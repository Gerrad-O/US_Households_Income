# US Household Project Data Cleaning



ALTER TABLE us_household_project.us_household_income_statistics RENAME COLUMN `ï»¿id` to `id`;

SELECT *
 FROM us_household_income
 ;

SELECT *
 FROM us_household_income_statistics
 ;


SELECT COUNT(id)
 FROM us_household_project.us_household_income
 ;

SELECT COUNT(id)
 FROM us_household_income_statistics
 ;
 
 
 # Identifying Duplicates
 
 SELECT id, Count(ID)
 FROM  us_household_income_statistics 
 GROUP BY id
 HAVING Count(id) > 1
 ;
 
 SELECT id, Count(ID)
 FROM us_household_project.us_household_income
 GROUP BY id
 HAVING Count(id) > 1
 ;
 
 # Deleting Duplicates
 
 SELECT row_id
	FROM (
	SELECT row_id,
	id, 
	ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) row_num
	FROM us_household_income
	) duplicates
 WHERE row_num > 1
 ;
 
 
 DELETE FROM us_household_income
 WHERE row_id IN (
	SELECT row_id
	FROM (
	SELECT row_id,
	id, 
	ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) row_num
	FROM us_household_income
	) duplicates
 WHERE row_num > 1)
  ;
  
  
  
 # Standardizing Data 
  
 SELECT DISTINCT State_Name
 FROM us_household_income
 GROUP BY State_Name
 ORDER BY 1
 ;
 
 UPDATE us_household_income
SET State_Name = 'Georgia'
WHERE State_Name = 'georia';

 UPDATE us_household_income
SET State_Name = 'Alabama'
WHERE State_Name = 'alabama';


SELECT *
 FROM us_household_income
 WHERE County = 'Autauga County'
 ORDER BY 1
 ;

UPDATE us_household_income
SET Place = 'Autaugaville'
WHERE County = 'Autauga County'
AND City = 'Vinemont'
;


SELECT Type, COUNT(type)
 FROM us_household_income
GROUP BY Type
 #ORDER BY 1
 ;
 
 UPDATE us_household_income
SET `Primary` = 'Place'
WHERE `Primary` = 'place'
;

 
UPDATE us_household_income
SET Type = 'Borough'
WHERE type = 'Boroughs'
;

 UPDATE us_household_income
SET Type = 'CDP'
WHERE type = 'CPD'
;


SELECT ALand, AWater
 FROM us_household_income
 WHERE (ALand = 0 OR ALand = '' OR ALand IS NULL)
;
 
 
 