DELIMITER $$
USE `cleverdbbeta`$$
CREATE PROCEDURE GetCourseDetail(in courseId int)
BEGIN
	select * from courses where course_id = courseId and courses_status = 'active';
END;$$
DELIMITER ;