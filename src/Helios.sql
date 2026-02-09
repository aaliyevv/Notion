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

SELECT customerss.first_name, customerss.last_name, customerss.account_balance
FROM customerss;

SELECT * FROM customerss LIMIT 2;

SELECT first_name, last_name
FROM customerss ORDER BY first_name DESC;

DELETE FROM customerss
WHERE id IN (5, 6);

TRUNCATE TABLE customerss CASCADE; /* Deletes all rows and dependent raw immediately and resets. */

TRUNCATE TABLE customerss RESTART IDENTITY CASCADE; /* Deletes all rows and dependent raw
                                                       immediately and resets any SERIAL*/

SELECT * FROM customerss WHERE id=1 AND city='Sumgayit';

SELECT * FROM customerss WHERE id=1 OR city='Sumgayit';

SELECT * FROM customerss WHERE NOT id=5;

SELECT * FROM customerss WHERE id=3 AND  email='ravan@example.com'
                            OR city='Sumgayit';

SELECT * FROM customerss WHERE id IN (3,5,6);

SELECT * FROM customerss WHERE city IN ('Baku', 'Sumgayit');

SELECT * FROM orderss WHERE total_amount BETWEEN 1800 AND 2400;

SELECT customerss.email FROM customerss WHERE id=1;
UPDATE customerss SET email='aaliyev@example.com' WHERE id=1;

UPDATE customerss SET phone='+994706848773' WHERE id=2;

UPDATE orderss
    SET total_amount = CASE
        WHEN id=1 THEN 1600
        WHEN id=2 THEN 1900
    END
WHERE id IN (1,2);

ALTER TABLE customerss ADD COLUMN age INT DEFAULT 18;
ALTER TABLE customerss DROP COLUMN age;

UPDATE customerss
    SET age = CASE
        WHEN id=1 THEN 23
        WHEN id=2 THEN 22
    END
WHERE id IN (1,2);

/* SELECT customer_id, sum(total_amount) AS total_spent
FROM orderss
GROUP BY customer_id; */


