DELIMITER $$
USE `sql12313586`$$
CREATE PROCEDURE GetAccountByUsername(in username varchar(45))
BEGIN
	select * from accounts where account_username COLLATE utf8mb4_unicode_ci = username;
END;$$
DELIMITER ;

DELIMITER $$
USE `sql12313586`$$
CREATE PROCEDURE GetAccountByEmail(in email varchar(45))
BEGIN
	select * from accounts where account_email COLLATE utf8mb4_unicode_ci = email;
END;$$
DELIMITER ;

DELIMITER $$
USE `sql12313586`$$

CREATE PROCEDURE GetAccountByPhone(in phone varchar(10))
BEGIN
	select * from accounts where account_phone COLLATE utf8mb4_unicode_ci = phone;
END;$$
DELIMITER ;

DELIMITER $$
USE `sql12313586`$$
CREATE PROCEDURE UpdatePasswordAccountByID(in ID int(11), in newPass varchar(72))
BEGIN
	update accounts a
    set a.account_password = newPass
    where a.account_id = ID;
END;$$
DELIMITER ;

DELIMITER $$
USE `sql12313586`$$
CREATE PROCEDURE GetAccountByID(in ID int(11))
BEGIN
	select * from accounts where account_status COLLATE utf8mb4_unicode_ci = 'active' and account_id = ID;
END;$$
DELIMITER ;