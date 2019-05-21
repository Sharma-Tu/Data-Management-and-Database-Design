#Views
####### Transactions and Users View for Accounts Team
DROP VIEW IF EXISTS loanckr.accountsTeamView;
CREATE VIEW loanckr.accountsTeamView
AS 
	SELECT 	A.*, 
			B.creditScore, 
            B.creditBalance 
    FROM loanckr.transactions A 
	JOIN  loanckr.accountUser B 
	ON A.memberid = B.memberid;

SELECT  * 
FROM loanckr.accountsTeamView;

