SELECT * FROM CUSTOMERS
SELECT * FROM ORDERS
SELECT * FROM ORDER_ITEMS
SELECT * FROM ITEMS

-- 1. Display the order (order ID, customer full name, and order date) and the
-- number of items it contains (aka the number of the different items, not how
-- many times – the quantity – each was ordered)
SELECT o.order_id, o.order_date, c.cust_fname + ' ' + c.cust_lname AS FullName,
count(oi.id) AS NmItems
FROM ORDERS o
JOIN CUSTOMERS c ON o.cust_id = c.cust_id
JOIN ORDER_ITEMS oi ON o.order_id = oi.order_id
GROUP BY o.order_id, c.cust_fname + ' ' + c.cust_lname, o.order_date
ORDER BY o.order_id;


-- 2. Display the order (order ID, customer full name, and order date) that contains
-- the most items
SELECT TOP 3 o.order_id, o.order_date, c.cust_fname + ' ' + c.cust_lname AS FullName,
count(oi.id) AS NumItems
FROM ORDERS o
JOIN CUSTOMERS c ON o.cust_id = c.cust_id
JOIN ORDER_ITEMS oi ON o.order_id = oi.order_id
GROUP BY o.order_id, c.cust_fname + ' ' + c.cust_lname, o.order_date
ORDER BY COUNT(oi.id) DESC;


-- 3. Display the order (order ID, customer full name, and order date) and the
-- number of items that should be packed (aka the number of different items
-- times the quantity)
SELECT o.order_id, o.order_date, c.cust_fname + ' ' + c.cust_lname AS FullName,
(count(oi.id) * oi.order_qty) AS PackedItems
FROM ORDERS o
JOIN CUSTOMERS c ON o.cust_id = c.cust_id
JOIN ORDER_ITEMS oi ON o.order_id = oi.order_id
GROUP BY o.order_id, c.cust_fname + ' ' + c.cust_lname, o.order_date, oi.order_qty


-- 4. Display the order (order ID, customer full name, and order date) that contains
-- the most items to be packed
SELECT TOP 1 o.order_id, o.order_date, c.cust_fname + ' ' + c.cust_lname AS FullName,
(count(oi.id) * oi.order_qty) AS PackedItems
FROM ORDERS o
JOIN CUSTOMERS c ON o.cust_id = c.cust_id
JOIN ORDER_ITEMS oi ON o.order_id = oi.order_id
GROUP BY o.order_id, c.cust_fname + ' ' + c.cust_lname, o.order_date, oi.order_qty
ORDER BY (count(oi.id) * oi.order_qty) DESC


-- 5. Display the total amount of money per order (order id and date, customer
-- name)
SELECT o.order_id, o.order_date, c.cust_fname + ' ' + c.cust_lname AS FullName,
SUM(oi.order_qty * i.item_price) as TotalPrice
FROM ITEMS i
JOIN ORDER_ITEMS oi ON i.item_id = oi.item_id
JOIN ORDERS o ON oi.order_id = o.order_id
JOIN CUSTOMERS c on o.cust_id = c.cust_id
GROUP BY o.order_id, c.cust_fname + ' ' + c.cust_lname, o.order_date

-- 6. Display the average total amount of money (for all orders)
SELECT AVG(TotalPrice) as AvrgPrice
FROM (
    SELECT o.order_id, SUM(oi.order_qty * i.item_price) as TotalPrice
    FROM ITEMS i
    JOIN ORDER_ITEMS oi ON i.item_id = oi.item_id
    JOIN ORDERS o ON oi.order_id = o.order_id
    JOIN CUSTOMERS c on o.cust_id = c.cust_id
    GROUP BY o.order_id
) SubQuery;

-- 7. Display the total amount per customer (full name) in the past 2 years
SELECT c.cust_fname + ' ' + c.cust_lname AS FullName,
SUM(oi.order_qty * i.item_price) as TotalPrice
FROM ITEMS i
JOIN ORDER_ITEMS oi ON i.item_id = oi.item_id
JOIN ORDERS o ON oi.order_id = o.order_id
JOIN CUSTOMERS c on o.cust_id = c.cust_id
WHERE o.order_date >= DATEADD(MONTH, -24, GETDATE())
GROUP BY c.cust_fname + ' ' + c.cust_lname

-- 8. Display the most popular item (most times it was ordered)
SELECT SUM(oi.order_qty) AS TimesBought, oi.item_id
FROM ORDER_ITEMS oi
GROUP BY oi.item_id
ORDER BY TimesBought DESC

UPDATE CUSTOMERS
SET cust_phone = '234567'
WHERE cust_id = 103

SELECT * 
FROM CUSTOMERS
WHERE cust_fname = 'John'

SELECT cust_fname
FROM CUSTOMERS c
LEFT JOIN ORDERS o ON c.cust_id = o.cust_id
WHERE o.cust_id is null

SELECT c.cust_fname, c.cust_lname
FROM CUSTOMERS c
LEFT JOIN ORDERS o ON o.cust_id=c.cust_id
WHERE o.order_id is null;

SELECT i.item_id, i.item_desc
FROM ITEMS i
LEFT JOIN ORDER_ITEMS oi ON i.item_id = oi.item_id
WHERE oi.item_id is null

SELECT SUM(i.item_price) AS TotalAmountSpent, c.cust_id
FROM CUSTOMERS c 
LEFT JOIN ORDERS o ON c.cust_id = o.cust_id
LEFT JOIN ORDER_ITEMS oi ON o.order_id = oi.order_id
LEFT JOIN ITEMS i ON oi.item_id = i.item_id
GROUP BY c.cust_id




