
GO

-- Create a new database called 'DatabaseName'
-- Connect to the 'master' database to run this snippet
USE master
GO
-- Create the new database if it does not exist already
IF NOT EXISTS (
    SELECT name
        FROM sys.databases
        WHERE name = 'SP_Sales'
)
CREATE DATABASE SP_Sales
GO
--------*********************************----------
USE SP_Sales

CREATE TABLE Orders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerName VARCHAR(100),
    OrderDate DATE,
    Amount DECIMAL(10,2),
    Status VARCHAR(20)
);

GO 

INSERT INTO Orders (CustomerName, OrderDate, Amount, Status)  
VALUES  
    ('Alice', '2024-02-20', 150.00, 'Pending'),  
    ('Bob', '2024-02-21', 200.00, 'Shipped'),  
    ('Charlie', '2024-02-22', 50.00, 'Delivered'),  
    ('David', '2024-02-23', 300.00, 'Pending'),  
    ('Eve', '2024-02-24', 500.00, 'Shipped');  

SELECT * FROM Orders


--** Get All Orders **--

-- Create the stored procedure in the specified schema
CREATE PROCEDURE GetOrders
AS
BEGIN

    SELECT *
    FROM Orders

END

EXECUTE GetOrders


--** Fetch Orders by Status **--
CREATE PROCEDURE FetchOrdersbyStatus 
@Status VARCHAR(30)
AS
BEGIN

    SELECT *
    FROM Orders
    WHERE [Status] = @Status

END

EXECUTE FetchOrdersbyStatus 'Pending'





