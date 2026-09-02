use WhitefieldBankDW

CREATE VIEW dw.vw_LoanPortfolio
AS
SELECT
    FL.LoanID,
    DC.CustomerID,
    DC.FirstName + ' ' + DC.LastName AS CustomerName,
    DB.BranchName,
    DLT.LoanType,
    DP.ProductID,
    D1.FullDate AS SanctionDate,
    D2.FullDate AS DisbursementDate,
    FL.SanctionedAmount,
    FL.InterestRate,
    FL.TenureMonths,
    FL.EMI,
    FL.OutstandingPrincipal,
    FL.LoanStatus
FROM dw.FactLoan FL
INNER JOIN dw.DimCustomer DC
    ON FL.CustomerKey = DC.CustomerKey
INNER JOIN dw.DimBranch DB
    ON FL.BranchKey = DB.BranchKey
INNER JOIN dw.DimLoanType DLT
    ON FL.LoanTypeKey = DLT.LoanTypeKey
INNER JOIN dw.DimProduct DP
    ON FL.ProductKey = DP.ProductKey
INNER JOIN dw.DimDate D1
    ON FL.SanctionDateKey = D1.DateKey
INNER JOIN dw.DimDate D2
    ON FL.DisbursementDateKey = D2.DateKey;

SELECT TOP 10 *
FROM dw.vw_LoanPortfolio;

CREATE VIEW dw.vw_TransactionSummary
AS
SELECT
    FT.TransactionID,
    DD.FullDate AS TransactionDate,
    DC.CustomerID,
    DC.FirstName + ' ' + DC.LastName AS CustomerName,
    DB.BranchName,
    DCH.ChannelName,
    DM.MerchantName,
    FT.TransactionType,
    FT.DebitCredit,
    FT.Amount,
    FT.FraudFlag
FROM dw.FactTransaction FT
INNER JOIN dw.DimCustomer DC
    ON FT.CustomerKey = DC.CustomerKey
INNER JOIN dw.DimBranch DB
    ON FT.BranchKey = DB.BranchKey
INNER JOIN dw.DimChannel DCH
    ON FT.ChannelKey = DCH.ChannelKey
INNER JOIN dw.DimMerchant DM
    ON FT.MerchantKey = DM.MerchantKey
INNER JOIN dw.DimDate DD
    ON FT.DateKey = DD.DateKey;

SELECT TOP 10 *
FROM dw.vw_TransactionSummary;

CREATE VIEW dw.vw_Customer360
AS
SELECT
    DC.CustomerID,
    DC.FirstName + ' ' + DC.LastName AS CustomerName,
    DC.Gender,
    DC.Age,
    DC.City,
    DC.State,
    DC.Occupation,
    DC.EmploymentType,
    DC.AnnualIncome,
    DC.CreditScore,
    DC.KYCStatus,
    DB.BranchName,
    COUNT(DISTINCT FL.LoanID) AS TotalLoans,
    SUM(FL.SanctionedAmount) AS TotalLoanAmount,
    SUM(FL.OutstandingPrincipal) AS OutstandingPrincipal,
    COUNT(DISTINCT FT.TransactionID) AS TotalTransactions,
    SUM(FT.Amount) AS TotalTransactionAmount
FROM dw.DimCustomer DC
LEFT JOIN dw.DimBranch DB
    ON DC.BranchID = DB.BranchID
LEFT JOIN dw.FactLoan FL
    ON DC.CustomerKey = FL.CustomerKey
LEFT JOIN dw.FactTransaction FT
    ON DC.CustomerKey = FT.CustomerKey
GROUP BY
    DC.CustomerID,
    DC.FirstName,
    DC.LastName,
    DC.Gender,
    DC.Age,
    DC.City,
    DC.State,
    DC.Occupation,
    DC.EmploymentType,
    DC.AnnualIncome,
    DC.CreditScore,
    DC.KYCStatus,
    DB.BranchName;

CREATE VIEW dw.vw_CollectionsPerformance
AS
SELECT
    DE.EmployeeID,
    DE.FirstName + ' ' + DE.LastName AS RecoveryOfficer,
    DB.BranchName,
    COUNT(*) AS TotalCases,
    SUM(FC.OutstandingAmount) AS TotalOutstanding,
    SUM(FC.RecoveryAmount) AS TotalRecovered,
    AVG(FC.RecoveryPercentage) AS AvgRecoveryPercentage,
    AVG(FC.DaysPastDue) AS AvgDaysPastDue
FROM dw.FactCollection FC
INNER JOIN dw.DimEmployee DE
    ON FC.EmployeeKey = DE.EmployeeKey
INNER JOIN dw.DimBranch DB
    ON DE.BranchID = DB.BranchID
GROUP BY
    DE.EmployeeID,
    DE.FirstName,
    DE.LastName,
    DB.BranchName;

CREATE VIEW dw.vw_FraudAnalysis
AS
SELECT
    FF.FraudCaseID,
    DD.FullDate AS TransactionDate,
    DC.CustomerID,
    DC.FirstName + ' ' + DC.LastName AS CustomerName,
    DB.BranchName,
    DM.MerchantName,
    FF.FraudType,
    FF.TransactionAmount,
    FF.InvestigationDays,
    FF.FraudStatus,
    FF.RecoveredAmount,
    FF.FinancialLoss
FROM dw.FactFraud FF
INNER JOIN dw.DimCustomer DC
    ON FF.CustomerKey = DC.CustomerKey
INNER JOIN dw.DimBranch DB
    ON FF.BranchKey = DB.BranchKey
INNER JOIN dw.DimMerchant DM
    ON FF.MerchantKey = DM.MerchantKey
INNER JOIN dw.DimDate DD
    ON FF.DateKey = DD.DateKey;

CREATE VIEW dw.vw_BranchPerformance
AS
SELECT
    DB.BranchID,
    DB.BranchName,
    DB.City,
    DB.State,
    COUNT(DISTINCT FL.LoanID) AS TotalLoans,
    SUM(FL.SanctionedAmount) AS TotalLoanAmount,
    SUM(FL.OutstandingPrincipal) AS OutstandingPrincipal,
    COUNT(DISTINCT FT.TransactionID) AS TotalTransactions,
    SUM(FT.Amount) AS TotalTransactionValue,
    COUNT(DISTINCT DC.CustomerID) AS TotalCustomers
FROM dw.DimBranch DB
LEFT JOIN dw.FactLoan FL
    ON DB.BranchKey = FL.BranchKey
LEFT JOIN dw.FactTransaction FT
    ON DB.BranchKey = FT.BranchKey
LEFT JOIN dw.DimCustomer DC
    ON DB.BranchID = DC.BranchID
GROUP BY
    DB.BranchID,
    DB.BranchName,
    DB.City,
    DB.State;


SELECT COUNT(*) FROM dw.DimDate;
SELECT COUNT(*) FROM dw.DimBranch;
SELECT COUNT(*) FROM dw.DimCustomer;
SELECT COUNT(*) FROM dw.DimEmployee;
SELECT COUNT(*) FROM dw.DimLoanType;
SELECT COUNT(*) FROM dw.DimProduct;
SELECT COUNT(*) FROM dw.DimChannel;
SELECT COUNT(*) FROM dw.DimMerchant;

SELECT COUNT(*) FROM dw.FactLoan;
SELECT COUNT(*) FROM dw.FactTransaction;
SELECT COUNT(*) FROM dw.FactRepayment;
SELECT COUNT(*) FROM dw.FactCollection;
SELECT COUNT(*) FROM dw.FactFraud;