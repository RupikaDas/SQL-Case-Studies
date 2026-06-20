-- Question 1
-- Find the total number of transactions made by each account

SELECT
    a.username,
    COUNT(t.transaction_id) AS total_transactions
FROM accounts a
LEFT JOIN transactions t
    ON a.account_id = t.account_id
GROUP BY a.username
ORDER BY total_transactions DESC;

-- Question 2
-- Identify accounts with fraudulent transactions

SELECT
    a.username,
    COUNT(t.transaction_id) AS fraudulent_transactions
FROM accounts a
JOIN transactions t
    ON a.account_id = t.account_id
WHERE t.is_fraud = 1
GROUP BY a.username
ORDER BY fraudulent_transactions DESC;

-- Question 3
-- Calculate fraud rate for each account

SELECT
    a.username,
    COUNT(t.transaction_id) AS total_transactions,
    SUM(t.is_fraud) AS fraudulent_transactions,
    ROUND(
        100.0 * SUM(t.is_fraud) / COUNT(t.transaction_id),
        2
    ) AS fraud_rate
FROM accounts a
JOIN transactions t
    ON a.account_id = t.account_id
GROUP BY a.username
ORDER BY fraud_rate DESC;

-- Question 4
-- Identify repeat fraud offenders

SELECT
    a.username,
    COUNT(t.transaction_id) AS fraudulent_transactions
FROM accounts a
JOIN transactions t
    ON a.account_id = t.account_id
WHERE t.is_fraud = 1
GROUP BY a.username
HAVING COUNT(t.transaction_id) >= 2
ORDER BY fraudulent_transactions DESC;

-- Question 5
-- Rank accounts by fraudulent transactions

SELECT
    a.username,
    COUNT(t.transaction_id) AS fraudulent_transactions,
    DENSE_RANK() OVER (
        ORDER BY COUNT(t.transaction_id) DESC
    ) AS fraud_rank
FROM accounts a
JOIN transactions t
    ON a.account_id = t.account_id
WHERE t.is_fraud = 1
GROUP BY a.username;

-- Question 6
-- Analyze fraudulent transactions by country

SELECT
    a.country,
    COUNT(t.transaction_id) AS fraudulent_transactions
FROM accounts a
JOIN transactions t
    ON a.account_id = t.account_id
WHERE t.is_fraud = 1
GROUP BY a.country
ORDER BY fraudulent_transactions DESC;

-- Question 7
-- Calculate each country's share of fraud

SELECT
    a.country,
    COUNT(*) AS fraudulent_transactions,
    ROUND(
        100.0 * COUNT(*) /
        SUM(COUNT(*)) OVER (),
        2
    ) AS fraud_share_percent
FROM accounts a
JOIN transactions t
    ON a.account_id = t.account_id
WHERE t.is_fraud = 1
GROUP BY a.country
ORDER BY fraudulent_transactions DESC;

-- Question 8
-- Analyze fraud investigation outcomes

SELECT
    action_type,
    COUNT(*) AS total_actions
FROM fraud_actions
GROUP BY action_type
ORDER BY total_actions DESC;

-- Question 9
-- Identify high-value fraudulent transactions

SELECT
    a.username,
    t.amount,
    t.payment_method
FROM accounts a
JOIN transactions t
    ON a.account_id = t.account_id
WHERE t.is_fraud = 1
AND t.amount >= 8000
ORDER BY t.amount DESC;

-- Question 10
-- Top fraud-generating accounts

SELECT
    a.username,
    COUNT(*) AS fraudulent_transactions
FROM accounts a
JOIN transactions t
    ON a.account_id = t.account_id
WHERE t.is_fraud = 1
GROUP BY a.username
ORDER BY fraudulent_transactions DESC
LIMIT 5;

-- Question 11

SELECT
    a.username,
    a.account_age_days,
    COUNT(t.transaction_id) AS fraudulent_transactions
FROM accounts a
JOIN transactions t
    ON a.account_id = t.account_id
WHERE t.is_fraud = 1
AND a.account_age_days <= 30
GROUP BY
    a.username,
    a.account_age_days
ORDER BY fraudulent_transactions DESC,
         a.account_age_days ASC;

-- Question 12

SELECT
    a.username,
    a.account_age_days,
    COUNT(t.transaction_id) AS fraudulent_transactions,
    ROUND(
        (COUNT(t.transaction_id) * 10.0) /
        (a.account_age_days + 1),
        2
    ) AS risk_score
FROM accounts a
JOIN transactions t
    ON a.account_id = t.account_id
WHERE t.is_fraud = 1
GROUP BY
    a.account_id,
    a.username,
    a.account_age_days
ORDER BY risk_score DESC;

-- Question 13

WITH fraud_risk AS (
    SELECT
        a.username,
        a.country,
        a.account_age_days,
        COUNT(t.transaction_id) AS fraudulent_transactions,
        ROUND(
            (COUNT(t.transaction_id) * 10.0) /
            (a.account_age_days + 1),
            2
        ) AS risk_score
    FROM accounts a
    JOIN transactions t
        ON a.account_id = t.account_id
    WHERE t.is_fraud = 1
    GROUP BY
        a.account_id,
        a.username,
        a.country,
        a.account_age_days
)

SELECT *
FROM fraud_risk
WHERE
    account_age_days <= 30
    AND fraudulent_transactions >= 2
    AND risk_score >= 1
ORDER BY risk_score DESC;

-- Question 14

SELECT
    transaction_date,
    COUNT(*) AS fraudulent_transactions
FROM transactions
WHERE is_fraud = 1
GROUP BY transaction_date
ORDER BY transaction_date;

-- Question 15

SELECT
    transaction_date,
    COUNT(*) AS daily_fraud,
    SUM(COUNT(*)) OVER (
        ORDER BY transaction_date
    ) AS cumulative_fraud
FROM transactions
WHERE is_fraud = 1
GROUP BY transaction_date
ORDER BY transaction_date;

-- Question 16

SELECT
    payment_method,
    COUNT(*) AS fraudulent_transactions
FROM transactions
WHERE is_fraud = 1
GROUP BY payment_method
ORDER BY fraudulent_transactions DESC;

-- Question 17

SELECT
    country,
    COUNT(*) AS fraudulent_transactions,
    DENSE_RANK() OVER (
        ORDER BY COUNT(*) DESC
    ) AS country_risk_rank
FROM accounts a
JOIN transactions t
    ON a.account_id = t.account_id
WHERE t.is_fraud = 1
GROUP BY country;

-- Question 18

SELECT
    a.username,
    ROUND(AVG(t.amount), 2) AS avg_fraud_amount
FROM accounts a
JOIN transactions t
    ON a.account_id = t.account_id
WHERE t.is_fraud = 1
GROUP BY a.username
ORDER BY avg_fraud_amount DESC;

-- Question 19

WITH fraud_risk AS (
    SELECT
        a.username,
        a.account_age_days,
        COUNT(*) AS fraudulent_transactions,
        ROUND(
            (COUNT(*) * 10.0) /
            (a.account_age_days + 1),
            2
        ) AS risk_score
    FROM accounts a
    JOIN transactions t
        ON a.account_id = t.account_id
    WHERE t.is_fraud = 1
    GROUP BY
        a.account_id,
        a.username,
        a.account_age_days
)

SELECT
    ROW_NUMBER() OVER (
        ORDER BY risk_score DESC
    ) AS investigation_priority,
    username,
    fraudulent_transactions,
    risk_score
FROM fraud_risk;

-- Question 20

WITH fraud_summary AS (
    SELECT
        COUNT(DISTINCT a.account_id) AS fraudulent_accounts,
        COUNT(t.transaction_id) AS fraudulent_transactions
    FROM accounts a
    JOIN transactions t
        ON a.account_id = t.account_id
    WHERE t.is_fraud = 1
),

country_summary AS (
    SELECT
        a.country,
        COUNT(t.transaction_id) AS fraudulent_transactions
    FROM accounts a
    JOIN transactions t
        ON a.account_id = t.account_id
    WHERE t.is_fraud = 1
    GROUP BY a.country
)

SELECT
    (SELECT fraudulent_accounts FROM fraud_summary) AS fraudulent_accounts,
    (SELECT fraudulent_transactions FROM fraud_summary) AS fraudulent_transactions,
    country,
    fraudulent_transactions
FROM country_summary
ORDER BY fraudulent_transactions DESC;