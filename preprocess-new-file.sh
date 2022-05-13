#!/usr/bin/env bash

newdata=$1
outcsv=$2
dbuser=$3
ext=".csv"
outfile="$(basename $newdata $ext)-preprocessed.csv"
outfile_preprocessed="$(basename $newdata $ext)-preprocessed-no-floats.csv"

# Run python script to add migration attributes
./add-migration-attrs.py $newdata

echo "migration attributes added to ${outfile}"

# Remove all trailing '.0' that cause types to be misinterpreted
sed 's/\.0//g' $outfile > $outfile_preprocessed

echo "floating point digits removed (output to ${outfile_preprocessed})"

# Run clojure script to reformat data into correct shape to be accepted by db
java -cp read-csv/target/uberjar/reformat-csv.jar clojure.main -m \
    read-csv.core \
    $outfile_preprocessed \
    $outcsv

echo "file preprocessed"

# Copy resultant csv into database
psql -d pumsdb -U $dbuser -c \
    "\copy df1_original from '${outcsv}' delimiter ',' csv header;"

echo "copied ${outcsv} into database"
