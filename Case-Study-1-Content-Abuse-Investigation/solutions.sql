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