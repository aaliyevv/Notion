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

TRUNCATE TABLE customerss CASCADE; /* Deletes all rows and dependent raw immediately and resets.*/

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


CREATE TABLE orderss (
    id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL REFERENCES customerss(id) ON DELETE CASCADE,
    order_date DATE DEFAULT CURRENT_DATE,
    total_amount NUMERIC(10,2) NOT NULL
);

INSERT INTO orderss (customer_id, order_date, total_amount)
VALUES (3, '2026-01-13', 2300);

INSERT INTO orderss (customer_id, order_date, total_amount)
VALUES (5, '2026-01-15', 1300);

SELECT count(total_amount) FROM orderss;

SELECT total_amount, COUNT(*) AS order_count
FROM orderss
GROUP BY total_amount;

SELECT customer_id, COUNT(*) AS order_count
FROM orderss
GROUP BY customer_id
HAVING COUNT(*) > 0; /* Keep only customers with more than 2 orders */

DELETE FROM orderss
WHERE id IN (3, 4, 5, 6);

CREATE TABLE productss (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    category VARCHAR(50),
    price NUMERIC (10,2) NOT NULL
);

SELECT * FROM productss;

SELECT category, productss.name FROM productss WHERE price > 2000;

SELECT customerss.first_name || ' ' || customerss.last_name AS full_name, customerss.phone
FROM customerss;
/* concatenation operator */

SELECT * FROM productss WHERE name LIKE '%phone%';

SELECT distinct category FROM productss WHERE category LIKE '%ho%';
/* returns unique (non-duplicate) category values */

TRUNCATE TABLE productss RESTART IDENTITY CASCADE;

CREATE TABLE order_item (
    id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orderss(id) ON DELETE CASCADE,
    product_id INT REFERENCES productss(id) ON DELETE CASCADE,
    quantity INT NOT NULL,
    subtotal NUMERIC(10,2)
);

CREATE TABLE paymentss (
    id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orderss(id) ON DELETE CASCADE,
    payment_date DATE DEFAULT CURRENT_DATE,
    amount NUMERIC(10,2)
);

CREATE TABLE complaintss (
    id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customerss(id) ON DELETE CASCADE,
    complaint_text TEXT NOT NULL,
    status VARCHAR(20) DEFAULT 'unsolved',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO orderss (customer_id, order_date, total_amount)
VALUES (1,'2026-01-10', 1500),
       (2,'2026-01-11', 1800);

DELETE FROM orderss
WHERE customer_id IN (3, 4);

INSERT INTO productss (name, category, price)
VALUES ('Iphone', 'Phone', 3000),
       ('Samsung', 'Phone', 2000);


DELETE FROM productss
WHERE id IN (1, 2);

INSERT INTO order_item (order_id, product_id, quantity, subtotal)
VALUES (1, 1, 2, 6000),
       (2, 2, 3, 6000);

DELETE FROM order_item
WHERE order_id IN (3, 4, 5, 6);

INSERT INTO paymentss (order_id, payment_date, amount)
VALUES (1, '2025-12-5', 6000),
       (2, '2025-12-24', 6000);

SELECT DISTINCT subtotal FROM order_item;

INSERT INTO complaintss (customer_id, complaint_text, status) /* default date */
VALUES (1, 'higher price', 'unsolved' ),
       (2, 'bad service', 'solved');


SELECT c.first_name, c.last_name, o.total_amount  FROM customerss c
JOIN orderss o on c.id=customer_id;

SELECT first_name, last_name, o.total_amount, o.order_date FROM customerss c
LEFT JOIN orderss o on c.id=customer_id;

SELECT o.id, o.customer_id, o.order_date, o.total_amount, c.last_name, c.first_name
FROM customerss c
RIGHT JOIN orderss o on c.id=customer_id;

SELECT * FROM orderss o
FULL JOIN customerss c on c.id = o.customer_id;


SELECT * FROM customerss
INNER JOIN orderss o on customerss.id = o.customer_id
INNER JOIN paymentss p on o.id = p.order_id;


SELECT * FROM customerss c
WHERE EXISTS(
    SELECT 1 FROM orderss o
    WHERE c.id=o.customer_id
); /* EXISTS only checks whether a row exists, so the value selected inside it
      doesn’t affect the result. */


DELETE FROM courses WHERE id=1;

