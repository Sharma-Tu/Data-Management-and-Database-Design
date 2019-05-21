# Create Account
USE loanckr;
DROP PROCEDURE IF EXISTS loanckr.SP_maketransaction;
DELIMITER $$
CREATE PROCEDURE loanckr.SP_maketransaction(IN memberidp VARCHAR(255), IN amountp decimal(10,2), IN merchantp VARCHAR(60), IN trxnSuccessp VARCHAR(10))
BEGIN
	DECLARE merchantfees decimal(10,2);
    DECLARE trxnidp VARCHAR(60);
    DECLARE bankrefidp VARCHAR(60);
    DECLARE txnStatus boolean;
    
    SET @trxnidp = CONCAT(F_randNum(3),F_randChar(3),F_randNum(1),F_randChar(2),F_randNum(1),F_randChar(1));
    SET @merchantfees  = ROUND(0.03*amountp,2);
    SET @bankrefidp = CONCAT(F_randNum(1), F_randChar(3), F_randNum(2),F_randChar(1),'_bankref');
	SET @txnStatus = IF(trxnSuccessp = 'Accept', true, false);
    
    IF(amountp <= (SELECT creditbalance FROM loanckr.accountUser WHERE memberid = memberidp))
		THEN
			INSERT IGNORE INTO loanckr.transactions (trxnId,memberid, trxnSuccess,amount,merchant,merchantfees,bank_refId,createdOn,updatedOn)
            VALUES (@trxnidp,memberidp,@txnStatus,amountp,merchantp,@merchantfees,@bankrefidp,CURRENT_TIMESTAMP(),CURRENT_TIMESTAMP());
	END IF;
END $$
DELIMITER ;

CALL loanckr.SP_maketransaction('tushar@ck1.com',200.67,'AMAZON','Accept');
select * from loanckr.transactions ORDER BY createdOn DESC;