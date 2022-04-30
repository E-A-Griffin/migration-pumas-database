-- Two tables, one for households and one for individuals

-- Probably a good idea to just copy the data verbatim from csvs to two tables
-- then create views and/or stored procedures for extracting certain data

-- Make separate table for veteran information
-- Make separate table for race/ethnicity, linguistic information, potentially if not all queries
--  need this type of info
-- Make separate table for allocation flags
-- Have main table include basic geographic information plus year and simple info
--  about person like their age, weight, sex, etc. Maybe include basic racial information,
--  but maybe not if that's not relevant to most queries
-- Have separate table for a person's relationship info, like married/divorced/parent
-- Have separate table for occupational information
-- Have separate table for replicate weights
-- Have separate table for adjustment factors OR simply bake adjustment factors into
--  stored procedures and drop data from database altogether. This should be easy to
--  do but may discourage the ease of use for others in writing their own queries.
--
-- Refine idea of different tables based on what *most* important queries need. Clearly
-- this implies that geographic information should be in the main table

-- Mostly for debugging
--drop table if exists raw_data_persons;

create table raw_migration (
  year numeric(4),
  multyear numeric(4),
  sample numeric(6),
  serial numeric(8),
  cb_cerial varchar(13),
  house_weight numeric(10),
  cluster varchar(13),
  strata numeric(12),
  gq varchar(1),
  pernum numeric(4),
  person_weight numeric(10),
  migrate1 varchar(1),
  migrate1D varchar(2),
  migplace1 varchar(3),
  migcounty1 varchar(3)
);

-- Copy concatenated persons csv into raw_data_persons
-- Need to use absolute path to csv unfortunately
\copy raw_migration from '/home/emma/Desktop/Courses/Grad/COP6712/project4/usa_00001.csv' with delimiter ',' csv header

-- Raw data table, delete as soon as all relevant information is extracted and
-- transferred to smaller, separate tables that use foreign keys to reference each
-- other
create table raw_data_persons (
  record_type varchar(1),
  serial_no varchar(13),
  division varchar(1),
  person_number numeric(2),
  puma varchar(5),
  region varchar(1),
  state varchar(2),
  adjustment_factor varchar(7),
  person_weight numeric(5),
  age numeric(2),
  citizenship_status varchar(1),
  naturalization_year numeric(4),
  worker_class varchar(1),
  self_care_difficulty varchar(1),
  hearing_difficulty varchar(1),
  vision_difficulty varchar(1),
  independent_living_difficulty varchar(1),
  ambulatory_difficulty varchar(1),
  vet_disability_rating varchar(1),
  vet_disability varchar(1),
  cognitive_difficulty varchar(1),
  english_ability varchar(1),
  gave_birth_last_year varchar(1),
  grandparents_w_grandchildren varchar(1),
  length_responsible_for_grandchildren varchar(1),
  grandparents_responsible_for_grandchildren varchar(1),
  insurance_through_employer varchar(1),
  insurance_purchased_directly varchar(1),
  medicare varchar(1),
  medicaid_etc varchar(1),
  tricare varchar(1),
  va varchar(1),
  ind_health_service varchar(1),
  interest_div_rental_income_last_year numeric(6),
  travel_time_to_work numeric(3),
  vehicle_occupancy numeric(2),
  means_of_transportation_to_work varchar(2),
  language_other_than_english varchar(1),
  marital_status varchar(1),
  divorced_in_last_year varchar(1),
  married_in_last_year varchar(1),
  n_times_married varchar(1),
  widowed_in_last_year varchar(1),
  year_last_married numeric(4),
  mobility_status varchar(1),
  military_service varchar(1),
  served_after_09_2001 boolean,
  served_from_08_1990_to_08_2001 boolean,
  served_from_05_1975_to_07_1990 boolean,
  served_from_08_1964_to_04_1975 boolean,
  served_from_02_1955_to_07_1964 boolean,
  served_from_07_1950_to_01_1955 boolean,
  served_from_01_1947_to_06_1950 boolean,
  served_from_12_1941_to_12_1946 boolean,
  served_before_11_1941 boolean,
  temp_absence_from_work varchar(1),
  available_for_work varchar(1),
  on_layoff varchar(1),
  looking_for_work varchar(1),
  informed_of_recall varchar(1),
  other_income_last_year numeric(6),
  public_assistance_income_last_year numeric(5),
  relationship_to_ref_person varchar(2),
  retirement_income_last_year numeric(6),
  school_enrollment varchar(1),
  grade_attending varchar(2),
  educational_attainment varchar(2),
  self_employed_income_last_year numeric(6),
  sex varchar(1),
  supp_security_income_last_year numeric(5),
  social_security_income_last_year numeric(5),
  salary_last_year numeric(6),
  usual_work_hours numeric(2),
  last_worked varchar(1),
  weeks_worked_last_year varchar(1),
  weeks_worked_2019_or_later numeric(2),
  worked_last_week varchar(1),
  year_of_entry numeric(4),
  ancestry_recode varchar(1),
  ancestry_recode_first_entry varchar(3),
  ancestry_recode_second_entry varchar(3),
  decade_of_entry varchar(1),
  disability_recode varchar(1),
  number_of_vehicles varchar(1),
  parents_employment varchar(1),
  employment_status_recode varchar(1),
  recode_field_of_degree_first_entry varchar(4),
  recode_field_of_degree_second_entry varchar(4),
  health_insurance_recode varchar(1),
  hispanic_origin_recode varchar(2),
  industry_recode_for_2018_or_later varchar(4),
  time_of_arrival_at_work varchar(3),
  time_of_departure_for_work varchar(3),
  language_other_than_english_code varchar(4),
  migration_puma_2010_census varchar(5),
  migration_recode varchar(3),
  married_spouse_present varchar(1),
  NAICS_recode_for_2018_or_later varchar(8),
  nativity varchar(1),
  nativity_parent varchar(1),
  own_child varchar(1),
  occcupation_recode_for_2018_or_later varchar(4),
  presence_and_age_of_childen varchar(1),
  total_persons_earnings numeric(7),
  total_persons_income numeric(7),
  place_of_birth varchar(3),
  income_to_poverty_recode numeric(3),
  place_of_work_PUMA varchar(5),
  place_of_work_state_country varchar(3),
  private_health_cov_recode varchar(1),
  public_health_cov_recode varchar(1),
  quarter_of_birth varchar(1),
  recoded_race_code varchar(1),
  recoded_race_code2 varchar(2),
  recoded_race_code3 varchar(3),
  native_american_recode boolean,
  asian_recode boolean,
  black_recode boolean,
  native_hawaiian_recode boolean,
  n_races_represented varchar(1),
  pacific_islander_recode boolean,
  other_races_recode boolean,
  white_recode boolean,
  related_child boolean,
  field_of_degree_science_and_engineering varchar(1),
  field_of_degree_science_and_engineering_related varchar(1),
  subfamily_number varchar(1),
  subfamily_relationship varchar(1),
  SOC_codes_for_2018_and_later varchar(6),
  vet_period_of_service varchar(2),
  world_area_of_birth varchar(1),
  age_alloc_flag boolean,
  ancestry_alloc_flag boolean,
  citizenship_alloc_flag boolean,
  year_of_naturalization_alloc_flag boolean,
  class_of_worker_alloc_flag boolean,
  self_care_alloc_flag boolean,
  hearing_difficulty_alloc_flag boolean,
  vision_difficulty_alloc_flag boolean,
  disability_recode_alloc_flag boolean,
  independent_living_difficulty_alloc_flag boolean,
  ambulatory_difficulty_alloc_flag boolean,
  disability_rating_percentage_alloc_flag boolean,
  disability_rating_checkbox_alloc_flag boolean,
  cognitive_difficulty_alloc_flag boolean,
  ability_to_speak_english_alloc_flag boolean,
  employment_status_recode_alloc_flag boolean,
  gave_birth_last_year_alloc_flag boolean,
  field_of_degree_alloc_flag boolean,
  grandparents_living_w_grandchildren_alloc_flag boolean,
  length_of_time_responsible_for_grandchildren_alloc_flag boolean,
  grandparents_responsible_for_grandchildren_alloc_flag boolean,
  insurance_recode_alloc_flag boolean,
  insurance_through_employer_alloc_flag boolean,
  insurance_direct_alloc_flag boolean,
  medicare_coverage_given_through_eligibility_alloc_flag boolean,
  medicare_65_or_older_certain_disabilities_alloc_flag boolean,
  medicare_coverage_given_through_eligibility_alloc_flag2 boolean,
  govt_assistance_alloc_flag boolean,
  tricare_through_eligibility_alloc_flag boolean,
  trcare_alloc_flag boolean,
  va_alloc_flag boolean,
  ind_health_service_alloc_flag boolean,
  detailed_hispanic_origin_alloc_flag boolean,
  industry_alloc_flag boolean,
  interest_dividend_rental_income_alloc_flag boolean,
  time_of_departure_to_work_alloc_flag boolean,
  travel_time_to_work_alloc_flag boolean,
  vehicle_occupancy_alloc_flag boolean,
  means_of_transportation_alloc_flag boolean,
  language_other_than_english_spoken_at_home_alloc_flag boolean,
  language_other_than_english_alloc_flag boolean,
  marital_status_alloc_flag boolean,
  divorced_last_year_alloc_flag boolean,
  married_last_year_alloc_flag boolean,
  times_married_alloc_flag boolean,
  widowed_last_year_alloc_flag boolean,
  year_last_married_alloc_flag boolean,
  mobility_status_alloc_flag boolean,
  migration_state_alloc_flag boolean,
  military_periods_of_service_alloc_flag boolean,
  military_service_alloc_flag boolean,
  occupation_alloc_flag boolean,
  all_other_income_alloc_flag boolean,
  public_assistance_income_alloc_flag boolean,
  total_persons_earnings_alloc_flag boolean,
  total_persons_income_alloc_flag boolean,
  place_of_birth_alloc_flag boolean,
  place_of_work_state_alloc_flag boolean,
  private_health_insurance_coverage_recode_alloc_flag boolean,
  public_health_coverage_recode_alloc_flag boolean,
  detailed_race_alloc_flag boolean,
  relationship_alloc_flag boolean,
  retirement_income_alloc_flag boolean,
  grade_attending_alloc_flag boolean,
  highest_education_alloc_flag boolean,
  school_enrollment_alloc_flag boolean,
  self_employment_income_alloc_flag boolean,
  sex_allocation_flag boolean,
  supplementary_security_income_alloc_flag boolean,
  social_security_income_alloc_flag boolean,
  wages_and_salary_income_alloc_flag boolean,
  usual_hours_worked_per_week_last_year_alloc_flag boolean,
  last_worked_alloc_flag boolean,
  weeks_worked_numeric_last_year_alloc_flag boolean,
  weeks_worked_last_year_alloc_flag boolean,
  worked_last_week_alloc_flag boolean,
  year_of_entry_alloc_flag boolean,
  person_weight_replicate_1 numeric(5),
  person_weight_replicate_2 numeric(5),
  person_weight_replicate_3 numeric(5),
  person_weight_replicate_4 numeric(5),
  person_weight_replicate_5 numeric(5),
  person_weight_replicate_6 numeric(5),
  person_weight_replicate_7 numeric(5),
  person_weight_replicate_8 numeric(5),
  person_weight_replicate_9 numeric(5),
  person_weight_replicate_10 numeric(5),
  person_weight_replicate_11 numeric(5),
  person_weight_replicate_12 numeric(5),
  person_weight_replicate_13 numeric(5),
  person_weight_replicate_14 numeric(5),
  person_weight_replicate_15 numeric(5),
  person_weight_replicate_16 numeric(5),
  person_weight_replicate_17 numeric(5),
  person_weight_replicate_18 numeric(5),
  person_weight_replicate_19 numeric(5),
  person_weight_replicate_20 numeric(5),
  person_weight_replicate_21 numeric(5),
  person_weight_replicate_22 numeric(5),
  person_weight_replicate_23 numeric(5),
  person_weight_replicate_24 numeric(5),
  person_weight_replicate_25 numeric(5),
  person_weight_replicate_26 numeric(5),
  person_weight_replicate_27 numeric(5),
  person_weight_replicate_28 numeric(5),
  person_weight_replicate_29 numeric(5),
  person_weight_replicate_30 numeric(5),
  person_weight_replicate_31 numeric(5),
  person_weight_replicate_32 numeric(5),
  person_weight_replicate_33 numeric(5),
  person_weight_replicate_34 numeric(5),
  person_weight_replicate_35 numeric(5),
  person_weight_replicate_36 numeric(5),
  person_weight_replicate_37 numeric(5),
  person_weight_replicate_38 numeric(5),
  person_weight_replicate_39 numeric(5),
  person_weight_replicate_40 numeric(5),
  person_weight_replicate_41 numeric(5),
  person_weight_replicate_42 numeric(5),
  person_weight_replicate_43 numeric(5),
  person_weight_replicate_44 numeric(5),
  person_weight_replicate_45 numeric(5),
  person_weight_replicate_46 numeric(5),
  person_weight_replicate_47 numeric(5),
  person_weight_replicate_48 numeric(5),
  person_weight_replicate_49 numeric(5),
  person_weight_replicate_50 numeric(5),
  person_weight_replicate_51 numeric(5),
  person_weight_replicate_52 numeric(5),
  person_weight_replicate_53 numeric(5),
  person_weight_replicate_54 numeric(5),
  person_weight_replicate_55 numeric(5),
  person_weight_replicate_56 numeric(5),
  person_weight_replicate_57 numeric(5),
  person_weight_replicate_58 numeric(5),
  person_weight_replicate_59 numeric(5),
  person_weight_replicate_60 numeric(5),
  person_weight_replicate_61 numeric(5),
  person_weight_replicate_62 numeric(5),
  person_weight_replicate_63 numeric(5),
  person_weight_replicate_64 numeric(5),
  person_weight_replicate_65 numeric(5),
  person_weight_replicate_66 numeric(5),
  person_weight_replicate_67 numeric(5),
  person_weight_replicate_68 numeric(5),
  person_weight_replicate_69 numeric(5),
  person_weight_replicate_70 numeric(5),
  person_weight_replicate_71 numeric(5),
  person_weight_replicate_72 numeric(5),
  person_weight_replicate_73 numeric(5),
  person_weight_replicate_74 numeric(5),
  person_weight_replicate_75 numeric(5),
  person_weight_replicate_76 numeric(5),
  person_weight_replicate_77 numeric(5),
  person_weight_replicate_78 numeric(5),
  person_weight_replicate_79 numeric(5),
  person_weight_replicate_80 numeric(5)
);

-- Copy concatenated persons csv into raw_data_persons
copy raw_data_persons
-- Need to use absolute path to csv unfortunately
from '/home/emma/Desktop/Courses/Grad/COP6712/project4/person-data.csv'
delimiter ','
csv header;

-- Weight Replicates
create table weight_replicates (
  serial_no varchar(13),
  person_number numeric(2),
  person_weight_replicate_1 numeric(5),
  person_weight_replicate_2 numeric(5),
  person_weight_replicate_3 numeric(5),
  person_weight_replicate_4 numeric(5),
  person_weight_replicate_5 numeric(5),
  person_weight_replicate_6 numeric(5),
  person_weight_replicate_7 numeric(5),
  person_weight_replicate_8 numeric(5),
  person_weight_replicate_9 numeric(5),
  person_weight_replicate_10 numeric(5),
  person_weight_replicate_11 numeric(5),
  person_weight_replicate_12 numeric(5),
  person_weight_replicate_13 numeric(5),
  person_weight_replicate_14 numeric(5),
  person_weight_replicate_15 numeric(5),
  person_weight_replicate_16 numeric(5),
  person_weight_replicate_17 numeric(5),
  person_weight_replicate_18 numeric(5),
  person_weight_replicate_19 numeric(5),
  person_weight_replicate_20 numeric(5),
  person_weight_replicate_21 numeric(5),
  person_weight_replicate_22 numeric(5),
  person_weight_replicate_23 numeric(5),
  person_weight_replicate_24 numeric(5),
  person_weight_replicate_25 numeric(5),
  person_weight_replicate_26 numeric(5),
  person_weight_replicate_27 numeric(5),
  person_weight_replicate_28 numeric(5),
  person_weight_replicate_29 numeric(5),
  person_weight_replicate_30 numeric(5),
  person_weight_replicate_31 numeric(5),
  person_weight_replicate_32 numeric(5),
  person_weight_replicate_33 numeric(5),
  person_weight_replicate_34 numeric(5),
  person_weight_replicate_35 numeric(5),
  person_weight_replicate_36 numeric(5),
  person_weight_replicate_37 numeric(5),
  person_weight_replicate_38 numeric(5),
  person_weight_replicate_39 numeric(5),
  person_weight_replicate_40 numeric(5),
  person_weight_replicate_41 numeric(5),
  person_weight_replicate_42 numeric(5),
  person_weight_replicate_43 numeric(5),
  person_weight_replicate_44 numeric(5),
  person_weight_replicate_45 numeric(5),
  person_weight_replicate_46 numeric(5),
  person_weight_replicate_47 numeric(5),
  person_weight_replicate_48 numeric(5),
  person_weight_replicate_49 numeric(5),
  person_weight_replicate_50 numeric(5),
  person_weight_replicate_51 numeric(5),
  person_weight_replicate_52 numeric(5),
  person_weight_replicate_53 numeric(5),
  person_weight_replicate_54 numeric(5),
  person_weight_replicate_55 numeric(5),
  person_weight_replicate_56 numeric(5),
  person_weight_replicate_57 numeric(5),
  person_weight_replicate_58 numeric(5),
  person_weight_replicate_59 numeric(5),
  person_weight_replicate_60 numeric(5),
  person_weight_replicate_61 numeric(5),
  person_weight_replicate_62 numeric(5),
  person_weight_replicate_63 numeric(5),
  person_weight_replicate_64 numeric(5),
  person_weight_replicate_65 numeric(5),
  person_weight_replicate_66 numeric(5),
  person_weight_replicate_67 numeric(5),
  person_weight_replicate_68 numeric(5),
  person_weight_replicate_69 numeric(5),
  person_weight_replicate_70 numeric(5),
  person_weight_replicate_71 numeric(5),
  person_weight_replicate_72 numeric(5),
  person_weight_replicate_73 numeric(5),
  person_weight_replicate_74 numeric(5),
  person_weight_replicate_75 numeric(5),
  person_weight_replicate_76 numeric(5),
  person_weight_replicate_77 numeric(5),
  person_weight_replicate_78 numeric(5),
  person_weight_replicate_79 numeric(5),
  person_weight_replicate_80 numeric(5),
  primary key(serial_no, person_number)
);

-- Allocation flags
create table allocation_flags (
  serial_no varchar(13),
  person_number numeric(2),
  age_alloc_flag boolean,
  ancestry_alloc_flag boolean,
  citizenship_alloc_flag boolean,
  year_of_naturalization_alloc_flag boolean,
  class_of_worker_alloc_flag boolean,
  self_care_alloc_flag boolean,
  hearing_difficulty_alloc_flag boolean,
  vision_difficulty_alloc_flag boolean,
  disability_recode_alloc_flag boolean,
  independent_living_difficulty_alloc_flag boolean,
  ambulatory_difficulty_alloc_flag boolean,
  disability_rating_percentage_alloc_flag boolean,
  disability_rating_checkbox_alloc_flag boolean,
  cognitive_difficulty_alloc_flag boolean,
  ability_to_speak_english_alloc_flag boolean,
  employment_status_recode_alloc_flag boolean,
  gave_birth_last_year_alloc_flag boolean,
  field_of_degree_alloc_flag boolean,
  grandparents_living_w_grandchildren_alloc_flag boolean,
  length_of_time_responsible_for_grandchildren_alloc_flag boolean,
  grandparents_responsible_for_grandchildren_alloc_flag boolean,
  insurance_recode_alloc_flag boolean,
  insurance_through_employer_alloc_flag boolean,
  insurance_direct_alloc_flag boolean,
  medicare_coverage_given_through_eligibility_alloc_flag boolean,
  medicare_65_or_older_certain_disabilities_alloc_flag boolean,
  medicare_coverage_given_through_eligibility_alloc_flag2 boolean,
  govt_assistance_alloc_flag boolean,
  tricare_through_eligibility_alloc_flag boolean,
  trcare_alloc_flag boolean,
  va_alloc_flag boolean,
  ind_health_service_alloc_flag boolean,
  detailed_hispanic_origin_alloc_flag boolean,
  industry_alloc_flag boolean,
  interest_dividend_rental_income_alloc_flag boolean,
  time_of_departure_to_work_alloc_flag boolean,
  travel_time_to_work_alloc_flag boolean,
  vehicle_occupancy_alloc_flag boolean,
  means_of_transportation_alloc_flag boolean,
  language_other_than_english_spoken_at_home_alloc_flag boolean,
  language_other_than_english_alloc_flag boolean,
  marital_status_alloc_flag boolean,
  divorced_last_year_alloc_flag boolean,
  married_last_year_alloc_flag boolean,
  times_married_alloc_flag boolean,
  widowed_last_year_alloc_flag boolean,
  year_last_married_alloc_flag boolean,
  mobility_status_alloc_flag boolean,
  migration_state_alloc_flag boolean,
  military_periods_of_service_alloc_flag boolean,
  military_service_alloc_flag boolean,
  occupation_alloc_flag boolean,
  all_other_income_alloc_flag boolean,
  public_assistance_income_alloc_flag boolean,
  total_persons_earnings_alloc_flag boolean,
  total_persons_income_alloc_flag boolean,
  place_of_birth_alloc_flag boolean,
  place_of_work_state_alloc_flag boolean,
  private_health_insurance_coverage_recode_alloc_flag boolean,
  public_health_coverage_recode_alloc_flag boolean,
  detailed_race_alloc_flag boolean,
  relationship_alloc_flag boolean,
  retirement_income_alloc_flag boolean,
  grade_attending_alloc_flag boolean,
  highest_education_alloc_flag boolean,
  school_enrollment_alloc_flag boolean,
  self_employment_income_alloc_flag boolean,
  sex_allocation_flag boolean,
  supplementary_security_income_alloc_flag boolean,
  social_security_income_alloc_flag boolean,
  wages_and_salary_income_alloc_flag boolean,
  usual_hours_worked_per_week_last_year_alloc_flag boolean,
  last_worked_alloc_flag boolean,
  weeks_worked_numeric_last_year_alloc_flag boolean,
  weeks_worked_last_year_alloc_flag boolean,
  worked_last_week_alloc_flag boolean,
  year_of_entry_alloc_flag boolean,
  primary key(serial_no, person_number)
);

-- veteran status/information
create table vet_info (
  serial_no varchar(13),
  person_number numeric(2),
  military_service varchar(1),
  served_after_09_2001 boolean,
  served_from_08_1990_to_08_2001 boolean,
  served_from_05_1975_to_07_1990 boolean,
  served_from_08_1964_to_04_1975 boolean,
  served_from_02_1955_to_07_1964 boolean,
  served_from_07_1950_to_01_1955 boolean,
  served_from_01_1947_to_06_1950 boolean,
  served_from_12_1941_to_12_1946 boolean,
  served_before_11_1941 boolean,
  primary key(serial_no, person_number)
);

-- healthcare/disability information
create table health_info (
  serial_no varchar(13),
  person_number numeric(2),
  self_care_difficulty varchar(1),
  hearing_difficulty varchar(1),
  vision_difficulty varchar(1),
  independent_living_difficulty varchar(1),
  ambulatory_difficulty varchar(1),
  vet_disability_rating varchar(1),
  vet_disability varchar(1),
  cognitive_difficulty varchar(1),
  primary key(serial_no, person_number)
);

create table adjustment_factors {
  year int primary key,

  /* Adjustment factor for housing dollar amounts
     1.079106 2015 factor
     1.065365 2016 factor
     1.042936 2017 factor
     1.018118 2018 factor
     1.000000 2019 factor */
  housing_adjustment_factor numeric(7,6),

  /* Adjustment factor for income and earnings dollar amounts
     1.080470 .2015 factor (1.001264 * 1.07910576)
     1.073449 .2016 factor (1.007588 * 1.06536503)
     1.054606 .2017 factor (1.011189 * 1.04293629)
     1.031452 .2018 factor (1.013097 * 1.01811790)
     1.010145 .2019 factor (1.010145 * 1.00000000) */
  income_adjustment_factor numeric(7,6)
}

-- Contains the 80 replicate weights for each entry in households_2015_to_2019
create table housing_record_replicate_weights {

}

create table households_2015_to_2019 {

  year int,
  -- Housing unit/GQ person serial number
  -- 2015000000001..2017999999999 .Unique identifier (2017 and earlier)
  -- 2018GQ0000001..2019GQ9999999 .GQ Unique identifier (2018 and later)
  -- 2018GQ0000001..2019HU9999999 .HU Unique identifier (2018 and later)
  serial_no varchar(13) primary key,

  /*
  Division code based on 2010 Census definitions
  0 .Puerto Rico
  1 .New England (Northeast region)
  2 .Middle Atlantic (Northeast region)
  3 .East North Central (Midwest region)
  4 .West North Central (Midwest region)
  5 .South Atlantic (South region)
  6 .East South Central (South region)
  7 .West South Central (South Region)
  8 .Mountain (West region)
  9 .Pacific (West region)
  */
  division int,

  /* Public use microdata area code (PUMA) based on 2010 Census definition
     (areas with population of 100,000 or more, use with ST for unique code)
     00100..70301 .Public use microdata area codes */
  PUMA int,

  /* Region code based on 2010 Census definitions
     1 .Northeast
     2 .Midwest
     3 .South
     4 .West
     9 .Puerto Rico */
  region int,

  /* Two character state code */
  state varchar(2),

  /* Housing Unit Weight
     0 .Group Quarter placeholder record
     1..9999 .Integer weight of housing unit */
  housing_unit_weight int,

  /* Number of persons associated with the housing record
     0 .Vacant unit
     1 .One person record (one person in household or any person
       .in group quarters)
     2..20  .Number of person records (number of persons in household)
  */
  num_persons int,

  /* Type of unit
    H .Housing unit
    I .Institutional group quarters
    N .Noninstitutional group quarters
  */
  type varchar(1)
  }

create table housing_unit_variables {
  /* Access to the Internet
    NA .N/A (GQ/vacant)
    YP .Yes, by paying a cell phone company or Internet service
      .provider
    YN .Yes, without paying a cell phone company or Internet service
      .provider
    NN .No access to the Internet at this house, apartment, or mobile
      .home
  */
  int_access varchar(2),

  /* Lot size
     N .N/A (GQ/not a one-family house or mobile home)
     S .House on less than one acre
     M .House on one to less than ten acres
     L .House on ten or more acres
  */
  lot_size varchar(1),

  /* Sales of agriculture products (yearly sales, no adjustment factor is
     applied)
     NA   .N/A (GQ/vacant/not a one-family house or mobile home/less than
          .1 acre)
     0k   .None
     1k   .$    1 - $  999
     2.5k .$ 1000 - $ 2499
     5k   .$ 2500 - $ 4999
     10k  .$ 5000 - $ 9999
     >10k .$10000+
     */
  aggriculture_sales varchar(4),

  /* Bathtub or shower
     NULL .N/A (GQ)
     true .Yes
     false .No */
  bath boolean,

  /* Number of bedrooms
     NULL .N/A (GQ)
     0..99 .0 to 99 bedrooms (Top-coded)
  */
  num_bedrooms numeric(2),

  /* Units in structure
     NULL .N/A (GQ)
     01 .Mobile home or trailer
     02 .One-family house detached
     03 .One-family house attached
     04 .2 Apartments
     05 .3-4 Apartments
     06 .5-9 Apartments
     07 .10-19 Apartments
     08 .20-49 Apartments
     09 .50 or more apartments
     10 .Boat, RV, van, etc.*/
  units_in_structure numeric(2),

}

create table individuals_2015_to_2019 {
  year int,
  -- Housing unit/GQ person serial number
  -- 2015000000001..2017999999999 .Unique identifier (2017 and earlier)
  -- 2018GQ0000001..2019GQ9999999 .GQ Unique identifier (2018 and later)
  -- 2018GQ0000001..2019HU9999999 .HU Unique identifier (2018 and later)
  serial_no varchar(13) primary key,

  /*
  Division code based on 2010 Census definitions
  0 .Puerto Rico
  1 .New England (Northeast region)
  2 .Middle Atlantic (Northeast region)
  3 .East North Central (Midwest region)
  4 .West North Central (Midwest region)
  5 .South Atlantic (South region)
  6 .East South Central (South region)
  7 .West South Central (South Region)
  8 .Mountain (West region)
  9 .Pacific (West region)
  */
  division int,

  -- I think this is respective to household, e.g. a number 03 would indicate
  -- a person is the 3rd member of their household
  /* Person number
    01..20 .Person number
  */
  person_number numeric(2),

  /* Public use microdata area code (PUMA) based on 2010 Census definition
     (areas with population of 100,000 or more, use with ST for unique code)
     00100..70301 .Public use microdata area codes */
  PUMA numeric(5),

  /* Region code based on 2010 Census definitions
     1 .Northeast
     2 .Midwest
     3 .South
     4 .West
     9 .Puerto Rico */
  region numeric(1),

  /* Two character state code */
  state varchar(2),

  /* Integer weight of person
     1..9999 .Integer weight of person
  */
  weight numeric(5),

  /* Age
     0    .Under 1 year
     1.99 .1 to 99 years (Top-coded)
  */
  age numeric(2),

  /* Year of naturalization write-in
    NULL .Not eligible - not naturalized
    1944 .1944 or earlier (Bottom-coded)
    1945 .1945 - 1947
    1948 .1948 - 1949
    1950 .1950
    1951 .1951
    1952 .1952
    1953 .1953
    1954 .1954
    1955 .1955
    1956 .1956
    1957 .1957
    1958 .1958
    1959 .1959
    1960 .1960
    1961 .1961
    1962 .1962
    1963 .1963
    1964 .1964
    1965 .1965
    1966 .1966
    1967 .1967
    1968 .1968
    1969 .1969
    1970 .1970
    1971 .1971
    1972 .1972
    1973 .1973
    1974 .1974
    1975 .1975
    1976 .1976
    1977 .1977
    1978 .1978
    1979 .1979
    1980 .1980
    1981 .1981
    1982 .1982
    1983 .1983
    1984 .1984
    1985 .1985
    1986 .1986
    1987 .1987
    1988 .1988
    1989 .1989
    1990 .1990
    1991 .1991
    1992 .1992
    1993 .1993
    1994 .1994
    1995 .1995
    1996 .1996
    1997 .1997
    1998 .1998
    1999 .1999
    2000 .2000
    2001 .2001
    2002 .2002
    2003 .2003
    2004 .2004
    2005 .2005
    2006 .2006
    2007 .2007
    2008 .2008
    2009 .2009
    2010 .2010
    2011 .2011
    2012 .2012
    2013 .2013
    2014 .2014
    2015 .2015
    2016 .2016
    2017 .2017
    2018 .2018
    2019 .2019
  */
  naturalization_yr int,

  /* Class of worker
  b .Not in universe (less than 16 years old/NILF who last worked
    .more than 5 years ago or never worked)
  1 .Employee of a private for-profit company or business, or of an
    .individual, for wages, salary, or commissions
  2 .Employee of a private not-for-profit, tax-exempt, or
    .charitable organization
  3 .Local government employee (city, county, etc.)
  4 .State government employee
  5 .Federal government employee
  6 .Self-employed in own not incorporated business, professional
    .practice, or farm
  7 .Self-employed in own incorporated business, professional
    .practice or farm
  8 .Working without pay in family business or farm
  9 .Unemployed and last worked 5 years ago or earlier or never
    .worked
  */
  worker_class numeric(1),


};
