CREATE DATABASE PIVOTUNPIVOTDB
USE PIVOTUNPIVOTDB
 CREATE TABLE EMPLOYEESALES (EMPLOYEENAME VARCHAR(100), SALESMONTH VARCHAR(10), SALESAMOUNT INT)

 INSERT INTO EMPLOYEESALES  (EMPLOYEENAME,SALESMONTH,	SALESAMOUNT) VALUES
('Alice',		'Jan',	1200),
('Alice',		'Feb',	1100),
('Alice',		'Mar',	1400),
('Bob'	,		'Jan',	1600),
('Bob'	,		'Feb',	1300),
('Bob'	,		'Mar',	1700),
('Carol',		'Jan',	1400),
('Carol',		'Feb',	1200),
('Carol',		'Mar',	1600)

--1. Convert sales data to show total sales by each month:
SELECT EMPLOYEENAME, [Jan], [Feb], [Mar]
FROM (
    SELECT EMPLOYEENAME, SALESMONTH, SALESAMOUNT
    FROM EmployeeSales
) AS SourceTable
PIVOT (
    SUM(SALESAMOUNT)
    FOR SALESMONTH IN ([Jan], [Feb], [Mar])
) AS PivotTable;

--2. Convert sales data to show total sales by each employee:

SELECT SALESMONTH, [Alice], [Bob], [Carol]
FROM (
    SELECT EMPLOYEENAME, SALESMONTH, SalesAmount
    FROM EmployeeSales
) AS SourceTable
PIVOT (
    SUM(SalesAmount)
    FOR EMPLOYEENAME IN ([Alice], [Bob], [Carol])
) AS PivotTable;

--3. Pivot Sales with Dynamic Columns : Pivot sales data where months are dynamically determined:
DECLARE @cols AS NVARCHAR(MAX),
        @query AS NVARCHAR(MAX);

SET @cols = STUFF((SELECT DISTINCT ',' + QUOTENAME(SALESMONTH) 
                   FROM EmployeeSales 
                   FOR XML PATH(''), TYPE
                   ).value('.', 'NVARCHAR(MAX)') 
                   ,1,1,'');

SET @query = 'SELECT EMPLOYEENAME, ' + @cols + ' 
               FROM 
               (
                   SELECT EMPLOYEENAME, SALESMONTH, SalesAmount
                   FROM EmployeeSales
               ) AS SourceTable
               PIVOT 
               (
                   SUM(SalesAmount)
                   FOR SALESMONTH IN (' + @cols + ')
               ) AS PivotTable';

EXEC sp_executesql @query;

--4. Pivot to show average sales per month:

SELECT EMPLOYEENAME, [Jan], [Feb], [Mar]
FROM (
    SELECT EMPLOYEENAME, SALESMONTH, SalesAmount
    FROM EmployeeSales
) AS SourceTable
PIVOT (
    AVG(SalesAmount)
    FOR SALESMONTH IN ([Jan], [Feb], [Mar])
) AS PivotTable;

/**
CREATE TABLE Sales (
    Year INT,
    Month VARCHAR(10),
    SalesAmount DECIMAL(10, 2)
);

INSERT INTO Sales VALUES
(2023, 'January', 1000),
(2023, 'February', 1500),
(2023, 'March', 2000),
(2024, 'January', 1100),
(2024, 'February', 1600);
**/

SELECT
    Year,
    SUM(CASE WHEN Month = 'January' THEN SalesAmount ELSE 0 END) AS January_Sales,
    SUM(CASE WHEN Month = 'February' THEN SalesAmount ELSE 0 END) AS February_Sales,
    SUM(CASE WHEN Month = 'March' THEN SalesAmount ELSE 0 END) AS March_Sales
FROM Sales
GROUP BY Year;

--Example 2: Pivot with Aggregation

--CREATE TABLE EmployeeHours (
--    EmployeeID INT,
--    Week INT,
--    HoursWorked INT
--);

--INSERT INTO EmployeeHours VALUES
--(1, 1, 40),
--(1, 2, 38),
--(2, 1, 35),
--(2, 2, 42);

SELECT
    EmployeeID,
    SUM(CASE WHEN Week = 1 THEN HoursWorked ELSE 0 END) AS Week_1_Hours,
    SUM(CASE WHEN Week = 2 THEN HoursWorked ELSE 0 END) AS Week_2_Hours
FROM EmployeeHours
GROUP BY EmployeeID;

--Example 3: Pivot with Multiple Categories
CREATE TABLE ProductSales (
    Product VARCHAR(20),
    Region VARCHAR(20),
    SalesAmount DECIMAL(10, 2)
);

INSERT INTO ProductSales VALUES
('ProductA', 'North', 500),
('ProductA', 'South', 600),
('ProductB', 'North', 700),
('ProductB', 'South', 800);

SELECT
    Product,
    SUM(CASE WHEN Region = 'North' THEN SalesAmount ELSE 0 END) AS North_Sales,
    SUM(CASE WHEN Region = 'South' THEN SalesAmount ELSE 0 END) AS South_Sales
FROM ProductSales
GROUP BY Product;


--Example 4: Pivot with Different Aggregation Functions

CREATE TABLE MonthlyExpenditures (
    Department VARCHAR(20),
    Month VARCHAR(10),
    Expenditure DECIMAL(10, 2)
);

INSERT INTO MonthlyExpenditures VALUES
('HR', 'January', 2000),
('HR', 'February', 1800),
('IT', 'January', 3000),
('IT', 'February', 3200);

SELECT
    Department,
    SUM(CASE WHEN Month = 'January' THEN Expenditure ELSE 0 END) AS Total_January_Expenditure,
    AVG(CASE WHEN Month = 'February' THEN Expenditure ELSE NULL END) AS Average_February_Expenditure
FROM MonthlyExpenditures
GROUP BY Department;

--  Example 5: Pivot with Dynamic Categories
CREATE TABLE StudentScores (
    StudentID INT,
    Subject VARCHAR(20),
    Score INT
);
INSERT INTO StudentScores VALUES
(1, 'Math', 85),
(1, 'Science', 90),
(2, 'Math', 78),
(2, 'Science', 88);

SELECT
    StudentID,
    SUM(CASE WHEN Subject = 'Math' THEN Score ELSE 0 END) AS Math_Score,
    SUM(CASE WHEN Subject = 'Science' THEN Score ELSE 0 END) AS Science_Score
FROM StudentScores
GROUP BY StudentID;

-- UNPIVOTING
CREATE TABLE MONTHLYSALES (
    YEAR INT,
    JANUARY DECIMAL(10, 2),
    FEBRUARY DECIMAL(10, 2),
    MARCH DECIMAL(10, 2)
);

INSERT INTO MONTHLYSALES VALUES
(2023, 1000, 1500, 2000),
(2024, 1100, 1600, 0);
SELECT * FROM MONTHLYSALES
SELECT
    YEAR,
    MONTH,
    SALESAMOUNT
FROM
    MONTHLYSALES
UNPIVOT (
    SALESAMOUNT FOR MONTH IN (JANUARY, FEBRUARY, MARCH)
) AS UNPIVOTED;
