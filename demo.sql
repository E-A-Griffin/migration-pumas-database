-- Destinations where people from Houston, Texas moved to between 2017 and 2018
-- ordered by number of people who moved.
with pumas as (
 select distinct pw_puma00_migpuma1
 from msa_delineation_2018, census_puma_relation, puma_to_powpuma_relation
 where CBSA_Title like 'Houston%, TX' and
       st = fips_state_code and
       county = fips_county_code and
       puma_to_powpuma_relation.puma = puma_5ce
)
select migpuma_d as destination_puma,
       state_num_to_code(state) as destination_state,
       sum(person_weight) as num_people
from df1
where migpuma_o in (select * from pumas) and
      state_o = state_code_to_num('TX')
group by destination_puma, destination_state
order by num_people desc;

-- Total number of people who moved out of Houston, TX between 2016 and 2017
select sum(person_weight)
from df1
where cast(migpuma_o as integer) in
 (select distinct cast(st || right('00000' || cast(puma_5ce as text),5) as integer) from census_puma_relation where cast(st as text) || '-' || cast(county as text) in
  (select distinct cast(FIPS_State_Code as text) || '-' || cast(FIPS_County_Code as text) from msa_delineation_2018 where CBSA_Title like 'Houston%, TX'))
  and substr(serial_no, 1, 4) = '2017';

-- Serves as a template for accessing health issues, specifically related to
-- disability status.
--
-- Total number of people with a disability who moved out of Houston, TX
-- between 2016 and 2017
with pumas as (
 select distinct pw_puma00_migpuma1
 from msa_delineation_2018, census_puma_relation, puma_to_powpuma_relation
 where CBSA_Title like 'Houston%, TX' and
       st = fips_state_code           and
       county = fips_county_code      and
       puma_to_powpuma_relation.puma = puma_5ce
)
select sum(person_weight) as total_disabled_population,
       sum(person_weight) filter (where self_care_difficulty)
                          as self_care_difficulty_population,
       sum(person_weight) filter (where hearing_difficulty)
                          as hearing_difficulty_population,
       sum(person_weight) filter (where vision_difficulty)
                          as vision_difficulty_population,
       sum(person_weight) filter (where independent_living_difficulty)
                          as independent_living_difficulty_population,
       sum(person_weight) filter (where ambulatory_difficulty)
                          as ambulatory_difficulty_population,
       sum(person_weight) filter (where cognitive_difficulty)
                          as cognitive_difficulty_population
from df1, health_info
where migpuma_o in (select * from pumas)    and
      state_o = state_code_to_num('TX')     and
      substr(df1.serial_no, 1, 4) = '2017'  and
      health_info.serial_no = df1.serial_no and
      disability_recode;

-- Total number of people who moved out of Houston, TX between 2017 and 2018
-- along with basic income/demographic information
with pumas as (
 select distinct pw_puma00_migpuma1
 from msa_delineation_2018, census_puma_relation, puma_to_powpuma_relation
 where CBSA_Title like 'Houston%, TX' and
       st = fips_state_code           and
       county = fips_county_code      and
       puma_to_powpuma_relation.puma = puma_5ce
)
select substr(serial_no, 1, 4) as year, age, person_number, person_weight,
       'TX' as original_state, migpuma_o as original_puma,
       state_num_to_code(state) as destination_state,
       migpuma_d as destination_puma,
       total_persons_earnings, total_persons_income, salary_last_year
from df1
where migpuma_o in (select * from pumas)       and
      state_o = state_code_to_num('TX')        and
      (state <> state_code_to_num('TX')        or
       migpuma_d not in (select * from pumas)) and
       substr(serial_no, 1, 4) = '2018';

-- Average income of those leaving Houston, TX
-- with zero and null income removed.
-- Used on person dataset so may not be most accurate metric.
with pumas as (
 select distinct pw_puma00_migpuma1
 from msa_delineation_2018, census_puma_relation, puma_to_powpuma_relation
 where CBSA_Title like 'Houston%, TX' and
       st = fips_state_code           and
       county = fips_county_code      and
       puma_to_powpuma_relation.puma = puma_5ce
)
select round(sum(person_weight * total_persons_income) / sum(person_weight), 2)
       as avg_income
from df1
where migpuma_o in (select * from pumas)       and
      state_o = state_code_to_num('TX')        and
      (state <> state_code_to_num('TX')        or
       migpuma_d not in (select * from pumas)) and
      substr(serial_no, 1, 4) = '2018'         and
      total_persons_income <> 0                and
      total_persons_income is not null;

-- Show employment status of out_migrating
with pumas as (
 select distinct pw_puma00_migpuma1
 from msa_delineation_2018, census_puma_relation, puma_to_powpuma_relation
 where CBSA_Title like 'Houston%, TX' and
       st = fips_state_code           and
       county = fips_county_code      and
       puma_to_powpuma_relation.puma = puma_5ce
)
select employment_code_to_explanation(employment_status_recode)
       as employment_status, sum(person_weight)
from df1
where migpuma_o in (select * from pumas)       and
      state_o = state_code_to_num('TX')        and
      (state <> state_code_to_num('TX')        or
       migpuma_d not in (select * from pumas)) and
      substr(serial_no, 1, 4) = '2018'
group by employment_status_recode
order by sum(person_weight) desc;


-- Racial demographics
with pumas as (
 select distinct pw_puma00_migpuma1
 from msa_delineation_2018, census_puma_relation, puma_to_powpuma_relation
 where CBSA_Title like 'Houston%, TX' and
       st = fips_state_code           and
       county = fips_county_code      and
       puma_to_powpuma_relation.puma = puma_5ce
)
select race_code_to_explanation(recoded_race_code) as racial_group,
       sum(person_weight)
from df1
where migpuma_o in (select * from pumas)       and
      state_o = state_code_to_num('TX')        and
      (state <> state_code_to_num('TX')        or
       migpuma_d not in (select * from pumas)) and
      substr(serial_no, 1, 4) = '2018'
group by recoded_race_code
order by sum(person_weight) desc;


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


-- 3 main types of queries:
-- (1) all 10 metro areas
-- (2) intra-metro area movement
-- (3) inter-metro area movement

-- Template for all 10 metro areas
-- Get individuals in top 10 metro areas
with states as (
 select distinct fips_state_code
 from msa_delineation_2018
 where CSA_Code in (408, 348, 176, 206, 288, 548, 428, 370, 122, 148)),
 pumas as (
 select distinct pw_puma00_migpuma1
 from msa_delineation_2018, census_puma_relation, puma_to_powpuma_relation
 where CSA_Code in (408, 348, 176, 206, 288, 548, 428, 370, 122, 148) and
       st = fips_state_code and
       county = fips_county_code and
       puma_to_powpuma_relation.puma = puma_5ce
)
select substr(serial_no, 1, 4) as year, age, person_number, person_weight,
       migpuma_o, migpuma_d
from df1
where state     in (select * from states) and
      migpuma_d in (select * from pumas);
-- Template for intra-metro movement
-- Get all NYC-Newark -> NYC-Newark metro movements
with states_and_pumas as (
 select distinct fips_state_code, pw_puma00_migpuma1
 from msa_delineation_2018, census_puma_relation, puma_to_powpuma_relation
 where CSA_Code = 408 and
       st = fips_state_code and
       county = fips_county_code and
       puma_to_powpuma_relation.puma = puma_5ce
)
select substr(serial_no, 1, 4) as year, age, person_number, person_weight,
       state_o as original_state, state as destination_state,
       migpuma_o as original_puma, migpuma_d as destination_puma
from df1
where (state, migpuma_d)     in (select * from states_and_pumas) and
      (state_o, migpuma_o)   in (select * from states_and_pumas);

-- Template for inter-metro movement
-- Get all NYC-Newark -> Different top 10 metro area
with o_states_and_pumas as (
 select distinct fips_state_code, pw_puma00_migpuma1
 from msa_delineation_2018, census_puma_relation, puma_to_powpuma_relation
 where CSA_Code = 408 and
       st = fips_state_code and
       county = fips_county_code and
       puma_to_powpuma_relation.puma = puma_5ce),
 d_states_and_pumas as (
 select distinct fips_state_code, pw_puma00_migpuma1
 from msa_delineation_2018, census_puma_relation, puma_to_powpuma_relation
 where CSA_Code in (348, 176, 206, 288, 548, 428, 370, 122, 148) and
       st = fips_state_code and
       county = fips_county_code and
       puma_to_powpuma_relation.puma = puma_5ce)

select substr(serial_no, 1, 4) as year, age, person_number, person_weight,
       state as destination_state, state_o as original_state,
       migpuma_o as original_puma, migpuma_d as destination_puma
from df1
where (state_o, migpuma_o) in (select * from o_states_and_pumas) and
      (state, migpuma_d) in (select * from d_states_and_pumas);


-- start debug
with o_states_and_pumas as (
 select distinct fips_state_code, migpuma10
 from msa_delineation_2018, census_puma_relation, crosswalk_2000_2010,
      puma_to_powpuma_relation
 where CSA_Code = 408 and
       st = fips_state_code and
       county = fips_county_code and
       migpuma10 = pw_puma00_migpuma1 and
       puma = puma_5ce),
 d_states_and_pumas as (
 select distinct fips_state_code, migpuma10
 from msa_delineation_2018, census_puma_relation, crosswalk_2000_2010,
      puma_to_powpuma_relation
 where CSA_Code = 348 and
       st = fips_state_code and
       county = fips_county_code and
       migpuma10 = pw_puma00_migpuma1 and
       puma = puma_5ce)

select --substr(serial_no, 1, 4) as year, age, person_number,
       --person_weight,
       distinct --state as destination_state,
       state_o as original_state,
       puma_to_powpuma_relation.puma as original_puma--,
       --df1.puma as destination_puma
 from df1, puma_to_powpuma_relation
 where (state_o, migpuma_o) in (select * from o_states_and_pumas) and
       --(state, migpuma_d) in (select * from d_states_and_pumas)   and
       (state, migpuma_d) not in (select * from o_states_and_pumas)   and
       migpuma_o = pw_puma00_migpuma1                             and
       state_o   = res_state
       order by original_state desc, original_puma desc;

-- top 10 outflows
with o_states_and_pumas as (
 select distinct fips_state_code, migpuma10
 from msa_delineation_2018, census_puma_relation, crosswalk_2000_2010,
      puma_to_powpuma_relation
 where CSA_Code = 288 and
       st = fips_state_code and
       county = fips_county_code and
       migpuma10 = pw_puma00_migpuma1 and
       puma = puma_5ce)

select sum(person_weight) as population,
       state as destination_state,
       df1.puma as destination_puma
 from df1, puma_to_powpuma_relation
 where (state_o, migpuma_o) in (select * from o_states_and_pumas) and

       migpuma_o = pw_puma00_migpuma1                             and
       state_o   = res_state
 group by destination_puma, destination_state
 order by sum(person_weight) desc
 limit 10;

with o_states_and_pumas as (
                   select distinct fips_state_code, migpuma10
                   from msa_delineation_2018, census_puma_relation,
                        crosswalk_2000_2010, puma_to_powpuma_relation
                   where CSA_Code = '408' and
                         st = fips_state_code and
                         county = fips_county_code and
                         migpuma10 = pw_puma00_migpuma1 and
                         puma = puma_5ce),
     -- mig_o_states_and_pumas necessary due to issue of 2000 vs. 2010
     -- representation of puma codes
     mig_o_states_and_pumas as (
                   select distinct state_o,
                                   puma_to_powpuma_relation.puma
                   from df1, puma_to_powpuma_relation
                   where (state_o, migpuma_o) in
                         (select * from o_states_and_pumas) and
                         migpuma_o = pw_puma00_migpuma1     and
                         state_o   = res_state)
  select sum(person_weight) as population,
         --state_o::text as original_state,
         --puma_to_powpuma_relation.puma::int as original_puma,
         state::text as destination_state,
         df1.puma::int as destination_puma
   from df1, puma_to_powpuma_relation
   where (state_o, migpuma_o) in (select * from o_states_and_pumas)  and
         (state, df1.puma::int) not in (select * from mig_o_states_and_pumas) and
         migpuma_o = pw_puma00_migpuma1                              and
         state_o   = res_state                                       and
         substr(serial_no, 1, 4)::int between 2015 and 2019
   group by destination_state, destination_puma
   order by sum(person_weight) desc
   limit 10;
-- top k inflows cannot be extrapolated from the database

-- end debug

-- Get racial demographics of individuals in top 10 metro areas
with states as (
 select distinct fips_state_code
 from msa_delineation_2018
 where CSA_Code in (408, 348, 176, 206, 288, 548, 428, 370, 122, 148)),
 pumas as (
 select distinct pw_puma00_migpuma1
 from msa_delineation_2018, census_puma_relation, puma_to_powpuma_relation
 where CSA_Code in (408, 348, 176, 206, 288, 548, 428, 370, 122, 148) and
       st = fips_state_code and
       county = fips_county_code and
       puma_to_powpuma_relation.puma = puma_5ce
)
-- Maybe create stored procedures for case statements
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
where state     in (select * from states) and
      migpuma_d in (select * from pumas)
group by recoded_race_code
order by sum(person_weight) desc;

-- Get employment status of individuals in top 10 metro areas
with states as (
 select distinct fips_state_code
 from msa_delineation_2018
 where CSA_Code in (408, 348, 176, 206, 288, 548, 428, 370, 122, 148)),
 pumas as (
 select distinct pw_puma00_migpuma1
 from msa_delineation_2018, census_puma_relation, puma_to_powpuma_relation
 where CSA_Code in (408, 348, 176, 206, 288, 548, 428, 370, 122, 148) and
       st = fips_state_code and
       county = fips_county_code and
       puma_to_powpuma_relation.puma = puma_5ce
)
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
where state     in (select * from states) and
      migpuma_d in (select * from pumas)
group by employment_status
order by sum(person_weight) desc;

-- Average income of those in top 10 metro areas
with states as (
 select distinct fips_state_code
 from msa_delineation_2018
 where CSA_Code in (408, 348, 176, 206, 288, 548, 428, 370, 122, 148)),
 pumas as (
 select distinct pw_puma00_migpuma1
 from msa_delineation_2018, census_puma_relation, puma_to_powpuma_relation
 where CSA_Code in (408, 348, 176, 206, 288, 548, 428, 370, 122, 148) and
       st = fips_state_code and
       county = fips_county_code and
       puma_to_powpuma_relation.puma = puma_5ce
)
select round(sum(person_weight * total_persons_income) / sum(person_weight), 2) as
       avg_income
from df1
where state     in (select * from states) and
      migpuma_o in (select * from pumas);

-- Average income of those in NYC-Newark metro area
with states as (
 select distinct fips_state_code
 from msa_delineation_2018
 where CSA_Code = 408),
 pumas as (
 select distinct pw_puma00_migpuma1
 from msa_delineation_2018, census_puma_relation, puma_to_powpuma_relation
 where CSA_Code = 408 and
       st = fips_state_code and
       county = fips_county_code and
       puma_to_powpuma_relation.puma = puma_5ce
)
select round(sum(person_weight * total_persons_income) / sum(person_weight), 2)
       as avg_income
from df1
where state     in (select * from states) and
      migpuma_o in (select * from pumas);

-- Get immigration status of individuals in top 10 metro areas
with states as (
 select distinct fips_state_code
 from msa_delineation_2018
 where CSA_Code in (408, 348, 176, 206, 288, 548, 428, 370, 122, 148)),
 pumas as (
 select distinct pw_puma00_migpuma1
 from msa_delineation_2018, census_puma_relation, puma_to_powpuma_relation
 where CSA_Code in (408, 348, 176, 206, 288, 548, 428, 370, 122, 148) and
       st = fips_state_code and
       county = fips_county_code and
       puma_to_powpuma_relation.puma = puma_5ce
)
select case when citizenship_status = '1' then 'Born in U.S. state or D.C.'
            when citizenship_status = '2' then 'Born in Puerto Rico, Guam, the U.S. Virgin
                                                Islands, or the Northern Marianas'
            when citizenship_status = '3' then 'Born abroad of American parent(s)'
            when citizenship_status = '4' then 'U.S. citizen by naturalization'
            when citizenship_status = '5' then 'Not a U.S. citizen'
        end as citizenship,
sum(person_weight)
from df1
where state     in (select * from states) and
      migpuma_o in (select * from pumas)
group by citizenship_status
order by sum(person_weight) desc;

-- Get immigration status of individuals in NYC-Newark metro area
with states as (
 select distinct fips_state_code
 from msa_delineation_2018
 where CSA_Code = 408),
 pumas as (
 select distinct pw_puma00_migpuma1
 from msa_delineation_2018, census_puma_relation, puma_to_powpuma_relation
 where CSA_Code = 408 and
       st = fips_state_code and
       county = fips_county_code and
       puma_to_powpuma_relation.puma = puma_5ce
)
select case when citizenship_status = '1' then 'Born in U.S. state or D.C.'
            when citizenship_status = '2' then 'Born in Puerto Rico, Guam, the U.S. Virgin
                                                Islands, or the Northern Marianas'
            when citizenship_status = '3' then 'Born abroad of American parent(s)'
            when citizenship_status = '4' then 'U.S. citizen by naturalization'
            when citizenship_status = '5' then 'Not a U.S. citizen'
        end as citizenship,
sum(person_weight)
from df1
where state     in (select * from states) and
      migpuma_o in (select * from pumas)
group by citizenship_status
order by sum(person_weight) desc;

-- Get immigration status of all top 10 metro areas, aggregated by metro area
-- and immigration status
with states as (
 select distinct fips_state_code, CSA_Code
 from msa_delineation_2018
 where CSA_Code in (408, 348, 176, 206, 288, 548, 428, 370, 122, 148)),
 pumas as (
 select distinct pw_puma00_migpuma1
 from msa_delineation_2018, census_puma_relation, puma_to_powpuma_relation
 where CSA_Code in (408, 348, 176, 206, 288, 548, 428, 370, 122, 148) and
       st = fips_state_code and
       county = fips_county_code and
       puma_to_powpuma_relation.puma = puma_5ce
)
select case when citizenship_status = '1' then 'Born in U.S. state or D.C.'
            when citizenship_status = '2' then 'Born in Puerto Rico, Guam, the U.S. Virgin
                                                Islands, or the Northern Marianas'
            when citizenship_status = '3' then 'Born abroad of American parent(s)'
            when citizenship_status = '4' then 'U.S. citizen by naturalization'
            when citizenship_status = '5' then 'Not a U.S. citizen'
       end as citizenship,
       case when csa_code = 408 then 'New York-Newark-Jersey City'
            when csa_code = 348 then 'Los Angeles-Long Beach-Anaheim'
            when csa_code = 176 then 'Chicago-Naperville-Elgin'
            when csa_code = 206 then 'Dallas-Fort Worth-Arlington'
            when csa_code = 288 then 'Houston-The Woodlands-Sugar Land'
            when csa_code = 548 then 'Washington-Arlington-Alexandria'
            when csa_code = 428 then 'Philadelphia-Camden-Wilmington'
            when csa_code = 370 then 'Miami-Fort Lauderdale-Pompano Beach'
            when csa_code = 122 then 'Atlanta-Sandy Springs-Alpharetta'
            when csa_code = 148 then 'Boston-Cambridge-Newton'
      end as metro_area,
sum(person_weight)
from df1, states
where state     = fips_state_code and
      migpuma_o in (select * from pumas)
group by citizenship_status, metro_area
order by metro_area, citizenship_status;

-- Get all LA-Long Beach-Anaheim -> LA-Long Beach-Anaheim Metro movements
with states as (
 select distinct fips_state_code
 from msa_delineation_2018
 where CSA_Code = 348
), pumas as (
 select distinct pw_puma00_migpuma1
 from msa_delineation_2018, census_puma_relation, puma_to_powpuma_relation
 where CSA_Code = 348 and
       st = fips_state_code and
       county = fips_county_code and
       puma_to_powpuma_relation.puma = puma_5ce
)
select sum(person_weight_sum), 'Los Angeles-Long Beach-Anaheim' as metro_area
from (select migpuma_o, migpuma_d, state, state_o,
      sum(person_weight) as person_weight_sum from df1
      group by state, migpuma_o, migpuma_d, state_o) sub_df1
where state in (select * from states) and
      state_o in (select * from states) and
      migpuma_o in (select * from pumas) and
      migpuma_d in (select * from pumas);
=> 4961.970 ms

-- Same query as above without CTEs
select sum(person_weight_sum), 'Los Angeles-Long Beach-Anaheim' as metro_area
from (select migpuma_o, migpuma_d, state, state_d,
      sum(person_weight) as person_weight_sum from df1
      group by state, migpuma_o, migpuma_d, state_d) sub_df1
where state in (select distinct fips_state_code
                from msa_delineation_2018
                where CSA_Code = 348) and
      state_d in (select distinct fips_state_code
                  from msa_delineation_2018
                  where CSA_Code = 348) and
      migpuma_o in (select distinct pw_puma00_migpuma1
                    from msa_delineation_2018, census_puma_relation, puma_to_powpuma_relation
                    where CSA_Code = 348 and
                    st = fips_state_code and
                    county = fips_county_code and
                    puma_to_powpuma_relation.puma = puma_5ce) and
      migpuma_d in (select distinct pw_puma00_migpuma1
                    from msa_delineation_2018, census_puma_relation, puma_to_powpuma_relation
                    where CSA_Code = 348 and
                    st = fips_state_code and
                    county = fips_county_code and
                    puma_to_powpuma_relation.puma = puma_5ce);
=> 5135.911 ms

-- Same as before but without distinct
select sum(person_weight_sum), 'Los Angeles-Long Beach-Anaheim' as metro_area
from (select migpuma_o, migpuma_d, state, state_d,
      sum(person_weight) as person_weight_sum from df1
      group by state, migpuma_o, migpuma_d, state_d) sub_df1
where state in (select fips_state_code
                from msa_delineation_2018
                where CSA_Code = 348) and
      state_d in (select fips_state_code
                  from msa_delineation_2018
                  where CSA_Code = 348) and
      migpuma_o in (select pw_puma00_migpuma1
                    from msa_delineation_2018, census_puma_relation, puma_to_powpuma_relation
                    where CSA_Code = 348 and
                    st = fips_state_code and
                    county = fips_county_code and
                    puma_to_powpuma_relation.puma = puma_5ce) and
      migpuma_d in (select pw_puma00_migpuma1
                    from msa_delineation_2018, census_puma_relation, puma_to_powpuma_relation
                    where CSA_Code = 348 and
                    st = fips_state_code and
                    county = fips_county_code and
                    puma_to_powpuma_relation.puma = puma_5ce);
=> 5162.164 ms

select substr(serial_no, 1, 4) as year, age, person_number, person_weight,
       migpuma_o, migpuma_d
from df1
where migpuma_o in
(select distinct  from census_puma_relation where cast(st as text) || '-' || cast(county as text) in
 (select distinct cast(FIPS_State_Code as text) || '-' || cast(FIPS_County_Code as text) from msa_delineation_2018
  where CSA_Code = 408))
  and
  cast(migpuma_d as integer) in
(select distinct cast(st || right('00000' || cast(puma_5ce as text),5) as integer) from census_puma_relation where cast(st as text) || '-' || cast(county as text) in
 (select distinct cast(FIPS_State_Code as text) || '-' || cast(FIPS_County_Code as text) from msa_delineation_2018
  where CSA_Code = 408));
--end debug

select migpuma_o, person_weight, 'Los Angeles-Long Beach-Anaheim' as metro_area
from df1
where migpuma_o
in
(select '060' || cast(pw_puma00_migpuma1 as text) as e from puma_to_powpuma_relation where res_state = 6 and puma = 5905);


-- Start Puerto Rico Queries
-- Query 1: All records from P.R. to U.S. states & Washington D.C.
select *
from df1, health_info
where state_o   =  state_code_to_num('PR') and
      df1.state <> state_code_to_num('PR') and
      df1.serial_no = health_info.serial_no         and
      df1.person_number = health_info.person_number and
      df1.state = health_info.state;
-- Query 2: All records from U.S. states & Washington D.C. to P.R.
select *
from df1, health_info
where state_o   <> state_code_to_num('PR')          and
      df1.state =  state_code_to_num('PR')          and
      df1.serial_no = health_info.serial_no         and
      df1.person_number = health_info.person_number and
      df1.state = health_info.state;
-- End Puerto Rico Queries


-- If this works then update other sql file
alter table df1 add column state_d numeric(2, 0);
update df1 set state_d = substring(migpuma_d, 1, 2)::numeric(2,0);

-- Need to test
alter table df1 alter column migpuma_d type integer using substring(migpuma_d, 3)::int;
alter table df1 alter column migpuma_o type integer using substring(migpuma_o, 3)::int;
