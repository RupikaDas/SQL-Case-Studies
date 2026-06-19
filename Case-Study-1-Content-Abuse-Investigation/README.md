# Case Study 1: Content Abuse Investigation

## Overview

This case study simulates a Trust & Safety investigation workflow similar to those used by content moderation, platform integrity, fraud prevention, and abuse detection teams at large technology companies.

Using SQL, the investigation analyzes user-generated content, identifies abusive behavior patterns, prioritizes high-risk accounts, and evaluates moderation outcomes.

---

## Business Problem

Online platforms receive large volumes of user-generated content every day. Trust & Safety teams must quickly identify harmful behavior, investigate suspicious accounts, and support moderation decisions using data.

The objective of this case study is to demonstrate how SQL can be used to:

* Detect abusive users
* Investigate repeat offenders
* Analyze content moderation actions
* Measure abuse trends over time
* Prioritize high-risk accounts
* Support operational decision-making

---

## Dataset

The database consists of three tables:

### Users

Stores account information for platform users.

| Column           | Description            |
| ---------------- | ---------------------- |
| user_id          | Unique user identifier |
| username         | Username               |
| country          | User country           |
| account_age_days | Age of account in days |

### Comments

Stores user-generated comments.

| Column       | Description                     |
| ------------ | ------------------------------- |
| comment_id   | Unique comment identifier       |
| user_id      | User who posted the comment     |
| comment_text | Comment content                 |
| comment_date | Date comment was posted         |
| is_flagged   | Flag indicating abusive content |

### Moderation Actions

Stores enforcement actions taken by moderators.

| Column      | Description              |
| ----------- | ------------------------ |
| action_id   | Unique moderation action |
| comment_id  | Related comment          |
| action_type | Moderation action taken  |
| review_date | Date of review           |

---

## Investigation Objectives

* Measure user activity levels
* Detect abusive content
* Identify repeat offenders
* Calculate abuse rates
* Analyze moderation decisions
* Detect suspicious new accounts
* Build risk scoring models
* Investigate abuse spikes
* Prioritize enforcement actions

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
* ROUND()

### Advanced SQL

* Common Table Expressions (CTEs)
* Window Functions
* RANK()
* DENSE_RANK()
* ROW_NUMBER()
* Running Totals

### Analytical Techniques

* Risk Scoring
* Trend Analysis
* Abuse Investigation
* Escalation Prioritization
* Moderation Analytics

---

## Key Results

### Abuse Investigation

* Identified 7 abusive users.
* Detected 19 flagged comments.
* Identified repeat offenders responsible for the majority of abusive activity.
* Detected clusters of newly created high-risk accounts.

### Risk Scoring

A risk scoring framework was developed using:

* Account age
* Flagged comment volume

This enabled prioritization of accounts for investigation and moderation review.

### Trend Analysis

* Abuse activity was analyzed over time.
* Significant spikes were identified on June 7 and June 11.
* Running totals were used to monitor cumulative abuse growth.

### Moderation Insights

* Moderation actions were analyzed across flagged content.
* Removed content represented the majority of enforcement actions.
* Escalation candidates were identified using multiple risk signals.

---

## Sample Investigation Questions

* Which users generate the most abusive content?
* Which countries contribute the highest volume of flagged comments?
* Which accounts should be prioritized for review?
* Are abuse incidents increasing over time?
* Which users are driving abuse spikes?
* Which accounts require immediate escalation?

---

## Business Conclusions

Based on the investigation, several meaningful patterns were identified:

### Executive Summary

* Identified **7 abusive users** across the platform.
* Detected **19 flagged comments** requiring moderation review.
* Found that **79% of abusive content (15 of 19 comments)** originated from accounts located in India.
* Identified multiple newly created accounts exhibiting spam-like behavior patterns.

### Top Escalation Candidates

The following accounts were prioritized for immediate investigation based on account age, violation volume, and calculated risk score:

| Username     | Account Age (Days) | Flagged Comments | Risk Score |
| ------------ | ------------------ | ---------------- | ---------- |
| ad_spammer   | 3                  | 3                | 7.50       |
| quick_cash   | 8                  | 3                | 3.33       |
| promo_master | 12                 | 3                | 2.31       |
| viral_hunter | 20                 | 3                | 1.43       |
| crypto_alert | 15                 | 2                | 1.25       |

### Abuse Trend Analysis

Abuse activity was not evenly distributed across time.

Two major abuse spikes were identified:

| Date       | Flagged Comments |
| ---------- | ---------------- |
| 2025-06-07 | 5                |
| 2025-06-11 | 5                |

These spikes suggest coordinated spam activity rather than isolated incidents.

### Moderation Insights

* Most policy violations resulted in content removal.
* Repeat offenders were responsible for a significant portion of total abuse activity.
* Risk scoring successfully prioritized accounts requiring enforcement review.

### Recommendations

* Increase monitoring of newly created accounts.
* Automatically escalate accounts with multiple flagged comments within the first 30 days.
* Implement automated spam detection rules for promotional language patterns.
* Continue tracking abuse trends using daily monitoring dashboards.

## Project Structure

Case-Study-1-Content-Abuse-Investigation/
|
|--- README.md
|--- schema.sql
|--- solutions.sql
|--- questions.md
|--- content_abuse.db

---

## Tools Used

* SQLite
* DB Browser for SQLite
* Git
* GitHub

---

## Skills Demonstrated

* SQL Analytics
* Data Investigation
* Trust & Safety Analytics
* Risk Analysis
* Content Moderation Analysis
* Data Modeling
* Root Cause Analysis
* Window Functions
* Business Intelligence

---

## Author

Rupika Das

Data Analyst | SQL | Python | Analytics | Trust & Safety Portfolio Projects
