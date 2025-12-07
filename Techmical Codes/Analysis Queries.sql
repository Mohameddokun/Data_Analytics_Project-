-- 1- Calculate the Percentage of employment in every age group
WITH AgeGroupTotals AS (
  SELECT
    Age_group,
    sum(Total) AS group_total
  FROM
    EmpAndAge
  GROUP BY
    Age_group
)

SELECT
  Age_group,
  group_total,
   CAST(ROUND((group_total * 100.0 / SUM(group_total) OVER()), 2) AS DECIMAL(10, 2)) AS percentage
FROM
  AgeGroupTotals

-- 2-Calculate The Percentage of freelancers in Egypt per gov


with Freelancing as (
    select
        Sector,
        sum(total) as total
    from
        MainjobAndSectors
    group by
        Sector
),
FreelancingWithPercentage AS (
    select
        sector,
        total,
        cast(round((total * 100.0 / sum(total) OVER()), 2) AS DECIMAL(10, 2)) AS percentage
    from
        Freelancing
)
select
    sector,
    total,
    percentage
from
    FreelancingWithPercentage
where
    sector = 'SelfEmployed_Inside_Home';

-- 3- Calculate the percentage of youth in every economy activity
with youth_percentage as(
SELECT
    Economy,
    SUM(CASE WHEN TRIM(Age_Group) IN ('<20', '<25', '<30') THEN total ELSE 0 END) AS YouthTotal,
    SUM(total) AS GrandTotal,
    CAST(
        ROUND(
            (SUM(CASE WHEN TRIM(Age_Group) IN ('<20', '<25', '<30') THEN total ELSE 0 END) * 100.0 / SUM(total)), 2
   )
    AS DECIMAL(10, 2)) AS YouthPercentage
FROM
    EconomyAndAge
GROUP BY
    Economy)
Select Economy,
    YouthTotal,
    GrandTotal,
    YouthPercentage,
    ROW_NUMBER() OVER(ORDER BY YouthPercentage DESC) AS rank
FROM youth_percentage

-- 4- Calculate the percentage of umemployment and operating

WITH CombinedData AS (
    SELECT
        p.Governorate,
        p.Age_Group,
        COALESCE(SUM(e.Total), 0) AS total_employees,
        SUM(p.Total) AS total_population
    FROM
        PopAndAge p
     JOIN
        EmpAndAge e ON p.Governorate = e.Governorate
                       AND p.Age_Group = e.Age_Group
                       AND p.Gender = e.Gender
WHERE
        p.Age_Group <> '<65'
    GROUP BY
        p.Governorate,
        p.Age_Group
)
SELECT
    Governorate,
    Age_Group,
    total_employees,
    total_population,
    CAST(
        CASE
            WHEN total_population > 0 THEN (total_employees * 100.0 / total_population)
            ELSE 0
        END
    AS DECIMAL(10, 2)) AS operating_percentage

 
FROM
    CombinedData

ORDER BY
    Governorate,
    Age_Group;

-- 6- The difference between every gender in main_job sector
select Mainjobs_sec , gender , sum(total) as total_per_gender

from MainjobsSecAndAge
group by Mainjobs_sec , Gender

-- 7- employees number per governorate
SELECT
    Governorate,
    SUM(total) AS Totalemployees,
    RANK() OVER (ORDER BY SUM(total) DESC) AS Rank
FROM
    EmpAndAge
GROUP BY
    Governorate;
