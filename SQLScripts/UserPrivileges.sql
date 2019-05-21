#User Priveleges

###### WEBAPP USER FOR INSERT, SELECT AND UPDATE (DELETE NOT PROVIDED) #####
DROP USER IF EXISTS 'webapp'@'localhost';
CREATE USER 'webapp'@'localhost' IDENTIFIED BY '1413';

SELECT * FROM mysql.user;

REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'webapp'@'localhost';

GRANT 	INSERT, 
		UPDATE, 
        SELECT,
        EXECUTE
ON *.* 
TO 'webapp'@'localhost';

SHOW GRANTS FOR 'webapp'@'localhost';


###### Account Team USER FOR Only View #####
DROP USER IF EXISTS 'account'@'localhost';
CREATE USER 'account'@'localhost' IDENTIFIED BY '1413';

SELECT * FROM mysql.user;

REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'account'@'localhost';

GRANT SELECT
ON loanckr.accountsTeamView 
TO 'account'@'localhost';

SHOW GRANTS FOR 'account'@'localhost';