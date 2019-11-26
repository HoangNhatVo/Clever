----"CREATE" PROCEDURES
DELIMITER $$
USE `clever`$$
CREATE PROCEDURE AddAccount(in role varchar(10), in email varchar(45), 
							in phone varchar(10),in username varchar(45), in password varchar(72)
                            ,in first_name varchar(45),in last_name varchar(45),in address varchar(45),
                            in birthdate varchar(45))
BEGIN
	insert into accounts values (null, 'active', role, email, phone, username, password, first_name, 
								last_name, address, birthdate);
END;$$
DELIMITER ;
#--VD Khi mình gọi trên project: call AddAccount('a1','a2','a3','a4','a5','a6','a7','a8','a9')

DELIMITER $$
USE `clever`$$
CREATE PROCEDURE AddAnswer(in question int(11), in content varchar(256), in correct tinyint(4))
BEGIN
	insert into answers values (null, question, content, correct);
END;$$
DELIMITER ;
#--VD call AddAnswer(1,'abc',1)

DELIMITER $$
USE `clever`$$
CREATE PROCEDURE AddAS_QU(in assignmentID int(11), in questionID int(11), in point int(11))
BEGIN
	insert into as_qu values (assignmentID, questionID, point);
END;$$
DELIMITER ;
#--VD call AddAS_QU(1,1,1)


DELIMITER $$
USE `clever`$$
CREATE PROCEDURE AddAssignment(in type varchar(11), in lession int(11), in timeout int(11),in author int(11))
BEGIN
	insert into assignments values (null, type, lession, timeout, author);
END;$$
DELIMITER ;
#--VD call AddAssignment('abc',1,1,1)

DELIMITER $$
USE `clever`$$
CREATE PROCEDURE AddCO_AC(in accountID int(11), in courseID int(11), in role varchar(10))
BEGIN
	insert into co_ac values (accountID, courseID, role);
END;$$
DELIMITER ;
#--VD call AddCO_AC(1,1,'abc')

DELIMITER $$
USE `clever`$$
CREATE PROCEDURE AddCourse(in name varchar(68),in subject int(11),in start_date date, in end_date date,
							in price bigint(8), in description varchar(45))
BEGIN
	insert into courses values (null, 'active', name, subject, start_date, end_date, price, description);
END;$$
DELIMITER ;
#--VD call AddCourse(..................)

DELIMITER $$
USE `clever`$$
CREATE PROCEDURE AddLesson(in course int(11),in title varchar(100), in content tinytext)
BEGIN
	insert into lessons values (null, 'active', course, title, content);
END;$$
DELIMITER ;
#--VD call AddLesson(..................)


DELIMITER $$
USE `clever`$$
CREATE PROCEDURE AddQuestion(in type varchar(6), in content varchar(256), in author int(11))
BEGIN
	insert into questions values (null, 'active', type, content, author);
END;$$
DELIMITER ;
#--VD call AddQuestion(..................)

DELIMITER $$
USE `clever`$$
CREATE PROCEDURE AddResource(in name varchar(255), in url varchar(45), in type varchar(10), in lesson int(11))
BEGIN
	insert into resources values (null, name, url, type, lesson);
END;$$
DELIMITER ;
#--VD call AddResource(..................)


DELIMITER $$
USE `clever`$$
CREATE PROCEDURE AddStudent_Answer(in id int(11), in account int(11), in answer int(11), in assignment int(11))
BEGIN
	insert into student_answers values (id, account, answer, assignment);
END;$$
DELIMITER ;
#--VD call AddStudent_Answer(..................)


DELIMITER $$
USE `clever`$$
CREATE PROCEDURE AddSubject(in grade int(11), in name varchar(100))
BEGIN
	insert into subjects values (null, 'active', grade, name);
END;$$
DELIMITER ;
#---VD call AddSubject(..................)

DELIMITER $$
USE `clever`$$
CREATE PROCEDURE AddTransaction(in accountID int(11), in type varchar(45), in amount int(11))
BEGIN
	insert into transactions values (null, accountID, type, '', amount);
END;$$
DELIMITER ;

#---DELIMITER $$
#---USE `clever`$$
#---CREATE PROCEDURE AddTransaction(in id int(11), in account int(11), in type varchar(45), 
#-								in description varchar(45), in amount varchar(45))
#--BEGIN
#--	insert into transactions values (id, account, type, description, amount);
#-- END;$$
#--DELIMITER ;
# VD call AddTransaction(..................)
