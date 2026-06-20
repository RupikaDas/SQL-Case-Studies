# Case Study 3: Platform Integrity Analytics

## Overview

This case study simulates a Platform Integrity and Trust & Safety investigation workflow used by online platforms to identify harmful content, investigate high-risk creators, analyze user reports, and evaluate moderation effectiveness.

Using SQL, the project investigates reported content, identifies repeat offenders, prioritizes creator investigations, analyzes enforcement outcomes, and supports platform integrity decision-making.

---

## Business Problem

Online platforms receive large volumes of user-generated content every day. Platform Integrity teams must quickly identify problematic creators, analyze reporting patterns, prioritize investigations, and ensure moderation actions are effective.

The objective of this project is to demonstrate how SQL can be used to:

* Identify high-risk creators
* Analyze content reporting patterns
* Detect repeat offenders
* Evaluate moderation effectiveness
* Prioritize creator investigations
* Monitor platform abuse trends

---

## Dataset

The database consists of four tables.

### Users

Stores creator account information.

| Column           | Description            |
| ---------------- | ---------------------- |
| user_id          | Unique user identifier |
| username         | Creator username       |
| country          | Creator country        |
| account_age_days | Account age in days    |

### Content

Stores user-generated content.

| Column       | Description                    |
| ------------ | ------------------------------ |
| content_id   | Unique content identifier      |
| user_id      | Content creator                |
| content_type | Video, Post, Comment, or Short |
| post_date    | Content publication date       |
| view_count   | Content view count             |

### Reports

Stores user reports submitted against content.

| Column        | Description              |
| ------------- | ------------------------ |
| report_id     | Unique report identifier |
| content_id    | Reported content         |
| report_reason | Reason for report        |
| report_date   | Report submission date   |

### Enforcement Actions

Stores moderation actions taken against reported content.

| Column      | Description              |
| ----------- | ------------------------ |
| action_id   | Unique action identifier |
| content_id  | Related content          |
| action_type | Moderation action        |
| action_date | Enforcement date         |

---

## Investigation Objectives

* Identify creators generating the highest volume of reports
* Detect repeat policy violators
* Analyze report categories
* Evaluate moderation outcomes
* Prioritize creator investigations
* Build creator integrity risk scores
* Monitor reporting trends
* Support platform integrity operations

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
* DENSE_RANK()
* ROW_NUMBER()
* Running Totals

### Analytical Techniques

* Platform Integrity Analytics
* Risk Scoring
* Escalation Logic
* Trend Analysis
* Content Moderation Analytics
* Investigation Prioritization

---

## Key Results

### Platform Integrity Summary

* Identified 7 reported creators.
* Detected 22 content reports.
* Built a creator integrity risk scoring model.
* Created an escalation queue for moderation review.
* Analyzed reporting trends and enforcement actions.

### Report Distribution

| Report Reason  | Reports |
| -------------- | ------- |
| Spam           | 13      |
| Misinformation | 6       |
| Harassment     | 3       |

Spam represented the largest category of policy violations across the platform.

### Enforcement Outcomes

| Action Type    | Count |
| -------------- | ----- |
| Removed        | 16    |
| Warning        | 3     |
| Age Restricted | 3     |

Most violations resulted in direct content removal, indicating strong moderation confidence.

### Highest-Risk Creators

| Creator           | Reports | Risk Score |
| ----------------- | ------- | ---------- |
| spam_master       | 4       | 3.64       |
| new_creator       | 3       | 5.00       |
| clickbait_channel | 3       | 3.33       |
| promo_account     | 3       | 2.31       |
| crypto_king       | 3       | 1.88       |

These creators were identified as the highest-priority investigation targets.

### Escalation Candidates

The following creators met multiple risk criteria:

* new_creator
* spam_master
* clickbait_channel
* promo_account
* crypto_king
* viral_account

These accounts demonstrated a combination of:

* New account age
* Multiple reports
* Elevated integrity risk scores

### Geographic Analysis

| Country | Reports |
| ------- | ------- |
| India   | 19      |
| Canada  | 3       |

India accounted for approximately 86.4% of all reported content in the dataset.

### High-Impact Reported Content

The highest-viewed reported content originated from:

* clickbait_channel
* viral_account

These creators generated reported content with audiences exceeding 35,000–50,000 views, increasing potential platform risk.

---

## Sample Business Questions

* Which creators receive the most reports?
* Which report categories are most common?
* Which creators should be escalated for investigation?
* How effective are moderation actions?
* Which content types generate the highest platform risk?
* How are reports trending over time?

---

## Project Structure

Case-Study-3-Platform-Integrity-Analytics/<br>
|<br>
|--- README.md<br>
|--- schema.sql<br>
|--- solutions.sql<br>
|--- questions.md<br>
|--- platform_integrity.db<br>

---

## Tools Used

* SQLite
* DB Browser for SQLite
* Git
* GitHub

---

## Skills Demonstrated

* Platform Integrity Analytics
* Trust & Safety Analytics
* Risk Analysis
* SQL Investigation Techniques
* Data Analysis
* Content Moderation Analytics
* Window Functions
* Trend Analysis
* Investigation Prioritization

---

## Business Recommendations

* Increase monitoring of newly created creator accounts.
* Prioritize high-view reported content for review.
* Expand automated spam detection systems.
* Implement creator risk scoring for proactive investigations.
* Build reporting trend dashboards for moderation teams.

---

## Author

Rupika Das

Data Analyst | SQL | Python | Analytics | Trust & Safety Portfolio Projects
