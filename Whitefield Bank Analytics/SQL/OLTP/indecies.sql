USE WhitefieldBankDB;

CREATE NONCLUSTERED INDEX IX_Customers_BranchID
ON Customers (BranchID);

CREATE NONCLUSTERED INDEX IX_Customers_CreditScore
ON Customers (CreditScore);

CREATE NONCLUSTERED INDEX IX_Customers_City_State
ON Customers (State, City);

CREATE NONCLUSTERED INDEX IX_Employees_BranchID
ON Employees (BranchID);

CREATE NONCLUSTERED INDEX IX_Employees_Department
ON Employees (Department);

CREATE NONCLUSTERED INDEX IX_LoanApplications_CustomerID
ON LoanApplications (CustomerID);

CREATE NONCLUSTERED INDEX IX_LoanApplications_Status
ON LoanApplications (Status);

CREATE NONCLUSTERED INDEX IX_LoanApplications_Date
ON LoanApplications (ApplicationDate);

CREATE NONCLUSTERED INDEX IX_Loans_CustomerID
ON Loans (CustomerID);

CREATE NONCLUSTERED INDEX IX_Loans_Status
ON Loans (LoanStatus);

CREATE NONCLUSTERED INDEX IX_Loans_BranchID
ON Loans (BranchID);

CREATE NONCLUSTERED INDEX IX_Loans_LoanType
ON Loans (LoanType);

CREATE NONCLUSTERED INDEX IX_Transactions_CustomerID
ON Transactions (CustomerID);

CREATE NONCLUSTERED INDEX IX_Transactions_Date
ON Transactions (TransactionDateTime);

CREATE NONCLUSTERED INDEX IX_Transactions_Channel
ON Transactions (Channel);

CREATE NONCLUSTERED INDEX IX_Transactions_Fraud
ON Transactions (FraudFlag);

CREATE NONCLUSTERED INDEX IX_Repayments_LoanID
ON Repayments (LoanID);

CREATE NONCLUSTERED INDEX IX_Repayments_CustomerID
ON Repayments (CustomerID);

CREATE NONCLUSTERED INDEX IX_Repayments_Status
ON Repayments (PaymentStatus);

CREATE NONCLUSTERED INDEX IX_Repayments_DPD
ON Repayments (DaysPastDue);

CREATE NONCLUSTERED INDEX IX_Collections_LoanID
ON Collections (LoanID);

CREATE NONCLUSTERED INDEX IX_Collections_Status
ON Collections (CollectionStatus);

CREATE NONCLUSTERED INDEX IX_FraudCases_Status
ON FraudCases (FraudStatus);

CREATE NONCLUSTERED INDEX IX_FraudCases_Type
ON FraudCases (FraudType);

CREATE NONCLUSTERED INDEX IX_FraudCases_Customer
ON FraudCases (CustomerID);
