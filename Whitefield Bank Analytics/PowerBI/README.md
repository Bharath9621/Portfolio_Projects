# 📊 Power BI Dashboard

## Overview

This folder contains the Power BI report for the **Whitefield Bank Analytics Platform**.

The report presents an end-to-end Business Intelligence solution built on top of a SQL Server Data Warehouse and Python analytics pipeline, enabling stakeholders to monitor banking operations, portfolio performance, customer behavior, fraud trends, and credit risk through interactive dashboards.

---

## Dashboard Download

The complete Power BI report (.pbix) exceeds GitHub's file size limit (100 MB) and is therefore hosted on Google Drive.

### 📥 Download Power BI Dashboard

**Google Drive**

https://drive.google.com/file/d/1b7-_C8Ze5LUlv49c7DqYJYkC_CZzS1v6/view?usp=drive_link

---

## Dashboard Pages

The report contains five interactive dashboards:

### 📌 Executive Dashboard

Provides a high-level overview of bank performance including:

- Loan Portfolio
- Outstanding Principal
- Collection Amount
- Transaction Value
- Fraud Loss
- Portfolio Trends
- Recovery Rate
- Default Rate
- Top Performing Branches

---

### 📌 Credit Risk & Collection Dashboard

Focuses on portfolio quality and loan recovery.

Key analyses include:

- Default Rate
- Days Past Due (DPD)
- Recovery Rate
- Loan Risk Distribution
- High Risk Customers
- Written-off Loans
- Recovery Trend
- Branch-wise Risk Analysis

---

### 📌 Branch & Portfolio Performance Dashboard

Evaluates operational performance across branches.

Includes:

- Portfolio by Branch
- Portfolio by State
- Recovery Performance
- Branch Productivity
- Credit Score Comparison
- Branch Ranking
- Default Analysis

---

### 📌 Customer Analytics & Segmentation Dashboard

Analyzes customer demographics and lending behavior.

Insights include:

- Customer Segmentation
- Income Distribution
- Credit Score Analysis
- Risk by Loan Type
- Age Group Analysis
- High Credit Customers
- High Risk Customers

---

### 📌 Fraud & Transaction Intelligence Dashboard

Monitors fraud patterns and transaction behavior.

Includes:

- Fraud Trends
- Fraud Types
- Fraud Rate
- Fraud by Merchant
- Fraud by Channel
- Fraud by State
- Legitimate vs Fraud Amount
- Financial Loss Analysis

---

## Technologies Used

- Microsoft Power BI
- DAX
- Power Query
- SQL Server
- Star Schema Data Warehouse
- Interactive Drill-through
- Cross-filtering
- KPI Cards
- Bookmarks & Navigation
- Custom Business Measures

---

## Data Source

The dashboard is powered by the enterprise Data Warehouse developed as part of this project.

Pipeline:

```

Raw Banking Data
↓
SQL Server OLTP Database
↓
ETL Process
↓
Star Schema Data Warehouse
↓
Power BI Data Model
↓
Interactive Dashboards

```

---

## Features

- Executive KPI Monitoring
- Interactive Filtering
- Dynamic DAX Measures
- Cross-page Navigation
- Drill-down Analysis
- Business Storytelling
- Banking Performance Monitoring
- Credit Risk Analytics
- Fraud Intelligence
- Customer Segmentation

---

## Dashboard Preview

Dashboard screenshots are available in the **Images** folder of this repository.

---

## Requirements

- Microsoft Power BI Desktop (Latest Version Recommended)

---

## Note

This Power BI report was developed solely for educational and portfolio purposes using a synthetic banking dataset. It demonstrates enterprise-level Business Intelligence reporting, data modeling, and banking analytics.