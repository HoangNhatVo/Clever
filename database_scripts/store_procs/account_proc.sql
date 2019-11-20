DELIMITER $$
USE `sql12311454`$$
CREATE PROCEDURE GetAccountByUsername(in username varchar(45))
BEGIN
	select * from accounts where account_username COLLATE utf8mb4_unicode_ci = username;
END;$$
DELIMITER ;

DELIMITER $$
USE `sql12311454`$$
CREATE PROCEDURE GetAccountByEmail(in email varchar(45))
BEGIN
	select * from accounts where account_email COLLATE utf8mb4_unicode_ci = email;
END;$$
DELIMITER ;

DELIMITER $$
USE `sql12311454`$$
CREATE PROCEDURE GetAccountByPhone(in phone varchar(10))
BEGIN
	select * from accounts where account_phone COLLATE utf8mb4_unicode_ci = phone;
END;$$
DELIMITER ;
