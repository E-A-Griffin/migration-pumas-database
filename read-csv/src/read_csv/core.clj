(ns read-csv.core
  (:require [clojure.data.csv :as csv]
            [clojure.java.io  :as io]
            [clojure.edn      :as edn]
            [clojure.data     :as data]
            [clojure.set      :as set]))

;; Path to example 2020 CSV file
;;(def csv-path
;;  "resources/person-data-2020-preprocessed-no-floats.csv")

;; Path to data_mapping.edn
(def edn-path "data_mapping.edn")

(defn csv-data->maps [csv-data]
  (map zipmap
       (->> (first csv-data) ;; First row is the header
            (map keyword) ;; Drop if you want string keys instead
            repeat)
       (rest csv-data)))

(defn load-csv [csv-path]
  (with-open [reader (io/reader csv-path)]
    (csv-data->maps
     (doall
      (csv/read-csv reader)))))

(defn load-csv-header [csv-path]
  (with-open [reader (io/reader csv-path)]
    (first
      (csv/read-csv reader))))


;;(def csv-headers (load-csv-header csv-path))

;;(def csv-data (load-csv csv-path))

;; Source: https://clojuredocs.org/clojure.edn/read
(defn load-edn
  "Load edn from an io/reader source (filename or io/resource).
   Expects two data structures in edn file, the first being a vector and the
   second being a map"
  [source]
  (try
    (with-open [r (io/reader source)]
      [(edn/read (java.io.PushbackReader. r))
       (edn/read (java.io.PushbackReader. r))])

    (catch java.io.IOException e
      (printf "Couldn't open '%s': %s\n" source (.getMessage e)))
    (catch RuntimeException e
      (printf "Error parsing edn file '%s': %s\n" source (.getMessage e)))))

(defn unordered-diffs
  "Returns '(things-in-a-but-not-b things-in-b-but-not-a), ignores order."
  [a b]
  (take 2 (data/diff (set a) (set b))))

(defn schemas-match? [csv-m edn-m]
  (every? string? (map (fn [[k v]] (k edn-m)) csv-m)))

(def edn-data (load-edn edn-path))

(defn diffs-from-2015-2019-schema
  "Returns differences between 2015-2019 schema and the schema (keys) of csv-m.
   Returns nil if no differences exist."
  [csv-m]
  ;; There are exactly four discrepancies between the edn file containing
  ;; the 2015-2019 data mapping and a CSV file with the same schema:
  ;; row number (""), PUMA_D, MIGPUMA_O, and MIGPUMA_D
  (let [supplementary-data {(keyword "") "row_number"
                            :PUMA_D      "puma_d"
                            :MIGPUMA_O   "migpuma_o"
                            :MIGPUMA_D   "migpuma_d"}
        edn-m (set/rename-keys (second edn-data) {:ST      :ST_x
                                                  :MIGPUMA :MIGPUMA_x
                                                  :MIGSP   :MIGSP_x
                                                  :PUMA    :PUMA_x})
        complete-m (merge supplementary-data edn-m)]
    (prn (unordered-diffs (keys csv-m) (keys complete-m)))
    (unordered-diffs (keys csv-m) (keys complete-m))))

(defn get-indices-of-diffs
  "Returns [indices-of-columns-to-be-removed indices-of-columns-to-be-added]"
  [[in-new-not-old in-old-not-new]
   new-v old-v]
  (letfn [(map-indices [diffs v]
            (let [keywords-v (map keyword v)]
              (map #(.indexOf keywords-v %) diffs)))]
    [(map-indices in-new-not-old new-v)
     (map-indices in-old-not-new old-v)]))

(defn reformat-vec
  [[indices-to-be-removed indices-to-be-added] v]
  (let [indices-to-add-set    (set indices-to-be-added)
        indices-to-remove-set (set indices-to-be-removed)]
    ;;Add new indices first, then remove old indices after
    (flatten
     (filter not-empty
             (map-indexed (fn [idx itm] (if (indices-to-remove-set idx)
                                          []
                                          [itm]))
                          (flatten
                           (map-indexed (fn [idx itm]
                                          (if (indices-to-add-set idx)
                                            [itm ""]
                                            [itm]))
                                        v)))))))

(defn write-correct-schema-to-csv
  [in-csv-path
   [indices-of-columns-to-be-removed indices-of-columns-to-be-added]
   out-csv-path]
  (let [reshape-vec (partial reformat-vec [indices-of-columns-to-be-removed
                                           indices-of-columns-to-be-added])]
    (with-open [reader (io/reader in-csv-path)
                writer (io/writer out-csv-path)]
      (->> (csv/read-csv reader)
           (map reshape-vec)
           (csv/write-csv writer)))))

(defn -main
  "Expects (= args '(pgm-name path-to-input-csv path-to-output-csv)"
  [& args]
  (letfn [(prn-err [s] (.println *err* s))]
    (if (not= (count args) 2)
      (do
        (prn-err (str "Wrong number of arguments " (count args) " given:"))
        (prn-err "Usage: input-csv-path output-csv-path"))
      (let [[in-csv-path out-csv-path]       args
            csv-headers                      (load-csv-header in-csv-path)
            [csv-data-first & csv-data-rest] (load-csv in-csv-path)]
        (write-correct-schema-to-csv in-csv-path
                                     (get-indices-of-diffs
                                      (diffs-from-2015-2019-schema
                                       csv-data-first) csv-headers
                                      (first edn-data))
                                     out-csv-path)))))
;; 0,P,2020GQ0000084,6,1,01301,3,01,1006149,39,18,1,,1,2,2,2,2,2,,,2,,2,,,,0,1,2,2,2,2,2,2,0,,,,2,5,,,,,,3,4
;; ,RT,SERIALNO,DIVISION,SPORDER,PUMA_x,REGION,ST_x,ADJINC,PWGTP,AGEP,CIT,CITWP,COW,DDRS,DEAR,DEYE,DOUT,DPHY,DRAT,DRATX,DREM,ENG,FER,GCL,GCM,GCR,HIMRKS,HINS1,HINS2,HINS3,HINS4,HINS5,HINS6,HINS7,INTP,JWMNP,JWRIP,JWTRNS,LANX,MAR,MARHD,MARHM,MARHT,MARHW,MARHYP,MIG,MIL
;;  row_number | record_type | serial_no | division | person_number | puma | region | state | adjustment_factor | person_weight | age | citizenship_status | naturalization_year | worker_class | self_care_difficulty | hearing_difficulty | vision_difficulty | independent_living_difficulty | ambulatory_difficulty | vet_disability_rating | vet_disability | cognitive_difficulty | english_ability | gave_birth_last_year | grandparents_w_grandchildren | length_responsible_for_grandchildren | grandparents_responsible_for_grandchildren | insurance_through_employer | insurance_purchased_directly | medicare | medicaid_etc | tricare | va | ind_health_service | interest_div_rental_income_last_year | travel_time_to_work | vehicle_occupancy | means_of_transportation_to_work | language_other_than_english | marital_status | divorced_in_last_year | married_in_last_year | n_times_married | widowed_in_last_year | year_last_married | mobility_status | military_service
;;  served_after_09_2001 | served_from_08_1990_to_08_2001 | served_from_05_1975_to_07_1990 | served_from_08_1964_to_04_1975 | served_from_02_1955_to_07_1964 | served_from_07_1950_to_01_1955 | served_from_01_1947_to_06_1950 | served_from_12_1941_to_12_1946 | served_before_11_1941 | temp_absence_from_work | available_for_work | on_layoff | looking_for_work | informed_of_recall | other_income_last_year | public_assistance_income_last_year | relationship_to_ref_person | retirement_income_last_year | school_enrollment | grade_attending | educational_attainment | self_employed_income_last_year | sex | supp_security_income_last_year | social_security_income_last_year | salary_last_year | usual_work_hours | last_worked | weeks_worked_last_year | weeks_worked_2019_or_later | worked_last_week | year_of_entry | ancestry_recode | ancestry_recode_first_entry | ancestry_recode_second_entry | decade_of_entry | disability_recode | number_of_vehicles | parents_employment | employment_status_recode | recode_field_of_degree_first_entry | recode_field_of_degree_second_entry | health_insurance_recode | hispanic_origin_recode | industry_recode_for_2018_or_later | time_of_arrival_at_work | time_of_departure_for_work | language_other_than_english_code | migration_puma_2010_census | migration_recode | married_spouse_present | naics_recode_for_2018_or_later | nativity | nativity_parent | own_child | occcupation_recode_for_2018_or_later | presence_and_age_of_childen | total_persons_earnings | total_persons_income | place_of_birth | income_to_poverty_recode | place_of_work_puma | place_of_work_state_country | private_health_cov_recode | public_health_cov_recode | quarter_of_birth | recoded_race_code | recoded_race_code2 | recoded_race_code3 | native_american_recode | asian_recode | black_recode | native_hawaiian_recode | n_races_represented | pacific_islander_recode | other_races_recode | white_recode | related_child | field_of_degree_science_and_engineering | field_of_degree_science_and_engineering_related | subfamily_number | subfamily_relationship | soc_codes_for_2018_and_later | vet_period_of_service | world_area_of_birth | age_alloc_flag | ancestry_alloc_flag | citizenship_alloc_flag | year_of_naturalization_alloc_flag | class_of_worker_alloc_flag | self_care_alloc_flag | hearing_difficulty_alloc_flag | vision_difficulty_alloc_flag | disability_recode_alloc_flag | independent_living_difficulty_alloc_flag | ambulatory_difficulty_alloc_flag | disability_rating_percentage_alloc_flag | disability_rating_checkbox_alloc_flag | cognitive_difficulty_alloc_flag | ability_to_speak_english_alloc_flag | employment_status_recode_alloc_flag | gave_birth_last_year_alloc_flag | field_of_degree_alloc_flag | grandparents_living_w_grandchildren_alloc_flag | length_of_time_responsible_for_grandchildren_alloc_flag | grandparents_responsible_for_grandchildren_alloc_flag | insurance_recode_alloc_flag | insurance_through_employer_alloc_flag | insurance_direct_alloc_flag | medicare_coverage_given_through_eligibility_alloc_flag | medicare_65_or_older_certain_disabilities_alloc_flag | medicare_coverage_given_through_eligibility_alloc_flag2 | govt_assistance_alloc_flag | tricare_through_eligibility_alloc_flag | trcare_alloc_flag | va_alloc_flag | ind_health_service_alloc_flag | detailed_hispanic_origin_alloc_flag | industry_alloc_flag | interest_dividend_rental_income_alloc_flag | time_of_departure_to_work_alloc_flag | travel_time_to_work_alloc_flag | vehicle_occupancy_alloc_flag | means_of_transportation_alloc_flag | language_other_than_english_spoken_at_home_alloc_flag | language_other_than_english_alloc_flag | marital_status_alloc_flag | divorced_last_year_alloc_flag | married_last_year_alloc_flag | times_married_alloc_flag | widowed_last_year_alloc_flag | year_last_married_alloc_flag | mobility_status_alloc_flag | migration_state_alloc_flag | military_periods_of_service_alloc_flag | military_service_alloc_flag | occupation_alloc_flag | all_other_income_alloc_flag | public_assistance_income_alloc_flag | total_persons_earnings_alloc_flag | total_persons_income_alloc_flag | place_of_birth_alloc_flag | place_of_work_state_alloc_flag | private_health_insurance_coverage_recode_alloc_flag | public_health_coverage_recode_alloc_flag | detailed_race_alloc_flag | relationship_alloc_flag | retirement_income_alloc_flag | grade_attending_alloc_flag | highest_education_alloc_flag | school_enrollment_alloc_flag | self_employment_income_alloc_flag | sex_allocation_flag | supplementary_security_income_alloc_flag | social_security_income_alloc_flag | wages_and_salary_income_alloc_flag | usual_hours_worked_per_week_last_year_alloc_flag | last_worked_alloc_flag | weeks_worked_numeric_last_year_alloc_flag | weeks_worked_last_year_alloc_flag | worked_last_week_alloc_flag | year_of_entry_alloc_flag | person_weight_replicate_1 | person_weight_replicate_2 | person_weight_replicate_3 | person_weight_replicate_4 | person_weight_replicate_5 | person_weight_replicate_6 | person_weight_replicate_7 | person_weight_replicate_8 | person_weight_replicate_9 | person_weight_replicate_10 | person_weight_replicate_11 | person_weight_replicate_12 | person_weight_replicate_13 | person_weight_replicate_14 | person_weight_replicate_15 | person_weight_replicate_16 | person_weight_replicate_17 | person_weight_replicate_18 | person_weight_replicate_19 | person_weight_replicate_20 | person_weight_replicate_21 | person_weight_replicate_22 | person_weight_replicate_23 | person_weight_replicate_24 | person_weight_replicate_25 | person_weight_replicate_26 | person_weight_replicate_27 | person_weight_replicate_28 | person_weight_replicate_29 | person_weight_replicate_30 | person_weight_replicate_31 | person_weight_replicate_32 | person_weight_replicate_33 | person_weight_replicate_34 | person_weight_replicate_35 | person_weight_replicate_36 | person_weight_replicate_37 | person_weight_replicate_38 | person_weight_replicate_39 | person_weight_replicate_40 | person_weight_replicate_41 | person_weight_replicate_42 | person_weight_replicate_43 | person_weight_replicate_44 | person_weight_replicate_45 | person_weight_replicate_46 | person_weight_replicate_47 | person_weight_replicate_48 | person_weight_replicate_49 | person_weight_replicate_50 | person_weight_replicate_51 | person_weight_replicate_52 | person_weight_replicate_53 | person_weight_replicate_54 | person_weight_replicate_55 | person_weight_replicate_56 | person_weight_replicate_57 | person_weight_replicate_58 | person_weight_replicate_59 | person_weight_replicate_60 | person_weight_replicate_61 | person_weight_replicate_62 | person_weight_replicate_63 | person_weight_replicate_64 | person_weight_replicate_65 | person_weight_replicate_66 | person_weight_replicate_67 | person_weight_replicate_68 | person_weight_replicate_69 | person_weight_replicate_70 | person_weight_replicate_71 | person_weight_replicate_72 | person_weight_replicate_73 | person_weight_replicate_74 | person_weight_replicate_75 | person_weight_replicate_76 | person_weight_replicate_77 | person_weight_replicate_78 | person_weight_replicate_79 | person_weight_replicate_80 | puma_d | migpuma_o | migpuma_d

;; (with-open [writer (io/writer "out-file.csv")]
;;   (csv/write-csv writer
;;                  [["abc" "def"]
;;                   ["ghi" "jkl"]]))
