DELIMITER $$
USE `clever`$$
DROP PROCEDURE IF EXISTS `GetActiveCourseList`$$
CREATE PROCEDURE GetActiveCourseList(in pageNth int)
BEGIN
	declare o int default 0;
    set o = 12*(pageNth-1);
	if (pageNth < 1) then set pageNth = 1; end if;
    select * from courses join accounts join co_ac join subjects where courses_status = 'active' and course_subject = subject_id and course_id = co_ac_course and co_ac_account = account_id and co_ac_role = 'teacher' limit o,12;
END;$$
DELIMITER ;

ALTER TABLE lessons
ADD COLUMN lesson_week int(11);
