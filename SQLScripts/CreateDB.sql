DROP DATABASE IF EXISTS loanckr;
CREATE DATABASE IF NOT EXISTS loanckr;

USE loanCkr;

#Step 1 is to install app/open the webpage and record relevant data

DROP TABLE IF EXISTS appInstall;
CREATE TABLE IF NOT EXISTS appInstall(
deviceid VARCHAR(255) NOT NULL,
ipaddress VARCHAR(60) NOT NULL,
appstore VARCHAR(20),
deviceName VARCHAR(40),
deviceVersion VARCHAR(40),
geotag_lat FLOAT(10,6),
geotag_long FLOAT(10,6),
createdOn DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
updatedOn DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
PRIMARY KEY(deviceid),
INDEX(createdOn),
INDEX(updatedOn)
)ENGINE=InnoDB;

#Step 2 is to record user signup instance
DROP TABLE IF EXISTS signupInfo;
CREATE TABLE IF NOT EXISTS signupinfo(
memberid VARCHAR(255) NOT NULL,
deviceid VARCHAR(255) NOT NULL,
fName VARCHAR(60),
lName VARCHAR(60),
email1 VARCHAR(255),
email2 VARCHAR(255),
cellnumber BIGINT NOT NULL,
ssn BIGINT NOT NULL,
age INT NOT NULL,
passkey VARCHAR(60) NOT NULL DEFAULT '0000',
isAgreementSigned BOOLEAN NOT NULL DEFAULT false,
activeStatus BOOLEAN NOT NULL DEFAULT false, 
signupSuccess BOOLEAN,
createdOn DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
updatedOn DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
PRIMARY KEY(memberid),
CONSTRAINT `fk_signupinfo_appinstall` FOREIGN KEY(deviceid) REFERENCES appInstall (deviceid),
INDEX(createdOn),
INDEX(updatedOn)
)ENGINE=InnoDB;

DROP TABLE IF EXISTS accountUser;
CREATE TABLE IF NOT EXISTS accountUser(
memberId VARCHAR(255) NOT NULL,
incomeGroup TINYINT(1) NOT NULL DEFAULT 0,
addressStreet VARCHAR(100) NOT NULL,
addressExtra VARCHAR(100),
city VARCHAR(60) NOT NULL,
state VARCHAR(60) NOT NULL,
zipCode BIGINT NOT NULL,
creditScore SMALLINT(4) NOT NULL DEFAULT 0,
creditBalance DECIMAL(10,2) NOT NULL DEFAULT 0,
createdOn DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
updatedOn DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
PRIMARY KEY(memberId),
CONSTRAINT `fk_demographics_signupinfo` FOREIGN KEY(memberId) REFERENCES signupinfo (memberId),
INDEX(createdOn),
INDEX(updatedOn)
)ENGINE=InnoDB;

#Step 3 is to record user login instances
DROP TABLE IF EXISTS loginInstances;
CREATE TABLE IF NOT EXISTS loginInstances(
loginId VARCHAR(60) NOT NULL,
memberId VARCHAR(255) NOT NULL,
loginSuccess tinyint,
createdOn DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
updatedOn DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
PRIMARY KEY(loginId),
CONSTRAINT `fk_loginInstances_signupinfo` FOREIGN KEY(memberId) REFERENCES signupinfo (memberId),
INDEX(createdOn),
INDEX(updatedOn)
)ENGINE=InnoDB;


#Step 4 is to record user Transactions
DROP TABLE IF EXISTS transactions;
CREATE TABLE IF NOT EXISTS transactions(
trxnId VARCHAR(60) NOT NULL,
memberid VARCHAR(255) NOT NULL,
trxnSuccess tinyint NOT NULL DEFAULT false,
amount decimal(10,2) NOT NULL CHECK(amount> 0),
merchant VARCHAR(60),
merchantfees decimal(10,2) NOT NULL CHECK(amount> 0),
bank_refId VARCHAR(60) NOT NULL,
customerId VARCHAR(60) NOT NULL DEFAULT 'noBill',
createdOn DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
updatedOn DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
PRIMARY KEY(trxnId),
CONSTRAINT `fk_transactions_signupinfo` FOREIGN KEY(memberid) REFERENCES signupInfo (memberid),
INDEX(createdOn),
INDEX(updatedOn)
)ENGINE=InnoDB;

#Step 4 is to get utility/subscriptions connection info
DROP TABLE IF EXISTS bills;
CREATE TABLE IF NOT EXISTS bills(
customerId VARCHAR(60) NOT NULL,
memberId VARCHAR(255) NOT NULL,
connectionType VARCHAR(60) NOT NULL,
merchant VARCHAR(60) NOT NULL,
isAutoPayment tinyint NOT NULL DEFAULT false, #loginid as autopayment
createdOn DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
updatedOn DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
PRIMARY KEY(customerId),
INDEX(createdOn),
INDEX(updatedOn)
)ENGINE=InnoDB;


DROP TABLE IF EXISTS merchants;
CREATE TABLE IF NOT EXISTS merchants(
merchantId int(50) NOT NULL,
merchant VARCHAR(255) NOT NULL,
PRIMARY KEY(merchantId)
)ENGINE=InnoDB;

#INSERT INTO merchants(merchantId, merchant) VALUES 
#													(0,'amazon'),
#													(1,'bestbuy'),
#                                                    (2,'costco'),
#                                                    (3,'ikea'),
#                                                    (4,'dominos'),
#                                                    (5,'papajohns'),
#                                                    (6,'stopnshop'),
#                                                    (7,'target'),
#                                                    (8,'wholefoods'),
#                                                    (9,'walmart');
#(10,'Electricity'),
#(11,'Gas'),
#(12,'Heat'),
#(13,'Water'),
#(14,'Parking'),
#(15,'Water'),
#(16,'Gas'),
#(17,'Parking'),
#(18,'Electricity'),
#(19,'Heat');