-- Question 1
SELECT
u.username,
COUNT(s.session_id) AS total_sessions
FROM users u
LEFT JOIN sessions s
ON u.user_id = s.user_id
GROUP BY u.username
ORDER BY total_sessions DESC;

---

-- Question 2

SELECT
u.username,
COUNT(a.activity_id) AS total_activities
FROM users u
LEFT JOIN activities a
ON u.user_id = a.user_id
GROUP BY u.username
ORDER BY total_activities DESC;

---

-- Question 3

SELECT
u.username,
ROUND(AVG(s.session_duration_minutes),2) AS avg_session_duration
FROM users u
JOIN sessions s
ON u.user_id = s.user_id
GROUP BY u.username
ORDER BY avg_session_duration DESC;

---

-- Question 4

SELECT
activity_type,
COUNT(*) AS activity_count
FROM activities
GROUP BY activity_type
ORDER BY activity_count DESC;

---

-- Question 5

SELECT
subscription_status,
COUNT(*) AS users
FROM subscriptions
GROUP BY subscription_status;

---

-- Question 6

SELECT
u.username,
COUNT(a.activity_id) AS total_activities
FROM users u
JOIN activities a
ON u.user_id = a.user_id
GROUP BY u.username
ORDER BY total_activities DESC
LIMIT 5;

---

-- Question 7

SELECT
u.username,
COUNT(a.activity_id) AS total_activities
FROM users u
LEFT JOIN activities a
ON u.user_id = a.user_id
GROUP BY u.username
ORDER BY total_activities ASC
LIMIT 5;

---

-- Question 8

SELECT
u.username,
ROUND(AVG(s.session_duration_minutes),2) AS avg_session_duration
FROM users u
JOIN sessions s
ON u.user_id = s.user_id
GROUP BY u.username
ORDER BY avg_session_duration DESC
LIMIT 5;

---

-- Question 9

SELECT
activity_date,
COUNT(*) AS activities
FROM activities
GROUP BY activity_date
ORDER BY activity_date;

---

-- Question 10

SELECT
u.country,
COUNT(a.activity_id) AS activities
FROM users u
JOIN activities a
ON u.user_id = a.user_id
GROUP BY u.country
ORDER BY activities DESC;

---

-- Question 11

SELECT
u.username,
COUNT(DISTINCT s.session_id) AS sessions,
COUNT(a.activity_id) AS activities,
ROUND(
(COUNT(DISTINCT s.session_id) * 2.0) +
COUNT(a.activity_id),
2
) AS engagement_score
FROM users u
LEFT JOIN sessions s
ON u.user_id = s.user_id
LEFT JOIN activities a
ON u.user_id = a.user_id
GROUP BY u.username
ORDER BY engagement_score DESC;

---

-- Question 12

SELECT
u.username,
sub.plan_type,
COUNT(a.activity_id) AS activities
FROM users u
JOIN subscriptions sub
ON u.user_id = sub.user_id
LEFT JOIN activities a
ON u.user_id = a.user_id
WHERE sub.plan_type = 'Premium'
GROUP BY
u.username,
sub.plan_type
ORDER BY activities DESC;

---

-- Question 13

SELECT
u.username,
sub.subscription_status,
COUNT(a.activity_id) AS activities
FROM users u
JOIN subscriptions sub
ON u.user_id = sub.user_id
LEFT JOIN activities a
ON u.user_id = a.user_id
WHERE sub.subscription_status = 'Cancelled'
GROUP BY
u.username,
sub.subscription_status
ORDER BY activities ASC;

---

-- Question 14

SELECT
activity_date,
COUNT(*) AS daily_activities,
SUM(COUNT(*)) OVER (
ORDER BY activity_date
) AS cumulative_activities
FROM activities
GROUP BY activity_date
ORDER BY activity_date;

---

-- Question 15

SELECT
u.username,
COUNT(DISTINCT s.session_id) AS sessions,
COUNT(a.activity_id) AS activities
FROM users u
LEFT JOIN sessions s
ON u.user_id = s.user_id
LEFT JOIN activities a
ON u.user_id = a.user_id
GROUP BY u.username
ORDER BY sessions DESC, activities DESC;

---

-- Question 16

SELECT
ROUND(
100.0 *
SUM(CASE WHEN plan_type='Premium' THEN 1 ELSE 0 END)
/ COUNT(*),
2
) AS premium_conversion_rate
FROM subscriptions;

---

-- Question 17

SELECT
u.username,
COUNT(a.activity_id) AS activities
FROM users u
JOIN subscriptions sub
ON u.user_id = sub.user_id
LEFT JOIN activities a
ON u.user_id = a.user_id
WHERE sub.plan_type='Premium'
GROUP BY u.username
ORDER BY activities DESC;

---

-- Question 18

SELECT
u.username,
COUNT(a.activity_id) AS activities,
DENSE_RANK() OVER (
ORDER BY COUNT(a.activity_id) DESC
) AS engagement_rank
FROM users u
LEFT JOIN activities a
ON u.user_id = a.user_id
GROUP BY u.username;

---

-- Question 19

WITH engagement AS (
SELECT
u.username,
COUNT(DISTINCT s.session_id) AS sessions,
COUNT(a.activity_id) AS activities,
ROUND(
(COUNT(DISTINCT s.session_id) * 2.0)
+ COUNT(a.activity_id),
2
) AS engagement_score
FROM users u
LEFT JOIN sessions s
ON u.user_id = s.user_id
LEFT JOIN activities a
ON u.user_id = a.user_id
GROUP BY u.username
)

SELECT
ROW_NUMBER() OVER (
ORDER BY engagement_score DESC
) AS priority_rank,
username,
engagement_score
FROM engagement;

---

-- Question 20

WITH engagement_summary AS (
SELECT
COUNT(DISTINCT u.user_id) AS active_users,
COUNT(a.activity_id) AS total_activities
FROM users u
LEFT JOIN activities a
ON u.user_id = a.user_id
),

country_summary AS (
SELECT
u.country,
COUNT(a.activity_id) AS activities
FROM users u
JOIN activities a
ON u.user_id = a.user_id
GROUP BY u.country
)

SELECT
(SELECT active_users FROM engagement_summary) AS active_users,
(SELECT total_activities FROM engagement_summary) AS total_activities,
country,
activities
FROM country_summary
ORDER BY activities DESC;
