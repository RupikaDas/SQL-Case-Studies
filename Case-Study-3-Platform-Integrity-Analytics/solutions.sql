-- Question 1
-- Total content by creator

SELECT
u.username,
COUNT(c.content_id) AS total_content
FROM users u
LEFT JOIN content c
ON u.user_id = c.user_id
GROUP BY u.username
ORDER BY total_content DESC;

---

-- Question 2
-- Most reported creators

SELECT
u.username,
COUNT(r.report_id) AS total_reports
FROM users u
JOIN content c
ON u.user_id = c.user_id
JOIN reports r
ON c.content_id = r.content_id
GROUP BY u.username
ORDER BY total_reports DESC;

---

-- Question 3
-- Reports by category

SELECT
report_reason,
COUNT(*) AS total_reports
FROM reports
GROUP BY report_reason
ORDER BY total_reports DESC;

---

-- Question 4
-- Enforcement actions by type

SELECT
action_type,
COUNT(*) AS total_actions
FROM enforcement_actions
GROUP BY action_type
ORDER BY total_actions DESC;

---

-- Question 5
-- Creator report rate

SELECT
u.username,
COUNT(DISTINCT c.content_id) AS total_content,
COUNT(r.report_id) AS reports_received,
ROUND(
100.0 * COUNT(r.report_id) /
COUNT(DISTINCT c.content_id),
2
) AS report_rate
FROM users u
JOIN content c
ON u.user_id = c.user_id
LEFT JOIN reports r
ON c.content_id = r.content_id
GROUP BY u.username
ORDER BY report_rate DESC;

---

-- Question 6
-- Repeat offenders

SELECT
u.username,
COUNT(r.report_id) AS total_reports
FROM users u
JOIN content c
ON u.user_id = c.user_id
JOIN reports r
ON c.content_id = r.content_id
GROUP BY u.username
HAVING COUNT(r.report_id) >= 2
ORDER BY total_reports DESC;

---

-- Question 7
-- High-risk new creators

SELECT
u.username,
u.account_age_days,
COUNT(r.report_id) AS reports_received
FROM users u
JOIN content c
ON u.user_id = c.user_id
JOIN reports r
ON c.content_id = r.content_id
WHERE u.account_age_days <= 30
GROUP BY
u.username,
u.account_age_days
ORDER BY reports_received DESC;

---

-- Question 8
-- Most-viewed reported content

SELECT
c.content_id,
u.username,
c.content_type,
c.view_count
FROM content c
JOIN users u
ON c.user_id = u.user_id
JOIN reports r
ON c.content_id = r.content_id
ORDER BY c.view_count DESC;

---

-- Question 9
-- Country-level abuse analysis

SELECT
u.country,
COUNT(r.report_id) AS reports_received
FROM users u
JOIN content c
ON u.user_id = c.user_id
JOIN reports r
ON c.content_id = r.content_id
GROUP BY u.country
ORDER BY reports_received DESC;

---

-- Question 10
-- Top reported creators

SELECT
u.username,
COUNT(r.report_id) AS reports_received
FROM users u
JOIN content c
ON u.user_id = c.user_id
JOIN reports r
ON c.content_id = r.content_id
GROUP BY u.username
ORDER BY reports_received DESC
LIMIT 5;

---

-- Question 11
-- Integrity risk score

SELECT
u.username,
u.account_age_days,
COUNT(r.report_id) AS reports_received,
ROUND(
(COUNT(r.report_id) * 10.0) /
(u.account_age_days + 1),
2
) AS integrity_risk_score
FROM users u
JOIN content c
ON u.user_id = c.user_id
JOIN reports r
ON c.content_id = r.content_id
GROUP BY
u.user_id,
u.username,
u.account_age_days
ORDER BY integrity_risk_score DESC;

---

-- Question 12
-- Escalation candidates

WITH creator_risk AS (
SELECT
u.username,
u.country,
u.account_age_days,
COUNT(r.report_id) AS reports_received,
ROUND(
(COUNT(r.report_id) * 10.0) /
(u.account_age_days + 1),
2
) AS integrity_risk_score
FROM users u
JOIN content c
ON u.user_id = c.user_id
JOIN reports r
ON c.content_id = r.content_id
GROUP BY
u.user_id,
u.username,
u.country,
u.account_age_days
)

SELECT *
FROM creator_risk
WHERE
account_age_days <= 30
AND reports_received >= 2
AND integrity_risk_score >= 1
ORDER BY integrity_risk_score DESC;

---

-- Question 13
-- Daily reporting trends

SELECT
report_date,
COUNT(*) AS reports
FROM reports
GROUP BY report_date
ORDER BY report_date;

---

-- Question 14
-- Running total of reports

SELECT
report_date,
COUNT(*) AS daily_reports,
SUM(COUNT(*)) OVER (
ORDER BY report_date
) AS cumulative_reports
FROM reports
GROUP BY report_date
ORDER BY report_date;

---

-- Question 15
-- Enforcement effectiveness

SELECT
action_type,
COUNT(*) AS total_actions
FROM enforcement_actions
GROUP BY action_type
ORDER BY total_actions DESC;

---

-- Question 16
-- Moderator action distribution

SELECT
action_type,
ROUND(
100.0 * COUNT(*) /
SUM(COUNT(*)) OVER (),
2
) AS action_percentage
FROM enforcement_actions
GROUP BY action_type
ORDER BY action_percentage DESC;

---

-- Question 17
-- High-risk content categories

SELECT
c.content_type,
COUNT(r.report_id) AS reports_received
FROM content c
JOIN reports r
ON c.content_id = r.content_id
GROUP BY c.content_type
ORDER BY reports_received DESC;

---

-- Question 18
-- Creator risk ranking

SELECT
u.username,
COUNT(r.report_id) AS reports_received,
DENSE_RANK() OVER (
ORDER BY COUNT(r.report_id) DESC
) AS creator_risk_rank
FROM users u
JOIN content c
ON u.user_id = c.user_id
JOIN reports r
ON c.content_id = r.content_id
GROUP BY u.username;

---

-- Question 19
-- Investigation priority queue

WITH creator_risk AS (
SELECT
u.username,
COUNT(r.report_id) AS reports_received,
ROUND(
(COUNT(r.report_id) * 10.0) /
(u.account_age_days + 1),
2
) AS integrity_risk_score
FROM users u
JOIN content c
ON u.user_id = c.user_id
JOIN reports r
ON c.content_id = r.content_id
GROUP BY
u.user_id,
u.username,
u.account_age_days
)

SELECT
ROW_NUMBER() OVER (
ORDER BY integrity_risk_score DESC
) AS investigation_priority,
username,
reports_received,
integrity_risk_score
FROM creator_risk;

---

-- Question 20
-- Executive platform integrity summary

WITH integrity_summary AS (
SELECT
COUNT(DISTINCT u.user_id) AS reported_creators,
COUNT(r.report_id) AS total_reports
FROM users u
JOIN content c
ON u.user_id = c.user_id
JOIN reports r
ON c.content_id = r.content_id
),

country_summary AS (
SELECT
u.country,
COUNT(r.report_id) AS reports_received
FROM users u
JOIN content c
ON u.user_id = c.user_id
JOIN reports r
ON c.content_id = r.content_id
GROUP BY u.country
)

SELECT
(SELECT reported_creators FROM integrity_summary) AS reported_creators,
(SELECT total_reports FROM integrity_summary) AS total_reports,
country,
reports_received
FROM country_summary
ORDER BY reports_received DESC;
