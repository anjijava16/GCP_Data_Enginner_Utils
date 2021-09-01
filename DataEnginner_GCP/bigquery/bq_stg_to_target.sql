## Create DDL 
create table welcome.welcome_test(
country string,
age int64,
salary int64,
purchased string
ts Datetime)


## Create DDL From exising table 
create table `iwinner-data-318822.welcome.welcome_target` as SELECT * FROM `iwinner-data-318822.welcome.welcome_test` LIMIT 0

## Insert from STG to Target Table 
INSERT INTO welcome.welcome_target
(age,salary,ts,country,purchased) 
select age,salary,ts,country,purchased from 
`iwinner-data-318822.welcome.welcome_test`



