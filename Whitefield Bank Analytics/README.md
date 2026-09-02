<p align="center">
 <img width="135" height="135" alt="Logo" src="https://github.com/user-attachments/assets/ab94c94f-8933-40fe-a3fb-caa66ef21fa4" />
</p>

<h1 align="center">Whitefield Bank Analytics Platform</h1>

<p align="center">
  <b>End-to-End Banking Analytics & Business Intelligence Project</b>
</p>

<p align="center">

![SQL Server](https://img.shields.io/badge/SQL%20Server-CC2927?style=for-the-badge&logo=microsoftsqlserver&logoColor=white)
![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)
![Power BI](https://img.shields.io/badge/Power_BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)
![Pandas](https://img.shields.io/badge/Pandas-150458?style=for-the-badge&logo=pandas&logoColor=white)
![NumPy](https://img.shields.io/badge/NumPy-013243?style=for-the-badge&logo=numpy&logoColor=white)
![Jupyter](https://img.shields.io/badge/Jupyter-F37626?style=for-the-badge&logo=jupyter&logoColor=white)

</p>

---

# Project Overview

Whitefield Bank Analytics Platform is a complete end-to-end Banking Analytics solution built using SQL Server, Python and Power BI.

The project simulates how a modern retail bank stores, transforms and analyzes banking data to support business decisions across lending, collections, fraud detection, customer analytics and branch performance.

Since no public banking dataset exists with the required level of detail, a realistic synthetic banking dataset was created containing over 100,000 customers and millions of banking records. The data was modeled using an OLTP database, transformed into a dimensional Data Warehouse, analyzed in Python and finally visualized through interactive Power BI dashboards.

This project demonstrates the complete lifecycle of Business Intelligence and Analytics.

---

# Project Architecture

```

Raw Banking Dataset
(Excel Files)

↓

SQL Server OLTP Database

↓

ETL Process

↓

Star Schema Data Warehouse

↓

Python Analytics
(EDA + Business Insights)

↓

Power BI Interactive Dashboards

↓

Business Decision Making

```

---

# Business Problems Solved

The project addresses real-world banking problems such as:

### Loan Portfolio

- How large is the bank's total loan portfolio?
- Which loan products generate the highest value?
- How is the outstanding principal changing over time?
- Which months experience peak lending activity?

---

### Credit Risk

- Which customers are high risk?
- Which branches have the highest default rates?
- Which loan types contribute the highest credit risk?
- How many loans are overdue?
- What is the Days Past Due (DPD) distribution?
- Which loans have been written off?

---

### Collections

- Collection efficiency by branch
- Recovery rate trend
- Outstanding balance trend
- Collection performance over time
- Average recovery days
- Recovery percentage

---

### Customer Analytics

- Customer segmentation by income
- Customer segmentation by age
- Credit score distribution
- High credit customers
- High risk customers
- Customer demographics
- Annual income analysis
- Occupation-wise loan analysis

---

### Branch Performance

- Top performing branches
- Branch portfolio comparison
- State-wise portfolio distribution
- Branch recovery efficiency
- Default rate by branch
- Average credit score by branch
- Fraud cases by branch

---

### Fraud Analytics

- Fraud trends over time
- Fraud amount vs legitimate amount
- Fraud type distribution
- Merchant-wise fraud
- Channel-wise fraud
- State-wise fraud
- Fraud investigation metrics
- Financial loss due to fraud

---

### Executive Insights

- Executive KPIs
- Loan Portfolio
- Outstanding Principal
- Collection Amount
- Transaction Volume
- Fraud Loss
- Portfolio trends
- Monthly summaries
- Dynamic business insights

---

# Dataset

The project uses a realistic synthetic banking dataset containing:

- 100,000 Customers
- 500 Branches
- Multiple Loan Products
- Loan Applications
- Loan Portfolio
- Transactions
- Repayments
- Collections
- Fraud Cases
- Employee Data
- Geographic Data

The complete dataset can be downloaded here:

## Dataset

https://drive.google.com/file/d/1p_5nIlwnOzcgtXVjrYVHHb116pYDBP_d/view?usp=sharing

---

# SQL Development

The SQL component consists of:

### OLTP Database

- Database Creation
- Primary Keys
- Foreign Keys
- Constraints
- Indexes
- Import Scripts

### Data Warehouse

- Star Schema Design
- Fact Tables
- Dimension Tables
- ETL Loading Scripts
- Analytical Views

### Business SQL Queries

- Portfolio Analysis
- Customer Analytics
- Fraud Analysis
- Recovery Analysis
- Branch Performance
- Collection Analytics

---

# Star Schema

The dimensional model contains:

## Fact Tables

- FactLoan
- FactRepayment
- FactCollection

## Dimension Tables

- DimCustomer
- DimDate
- DimBranch
- DimProduct
- DimChannel
- DimMerchant
- DimEmployee

This model enables efficient analytical reporting within Power BI.

---

# Python Analytics

Python was used for:

## Data Cleaning

- Missing Value Handling
- Data Validation
- Data Transformation
- Feature Engineering

## Exploratory Data Analysis

- Portfolio Analysis
- Customer Analysis
- Loan Analysis
- Fraud Analysis
- Collection Analysis
- Branch Analysis

## Business Insights

- High Risk Customer Identification
- Credit Score Distribution
- Income Segmentation
- Loan Performance
- Fraud Pattern Detection
- Monthly Trends
- Recovery Analysis
- Customer Behaviour
- Branch Performance Evaluation

Libraries Used

- Pandas
- NumPy
- Matplotlib
- Seaborn
- OpenPyXL

---

# Power BI Dashboards

The project contains multiple interactive dashboards.

## Executive Dashboard
<img width="1433" height="797" alt="Exec Dash" src="https://github.com/user-attachments/assets/0a930f93-1d2a-43f8-a4c0-f3d8087588f0" />

- Portfolio KPIs
- Outstanding Principal
- Collection Metrics
- Transaction Trends
- Fraud Loss
- Executive Insights

---

## Credit Risk & Collection
<img width="1433" height="807" alt="Credit Risk and Collection" src="https://github.com/user-attachments/assets/329a34d7-ab57-4c2a-b2b2-33de642adda4" />

- Default Rate
- Recovery Rate
- DPD Analysis
- High Risk Loans
- Recovery Trend
- Outstanding Balance

---

## Customer Analytics
<img width="1421" height="799" alt="Customer Analytics and Segmentation" src="https://github.com/user-attachments/assets/c8fa26aa-1a83-45eb-8a17-4b97f3da48b7" />

- Customer Segmentation
- Credit Score Distribution
- Income Analysis
- Risk by Occupation
- High Risk Customers

---

## Branch Performance
<img width="1431" height="809" alt="Branch and Portfolio" src="https://github.com/user-attachments/assets/2d5b5f14-8d8e-4cc3-af13-b5f8e7434797" />

- Top Performing Branches
- Portfolio Distribution
- Recovery Performance
- Branch Comparison
- State Analysis

---

## Fraud Intelligence
<img width="1429" height="846" alt="Fraud Analytics" src="https://github.com/user-attachments/assets/9b12a051-05b2-4416-b3a7-9bdf490fce6f" />

- Fraud Trends
- Fraud Types
- Merchant Fraud
- Fraud Channels
- Financial Loss
- Fraud Distribution

---

# Dashboard File

The complete Power BI dashboard can be downloaded here:

https://drive.google.com/file/d/1b7-_C8Ze5LUlv49c7DqYJYkC_CZzS1v6/view?usp=drive_link

---

# Repository Structure

```

Whitefield Bank Analytics/
│
├── Dataset/
│ └── README.md
│
├── Documents/
│ ├── Business Queries.pdf
│ └── Star Schema Diagram.pdf
│
├── Images/
│ ├── logo.png
│ ├── Executive Dashboard.png
│ ├── Credit Risk Dashboard.png
│ ├── Customer Analytics.png
│ ├── Branch Dashboard.png
│ └── Fraud Dashboard.png
│
├── Python/
│ └── Whitefield_Bank.ipynb
│
├── SQL/
│ ├── OLTP/
│ ├── Data Warehouse/
│ └── Business Queries.sql
│
├── PowerBI/
│ └── README.md
│
└── README.md

```

---

# Technologies Used

- SQL Server
- SQL
- Python
- Pandas
- NumPy
- Matplotlib
- Power BI
- DAX
- Power Query
- Dimensional Modeling
- Star Schema
- ETL
- Excel

---

# Key Skills Demonstrated

- Business Intelligence
- Data Analytics
- SQL Development
- Data Warehousing
- ETL
- Data Cleaning
- Exploratory Data Analysis
- Dashboard Development
- Banking Analytics
- Fraud Analytics
- Credit Risk Analytics
- Customer Segmentation
- KPI Design
- Storytelling with Data

---

# Future Improvements

- Machine Learning Based Credit Risk Prediction
- Loan Default Prediction
- Fraud Detection Models
- Customer Churn Prediction
- Automated ETL Pipelines
- Azure SQL Integration
- Microsoft Fabric Migration
- Real-Time Streaming Dashboards

---

# Disclaimer

This project is created solely for educational and portfolio purposes.

The banking data used is completely synthetic and does not represent any real bank or customer information.

---

## Author

**Bharath Venkatesh**

Data Analytics | Business Intelligence | SQL | Python | Power BI

LinkedIn: www.linkedin.com/in/bharath-venkatesh-561086203
