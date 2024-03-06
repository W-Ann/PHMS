CREATE TABLE IF NOT EXISTS users
(
    `id`       INT PRIMARY KEY AUTO_INCREMENT,
    `name`     VARCHAR(255) NOT NULL,
    `email`    VARCHAR(255) NOT NULL UNIQUE,
    `password` VARCHAR(512) NOT NULL
);

CREATE TABLE IF NOT EXISTS sessions
(
    id      INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    token VARCHAR(255),
    is_valid BOOLEAN DEFAULT true,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);