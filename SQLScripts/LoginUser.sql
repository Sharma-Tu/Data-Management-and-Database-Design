USE loanckr;
DROP PROCEDURE IF EXISTS loanckr.SP_login;
DELIMITER $$
CREATE PROCEDURE loanckr.SP_login (IN memberidp VARCHAR(255), IN passkeyp VARCHAR(60), OUT phpmsg VARCHAR(60))
BEGIN
	DECLARE loginidp VARCHAR(10);
    DECLARE conditionCheck boolean DEFAULT false;
    SET loginidp = CONCAT(F_randNum(4),F_randChar(2),F_randNum(1),F_randChar(1),F_randNum(2));
    SET @conditionCheck = IF((SELECT passkey FROM loanckr.signupInfo WHERE memberid = memberidp) = passkeyp, true, false);
    IF(@conditionCheck  = true AND F_checkExistence(memberidp)=true)
		THEN 
			SET phpmsg = 'CKHome.php';
            INSERT IGNORE INTO loanckr.loginInstances(loginId, memberId, loginSuccess, createdOn, updatedOn)
            VALUES (loginidp, memberidp, true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
            
		ELSE
			SET phpmsg = IF(F_checkExistence(memberidp),'Wrong Password! Go back to','You were not found. Click on ');
	END IF;
END$$
DELIMITER ;

SELECT * FROM loanckr.loginInstances ORDER BY createdOn DESC;