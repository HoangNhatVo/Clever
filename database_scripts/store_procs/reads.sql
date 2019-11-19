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
