USE loanckr;
DROP PROCEDURE IF EXISTS loanckr.SP_appInstall;
DELIMITER $$
CREATE PROCEDURE loanckr.SP_appInstall()
BEGIN
	DECLARE deviceid CHAR;
	DECLARE ipaddress CHAR;
	DECLARE appstore CHAR;
	DECLARE deviceName CHAR;
	DECLARE deviceVersion CHAR;
	DECLARE geotag_lat CHAR;
	DECLARE geotag_long CHAR;
	SET @deviceid = CONCAT(UPPER(F_randChar(10)), CAST(F_randNum(5) AS CHAR(5)), F_randChar(7));
	SET @ipaddress = CONCAT('1',F_randNum(2),'.',F_randNum(2),'.',F_randNum(1),'.',F_randNum(1));
	SET @appstore = ELT(CEIL((rand()*5)+0.1),'webapp','appstore','playstore','samsungapps','','');
	SET @deviceName = CASE WHEN @appstore = 'webapp' THEN ELT(CEIL((rand()*5)+0.1),'lenovo','samsung','apple','dell','','')
						WHEN @appstore = 'appstore' THEN 'apple'
						WHEN @appstore = 'playstore' THEN ELT(CEIL((rand()*5)+0.1),'google','samsung','lenovo','OnePlus','','')
						WHEN @appstore = 'samsungapps' THEN 'samsung'
						ELSE '' END;
	SET @deviceVersion = CONCAT(CAST(F_randNum(1) AS CHAR),'.',CAST(F_randNum(1) AS CHAR));
	SET @geotag_lat = F_randNum(2)+round(rand() * 0.99 + 0.01, 6);
	SET @geotag_long = F_randNum(2)+round(rand() * 0.99 + 0.01, 6);
    
    INSERT IGNORE INTO loanckr.appInstall (deviceid,ipaddress,appstore,deviceName,deviceVersion,geotag_lat,geotag_long,createdOn,updatedOn)
    VALUES (@deviceid,@ipaddress,@appstore,@deviceName,@deviceVersion,@geotag_lat,@geotag_long, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
    
COMMIT;
END $$
#IN deviceid VARCHAR(255), IN ipaddress VARCHAR(60), IN appstore VARCHAR(20), IN deviceName VARCHAR(40), IN deviceVersion VARCHAR(40), IN geotag_lat FLOAT(10,6), IN geotag_long FLOAT(10,6) 

#CALL loanckr.SP_appInstall();
SELECT * FROM appInstall ORDER BY createdOn DESC;