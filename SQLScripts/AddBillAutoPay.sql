#Add auto bill to Bills Table

USE loanckr;
DROP PROCEDURE IF EXISTS loanckr.SP_addAutoBill;
DELIMITER $$
CREATE PROCEDURE loanckr.SP_addAutoBill(IN memberidp VARCHAR(255))
BEGIN
	DECLARE customerIdp VARCHAR(10);
    DECLARE connectionType VARCHAR(10);
    DECLARE merchantp VARCHAR(60);
    
    SET @customerIdp = CONCAT(F_randNum(3),F_randChar(5),F_randNum(4));
    SET @merchantp = (SELECT merchant FROM ((SELECT CAST(CONCAT(1,F_randNum(1)) AS CHAR) AS id) A JOIN merchants B ON A.id = B.merchantId));
	
    IF (F_checkExistence(memberidp)=true)
    THEN 
		INSERT IGNORE INTO loanckr.bills (customerId,memberId,connectionType,merchant,isAutoPayment,createdOn,updatedOn)
		VALUES (@customerIdp,memberIdp,@merchantp,@merchantp,1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);    
	END IF;
	
COMMIT;
END $$
DELIMITER ;

