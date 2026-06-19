# Case Study 1: Content Abuse Investigation

## Overview

This case study simulates a Trust & Safety investigation environment similar to those used by content moderation and platform integrity teams.

Using SQL, the analysis identifies suspicious user behavior, abusive content patterns, repeat offenders, and moderation trends across a fictional social media platform.

## Business Problem

Online platforms receive large volumes of user-generated content every day. Trust & Safety teams must identify abusive users, investigate harmful behavior, and support moderation decisions using data.

This project demonstrates how SQL can be used to:

* Detect abusive accounts
* Identify repeat offenders
* Analyze flagged content
* Investigate moderation activity
* Generate actionable insights for content integrity teams

## Database Schema

### Users

Stores user account information.

| Column           | Description            |
| ---------------- | ---------------------- |
| user_id          | Unique user identifier |
| username         | Username               |
| country          | User location          |
| account_age_days | Age of account         |

### Comments

Stores user-generated comments.

| Column       | Description                 |
| ------------ | --------------------------- |
| comment_id   | Unique comment identifier   |
| user_id      | User who posted comment     |
| comment_text | Comment content             |
| comment_date | Date posted                 |
| is_flagged   | Whether content was flagged |

### Moderation Actions

Stores moderation decisions.

| Column      | Description              |
| ----------- | ------------------------ |
| action_id   | Unique action identifier |
| comment_id  | Related comment          |
| action_type | Moderation action taken  |
| review_date | Review date              |

## Investigation Objectives

* Measure user activity levels
* Identify users generating abusive content
* Calculate abuse rates
* Detect repeat offenders
* Analyze moderation outcomes
* Support risk-based investigations

## SQL Concepts Demonstrated

* SELECT
* WHERE
* GROUP BY
* HAVING
* ORDER BY
* Aggregate Functions
* INNER JOIN
* LEFT JOIN
* Investigative Analytics

## Key Findings

* Identified users with the highest volume of flagged content.
* Calculated abuse rates to prioritize investigations.
* Detected repeat offenders based on moderation signals.
* Demonstrated how SQL can support Trust & Safety decision-making.

## Future Enhancements

* Window Functions
* Risk Scoring Models
* Country-Level Abuse Analysis
* Weekly Abuse Trend Monitoring
* Content Moderation Dashboards
* Fraud and Spam Detection Analytics
