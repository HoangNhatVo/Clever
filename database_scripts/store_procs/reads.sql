DELIMITER $$
USE `clever`$$
CREATE PROCEDURE GetActiveCourseList(in pageNth int)
BEGIN
	declare l int default 12;
	if (pageNth < 1) then set pageNth = 1; end if;
    select * from courses join accounts join co_ac join subjects where courses_status = 'active' and course_subject = subject_id and course_id = co_ac_course and co_ac_account = account_id and co_ac_role = 'teacher';
END;$$
DELIMITER ;

DELIMITER $$
USE `clever`$$
CREATE PROCEDURE GetCourseDetail(in courseId int)
BEGIN
	select * from courses where course_id = courseId and courses_status = 'active';
END;$$
DELIMITER ;

DELIMITER $$
USE `clever`$$
CREATE PROCEDURE GetListSubject()
BEGIN
    select * from subjects where subject_status = 'active' ;
END;$$
DELIMITER ;

DELIMITER $$
USE `clever`$$
CREATE PROCEDURE GetActiveCourseListBySubject(in pageNth int, in subjectID int)
BEGIN
	declare l int default 12;
	if (pageNth < 1) then set pageNth = 1; end if;
    select * from courses join accounts join co_ac join subjects where courses_status = 'active' and course_subject = subject_id and course_id = co_ac_course and co_ac_account = account_id and co_ac_role = 'teacher' and subject_id = subjectID;
END;$$
DELIMITER ;

DELIMITER $$
USE `clever`$$
CREATE PROCEDURE GetSubjectByID(in subjectID int)
BEGIN
    select * from subjects where subject_status = 'active' and subject_id = subjectID;
END;$$
DELIMITER ;

DELIMITER $$
USE `clever`$$
CREATE DEFINER=`dev`@`localhost` PROCEDURE `GetAccountDetails`(in accountID int(11))
BEGIN
	select account_id,account_status,account_role,account_email,account_phone,account_username,account_first_name,account_last_name,account_address,account_birthdate, sum(transaction_amount) as 'balance' from accounts left join transactions on account_id = transaction_account group by account_id;
END$$

DELIMITER ;