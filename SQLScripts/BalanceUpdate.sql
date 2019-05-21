## TRIGGER TO UPDATE CREDIT WALLET BALANCE AFTER EVERY TRANSACTION
USE loanckr;
DROP TRIGGER IF EXISTS loanckr.T_updateCreditBalance;
DELIMITER $$
CREATE TRIGGER loanckr.T_updateCreditBalance
AFTER INSERT
ON loanckr.transactions FOR EACH ROW
BEGIN 
	IF (NEW.trxnSuccess= 1)
	THEN 
		UPDATE accountUser A
        SET A.creditBalance= A.creditBalance-NEW.amount
        WHERE A.memberid = NEW.memberid;
END IF;
END $$
DELIMITER ;