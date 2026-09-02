CREATE DATABASE WhitefieldBankDB;
USE WhitefieldBankDB;

CREATE TABLE Branches
(
    BranchID            VARCHAR(10) PRIMARY KEY,
    BranchCode          VARCHAR(10) NOT NULL,
    BranchName          VARCHAR(100) NOT NULL,
    IFSCCode            VARCHAR(15) UNIQUE,
    BranchType          VARCHAR(30),
    Region              VARCHAR(30),
    State               VARCHAR(50),
    City                VARCHAR(50),
    Pincode             VARCHAR(10),
    Address             VARCHAR(255),
    OpeningDate         DATE,
    ManagerID           VARCHAR(15),
    Latitude            DECIMAL(9,6),
    Longitude           DECIMAL(9,6),
    IsActive            BIT DEFAULT 1
);

CREATE TABLE Employees
(
    EmployeeID          VARCHAR(15) PRIMARY KEY,
    FirstName           VARCHAR(50),
    LastName            VARCHAR(50),
    Designation         VARCHAR(50),
    Department          VARCHAR(50),
    BranchID            VARCHAR(10),
    ManagerID           VARCHAR(15),
    DateOfJoining       DATE,
    AnnualSalaryINR     DECIMAL(18,2),
    PerformanceRating   DECIMAL(3,1),
    EmploymentStatus    VARCHAR(20),
    Email               VARCHAR(100),
    Phone               VARCHAR(15),
    LoanOfficerFlag     BIT
);

CREATE TABLE Customers
(
    CustomerID          VARCHAR(15) PRIMARY KEY,
    FirstName           VARCHAR(50),
    LastName            VARCHAR(50),
    Gender              VARCHAR(10),
    DateOfBirth         DATE,
    Age                 INT,
    PAN                 VARCHAR(10),
    Aadhaar             VARCHAR(12),
    Mobile              VARCHAR(15),
    Email               VARCHAR(100),
    Occupation          VARCHAR(60),
    EmploymentType      VARCHAR(30),
    AnnualIncome        DECIMAL(18,2),
    CreditScore         INT,
    MaritalStatus       VARCHAR(20),
    City                VARCHAR(50),
    State               VARCHAR(50),
    Pincode             VARCHAR(10),
    CustomerSince       DATE,
    KYCStatus           VARCHAR(20),
    PreferredChannel    VARCHAR(30),
    BranchID            VARCHAR(10),
    IsActive            BIT DEFAULT 1
);

CREATE TABLE LoanApplications
(
    ApplicationID       VARCHAR(15) PRIMARY KEY,
    CustomerID          VARCHAR(15),
    BranchID            VARCHAR(10),
    ProductID           VARCHAR(10),
    LoanType            VARCHAR(50),
    ApplicationDate     DATE,
    RequestedAmount     DECIMAL(18,2),
    AnnualIncome        DECIMAL(18,2),
    CreditScore         INT,
    Status              VARCHAR(20),
    DecisionDate        DATE,
    Channel             VARCHAR(30),
    LoanOfficerID       VARCHAR(15)
);

CREATE TABLE Loans
(
    LoanID                  VARCHAR(15) PRIMARY KEY,
    ApplicationID           VARCHAR(15),
    CustomerID              VARCHAR(15),
    BranchID                VARCHAR(10),
    ProductID               VARCHAR(10),
    LoanType                VARCHAR(50),
    SanctionDate            DATE,
    DisbursementDate        DATE,
    SanctionedAmount        DECIMAL(18,2),
    InterestRate            DECIMAL(5,2),
    TenureMonths            INT,
    EMI                     DECIMAL(18,2),
    OutstandingPrincipal    DECIMAL(18,2),
    LoanStatus              VARCHAR(20)
);

CREATE TABLE Transactions
(
    TransactionID           VARCHAR(20) PRIMARY KEY,
    CustomerID              VARCHAR(15),
    BranchID                VARCHAR(10),
    TransactionDateTime     DATETIME2,
    TransactionType         VARCHAR(40),
    DebitCredit             VARCHAR(10),
    Amount                  DECIMAL(18,2),
    Channel                 VARCHAR(40),
    Merchant                VARCHAR(100),
    City                    VARCHAR(50),
    State                   VARCHAR(50),
    FraudFlag               BIT
);

CREATE TABLE Repayments
(
    RepaymentID             VARCHAR(20) PRIMARY KEY,
    LoanID                  VARCHAR(15),
    CustomerID              VARCHAR(15),
    EMINumber               INT,
    DueDate                 DATE,
    PaymentDate             DATE,
    EMIAmount               DECIMAL(18,2),
    PrincipalPaid           DECIMAL(18,2),
    InterestPaid            DECIMAL(18,2),
    OutstandingBalance      DECIMAL(18,2),
    PaymentStatus           VARCHAR(20),
    DaysPastDue             INT,
    PaymentMode             VARCHAR(30),
    CollectionRequired      VARCHAR(10)
);

CREATE TABLE Collections
(
    CollectionID            VARCHAR(20) PRIMARY KEY,
    LoanID                  VARCHAR(15),
    CustomerID              VARCHAR(15),
    RepaymentID             VARCHAR(20),
    RecoveryOfficerID       VARCHAR(15),
    CollectionStartDate     DATE,
    DaysPastDue             INT,
    OutstandingAmount       DECIMAL(18,2),
    ContactAttempts         INT,
    CollectionStage         VARCHAR(30),
    RecoveryAmount          DECIMAL(18,2),
    RecoveryDate            DATE,
    CollectionStatus        VARCHAR(20),
    RecoveryPercentage      DECIMAL(5,2)
);

CREATE TABLE FraudCases
(
    FraudCaseID             VARCHAR(20) PRIMARY KEY,
    TransactionID           VARCHAR(20),
    CustomerID              VARCHAR(15),
    BranchID                VARCHAR(10),
    FraudType               VARCHAR(50),
    TransactionAmount       DECIMAL(18,2),
    TransactionDate         DATETIME2,
    DetectionDate           DATETIME2,
    InvestigationDays       INT,
    FraudStatus             VARCHAR(30),
    RecoveredAmount         DECIMAL(18,2),
    FinancialLoss           DECIMAL(18,2),
    FraudChannel            VARCHAR(40),
    Merchant                VARCHAR(100)
);

delete from dbo.Loans;
ALTER TABLE dbo.Repayments NOCHECK CONSTRAINT FK_Repayments_Loans;
DELETE FROM dbo.Loans;
DELETE FROM dbo.Repayments;
DELETE FROM dbo.Collections;
DELETE FROM dbo.Loans;

SELECT
    COUNT(*) AS LoanCount,
    SUM(SanctionedAmount) AS LoanPortfolio,
    SUM(OutstandingPrincipal) AS OutstandingPrincipal
FROM dbo.Loans;

SELECT
    COLUMN_NAME,
    DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Repayments';

SELECT
COLUMN_NAME,
IS_NULLABLE,
DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Repayments';

BULK INSERT dbo.Collections
FROM 'C:\Users\Bharath Venkatesh\Downloads\Whitefield Bank\raw\Collections.csv'
WITH
(
    FORMAT='CSV',
    FIRSTROW = 2,
    TABLOCK,
    KEEPNULLS
);

SELECT COUNT(*) AS Loans FROM dbo.Loans;
SELECT COUNT(*) AS Repayments FROM dbo.Repayments;
SELECT COUNT(*) AS Collections FROM dbo.Collections;

SELECT COUNT(*)
FROM dbo.Repayments r
LEFT JOIN dbo.Loans l
ON r.LoanID = l.LoanID
WHERE l.LoanID IS NULL;

SELECT COUNT(*)
FROM dbo.Collections c
LEFT JOIN dbo.Loans l
ON c.LoanID = l.LoanID
WHERE l.LoanID IS NULL;