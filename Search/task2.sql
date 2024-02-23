-- 1
SELECT FLOOR(AVG(Population))
FROM CITY;

-- 2
SELECT MAX(Months * Salary) AS max_total_earnings,
COUNT(*) AS num_employees_with_max_earnings
FROM Employee
WHERE Months * Salary = (SELECT MAX(Months * Salary) FROM Employee);

-- 3
SELECT ROUND(SUM(LAT_N), 2) AS sum_lat_n,
ROUND(SUM(LONG_W), 2) AS sum_long_w
FROM STATION;

-- 5
SELECT COUNTRY.Continent, FLOOR(AVG(CITY.Population)) AS avg_city_population
FROM CITY
JOIN COUNTRY ON CITY.CountryCode = COUNTRY.Code
GROUP BY COUNTRY.Continent;