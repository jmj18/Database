--1 
SELECT *
FROM LGDEPARTMENT

--2 
SELECT *
FROM LGPRODUCT
WHERE PROD_BASE='WATER' AND PROD_CATEGORY= 'SEALER'

--3
SELECT EMP_FNAME,EMP_LNAME,EMP_EMAIL
FROM LGEMPLOYEE
WHERE EMP_HIREDATE >= '1/1/2001' AND EMP_HIREDATE <= '12/31/2010'
ORDER BY EMP_LNAME,EMP_FNAME,EMP_EMAIL

--4
SELECT EMP_FNAME,EMP_LNAME,EMP_PHONE,EMP_TITLE,DEPT_NUM
FROM LGEMPLOYEE
WHERE DEPT_NUM= '300' OR EMP_TITLE= 'CLERK I'
ORDER BY EMP_LNAME,EMP_FNAME

--5
SELECT E.EMP_NUM,E.EMP_LNAME,E.EMP_FNAME,H.SAL_FROM,H.SAL_END
FROM LGEMPLOYEE E INNER JOIN LGSALARY_HISTORY H ON E.EMP_NUM=H.EMP_NUM
WHERE E.EMP_NUM='83731' OR E.EMP_NUM='83745' OR E.EMP_NUM='84039'


--6
SELECT DISTINCT C.CUST_FNAME,C.CUST_LNAME,C.CUST_STREET,C.CUST_CITY,C.CUST_ZIP
FROM LGCUSTOMER C INNER JOIN LGINVOICE I ON C.CUST_CODE=I.CUST_CODE
	 INNER JOIN LGLINE L ON L.INV_NUM=I.INV_NUM INNER JOIN LGPRODUCT P 
	 ON P.PROD_SKU=L.PROD_SKU INNER JOIN LGBRAND B ON B.BRAND_ID=P.BRAND_ID
WHERE B.BRAND_NAME='FORESTERS BEST' AND P.PROD_CATEGORY= 'TOP COAT' AND 
	  I.INV_DATE > '7/15/2013' AND I.INV_DATE < '7/31/2013'


--7 
SELECT EMP_NUM,EMP_LNAME,EMP_EMAIL,EMP_TITLE,DEPT_NUM
FROM LGEMPLOYEE
WHERE EMP_TITLE= 'ASSOCIATE' OR EMP_TITLE= 'SENIOR ASSOCIATE' OR EMP_TITLE= 'BRAND ASSOCIATE'


--8
SELECT BRAND_NAME, COUNT(PROD_SKU)AS NUMPRODUCTS   
FROM LGBRAND B,LGPRODUCT P 
WHERE B.BRAND_ID=P.BRAND_ID
GROUP BY BRAND_NAME
ORDER BY BRAND_NAME

--9
SELECT PROD_CATEGORY,COUNT(*) AS NUMPRODUCT 
FROM LGPRODUCT
WHERE PROD_BASE='WATER'
GROUP BY PROD_CATEGORY

--10
SELECT PROD_BASE, PROD_TYPE, COUNT(*) AS NUMPRODUCTS
FROM LGPRODUCT
GROUP BY PROD_BASE,PROD_TYPE
ORDER BY PROD_BASE,PROD_TYPE


--11
SELECT BRAND_ID,SUM(PROD_QOH) AS TOTALINVENTORY  
FROM LGPRODUCT
GROUP BY BRAND_ID
ORDER BY BRAND_ID

--12
SELECT P.BRAND_ID,BRAND_NAME,ROUND(AVG(PROD_PRICE),2) AS AVGPRICE 
FROM LGBRAND B, LGPRODUCT P
WHERE B.BRAND_ID=P.BRAND_ID
GROUP BY P.BRAND_ID,BRAND_NAME
ORDER BY BRAND_NAME 


--13
SELECT DEPT_NUM,MAX(EMP_HIREDATE) AS MOSTRECENT
FROM LGEMPLOYEE
GROUP BY DEPT_NUM
ORDER BY DEPT_NUM


--14
SELECT E.EMP_NUM,EMP_FNAME,EMP_LNAME,MAX(SAL_AMOUNT) AS LARGESTSALARY 
FROM LGEMPLOYEE E, LGSALARY_HISTORY S
WHERE E.EMP_NUM=S.EMP_NUM AND DEPT_NUM='200'
GROUP BY E.EMP_NUM,E.EMP_FNAME,E.EMP_LNAME
ORDER BY MAX(SAL_AMOUNT) DESC


--15
SELECT C.CUST_CODE,CUST_FNAME,CUST_LNAME,SUM(INV_TOTAL)AS TOTALINVOICE
FROM LGCUSTOMER C INNER JOIN LGINVOICE I ON C.CUST_CODE=I.CUST_CODE
GROUP BY C.CUST_CODE,C.CUST_FNAME,C.CUST_LNAME
HAVING SUM(INV_TOTAL)> '1500'
ORDER BY SUM(INV_TOTAL)DESC


--16
SELECT D.DEPT_NUM,D.DEPT_NAME,D.DEPT_PHONE,D.EMP_NUM,E.EMP_LNAME
FROM LGDEPARTMENT D INNER JOIN LGEMPLOYEE E ON D.EMP_NUM=E.EMP_NUM
ORDER BY D.DEPT_NAME


--17
SELECT V.VEND_ID,V.VEND_NAME,B.BRAND_NAME,COUNT(*)AS NUMPRODUCTS
FROM LGBRAND B INNER JOIN LGPRODUCT P ON B.BRAND_ID=P.BRAND_ID INNER JOIN LGSUPPLIES S ON 
	 S.PROD_SKU=P.PROD_SKU INNER JOIN LGVENDOR V ON V.VEND_ID=S.VEND_ID
GROUP BY V.VEND_ID,V.VEND_NAME,B.BRAND_NAME
ORDER BY V.VEND_NAME,B.BRAND_NAME


--18
SELECT E.EMP_NUM,E.EMP_LNAME,E.EMP_FNAME,SUM(INV_TOTAL)AS TOTALINVOICE 
FROM LGINVOICE I INNER JOIN LGEMPLOYEE E ON I.EMPLOYEE_ID=E.EMP_NUM
GROUP BY EMP_NUM,EMP_FNAME,EMP_LNAME
ORDER BY EMP_FNAME,EMP_LNAME


--19
SELECT Max(TEMP.AVGPRICE) AS LARGESTAVERAGE 
FROM (SELECT BRAND_ID, Round(Avg(PROD_PRICE),2) AS AVGPRICE
      FROM LGPRODUCT P 
	  GROUP BY BRAND_ID)TEMP


--20
SELECT P.BRAND_ID,BRAND_NAME,BRAND_TYPE,ROUND(AVG(PROD_PRICE),2) AS AVGPRICE
FROM LGPRODUCT P INNER JOIN LGBRAND B ON P.BRAND_ID=B.BRAND_ID
GROUP BY P.BRAND_ID,BRAND_NAME,BRAND_TYPE
HAVING ROUND(AVG(PROD_PRICE),2)=(SELECT MAX(TEMP.AVGPRICE)AS LARGESTAVERAGE
								 FROM (SELECT BRAND_ID,ROUND(AVG(PROD_PRICE),2) AS AVGPRICE
									   FROM LGPRODUCT P
									   GROUP BY BRAND_ID)TEMP
									   )



--21
SELECT MANGERNAME=E.EMP_FNAME+EMP_LNAME, D.DEPT_NAME, D.DEPT_PHONE,EMPLOYEENAME=C.CUST_FNAME+C.CUST_LNAME, I.INV_DATE,I.INV_TOTAL
FROM LGEMPLOYEE E INNER JOIN LGDEPARTMENT D ON E.DEPT_NUM=D.DEPT_NUM INNER JOIN LGINVOICE I ON 
     E.EMP_NUM=I.EMPLOYEE_ID INNER JOIN LGCUSTOMER C ON C.CUST_CODE=I.CUST_CODE
WHERE C.CUST_LNAME='HAGAN'AND I.INV_DATE= '5/18/2011'



								 
	 



