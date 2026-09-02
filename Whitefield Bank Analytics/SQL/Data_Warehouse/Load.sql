use WhitefieldBankDW
INSERT INTO dw.DimBranch
(
    BranchID,
    BranchCode,
    BranchName,
    IFSCCode,
    BranchType,
    Region,
    State,
    City,
    Pincode,
    Address,
    OpeningDate,
    ManagerID,
    Latitude,
    Longitude,
    IsActive
)
SELECT
    BranchID,
    BranchCode,
    BranchName,
    IFSCCode,
    BranchType,
    Region,
    State,
    City,
    Pincode,
    Address,
    OpeningDate,
    ManagerID,
    Latitude,
    Longitude,
    IsActive
FROM WhitefieldBankDB.dbo.Branches;

SELECT * FROM dw.DimBranch;
SELECT COUNT(*) FROM dw.DimBranch;

INSERT INTO dw.DimCustomer
(
    CustomerID,
    FirstName,
    LastName,
    Gender,
    DateOfBirth,
    Age,
    PAN,
    Aadhaar,
    Mobile,
    Email,
    Occupation,
    EmploymentType,
    AnnualIncome,
    CreditScore,
    MaritalStatus,
    City,
    State,
    Pincode,
    CustomerSince,
    KYCStatus,
    PreferredChannel,
    BranchID,
    IsActive
)
SELECT
    CustomerID,
    FirstName,
    LastName,
    Gender,
    DateOfBirth,
    Age,
    PAN,
    Aadhaar,
    Mobile,
    Email,
    Occupation,
    EmploymentType,
    AnnualIncome,
    CreditScore,
    MaritalStatus,
    City,
    State,
    Pincode,
    CustomerSince,
    KYCStatus,
    PreferredChannel,
    BranchID,
    IsActive
FROM WhitefieldBankDB.dbo.Customers;

SELECT COUNT(*) FROM dw.DimCustomer;

SELECT TOP 10 *
FROM dw.DimCustomer;

INSERT INTO dw.DimEmployee
(
    EmployeeID,
    FirstName,
    LastName,
    Designation,
    Department,
    BranchID,
    ManagerID,
    DateOfJoining,
    AnnualSalaryINR,
    PerformanceRating,
    EmploymentStatus,
    Email,
    Phone,
    LoanOfficerFlag
)
SELECT
    EmployeeID,
    FirstName,
    LastName,
    Designation,
    Department,
    BranchID,
    ManagerID,
    DateOfJoining,
    AnnualSalaryINR,
    PerformanceRating,
    EmploymentStatus,
    Email,
    Phone,
    LoanOfficerFlag
FROM WhitefieldBankDB.dbo.Employees;

SELECT COUNT(*) FROM dw.DimEmployee;
SELECT TOP 10 *
FROM dw.DimEmployee;

INSERT INTO dw.DimLoanType (LoanType)
SELECT DISTINCT LoanType
FROM WhitefieldBankDB.dbo.Loans
ORDER BY LoanType;

SELECT * FROM dw.DimLoanType;

INSERT INTO dw.DimChannel (ChannelName)
SELECT DISTINCT Channel
FROM WhitefieldBankDB.dbo.Transactions
ORDER BY Channel;

INSERT INTO dw.DimMerchant (MerchantName)
SELECT DISTINCT MerchantName
FROM WhitefieldBankDB.dbo.Transactions
WHERE MerchantName IS NOT NULL
ORDER BY MerchantName;

INSERT INTO dw.DimMerchant (MerchantName)
SELECT DISTINCT Merchant
FROM WhitefieldBankDB.dbo.Transactions
WHERE Merchant IS NOT NULL
ORDER BY Merchant;

INSERT INTO dw.DimProduct(ProductID, LoanType)
SELECT DISTINCT ProductID, LoanType
FROM WhitefieldBankDB.dbo.Loans;

INSERT INTO dw.FactLoan
(
    LoanID,
    CustomerKey,
    BranchKey,
    LoanTypeKey,
    ProductKey,
    SanctionDateKey,
    DisbursementDateKey,
    SanctionedAmount,
    InterestRate,
    TenureMonths,
    EMI,
    OutstandingPrincipal,
    LoanStatus
)
SELECT
    L.LoanID,
    C.CustomerKey,
    B.BranchKey,
    LT.LoanTypeKey,
    P.ProductKey,
    CONVERT(INT, CONVERT(VARCHAR(8), L.SanctionDate, 112)),
    CONVERT(INT, CONVERT(VARCHAR(8), L.DisbursementDate, 112)),
    L.SanctionedAmount,
    L.InterestRate,
    L.TenureMonths,
    L.EMI,
    L.OutstandingPrincipal,
    L.LoanStatus
FROM WhitefieldBankDB.dbo.Loans L
INNER JOIN dw.DimCustomer C
    ON L.CustomerID = C.CustomerID
INNER JOIN dw.DimBranch B
    ON L.BranchID = B.BranchID
INNER JOIN dw.DimLoanType LT
    ON L.LoanType = LT.LoanType
INNER JOIN dw.DimProduct P
    ON L.ProductID = P.ProductID;

INSERT INTO dw.FactTransaction
(
    TransactionID,
    CustomerKey,
    BranchKey,
    DateKey,
    ChannelKey,
    MerchantKey,
    TransactionType,
    DebitCredit,
    Amount,
    FraudFlag
)
SELECT
    T.TransactionID,
    C.CustomerKey,
    B.BranchKey,
    CONVERT(INT, CONVERT(VARCHAR(8), T.TransactionDateTime, 112)),
    CH.ChannelKey,
    M.MerchantKey,
    T.TransactionType,
    T.DebitCredit,
    T.Amount,
    T.FraudFlag
FROM WhitefieldBankDB.dbo.Transactions T
INNER JOIN dw.DimCustomer C
    ON T.CustomerID = C.CustomerID
INNER JOIN dw.DimBranch B
    ON T.BranchID = B.BranchID
INNER JOIN dw.DimChannel CH
    ON T.Channel = CH.ChannelName
INNER JOIN dw.DimMerchant M
    ON T.Merchant = M.MerchantName;

SELECT COUNT(*) AS TotalTransactions
FROM dw.FactTransaction;

SELECT TOP 10 *
FROM dw.FactTransaction;

INSERT INTO dw.FactRepayment
(
    RepaymentID,
    LoanKey,
    CustomerKey,
    DueDateKey,
    PaymentDateKey,
    EMINumber,
    EMIAmount,
    PrincipalPaid,
    InterestPaid,
    OutstandingBalance,
    PaymentStatus,
    DaysPastDue
)
SELECT
    R.RepaymentID,
    FL.LoanKey,
    DC.CustomerKey,
    CONVERT(INT, CONVERT(VARCHAR(8), R.DueDate, 112)),
    CONVERT(INT, CONVERT(VARCHAR(8), R.PaymentDate, 112)),
    R.EMINumber,
    R.EMIAmount,
    R.PrincipalPaid,
    R.InterestPaid,
    R.OutstandingBalance,
    R.PaymentStatus,
    R.DaysPastDue
FROM WhitefieldBankDB.dbo.Repayments R
INNER JOIN dw.FactLoan FL
    ON R.LoanID = FL.LoanID
INNER JOIN dw.DimCustomer DC
    ON R.CustomerID = DC.CustomerID;


SELECT COUNT(*) AS WarehouseRows
FROM dw.FactRepayment;

SELECT
    COUNT(*) AS NullPaymentDateKey
FROM dw.FactRepayment
WHERE PaymentDateKey IS NULL;


INSERT INTO dw.FactCollection
(
    LoanKey,
    CustomerKey,
    EmployeeKey,
    DateKey,
    OutstandingAmount,
    DaysPastDue,
    ContactAttempts,
    RecoveryAmount,
    RecoveryPercentage,
    CollectionStatus
)
SELECT
    FL.LoanKey,
    DC.CustomerKey,
    DE.EmployeeKey,
    CONVERT(INT, CONVERT(VARCHAR(8), C.CollectionStartDate, 112)),
    C.OutstandingAmount,
    C.DaysPastDue,
    C.ContactAttempts,
    C.RecoveryAmount,
    C.RecoveryPercentage,
    C.CollectionStatus
FROM WhitefieldBankDB.dbo.Collections C
INNER JOIN dw.FactLoan FL
    ON C.LoanID = FL.LoanID
INNER JOIN dw.DimCustomer DC
    ON C.CustomerID = DC.CustomerID
INNER JOIN dw.DimEmployee DE
    ON C.RecoveryOfficerID = DE.EmployeeID;

SELECT COUNT(*) AS TotalCollections
FROM dw.FactCollection;

SELECT TOP 10 *
FROM dw.FactCollection;


INSERT INTO dw.FactFraud
(
    FraudCaseID,
    TransactionKey,
    CustomerKey,
    BranchKey,
    MerchantKey,
    DateKey,
    FraudType,
    TransactionAmount,
    InvestigationDays,
    FraudStatus,
    RecoveredAmount,
    FinancialLoss
)
SELECT
    F.FraudCaseID,
    FT.TransactionKey,
    DC.CustomerKey,
    DB.BranchKey,
    DM.MerchantKey,
    CONVERT(INT, CONVERT(VARCHAR(8), F.TransactionDate, 112)),
    F.FraudType,
    F.TransactionAmount,
    F.InvestigationDays,
    F.FraudStatus,
    F.RecoveredAmount,
    F.FinancialLoss
FROM WhitefieldBankDB.dbo.FraudCases F
INNER JOIN dw.FactTransaction FT
    ON F.TransactionID = FT.TransactionID
INNER JOIN dw.DimCustomer DC
    ON F.CustomerID = DC.CustomerID
INNER JOIN dw.DimBranch DB
    ON F.BranchID = DB.BranchID
INNER JOIN dw.DimMerchant DM
    ON F.Merchant = DM.MerchantName;

SELECT
    SUM(SanctionedAmount) AS LoanPortfolio,
    SUM(OutstandingPrincipal) AS OutstandingPrincipal
FROM dw.FactLoan;