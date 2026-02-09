CREATE TABLE customerss (
    id SERIAL PRIMARY KEY, /* auto-incrementing integer */
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    city VARCHAR(50),
    account_balance NUMERIC(10,2) DEFAULT 0.00
);

INSERT INTO customerss (first_name)
VALUES ('Murad'); /* error */

INSERT INTO customerss (first_name, last_name, email)
VALUES ('Ravan', 'Gozalov', 'ravan@example.com');

INSERT INTO customerss (first_name, last_name, email)
VALUES ('Ravan', 'Xalilov', 'xravan@example.com');

INSERT INTO customerss (first_name, last_name, email)
VALUES ('Polad', 'Salmanov', 'polad@example.com');

INSERT INTO customerss (first_name, last_name, email, phone, city, account_balance)
VALUES ('Ali', 'Aliyev', 'ali@example.com', '+994705155558',
        'Baku', 500),
       ('Eljan', 'Abdullazada', 'eljan@example.com', '+994501112233',
        'Sumgayit', 300);

SELECT * FROM customerss;