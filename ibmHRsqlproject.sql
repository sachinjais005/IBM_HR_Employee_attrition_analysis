select *from ibmHR;

/*Total Employees*/
select count(*) as total_employees
from ibmHR;

select distinct Department from ibmHR;
--Attrition Count
select Attrition, count(*) as total from ibmHR
group by Attrition;
--Attrition Rate (%)
select round( 100.0*
 sum(case when Attrition='yes' then 1 else 0 end)/ count(*),2)
as attrition_rate;

--Average Monthly Income by Department
SELECT Department,
avg(MonthlyIncome) as avg_salary
from ibmHR
group by Department
order by avg_salary desc;
--Employee Count by Department
select Department,
count(*) as employees
from ibmHR
group by Department
order by employees desc;
--Average Age
select avg (Age) as average_age
from ibmHR;

--Gender Distribution
select Gender,
count(*) as total from ibmHR group by Gender;

--Job Role Wise Employees
select JobRole,
count(*) as total from ibmHR
group by JobRole
order by total desc;

--Highest Salary Employees
select EmployeeNumber,
JobRole, MonthlyIncome from ibmHR
order by MonthlyIncome desc limit 10;

--Employees Doing Overtime
select OverTime,
count(*) as total from ibmHR group by  OverTime;

--Attrition by Department
select Department,
count(*) as attrition_count
from ibmHR
where Attrition = 'yes' group by Department;

--Average Years at Company
select avg(YearsAtCompany) as avg_years
from ibmHR;

--Top 5 Highest Paid Departments
select Department,
Avg(MonthlyIncome) as avg_salary from ibmHR
group by Department 
order  by avg_salary desc
limit 5;

--Employees with More Than 10 Years Experience
select EmployeeNumber,
Age,
TotalWorkingYears
from ibmHR
where TotalWorkingYears >10;

--Job Satisfaction Analysis
select JobSatisfaction,
count(*) as employees 
from ibmHR
group by JobSatisfaction
order by JobSatisfaction;

--Interview Level Query
select Department,
round(avg(MonthlyIncome),2) as avg_salary,
count(*) as employees,
round(avg(JobSatisfaction),2) as avg_job_satisfaction 
from ibmHR
group by Department
order by avg_salary desc



with SalaryCTE as
(
select Department,
avg(MonthlyIncome) AvgSalary
from ibmHR
group by Department
)
select * from salaryCTE
where AvgSalary>6000;


select EmployeeNumber,
MonthlyIncome
from ibmHR
where MonthlyIncome>
(
select avg(MonthlyIncome)
from ibmHR  
);

select EmployeeNumber,
Department,
JobRole,
JobSatisfaction from ibmHR
where OverTime='Yes' 
and JobSatisfaction<=2;


--Employees earning above average salary
select EmployeeNumber,
JobRole,
MonthlyIncome
from ibmHR
where MonthlyIncome>(
select avg(MonthlyIncome) from ibmHR);

--Salary Band Analysis
SELECT
CASE
WHEN MonthlyIncome<5000 THEN 'Low'
WHEN MonthlyIncome BETWEEN 5000 AND 10000 THEN 'Medium'
ELSE 'High'
END AS SalaryBand,
COUNT(*) AS Employees
FROM ibmhr
GROUP BY SalaryBand;


--Department having more than 200 employees 
select Department,
count(*) as TotalEmployees
from ibmHR
group by Department
having count(*) >200;

--Average salary by Job Role
select JobRole ,
Round(avg(MonthlyIncome),2) as AvgSalary
from ibmHR
group by JobRole
order by AvgSalary desc;

--Highest salary in each Department
select Department,
max(MonthlyIncome) as HighestSalary
from ibmHR
group by Department;


--Lowest salary in each Department
select Department,
min(MonthlyIncome) as HighestSalary
from ibmHR
group by Department;


--Married employees with Overtime
select  EmployeeNumber,
MaritalStatus, OverTime from ibmHR
where maritalStatus='Married'
and OverTime='Yes';


--Employees with Job Satisfaction 4
select EmployeeNumber,
JobRole, JobSatisfaction
from ibmHR
where JobSatisfaction=4;


--Count employees by Education Field
SELECT EducationField,
       COUNT(*) AS Employees
FROM ibmhr
GROUP BY EducationField
ORDER BY Employees DESC;

--Top 10% Highest Paid Employees
SELECT *
FROM
(
SELECT EmployeeNumber,
       Department,
       MonthlyIncome,
       NTILE(10) OVER(ORDER BY MonthlyIncome DESC) AS SalaryGroup
FROM ibmhr
) t
WHERE SalaryGroup=1;


--Salary Category using CASE
select EmployeeNumber,
MonthlyIncome,
case 
when MonthlyIncome>=15000 then 'High' 
when MonthlyIncome>=8000 then 'Medium'
else 'low'
end as SalaryCategory
from ibmHR;

--Average Years at Company by Department
select Department,
round(avg(YearsAtCompany),2)as AvgYears
from ibmHR
Group by Department
order by AvgYears desc;

--Top 5 Job Roles with Highest Attrition
select JobRole,
count(*) as AttritionCount
from ibmHR
where Attrition='Yes'
group by JobRole
order by AttritionCount desc
limit 5;


--Employees working Overtime with Low Job Satisfaction
select EmployeeNumber,
Department,
JobRole,
JobSatisfaction
from ibmHR
where OverTime ='Yes' and JobSatisfaction<=2;


--Salary Difference from Department Average
select EmployeeNumber,
Department,
MonthlyIncome,
MonthlyIncome-avg(MonthlyIncome)
over(Partition by Department) as Difference
from ibmHR;

--Previous Employee Salary (LAG)
select EmployeeNumber,
MonthlyIncome,
lag(MonthlyIncome) 
over(order by MonthlyIncome) as PreviousSalary
from ibmHR;

--Department with Highest Average Performance Rating
SELECT Department,
       ROUND(AVG(PerformanceRating),2) AS AvgPerformance
FROM ibmhr
GROUP BY Department
ORDER BY AvgPerformance DESC;

--Next Employee Salary (LEAD)
select EmployeeNumber,
MonthlyIncome,
lead(MonthlyIncome)
over(order by MonthlyIncome) as NextSalary
from ibmHR;

--Salary Difference with Previous Employee
select EmployeeNumber,
MonthlyIncome,
MonthlyIncome-lag(MonthlyIncome)
over(order by MonthlyIncome) as Difference
from ibmHR;

--Top 3 Highest Paid Employees in Each Department
select*from(
select EmployeeNumber,
Department,
JobRole,
MonthlyIncome,
Row_number() over(
partition by Department
order by MonthlyIncome desc) as rn
from ibmHR) where rn<=3;
)

--Create a View
CREATE VIEW HighSalaryEmployees AS
SELECT EmployeeNumber,
       Department,
       JobRole,
       MonthlyIncome
FROM ibmHR
WHERE MonthlyIncome > 10000;
)

--Show View Data
SELECT *
FROM HighSalaryEmployees;


/*Employees having Maximum Salary in each Department*/
select EmployeeNumber,
Department,
MonthlyIncome
from ibmHR i where MonthlyIncome=(select max(MonthlyIncome)
from ibmHR
where Department=i.Department);

--Employees with No Overtime and High Job Satisfaction
SELECT EmployeeNumber,
       Department,
       JobSatisfaction
FROM ibmHR
WHERE OverTime='No'
AND JobSatisfaction=4;

/*Average Job Satisfaction by Department*/
select Department,
round(avg(JobSatisfaction),2) as AvgJobSatisfaction
from ibmHR
group by Department
Order by AvgJobSatisfaction desc;


/*Employees with Low Environment Satisfaction*/

SELECT EmployeeNumber,
       Department,
       EnvironmentSatisfaction
FROM ibmHR
WHERE EnvironmentSatisfaction <= 2;


/*Employees with High Performance Rating*/

SELECT EmployeeNumber,
       Department,
       PerformanceRating
FROM ibmhr
WHERE PerformanceRating = 4;


/*Employees who never got Promotion*/
SELECT EmployeeNumber,
       Department,
       YearsSinceLastPromotion
FROM ibmHR
WHERE YearsSinceLastPromotion = 0;

/*Employees with Highest Total Working Years*/

SELECT EmployeeNumber,
       JobRole,
       TotalWorkingYears
FROM ibmHR
ORDER BY TotalWorkingYears DESC
LIMIT 10;
--Employees Eligible for Promotion
SELECT EmployeeNumber,
       JobRole,
       YearsAtCompany,
       PerformanceRating
FROM ibmhr
WHERE YearsAtCompany>=5
AND PerformanceRating=4;
--Average Monthly Income by Gender and Department
SELECT Department,
       Gender,
       ROUND(AVG(MonthlyIncome),2) AS AvgSalary
FROM ibmHR
GROUP BY Department, Gender
ORDER BY Department;

/*HR Dashboard Summary*/
SELECT
COUNT(*) AS TotalEmployees,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS AttritionEmployees,
ROUND(AVG(MonthlyIncome),2) AS AvgSalary,
ROUND(AVG(Age),2) AS AvgAge,
ROUND(AVG(JobSatisfaction),2) AS AvgJobSatisfaction
FROM ibmHR;

select*from ibmHR;