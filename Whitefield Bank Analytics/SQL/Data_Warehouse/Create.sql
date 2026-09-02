CREATE DATABASE WhitefieldBankDW;
USE WhitefieldBankDW;

CREATE SCHEMA dw;

CREATE TABLE dw.DimDate
(
    DateKey INT NOT NULL PRIMARY KEY,
    FullDate DATE NOT NULL,
    DayNumber TINYINT NOT NULL,
    DayName VARCHAR(20) NOT NULL,
    WeekNumber TINYINT NOT NULL,
    MonthNumber TINYINT NOT NULL,
    MonthName VARCHAR(20) NOT NULL,
    QuarterNumber TINYINT NOT NULL,
    QuarterName VARCHAR(10) NOT NULL,
    YearNumber SMALLINT NOT NULL,
    FiscalMonth TINYINT NOT NULL,
    FiscalQuarter VARCHAR(10) NOT NULL,
    FiscalYear SMALLINT NOT NULL,
    IsWeekend BIT NOT NULL,
    IsMonthStart BIT NOT NULL,
    IsMonthEnd BIT NOT NULL
);

DECLARE @StartDate DATE = '2020-01-01';
DECLARE @EndDate DATE = '2035-12-31';

WHILE @StartDate <= @EndDate
BEGIN
    INSERT INTO dw.DimDate
    (
        DateKey,
        FullDate,
        DayNumber,
        DayName,
        WeekNumber,
        MonthNumber,
        MonthName,
        QuarterNumber,
        QuarterName,
        YearNumber,
        FiscalMonth,
        FiscalQuarter,
        FiscalYear,
        IsWeekend,
        IsMonthStart,
        IsMonthEnd
    )
    VALUES
    (
        CONVERT(INT, FORMAT(@StartDate, 'yyyyMMdd')),
        @StartDate,
        DAY(@StartDate),
        DATENAME(WEEKDAY, @StartDate),
        DATEPART(WEEK, @StartDate),
        MONTH(@StartDate),
        DATENAME(MONTH, @StartDate),
        DATEPART(QUARTER, @StartDate),
        CONCAT('Q', DATEPART(QUARTER, @StartDate)),
        YEAR(@StartDate),
        MONTH(@StartDate),
        CONCAT('Q', DATEPART(QUARTER, @StartDate)),
        YEAR(@StartDate),
        CASE WHEN DATENAME(WEEKDAY, @StartDate) IN ('Saturday', 'Sunday') THEN 1 ELSE 0 END,
        CASE WHEN DAY(@StartDate) = 1 THEN 1 ELSE 0 END,
        CASE WHEN @StartDate = EOMONTH(@StartDate) THEN 1 ELSE 0 END
    );

    SET @StartDate = DATEADD(DAY, 1, @StartDate);
END;

SELECT COUNT(*) FROM dw.DimDate;

SELECT TOP 10 *
FROM dw.DimDate
ORDER BY FullDate;

SELECT TOP 10 *
FROM dw.DimDate
ORDER BY FullDate DESC;

CREATE TABLE dw.DimBranch
(
    BranchKey INT IDENTITY(1,1) PRIMARY KEY,
    BranchID VARCHAR(20) NOT NULL,
    BranchCode VARCHAR(20) NOT NULL,
    BranchName VARCHAR(100) NOT NULL,
    IFSCCode VARCHAR(20) NOT NULL,
    BranchType VARCHAR(30) NOT NULL,
    Region VARCHAR(30) NOT NULL,
    State VARCHAR(50) NOT NULL,
    City VARCHAR(50) NOT NULL,
    Pincode VARCHAR(10) NOT NULL,
    Address VARCHAR(255) NOT NULL,
    OpeningDate DATE NOT NULL,
    ManagerID VARCHAR(20),
    Latitude DECIMAL(10,6),
    Longitude DECIMAL(10,6),
    IsActive BIT NOT NULL,
    CreatedDate DATETIME2 DEFAULT GETDATE()
);

CREATE TABLE dw.DimCustomer
(
    CustomerKey INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID VARCHAR(20) NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Gender VARCHAR(10),
    DateOfBirth DATE,
    Age TINYINT,
    PAN VARCHAR(20),
    Aadhaar VARCHAR(20),
    Mobile VARCHAR(20),
    Email VARCHAR(100),
    Occupation VARCHAR(50),
    EmploymentType VARCHAR(30),
    AnnualIncome DECIMAL(18,2),
    CreditScore SMALLINT,
    MaritalStatus VARCHAR(20),
    City VARCHAR(50),
    State VARCHAR(50),
    Pincode VARCHAR(10),
    CustomerSince DATE,
    KYCStatus VARCHAR(20),
    PreferredChannel VARCHAR(50),
    BranchID VARCHAR(20),
    IsActive BIT,
    CreatedDate DATETIME2 DEFAULT GETDATE()
);

CREATE TABLE dw.DimEmployee
(
    EmployeeKey INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeID VARCHAR(20) NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Designation VARCHAR(100),
    Department VARCHAR(50),
    BranchID VARCHAR(20),
    ManagerID VARCHAR(20),
    DateOfJoining DATE,
    AnnualSalaryINR DECIMAL(18,2),
    PerformanceRating DECIMAL(3,1),
    EmploymentStatus VARCHAR(20),
    Email VARCHAR(100),
    Phone VARCHAR(20),
    LoanOfficerFlag BIT,
    CreatedDate DATETIME2 DEFAULT GETDATE()
);

CREATE TABLE dw.DimLoanType
(
    LoanTypeKey INT IDENTITY(1,1) PRIMARY KEY,
    LoanType VARCHAR(50) NOT NULL,
    CreatedDate DATETIME2 DEFAULT GETDATE()
);

CREATE TABLE dw.DimChannel
(
    ChannelKey INT IDENTITY(1,1) PRIMARY KEY,
    ChannelName VARCHAR(50) NOT NULL,
    CreatedDate DATETIME2 DEFAULT GETDATE()
);

CREATE TABLE dw.DimMerchant
(
    MerchantKey INT IDENTITY(1,1) PRIMARY KEY,
    MerchantName VARCHAR(100) NOT NULL,
    CreatedDate DATETIME2 DEFAULT GETDATE()
);

CREATE TABLE dw.FactLoan
(
    LoanKey INT IDENTITY(1,1) PRIMARY KEY,
    LoanID VARCHAR(20) NOT NULL,
    CustomerKey INT NOT NULL,
    BranchKey INT NOT NULL,
    LoanTypeKey INT NOT NULL,
    ProductKey INT NOT NULL,
    SanctionDateKey INT NOT NULL,
    DisbursementDateKey INT NOT NULL,
    SanctionedAmount DECIMAL(18,2),
    InterestRate DECIMAL(5,2),
    TenureMonths INT,
    EMI DECIMAL(18,2),
    OutstandingPrincipal DECIMAL(18,2),
    LoanStatus VARCHAR(20)
);

CREATE TABLE dw.FactTransaction
(
    TransactionKey INT IDENTITY(1,1) PRIMARY KEY,
    TransactionID VARCHAR(20) NOT NULL,
    CustomerKey INT NOT NULL,
    BranchKey INT NOT NULL,
    DateKey INT NOT NULL,
    ChannelKey INT NOT NULL,
    MerchantKey INT NOT NULL,
    TransactionType VARCHAR(30),
    DebitCredit VARCHAR(10),
    Amount DECIMAL(18,2),
    FraudFlag BIT
);

CREATE TABLE dw.FactRepayment
(
    RepaymentKey INT IDENTITY(1,1) PRIMARY KEY,
    RepaymentID VARCHAR(20) NOT NULL,
    LoanKey INT NOT NULL,
    CustomerKey INT NOT NULL,
    DueDateKey INT NOT NULL,
    PaymentDateKey INT NOT NULL,
    EMINumber INT,
    EMIAmount DECIMAL(18,2),
    PrincipalPaid DECIMAL(18,2),
    InterestPaid DECIMAL(18,2),
    OutstandingBalance DECIMAL(18,2),
    PaymentStatus VARCHAR(20),
    DaysPastDue INT
);

CREATE TABLE dw.FactCollection
(
    CollectionKey INT IDENTITY(1,1) PRIMARY KEY,
    LoanKey INT NOT NULL,
    CustomerKey INT NOT NULL,
    EmployeeKey INT NOT NULL,
    DateKey INT NOT NULL,
    OutstandingAmount DECIMAL(18,2),
    DaysPastDue INT,
    ContactAttempts INT,
    RecoveryAmount DECIMAL(18,2),
    RecoveryPercentage DECIMAL(5,2),
    CollectionStatus VARCHAR(20)
);

CREATE TABLE dw.FactFraud
(
    FraudKey INT IDENTITY(1,1) PRIMARY KEY,
    FraudCaseID VARCHAR(20) NOT NULL,
    TransactionKey INT NOT NULL,
    CustomerKey INT NOT NULL,
    BranchKey INT NOT NULL,
    MerchantKey INT NOT NULL,
    DateKey INT NOT NULL,
    FraudType VARCHAR(50),
    TransactionAmount DECIMAL(18,2),
    InvestigationDays INT,
    FraudStatus VARCHAR(20),
    RecoveredAmount DECIMAL(18,2),
    FinancialLoss DECIMAL(18,2)
);


CREATE TABLE dw.DimProduct
(
    ProductKey INT IDENTITY(1,1) PRIMARY KEY,
    ProductID VARCHAR(20) NOT NULL,
    LoanType VARCHAR(50),
    CreatedDate DATETIME2 DEFAULT GETDATE()
);

INSERT INTO dw.DimProduct(ProductID, LoanType)
SELECT DISTINCT ProductID, LoanType
FROM WhitefieldBankDB.dbo.Loans;

DROP TABLE dw.FactRepayment;

CREATE TABLE dw.FactRepayment
(
    RepaymentKey INT IDENTITY(1,1) PRIMARY KEY,
    RepaymentID VARCHAR(20) NOT NULL,
    LoanKey INT NOT NULL,
    CustomerKey INT NOT NULL,
    DueDateKey INT NOT NULL,
    PaymentDateKey INT NULL,
    EMINumber INT NOT NULL,
    EMIAmount DECIMAL(18,2) NOT NULL,
    PrincipalPaid DECIMAL(18,2) NOT NULL,
    InterestPaid DECIMAL(18,2) NOT NULL,
    OutstandingBalance DECIMAL(18,2) NOT NULL,
    PaymentStatus VARCHAR(20) NOT NULL,
    DaysPastDue INT NOT NULL
);
