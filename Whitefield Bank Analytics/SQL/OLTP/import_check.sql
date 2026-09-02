use WhitefieldBankDB

SELECT
'Branches' AS TableName,
COUNT(*) AS Records
FROM Branches

SELECT
'Transactions',
COUNT(*)
FROM Transactions

SELECT
'Transactions',
COUNT(*)
FROM Transactions


BULK INSERT Repayments
FROM 'C:\Users\Bharath Venkatesh\Downloads\Whitefield Bank\raw\Repayments.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0A',
    TABLOCK,
    BATCHSIZE = 50000,
    MAXERRORS = 10
);

SELECT COUNT(*) AS TotalRows
FROM Repayments;

SELECT COUNT(*) AS TotalRows
FROM FraudCases;

SELECT 'Branches' AS TableName, COUNT(*) AS Records FROM Branches
UNION ALL
SELECT 'Employees', COUNT(*) FROM Employees
UNION ALL
SELECT 'Customers', COUNT(*) FROM Customers
UNION ALL
SELECT 'LoanApplications', COUNT(*) FROM LoanApplications
UNION ALL
SELECT 'Loans', COUNT(*) FROM Loans
UNION ALL
SELECT 'Transactions', COUNT(*) FROM Transactions
UNION ALL
SELECT 'Repayments', COUNT(*) FROM Repayments
UNION ALL
SELECT 'Collections', COUNT(*) FROM Collections
UNION ALL
SELECT 'FraudCases', COUNT(*) FROM FraudCases;

SELECT CustomerID, COUNT(*)
FROM Customers
GROUP BY CustomerID
HAVING COUNT(*) > 1;


SELECT LoanID, COUNT(*)
FROM Loans
GROUP BY LoanID
HAVING COUNT(*) > 1;


SELECT TransactionID, COUNT(*)
FROM Transactions
GROUP BY TransactionID
HAVING COUNT(*) > 1;

SELECT RepaymentID, COUNT(*)
FROM Repayments
GROUP BY RepaymentID
HAVING COUNT(*) > 1;

SELECT *
FROM Loans l
LEFT JOIN Customers c
ON l.CustomerID = c.CustomerID
WHERE c.CustomerID IS NULL;

SELECT
BranchID,
COUNT(*) Customers
FROM Customers
GROUP BY BranchID
ORDER BY Customers DESC;