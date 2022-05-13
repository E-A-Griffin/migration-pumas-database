#!/usr/bin/python3
# Taken from Yi Qiang's https://github.com/qiang-yi/PUMS_migration
import glob
import pandas as pd
import sys

N_CL_ARGS = 2


def eprint(*args, **kwargs):
    """
    Print to stderr
    """
    print(*args, file=sys.stderr, **kwargs)


def main(argv):
    if len(argv) != N_CL_ARGS:
        eprint(str(len(argv)) + " argument(s) provided but " + str(N_CL_ARGS) +
               " expected.")
        eprint("Usage: %s input-file.csv" % argv[0])
        return False

    table_path = "./"
    EXT = ".csv"
    in_file = argv[1]
    out_file = in_file.split(EXT)[0] + "-preprocessed" + EXT

    # These data are 2015-2019 5-year data downloaded from
    # https://www.census.gov/programs-surveys/acs/microdata/access.html
    f_ls = glob.glob(table_path+in_file)

    # test the list
    df_ls = []
    for f in f_ls:
        df_ls.append(pd.read_csv(f))

    df = pd.concat(df_ls)

    # Read the PUMA <-> MIGPUMA crosswalk table
    trans = pd.read_csv('supplementary-tables/puma_migpuma1_pwpuma00.csv')

    trans = trans.rename(columns={
        "Place of Work State (PWSTATE2) or Migration State (MIGPLAC1)":
        "MIGSP"})
    trans = trans.rename(columns={"PWPUMA00 or MIGPUMA1": "MIGPUMA"})
    trans = trans.rename(columns={"State of Residence (ST)": "ST"})

    trans['PUMA'] = trans['PUMA'].astype('int64').astype('str').str.rjust(5,
                                                                          "0")
    trans['ST'] = trans['ST'].astype('int16').astype('str').str.rjust(2, "0")
    trans['MIGSP'] = trans['MIGSP'].astype('int64').astype('str').str.rjust(
        2, "0")
    trans['MIGPUMA'] = trans['MIGPUMA'].astype(
        'int64').astype('str').str.rjust(5, "0")

    trans['PUMA2'] = trans['ST'] + trans['PUMA']
    trans['MIGPUMA2'] = trans['MIGSP'] + trans['MIGPUMA']

    # Remove records without migration data
    df1 = df.dropna(subset=['MIGPUMA'])

    # Format MIGPUMA codes
    df1.loc[:, 'MIGPUMA'] = df1['MIGPUMA'].astype(
        'int64').astype('str').str.rjust(5, "0")
    df1.loc[:, 'PUMA'] = df1['PUMA'].astype(
        'int64').astype('str').str.rjust(5, "0")
    df1.loc[:, 'MIGSP'] = df1['MIGSP'].astype(
        'int64').astype('str').str.rjust(2, "0")
    df1.loc[:, 'ST'] = df1['ST'].astype('int64').astype('str').str.rjust(2,
                                                                         "0")

    # Concatenate State and PUMA codes to unique codes for PUMA and MIGPUMA
    df1.loc[:, 'PUMA_D'] = df1['ST'] + df1['PUMA']
    df1.loc[:, 'MIGPUMA_O'] = df1['MIGSP'] + df1['MIGPUMA']

    # Merge PUMS data with the conversion table
    # Rename column names
    df1 = pd.merge(df1, trans, how='left', left_on='PUMA_D',
                   right_on='PUMA2').drop(
                       ['ST_y', 'PUMA_y', 'MIGSP_y', 'MIGPUMA_y', 'PUMA2'],
                       axis=1).rename(columns={"MIGPUMA2": "MIGPUMA_D"})

    # Export data to a csv file
    df1.to_csv(out_file)


# Allow file to be imported by other files without automatically triggering
# driver code with CL args
if __name__ == "__main__":
    main(sys.argv)
