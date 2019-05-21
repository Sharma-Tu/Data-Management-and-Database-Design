#Signup Procedure

USE loanckr;
DROP PROCEDURE IF EXISTS loanckr.SP_signupInfo;
DELIMITER $$
CREATE PROCEDURE loanckr.SP_signupInfo (IN fNamep varchar(60), IN lNamep varchar(60), IN cellNumberp BIGINT, IN ssnp BIGINT, IN memberidp VARCHAR(255),IN passwordp1 VARCHAR(60), IN agep int, IN deviceidp VARCHAR(255), OUT errmsg VARCHAR(255))
MODIFIES SQL DATA
BEGIN
	DECLARE inputdata int;
    
    SET @inputdata = 0;
    
    #error handling
    SELECT CASE WHEN LENGTH(cellnumberp) <> 10 THEN 1
         WHEN LENGTH(ssnp) <> 9 THEN 2
         WHEN LENGTH(memberidp) = 0 THEN 3
         WHEN LENGTH(passwordp1) < 3 THEN 4
         WHEN F_checkExistence(memberidp) = true THEN 5
         ELSE 0 END INTO @inputdata;
	
	IF @inputdata = 0
    THEN
		INSERT IGNORE INTO loanckr.signupInfo(memberid,deviceid,fName,lName,email1,email2,cellnumber,ssn,age,passkey,isAgreementSigned,activeStatus,signupSuccess,createdOn,updatedOn)
		VALUES (memberidp,deviceidp,fNamep,lNamep,'','',cellNumberp,ssnp,agep,passwordp1,true,true,true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
		#ON DUPLICATE KEY UPDATE ;
		SET errmsg  = '';
    ELSEIF @inputdata = 1
    THEN
		SET errmsg = 'Cellnumber needs to be 10 digit number';
    ELSEIF @inputdata = 2
    THEN
		SET errmsg = 'SSN needs to be 9 digit number';
	ELSEIF @inputdata = 3
    THEN
		SET errmsg = 'Email cannot be empty';
	ELSEIF @inputdata = 4
    THEN
		SET errmsg = 'Password should be more than 3 characters';
	ELSEIF @inputdata = 5
    THEN
		SET errmsg = 'This user already exists. Use a different email.';
	END IF;
COMMIT;
END$$
DELIMITER ;

SELECT * FROM signupInfo ORDER BY createdOn DESC;