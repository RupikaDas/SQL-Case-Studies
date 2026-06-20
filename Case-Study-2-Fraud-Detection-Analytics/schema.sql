CREATE TABLE accounts (
    account_id INTEGER PRIMARY KEY,
    username TEXT NOT NULL,
    country TEXT,
    account_age_days INTEGER
);

CREATE TABLE transactions (
    transaction_id INTEGER PRIMARY KEY,
    account_id INTEGER,
    transaction_date DATE,
    amount REAL,
    payment_method TEXT,
    is_fraud INTEGER,
    FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);

CREATE TABLE fraud_actions (
    action_id INTEGER PRIMARY KEY,
    transaction_id INTEGER,
    action_type TEXT,
    review_date DATE,
    FOREIGN KEY (transaction_id) REFERENCES transactions(transaction_id)
);