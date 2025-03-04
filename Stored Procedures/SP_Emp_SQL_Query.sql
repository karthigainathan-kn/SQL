create database sp_emp

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(100),
    Department VARCHAR(50),
    Salary DECIMAL(10, 2),
    JoiningDate DATE
);
INSERT INTO Employees VALUES
(1, 'Alice', 'HR', 50000, '2020-01-15'),
(2, 'Bob', 'Finance', 60000, '2021-05-10'),
(3, 'Charlie', 'IT', 70000, '2019-07-20'),
(4, 'Diana', 'Marketing', 55000, '2022-03-05'),
(5, 'Eve', 'IT', 80000, '2020-11-22');

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50),
    Location VARCHAR(50)
);

INSERT INTO Departments VALUES
(1, 'HR', 'New York'),
(2, 'Finance', 'San Francisco'),
(3, 'IT', 'Austin'),
(4, 'Marketing', 'Los Angeles');

CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(100),
    DepartmentID INT,
    Budget DECIMAL(10, 2),
    StartDate DATE,
    EndDate DATE
);

INSERT INTO Projects VALUES
(101, 'Website Redesign', 3, 200000, '2023-01-01', '2023-06-30'),
(102, 'Employee Training', 1, 50000, '2023-03-01', '2023-04-30'),
(103, 'Market Analysis', 4, 100000, '2023-02-01', '2023-07-31'),
(104, 'Financial Audit', 2, 75000, '2023-05-01', '2023-09-30');


--1.Fetch employees by department:Write a stored procedure that takes a department name as input and returns all employees in that department.

CREATE PROCEDURE GetEmployeesByDept
@Departmentname nvarchar(50)

AS
BEGIN

SELECT
    EmployeeID,
    Name,
    Department,
    Salary,
    JoiningDate
FROM Employees
WHERE Department = @Departmentname

END

EXEC GetEmployeesByDept @Departmentname =  'IT'



--2.Update employee salary:Create a stored procedure to increase the salary of an employee by a given percentage.

CREATE PROCEDURE UpdateEmployeeSalary

@EmployeeID INT,
@PercentageIncrease FLOAT

AS
BEGIN

Update Employees
SET  Salary = Salary + (Salary * @PercentageIncrease/100)
WHERE EmployeeID = @EmployeeID

END

EXEC UpdateEmployeeSalary @EmployeeID = 2 , @PercentageIncrease = 10


--3.Insert a new project:Create a stored procedure to insert a new project into the Projects table.

select * from [dbo].[Projects]

ALTER PROCEDURE InsertNewProject

@ProjectId Int,
@ProjectName Varchar(100),
@DepartmentID Int,
@Budget Decimal(10,2),
@StartDate date,
@EndDate date

AS
BEGIN

INSERT INTO  Projects (ProjectId,ProjectName, DepartmentID, Budget, StartDate, EndDate)
VALUES (@ProjectId, @ProjectName, @DepartmentID, @Budget, @StartDate, @EndDate);

Print      'New project inserted successfully.';
END;

EXEC InsertNewProject
		@ProjectId = 105,
		@ProjectName = 'Website Dev',
		@DepartmentID = 5,
		@Budget = 80000.00,
		@StartDate = '2025-01-15',
		@EndDate = '2025-06-30';

    

--4.Retrieve department details:Write a procedure to fetch the location of a department by its name.

select * from [dbo].[Departments]


CREATE PROCEDURE GetLocationByDept
@Departmentname nvarchar(50)
AS
BEGIN

SELECT
    DepartmentID,
    DepartmentName,
    Location
FROM Departments
WHERE DepartmentName = @Departmentname

END

EXEC GetLocationByDept @Departmentname =  'Finance'


--5.Count employees:Write a stored procedure to count the total number of employees in a specific department.

CREATE PROCEDURE getemployeecountbylocation
@Departmentname nvarchar(50)

AS
BEGIN

SELECT 
Department,
Count(Name) AS Emp_Count
FROM [dbo].[Employees]
WHERE Department = @Departmentname
GROUP BY Department

END

EXEC getemployeecountbylocation @Departmentname = 'IT';



--6.Calculate average salary:Create a procedure that calculates and returns the average salary of employees in a specific department.

CREATE PROCEDURE getemployeeavgsalarybylocation
@Departmentname nvarchar(50)

AS
BEGIN 

SELECT Department, Round(AVG(Salary),2) AS avgsalary 
FROM [dbo].[Employees]
WHERE Department = @Departmentname
GROUP BY Department
END


EXEC getemployeeavgsalarybylocation @Departmentname = 'IT'
