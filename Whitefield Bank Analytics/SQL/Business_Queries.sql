use WhitefieldBankDW

Select SUM(SanctionedAmount) AS TotalLoanPortfolio
FROM dw.FactLoan;

SELECT
    SUM(OutstandingPrincipal) AS OutstandingPortfolio
FROM dw.FactLoan;

SELECT
    DLT.LoanType,
    COUNT(*) AS TotalLoans,
    SUM(FL.SanctionedAmount) AS LoanAmount
FROM dw.FactLoan FL
JOIN dw.DimLoanType DLT
    ON FL.LoanTypeKey = DLT.LoanTypeKey
GROUP BY DLT.LoanType
ORDER BY LoanAmount DESC;

SELECT TOP 10
    DC.CustomerID,
    DC.FirstName + ' ' + DC.LastName AS CustomerName,
    SUM(FL.SanctionedAmount) AS TotalLoan
FROM dw.FactLoan FL
JOIN dw.DimCustomer DC
    ON FL.CustomerKey = DC.CustomerKey
GROUP BY
    DC.CustomerID,
    DC.FirstName,
    DC.LastName
ORDER BY TotalLoan DESC;

SELECT
    DD.YearNumber,
    DD.MonthName,
    SUM(FL.SanctionedAmount) AS LoanAmount
FROM dw.FactLoan FL
JOIN dw.DimDate DD
    ON FL.DisbursementDateKey = DD.DateKey
GROUP BY
    DD.YearNumber,
    DD.MonthNumber,
    DD.MonthName
ORDER BY
    DD.YearNumber,
    DD.MonthNumber;

SELECT
    DB.BranchName,
    COUNT(*) AS TotalLoans,
    SUM(FL.SanctionedAmount) AS LoanPortfolio
FROM dw.FactLoan FL
JOIN dw.DimBranch DB
    ON FL.BranchKey = DB.BranchKey
GROUP BY DB.BranchName
ORDER BY LoanPortfolio DESC;


SELECT
    DC.ChannelName,
    COUNT(*) AS Transactions,
    SUM(FT.Amount) AS TransactionValue
FROM dw.FactTransaction FT
JOIN dw.DimChannel DC
    ON FT.ChannelKey = DC.ChannelKey
GROUP BY DC.ChannelName
ORDER BY TransactionValue DESC;


SELECT
    COUNT(*) AS FraudTransactions,
    SUM(TransactionAmount) AS FraudAmount
FROM dw.FactFraud;


SELECT TOP 10
    DM.MerchantName,
    SUM(FT.Amount) AS TotalValue
FROM dw.FactTransaction FT
JOIN dw.DimMerchant DM
    ON FT.MerchantKey = DM.MerchantKey
GROUP BY DM.MerchantName
ORDER BY TotalValue DESC;


SELECT
    AVG(RecoveryPercentage) AS AvgRecovery,
    SUM(RecoveryAmount) AS TotalRecovered
FROM dw.FactCollection;

/*Executive KPIs*/
SELECT
    COUNT(*) AS TotalCustomers
FROM dw.DimCustomer;

SELECT
    COUNT(DISTINCT FL.CustomerKey) AS ActiveCustomers
FROM dw.FactLoan FL
WHERE FL.LoanStatus = 'Active';

SELECT
    COUNT(*) AS TotalLoans
FROM dw.FactLoan;

SELECT
    SUM(SanctionedAmount) AS LoanPortfolio
FROM dw.FactLoan;

SELECT
    COUNT(*) AS TotalTransactions
FROM dw.FactTransaction;

SELECT
    SUM(Amount) AS TransactionValue
FROM dw.FactTransaction;

SELECT
    COUNT(*) AS FraudCases,
    SUM(FinancialLoss) AS TotalFraudLoss
FROM dw.FactFraud;

SELECT
    SUM(RecoveryAmount) AS TotalRecoveredAmount
FROM dw.FactCollection;

SELECT
    SUM(RecoveryAmount) AS TotalRecovered,
    SUM(OutstandingAmount) AS TotalOutstanding,
    ROUND(
        (SUM(RecoveryAmount) * 100.0) /
        NULLIF(SUM(OutstandingAmount),0),
        2
    ) AS CollectionEfficiencyPercent
FROM dw.FactCollection;

SELECT
    SUM(FC.RecoveryAmount) AS TotalRecovered,
    SUM(FF.FinancialLoss) AS TotalFraudLoss,
    SUM(FC.RecoveryAmount) - SUM(FF.FinancialLoss) AS NetRecovery
FROM dw.FactCollection FC
CROSS JOIN dw.FactFraud FF;

SELECT
    C.TotalRecovered,
    F.TotalFraudLoss,
    C.TotalRecovered - F.TotalFraudLoss AS NetRecovery
FROM
(
    SELECT SUM(RecoveryAmount) AS TotalRecovered
    FROM dw.FactCollection
) C
CROSS JOIN
(
    SELECT SUM(FinancialLoss) AS TotalFraudLoss
    FROM dw.FactFraud
) F;

SELECT TOP 10
    DC.CustomerID,
    DC.FirstName + ' ' + DC.LastName AS CustomerName,
    SUM(FL.SanctionedAmount) AS TotalLoanAmount
FROM dw.FactLoan FL
JOIN dw.DimCustomer DC
    ON FL.CustomerKey = DC.CustomerKey
GROUP BY
    DC.CustomerID,
    DC.FirstName,
    DC.LastName
ORDER BY TotalLoanAmount DESC;

SELECT
    CASE
        WHEN CreditScore < 600 THEN 'Poor'
        WHEN CreditScore BETWEEN 600 AND 699 THEN 'Fair'
        WHEN CreditScore BETWEEN 700 AND 749 THEN 'Good'
        WHEN CreditScore BETWEEN 750 AND 799 THEN 'Very Good'
        ELSE 'Excellent'
    END AS CreditScoreBand,
    COUNT(*) AS TotalCustomers
FROM dw.DimCustomer
GROUP BY
    CASE
        WHEN CreditScore < 600 THEN 'Poor'
        WHEN CreditScore BETWEEN 600 AND 699 THEN 'Fair'
        WHEN CreditScore BETWEEN 700 AND 749 THEN 'Good'
        WHEN CreditScore BETWEEN 750 AND 799 THEN 'Very Good'
        ELSE 'Excellent'
    END
ORDER BY TotalCustomers DESC;

SELECT
    CASE
        WHEN AnnualIncome < 500000 THEN 'Below 5 Lakhs'
        WHEN AnnualIncome BETWEEN 500000 AND 1000000 THEN '5 - 10 Lakhs'
        WHEN AnnualIncome BETWEEN 1000001 AND 2000000 THEN '10 - 20 Lakhs'
        ELSE 'Above 20 Lakhs'
    END AS IncomeBand,
    COUNT(*) AS TotalCustomers
FROM dw.DimCustomer
GROUP BY
    CASE
        WHEN AnnualIncome < 500000 THEN 'Below 5 Lakhs'
        WHEN AnnualIncome BETWEEN 500000 AND 1000000 THEN '5 - 10 Lakhs'
        WHEN AnnualIncome BETWEEN 1000001 AND 2000000 THEN '10 - 20 Lakhs'
        ELSE 'Above 20 Lakhs'
    END
ORDER BY TotalCustomers DESC;

SELECT
    CASE
        WHEN Age BETWEEN 18 AND 25 THEN '18-25'
        WHEN Age BETWEEN 26 AND 35 THEN '26-35'
        WHEN Age BETWEEN 36 AND 45 THEN '36-45'
        WHEN Age BETWEEN 46 AND 55 THEN '46-55'
        ELSE '56+'
    END AS AgeGroup,
    COUNT(*) AS TotalCustomers
FROM dw.DimCustomer
GROUP BY
    CASE
        WHEN Age BETWEEN 18 AND 25 THEN '18-25'
        WHEN Age BETWEEN 26 AND 35 THEN '26-35'
        WHEN Age BETWEEN 36 AND 45 THEN '36-45'
        WHEN Age BETWEEN 46 AND 55 THEN '46-55'
        ELSE '56+'
    END
ORDER BY TotalCustomers DESC;

SELECT
    Occupation,
    COUNT(*) AS TotalCustomers
FROM dw.DimCustomer
GROUP BY Occupation
ORDER BY TotalCustomers DESC;

SELECT
    State,
    COUNT(*) AS TotalCustomers
FROM dw.DimCustomer
GROUP BY State
ORDER BY TotalCustomers DESC;

SELECT
    EmploymentType,
    COUNT(*) AS TotalCustomers
FROM dw.DimCustomer
GROUP BY EmploymentType
ORDER BY TotalCustomers DESC;

SELECT
    DC.CustomerID,
    DC.FirstName + ' ' + DC.LastName AS CustomerName,
    AVG(FL.SanctionedAmount) AS AverageLoanAmount
FROM dw.FactLoan FL
JOIN dw.DimCustomer DC
    ON FL.CustomerKey = DC.CustomerKey
GROUP BY
    DC.CustomerID,
    DC.FirstName,
    DC.LastName
ORDER BY AverageLoanAmount DESC;

/*Loan Analytics*/
SELECT
    DLT.LoanType,
    COUNT(*) AS TotalLoans,
    SUM(FL.SanctionedAmount) AS TotalLoanAmount
FROM dw.FactLoan FL
JOIN dw.DimLoanType DLT
    ON FL.LoanTypeKey = DLT.LoanTypeKey
GROUP BY DLT.LoanType
ORDER BY TotalLoanAmount DESC;

SELECT
    DP.ProductID,
    COUNT(*) AS TotalLoans,
    SUM(FL.SanctionedAmount) AS TotalLoanAmount
FROM dw.FactLoan FL
JOIN dw.DimProduct DP
    ON FL.ProductKey = DP.ProductKey
GROUP BY DP.ProductID
ORDER BY TotalLoanAmount DESC;

SELECT
    LoanStatus,
    COUNT(*) AS TotalLoans,
    SUM(SanctionedAmount) AS LoanPortfolio,
    SUM(OutstandingPrincipal) AS OutstandingPrincipal
FROM dw.FactLoan
GROUP BY LoanStatus
ORDER BY TotalLoans DESC;

SELECT
    DD.YearNumber,
    DD.MonthNumber,
    DD.MonthName,
    COUNT(*) AS LoansDisbursed,
    SUM(FL.SanctionedAmount) AS LoanAmount
FROM dw.FactLoan FL
JOIN dw.DimDate DD
    ON FL.DisbursementDateKey = DD.DateKey
GROUP BY
    DD.YearNumber,
    DD.MonthNumber,
    DD.MonthName
ORDER BY
    DD.YearNumber,
    DD.MonthNumber;

SELECT
    DLT.LoanType,
    AVG(FL.InterestRate) AS AverageInterestRate
FROM dw.FactLoan FL
JOIN dw.DimLoanType DLT
    ON FL.LoanTypeKey = DLT.LoanTypeKey
GROUP BY DLT.LoanType
ORDER BY AverageInterestRate DESC;

SELECT
    DLT.LoanType,
    AVG(FL.EMI) AS AverageEMI
FROM dw.FactLoan FL
JOIN dw.DimLoanType DLT
    ON FL.LoanTypeKey = DLT.LoanTypeKey
GROUP BY DLT.LoanType
ORDER BY AverageEMI DESC;

SELECT
    DLT.LoanType,
    AVG(FL.TenureMonths) AS AverageTenureMonths
FROM dw.FactLoan FL
JOIN dw.DimLoanType DLT
    ON FL.LoanTypeKey = DLT.LoanTypeKey
GROUP BY DLT.LoanType
ORDER BY AverageTenureMonths DESC;

SELECT
    DLT.LoanType,
    SUM(FL.OutstandingPrincipal) AS OutstandingPrincipal
FROM dw.FactLoan FL
JOIN dw.DimLoanType DLT
    ON FL.LoanTypeKey = DLT.LoanTypeKey
GROUP BY DLT.LoanType
ORDER BY OutstandingPrincipal DESC;

SELECT TOP 10
    DB.BranchName,
    DB.City,
    COUNT(*) AS TotalLoans,
    SUM(FL.SanctionedAmount) AS LoanPortfolio
FROM dw.FactLoan FL
JOIN dw.DimBranch DB
    ON FL.BranchKey = DB.BranchKey
GROUP BY
    DB.BranchName,
    DB.City
ORDER BY LoanPortfolio DESC;

SELECT TOP 10
    DC.CustomerID,
    DC.FirstName + ' ' + DC.LastName AS CustomerName,
    SUM(FL.OutstandingPrincipal) AS OutstandingBalance
FROM dw.FactLoan FL
JOIN dw.DimCustomer DC
    ON FL.CustomerKey = DC.CustomerKey
GROUP BY
    DC.CustomerID,
    DC.FirstName,
    DC.LastName
ORDER BY OutstandingBalance DESC;

SELECT
    DD.YearNumber,
    COUNT(*) AS LoansApproved,
    SUM(FL.SanctionedAmount) AS TotalApprovedAmount
FROM dw.FactLoan FL
JOIN dw.DimDate DD
    ON FL.SanctionDateKey = DD.DateKey
GROUP BY DD.YearNumber
ORDER BY DD.YearNumber;

/*Transaction Analytics*/
SELECT
    DC.ChannelName as Channel,
    COUNT(*) AS TotalTransactions,
    SUM(FT.Amount) AS TransactionValue
FROM dw.FactTransaction FT
JOIN dw.DimChannel DC
    ON FT.ChannelKey = DC.ChannelKey
GROUP BY DC.ChannelName
ORDER BY TransactionValue DESC;

SELECT
    DD.YearNumber,
    DD.MonthNumber,
    DD.MonthName,
    COUNT(*) AS TotalTransactions,
    SUM(FT.Amount) AS TransactionValue
FROM dw.FactTransaction FT
JOIN dw.DimDate DD
    ON FT.DateKey = DD.DateKey
GROUP BY
    DD.YearNumber,
    DD.MonthNumber,
    DD.MonthName
ORDER BY
    DD.YearNumber,
    DD.MonthNumber;

SELECT
    DebitCredit,
    COUNT(*) AS TotalTransactions,
    SUM(Amount) AS TransactionValue
FROM dw.FactTransaction
GROUP BY DebitCredit;

SELECT
    DC.ChannelName,
    AVG(FT.Amount) AS AverageTransactionAmount
FROM dw.FactTransaction FT
JOIN dw.DimChannel DC
    ON FT.ChannelKey = DC.ChannelKey
GROUP BY DC.ChannelName
ORDER BY AverageTransactionAmount DESC;

SELECT TOP 10
    FT.TransactionID,
    DC.CustomerID,
    DC.FirstName + ' ' + DC.LastName AS CustomerName,
    FT.Amount
FROM dw.FactTransaction FT
JOIN dw.DimCustomer DC
    ON FT.CustomerKey = DC.CustomerKey
ORDER BY FT.Amount DESC;

SELECT
    DM.MerchantName,
    COUNT(*) AS TotalTransactions,
    SUM(FT.Amount) AS TransactionValue
FROM dw.FactTransaction FT
JOIN dw.DimMerchant DM
    ON FT.MerchantKey = DM.MerchantKey
GROUP BY DM.MerchantName
ORDER BY TransactionValue DESC;

SELECT
    DB.BranchName,
    COUNT(*) AS TotalTransactions,
    SUM(FT.Amount) AS TransactionValue
FROM dw.FactTransaction FT
JOIN dw.DimBranch DB
    ON FT.BranchKey = DB.BranchKey
GROUP BY DB.BranchName
ORDER BY TransactionValue DESC;

SELECT TOP 10
    DC.CustomerID,
    DC.FirstName + ' ' + DC.LastName AS CustomerName,
    COUNT(*) AS TotalTransactions,
    SUM(FT.Amount) AS TransactionValue
FROM dw.FactTransaction FT
JOIN dw.DimCustomer DC
    ON FT.CustomerKey = DC.CustomerKey
GROUP BY
    DC.CustomerID,
    DC.FirstName,
    DC.LastName
ORDER BY TransactionValue DESC;

/*Fraud Analytics*/

SELECT
    FraudType,
    COUNT(*) AS FraudCases,
    SUM(FinancialLoss) AS TotalLoss
FROM dw.FactFraud
GROUP BY FraudType
ORDER BY TotalLoss DESC;

SELECT
    DB.BranchName,
    COUNT(*) AS FraudCases,
    SUM(FF.FinancialLoss) AS FinancialLoss
FROM dw.FactFraud FF
JOIN dw.DimBranch DB
    ON FF.BranchKey = DB.BranchKey
GROUP BY DB.BranchName
ORDER BY FinancialLoss DESC;

SELECT
    DM.MerchantName,
    COUNT(*) AS FraudCases,
    SUM(FF.FinancialLoss) AS FinancialLoss
FROM dw.FactFraud FF
JOIN dw.DimMerchant DM
    ON FF.MerchantKey = DM.MerchantKey
GROUP BY DM.MerchantName
ORDER BY FinancialLoss DESC;

SELECT
    FraudType,
    SUM(FinancialLoss) AS TotalFinancialLoss,
    SUM(RecoveredAmount) AS TotalRecovered
FROM dw.FactFraud
GROUP BY FraudType
ORDER BY TotalFinancialLoss DESC;

SELECT
    SUM(RecoveredAmount) AS TotalRecovered,
    SUM(FinancialLoss) AS TotalLoss,
    ROUND(
        (SUM(RecoveredAmount) * 100.0) /
        NULLIF(SUM(FinancialLoss),0),
        2
    ) AS RecoveryRatePercent
FROM dw.FactFraud;

SELECT
    FraudType,
    AVG(InvestigationDays) AS AverageInvestigationDays
FROM dw.FactFraud
GROUP BY FraudType
ORDER BY AverageInvestigationDays DESC;

SELECT
    DD.YearNumber,
    DD.MonthNumber,
    DD.MonthName,
    COUNT(*) AS FraudCases,
    SUM(FF.FinancialLoss) AS FinancialLoss
FROM dw.FactFraud FF
JOIN dw.DimDate DD
    ON FF.DateKey = DD.DateKey
GROUP BY
    DD.YearNumber,
    DD.MonthNumber,
    DD.MonthName
ORDER BY
    DD.YearNumber,
    DD.MonthNumber;

/*Collections Analytics*/
SELECT
    DE.EmployeeID,
    DE.FirstName + ' ' + DE.LastName AS RecoveryOfficer,
    COUNT(*) AS TotalCases,
    SUM(FC.RecoveryAmount) AS TotalRecovered,
    AVG(FC.RecoveryPercentage) AS AvgRecoveryPercentage
FROM dw.FactCollection FC
JOIN dw.DimEmployee DE
ON FC.EmployeeKey = DE.EmployeeKey
GROUP BY
    DE.EmployeeID,
    DE.FirstName,
    DE.LastName
ORDER BY TotalRecovered DESC;

SELECT
    CollectionStatus,
    COUNT(*) AS TotalCases,
    SUM(RecoveryAmount) AS TotalRecovered
FROM dw.FactCollection
GROUP BY CollectionStatus
ORDER BY TotalCases DESC;

SELECT
    DB.BranchName,
    AVG(FC.RecoveryPercentage) AS AvgRecoveryPercentage
FROM dw.FactCollection FC
JOIN dw.DimEmployee DE
ON FC.EmployeeKey=DE.EmployeeKey
JOIN dw.DimBranch DB
ON DE.BranchID=DB.BranchID
GROUP BY DB.BranchName
ORDER BY AvgRecoveryPercentage DESC;

SELECT
    DB.BranchName,
    AVG(FC.DaysPastDue) AS AvgDaysPastDue
FROM dw.FactCollection FC
JOIN dw.DimEmployee DE
ON FC.EmployeeKey=DE.EmployeeKey
JOIN dw.DimBranch DB
ON DE.BranchID=DB.BranchID
GROUP BY DB.BranchName
ORDER BY AvgDaysPastDue DESC;

SELECT
    DD.YearNumber,
    DD.MonthNumber,
    DD.MonthName,
    SUM(FC.RecoveryAmount) AS RecoveryAmount
FROM dw.FactCollection FC
JOIN dw.DimDate DD
ON FC.DateKey=DD.DateKey
GROUP BY
    DD.YearNumber,
    DD.MonthNumber,
    DD.MonthName
ORDER BY
    DD.YearNumber,
    DD.MonthNumber;

SELECT
    CollectionStatus,
    SUM(OutstandingAmount) AS OutstandingAmount
FROM dw.FactCollection
GROUP BY CollectionStatus
ORDER BY OutstandingAmount DESC;

SELECT TOP 10
    DE.EmployeeID,
    DE.FirstName + ' ' + DE.LastName AS RecoveryOfficer,
    SUM(FC.RecoveryAmount) AS TotalRecovered
FROM dw.FactCollection FC
JOIN dw.DimEmployee DE
ON FC.EmployeeKey=DE.EmployeeKey
GROUP BY
    DE.EmployeeID,
    DE.FirstName,
    DE.LastName
ORDER BY TotalRecovered DESC;

/*Advanced SQL*/
SELECT
    DC.CustomerID,
    DC.FirstName+' '+DC.LastName AS CustomerName,
    SUM(FL.SanctionedAmount) AS LoanAmount,
    RANK() OVER(ORDER BY SUM(FL.SanctionedAmount) DESC) AS CustomerRank
FROM dw.FactLoan FL
JOIN dw.DimCustomer DC
ON FL.CustomerKey=DC.CustomerKey
GROUP BY
    DC.CustomerID,
    DC.FirstName,
    DC.LastName;

SELECT
    DB.BranchName,
    SUM(FL.SanctionedAmount) AS Portfolio,
    DENSE_RANK() OVER(ORDER BY SUM(FL.SanctionedAmount) DESC) AS BranchRank
FROM dw.FactLoan FL
JOIN dw.DimBranch DB
ON FL.BranchKey=DB.BranchKey
GROUP BY DB.BranchName;

SELECT
    DD.FullDate,
    SUM(FL.SanctionedAmount) AS DailyLoan,
    SUM(SUM(FL.SanctionedAmount))
    OVER(ORDER BY DD.FullDate) AS RunningPortfolio
FROM dw.FactLoan FL
JOIN dw.DimDate DD
ON FL.DisbursementDateKey=DD.DateKey
GROUP BY DD.FullDate
ORDER BY DD.FullDate;

SELECT
    DD.FullDate,
    SUM(FT.Amount) AS DailyTransactions,
    SUM(SUM(FT.Amount))
    OVER(ORDER BY DD.FullDate) AS RunningTransactions
FROM dw.FactTransaction FT
JOIN dw.DimDate DD
ON FT.DateKey=DD.DateKey
GROUP BY DD.FullDate
ORDER BY DD.FullDate;

SELECT
    DD.YearNumber,
    DD.MonthNumber,
    SUM(FL.SanctionedAmount) AS LoanAmount,
    LAG(SUM(FL.SanctionedAmount))
    OVER(ORDER BY DD.YearNumber,DD.MonthNumber) AS PreviousMonth
FROM dw.FactLoan FL
JOIN dw.DimDate DD
ON FL.DisbursementDateKey=DD.DateKey
GROUP BY
    DD.YearNumber,
    DD.MonthNumber;

SELECT
    DD.YearNumber,
    DD.MonthNumber,
    SUM(FF.FinancialLoss) AS FraudLoss,
    LAG(SUM(FF.FinancialLoss))
    OVER(ORDER BY DD.YearNumber,DD.MonthNumber) AS PreviousLoss
FROM dw.FactFraud FF
JOIN dw.DimDate DD
ON FF.DateKey=DD.DateKey
GROUP BY
    DD.YearNumber,
    DD.MonthNumber;

SELECT *
FROM
(
SELECT
DB.BranchName,
DC.CustomerID,
DC.FirstName+' '+DC.LastName AS CustomerName,
SUM(FL.SanctionedAmount) AS LoanAmount,
ROW_NUMBER() OVER(
PARTITION BY DB.BranchName
ORDER BY SUM(FL.SanctionedAmount) DESC
) RN
FROM dw.FactLoan FL
JOIN dw.DimCustomer DC
ON FL.CustomerKey=DC.CustomerKey
JOIN dw.DimBranch DB
ON FL.BranchKey=DB.BranchKey
GROUP BY
DB.BranchName,
DC.CustomerID,
DC.FirstName,
DC.LastName
)A
WHERE RN<=5;

SELECT
CustomerID,
AnnualIncome,
NTILE(4) OVER(ORDER BY AnnualIncome DESC) AS IncomeQuartile
FROM dw.DimCustomer;

SELECT
CustomerID,
CreditScore,
PERCENT_RANK() OVER(ORDER BY CreditScore DESC) AS CreditPercentile
FROM dw.DimCustomer;

SELECT
DD.FullDate,
SUM(FC.RecoveryAmount) AS DailyRecovery,
SUM(SUM(FC.RecoveryAmount))
OVER(ORDER BY DD.FullDate) RunningRecovery
FROM dw.FactCollection FC
JOIN dw.DimDate DD
ON FC.DateKey=DD.DateKey
GROUP BY DD.FullDate;

WITH LoanCTE AS
(
SELECT CustomerKey,SUM(SanctionedAmount) LoanAmount
FROM dw.FactLoan
GROUP BY CustomerKey
)
SELECT *
FROM LoanCTE
WHERE LoanAmount>(
SELECT AVG(LoanAmount) FROM LoanCTE
);

WITH ActiveLoans AS
(
SELECT CustomerKey,COUNT(*) TotalLoans
FROM dw.FactLoan
WHERE LoanStatus='Active'
GROUP BY CustomerKey
)
SELECT *
FROM ActiveLoans
WHERE TotalLoans>1;

WITH RiskCTE AS
(
SELECT
CustomerID,
CreditScore
FROM dw.DimCustomer
WHERE CreditScore<650
)
SELECT *
FROM RiskCTE;

WITH PortfolioCTE AS
(
SELECT
BranchKey,
SUM(SanctionedAmount) Portfolio
FROM dw.FactLoan
GROUP BY BranchKey
)
SELECT *
FROM PortfolioCTE
WHERE Portfolio>
(
SELECT AVG(Portfolio)
FROM PortfolioCTE
);

WITH FraudCustomers AS
(
SELECT DISTINCT CustomerKey
FROM dw.FactFraud
)
SELECT
DC.CustomerID,
FL.LoanStatus
FROM FraudCustomers FC
JOIN dw.DimCustomer DC
ON FC.CustomerKey=DC.CustomerKey
JOIN dw.FactLoan FL
ON FC.CustomerKey=FL.CustomerKey;

SELECT *
FROM dw.DimCustomer
WHERE AnnualIncome>
(
SELECT AVG(AnnualIncome)
FROM dw.DimCustomer
);

SELECT
DB.BranchName,
COUNT(*) Transactions
FROM dw.FactTransaction FT
JOIN dw.DimBranch DB
ON FT.BranchKey=DB.BranchKey
GROUP BY DB.BranchName
HAVING COUNT(*)>
(
SELECT AVG(TransactionCount)
FROM
(
SELECT COUNT(*) TransactionCount
FROM dw.FactTransaction
GROUP BY BranchKey
)A
);

SELECT *
FROM dw.FactLoan
WHERE EMI>
(
SELECT AVG(EMI)
FROM dw.FactLoan
);

SELECT TOP 1
DB.BranchName,
SUM(FF.FinancialLoss) AS FraudLoss
FROM dw.FactFraud FF
JOIN dw.DimBranch DB
ON FF.BranchKey=DB.BranchKey
GROUP BY DB.BranchName
ORDER BY FraudLoss DESC;

SELECT *
FROM
(
SELECT
DB.State,
DM.MerchantName,
SUM(FT.Amount) TransactionValue,
ROW_NUMBER() OVER(
PARTITION BY DB.State
ORDER BY SUM(FT.Amount) DESC
) RN
FROM dw.FactTransaction FT
JOIN dw.DimBranch DB
ON FT.BranchKey=DB.BranchKey
JOIN dw.DimMerchant DM
ON FT.MerchantKey=DM.MerchantKey
GROUP BY
DB.State,
DM.MerchantName
)A
WHERE RN=1;

SELECT COUNT(*)
FROM dw.DimDate;

SELECT TOP 31
    DateKey,
    FullDate,
    DayName
FROM dw.DimDate
ORDER BY FullDate;

SELECT CustomerKey, COUNT(*) AS Cnt
FROM dw.DimCustomer
GROUP BY CustomerKey
HAVING COUNT(*) > 1;

SELECT
    SUM(SanctionedAmount) AS LoanPortfolio,
    SUM(OutstandingPrincipal) AS OutstandingPrincipal
FROM dw.FactLoan;

SELECT
    d.[Year],
    SUM(f.Amount) AS TotalTransactionValue
FROM dw.FactTransaction f
JOIN dw.DimDate d
    ON f.TransactionDateKey = d.DateKey
GROUP BY d.[Year]
ORDER BY d.[Year];

SELECT
    d.YearNumber,
    SUM(f.Amount) AS TotalTransactionValue
FROM dw.FactTransaction f
INNER JOIN dw.DimDate d
    ON f.DateKey = d.DateKey
GROUP BY d.YearNumber
ORDER BY d.YearNumber;

SELECT
    d.YearNumber,
    SUM(f.SanctionedAmount) AS LoanPortfolio
FROM dw.FactLoan f
INNER JOIN dw.DimDate d
    ON f.SanctionDateKey = d.DateKey
GROUP BY d.YearNumber
ORDER BY d.YearNumber;

SELECT
    MIN(d.FullDate) AS FirstTransaction,
    MAX(d.FullDate) AS LastTransaction
FROM dw.FactTransaction t
JOIN dw.DimDate d
    ON t.DateKey = d.DateKey;