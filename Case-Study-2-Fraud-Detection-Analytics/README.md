# Case Study 2: Fraud Detection Analytics

## Overview

This case study simulates a fraud detection and investigation workflow commonly used by Trust & Safety, Risk, Fraud Operations, Payments Integrity, and Account Protection teams.

Using SQL, the project investigates fraudulent transactions, identifies repeat offenders, prioritizes high-risk accounts, analyzes fraud concentration, and supports investigation workflows through data-driven decision making.

---

## Business Problem

Financial platforms process thousands of transactions daily. Fraud teams must quickly identify suspicious activity, detect repeat offenders, prioritize investigations, and minimize financial losses.

The objective of this project is to demonstrate how SQL can be used to:

* Detect fraudulent accounts
* Analyze fraud concentration
* Investigate high-risk users
* Prioritize fraud investigations
* Monitor fraud trends
* Support operational decision making

---

## Dataset

The database consists of three tables.

### Accounts

Stores account-level information.

| Column           | Description               |
| ---------------- | ------------------------- |
| account_id       | Unique account identifier |
| username         | Account username          |
| country          | Account country           |
| account_age_days | Age of account in days    |

### Transactions

Stores transaction activity.

| Column           | Description                   |
| ---------------- | ----------------------------- |
| transaction_id   | Unique transaction identifier |
| account_id       | Related account               |
| transaction_date | Transaction date              |
| amount           | Transaction amount            |
| payment_method   | Payment method used           |
| is_fraud         | Fraud indicator               |

### Fraud Actions

Stores fraud investigation outcomes.

| Column         | Description                     |
| -------------- | ------------------------------- |
| action_id      | Investigation action identifier |
| transaction_id | Related transaction             |
| action_type    | Investigation outcome           |
| review_date    | Investigation review date       |

---

## Investigation Objectives

* Detect fraudulent transactions
* Identify repeat fraud offenders
* Analyze fraud concentration by country
* Evaluate payment method risk
* Prioritize high-risk accounts
* Build fraud risk scoring models
* Monitor fraud activity over time
* Generate executive-level fraud summaries

---

## SQL Concepts Demonstrated

### Core SQL

* SELECT
* WHERE
* ORDER BY
* GROUP BY
* HAVING
* LIMIT

### Joins

* INNER JOIN
* LEFT JOIN

### Aggregations

* COUNT()
* SUM()
* AVG()
* ROUND()

### Advanced SQL

* Common Table Expressions (CTEs)
* Window Functions
* DENSE_RANK()
* ROW_NUMBER()
* Running Totals

### Analytical Techniques

* Fraud Risk Scoring
* Investigation Prioritization
* Fraud Trend Analysis
* Country Risk Analysis
* Payment Method Risk Analysis
* Escalation Logic

---

## Key Results

### Fraud Investigation Summary

* Identified 9 fraudulent accounts.
* Detected 23 fraudulent transactions.
* Built a fraud risk scoring framework.
* Created an investigation priority queue.
* Identified repeat fraud offenders and escalation candidates.

### Fraud Concentration

| Country | Fraudulent Transactions |
| ------- | ----------------------- |
| India   | 19                      |
| USA     | 4                       |

India accounted for approximately 82.6% of all fraudulent activity identified in the investigation.

### Highest Risk Accounts

| Username     | Fraud Transactions | Risk Score |
| ------------ | ------------------ | ---------- |
| new_account1 | 3                  | 7.50       |
| fraudster01  | 3                  | 5.00       |
| user18       | 3                  | 3.75       |
| quick_cash   | 3                  | 2.73       |
| user23       | 3                  | 2.31       |

These accounts were identified as the highest-priority investigation targets.

### Highest Financial Risk Accounts

| Username     | Average Fraud Amount |
| ------------ | -------------------- |
| user18       | 9566.67              |
| user23       | 8766.67              |
| new_account1 | 8366.67              |
| fraudster01  | 8266.67              |
| user14       | 7000.00              |

These accounts generated the highest average fraudulent transaction values and would be prioritized for financial loss prevention efforts.

### Investigation Outcomes

| Action Type | Count |
| ----------- | ----- |
| Blocked     | 13    |
| Escalated   | 10    |

Most fraud cases resulted in direct account blocking, while higher-risk transactions were escalated for further review.

---

## Sample Business Questions

* Which accounts generate the highest volume of fraud?
* Which countries present the greatest fraud risk?
* Which payment methods are most frequently abused?
* Which accounts should be escalated for investigation?
* What are the highest-value fraudulent transactions?
* How is fraud activity changing over time?

---

## Project Structure

Case-Study-2-Fraud-Detection-Analytics/
|
|--- README.md
|--- schema.sql
|--- solutions.sql
|--- questions.md
|--- fraud_detection.db

---

## Tools Used

* SQLite
* DB Browser for SQLite
* Git
* GitHub

---

## Skills Demonstrated

* Fraud Analytics
* Risk Analysis
* SQL Investigation Techniques
* Data Analysis
* Trust & Safety Analytics
* Window Functions
* Fraud Detection
* Business Intelligence
* Investigation Prioritization

---

## Business Recommendations

* Increase monitoring of newly created accounts.
* Introduce automated escalation rules for accounts with multiple fraudulent transactions.
* Apply enhanced fraud screening to high-risk payment methods.
* Develop automated risk scoring pipelines for real-time fraud detection.
* Implement country-level fraud monitoring dashboards.

---

## Author

Rupika Das

Data Analyst | SQL | Python | Analytics | Trust & Safety Portfolio Projects
