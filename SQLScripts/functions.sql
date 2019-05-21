#FUNCTIONS
USE loanckr;
DROP FUNCTION IF EXISTS F_randChar;
DROP FUNCTION IF EXISTS F_randNum;
#######################		RANDOM string		############################
DELIMITER $$
CREATE FUNCTION F_randChar(len int)
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
	DECLARE randChar VARCHAR(255);
    SET randChar = substring('abcdefghijklmnopqrstuvwxyz',FLOOR(RAND()*26.5),1);
	WHILE (LENGTH(randChar) < len) DO
		SET randChar = CONCAT(randChar, substring('abcdefghijklmnopqrstuvwxyz',FLOOR(RAND()*26.5),1));
	END WHILE;
	RETURN randChar;
END$$

#######################		RANDOM num			############################

DELIMITER $$
CREATE FUNCTION F_randNum(len int)
RETURNS int
DETERMINISTIC
BEGIN
	DECLARE randNum VARCHAR(255);
    SET randNum = substring('0123456789',FLOOR(RAND()*10.5),1);
	WHILE (LENGTH(randNum) < len) DO
		SET randNum= CONCAT(randNum, substring('0123456789',FLOOR(RAND()*10.5),1));
	END WHILE;
	RETURN CAST(randNum AS UNSIGNED);
END$$

#######################		CHECK USER EXISTENCE			############################

DELIMITER $$

CREATE FUNCTION F_checkExistence(memberidp VARCHAR(255))
RETURNS int
DETERMINISTIC
BEGIN
	DECLARE userExists boolean;
    SET userExists = IF(EXISTS(SELECT memberid FROM loanckr.signupInfo WHERE memberid = memberidp AND activeStatus = true), true, false);
	RETURN userExists;
END$$

