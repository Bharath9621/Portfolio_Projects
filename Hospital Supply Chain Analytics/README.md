# 🏥 Hospital Supply Chain Analytics

An end-to-end Business Intelligence project that simulates a real-world hospital supply chain environment using SQL Server, Python, and Power BI. The project provides comprehensive analytics across procurement, inventory, finance, logistics, and vendor performance through interactive dashboards and a well-structured relational database.

---

# 📌 Project Overview

Efficient supply chain management is critical for hospitals to ensure uninterrupted patient care while optimizing operational costs. This project demonstrates how Business Intelligence can be used to monitor procurement activities, manage inventory, evaluate supplier performance, and analyze financial operations.

Since a comprehensive hospital supply chain dataset covering procurement, inventory, finance, logistics, and hospital operations was not publicly available, a realistic synthetic dataset was created based on real-world business scenarios and relational database principles. The dataset was validated, modeled in SQL Server, and analyzed using Power BI to build a complete Business Intelligence solution.

---

# 🎯 Business Objectives

This project was designed to help answer key business questions such as:

- Which hospitals contribute the highest procurement spend?
- Which departments exceed their allocated budgets?
- Which products require immediate replenishment?
- Which vendors deliver on time consistently?
- What are the monthly procurement trends?
- How efficiently is inventory being managed?
- Which suppliers contribute the highest procurement value?
- How do procurement and logistics performance vary across hospitals?

---

# 🚀 Business Problems Solved

### Procurement Visibility
Developed executive dashboards to monitor procurement spending, purchase orders, and vendor contributions across multiple hospitals.

### Budget Monitoring
Enabled finance teams to compare budgeted versus actual expenditure and identify departments operating above budget.

### Inventory Optimization
Built inventory dashboards to monitor stock availability, identify low-stock products, and support replenishment planning.

### Vendor Performance Evaluation
Measured supplier performance using KPIs such as on-time delivery percentage, delivery delays, shipment status, and procurement value.

### Centralized Decision Support
Integrated procurement, finance, inventory, and logistics data into a unified reporting platform for executive decision-making.

### Data Quality Assurance
Performed validation checks including missing values, duplicate records, data types, primary key uniqueness, and foreign key integrity before loading data into SQL Server.

---

# 🛠 Technology Stack

| Technology | Purpose |
|------------|---------|
| Python | Data validation and SQL data loading |
| Pandas | Data manipulation |
| SQL Server | Relational database |
| SQLAlchemy | Data import into SQL Server |
| SQL Server Management Studio (SSMS) | Database management |
| Power BI Desktop | Dashboard development |
| DAX | KPI calculations and business metrics |
| Git & GitHub | Version control and project hosting |

---

# 📂 Project Architecture

```
Synthetic Hospital Supply Chain Dataset
                │
                ▼
      Data Validation (Python)
                │
                ▼
      SQL Server Database
                │
                ▼
 Relational Data Modeling
                │
                ▼
 Interactive Power BI Dashboards
                │
                ▼
 Business Insights & Decision Support
```

---

# 🗄 Database Design

The project follows a relational database design with interconnected master and transactional tables.

### Master Tables

- Hospitals
- Departments
- Vendors
- Product Master
- Warehouses
- Vendor Products
- Date Dimension

### Transaction Tables

- Purchase Orders
- Purchase Order Lines
- Shipments
- Inventory
- Financials
- Patients
- Staff

### Database Features

- Primary Keys
- Foreign Keys
- One-to-Many Relationships
- Referential Integrity
- Clustered & Non-Clustered Indexes
- Query Optimization

---

# 📊 Power BI Dashboards

## 1. Executive Procurement Overview

Provides an executive summary of procurement performance.

### KPIs

- Total Procurement Spend
- Purchase Orders
- Average Purchase Order Value
- Inventory Value
- Average Delivery Delay

### Visualizations

- Monthly Procurement Trend
- Spend by Hospital
- Inventory by Category
- Delivery Status
- Top Vendors by Spend

---

## 2. Department Performance & Financial Analysis

Analyzes departmental expenditure and financial performance.

### KPIs

- Department Spend
- Budget Utilization
- Average Department Spend
- Departments Over Budget

### Visualizations

- Department Spend
- Budget vs Actual
- Expense Category Distribution
- Expense Type Analysis
- Cost Center Analysis

---

## 3. Inventory & Warehouse Analytics

Provides inventory monitoring and warehouse insights.

### KPIs

- Total Inventory Value
- Current Stock
- Low Stock Items
- Out of Stock Products
- Average Stock Value

### Visualizations

- Inventory by Hospital
- Inventory by Category
- Stock Status Distribution
- Current Stock vs Reorder Level
- Most Valuable Products

---

## 4. Vendor Performance & Logistics

Evaluates supplier performance and logistics efficiency.

### KPIs

- Total Vendors
- Total Shipments
- On-Time Delivery %
- Average Delivery Delay
- Damaged Quantity

### Visualizations

- Vendor Spend
- Shipment Trend
- Delivery Status
- Transport Mode Analysis
- Vendor Performance Matrix

---

# 📈 Key Performance Indicators

- Total Procurement Spend
- Purchase Orders
- Average Purchase Order Value
- Inventory Value
- Department Spend
- Budget Variance
- Current Stock
- Low Stock Products
- Vendor Spend
- Total Shipments
- On-Time Delivery %
- Average Delivery Delay
- Damaged Quantity

---

# 🧮 SQL Features

The SQL implementation includes:

- Database Creation
- Table Creation
- Primary Key Constraints
- Foreign Key Constraints
- Clustered & Non-Clustered Indexes
- Data Validation Queries
- Business Analysis Queries
- Query Performance Optimization

---

# 📊 Power BI Features

- Star Schema Data Model
- Interactive Dashboards
- DAX Measures
- KPI Cards
- Interactive Slicers
- Cross Filtering
- Drill-through
- Conditional Formatting
- Dynamic Visualizations

---

# 📁 Project Structure

```
Hospital-Supply-Chain-Analytics
│
├── Dataset
│   ├── Hospitals.csv
│   ├── Vendors.csv
│   ├── Departments.csv
│   ├── Product_Master.csv
│   ├── Vendor_Products.csv
│   ├── Purchase_Orders.csv
│   ├── Purchase_Order_Lines.csv
│   ├── Shipments.csv
│   ├── Inventory.csv
│   ├── Financials.csv
│   ├── Patients.csv
│   ├── Staff.csv
│   └── Date_Dimension.csv
│
├── Python
│   ├── Data_Validation.ipynb
│   └── SQL_import.ipynb
│
├── SQL
│   └── Hospital_Supply_Chain.sql
│
├── Power BI
│   └── Hospital_Supply_Chains.pbix
│
├── SQL Query Results
│   └── SQL_Business_Queries.pdf
│
├── Images
│   ├── Dashboard1.png
│   ├── Dashboard2.png
│   ├── Dashboard3.png
│   ├── Dashboard4.png
│
└── README.md
```

---

# 📝 SQL Business Queries

The project includes a collection of SQL business queries with output screenshots demonstrating how SQL was used to answer practical business questions.

Examples include:

- Total procurement spend
- Top vendors by procurement value
- Monthly procurement trend
- Department expenditure analysis
- Budget vs Actual comparison
- Inventory valuation
- Low-stock product identification
- Vendor delivery performance
- Shipment status analysis
- Warehouse inventory summary

The complete queries and outputs are available in:

[SQL_Business_Queries.pdf](https://github.com/user-attachments/files/31416633/SQL_Business_Queries.pdf)


---

# 📸 Dashboard Preview

### Executive Procurement Overview
<img width="1434" height="807" alt="Executive overview" src="https://github.com/user-attachments/assets/60f8caab-c5ea-47e4-ab3c-c9f2b5941485" />

---

### Department Performance & Financial Analysis
<img width="1431" height="806" alt="Department cost analysis" src="https://github.com/user-attachments/assets/7d379a64-18f3-4d0b-bf51-023e8fd84cc6" />


---

### Inventory & Warehouse Analytics
<img width="1435" height="809" alt="Inventory analysis" src="https://github.com/user-attachments/assets/eac66789-3427-4040-b344-9163f77a5413" />

---

### Vendor Performance & Logistics
<img width="1433" height="810" alt="Vendor performance analysis" src="https://github.com/user-attachments/assets/3dfdb1d5-1d28-49da-a78a-08f9969597f4" />

---

# 💡 Key Insights

- Procurement spending can be monitored across hospitals and departments from a centralized dashboard.
- Budget variance analysis highlights departments exceeding allocated budgets.
- Inventory dashboards identify low-stock products requiring replenishment.
- Vendor analytics measure delivery reliability and supplier performance.
- Executive dashboards provide actionable insights to support operational and strategic decision-making.

---

# 🔮 Future Enhancements

- Integration with real-time ERP systems
- Automated inventory replenishment alerts
- Demand forecasting using Machine Learning
- Vendor performance scoring
- Power BI Service deployment with scheduled refresh
- Role-based dashboard security

---

# 👨‍💻 Author

**Bharath Venkatesh**

**Skills:** SQL Server • Power BI • DAX • Python • Pandas • Data Analytics • Business Intelligence • Data Visualization

---

## ⭐ If you found this project interesting, consider giving it a star!
