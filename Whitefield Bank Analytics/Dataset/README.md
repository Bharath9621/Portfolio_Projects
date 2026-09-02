# 📂 Whitefield Bank Dataset

This folder contains the datasets used to build the **Whitefield Bank End-to-End Banking Analytics Platform**.

Due to GitHub's maximum file size restrictions (100 MB per file), the complete dataset is hosted on Google Drive.

---

# 📥 Download Dataset

**Google Drive**

https://drive.google.com/file/d/1p_5nIlwnOzcgtXVjrYVHHb116pYDBP_d/view?usp=sharing

---

# 📊 Dataset Overview

The project consists of realistic synthetic banking data covering the complete lending lifecycle.

### Core Transactional Tables

- Customers
- Loans
- Repayments
- Collections
- Loan Applications
- Transactions
- Fraud Cases
- Employees
- Branches

### Dimension Tables

- Products
- Channels
- Fraud Types
- Risk Categories
- Occupations
- Credit Score Bands
- Branch Types
- India Geography

---

# 📈 Dataset Scale

- 100,000 Customers
- 500 Bank Branches
- Multiple Loan Products
- Multi-year Transaction History
- Loan Repayment Records
- Collection Records
- Fraud Investigation Data
- Geographic Coverage Across India

---

# 📁 File Format

All datasets are provided as **Excel (.xlsx)** files.

These files are intended to be imported into SQL Server using the ETL scripts provided in the SQL folder.

---

# 🔄 Data Flow

Raw Dataset

↓

SQL Server OLTP Database

↓

SQL Server Data Warehouse (Star Schema)

↓

Python (EDA + Business Analytics)

↓

Power BI Dashboards

---

# ⚠ Important Note

The dataset is completely **synthetic** and was created solely for educational and portfolio purposes.

No real customer information or confidential banking data has been used.

---

# 📌 Related Project

Please return to the main project README for:

- Project Architecture
- SQL Scripts
- Python Analytics
- Business Problems Solved
- Power BI Dashboards
- Star Schema
- Documentation