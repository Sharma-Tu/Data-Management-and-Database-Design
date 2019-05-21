# Create Account
USE loanckr;
DROP PROCEDURE IF EXISTS loanckr.SP_useraccount;
DELIMITER $$
CREATE PROCEDURE loanckr.SP_useraccount (IN memberidp VARCHAR(255), IN income decimal(10,2), IN addressStreetp VARCHAR (255), IN addressExtrap VARCHAR(255), IN zipCodep VARCHAR(5), IN cityp VARCHAR(60), IN statep VARCHAR(60))
BEGIN
		DECLARE incomeGroupp INT;
		DECLARE creditScorep SMALLINT(4);
		DECLARE credit_amt decimal(10,2);
         
		SET incomeGroupp = F_randNum(1);
        SET creditScorep = F_randNum(3);
        SET creditScorep = CASE WHEN creditScorep< 100 THEN creditScorep+100
								ELSE creditScorep END;

        SET incomeGroupp = CASE WHEN income BETWEEN 0 AND 50000 THEN 1
								WHEN income BETWEEN 50000 AND 75000 THEN 2
                                WHEN income BETWEEN 75000 AND 100000 THEN 3
                                WHEN income > 100000 THEN 4
                               ELSE 0 END;
        
        	IF creditScorep < 300 then
				SET credit_amt = 1000;
			 ELSEIF creditScorep BETWEEN 300 AND 500 then
				SET credit_amt = 2000;
			 ELSEIF creditScorep BETWEEN 500 AND 700 then
				SET credit_amt = 4000;
			 ELSEIF creditScorep BETWEEN 700 AND 900 then
				SET credit_amt = 5000;
			 ELSE
				SET credit_amt = 10000;
			 END IF;

        IF (F_checkExistence(memberIdp) = true)
			THEN
				INSERT IGNORE INTO loanckr.accountUser(memberId , incomeGroup, addressStreet, addressExtra, city, state, zipCode, creditScore, creditBalance, createdOn, updatedOn)
                VALUES (memberidp, incomeGroupp, addressStreetp, addressExtrap,  cityp, statep, zipCodep, creditscorep, credit_amt, CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP())
                ON DUPLICATE KEY UPDATE incomeGroup = incomeGroupp,
										addressStreet = addressStreetp,
                                        addressExtra = addressExtrap,
                                        city = cityp,
                                        state = statep,
                                        creditscore = creditscorep,
                                        updatedOn = CURRENT_TIMESTAMP;
        END IF;
END$$
DELIMITER ;

SELECT * FROM loanckr.accountUser ORDER BY createdOn DESC;