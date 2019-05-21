DROP procedure if exists loanckr.SP_creditw;
DELIMITER $$
CREATE PROCEDURE loanckr.SP_creditw(IN memberidp VARCHAR(255), OUT cramt INT)
BEGIN
    DECLARE walletId VARCHAR(50);
    # declare membid VARCHAR(255);
    DECLARE creditScorep smallint(4);
    DECLARE credit_amt decimal(10,2);

    IF (EXISTS(SELECT memberid FROM loanckr.accountUser WHERE memberid = memberidp)= true)
		THEN SELECT creditScore FROM loanckr.accountUser  WHERE memberid = memberidp INTO creditScorep;		
	END IF;
    
        
	IF creditScorep < 300 then
				SET credit_amt = 1000;
			 ELSEIF credit_score BETWEEN 300 AND 500 then
				SET credit_amt = 2000;
			 ELSEIF credit_score BETWEEN 500 AND 700 then
				SET credit_amt = 4000;
			 ELSEIF credit_score BETWEEN 700 AND 900 then
				SET credit_amt = 5000;
			 ELSE
				SET credit_amt = 10000;
			 END IF;
		
    SET cramt=credit_amt ;
	
    INSERT INTO loanckr.creditwallet(walletId,creditscore,memberid,credit_amount) values (@walletId,credit_score,@memberidp,credit_amt);

end  $$
DELIMITER ;