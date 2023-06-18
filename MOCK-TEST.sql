-- First question
SELECT c.LastName, c.CustomerSince
FROM Customers c
ORDER BY c.CustomerSince DESC

-- Second question
SELECT c.ID
FROM Customers c
WHERE c.CustomerTypeID = 3
AND c.CustomerSince BETWEEN '2022-10-01' AND '2022-11-30'

-- Third question
SELECT (c.FirstName + ' ' + c.LastName) AS FullName
FROM Customers c
WHERE c.CustomerTypeID = 3 
AND c.ID NOT IN (
    SELECT s.CustomerID
    FROM SupportTickets s
)
-- With JOINS
SELECT (c.FirstName + ' ' + c.LastName) AS FullName
FROM Customers c
LEFT JOIN SupportTickets s ON c.ID = s.CustomerID
WHERE c.CustomerTypeID = 3
  AND s.CustomerID IS NULL;

-- Fourth question
SELECT s.ResolutionTypeID, AVG(s.CallDurationMinutes) AS Averege_Duration
FROM SupportTickets s, ResolutionTypes r
WHERE s.ResolutionTypeID = r.ID
AND r.OutcomeIsPositive = 0
GROUP BY s.ResolutionTypeID
-- With JOINS
SELECT AVG(s.CallDurationMinutes) AS Average_Duration
FROM SupportTickets s
JOIN ResolutionTypes r ON s.ResolutionTypeID = r.ID
WHERE r.OutcomeIsPositive = 0;

ALTER TABLE ResolutionTypes
ADD Cost DECIMAL(10, 2);

ALTER TABLE SupportTickets
ADD Cost DECIMAL(10, 2);

UPDATE SupportTickets
SET Cost = 50
WHERE ResolutionTypeID = (
    SELECT r.ID
    FROM ResolutionTypes r
    WHERE r.Descr = 'Further Investigation Needed'
)


SELECT tt.Descr,
avg(datediff
(
hour,
cast(TicketOpened as datetime),
cast(TicketResolved as datetime)
)
)
FROM SupportTickets t
JOIN TicketTypes tt ON t.TicketTypeID=tt.ID
JOIN Customers c ON t.CustomerID=c.ID AND
month(c.CustomerSince)=month(getdate())
GROUP BY tt.Descr;


SELECT *
FROM Customers

SELECT *
FROM CustomerTypes

SELECT *
FROM SupportTickets

SELECT *
FROM ResolutionTypes

SELECT *
FROM TicketTypes



-- ---------------------------- diffrent tables ------------------------

-- SELECT o.order_id, o.order_date, c.cust_fname + ' ' + c.cust_lname AS FullName
-- FROM ORDERS o
-- JOIN CUSTOMERS c ON c.cust_id = o.cust_id

-- SELECT c.cust_fname + ' ' + c.cust_lname AS CustomerName, o.order_date, i.item_desc, o.order_qty * i.item_price AS TotalItemAmount
-- FROM ORDERS o
-- JOIN CUSTOMERS c ON c.cust_id = o.cust_id
-- JOIN ITEMS i ON i.item_id = o.item_id

-- SELECT c.cust_fname + ' ' + c.cust_lname AS CustomerName
-- FROM CUSTOMERS c
-- LEFT JOIN ORDERS o ON c.cust_id = o.cust_id
-- WHERE o.order_id is null

-- SELECT distinct c.cust_fname + ' ' + c.cust_lname AS CustomerName
-- FROM CUSTOMERS c
-- INNER JOIN ORDERS o ON c.cust_id = o.cust_id