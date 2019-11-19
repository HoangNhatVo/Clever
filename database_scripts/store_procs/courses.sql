--"READ - GET" PROCEDURES
DELIMITER $$
USE `elearningv1`$$
CREATE PROCEDURE GetListCourse(in limit_num int, in offset_num int)
BEGIN
	SELECT * FROM courses WHERE status = 'active' LIMIT limit_num OFFSET offset_num; 
END;$$

DELIMITER ;
