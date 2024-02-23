-- 1.
SELECT P.product_name, S.year, S.price
FROM Sales S, Product P
WHERE S.product_id = P.product_id;

--2.
SELECT DISTINCT author_id AS id 
FROM Views 
WHERE author_id = viewer_id 
ORDER BY id ASC

-- 3.
SELECT Employee.name,Bonus.bonus FROM Employee 
LEFT JOIN Bonus ON Employee.empID = Bonus.empID
WHERE bonus < 1000 OR Bonus IS NULL ;

-- 4.
SELECT * FROM Cinema WHERE MOD( id, 2) = 1 AND 
description <> 'boring' ORDER BY rating DESC

-- 5.
SELECT ACTOR_ID, DIRECTOR_ID 
FROM ACTORDIRECTOR 
GROUP BY ACTOR_ID,DIRECTOR_ID 
HAVING COUNT(TIMESTAMP)>2;