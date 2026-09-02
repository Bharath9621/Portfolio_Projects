CREATE DATABASE Hospital_Supply_Chain;

USE Hospital_Supply_Chain;

CREATE TABLE dbo.Hospitals
(
    Hospital_ID VARCHAR(10) NOT NULL,
    Hospital_Name VARCHAR(100) NOT NULL,
    City VARCHAR(50) NOT NULL,
    State VARCHAR(50) NOT NULL,
    Country VARCHAR(50) NOT NULL,
    Bed_Capacity INT NOT NULL,
    Hospital_Type VARCHAR(50) NOT NULL,
    Operational_Since DATE NOT NULL,
    Hospital_Tier VARCHAR(20) NOT NULL,
    Emergency_Level VARCHAR(20) NOT NULL,
    Trauma_Center VARCHAR(3) NOT NULL,
    Annual_Patient_Capacity INT NOT NULL,
    Annual_Procurement_Budget BIGINT NOT NULL,
    Warehouse_ID VARCHAR(10) NOT NULL,

    CONSTRAINT PK_Hospitals PRIMARY KEY (Hospital_ID)
);

SELECT COUNT(*) AS Total_Hospitals
FROM Hospitals;

CREATE TABLE dbo.Departments
(
    Department_ID VARCHAR(10) NOT NULL,
    Hospital_ID VARCHAR(10) NOT NULL,
    Hospital_Name VARCHAR(100) NOT NULL,
    Department_Name VARCHAR(100) NOT NULL,
    Cost_Center VARCHAR(20) NOT NULL,
    Floor INT NOT NULL,
    Bed_Capacity INT NOT NULL,
    Operating_Hours VARCHAR(30) NOT NULL,
    Critical_Department VARCHAR(3) NOT NULL,
    Department_Type VARCHAR(20) NOT NULL,

    CONSTRAINT PK_Departments PRIMARY KEY (Department_ID)
);

SELECT COUNT(*) AS Total_Departments
FROM Departments;

SELECT TOP (10) *
FROM Departments;

CREATE TABLE dbo.Vendors
(
    Vendor_ID VARCHAR(10) NOT NULL,
    Vendor_Name VARCHAR(100) NOT NULL,
    Vendor_Type VARCHAR(50) NOT NULL,
    Primary_Category VARCHAR(50) NOT NULL,
    Country VARCHAR(50) NOT NULL,
    City VARCHAR(50) NOT NULL,
    Lead_Time_Days INT NOT NULL,
    Vendor_Rating DECIMAL(3,1) NOT NULL,
    Quality_Score DECIMAL(5,2) NOT NULL,
    On_Time_Delivery_Percentage DECIMAL(5,2) NOT NULL,
    Payment_Terms VARCHAR(20) NOT NULL,
    Preferred_Vendor VARCHAR(3) NOT NULL,
    Contract_Start_Date DATE NOT NULL,
    Contract_End_Date DATE NOT NULL,
    Currency VARCHAR(10) NOT NULL,
    Minimum_Order_Value DECIMAL(18,2) NOT NULL,
    GST_Number VARCHAR(20) NOT NULL,
    Vendor_Status VARCHAR(20) NOT NULL,

    CONSTRAINT PK_Vendors PRIMARY KEY (Vendor_ID)
);

SELECT TOP (10) *
FROM Vendors;

CREATE TABLE dbo.Product_Master
(
    Product_ID VARCHAR(10) NOT NULL,
    SKU VARCHAR(20) NOT NULL,
    Product_Name VARCHAR(100) NOT NULL,
    Category VARCHAR(50) NOT NULL,
    Subcategory VARCHAR(50) NOT NULL,
    Brand VARCHAR(50) NOT NULL,
    Manufacturer VARCHAR(100) NOT NULL,
    Unit VARCHAR(20) NOT NULL,
    Unit_Cost DECIMAL(18,2) NOT NULL,
    Reorder_Level INT NOT NULL,
    Safety_Stock INT NOT NULL,
    Shelf_Life_Months INT NOT NULL,
    Storage_Type VARCHAR(50) NOT NULL,
    Critical_Item VARCHAR(3) NOT NULL,
    Disposable VARCHAR(3) NOT NULL,

    CONSTRAINT PK_Product_Master PRIMARY KEY (Product_ID)
);

SELECT TOP (10) *
FROM Product_Master;

CREATE TABLE dbo.Vendor_Product
(
    Vendor_Product_ID VARCHAR(10) NOT NULL,
    Vendor_ID VARCHAR(10) NOT NULL,
    Product_ID VARCHAR(10) NOT NULL,
    Negotiated_Unit_Cost DECIMAL(18,2) NOT NULL,
    Minimum_Order_Quantity INT NOT NULL,
    Lead_Time_Days INT NOT NULL,
    Preferred_Supplier VARCHAR(3) NOT NULL,
    Status VARCHAR(20) NOT NULL,

    CONSTRAINT PK_Vendor_Product PRIMARY KEY (Vendor_Product_ID)
);
SELECT TOP (10) *
FROM Vendor_Product;

CREATE TABLE dbo.Purchase_Orders
(
    PO_ID VARCHAR(15) NOT NULL,
    PO_Date DATE NOT NULL,
    Hospital_ID VARCHAR(10) NOT NULL,
    Department_ID VARCHAR(10) NOT NULL,
    Vendor_ID VARCHAR(10) NOT NULL,
    Buyer_Name VARCHAR(100) NOT NULL,
    Expected_Delivery_Date DATE NOT NULL,
    Actual_Delivery_Date DATE NOT NULL,
    PO_Status VARCHAR(20) NOT NULL,
    Total_PO_Value DECIMAL(18,2) NOT NULL,
    Payment_Status VARCHAR(20) NOT NULL,
    Approval_Status VARCHAR(20) NOT NULL,

    CONSTRAINT PK_Purchase_Orders PRIMARY KEY (PO_ID)
);

SELECT TOP (10) *
FROM Purchase_Orders;

CREATE TABLE dbo.Purchase_Order_Lines
(
    PO_Line_ID VARCHAR(15) NOT NULL,
    PO_ID VARCHAR(15) NOT NULL,
    Product_ID VARCHAR(10) NOT NULL,
    Quantity INT NOT NULL,
    Unit_Cost DECIMAL(18,2) NOT NULL,
    Line_Total DECIMAL(18,2) NOT NULL,

    CONSTRAINT PK_Purchase_Order_Lines PRIMARY KEY (PO_Line_ID)
);

SELECT TOP (10) *
FROM Purchase_Order_Lines;

CREATE TABLE dbo.Shipments
(
    Shipment_ID VARCHAR(15) NOT NULL,
    PO_ID VARCHAR(15) NOT NULL,
    Vendor_ID VARCHAR(10) NOT NULL,
    Hospital_ID VARCHAR(10) NOT NULL,
    Planned_Delivery_Date DATE NOT NULL,
    Actual_Delivery_Date DATE NOT NULL,
    Ordered_Quantity INT NOT NULL,
    Received_Quantity INT NOT NULL,
    Damaged_Quantity INT NOT NULL,
    Delivery_Variance_Days INT NOT NULL,
    Delivery_Status VARCHAR(30) NOT NULL,
    Transport_Mode VARCHAR(30) NOT NULL,
    Receiving_Status VARCHAR(30) NOT NULL,

    CONSTRAINT PK_Shipments PRIMARY KEY (Shipment_ID)
);

SELECT TOP (10) *
FROM Shipments;

CREATE TABLE dbo.Inventory
(
    Inventory_ID VARCHAR(15) NOT NULL,
    Hospital_ID VARCHAR(10) NOT NULL,
    Warehouse_ID VARCHAR(10) NOT NULL,
    Product_ID VARCHAR(10) NOT NULL,
    Current_Stock INT NOT NULL,
    Reorder_Level INT NOT NULL,
    Safety_Stock INT NOT NULL,
    Maximum_Stock INT NOT NULL,
    Inventory_Value DECIMAL(18,2) NOT NULL,
    Stock_Status VARCHAR(20) NOT NULL,

    CONSTRAINT PK_Inventory PRIMARY KEY (Inventory_ID)
);

SELECT TOP (10) *
FROM Inventory;

CREATE TABLE dbo.Financials
(
    Financial_ID VARCHAR(15) NOT NULL,
    PO_ID VARCHAR(15) NOT NULL,
    Vendor_ID VARCHAR(10) NOT NULL,
    Hospital_ID VARCHAR(10) NOT NULL,
    Department_ID VARCHAR(10) NOT NULL,
    Cost_Center VARCHAR(20) NOT NULL,
    Invoice_Number VARCHAR(30) NOT NULL,
    Invoice_Date DATE NOT NULL,
    Payment_Due_Date DATE NOT NULL,
    Payment_Date DATE NOT NULL,
    Transaction_Date DATE NOT NULL,
    Expense_Category VARCHAR(50) NOT NULL,
    Expense_Type VARCHAR(50) NOT NULL,
    Budget_Amount DECIMAL(18,2) NOT NULL,
    Actual_Amount DECIMAL(18,2) NOT NULL,
    Variance DECIMAL(18,2) NOT NULL,
    Variance_Percentage DECIMAL(8,2) NOT NULL,
    Payment_Method VARCHAR(30) NOT NULL,
    Payment_Status VARCHAR(20) NOT NULL,
    Fiscal_Year INT NOT NULL,
    Fiscal_Quarter VARCHAR(10) NOT NULL,
    Budget_Status VARCHAR(20) NOT NULL,

    CONSTRAINT PK_Financials PRIMARY KEY (Financial_ID)
);

DROP TABLE Financials;

CREATE TABLE dbo.Financials
(
    Financial_ID VARCHAR(15) NOT NULL,
    PO_ID VARCHAR(15) NOT NULL,
    Vendor_ID VARCHAR(10) NOT NULL,
    Hospital_ID VARCHAR(10) NOT NULL,
    Department_ID VARCHAR(10) NOT NULL,
    Cost_Center VARCHAR(20) NOT NULL,
    Invoice_Number VARCHAR(30) NOT NULL,
    Invoice_Date DATE NOT NULL,
    Payment_Due_Date DATE NOT NULL,
    Payment_Date DATE NULL, 
    Transaction_Date DATE NOT NULL,
    Expense_Category VARCHAR(50) NOT NULL,
    Expense_Type VARCHAR(50) NOT NULL,
    Budget_Amount DECIMAL(18,2) NOT NULL,
    Actual_Amount DECIMAL(18,2) NOT NULL,
    Variance DECIMAL(18,2) NOT NULL,
    Variance_Percentage DECIMAL(8,2) NOT NULL,
    Payment_Method VARCHAR(30) NOT NULL,
    Payment_Status VARCHAR(20) NOT NULL,
    Fiscal_Year VARCHAR(10) NOT NULL,
    Fiscal_Quarter VARCHAR(10) NOT NULL,
    Budget_Status VARCHAR(20) NOT NULL,

    CONSTRAINT PK_Financials PRIMARY KEY (Financial_ID)
);
SELECT TOP (10) *
FROM Financials;

CREATE TABLE dbo.Patients
(
    Patient_ID VARCHAR(15) NOT NULL,
    Hospital_ID VARCHAR(10) NOT NULL,
    Department_ID VARCHAR(10) NOT NULL,
    Age INT NOT NULL,
    Gender VARCHAR(10) NOT NULL,
    Admission_Date DATE NOT NULL,

    Discharge_Date DATE NULL,

    Length_of_Stay INT NOT NULL,
    Diagnosis VARCHAR(100) NOT NULL,
    Payment_Type VARCHAR(30) NOT NULL,
    Outcome VARCHAR(30) NOT NULL,

    CONSTRAINT PK_Patients PRIMARY KEY (Patient_ID)
);

SELECT TOP (10) *
FROM Patients;

CREATE TABLE dbo.Staff
(
    Staff_ID VARCHAR(15) NOT NULL,
    Hospital_ID VARCHAR(10) NOT NULL,
    Department_ID VARCHAR(10) NOT NULL,
    Job_Role VARCHAR(100) NOT NULL,
    Staff_Type VARCHAR(30) NOT NULL,
    Years_Experience INT NOT NULL,
    Shift VARCHAR(20) NOT NULL,
    Employment_Type VARCHAR(20) NOT NULL,
    Performance_Rating DECIMAL(3,2) NOT NULL,
    Status VARCHAR(20) NOT NULL,

    CONSTRAINT PK_Staff PRIMARY KEY (Staff_ID)
);

CREATE TABLE dbo.Date_Dimension
(
    Date_Key INT NOT NULL,
    [Date] DATE NOT NULL,
    [Day] TINYINT NOT NULL,
    Day_Name VARCHAR(15) NOT NULL,
    Week_Number TINYINT NOT NULL,
    [Month] TINYINT NOT NULL,
    Month_Name VARCHAR(20) NOT NULL,
    Quarter VARCHAR(5) NOT NULL,
    [Year] SMALLINT NOT NULL,
    Fiscal_Year VARCHAR(10) NOT NULL,
    Fiscal_Quarter VARCHAR(5) NOT NULL,
    Is_Weekend BIT NOT NULL,
    Is_Month_Start BIT NOT NULL,
    Day_Of_Year SMALLINT NOT NULL,

    CONSTRAINT PK_Date_Dimension PRIMARY KEY (Date_Key)
);

DROP TABLE Date_Dimension;

CREATE TABLE dbo.Date_Dimension
(
    Date_Key INT NOT NULL,
    [Date] DATE NOT NULL,
    [Day] TINYINT NOT NULL,
    Day_Name VARCHAR(15) NOT NULL,
    Week_Number TINYINT NOT NULL,
    [Month] TINYINT NOT NULL,
    Month_Name VARCHAR(20) NOT NULL,

    Quarter TINYINT NOT NULL,

    [Year] SMALLINT NOT NULL,

    Fiscal_Year VARCHAR(10) NOT NULL,
    Fiscal_Quarter VARCHAR(5) NOT NULL,

    Is_Weekend VARCHAR(3) NOT NULL,
    Is_Month_Start VARCHAR(3) NOT NULL,

    Day_Of_Year SMALLINT NOT NULL,

    CONSTRAINT PK_Date_Dimension PRIMARY KEY(Date_Key)
);

SELECT TOP (10) *
FROM Date_Dimension;

SELECT COUNT(*) FROM Hospitals;
SELECT COUNT(*) FROM Departments;
SELECT COUNT(*) FROM Vendors;
SELECT COUNT(*) FROM Product_Master;
SELECT COUNT(*) FROM Vendor_Product;
SELECT COUNT(*) FROM Purchase_Orders;
SELECT COUNT(*) FROM Purchase_Order_Lines;
SELECT COUNT(*) FROM Shipments;
SELECT COUNT(*) FROM Inventory;
SELECT COUNT(*) FROM Financials;
SELECT COUNT(*) FROM Patients;
SELECT COUNT(*) FROM Staff;
SELECT COUNT(*) FROM Date_Dimension;

SELECT Hospital_ID, COUNT(*)
FROM Hospitals
GROUP BY Hospital_ID
HAVING COUNT(*) > 1;

SELECT *
FROM Hospitals
WHERE Hospital_Name IS NULL;

SELECT *
FROM Inventory
WHERE Current_Stock < 0;

SELECT *
FROM Inventory
WHERE Current_Stock < 0;

SELECT
(SELECT COUNT(*) FROM Hospitals) AS Hospitals,
(SELECT COUNT(*) FROM Departments) AS Departments,
(SELECT COUNT(*) FROM Vendors) AS Vendors,
(SELECT COUNT(*) FROM Product_Master) AS Products,
(SELECT COUNT(*) FROM Vendor_Product) AS Vendor_Product,
(SELECT COUNT(*) FROM Purchase_Orders) AS Purchase_Orders,
(SELECT COUNT(*) FROM Purchase_Order_Lines) AS Purchase_Order_Lines,
(SELECT COUNT(*) FROM Shipments) AS Shipments,
(SELECT COUNT(*) FROM Inventory) AS Inventory,
(SELECT COUNT(*) FROM Financials) AS Financials,
(SELECT COUNT(*) FROM Patients) AS Patients,
(SELECT COUNT(*) FROM Staff) AS Staff,
(SELECT COUNT(*) FROM Date_Dimension) AS Date_Dimension;

ALTER TABLE Departments
ADD CONSTRAINT FK_Departments_Hospitals
FOREIGN KEY (Hospital_ID)
REFERENCES Hospitals(Hospital_ID);

ALTER TABLE Purchase_Orders
ADD CONSTRAINT FK_PO_Hospital
FOREIGN KEY (Hospital_ID)
REFERENCES Hospitals(Hospital_ID);

ALTER TABLE Purchase_Orders
ADD CONSTRAINT FK_PO_Department
FOREIGN KEY (Department_ID)
REFERENCES Departments(Department_ID);

ALTER TABLE Purchase_Orders
ADD CONSTRAINT FK_PO_Vendor
FOREIGN KEY (Vendor_ID)
REFERENCES Vendors(Vendor_ID);

ALTER TABLE Vendor_Product
ADD CONSTRAINT FK_VP_Vendor
FOREIGN KEY (Vendor_ID)
REFERENCES Vendors(Vendor_ID);

ALTER TABLE Vendor_Product
ADD CONSTRAINT FK_VP_Product
FOREIGN KEY (Product_ID)
REFERENCES Product_Master(Product_ID);

ALTER TABLE Purchase_Order_Lines
ADD CONSTRAINT FK_POL_PO
FOREIGN KEY (PO_ID)
REFERENCES Purchase_Orders(PO_ID);

ALTER TABLE Purchase_Order_Lines
ADD CONSTRAINT FK_POL_Product
FOREIGN KEY (Product_ID)
REFERENCES Product_Master(Product_ID);

ALTER TABLE Shipments
ADD CONSTRAINT FK_Shipment_PO
FOREIGN KEY (PO_ID)
REFERENCES Purchase_Orders(PO_ID);

ALTER TABLE Shipments
ADD CONSTRAINT FK_Shipment_Vendor
FOREIGN KEY (Vendor_ID)
REFERENCES Vendors(Vendor_ID);

ALTER TABLE Shipments
ADD CONSTRAINT FK_Shipment_Hospital
FOREIGN KEY (Hospital_ID)
REFERENCES Hospitals(Hospital_ID);

ALTER TABLE Inventory
ADD CONSTRAINT FK_Inventory_Hospital
FOREIGN KEY (Hospital_ID)
REFERENCES Hospitals(Hospital_ID);

ALTER TABLE Inventory
ADD CONSTRAINT FK_Inventory_Product
FOREIGN KEY (Product_ID)
REFERENCES Product_Master(Product_ID);

ALTER TABLE Financials
ADD CONSTRAINT FK_Fin_PO
FOREIGN KEY (PO_ID)
REFERENCES Purchase_Orders(PO_ID);

ALTER TABLE Financials
ADD CONSTRAINT FK_Fin_Vendor
FOREIGN KEY (Vendor_ID)
REFERENCES Vendors(Vendor_ID);

ALTER TABLE Financials
ADD CONSTRAINT FK_Fin_Hospital
FOREIGN KEY (Hospital_ID)
REFERENCES Hospitals(Hospital_ID);

ALTER TABLE Financials
ADD CONSTRAINT FK_Fin_Department
FOREIGN KEY (Department_ID)
REFERENCES Departments(Department_ID);

ALTER TABLE Patients
ADD CONSTRAINT FK_Patient_Hospital
FOREIGN KEY (Hospital_ID)
REFERENCES Hospitals(Hospital_ID);

ALTER TABLE Patients
ADD CONSTRAINT FK_Patient_Department
FOREIGN KEY (Department_ID)
REFERENCES Departments(Department_ID);

ALTER TABLE Staff
ADD CONSTRAINT FK_Staff_Hospital
FOREIGN KEY (Hospital_ID)
REFERENCES Hospitals(Hospital_ID);

ALTER TABLE Staff
ADD CONSTRAINT FK_Staff_Department
FOREIGN KEY (Department_ID)
REFERENCES Departments(Department_ID);

SELECT d.*
FROM Departments d
LEFT JOIN Hospitals h
ON d.Hospital_ID = h.Hospital_ID
WHERE h.Hospital_ID IS NULL;

SELECT po.*
FROM Purchase_Orders po
LEFT JOIN Hospitals h
ON po.Hospital_ID = h.Hospital_ID
WHERE h.Hospital_ID IS NULL;

SELECT po.*
FROM Purchase_Orders po
LEFT JOIN Departments d
ON po.Department_ID = d.Department_ID
WHERE d.Department_ID IS NULL;

SELECT *
FROM Departments d
WHERE NOT EXISTS (
    SELECT 1
    FROM Hospitals h
    WHERE h.Hospital_ID = d.Hospital_ID
);

SELECT *
FROM Purchase_Orders po
WHERE NOT EXISTS (
    SELECT 1
    FROM Vendors v
    WHERE v.Vendor_ID = po.Vendor_ID
);

SELECT
    fk.name AS ForeignKey,
    OBJECT_NAME(fk.parent_object_id) AS ChildTable,
    OBJECT_NAME(fk.referenced_object_id) AS ParentTable
FROM sys.foreign_keys fk
ORDER BY ChildTable;

/* Departments */
CREATE INDEX IX_Departments_Hospital
ON Departments(Hospital_ID);

/* Purchase Orders */
CREATE INDEX IX_PO_Hospital
ON Purchase_Orders(Hospital_ID);

CREATE INDEX IX_PO_Department
ON Purchase_Orders(Department_ID);

CREATE INDEX IX_PO_Vendor
ON Purchase_Orders(Vendor_ID);

CREATE INDEX IX_PO_Date
ON Purchase_Orders(PO_Date);

/* Purchase Order Lines */
CREATE INDEX IX_POL_PO
ON Purchase_Order_Lines(PO_ID);

CREATE INDEX IX_POL_Product
ON Purchase_Order_Lines(Product_ID);

/* Vendor Product */
CREATE INDEX IX_VP_Product
ON Vendor_Product(Product_ID);

CREATE INDEX IX_VP_Vendor
ON Vendor_Product(Vendor_ID);

/* Shipments */
CREATE INDEX IX_Shipment_PO
ON Shipments(PO_ID);

CREATE INDEX IX_Shipment_Hospital
ON Shipments(Hospital_ID);

CREATE INDEX IX_Shipment_Vendor
ON Shipments(Vendor_ID);

/* Inventory */
CREATE INDEX IX_Inventory_Product
ON Inventory(Product_ID);

CREATE INDEX IX_Inventory_Hospital
ON Inventory(Hospital_ID);

/* Financials */
CREATE INDEX IX_Financial_PO
ON Financials(PO_ID);

CREATE INDEX IX_Financial_Hospital
ON Financials(Hospital_ID);

CREATE INDEX IX_Financial_Department
ON Financials(Department_ID);

CREATE INDEX IX_Financial_Vendor
ON Financials(Vendor_ID);

/* Patients */
CREATE INDEX IX_Patient_Hospital
ON Patients(Hospital_ID);

CREATE INDEX IX_Patient_Department
ON Patients(Department_ID);

/* Staff */
CREATE INDEX IX_Staff_Hospital
ON Staff(Hospital_ID);

CREATE INDEX IX_Staff_Department
ON Staff(Department_ID);

CREATE VIEW vw_Purchase_Order_Summary
AS
SELECT
    po.PO_ID,
    po.PO_Date,

    h.Hospital_Name,
    h.City,
    h.State,

    d.Department_Name,

    v.Vendor_Name,
    v.Vendor_Type,

    po.Expected_Delivery_Date,
    po.Actual_Delivery_Date,

    po.PO_Status,
    po.Payment_Status,
    po.Approval_Status,

    po.Total_PO_Value

FROM Purchase_Orders po

INNER JOIN Hospitals h
ON po.Hospital_ID = h.Hospital_ID

INNER JOIN Departments d
ON po.Department_ID = d.Department_ID

INNER JOIN Vendors v
ON po.Vendor_ID = v.Vendor_ID;

SELECT TOP 20 *
FROM vw_Purchase_Order_Summary;

CREATE VIEW vw_Inventory_Status
AS
SELECT
    i.Inventory_ID,

    h.Hospital_Name,
    h.City,

    p.Product_ID,
    p.Product_Name,
    p.Category,
    p.Subcategory,
    p.Brand,

    i.Current_Stock,
    i.Reorder_Level,
    i.Safety_Stock,
    i.Maximum_Stock,

    i.Inventory_Value,
    i.Stock_Status,

    p.Critical_Item,
    p.Disposable

FROM Inventory i

INNER JOIN Hospitals h
    ON i.Hospital_ID = h.Hospital_ID

INNER JOIN Product_Master p
    ON i.Product_ID = p.Product_ID;

SELECT TOP (20) *
FROM vw_Inventory_Status;

CREATE VIEW vw_Vendor_Performance
AS
SELECT

    v.Vendor_ID,
    v.Vendor_Name,
    v.Vendor_Type,
    v.Primary_Category,

    v.Vendor_Rating,
    v.Quality_Score,
    v.On_Time_Delivery_Percentage,
    v.Lead_Time_Days,

    v.Preferred_Vendor,

    COUNT(DISTINCT vp.Product_ID) AS Products_Supplied,

    COUNT(DISTINCT po.PO_ID) AS Total_Purchase_Orders,

    ISNULL(SUM(po.Total_PO_Value),0) AS Total_Spend,

    AVG(s.Delivery_Variance_Days) AS Avg_Delivery_Variance,

    COUNT(DISTINCT s.Shipment_ID) AS Total_Shipments

FROM Vendors v

LEFT JOIN Vendor_Product vp
ON v.Vendor_ID = vp.Vendor_ID

LEFT JOIN Purchase_Orders po
ON v.Vendor_ID = po.Vendor_ID

LEFT JOIN Shipments s
ON po.PO_ID = s.PO_ID

GROUP BY

    v.Vendor_ID,
    v.Vendor_Name,
    v.Vendor_Type,
    v.Primary_Category,

    v.Vendor_Rating,
    v.Quality_Score,
    v.On_Time_Delivery_Percentage,
    v.Lead_Time_Days,

    v.Preferred_Vendor;

SELECT TOP 10
Vendor_Name,
Total_Spend
FROM vw_Vendor_Performance
ORDER BY Total_Spend DESC;

CREATE VIEW vw_Financial_Summary
AS
SELECT

    f.Financial_ID,

    f.Invoice_Number,
    f.Invoice_Date,
    f.Payment_Due_Date,
    f.Payment_Date,

    h.Hospital_Name,
    h.City,
    h.State,

    d.Department_Name,
    d.Cost_Center,

    v.Vendor_Name,
    v.Vendor_Type,

    f.Expense_Category,
    f.Expense_Type,

    f.Budget_Amount,
    f.Actual_Amount,
    f.Variance,
    f.Variance_Percentage,

    f.Payment_Method,
    f.Payment_Status,

    f.Fiscal_Year,
    f.Fiscal_Quarter,

    f.Budget_Status

FROM Financials f

INNER JOIN Hospitals h
ON f.Hospital_ID = h.Hospital_ID

INNER JOIN Departments d
ON f.Department_ID = d.Department_ID

INNER JOIN Vendors v
ON f.Vendor_ID = v.Vendor_ID;

SELECT TOP (20) *
FROM vw_Financial_Summary;

CREATE VIEW vw_Hospital_Operations
AS
SELECT

    h.Hospital_ID,
    h.Hospital_Name,
    h.City,
    h.State,
    h.Hospital_Type,
    h.Hospital_Tier,
    h.Bed_Capacity,

    COUNT(DISTINCT d.Department_ID) AS Total_Departments,

    COUNT(DISTINCT s.Staff_ID) AS Total_Staff,

    COUNT(DISTINCT p.Patient_ID) AS Total_Patients,

    AVG(CAST(p.Length_of_Stay AS FLOAT)) AS Avg_Length_of_Stay,

    AVG(CAST(s.Years_Experience AS FLOAT)) AS Avg_Staff_Experience,

    AVG(CAST(s.Performance_Rating AS FLOAT)) AS Avg_Staff_Performance

FROM Hospitals h

LEFT JOIN Departments d
ON h.Hospital_ID = d.Hospital_ID

LEFT JOIN Staff s
ON d.Department_ID = s.Department_ID

LEFT JOIN Patients p
ON d.Department_ID = p.Department_ID

GROUP BY

    h.Hospital_ID,
    h.Hospital_Name,
    h.City,
    h.State,
    h.Hospital_Type,
    h.Hospital_Tier,
    h.Bed_Capacity;

/* Procurement Analytics */
SELECT
    SUM(Total_PO_Value) AS Total_Procurement_Spend
FROM Purchase_Orders;

SELECT
    Hospital_Name,
    SUM(Total_PO_Value) AS Total_Spend
FROM vw_Purchase_Order_Summary
GROUP BY Hospital_Name
ORDER BY Total_Spend DESC;

SELECT
    Department_Name,
    SUM(Total_PO_Value) AS Total_Spend
FROM vw_Purchase_Order_Summary
GROUP BY Department_Name
ORDER BY Total_Spend DESC;

SELECT
    YEAR(PO_Date) AS Year,
    MONTH(PO_Date) AS Month,
    SUM(Total_PO_Value) AS Monthly_Spend
FROM Purchase_Orders
GROUP BY
    YEAR(PO_Date),
    MONTH(PO_Date)
ORDER BY
    Year,
    Month;

SELECT
    PO_Status,
    COUNT(*) AS Total_Orders
FROM Purchase_Orders
GROUP BY PO_Status;

SELECT
    AVG(Total_PO_Value) AS Average_PO_Value
FROM Purchase_Orders;

SELECT TOP (10)
    PO_ID,
    Hospital_Name,
    Vendor_Name,
    Total_PO_Value
FROM vw_Purchase_Order_Summary
ORDER BY Total_PO_Value DESC;

SELECT
    Vendor_Name,
    COUNT(*) AS Purchase_Order_Count
FROM vw_Purchase_Order_Summary
GROUP BY Vendor_Name
ORDER BY Purchase_Order_Count DESC;

SELECT
    PO_Status,
    COUNT(*) AS Orders
FROM Purchase_Orders
GROUP BY PO_Status;

SELECT
    AVG(Delivery_Variance_Days) AS Avg_Delivery_Delay
FROM Shipments;

/* Inventory Analytics*/
SELECT
    SUM(Inventory_Value) AS Total_Inventory_Value
FROM Inventory;

SELECT
    Hospital_Name,
    SUM(Inventory_Value) AS Inventory_Value
FROM vw_Inventory_Status
GROUP BY Hospital_Name
ORDER BY Inventory_Value DESC;

SELECT
    Hospital_Name,
    Product_Name,
    Current_Stock,
    Reorder_Level
FROM vw_Inventory_Status
WHERE Current_Stock < Reorder_Level
ORDER BY Hospital_Name;

SELECT
    Hospital_Name,
    Product_Name,
    Current_Stock,
    Safety_Stock
FROM vw_Inventory_Status
WHERE Critical_Item = 'Yes'
AND Current_Stock < Safety_Stock;

SELECT
    Category,
    SUM(Current_Stock) AS Total_Stock,
    SUM(Inventory_Value) AS Total_Value
FROM vw_Inventory_Status
GROUP BY Category
ORDER BY Total_Value DESC;

SELECT TOP (10)
    Product_Name,
    SUM(Inventory_Value) AS Inventory_Value
FROM vw_Inventory_Status
GROUP BY Product_Name
ORDER BY Inventory_Value DESC;

SELECT
    Stock_Status,
    COUNT(*) AS Products
FROM Inventory
GROUP BY Stock_Status;

SELECT
    Hospital_Name,
    SUM(Current_Stock) AS Total_Stock
FROM vw_Inventory_Status
GROUP BY Hospital_Name
ORDER BY Total_Stock;

SELECT
    Disposable,
    SUM(Current_Stock) AS Total_Stock,
    SUM(Inventory_Value) AS Total_Value
FROM vw_Inventory_Status
GROUP BY Disposable;

SELECT TOP (10)
    Product_Name,
    SUM(Current_Stock) AS Total_Stock
FROM vw_Inventory_Status
GROUP BY Product_Name
ORDER BY Total_Stock DESC;

/* Vendor Analytics */
SELECT
    Vendor_Name,
    SUM(Total_PO_Value) AS Total_Spend,
    RANK() OVER (
        ORDER BY SUM(Total_PO_Value) DESC
    ) AS Vendor_Rank
FROM vw_Purchase_Order_Summary
GROUP BY Vendor_Name;

WITH VendorSpend AS
(
    SELECT
        Vendor_Name,
        SUM(Total_PO_Value) AS Total_Spend,
        RANK() OVER(
            ORDER BY SUM(Total_PO_Value) DESC
        ) AS Vendor_Rank
    FROM vw_Purchase_Order_Summary
    GROUP BY Vendor_Name
)
SELECT *
FROM VendorSpend
WHERE Vendor_Rank <= 5;

SELECT
    Vendor_Name,
    AVG(Avg_Delivery_Variance) AS Avg_Delay
FROM vw_Vendor_Performance
GROUP BY Vendor_Name
ORDER BY Avg_Delay;

SELECT
    Vendor_Name,
    Avg_Delivery_Variance
FROM vw_Vendor_Performance
WHERE Avg_Delivery_Variance > 2
ORDER BY Avg_Delivery_Variance DESC;

SELECT
    Vendor_Name,
    Products_Supplied
FROM vw_Vendor_Performance
ORDER BY Products_Supplied DESC;

SELECT
    Vendor_Name,
    Vendor_Rating,
    Total_Spend
FROM vw_Vendor_Performance
ORDER BY Vendor_Rating DESC,
         Total_Spend DESC;

SELECT
    Vendor_Name,
    Lead_Time_Days,
    DENSE_RANK() OVER(
        ORDER BY Lead_Time_Days
    ) AS Lead_Time_Rank
FROM vw_Vendor_Performance;

SELECT *
FROM vw_Vendor_Performance
WHERE Preferred_Vendor='Yes'
ORDER BY Vendor_Rating DESC;

SELECT

    Vendor_Name,
    Total_Spend,
    ROUND(
        Total_Spend * 100.0 /
        SUM(Total_Spend) OVER(),
        2
    ) AS Spend_Percentage
FROM vw_Vendor_Performance
ORDER BY Spend_Percentage DESC;

SELECT

    Vendor_Name,
    Vendor_Rating,
    Quality_Score,
    On_Time_Delivery_Percentage,
    Lead_Time_Days,
    Total_Spend,
    Vendor_Rank =
    RANK() OVER(
        ORDER BY Vendor_Rating DESC,
                 Total_Spend DESC
    )

FROM vw_Vendor_Performance;

/*Financial Analytics*/

SELECT
    SUM(Actual_Amount) AS Total_Spend
FROM Financials;

SELECT
    Hospital_Name,
    SUM(Budget_Amount) AS Budget,
    SUM(Actual_Amount) AS Actual,
    SUM(Variance) AS Variance
FROM vw_Financial_Summary
GROUP BY Hospital_Name
ORDER BY Actual DESC;

SELECT
    Hospital_Name,
    SUM(Actual_Amount) AS Actual,
    SUM(Budget_Amount) AS Budget,
    ROUND(
        SUM(Actual_Amount) * 100.0 /
        SUM(Budget_Amount),
        2
    ) AS Budget_Utilization_Percentage
FROM vw_Financial_Summary
GROUP BY Hospital_Name;

SELECT
    Department_Name,
    SUM(Actual_Amount) AS Total_Spend,
    RANK() OVER(
        ORDER BY SUM(Actual_Amount) DESC
    ) AS Spend_Rank
FROM vw_Financial_Summary
GROUP BY Department_Name;


SELECT
    Fiscal_Year,
    Fiscal_Quarter,
    SUM(Actual_Amount) AS Quarterly_Spend
FROM vw_Financial_Summary
GROUP BY
    Fiscal_Year,
    Fiscal_Quarter
ORDER BY
    Fiscal_Year,
    Fiscal_Quarter;

SELECT
    Vendor_Name,
    Invoice_Number,
    Actual_Amount,
    Payment_Due_Date,
    DATEDIFF(
        DAY,
        Payment_Due_Date,
        GETDATE()
    ) AS Days_Overdue
FROM vw_Financial_Summary
WHERE Payment_Status = 'Pending'
ORDER BY Payment_Due_Date;

SELECT TOP (10)
    Invoice_Number,
    Vendor_Name,
    Hospital_Name,
    Actual_Amount,
    RANK() OVER(
        ORDER BY Actual_Amount DESC
    ) AS Invoice_Rank
FROM vw_Financial_Summary;

SELECT
    Expense_Category,
    COUNT(*) AS Transactions,
    SUM(Actual_Amount) AS Total_Spend,
    AVG(Actual_Amount) AS Avg_Spend
FROM vw_Financial_Summary
GROUP BY Expense_Category
ORDER BY Total_Spend DESC;

SELECT
    Vendor_Name,
    SUM(Actual_Amount) AS Total_Paid,
    COUNT(*) AS Invoice_Count,
    DENSE_RANK() OVER(
        ORDER BY SUM(Actual_Amount) DESC
    ) AS Vendor_Rank
FROM vw_Financial_Summary
GROUP BY Vendor_Name;

SELECT
    Invoice_Date,
    SUM(Actual_Amount) AS Daily_Spend,
    SUM(SUM(Actual_Amount))
    OVER(
        ORDER BY Invoice_Date
    ) AS Running_Total

FROM vw_Financial_Summary
GROUP BY Invoice_Date
ORDER BY Invoice_Date;

/*Hospital Operations Analytics */


SELECT
    Hospital_Name,
    Total_Patients
FROM vw_Hospital_Operations
ORDER BY Total_Patients DESC;

SELECT
    Hospital_Name,
    Avg_Length_of_Stay,
    RANK() OVER(
        ORDER BY Avg_Length_of_Stay DESC
    ) AS Stay_Rank
FROM vw_Hospital_Operations;

SELECT
    Hospital_Name,
    Total_Staff
FROM vw_Hospital_Operations
ORDER BY Total_Staff DESC;

SELECT
    Hospital_Name,
    Avg_Staff_Experience,
    DENSE_RANK() OVER(
        ORDER BY Avg_Staff_Experience DESC
    ) AS Experience_Rank
FROM vw_Hospital_Operations;

SELECT
    Hospital_Name,
    Avg_Staff_Performance,
    RANK() OVER(
        ORDER BY Avg_Staff_Performance DESC
    ) AS Performance_Rank
FROM vw_Hospital_Operations;

SELECT
    d.Department_Name,
    COUNT(p.Patient_ID) AS Patient_Count
FROM Patients p
JOIN Departments d
ON p.Department_ID = d.Department_ID
GROUP BY d.Department_Name
ORDER BY Patient_Count DESC;

SELECT
    Gender,
    COUNT(*) AS Total_Patients,
    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER(),
        2
    ) AS Percentage
FROM Patients
GROUP BY Gender;

SELECT
    d.Department_Name,
    AVG(p.Age) AS Average_Age
FROM Patients p
JOIN Departments d
ON p.Department_ID = d.Department_ID
GROUP BY d.Department_Name
ORDER BY Average_Age DESC;

SELECT
    Outcome,
    COUNT(*) AS Total_Patients,
    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER(),
        2
    ) AS Percentage
FROM Patients
GROUP BY Outcome
ORDER BY Total_Patients DESC;

SELECT
    Hospital_Name,
    Total_Patients,
    Total_Staff,
    Avg_Length_of_Stay,
    Avg_Staff_Experience,
    Avg_Staff_Performance,
    RANK() OVER(
        ORDER BY
            Total_Patients DESC,
            Avg_Staff_Performance DESC
    ) AS Overall_Rank
FROM vw_Hospital_Operations;

SELECT
    Department_ID,
    SUM(Total_PO_Value) AS TotalSpend
FROM Purchase_Orders
GROUP BY Department_ID
ORDER BY TotalSpend DESC;

SELECT
    Department_ID,
    SUM(Actual_Amount) AS TotalSpend
FROM Financials
GROUP BY Department_ID
ORDER BY TotalSpend DESC;

SELECT
    COUNT(*) AS TotalPOs,
    SUM(Total_PO_Value) AS TotalSpend,
    AVG(Total_PO_Value) AS AvgPOValue
FROM Purchase_Orders;

SELECT
    COUNT(*) AS Total_Shipments,
    SUM(CASE
            WHEN Delivery_Status IN ('Delivered', 'Early') THEN 1
            ELSE 0
        END) AS OnTime_Shipments,
    CAST(
        100.0 * SUM(CASE
                        WHEN Delivery_Status IN ('Delivered', 'Early') THEN 1
                        ELSE 0
                    END)
        / COUNT(*)
        AS DECIMAL(5,2)
    ) AS OnTime_Delivery_Percentage
FROM Shipments;