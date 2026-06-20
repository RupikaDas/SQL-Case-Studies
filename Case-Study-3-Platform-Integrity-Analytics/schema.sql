CREATE TABLE users (
    user_id INTEGER PRIMARY KEY,
    username TEXT NOT NULL,
    country TEXT,
    account_age_days INTEGER
);

CREATE TABLE content (
    content_id INTEGER PRIMARY KEY,
    user_id INTEGER,
    content_type TEXT,
    post_date DATE,
    view_count INTEGER,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE reports (
    report_id INTEGER PRIMARY KEY,
    content_id INTEGER,
    report_reason TEXT,
    report_date DATE,
    FOREIGN KEY (content_id) REFERENCES content(content_id)
);

CREATE TABLE enforcement_actions (
    action_id INTEGER PRIMARY KEY,
    content_id INTEGER,
    action_type TEXT,
    action_date DATE,
    FOREIGN KEY (content_id) REFERENCES content(content_id)
);