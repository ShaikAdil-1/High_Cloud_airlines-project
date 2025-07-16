
# Q1
SELECT 
    CAST(CONCAT(Year, '-', `Month (#)`, '-', Day) AS DATE) AS FlightDate
FROM maindata;

SELECT 
    YEAR(CAST(CONCAT(Year, '-',`Month (#)`, '-', Day) AS DATE)) AS FlightYear
FROM maindata;

SELECT 
    MONTH(CAST(CONCAT(Year, '-', `Month (#)`, '-', Day) AS DATE)) AS MonthNumber
FROM maindata;

#??
SELECT 
    DATE_FORMAT(STR_TO_DATE(CONCAT(Year, '-',`Month (#)` , '-', Day), '%Y-%m-%d'), '%M') AS MonthName
FROM maindata;


#??
SELECT 
    CONCAT('Q', QUARTER(STR_TO_DATE(CONCAT(Year, '-', `Month (#)`, '-', Day), '%Y-%m-%d'))) AS Quarter
FROM maindata;


#??
SELECT 
    DATE_FORMAT(STR_TO_DATE(CONCAT(Year, '-',  `Month (#)`, '-', Day), '%Y-%m-%d'), '%Y-%b') AS YearMonth
FROM maindata;


# ??
SELECT 
    WEEKDAY(STR_TO_DATE(CONCAT(Year, '-', `Month (#)` , '-', Day), '%Y-%m-%d')) AS WeekdayNumber
FROM maindata;


# ??
SELECT 
    DAYNAME(STR_TO_DATE(CONCAT(Year, '-', `Month (#)` , '-', Day), '%Y-%m-%d')) AS WeekdayName
FROM maindata;

##
SELECT 
    CASE 
        WHEN `Month (#)`>= 4 THEN  `Month (#)`
        ELSE `Month (#)`+ 12 
    END AS FinancialMonth
FROM maindata;

SELECT 
    CASE 
        WHEN `Month (#)` IN (4,5,6) THEN 'Q1'
        WHEN `Month (#)` IN (7,8,9) THEN 'Q2'
        WHEN `Month (#)` IN (10,11,12) THEN 'Q3'
        ELSE 'Q4'
    END AS FinancialQuarter
FROM maindata;

# Q2

-- Monthly
    SELECT 
    `Year`, `Month (#)`,
    ROUND(SUM(`# Transported Passengers`) / SUM(`# Available Seats`) * 100, 2) AS MonthlyLoadFactorPercent
FROM maindata
GROUP BY `Year`, `Month (#)`
ORDER BY `Year`, `Month (#)`;

-- Quarterly
SELECT 
    Year,
    CASE 
        WHEN `Month (#)` IN (1,2,3) THEN 'Q1'
        WHEN `Month (#)` IN (4,5,6) THEN 'Q2'
        WHEN `Month (#)` IN (7,8,9) THEN 'Q3'
        ELSE 'Q4'
    END AS Quarter,
   round( SUM(`# Transported Passengers`) * 1.0 / SUM(`# Available Seats`) *100,2) AS QuarterlyLoadFactor
FROM maindata
GROUP BY Year, 
    CASE 
        WHEN `Month (#)` IN (1,2,3) THEN 'Q1'
        WHEN `Month (#)` IN (4,5,6) THEN 'Q2'
        WHEN `Month (#)` IN (7,8,9) THEN 'Q3'
        ELSE 'Q4'
    END;

-- Yearly
SELECT 
    Year,
   round( SUM(`# Transported Passengers`) * 1.0 / SUM(`# Available Seats`) *100,2) AS YearlyLoadFactor
FROM maindata
GROUP BY Year;

# Q3

SELECT 
    `Carrier Name`,
   round( SUM(`# Transported Passengers`) * 1.0 / SUM(`# Available Seats`)*100,2) AS CarrierLoadFactor
FROM maindata
GROUP BY `Carrier Name`
limit 10;


# Q4
SELECT 
    `Carrier Name`,
    SUM(`# Transported Passengers`) AS TotalPassengers
FROM maindata
GROUP BY `Carrier Name`
ORDER BY TotalPassengers DESC
LIMIT 10;

#Q5
SELECT 
`Origin City`,`Destination City`,
    COUNT(*) AS NumberOfFlights
FROM maindata
GROUP BY `Origin City`, `Destination City`
ORDER BY NumberOfFlights DESC;

# Q6
SELECT 
    CASE 
        WHEN DAYOFWEEK(STR_TO_DATE(CONCAT(Year, '-', `Month (#)`, '-', Day), '%Y-%m-%d')) IN (1,7) THEN 'Weekend'
        ELSE 'Weekday'
    END AS DayType,
    COUNT(*) AS TotalFlights,
    SUM(`# Transported Passengers`) AS TotalPassengers,
    SUM(`# Available Seats`) AS TotalSeats,
    ROUND(SUM(`# Transported Passengers`) / SUM(`# Available Seats`) * 100, 2) AS LoadFactor
FROM maindata
GROUP BY DayType;

# Q7
SELECT 
    CASE 
        WHEN Distance < 500 THEN 'Short'
        WHEN Distance BETWEEN 500 AND 1500 THEN 'Medium'
        ELSE 'Long'
    END AS `%Distance Group ID`,
    COUNT(*) AS FlightsCount
FROM maindata
GROUP BY 
    CASE 
        WHEN Distance < 500 THEN 'Short'
        WHEN Distance BETWEEN 500 AND 1500 THEN 'Medium'
        ELSE 'Long'
    END;




