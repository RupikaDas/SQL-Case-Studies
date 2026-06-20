CREATE TABLE users (
    user_id INTEGER PRIMARY KEY,
    username TEXT NOT NULL,
    signup_date DATE,
    country TEXT
);

CREATE TABLE sessions (
    session_id INTEGER PRIMARY KEY,
    user_id INTEGER,
    session_date DATE,
    session_duration_minutes INTEGER,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE activities (
    activity_id INTEGER PRIMARY KEY,
    user_id INTEGER,
    activity_type TEXT,
    activity_date DATE,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE subscriptions (
    subscription_id INTEGER PRIMARY KEY,
    user_id INTEGER,
    plan_type TEXT,
    subscription_status TEXT,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);