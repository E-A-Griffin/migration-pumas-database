-- Mostly for debugging
--drop table if exists raw_data_persons;

-- build sequnce
-- currently not used
CREATE SEQUENCE unique_id_seq
  START WITH 1
  INCREMENT BY 1
  MINVALUE 1
  NO MAXVALUE
  CACHE 1;

-- Table for reading in raw data
create table df1_original (
  row_number int,
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
  -- Cast all booleans as nullable
  self_care_difficulty varchar(1), -- boolean 1 => true; 2 => false; null => null
  hearing_difficulty varchar(1),   -- boolean
  vision_difficulty varchar(1),    -- boolean
  independent_living_difficulty varchar(1), -- boolean
  ambulatory_difficulty varchar(1), -- boolean
  vet_disability_rating varchar(1),
  vet_disability varchar(1), -- boolean
  cognitive_difficulty varchar(1), -- boolean
  english_ability varchar(1),
  gave_birth_last_year varchar(1),
  grandparents_w_grandchildren varchar(1), -- boolean
  length_responsible_for_grandchildren varchar(1),
  grandparents_responsible_for_grandchildren varchar(1),
  insurance_through_employer varchar(1), -- boolean
  insurance_purchased_directly varchar(1), -- boolean
  medicare varchar(1), -- boolean
  medicaid_etc varchar(1), -- boolean
  tricare varchar(1), -- boolean
  va varchar(1), -- boolean
  ind_health_service varchar(1), -- boolean
  interest_div_rental_income_last_year numeric(6),
  travel_time_to_work numeric(3),
  vehicle_occupancy numeric(2),
  means_of_transportation_to_work varchar(2),
  language_other_than_english varchar(1), -- boolean
  marital_status varchar(1),
  divorced_in_last_year varchar(1),
  married_in_last_year varchar(1), -- boolean
  n_times_married varchar(1),
  widowed_in_last_year varchar(1), -- boolean
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
  sex varchar(1), -- boolean
  supp_security_income_last_year numeric(5),
  social_security_income_last_year numeric(5),
  salary_last_year numeric(6),
  usual_work_hours numeric(2),
  last_worked varchar(1),
  weeks_worked_last_year varchar(1),
  weeks_worked_2019_or_later numeric(2),
  worked_last_week varchar(1), -- boolean
  year_of_entry numeric(4),
  ancestry_recode varchar(1),
  ancestry_recode_first_entry varchar(3),
  ancestry_recode_second_entry varchar(3),
  decade_of_entry varchar(1),
  disability_recode varchar(1), -- boolean
  number_of_vehicles varchar(1),
  parents_employment varchar(1),
  employment_status_recode varchar(1),
  recode_field_of_degree_first_entry varchar(4),
  recode_field_of_degree_second_entry varchar(4),
  health_insurance_recode varchar(1), -- boolean
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
  own_child varchar(1), -- boolean
  occcupation_recode_for_2018_or_later varchar(4),
  presence_and_age_of_childen varchar(1),
  total_persons_earnings numeric(7),
  total_persons_income numeric(7),
  place_of_birth varchar(3),
  income_to_poverty_recode numeric(3),
  place_of_work_PUMA varchar(5),
  place_of_work_state_country varchar(3),
  private_health_cov_recode varchar(1), -- boolean
  public_health_cov_recode varchar(1), -- boolean
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
  field_of_degree_science_and_engineering varchar(1), -- boolean
  field_of_degree_science_and_engineering_related varchar(1), -- boolean
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
  person_weight_replicate_80 numeric(5),
  puma_d varchar(8),
  migpuma_o varchar(8),
  migpuma_d varchar(8)
);

copy df1_original
from '/home/emma/Desktop/Courses/Grad/COP6712/project4/df1_no_floats.csv'
delimiter ','
header csv;

copy df1_original
from '/home/emma/Desktop/Courses/Grad/COP6712/project4/puerto-rico/puerto-rico-preprocessed-no-floats.csv'
delimiter ','
header csv;

-- INTERMEDIATE TABLES

--migpuma_cw.csv

create table migpuma_cw (
    rowId NUMERIC,
    MigPUMA2 NUMERIC,
    MigPUMA10_Pop10 NUMERIC,

    PRIMARY KEY(rowId)
);

copy migpuma_cw
from '/home/emma/Desktop/Courses/Grad/COP6712/project4/migpuma_cw_no_commas.csv'
delimiter ','
header csv;

--out_move.csv
create table out_move (
    rowId integer,
    MigPUMA_O integer,
    MigPUMA_D integer,
    person integer,
    cent_o POINT,
    cent_d POINT,
    STFIPS_O INTEGER,
    STFIPS_D INTEGER,
    distance decimal,
    state_O VARCHAR(2),
    state_D VARCHAR(2),

    PRIMARY KEY(rowId)
    
);

copy out_move
from '/home/emma/Desktop/Courses/Grad/COP6712/project4/out_move_point_fixed.csv'
delimiter ','
header csv;

----- OTHER TABLES

-- census_tract_puma_relationship
create table census_puma_relation(
    -- st+puma5ce = puma2
    -- st+country+tract_ce = tract_fips
    id serial,
    st numeric(2),          -- state code
    county integer,        -- county code
    tract_ce integer,
    puma_5ce integer,

    primary key(id)

    -- constraint fk_fips_county
    --   foreign key(st, country)
	--     references msa_delineation_2018(fips_state_code, fips_county_code)

    
);

copy census_puma_relation(st,county,tract_ce,puma_5ce)
from '/home/emma/Desktop/Courses/Grad/COP6712/project4/census_tract_PUMA_relationship.csv'
delimiter ','
header csv;


--MIGPUMA2000_MIGPUMA2010_crosswalk.csv
CREATE TABLE crosswalk_2000_2010(
    st00        numeric(2),
    MigPUMA00   INTEGER,
    GEOID00     INTEGER,
    GISMATCH00  INTEGER,
    st10        numeric(2),
    MigPUMA10   INTEGER,
    GEOID10     INTEGER,
    GISMATCH10  INTEGER,
    st10_name   VARCHAR(20),
    MigPUMA00_pop00 INTEGER,
    MigPUMA10_pop00 INTEGER,
    part_pop00      INTEGER,
    pMigPUMA00_Pop00 DECIMAL,
    pMigPUMA10_Pop00 DECIMAL,
    MigPUMA00_Pop10 INTEGER,
    MigPUMA10_Pop10 INTEGER, 
    Part_Pop10	    INTEGER,
    pMigPUMA00_Pop10    DECIMAL,	
    pMigPUMA10_Pop10	DECIMAL,
    MigPUMA00_Land	BIGINT,
    MigPUMA10_Land  BIGINT,
    Part_Land       BIGINT,
    pMigPUMA00_Land	DECIMAL,
    pMigPUMA10_Land DECIMAL

    --PRIMARY KEY()
);

copy crosswalk_2000_2010
from '/home/emma/Desktop/Courses/Grad/COP6712/project4/MIGPUMA2000_MIGPUMA2010_crosswalk.csv'
delimiter ','
header csv;

--MSA_delineation_2018.xls
-- FIPS STATE AND COUTNRY CODES
CREATE TABLE MSA_delineation_2018(
    CBSA_code                   INTEGER,
    Metro_Div_Code              INTEGER,
	CSA_Code                    INTEGER,
    CBSA_Title	                VARCHAR(100),
    Metro_Micro_Stat_Area       VARCHAR(100),
    Metro_Div_Title             VARCHAR(200),
    CSA_Title	                VARCHAR(100),
    County_Equivalent	        VARCHAR(100),
    St_Name	                VARCHAR(20),
    FIPS_State_Code	        INTEGER,
    FIPS_County_Code	        INTEGER,
    Central_OR_Outlying         VARCHAR(20),        --- this could be changed to a bool to inmporve speed and reduce stoage size

    PRIMARY KEY(FIPS_State_Code, FIPS_County_Code)
);

copy MSA_delineation_2018
from '/home/emma/Desktop/Courses/Grad/COP6712/project4/MSA_delineation_2018_auto_ascii.csv'
delimiter ','
header csv;

--puma_migpuma1_pwpuma00.csv
-- convert 
CREATE TABLE PUMA_to_POWPUMA_relation(
    res_state   INTEGER,        -- state of residence (maps to ST)
    PUMA        INTEGER,
    work_state  INTEGER,        -- state of work(maps to PWSTATE2 or MIGPLAC1)
    pw_PUMA00_MigPuma1 INTEGER  -- maps to PWPUMA00 or MIGPUMA1
);

copy PUMA_to_POWPUMA_relation
from '/home/emma/Desktop/Courses/Grad/COP6712/project4/puma_migpuma1_pwpuma00.csv'
delimiter ','
header csv;

-- the top PUMAs
-- this table is a subset of out_move
--top_out_move.csv
-- create table top_out_move (
--     rowId integer,
--     MigPUMA_O integer,
--     MigPUMA_D integer,
--     person integer,
--     cent_o POINT,
--     cent_d POINT,
--     STFIPS_O INTEGER,
--     STFIPS_D INTEGER,
--     STFIPS_O integer,
--     distance decimal,
--     state_O VARCHAR(2),
--     state_D VARCHAR(2)
    
-- );

-- debugging
-- Allocation flags table
create table allocation_flags (
  state numeric(2),
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
  primary key(serial_no, person_number, state)
);

-- allocation flags data insertion
INSERT into allocation_flags (serial_no, state, person_number,
  age_alloc_flag,
  ancestry_alloc_flag,
  citizenship_alloc_flag,
  year_of_naturalization_alloc_flag,
  class_of_worker_alloc_flag,
  self_care_alloc_flag,
  hearing_difficulty_alloc_flag,
  vision_difficulty_alloc_flag,
  disability_recode_alloc_flag,
  independent_living_difficulty_alloc_flag,
  ambulatory_difficulty_alloc_flag,
  disability_rating_percentage_alloc_flag,
  disability_rating_checkbox_alloc_flag,
  cognitive_difficulty_alloc_flag,
  ability_to_speak_english_alloc_flag,
  employment_status_recode_alloc_flag,
  gave_birth_last_year_alloc_flag,
  field_of_degree_alloc_flag,
  grandparents_living_w_grandchildren_alloc_flag,
  length_of_time_responsible_for_grandchildren_alloc_flag,
  grandparents_responsible_for_grandchildren_alloc_flag,
  insurance_recode_alloc_flag,
  insurance_through_employer_alloc_flag,
  insurance_direct_alloc_flag,
  medicare_coverage_given_through_eligibility_alloc_flag,
  medicare_65_or_older_certain_disabilities_alloc_flag,
  medicare_coverage_given_through_eligibility_alloc_flag2,
  govt_assistance_alloc_flag,
  tricare_through_eligibility_alloc_flag,
  trcare_alloc_flag,
  va_alloc_flag,
  ind_health_service_alloc_flag,
  detailed_hispanic_origin_alloc_flag,
  industry_alloc_flag,
  interest_dividend_rental_income_alloc_flag,
  time_of_departure_to_work_alloc_flag,
  travel_time_to_work_alloc_flag,
  vehicle_occupancy_alloc_flag,
  means_of_transportation_alloc_flag,
  language_other_than_english_spoken_at_home_alloc_flag,
  language_other_than_english_alloc_flag,
  marital_status_alloc_flag,
  divorced_last_year_alloc_flag,
  married_last_year_alloc_flag,
  times_married_alloc_flag,
  widowed_last_year_alloc_flag,
  year_last_married_alloc_flag,
  mobility_status_alloc_flag,
  migration_state_alloc_flag,
  military_periods_of_service_alloc_flag,
  military_service_alloc_flag,
  occupation_alloc_flag,
  all_other_income_alloc_flag,
  public_assistance_income_alloc_flag,
  total_persons_earnings_alloc_flag,
  total_persons_income_alloc_flag,
  place_of_birth_alloc_flag,
  place_of_work_state_alloc_flag,
  private_health_insurance_coverage_recode_alloc_flag,
  public_health_coverage_recode_alloc_flag,
  detailed_race_alloc_flag,
  relationship_alloc_flag,
  retirement_income_alloc_flag,
  grade_attending_alloc_flag,
  highest_education_alloc_flag,
  school_enrollment_alloc_flag,
  self_employment_income_alloc_flag,
  sex_allocation_flag,
  supplementary_security_income_alloc_flag,
  social_security_income_alloc_flag,
  wages_and_salary_income_alloc_flag,
  usual_hours_worked_per_week_last_year_alloc_flag,
  last_worked_alloc_flag,
  weeks_worked_numeric_last_year_alloc_flag,
  weeks_worked_last_year_alloc_flag,
  worked_last_week_alloc_flag,
  year_of_entry_alloc_flag
)
SELECT serial_no, state::numeric(2,0), person_number,
  age_alloc_flag,
  ancestry_alloc_flag,
  citizenship_alloc_flag,
  year_of_naturalization_alloc_flag,
  class_of_worker_alloc_flag,
  self_care_alloc_flag,
  hearing_difficulty_alloc_flag,
  vision_difficulty_alloc_flag,
  disability_recode_alloc_flag,
  independent_living_difficulty_alloc_flag,
  ambulatory_difficulty_alloc_flag,
  disability_rating_percentage_alloc_flag,
  disability_rating_checkbox_alloc_flag,
  cognitive_difficulty_alloc_flag,
  ability_to_speak_english_alloc_flag,
  employment_status_recode_alloc_flag,
  gave_birth_last_year_alloc_flag,
  field_of_degree_alloc_flag,
  grandparents_living_w_grandchildren_alloc_flag,
  length_of_time_responsible_for_grandchildren_alloc_flag,
  grandparents_responsible_for_grandchildren_alloc_flag,
  insurance_recode_alloc_flag,
  insurance_through_employer_alloc_flag,
  insurance_direct_alloc_flag,
  medicare_coverage_given_through_eligibility_alloc_flag,
  medicare_65_or_older_certain_disabilities_alloc_flag,
  medicare_coverage_given_through_eligibility_alloc_flag2,
  govt_assistance_alloc_flag,
  tricare_through_eligibility_alloc_flag,
  trcare_alloc_flag,
  va_alloc_flag,
  ind_health_service_alloc_flag,
  detailed_hispanic_origin_alloc_flag,
  industry_alloc_flag,
  interest_dividend_rental_income_alloc_flag,
  time_of_departure_to_work_alloc_flag,
  travel_time_to_work_alloc_flag,
  vehicle_occupancy_alloc_flag,
  means_of_transportation_alloc_flag,
  language_other_than_english_spoken_at_home_alloc_flag,
  language_other_than_english_alloc_flag,
  marital_status_alloc_flag,
  divorced_last_year_alloc_flag,
  married_last_year_alloc_flag,
  times_married_alloc_flag,
  widowed_last_year_alloc_flag,
  year_last_married_alloc_flag,
  mobility_status_alloc_flag,
  migration_state_alloc_flag,
  military_periods_of_service_alloc_flag,
  military_service_alloc_flag,
  occupation_alloc_flag,
  all_other_income_alloc_flag,
  public_assistance_income_alloc_flag,
  total_persons_earnings_alloc_flag,
  total_persons_income_alloc_flag,
  place_of_birth_alloc_flag,
  place_of_work_state_alloc_flag,
  private_health_insurance_coverage_recode_alloc_flag,
  public_health_coverage_recode_alloc_flag,
  detailed_race_alloc_flag,
  relationship_alloc_flag,
  retirement_income_alloc_flag,
  grade_attending_alloc_flag,
  highest_education_alloc_flag,
  school_enrollment_alloc_flag,
  self_employment_income_alloc_flag,
  sex_allocation_flag,
  supplementary_security_income_alloc_flag,
  social_security_income_alloc_flag,
  wages_and_salary_income_alloc_flag,
  usual_hours_worked_per_week_last_year_alloc_flag,
  last_worked_alloc_flag,
  weeks_worked_numeric_last_year_alloc_flag, weeks_worked_last_year_alloc_flag, worked_last_week_alloc_flag, year_of_entry_alloc_flag
FROM df1_original;

-- Weight Replicates
CREATE TABLE PersonWeightReplicates (
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

INSERT into PersonWeightReplicates (serial_no, person_number, person_weight_replicate_1, person_weight_replicate_2, person_weight_replicate_3,person_weight_replicate_4,person_weight_replicate_5,
person_weight_replicate_6, person_weight_replicate_7, person_weight_replicate_8, person_weight_replicate_9, person_weight_replicate_10, person_weight_replicate_11,
person_weight_replicate_12, person_weight_replicate_13, person_weight_replicate_14, person_weight_replicate_15, person_weight_replicate_16, person_weight_replicate_17,
person_weight_replicate_18, person_weight_replicate_19, person_weight_replicate_20, person_weight_replicate_21, person_weight_replicate_22, person_weight_replicate_23,
person_weight_replicate_24, person_weight_replicate_25, person_weight_replicate_26, person_weight_replicate_27, person_weight_replicate_28, person_weight_replicate_29,
person_weight_replicate_30, person_weight_replicate_31, person_weight_replicate_32, person_weight_replicate_33, person_weight_replicate_34, person_weight_replicate_35,
person_weight_replicate_36, person_weight_replicate_37, person_weight_replicate_38, person_weight_replicate_39, person_weight_replicate_40, person_weight_replicate_41,
person_weight_replicate_42, person_weight_replicate_43, person_weight_replicate_44, person_weight_replicate_45, person_weight_replicate_46, person_weight_replicate_47,
person_weight_replicate_48, person_weight_replicate_49, person_weight_replicate_50, person_weight_replicate_51, person_weight_replicate_52, person_weight_replicate_53,
person_weight_replicate_54, person_weight_replicate_55, person_weight_replicate_56, person_weight_replicate_57, person_weight_replicate_58, person_weight_replicate_59,
person_weight_replicate_60, person_weight_replicate_61, person_weight_replicate_62, person_weight_replicate_63, person_weight_replicate_64, person_weight_replicate_65,
person_weight_replicate_66, person_weight_replicate_67, person_weight_replicate_68, person_weight_replicate_69, person_weight_replicate_70, person_weight_replicate_71,
person_weight_replicate_72, person_weight_replicate_73, person_weight_replicate_74, person_weight_replicate_75, person_weight_replicate_76, person_weight_replicate_77,
person_weight_replicate_78, person_weight_replicate_79, person_weight_replicate_80)
SELECT serial_no, person_number, person_weight_replicate_1, person_weight_replicate_2, person_weight_replicate_3,person_weight_replicate_4,person_weight_replicate_5,
person_weight_replicate_6, person_weight_replicate_7, person_weight_replicate_8, person_weight_replicate_9, person_weight_replicate_10, person_weight_replicate_11,
person_weight_replicate_12, person_weight_replicate_13, person_weight_replicate_14, person_weight_replicate_15, person_weight_replicate_16, person_weight_replicate_17,
person_weight_replicate_18, person_weight_replicate_19, person_weight_replicate_20, person_weight_replicate_21, person_weight_replicate_22, person_weight_replicate_23,
person_weight_replicate_24, person_weight_replicate_25, person_weight_replicate_26, person_weight_replicate_27, person_weight_replicate_28, person_weight_replicate_29,
person_weight_replicate_30, person_weight_replicate_31, person_weight_replicate_32, person_weight_replicate_33, person_weight_replicate_34, person_weight_replicate_35,
person_weight_replicate_36, person_weight_replicate_37, person_weight_replicate_38, person_weight_replicate_39, person_weight_replicate_40, person_weight_replicate_41,
person_weight_replicate_42, person_weight_replicate_43, person_weight_replicate_44, person_weight_replicate_45, person_weight_replicate_46, person_weight_replicate_47,
person_weight_replicate_48, person_weight_replicate_49, person_weight_replicate_50, person_weight_replicate_51, person_weight_replicate_52, person_weight_replicate_53,
person_weight_replicate_54, person_weight_replicate_55, person_weight_replicate_56, person_weight_replicate_57, person_weight_replicate_58, person_weight_replicate_59,
person_weight_replicate_60, person_weight_replicate_61, person_weight_replicate_62, person_weight_replicate_63, person_weight_replicate_64, person_weight_replicate_65,
person_weight_replicate_66, person_weight_replicate_67, person_weight_replicate_68, person_weight_replicate_69, person_weight_replicate_70, person_weight_replicate_71,
person_weight_replicate_72, person_weight_replicate_73, person_weight_replicate_74, person_weight_replicate_75, person_weight_replicate_76, person_weight_replicate_77,
person_weight_replicate_78, person_weight_replicate_79, person_weight_replicate_80
FROM df1_original;

-- veteran status/information
create table vet_info (
  state numeric(2),
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

-- vet info data insertion
INSERT into vet_info (serial_no, state, person_number,
  military_service ,
  served_after_09_2001 ,
  served_from_08_1990_to_08_2001 ,
  served_from_05_1975_to_07_1990 ,
  served_from_08_1964_to_04_1975 ,
  served_from_02_1955_to_07_1964 ,
  served_from_07_1950_to_01_1955 ,
  served_from_01_1947_to_06_1950 ,
  served_from_12_1941_to_12_1946 ,
  served_before_11_1941
)
SELECT serial_no, state::numeric(2,0), person_number,
  military_service ,
  served_after_09_2001 ,
  served_from_08_1990_to_08_2001 ,
  served_from_05_1975_to_07_1990 ,
  served_from_08_1964_to_04_1975 ,
  served_from_02_1955_to_07_1964 ,
  served_from_07_1950_to_01_1955 ,
  served_from_01_1947_to_06_1950 ,
  served_from_12_1941_to_12_1946 ,
  served_before_11_1941
FROM df1_original;

-- Healthcare & disability status table
create table health_info (
  state numeric(2),
  serial_no varchar(13),
  person_number numeric(2),
  self_care_difficulty boolean,
  hearing_difficulty boolean,
  vision_difficulty boolean,
  independent_living_difficulty boolean,
  ambulatory_difficulty boolean,
  vet_disability_rating boolean,
  vet_disability boolean,
  cognitive_difficulty boolean,
  insurance_through_employer boolean,
  insurance_purchased_directly boolean,
  medicare boolean,
  medicaid_etc boolean,
  tricare boolean,
  va boolean,
  ind_health_service boolean,
  disability_recode boolean,
  health_insurance_recode boolean,
  private_health_cov_recode boolean,
  public_health_cov_recode boolean,
  primary key (serial_no, person_number, state)
);

-- Health and disability info data insertion
INSERT into health_info (serial_no, state, person_number,
  self_care_difficulty ,
  hearing_difficulty ,
  vision_difficulty ,
  independent_living_difficulty ,
  ambulatory_difficulty ,
  vet_disability_rating ,
  vet_disability ,
  cognitive_difficulty ,
  insurance_through_employer ,
  insurance_purchased_directly ,
  medicare ,
  medicaid_etc ,
  tricare ,
  va ,
  ind_health_service ,
  disability_recode ,
  health_insurance_recode ,
  private_health_cov_recode ,
  public_health_cov_recode
)
SELECT serial_no, state::numeric(2,0), person_number,
  cast(case when self_care_difficulty = '2'   then false
            when self_care_difficulty = '1'   then true
            when self_care_difficulty is null then null
       end as boolean),
  cast(case when hearing_difficulty = '2'   then false
            when hearing_difficulty = '1'   then true
            when hearing_difficulty is null then null
       end as boolean),
  cast(case when vision_difficulty = '2'   then false
            when vision_difficulty = '1'   then true
            when vision_difficulty is null then null
       end as boolean),
  cast(case when independent_living_difficulty = '2'   then false
            when independent_living_difficulty = '1'   then true
            when independent_living_difficulty is null then null
       end as boolean),
  cast(case when ambulatory_difficulty = '2'   then false
            when ambulatory_difficulty = '1'   then true
            when ambulatory_difficulty is null then null
       end as boolean),
  cast(case when vet_disability_rating = '2'   then false
            when vet_disability_rating = '1'   then true
            when vet_disability_rating is null then null
       end as boolean),
  cast(case when vet_disability = '2'   then false
            when vet_disability = '1'   then true
            when vet_disability is null then null
       end as boolean),
  cast(case when cognitive_difficulty = '2'   then false
            when cognitive_difficulty = '1'   then true
            when cognitive_difficulty is null then null
       end as boolean),
  cast(case when insurance_through_employer = '2'   then false
            when insurance_through_employer = '1'   then true
            when insurance_through_employer is null then null
       end as boolean),
  cast(case when insurance_purchased_directly = '2'   then false
            when insurance_purchased_directly = '1'   then true
            when insurance_purchased_directly is null then null
       end as boolean),
  cast(case when medicare = '2'   then false
            when medicare = '1'   then true
            when medicare is null then null
       end as boolean),
  cast(case when medicaid_etc = '2'   then false
            when medicaid_etc = '1'   then true
            when medicaid_etc is null then null
       end as boolean),
  cast(case when tricare = '2'   then false
            when tricare = '1'   then true
            when tricare is null then null
       end as boolean),
  cast(case when va = '2'   then false
            when va = '1'   then true
            when va is null then null
       end as boolean),
  cast(case when ind_health_service = '2'   then false
            when ind_health_service = '1'   then true
            when ind_health_service is null then null
       end as boolean),
  cast(case when disability_recode = '2'   then false
            when disability_recode = '1'   then true
            when disability_recode is null then null
       end as boolean),
  cast(case when health_insurance_recode = '2'   then false
            when health_insurance_recode = '1'   then true
            when health_insurance_recode is null then null
       end as boolean),
  cast(case when private_health_cov_recode = '2'   then false
            when private_health_cov_recode = '1'   then true
            when private_health_cov_recode is null then null
       end as boolean),
  cast(case when public_health_cov_recode = '2'   then false
            when public_health_cov_recode = '1'   then true
            when public_health_cov_recode is null then null
       end as boolean)
FROM df1_original;

-- Create new table df1 from df1_original, having
-- columns that were separated into other tables removed
-- from df1
create table df1 as select * from df1_original;

alter table df1
drop column if exists military_service ,
drop column if exists served_after_09_2001 ,
drop column if exists served_from_08_1990_to_08_2001 ,
drop column if exists served_from_05_1975_to_07_1990 ,
drop column if exists served_from_08_1964_to_04_1975 ,
drop column if exists served_from_02_1955_to_07_1964 ,
drop column if exists served_from_07_1950_to_01_1955 ,
drop column if exists served_from_01_1947_to_06_1950 ,
drop column if exists served_from_12_1941_to_12_1946 ,
drop column if exists served_before_11_1941,
drop column if exists age_alloc_flag,
drop column if exists ancestry_alloc_flag,
drop column if exists citizenship_alloc_flag,
drop column if exists year_of_naturalization_alloc_flag,
drop column if exists class_of_worker_alloc_flag,
drop column if exists self_care_alloc_flag,
drop column if exists hearing_difficulty_alloc_flag,
drop column if exists vision_difficulty_alloc_flag,
drop column if exists disability_recode_alloc_flag,
drop column if exists independent_living_difficulty_alloc_flag,
drop column if exists ambulatory_difficulty_alloc_flag,
drop column if exists disability_rating_percentage_alloc_flag,
drop column if exists disability_rating_checkbox_alloc_flag,
drop column if exists cognitive_difficulty_alloc_flag,
drop column if exists ability_to_speak_english_alloc_flag,
drop column if exists employment_status_recode_alloc_flag,
drop column if exists gave_birth_last_year_alloc_flag,
drop column if exists field_of_degree_alloc_flag,
drop column if exists grandparents_living_w_grandchildren_alloc_flag,
drop column if exists length_of_time_responsible_for_grandchildren_alloc_flag,
drop column if exists grandparents_responsible_for_grandchildren_alloc_flag,
drop column if exists insurance_recode_alloc_flag,
drop column if exists insurance_through_employer_alloc_flag,
drop column if exists insurance_direct_alloc_flag,
drop column if exists medicare_coverage_given_through_eligibility_alloc_flag,
drop column if exists medicare_65_or_older_certain_disabilities_alloc_flag,
drop column if exists medicare_coverage_given_through_eligibility_alloc_flag2,
drop column if exists govt_assistance_alloc_flag,
drop column if exists tricare_through_eligibility_alloc_flag,
drop column if exists trcare_alloc_flag,
drop column if exists va_alloc_flag,
drop column if exists ind_health_service_alloc_flag,
drop column if exists detailed_hispanic_origin_alloc_flag,
drop column if exists industry_alloc_flag,
drop column if exists interest_dividend_rental_income_alloc_flag,
drop column if exists time_of_departure_to_work_alloc_flag,
drop column if exists travel_time_to_work_alloc_flag,
drop column if exists vehicle_occupancy_alloc_flag,
drop column if exists means_of_transportation_alloc_flag,
drop column if exists language_other_than_english_spoken_at_home_alloc_flag,
drop column if exists language_other_than_english_alloc_flag,
drop column if exists marital_status_alloc_flag,
drop column if exists divorced_last_year_alloc_flag,
drop column if exists married_last_year_alloc_flag,
drop column if exists times_married_alloc_flag,
drop column if exists widowed_last_year_alloc_flag,
drop column if exists year_last_married_alloc_flag,
drop column if exists mobility_status_alloc_flag,
drop column if exists migration_state_alloc_flag,
drop column if exists military_periods_of_service_alloc_flag,
drop column if exists military_service_alloc_flag,
drop column if exists occupation_alloc_flag,
drop column if exists all_other_income_alloc_flag,
drop column if exists public_assistance_income_alloc_flag,
drop column if exists total_persons_earnings_alloc_flag,
drop column if exists total_persons_income_alloc_flag,
drop column if exists place_of_birth_alloc_flag,
drop column if exists place_of_work_state_alloc_flag,
drop column if exists private_health_insurance_coverage_recode_alloc_flag,
drop column if exists public_health_coverage_recode_alloc_flag,
drop column if exists detailed_race_alloc_flag,
drop column if exists relationship_alloc_flag,
drop column if exists retirement_income_alloc_flag,
drop column if exists grade_attending_alloc_flag,
drop column if exists highest_education_alloc_flag,
drop column if exists school_enrollment_alloc_flag,
drop column if exists self_employment_income_alloc_flag,
drop column if exists sex_allocation_flag,
drop column if exists supplementary_security_income_alloc_flag,
drop column if exists social_security_income_alloc_flag,
drop column if exists wages_and_salary_income_alloc_flag,
drop column if exists usual_hours_worked_per_week_last_year_alloc_flag,
drop column if exists last_worked_alloc_flag,
drop column if exists weeks_worked_numeric_last_year_alloc_flag,
drop column if exists weeks_worked_last_year_alloc_flag,
drop column if exists worked_last_week_alloc_flag,
drop column if exists year_of_entry_alloc_flag,
drop column if exists person_weight_replicate_1,
drop column if exists person_weight_replicate_2,
drop column if exists person_weight_replicate_3,
drop column if exists person_weight_replicate_4,
drop column if exists person_weight_replicate_5,
drop column if exists person_weight_replicate_6,
drop column if exists person_weight_replicate_7,
drop column if exists person_weight_replicate_8,
drop column if exists person_weight_replicate_9,
drop column if exists person_weight_replicate_10,
drop column if exists person_weight_replicate_11,
drop column if exists person_weight_replicate_12,
drop column if exists person_weight_replicate_13,
drop column if exists person_weight_replicate_14,
drop column if exists person_weight_replicate_15,
drop column if exists person_weight_replicate_16,
drop column if exists person_weight_replicate_17,
drop column if exists person_weight_replicate_18,
drop column if exists person_weight_replicate_19,
drop column if exists person_weight_replicate_20,
drop column if exists person_weight_replicate_21,
drop column if exists person_weight_replicate_22,
drop column if exists person_weight_replicate_23,
drop column if exists person_weight_replicate_24,
drop column if exists person_weight_replicate_25,
drop column if exists person_weight_replicate_26,
drop column if exists person_weight_replicate_27,
drop column if exists person_weight_replicate_28,
drop column if exists person_weight_replicate_29,
drop column if exists person_weight_replicate_30,
drop column if exists person_weight_replicate_31,
drop column if exists person_weight_replicate_32,
drop column if exists person_weight_replicate_33,
drop column if exists person_weight_replicate_34,
drop column if exists person_weight_replicate_35,
drop column if exists person_weight_replicate_36,
drop column if exists person_weight_replicate_37,
drop column if exists person_weight_replicate_38,
drop column if exists person_weight_replicate_39,
drop column if exists person_weight_replicate_40,
drop column if exists person_weight_replicate_41,
drop column if exists person_weight_replicate_42,
drop column if exists person_weight_replicate_43,
drop column if exists person_weight_replicate_44,
drop column if exists person_weight_replicate_45,
drop column if exists person_weight_replicate_46,
drop column if exists person_weight_replicate_47,
drop column if exists person_weight_replicate_48,
drop column if exists person_weight_replicate_49,
drop column if exists person_weight_replicate_50,
drop column if exists person_weight_replicate_51,
drop column if exists person_weight_replicate_52,
drop column if exists person_weight_replicate_53,
drop column if exists person_weight_replicate_54,
drop column if exists person_weight_replicate_55,
drop column if exists person_weight_replicate_56,
drop column if exists person_weight_replicate_57,
drop column if exists person_weight_replicate_58,
drop column if exists person_weight_replicate_59,
drop column if exists person_weight_replicate_60,
drop column if exists person_weight_replicate_61,
drop column if exists person_weight_replicate_62,
drop column if exists person_weight_replicate_63,
drop column if exists person_weight_replicate_64,
drop column if exists person_weight_replicate_65,
drop column if exists person_weight_replicate_66,
drop column if exists person_weight_replicate_67,
drop column if exists person_weight_replicate_68,
drop column if exists person_weight_replicate_69,
drop column if exists person_weight_replicate_70,
drop column if exists person_weight_replicate_71,
drop column if exists person_weight_replicate_72,
drop column if exists person_weight_replicate_73,
drop column if exists person_weight_replicate_74,
drop column if exists person_weight_replicate_75,
drop column if exists person_weight_replicate_76,
drop column if exists person_weight_replicate_77,
drop column if exists person_weight_replicate_78,
drop column if exists person_weight_replicate_79,
drop column if exists person_weight_replicate_80,
drop column if exists self_care_difficulty ,
drop column if exists hearing_difficulty ,
drop column if exists vision_difficulty ,
drop column if exists independent_living_difficulty ,
drop column if exists ambulatory_difficulty ,
drop column if exists vet_disability_rating ,
drop column if exists vet_disability ,
drop column if exists cognitive_difficulty ,
drop column if exists insurance_through_employer ,
drop column if exists insurance_purchased_directly ,
drop column if exists medicare ,
drop column if exists medicaid_etc ,
drop column if exists tricare ,
drop column if exists va ,
drop column if exists ind_health_service ,
drop column if exists disability_recode ,
drop column if exists health_insurance_recode ,
drop column if exists private_health_cov_recode ,
drop column if exists public_health_cov_recode;

-- Convert state from string to numeric
alter table df1 alter column state type numeric(2, 0) using
state::numeric(2,0);

alter table df1 add column state_o numeric(2, 0);
update df1 set state_o = substring(migpuma_o, 1, 2)::numeric(2,0);


-- TESTING NEEDED ONWARD
alter table df1 alter column migpuma_d type integer using substring(migpuma_d, 3)::int;
alter table df1 alter column migpuma_o type integer using substring(migpuma_o, 3)::int;

-- Add foreign keys between df1 and vet_info, between
-- df1 and allocation_flags, and between df1 and PersonWeightReplicates
alter table df1
add constraint df1_to_vet_info_fk
foreign key (serial_no, person_number)
references vet_info(serial_no, person_number);

alter table df1
add constraint df1_to_allocation_flags_fk
foreign key (serial_no, person_number, state)
references allocation_flags(serial_no, person_number, state);

alter table df1
add constraint df1_to_PersonWeightReplicates_fk
foreign key (serial_no, person_number)
references PersonWeightReplicates(serial_no, person_number);

alter table df1
add constraint df1_to_health_info_fk
foreign key (serial_no, person_number, state)
references health_info(serial_no, person_number, state);

create index dest_state_index on df1 (state_o);
create index migpuma_d_index on df1 (migpuma_d);
create index state_index on census_puma_relation (st);
-- END TESTING
