-- Question 1
-- Find the number of comments posted by each user

SELECT
    u.username,
    COUNT(c.comment_id) AS total_comments
FROM users u
LEFT JOIN comments c
    ON u.user_id = c.user_id
GROUP BY u.username
ORDER BY total_comments DESC;

-- Question 2
-- Identify users with the highest number of flagged comments

SELECT
    u.username,
    COUNT(c.comment_id) AS flagged_comments
FROM users u
JOIN comments c
    ON u.user_id = c.user_id
WHERE c.is_flagged = 1
GROUP BY u.username
ORDER BY flagged_comments DESC;

-- Question 3
-- Calculate the flag rate for each user

SELECT
    u.username,
    COUNT(c.comment_id) AS total_comments,
    SUM(c.is_flagged) AS flagged_comments,
    ROUND(
        100.0 * SUM(c.is_flagged) / COUNT(c.comment_id),
        2
    ) AS flag_rate_percent
FROM users u
JOIN comments c
    ON u.user_id = c.user_id
GROUP BY u.username
ORDER BY flag_rate_percent DESC;

-- Question 4
-- Identify repeat offenders

SELECT
    u.username,
    COUNT(c.comment_id) AS total_comments,
    SUM(c.is_flagged) AS flagged_comments
FROM users u
JOIN comments c
    ON u.user_id = c.user_id
GROUP BY u.username
HAVING SUM(c.is_flagged) >= 2
ORDER BY flagged_comments DESC;

-- Question 5
-- Rank users by flagged comments

SELECT
    u.username,
    COUNT(c.comment_id) AS flagged_comments,
    RANK() OVER (
        ORDER BY COUNT(c.comment_id) DESC
    ) AS user_rank
FROM users u
JOIN comments c
    ON u.user_id = c.user_id
WHERE c.is_flagged = 1
GROUP BY u.username;

-- Question 6
-- Calculate each user's contribution to total flagged content

SELECT
    u.username,
    COUNT(c.comment_id) AS flagged_comments,
    ROUND(
        100.0 * COUNT(c.comment_id) /
        SUM(COUNT(c.comment_id)) OVER (),
        2
    ) AS percent_of_total_flagged
FROM users u
JOIN comments c
    ON u.user_id = c.user_id
WHERE c.is_flagged = 1
GROUP BY u.username
ORDER BY flagged_comments DESC;

-- Question 7
-- Identify users whose flag rate exceeds 50%

WITH user_flag_rates AS (
    SELECT
        u.username,
        COUNT(c.comment_id) AS total_comments,
        SUM(c.is_flagged) AS flagged_comments,
        ROUND(
            100.0 * SUM(c.is_flagged) / COUNT(c.comment_id),
            2
        ) AS flag_rate
    FROM users u
    JOIN comments c
        ON u.user_id = c.user_id
    GROUP BY u.username
)

SELECT *
FROM user_flag_rates
WHERE flag_rate > 50
ORDER BY flag_rate DESC;

-- Question 8
-- Analyze flagged comments by country

SELECT
    u.country,
    COUNT(c.comment_id) AS flagged_comments
FROM users u
JOIN comments c
    ON u.user_id = c.user_id
WHERE c.is_flagged = 1
GROUP BY u.country
ORDER BY flagged_comments DESC;

-- Question 9
-- Analyze moderation actions

SELECT
    action_type,
    COUNT(*) AS total_actions
FROM moderation_actions
GROUP BY action_type
ORDER BY total_actions DESC;

-- Question 10
-- Show removed comments and the users who posted them

SELECT
    u.username,
    c.comment_text,
    m.action_type,
    m.review_date
FROM users u
JOIN comments c
    ON u.user_id = c.user_id
JOIN moderation_actions m
    ON c.comment_id = m.comment_id
WHERE m.action_type = 'Removed';

-- Question 11
-- Rank users by flagged comments

SELECT
    u.username,
    COUNT(*) AS flagged_comments,
    DENSE_RANK() OVER (
        ORDER BY COUNT(*) DESC
    ) AS offender_rank
FROM users u
JOIN comments c
    ON u.user_id = c.user_id
WHERE c.is_flagged = 1
GROUP BY u.username
ORDER BY flagged_comments DESC;

-- Question 12
-- Identify high-risk new accounts

SELECT
    u.username,
    u.account_age_days,
    COUNT(c.comment_id) AS flagged_comments
FROM users u
JOIN comments c
    ON u.user_id = c.user_id
WHERE c.is_flagged = 1
AND u.account_age_days <= 30
GROUP BY
    u.username,
    u.account_age_days
ORDER BY flagged_comments DESC,
         u.account_age_days ASC;

-- Question 13
-- Create a simple abuse risk score

SELECT
    u.username,
    u.account_age_days,
    COUNT(c.comment_id) AS flagged_comments,
    ROUND(
        (COUNT(c.comment_id) * 10.0) /
        (u.account_age_days + 1),
        2
    ) AS risk_score
FROM users u
JOIN comments c
    ON u.user_id = c.user_id
WHERE c.is_flagged = 1
GROUP BY
    u.user_id,
    u.username,
    u.account_age_days
ORDER BY risk_score DESC;

-- Question 14
-- Identify the top 3 highest-risk accounts

WITH risk_scores AS (
    SELECT
        u.username,
        u.account_age_days,
        COUNT(c.comment_id) AS flagged_comments,
        ROUND(
            (COUNT(c.comment_id) * 10.0) /
            (u.account_age_days + 1),
            2
        ) AS risk_score
    FROM users u
    JOIN comments c
        ON u.user_id = c.user_id
    WHERE c.is_flagged = 1
    GROUP BY
        u.user_id,
        u.username,
        u.account_age_days
)

SELECT *
FROM risk_scores
ORDER BY risk_score DESC
LIMIT 3;

-- Question 15
-- Assign investigation priority to abusive accounts

WITH risk_scores AS (
    SELECT
        u.username,
        u.account_age_days,
        COUNT(c.comment_id) AS flagged_comments,
        ROUND(
            (COUNT(c.comment_id) * 10.0) /
            (u.account_age_days + 1),
            2
        ) AS risk_score
    FROM users u
    JOIN comments c
        ON u.user_id = c.user_id
    WHERE c.is_flagged = 1
    GROUP BY
        u.user_id,
        u.username,
        u.account_age_days
)

SELECT
    ROW_NUMBER() OVER (
        ORDER BY risk_score DESC
    ) AS investigation_priority,
    username,
    account_age_days,
    flagged_comments,
    risk_score
FROM risk_scores;

-- Question 16
-- Analyze flagged comments by day

SELECT
    comment_date,
    COUNT(*) AS flagged_comments
FROM comments
WHERE is_flagged = 1
GROUP BY comment_date
ORDER BY comment_date;

-- Question 17
-- Calculate cumulative flagged comments over time

SELECT
    comment_date,
    COUNT(*) AS daily_flagged_comments,
    SUM(COUNT(*)) OVER (
        ORDER BY comment_date
    ) AS cumulative_flagged_comments
FROM comments
WHERE is_flagged = 1
GROUP BY comment_date
ORDER BY comment_date;

-- Question 18
-- Identify users responsible for the highest amount of abusive content

SELECT
    u.username,
    u.country,
    COUNT(*) AS flagged_comments
FROM users u
JOIN comments c
    ON u.user_id = c.user_id
WHERE c.is_flagged = 1
GROUP BY
    u.username,
    u.country
ORDER BY flagged_comments DESC
LIMIT 5;

-- Question 19
-- Identify accounts requiring immediate escalation

WITH user_risk AS (
    SELECT
        u.username,
        u.country,
        u.account_age_days,
        COUNT(c.comment_id) AS flagged_comments,
        ROUND(
            (COUNT(c.comment_id) * 10.0) /
            (u.account_age_days + 1),
            2
        ) AS risk_score
    FROM users u
    JOIN comments c
        ON u.user_id = c.user_id
    WHERE c.is_flagged = 1
    GROUP BY
        u.user_id,
        u.username,
        u.country,
        u.account_age_days
)

SELECT *
FROM user_risk
WHERE
    account_age_days <= 30
    AND flagged_comments >= 2
    AND risk_score >= 1
ORDER BY risk_score DESC;

-- Question 20
-- Executive abuse summary

WITH abuse_summary AS (
    SELECT
        COUNT(DISTINCT u.user_id) AS abusive_users,
        COUNT(c.comment_id) AS total_flagged_comments
    FROM users u
    JOIN comments c
        ON u.user_id = c.user_id
    WHERE c.is_flagged = 1
),

country_summary AS (
    SELECT
        country,
        COUNT(c.comment_id) AS flagged_comments
    FROM users u
    JOIN comments c
        ON u.user_id = c.user_id
    WHERE c.is_flagged = 1
    GROUP BY country
)

SELECT
    (SELECT abusive_users FROM abuse_summary) AS abusive_users,
    (SELECT total_flagged_comments FROM abuse_summary) AS total_flagged_comments,
    country,
    flagged_comments
FROM country_summary
ORDER BY flagged_comments DESC;