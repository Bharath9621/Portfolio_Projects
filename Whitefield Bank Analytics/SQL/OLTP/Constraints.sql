use WhitefieldBankDB;

ALTER TABLE Employees
ADD CONSTRAINT FK_Employees_Branches
FOREIGN KEY (BranchID)
REFERENCES Branches(BranchID);

ALTER TABLE Customers
ADD CONSTRAINT FK_Customers_Branches
FOREIGN KEY (BranchID)
REFERENCES Branches(BranchID);

ALTER TABLE LoanApplications
ADD CONSTRAINT FK_LoanApplications_Customers
FOREIGN KEY (CustomerID)
REFERENCES Customers(CustomerID);

ALTER TABLE LoanApplications
ADD CONSTRAINT FK_LoanApplications_Branches
FOREIGN KEY (BranchID)
REFERENCES Branches(BranchID);

ALTER TABLE LoanApplications
ADD CONSTRAINT FK_LoanApplications_Employees
FOREIGN KEY (LoanOfficerID)
REFERENCES Employees(EmployeeID);

ALTER TABLE Loans
ADD CONSTRAINT FK_Loans_Applications
FOREIGN KEY (ApplicationID)
REFERENCES LoanApplications(ApplicationID);

ALTER TABLE Loans
ADD CONSTRAINT FK_Loans_Customers
FOREIGN KEY (CustomerID)
REFERENCES Customers(CustomerID);

ALTER TABLE Loans
ADD CONSTRAINT FK_Loans_Branches
FOREIGN KEY (BranchID)
REFERENCES Branches(BranchID);

ALTER TABLE Transactions
ADD CONSTRAINT FK_Transactions_Customers
FOREIGN KEY (CustomerID)
REFERENCES Customers(CustomerID);

ALTER TABLE Transactions
ADD CONSTRAINT FK_Transactions_Branches
FOREIGN KEY (BranchID)
REFERENCES Branches(BranchID);

ALTER TABLE Repayments
ADD CONSTRAINT FK_Repayments_Loans
FOREIGN KEY (LoanID)
REFERENCES Loans(LoanID);

ALTER TABLE Repayments
ADD CONSTRAINT FK_Repayments_Customers
FOREIGN KEY (CustomerID)
REFERENCES Customers(CustomerID);

ALTER TABLE Collections
ADD CONSTRAINT FK_Collections_Loans
FOREIGN KEY (LoanID)
REFERENCES Loans(LoanID);

ALTER TABLE Collections
ADD CONSTRAINT FK_Collections_Customers
FOREIGN KEY (CustomerID)
REFERENCES Customers(CustomerID);

ALTER TABLE Collections
ADD CONSTRAINT FK_Collections_Repayments
FOREIGN KEY (RepaymentID)
REFERENCES Repayments(RepaymentID);

ALTER TABLE Collections
ADD CONSTRAINT FK_Collections_Employees
FOREIGN KEY (RecoveryOfficerID)
REFERENCES Employees(EmployeeID);

ALTER TABLE FraudCases
ADD CONSTRAINT FK_FraudCases_Transactions
FOREIGN KEY (TransactionID)
REFERENCES Transactions(TransactionID);

ALTER TABLE FraudCases
ADD CONSTRAINT FK_FraudCases_Customers
FOREIGN KEY (CustomerID)
REFERENCES Customers(CustomerID);

ALTER TABLE FraudCases
ADD CONSTRAINT FK_FraudCases_Branches
FOREIGN KEY (BranchID)
REFERENCES Branches(BranchID);
