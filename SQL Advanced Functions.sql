-- WHERE clause based on name
Select * from Parks_and_Recreation.employee_salary where first_name ='Leslie';
-- WHERE clause based on number
select * from Parks_and_Recreation.employee_salary where salary>50000;
-- WHERE clause with not condition
Select * from Parks_and_Recreation.employee_demographics where gender!='Female';
-- Where clause with Date condition
Select * from Parks_and_Recreation.employee_demographics where birth_date>'1985-01-01';


-- Logical operators

-- AND born after the given date will show up as result
-- Only Males 
Select * from Parks_and_Recreation.employee_demographics where birth_date>'1985-01-01' and gender='male';

-- OR
-- All Men will be shown and only the women born after 1st Jan 1985 will be shown
Select * from Parks_and_Recreation.employee_demographics where birth_date>'1985-01-01' or gender='male';

-- OR NOT
-- All women will be shown and only the men born after 1st Jan 1985 will be shown
Select * from Parks_and_Recreation.employee_demographics where birth_date>'1985-01-01' or not gender='male';

-- AND in Parenthesis with OR condition
-- Only the records satisfying the conditions in Parnethesis will be displayed and the record meeting the condition Age>50 will be displayed.
Select * from Parks_and_Recreation.employee_demographics where (first_name ='Tom' and age =36) or Age >50;


-- Like Statement
-- % means anything stating or ending with charachters including the ones mentioned will be displayed. Depends on location of % whether it is preceeding or following the input.
-- ___ any record with only the specified number of charachters will be displayed.

Select * from Parks_and_Recreation.employee_demographics where first_name like 'T%';
Select * from Parks_and_Recreation.employee_demographics where first_name like 'A___%';
Select * from Parks_and_Recreation.employee_demographics where birth_date like '196%';


-- Grouping records
-- To display average age of males and females
Select gender, avg(age) from Parks_and_Recreation.employee_demographics group by gender;

-- Average salary according to Job
Select occupation, avg(salary) from Parks_and_Recreation.employee_salary group by occupation;

-- To check if all roles pay the same amount
Select occupation, salary from Parks_and_Recreation.employee_salary group by occupation, salary;

-- Order BY
-- Order by: to get the smallest to largest salary of roles
Select occupation, salary from Parks_and_Recreation.employee_salary group by occupation, salary order by salary;

-- To get a list of people in city according to age
select * from Parks_and_Recreation.employee_demographics order by age, gender;

-- List of people in both genders along with their average age
select gender, Avg(age) from Parks_and_Recreation.employee_demographics group by gender;

-- Having and Where

-- Having is used to filter on top of aggregated function
select Occupation, Avg(salary) from Parks_and_Recreation.employee_salary where occupation like'%manager%' group by occupation having AVG (salary)>40000;

-- Limit: used to limit the number of results shown
-- Select top 5 oldest employeed
Select * from Parks_and_Recreation.employee_demographics order by age desc limit 5;


--  Aliasing
-- Selecting the column name as desired result. In this case we are obtaining the average age as a result. Using the aliasing function we can rename the column name on run. 
Select gender, avg(age)as avg_age from Parks_and_Recreation.employee_demographics group by gender having avg(age)>35;

-- Join
-- Inner join- Pulls up data for all the column but only rows having same data.
Select * from Parks_and_Recreation.employee_demographics as dem inner join Parks_and_Recreation.employee_salary as sal on dem.employee_id= sal.employee_id;

-- We need to make use of table name for the columns available in both tables
Select dem. employee_id, age, occupation from Parks_and_Recreation.employee_demographics as dem inner join Parks_and_Recreation.employee_salary as sal on dem.employee_id= sal.employee_id;

-- Left Join: takes data for all records in left table
Select * from Parks_and_Recreation.employee_demographics as dem left join Parks_and_Recreation.employee_salary as sal on dem.employee_id= sal.employee_id;
-- Right Join takes data for all records in right table-- In above cases employee ID 2 was missing here the available data is shown for employee ID 2
Select * from Parks_and_Recreation.employee_demographics as dem Right join Parks_and_Recreation.employee_salary as sal on dem.employee_id= sal.employee_id;

-- Self Join
-- Tie the table to itself
-- Use case example organization wants to perform secret santa first 3 columns highlight the secret santa details
select emp1.employee_id as emp_santa, emp1.first_name as first_name_santa, emp1.last_name as last_name_santa, emp2.employee_id, emp2.first_name, emp2.last_name from Parks_and_Recreation.employee_salary emp1
join Parks_and_Recreation.employee_salary emp2
on emp1.employee_id + 4 = emp2.employee_id;


-- Joining multiple tables together
-- Here we combine demographic, salary and department tables to get all tables in a single screen
select * from Parks_and_Recreation.employee_demographics as dem
inner join Parks_and_Recreation.employee_salary as sal
on dem.employee_id= sal.employee_id
inner join Parks_and_Recreation.Parks_departments pd
on sal.dept_id= pd.department_id;

-- Unions
-- union all and union distinct can be used to stack the data from multiple tables. Union all includes duplicates and Union distinct will remove the duplicates.
select first_name, last_name from Parks_and_Recreation.employee_demographics
union distinct
select first_name, last_name from Parks_and_Recreation.employee_salary;


-- Union and Labels
-- An organization wants to find out the gender of old employees and the high paid employees

Select first_name, last_name, 'Old Man' as Label
from Parks_and_Recreation.employee_demographics
where age> 45 and gender = 'Male'
union
select first_name, last_name, 'Old Lady' as Label
from Parks_and_Recreation.employee_demographics
where age> 45 and gender ='Female'
union
select first_name, last_name, 'Highly Paid Employee' as Label
from Parks_and_Recreation.employee_salary
where salary>70000
order by first_name, last_name;



-- String functions

-- Length- can be used to find out if all mobile numbers entered ate having 10 digits

Select first_name, length(first_name) as len
from Parks_and_Recreation.employee_demographics
order by len desc;


-- Upper case and lower case functions- can be used to standardize name data

select upper(first_name) as Name from Parks_and_Recreation.employee_demographics order by Name;


-- Trim and ltrim, rtrim - help in removing leading and trailing spaces

select trim(      'sky'       );

-- Left, Right- Selecting limited charachter from a column
Select left(first_name, 4) from Parks_and_Recreation.employee_demographics;


-- Substring- Helps select specific position data
-- Example select birth date for the employees

select first_name, birth_date, substring(birth_date, 9,10) as Date_of_Month from Parks_and_Recreation.employee_demographics;


-- Replace- replace specific data with other data
Select first_name, replace(first_name, 'o', 'P') from Parks_and_Recreation. employee_demographics;


-- Locate- get the position of data within a column
select first_name, locate('An', first_name) from Parks_and_Recreation.employee_demographics;

-- Concat- combine multiple columns

Select concat(first_name, ' ', last_name) as Full_Name from Parks_and_Recreation.employee_demographics; 


-- Case Statements- Helps classify data
-- example if a company needs to provide a raise and bonous as below
-- salary <40000= 5% raise
-- salary >=40000=7% raise
-- Finance department gets 10% bonous

select first_name, last_name, salary, dept_id, 
 
case
	when salary <40000 then salary + (salary*0.05)
    when salary >=40000 then salary + (salary*0.07)
end as Salary,
case
	when employee_salary.dept_id='6' then (salary*0.1)
end as Bonous

from Parks_and_Recreation.employee_salary;


-- Sub queries
-- We can only retrieve one column from a sub query


select * from Parks_and_Recreation.employee_demographics
where employee_id in 
				(select employee_id
					from Parks_and_Recreation.employee_salary
                    where dept_id =1);



-- Compare salary of each employee with the average salary

select first_name, salary,
(select avg(salary) from Parks_and_Recreation.employee_salary)
from Parks_and_Recreation.employee_salary;

-- Sub queries and aggeragate functions
-- useing as to rename columns can make it easier to select the columns
select gender, avg(`max(age)`) from
(select gender, avg(age), max(age), min(age), count(age)
from Parks_and_Recreation.employee_demographics
group by gender) as agg_table
group by gender;


-- Window functions
-- Partition by is similar to group by but each line item shows the output value
-- This can be used when we need to apply aggregate fuinction but need some other
-- outpou according to the line items

select dem.first_name, dem.last_name, gender, salary, sum(salary) over(partition by gender order by dem.employee_id) as rolling_total
from Parks_and_Recreation.employee_demographics dem
join employee_salary sal
	on dem.employee_id=sal.employee_id
    ;
    
-- Row num using over and partition by will divide the data according to the gender
-- Rank_num will show duplicate rank for values having same amount, but it will skip the next rank.
-- Dense_rank will have duplicate rank for values having same data but it will not skip the next rank

select dem.employee_id, dem.first_name, dem.last_name, gender, salary,
row_number() over(partition by gender order by salary desc) as row_num,
rank() over(partition by gender order by salary desc) rank_num,
dense_rank() over (Partition by gender order by salary desc) sense_rank_num
from Parks_and_Recreation.employee_demographics dem
join Parks_and_Recreation.employee_salary sal
	on dem.employee_id=sal.employee_id;


-- CTE- Common table expression- creates a subquery block that can be referred in the main query
-- Can be used only immidiately after creating
with CTE_Example AS
(
select gender, avg(salary) avg_sal, max(salary) max_sal, min(salary) min_sal, count(salary) count_sal
from Parks_and_Recreation.employee_demographics dem
join Parks_and_Recreation.employee_salary sal
	on dem.employee_id=sal.employee_id
group by gender
)

select avg(avg_sal)
from CTE_Example
;
    
-- CTE example 2

with CTE_Example2 AS
(
select employee_id, gender, birth_date
from Parks_and_Recreation.employee_demographics
where birth_date > '1985-01-01'
),
CTE_Example3 as
(
select employee_id, salary
from Parks_and_Recreation.employee_salary
where salary>50000
)
select *
from CTE_Example2
join CTE_Example3
	on CTE_Example2.employee_id=CTE_Example3.employee_id;
    
    
-- Temporary tables- Lasts only as long as we are within the session

Create temporary table temp_table
(
first_name varchar(50),
last_name varchar(50),
favourite_movie varchar(100)
);

select * from temp_table;

insert into temp_table
values('Naman','Vasudeva','Jab Harry Met Sejal');

select * from temp_table;

create temporary table salary_over_50k
Select *
from employee_salary
where salary>=5000;

select * from salary_over_50K;

-- Stored Procedure: sasved code that can be used again and again(repititive code)

Create procedure large_salaries()
select * 
from Parks_and_Recreation.employee_salary
where salary >=50000;

call large_salaries();

delimiter $$
Create procedure large_salaries3()
begin
	select *
    from Parks_and_Recreation.employee_salary
    where salary  >=50000;
    select * 
    from Parks_and_Recreation.employee_salary
    where salary >= 10000;
end $$
delimiter ;


call large_salaries3();



-- Creating parameters for Stored Procedures
delimiter $$
Create procedure large_salaries4(p_employee_id int)
begin
	select salary
    from Parks_and_Recreation.employee_salary
    where employee_id=p_employee_id;
end $$
delimiter ;


call large_salaries4(2);



-- Triggers and events in SQL
-- We want to update emp demographic when emp salary is updated.

Delimiter $$
create trigger employee_insert
	after insert on employee_salary
    for each row
begin
	insert into employee_demographics (employee_id, first_name, last_name)
    values (new.employee_id, new.first_name, new.last_name);
end $$
delimiter ;

insert into employee_salary (employee_id, first_name, last_name, occupation, salary, dept_id)
values(13, 'Jean-Ralphio', 'Saperstein', 'Exntertainment 720 CEO', 1000000, NULL);

-- Same data gets inserted into demograohic table due to use of triggers.
Select * from employee_demographics;

-- Events

Select * from employee_demographics;

Delimiter $$
create event delete_retirees
on schedule every 30 second
do
begin
	delete
    from employee_demographics
    where age>=60;
end $$
delimiter ;

show variables like 'event%';