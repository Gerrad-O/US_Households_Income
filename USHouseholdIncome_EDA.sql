# US Household Project Exploratory Data Analysis


SELECT *
 FROM us_household_income
 ;

SELECT *
 FROM us_household_income_statistics
 ;

# Top 10 States with the largest area of land

SELECT State_Name, SUM(ALand), SUM(AWater)
 FROM us_household_income
 GROUP BY State_Name
 ORDER BY 2 DESC
 LIMIT 10
 ;
 
 # Top 10 States with the largest body of water
 
 SELECT State_Name, SUM(ALand), SUM(AWater)
 FROM us_household_income
 GROUP BY State_Name
 ORDER BY 3 DESC
 LIMIT 10
 ;
 
 # Joining the tables
 
 SELECT *
 FROM us_household_income u
JOIN us_household_income_statistics s
	ON u.id = s.id
   ;


SELECT u.State_Name, County, Type, `Primary`, Mean, Median
 FROM us_household_income u
 INNER JOIN us_household_income_statistics s
	ON u.id = s.id
   WHERE MEAN <> 0
   ;
   
   # Bottom 10 average mean income households per state
   
   SELECT u.State_Name, ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
 FROM us_household_income u
 INNER JOIN us_household_income_statistics s
	ON u.id = s.id
       WHERE MEAN <> 0
GROUP BY u.State_Name
ORDER BY 2
LIMIT 10;


 # Top 10 average median income households per state

 SELECT u.State_Name, ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
 FROM us_household_income u
 INNER JOIN us_household_income_statistics s
	ON u.id = s.id
       WHERE MEAN <> 0
GROUP BY u.State_Name
ORDER BY 3 DESC
LIMIT 10;
    
    
# The average mean of household incomes per type
    
SELECT Type, COUNT(Type), ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_household_income u
INNER JOIN us_household_income_statistics s
	ON u.id = s.id
       WHERE MEAN <> 0
GROUP BY Type
HAVING COUNT(Type) > 100
ORDER BY 3 DESC
;
    

# The average median of household incomes per type
  
SELECT Type, COUNT(Type), ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_household_income u
INNER JOIN us_household_income_statistics s
	ON u.id = s.id
	WHERE MEAN <> 0
GROUP BY Type
HAVING COUNT(Type) > 100
ORDER BY 4 DESC
;
    
    # The average mean and median of household incomes per city
    
SELECT u.State_Name, City, ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_household_income u
JOIN us_household_income_statistics s
	ON u.id = s.id
    WHERE Mean <> 0
GROUP BY u.State_Name, City
ORDER BY 3 DESC
;


