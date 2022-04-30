-- Takes state number as input and returns respective state code
create or replace function state_num_to_code(state numeric(2)) returns text as $$
       select case
       when state = 01 then 'AL'
       when state = 02 then 'AK'
       when state = 04 then 'AZ'
       when state = 05 then 'AR'
       when state = 06 then 'CA'
       when state = 08 then 'CO'
       when state = 09 then 'CT'
       when state = 10 then 'DE'
       when state = 11 then 'DC'
       when state = 12 then 'FL'
       when state = 13 then 'GA'
       when state = 15 then 'HI'
       when state = 16 then 'ID'
       when state = 17 then 'IL'
       when state = 18 then 'IN'
       when state = 19 then 'IA'
       when state = 20 then 'KS'
       when state = 21 then 'KY'
       when state = 22 then 'LA'
       when state = 23 then 'ME'
       when state = 24 then 'MD'
       when state = 25 then 'MA'
       when state = 26 then 'MI'
       when state = 27 then 'MN'
       when state = 28 then 'MS'
       when state = 29 then 'MO'
       when state = 30 then 'MT'
       when state = 31 then 'NE'
       when state = 32 then 'NV'
       when state = 33 then 'NH'
       when state = 34 then 'NJ'
       when state = 35 then 'NM'
       when state = 36 then 'NY'
       when state = 37 then 'NC'
       when state = 38 then 'ND'
       when state = 39 then 'OH'
       when state = 40 then 'OK'
       when state = 41 then 'OR'
       when state = 42 then 'PA'
       when state = 44 then 'RI'
       when state = 45 then 'SC'
       when state = 46 then 'SD'
       when state = 47 then 'TN'
       when state = 48 then 'TX'
       when state = 49 then 'UT'
       when state = 50 then 'VT'
       when state = 51 then 'VA'
       when state = 53 then 'WA'
       when state = 54 then 'WV'
       when state = 55 then 'WI'
       when state = 56 then 'WY'
       when state = 72 then 'PR'
       else 'other'
       end
$$
language sql
immutable;

-- Takes state code as input and returns respective state number
create or replace function state_code_to_num(state varchar(2)) returns numeric(2) as $$
       select case
       when state = 'AL' then 01::numeric(2)
       when state = 'AK' then 02
       when state = 'AZ' then 04
       when state = 'AR' then 05
       when state = 'CA' then 06
       when state = 'CO' then 08
       when state = 'CT' then 09
       when state = 'DE' then 10
       when state = 'DC' then 11
       when state = 'FL' then 12
       when state = 'GA' then 13
       when state = 'HI' then 15
       when state = 'ID' then 16
       when state = 'IL' then 17
       when state = 'IN' then 18
       when state = 'IA' then 19
       when state = 'KS' then 20
       when state = 'KY' then 21
       when state = 'LA' then 22
       when state = 'ME' then 23
       when state = 'MD' then 24
       when state = 'MA' then 25
       when state = 'MI' then 26
       when state = 'MN' then 27
       when state = 'MS' then 28
       when state = 'MO' then 29
       when state = 'MT' then 30
       when state = 'NE' then 31
       when state = 'NV' then 32
       when state = 'NH' then 33
       when state = 'NJ' then 34
       when state = 'NM' then 35
       when state = 'NY' then 36
       when state = 'NC' then 37
       when state = 'ND' then 38
       when state = 'OH' then 39
       when state = 'OK' then 40
       when state = 'OR' then 41
       when state = 'PA' then 42
       when state = 'RI' then 44
       when state = 'SC' then 45
       when state = 'SD' then 46
       when state = 'TN' then 47
       when state = 'TX' then 48
       when state = 'UT' then 49
       when state = 'VT' then 50
       when state = 'VA' then 51
       when state = 'WA' then 53
       when state = 'WV' then 54
       when state = 'WI' then 55
       when state = 'WY' then 56
       when state = 'PR' then 72
       else -1
       end
$$
language sql
immutable;

-- Takes race (re)code as input and returns respective description
create or replace function race_code_to_explanation(race varchar(1))
returns text as $$
select case when race = '1' then 'White alone'
            when race = '2' then 'Black alone'
            when race = '3' then 'Native American alone'
            when race = '4' then 'Alaska Native alone'
            when race = '5' then 'Native American and Alaska Native tribes specified;
                                               or Native American or Alaska Native, not specified
                                               and no other races'
            when race = '6' then 'Asian alone'
            when race = '7' then 'Native Hawaiian and Other Pacific Islander alone'
            when race = '8' then 'Some Other Race alone'
            when race = '9' then 'Two or More Races'
            else 'Other'
        end
$$
language sql
immutable;


-- Takes employment status (re)code as input and returns respective description
create or replace function employment_code_to_explanation(emp varchar(1))
returns text as $$
select case when emp = '1' then 'Civilian employed at work'
            when emp = '2' then 'Civilian employed, with a job but not at work'
            when emp = '3' then 'Unemployed'
            when emp = '4' then 'Armed forces, at work'
            when emp = '5' then 'Armed forces, with a job but not at work'
            when emp = '6' then 'Not in labor force'
            else 'Other'
       end
$$
language sql
immutable;
