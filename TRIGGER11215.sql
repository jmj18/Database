-- ================================================
-- Template generated from Template Explorer using:
-- Create Trigger (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- See additional Create Trigger templates for more
-- examples of different Trigger statements.
--
-- This block of comments will not be included in
-- the definition of the function.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE TRIGGER UPDATE_ITEM_ON_HAND
   ON  ORDER_LINE
   AFTER INSERT,DELETE,UPDATE
AS 
BEGIN

DECLARE @ITEM_NUM CHAR(4)
DECLARE @TOTAL INT

IF(EXIST(SELECT * FROM INSERTED)) 
BEGIN
--LOGIC TO HANDEL RECORDS IN INSERTED  
DECLARE INSERTED_CURSOR CURSOR FOR 
SELECT ITEM_NUM, SUM(NUM_ORDERED) AS TOTAL 
FROM INSERTED 
GROUP BY ITEM_NUM

OPEN INSERTED_CURSOR 
FETCH NEXT INTO @ITEM_NUM,@TOTAL 
WHILE (@@FETCH_STATUS=0)
BEGIN 
	UPDATE ITEM 
	SET ON_HAND=ON_HAND- @TOTAL 
	WHERE ITEM_NUM=@ITEM_NUM
	FETCH NEXT INTO @ITEM_NUM,@TOTAL 
END 
CLOSE INSERTED_CURSOR 
DEALLOCATE INSERTED_CURSOR 
END 

	
END
GO
