-- Queries to answer research questions about queries

select substr(serial_no, 1, 4) as year, age, person_number, person_weight,
       migpuma_o, migpuma_d
from df1
where cast(migpuma_o as integer) in
 (select distinct cast(st || right('00000' || cast(puma_5ce as text),5) as integer) from census_puma_relation where cast(st as text) || '-' || cast(county as text) in
  (select distinct cast(FIPS_State_Code as text) || '-' || cast(FIPS_County_Code as text) from msa_delineation_2018 where CBSA_Title like 'Houston%, TX'))
  and substr(serial_no, 1, 4) = '2018';

-- Destinations where people from Houston, Texas moved to between 2017 and 2018
-- ordered by number of people who moved.
select migpuma_d,
case
when state = '01' then 'AL'
when state = '02' then 'AK'
when state = '04' then 'AZ'
when state = '05' then 'AR'
when state = '06' then 'CA'
when state = '08' then 'CO'
when state = '09' then 'CT'
when state = '10' then 'DE'
when state = '11' then 'DC'
when state = '12' then 'FL'
when state = '13' then 'GA'
when state = '15' then 'HI'
when state = '16' then 'ID'
when state = '17' then 'IL'
when state = '18' then 'IN'
when state = '19' then 'IA'
when state = '20' then 'KS'
when state = '21' then 'KY'
when state = '22' then 'LA'
when state = '23' then 'ME'
when state = '24' then 'MD'
when state = '25' then 'MA'
when state = '26' then 'MI'
when state = '27' then 'MN'
when state = '28' then 'MS'
when state = '29' then 'MO'
when state = '30' then 'MT'
when state = '31' then 'NE'
when state = '32' then 'NV'
when state = '33' then 'NH'
when state = '34' then 'NJ'
when state = '35' then 'NM'
when state = '36' then 'NY'
when state = '37' then 'NC'
when state = '38' then 'ND'
when state = '39' then 'OH'
when state = '40' then 'OK'
when state = '41' then 'OR'
when state = '42' then 'PA'
when state = '44' then 'RI'
when state = '45' then 'SC'
when state = '46' then 'SD'
when state = '47' then 'TN'
when state = '48' then 'TX'
when state = '49' then 'UT'
when state = '50' then 'VT'
when state = '51' then 'VA'
when state = '53' then 'WA'
when state = '54' then 'WV'
when state = '55' then 'WI'
when state = '56' then 'WY'
when state = '72' then 'PR'
else 'other'
end,
sum(person_weight)
from df1
where cast(migpuma_o as integer) in
 (select distinct cast(st || right('00000' || cast(puma_5ce as text),5) as integer) from census_puma_relation where cast(st as text) || '-' || cast(county as text) in
  (select distinct cast(FIPS_State_Code as text) || '-' || cast(FIPS_County_Code as text) from msa_delineation_2018 where CBSA_Title like 'Houston%, TX'))
  and substr(serial_no, 1, 4) = '2018' group by migpuma_d, state
  order by sum(person_weight) desc;

-- Total number of people who moved out of Houston, TX between 2016 and 2017
select sum(person_weight)
from df1
where cast(migpuma_o as integer) in
 (select distinct cast(st || right('00000' || cast(puma_5ce as text),5) as integer) from census_puma_relation where cast(st as text) || '-' || cast(county as text) in
  (select distinct cast(FIPS_State_Code as text) || '-' || cast(FIPS_County_Code as text) from msa_delineation_2018 where CBSA_Title like 'Houston%, TX'))
  and substr(serial_no, 1, 4) = '2017';


-- Total number of people with a disability who moved out of Houston, TX
-- between 2016 and 2017
select sum(person_weight)
from df1
where cast(migpuma_o as integer) in
 (select distinct cast(st || right('00000' || cast(puma_5ce as text),5) as integer) from census_puma_relation where cast(st as text) || '-' || cast(county as text) in
  (select distinct cast(FIPS_State_Code as text) || '-' || cast(FIPS_County_Code as text) from msa_delineation_2018 where CBSA_Title like 'Houston%, TX'))
  and substr(serial_no, 1, 4) = '2017'
  and (self_care_difficulty = '1' or
       hearing_difficulty = '1' or
       vision_difficulty = '1' or
       independent_living_difficulty = '1');

select substr(serial_no, 1, 4) as year, age, person_number, person_weight,
       migpuma_o, migpuma_d, total_persons_earnings, total_persons_income, salary_last_year
from df1
where cast(migpuma_o as integer) in
 (select distinct cast(st || right('00000' || cast(puma_5ce as text),5) as integer) from census_puma_relation where cast(st as text) || '-' || cast(county as text) in
  (select distinct cast(FIPS_State_Code as text) || '-' || cast(FIPS_County_Code as text) from msa_delineation_2018 where CBSA_Title like 'Houston%, TX'))
  and substr(serial_no, 1, 4) = '2018';

-- Average income of those leaving Houston, TX
-- with zero and null income removed.
-- Used on person dataset so may not be most accurate metric.
select sum(person_weight * total_persons_income) / sum(person_weight) as avg_income
from df1
where cast(migpuma_o as integer) in
 (select distinct cast(st || right('00000' || cast(puma_5ce as text),5) as integer) from census_puma_relation where cast(st as text) || '-' || cast(county as text) in
  (select distinct cast(FIPS_State_Code as text) || '-' || cast(FIPS_County_Code as text) from msa_delineation_2018 where CBSA_Title like 'Houston%, TX'))
  and substr(serial_no, 1, 4) = '2018' and total_persons_income <> 0 and total_persons_income is not null;

-- Show employment status of out_migrating
select case when employment_status_recode = '1' then 'Civilian employed at work'
            when employment_status_recode = '2' then 'Civilian employed, with a job but not at work'
            when employment_status_recode = '3' then 'Unemployed'
            when employment_status_recode = '4' then 'Armed forces, at work'
            when employment_status_recode = '5' then 'Armed forces, with a job but not at work'
            when employment_status_recode = '6' then 'Not in labor force'
            else 'Other'
        end as employment_status,
            sum(person_weight)
from df1
where cast(migpuma_o as integer) in
 (select distinct cast(st || right('00000' || cast(puma_5ce as text),5) as integer) from census_puma_relation where cast(st as text) || '-' || cast(county as text) in
  (select distinct cast(FIPS_State_Code as text) || '-' || cast(FIPS_County_Code as text) from msa_delineation_2018 where CBSA_Title like 'Houston%, TX'))
  and substr(serial_no, 1, 4) = '2018'
group by employment_status_recode;


-- Racial demographics
select case when recoded_race_code = '1' then 'White alone'
            when recoded_race_code = '2' then 'Black alone'
            when recoded_race_code = '3' then 'Native American alone'
            when recoded_race_code = '4' then 'Alaska Native alone'
            when recoded_race_code = '5' then 'Native American and Alaska Native tribes specified;
                                               or Native American or Alaska Native, not specified
                                               and no other races'
            when recoded_race_code = '6' then 'Asian alone'
            when recoded_race_code = '7' then 'Native Hawaiian and Other Pacific Islander alone'
            when recoded_race_code = '8' then 'Some Other Race alone'
            when recoded_race_code = '9' then 'Two or More Races'
            else 'Other'
        end as racial_group,
sum(person_weight)
from df1
where cast(migpuma_o as integer) in
 (select distinct cast(st || right('00000' || cast(puma_5ce as text),5) as integer) from census_puma_relation where cast(st as text) || '-' || cast(county as text) in
  (select distinct cast(FIPS_State_Code as text) || '-' || cast(FIPS_County_Code as text) from msa_delineation_2018 where CBSA_Title like 'Houston%, TX'))
  and substr(serial_no, 1, 4) = '2018'
group by recoded_race_code;


-- Top 10 metro areas
-- 1. New York-Newark-Jersey City, NY-NJ-PA MSA -> 408
-- 2. Los Angeles-Long Beach-Anaheim, CA MSA -> 348
-- 3. Chicago-Naperville-Elgin, IL-IN-WI MSA -> 176
-- 4. Dallas-Fort Worth-Arlington, TX MSA -> 206
-- 5. Houston-The Woodlands-Sugar Land, TX MSA -> 288
-- 6. Washington-Arlington-Alexandria, DC-VA-MD-WV MSA -> 548
-- 7. Philadelphia-Camden-Wilmington, PA-NJ-DE-MD MSA -> 428
-- 8. Miami-Fort Lauderdale-Pompano Beach, FL MSA -> 370
-- 9. Atlanta-Sandy Springs-Alpharetta, GA MSA -> 122
-- 10. Boston-Cambridge-Newton, MA-NH MSA -> 148
--
-- Get top 10 metro areas
select * from msa_delineation_2018
where CSA_Code in (408, 348, 176, 206, 288, 548, 428, 370, 122, 148);


select substr(serial_no, 1, 4) as year, age, person_number, person_weight,
       migpuma_o, migpuma_d
from df1
where cast(migpuma_o as integer) in
(select distinct cast(st || right('00000' || cast(puma_5ce as text),5) as integer) from census_puma_relation where cast(st as text) || '-' || cast(county as text) in
 (select distinct cast(FIPS_State_Code as text) || '-' || cast(FIPS_County_Code as text) from msa_delineation_2018
  where CSA_Code in (408, 348, 176, 206, 288, 548, 428, 370, 122, 148)));

select substr(serial_no, 1, 4) as year, age, person_number, person_weight,
       migpuma_o, migpuma_d
from df1
where cast(migpuma_o as integer) in
(select distinct cast(st || right('00000' || cast(puma_5ce as text),5) as integer) from census_puma_relation where cast(st as text) || '-' || cast(county as text) in
 (select distinct cast(FIPS_State_Code as text) || '-' || cast(FIPS_County_Code as text) from msa_delineation_2018
  where CSA_Code in (408, 348, 176, 206, 288, 548, 428, 370, 122, 148)));

-- Get all NYC-Newark -> NYC-Newark metro movements
select substr(serial_no, 1, 4) as year, age, person_number, person_weight,
       migpuma_o, migpuma_d
from df1
where cast(migpuma_o as integer) in
(select distinct cast(st || right('00000' || cast(puma_5ce as text),5) as integer) from census_puma_relation where cast(st as text) || '-' || cast(county as text) in
 (select distinct cast(FIPS_State_Code as text) || '-' || cast(FIPS_County_Code as text) from msa_delineation_2018
  where CSA_Code = 408))
  and
  cast(migpuma_d as integer) in
(select distinct cast(st || right('00000' || cast(puma_5ce as text),5) as integer) from census_puma_relation where cast(st as text) || '-' || cast(county as text) in
 (select distinct cast(FIPS_State_Code as text) || '-' || cast(FIPS_County_Code as text) from msa_delineation_2018
  where CSA_Code = 408));

-- Get all NYC-Newark -> other top 10 metro movements
select substr(serial_no, 1, 4) as year, age, person_number, person_weight,
       migpuma_o, migpuma_d
from df1
where cast(migpuma_o as integer) in
(select distinct cast(st || right('00000' || cast(puma_5ce as text),5) as integer) from census_puma_relation where cast(st as text) || '-' || cast(county as text) in
 (select distinct cast(FIPS_State_Code as text) || '-' || cast(FIPS_County_Code as text) from msa_delineation_2018
  where CSA_Code = 408))
  and
  cast(migpuma_d as integer) in
(select distinct cast(st || right('00000' || cast(puma_5ce as text),5) as integer) from census_puma_relation where cast(st as text) || '-' || cast(county as text) in
 (select distinct cast(FIPS_State_Code as text) || '-' || cast(FIPS_County_Code as text) from msa_delineation_2018
  where CSA_Code in (348, 176, 206, 288, 548, 428, 370, 122, 148)));
