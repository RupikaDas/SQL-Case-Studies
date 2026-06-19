CREATE TABLE users (
    user_id INTEGER PRIMARY KEY,
    username TEXT NOT NULL,
    country TEXT,
    account_age_days INTEGER
);

CREATE TABLE comments (
    comment_id INTEGER PRIMARY KEY,
    user_id INTEGER,
    comment_text TEXT,
    comment_date DATE,
    is_flagged INTEGER,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE moderation_actions (
    action_id INTEGER PRIMARY KEY,
    comment_id INTEGER,
    action_type TEXT,
    review_date DATE,
    FOREIGN KEY (comment_id) REFERENCES comments(comment_id)
);

INSERT INTO users VALUES
(1, 'alpha_user', 'USA', 365),
(2, 'spam_king', 'India', 30),
(3, 'normal_user', 'UK', 720),
(4, 'toxic_guy', 'Canada', 60),
(5, 'new_account', 'India', 5);

INSERT INTO comments VALUES
(101, 1, 'Great video, very helpful!', '2025-06-01', 0),
(102, 2, 'Click here to win free money!', '2025-06-01', 1),
(103, 3, 'Thanks for sharing this content.', '2025-06-02', 0),
(104, 4, 'You are stupid and useless.', '2025-06-02', 1),
(105, 2, 'Visit my profile for free gifts.', '2025-06-03', 1),
(106, 5, 'Nice tutorial!', '2025-06-03', 0);

INSERT INTO moderation_actions VALUES
(1, 102, 'Removed', '2025-06-01'),
(2, 104, 'Warning', '2025-06-02'),
(3, 105, 'Removed', '2025-06-03');