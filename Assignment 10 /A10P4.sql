--JORDAN JOHNSON 
--A10 PART 4
SELECT CUST_CITY,PROD_CATEGORY,(PROD_QOH *PROD_PRICE) AS TOTAL
FROM CUSTOMER_DIMENSION, PRODUCT_DIMENSION
ORDER BY TOTAL

SELECT DISTINCT TOP(3) MONTH,(PROD_QOH *PROD_PRICE)AS TOTAL
FROM TIME_DIMENSION,PRODUCT_DIMENSION
ORDER BY TOTAL DESC

--LIST THE CITY, CATEGORY, EMPLOYEE TITLE, DEPT NAME, PRODUCT CATEGORY FOR THE TOP SALE MONTH
SELECT DISTINCT TOP(1) MONTH,CUST_CITY,DEPT_NAME,PROD_CATEGORY,(PROD_QOH *PROD_PRICE)AS TOTAL
FROM TIME_DIMENSION,CUSTOMER_DIMENSION,EMPLOYEE_DIMENSION,DEPARTMENT_DIMENSION,PRODUCT_DIMENSION
ORDER BY TOTAL DESC