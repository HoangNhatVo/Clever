-- MySQL dump 10.13  Distrib 5.7.28, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: clever
-- ------------------------------------------------------
-- Server version	5.7.28-0ubuntu0.18.04.4

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accounts` (
  `account_id` int(11) NOT NULL AUTO_INCREMENT,
  `account_status` varchar(15) NOT NULL DEFAULT 'active',
  `account_role` varchar(10) NOT NULL,
  `account_email` varchar(45) NOT NULL,
  `account_phone` varchar(10) NOT NULL,
  `account_username` varchar(45) NOT NULL,
  `account_password` varchar(72) NOT NULL,
  `account_first_name` varchar(45) DEFAULT NULL,
  `account_last_name` varchar(45) DEFAULT NULL,
  `account_address` varchar(45) DEFAULT NULL,
  `account_birthdate` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`account_id`),
  UNIQUE KEY `account_username_UNIQUE` (`account_username`),
  UNIQUE KEY `account_email_UNIQUE` (`account_email`),
  UNIQUE KEY `account_phone_UNIQUE` (`account_phone`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts`
--

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
INSERT INTO `accounts` VALUES (1,'active','admin','admin@clever.com','123456789','admin','$2y$10$ta.iMT0h.gQBA/lwMmkSX.rcULE7Nmwyi/5YHubTI2niz5dI57SLa','admin','admin','adminAddr','1998-01-01'),(2,'active','teacher','teacherkhanhhuy@clever.com','0131556464','teacherkhanhhuy','$2y$10$ta.iMT0h.gQBA/lwMmkSX.rcULE7Nmwyi/5YHubTI2niz5dI57SLa','Huy','Khánh','pfiijewfj','1988-02-01'),(3,'active','teacher','teacherngohoang','0654654654','teacherngohoang','$2y$10$ta.iMT0h.gQBA/lwMmkSX.rcULE7Nmwyi/5YHubTI2niz5dI57SLa','Hoàng','Ngô','ewkfhufeo','1978-08-09'),(4,'active','teacher','teachvandoan','0148465454','teachervandoan','$2y$10$ta.iMT0h.gQBA/lwMmkSX.rcULE7Nmwyi/5YHubTI2niz5dI57SLa','Vân','Đoàn','dgjherghwuihiu','1989-01-09'),(5,'active','teacher','teachervanphong','0148566422','teachervanphong','$2y$10$ta.iMT0h.gQBA/lwMmkSX.rcULE7Nmwyi/5YHubTI2niz5dI57SLa','Văn','Phòng','dewhuweiughwueigh','1993-12-31'),(6,'active','teacher','teacherthiphan','0145798733','teacherthiphan','$2y$10$ta.iMT0h.gQBA/lwMmkSX.rcULE7Nmwyi/5YHubTI2niz5dI57SLa','Phấn','Thị','gewuheiuewhgiuhg','1990-01-09'),(7,'active','teacher','teacherte','0165468877','teacherte','$2y$10$ta.iMT0h.gQBA/lwMmkSX.rcULE7Nmwyi/5YHubTI2niz5dI57SLa','Tê','Tê','wuheguihghghgh','1990-01-09'),(8,'active','student','nguyenvietnam','0132132144','vietnamnguyen','$2y$10$ta.iMT0h.gQBA/lwMmkSX.rcULE7Nmwyi/5YHubTI2niz5dI57SLa','Nam','Nguyễn','oihweoghewguh','2002-08-07');
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `answers`
--

DROP TABLE IF EXISTS `answers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `answers` (
  `answer_id` int(11) NOT NULL AUTO_INCREMENT,
  `answer_question` int(11) NOT NULL,
  `answer_content` varchar(256) NOT NULL,
  `answer_correct` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`answer_id`),
  KEY `fk_answers_1_idx` (`answer_question`),
  CONSTRAINT `fk_answers_1` FOREIGN KEY (`answer_question`) REFERENCES `questions` (`question_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `answers`
--

LOCK TABLES `answers` WRITE;
/*!40000 ALTER TABLE `answers` DISABLE KEYS */;
/*!40000 ALTER TABLE `answers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `as_qu`
--

DROP TABLE IF EXISTS `as_qu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `as_qu` (
  `as_qu_assignment` int(11) NOT NULL,
  `as_qu_question` int(11) NOT NULL,
  `point` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`as_qu_assignment`,`as_qu_question`),
  KEY `fk_as_qu_2_idx` (`as_qu_question`),
  CONSTRAINT `fk_as_qu_1` FOREIGN KEY (`as_qu_assignment`) REFERENCES `assignments` (`assignment_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_as_qu_2` FOREIGN KEY (`as_qu_question`) REFERENCES `questions` (`question_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `as_qu`
--

LOCK TABLES `as_qu` WRITE;
/*!40000 ALTER TABLE `as_qu` DISABLE KEYS */;
/*!40000 ALTER TABLE `as_qu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assignments`
--

DROP TABLE IF EXISTS `assignments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assignments` (
  `assignment_id` int(11) NOT NULL AUTO_INCREMENT,
  `assignment_type` varchar(11) NOT NULL DEFAULT 'test',
  `assignment_lesson` int(11) DEFAULT NULL,
  `assignment_timeout` int(11) NOT NULL DEFAULT '-1',
  `assignment_author` int(11) NOT NULL,
  PRIMARY KEY (`assignment_id`),
  KEY `fk_assignments_1_idx` (`assignment_lesson`),
  KEY `fk_assignments_2_idx` (`assignment_author`),
  CONSTRAINT `fk_assignments_1` FOREIGN KEY (`assignment_lesson`) REFERENCES `lessons` (`lesson_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_assignments_2` FOREIGN KEY (`assignment_author`) REFERENCES `accounts` (`account_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assignments`
--

LOCK TABLES `assignments` WRITE;
/*!40000 ALTER TABLE `assignments` DISABLE KEYS */;
/*!40000 ALTER TABLE `assignments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `co_ac`
--

DROP TABLE IF EXISTS `co_ac`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `co_ac` (
  `co_ac_account` int(11) NOT NULL,
  `co_ac_course` int(11) NOT NULL,
  `co_ac_role` varchar(10) NOT NULL DEFAULT 'student',
  PRIMARY KEY (`co_ac_account`,`co_ac_course`),
  KEY `fk_co_ac_2_idx` (`co_ac_course`),
  CONSTRAINT `fk_co_ac_1` FOREIGN KEY (`co_ac_account`) REFERENCES `accounts` (`account_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_co_ac_2` FOREIGN KEY (`co_ac_course`) REFERENCES `courses` (`course_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `co_ac`
--

LOCK TABLES `co_ac` WRITE;
/*!40000 ALTER TABLE `co_ac` DISABLE KEYS */;
INSERT INTO `co_ac` VALUES (2,1,'teacher'),(3,2,'teacher'),(4,3,'teacher'),(4,4,'teacher'),(5,5,'teacher'),(8,1,'student'),(8,2,'student');
/*!40000 ALTER TABLE `co_ac` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses`
--

DROP TABLE IF EXISTS `courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courses` (
  `course_id` int(11) NOT NULL AUTO_INCREMENT,
  `courses_status` varchar(11) NOT NULL DEFAULT 'active',
  `course_name` varchar(68) NOT NULL,
  `course_subject` int(11) NOT NULL,
  `course_start_date` date NOT NULL,
  `course_end_date` date DEFAULT NULL,
  `course_price` bigint(8) NOT NULL DEFAULT '0',
  `course_description` varchar(45) DEFAULT NULL,
  `course_banner` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`course_id`),
  UNIQUE KEY `course_description_UNIQUE` (`course_description`),
  KEY `fk_courses_1_idx` (`course_subject`),
  CONSTRAINT `fk_courses_1` FOREIGN KEY (`course_subject`) REFERENCES `subjects` (`subject_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses`
--

LOCK TABLES `courses` WRITE;
/*!40000 ALTER TABLE `courses` DISABLE KEYS */;
INSERT INTO `courses` VALUES (1,'active','Luyện thi cấp tốc đại học hóa hữu cơ khối A',3,'2020-01-08','2020-05-08',399000,'jnegjwnejnweg','https://d3njjcbhbojbot.cloudfront.net/api/utilities/v1/imageproxy/https://s3.amazonaws.com/coursera_assets/growth_frontpage/banner.jpg'),(2,'active','Luyện thi cấp tốc Vật lý khối A và A1',2,'2020-01-08','2020-06-08',499000,'regjegoiuejgoieg','https://d3njjcbhbojbot.cloudfront.net/api/utilities/v1/imageproxy/https://s3.amazonaws.com/coursera_assets/growth_frontpage/banner.jpg'),(3,'active','Sinh học phổ thông 10',13,'2019-06-05','2019-11-05',349000,'whegghiuweewu','https://d3njjcbhbojbot.cloudfront.net/api/utilities/v1/imageproxy/https://s3.amazonaws.com/coursera_assets/growth_frontpage/banner.jpg'),(4,'active','Luyện thi sinh học khối B',1,'2020-07-01','2020-11-01',349000,'ergrogjgogiij','https://d3njjcbhbojbot.cloudfront.net/api/utilities/v1/imageproxy/https://s3.amazonaws.com/coursera_assets/growth_frontpage/banner.jpg'),(5,'active','Làm chủ hình học phổ thông 11',11,'2019-12-01','2019-04-01',569000,'jhiuhiu','https://d3njjcbhbojbot.cloudfront.net/api/utilities/v1/imageproxy/https://s3.amazonaws.com/coursera_assets/growth_frontpage/banner.jpg');
/*!40000 ALTER TABLE `courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lessons`
--

DROP TABLE IF EXISTS `lessons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lessons` (
  `lesson_id` int(11) NOT NULL AUTO_INCREMENT,
  `lesson_status` varchar(11) NOT NULL DEFAULT 'active',
  `lesson_course` int(11) NOT NULL,
  `lesson_title` varchar(100) DEFAULT NULL,
  `lesson_content` tinytext,
  PRIMARY KEY (`lesson_id`),
  KEY `fk_lessons_1_idx` (`lesson_course`),
  CONSTRAINT `fk_lessons_1` FOREIGN KEY (`lesson_course`) REFERENCES `courses` (`course_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lessons`
--

LOCK TABLES `lessons` WRITE;
/*!40000 ALTER TABLE `lessons` DISABLE KEYS */;
/*!40000 ALTER TABLE `lessons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questions`
--

DROP TABLE IF EXISTS `questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `questions` (
  `question_id` int(11) NOT NULL AUTO_INCREMENT,
  `question_status` varchar(11) NOT NULL DEFAULT 'active',
  `question_type` varchar(6) NOT NULL DEFAULT 'choice',
  `question_content` varchar(256) NOT NULL,
  `question_author` int(11) NOT NULL,
  PRIMARY KEY (`question_id`),
  KEY `fk_questions_1_idx` (`question_author`),
  CONSTRAINT `fk_questions_1` FOREIGN KEY (`question_author`) REFERENCES `accounts` (`account_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questions`
--

LOCK TABLES `questions` WRITE;
/*!40000 ALTER TABLE `questions` DISABLE KEYS */;
/*!40000 ALTER TABLE `questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resources`
--

DROP TABLE IF EXISTS `resources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resources` (
  `resource_id` int(11) NOT NULL AUTO_INCREMENT,
  `resource_name` varchar(255) NOT NULL,
  `resource_url` varchar(45) NOT NULL,
  `resource_type` varchar(10) DEFAULT 'video',
  `resource_lesson` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`resource_id`),
  KEY `fk_resources_1_idx` (`resource_lesson`),
  CONSTRAINT `fk_resources_1` FOREIGN KEY (`resource_lesson`) REFERENCES `lessons` (`lesson_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resources`
--

LOCK TABLES `resources` WRITE;
/*!40000 ALTER TABLE `resources` DISABLE KEYS */;
/*!40000 ALTER TABLE `resources` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_answers`
--

DROP TABLE IF EXISTS `student_answers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_answers` (
  `student_answer_id` int(11) NOT NULL,
  `student_answer_account` int(11) DEFAULT NULL,
  `student_answer_answer` int(11) DEFAULT NULL,
  `student_answer_assignment` int(11) DEFAULT NULL,
  PRIMARY KEY (`student_answer_id`),
  KEY `fk_student_answers_1_idx` (`student_answer_account`),
  KEY `fk_student_answers_2_idx` (`student_answer_answer`),
  KEY `fk_student_answers_3` (`student_answer_assignment`),
  CONSTRAINT `fk_student_answers_1` FOREIGN KEY (`student_answer_account`) REFERENCES `accounts` (`account_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_student_answers_2` FOREIGN KEY (`student_answer_answer`) REFERENCES `answers` (`answer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_student_answers_3` FOREIGN KEY (`student_answer_assignment`) REFERENCES `assignments` (`assignment_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_answers`
--

LOCK TABLES `student_answers` WRITE;
/*!40000 ALTER TABLE `student_answers` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_answers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subjects`
--

DROP TABLE IF EXISTS `subjects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subjects` (
  `subject_id` int(11) NOT NULL AUTO_INCREMENT,
  `subject_status` varchar(11) NOT NULL DEFAULT 'active',
  `subject_grade` int(11) DEFAULT NULL,
  `subject_name` varchar(100) NOT NULL,
  PRIMARY KEY (`subject_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subjects`
--

LOCK TABLES `subjects` WRITE;
/*!40000 ALTER TABLE `subjects` DISABLE KEYS */;
INSERT INTO `subjects` VALUES (1,'active',12,'Sinh học 12'),(2,'active',12,'Vật lý 12'),(3,'active',12,'Hóa học 12'),(4,'active',12,'Giải tích 12'),(5,'active',12,'Hình học 12'),(6,'active',11,'Sinh học 11'),(7,'active',11,'Vật lý 11'),(8,'active',11,'Hóa học 11'),(9,'active',11,'Đại số và giải tích 11'),(10,'active',11,'Hình học 11'),(11,'active',10,'Đại số 10'),(12,'active',10,'Hình học 10'),(13,'active',10,'Sinh học 10'),(14,'active',10,'Hóa học 10'),(15,'active',10,'Vật lý 10');
/*!40000 ALTER TABLE `subjects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transactions` (
  `transaction_id` int(11) NOT NULL AUTO_INCREMENT,
  `transaction_account` int(11) NOT NULL,
  `transaction_type` varchar(45) NOT NULL,
  `transaction_description` varchar(45) DEFAULT NULL,
  `transaction_amount` int(11) default null,
  PRIMARY KEY (`transaction_id`),
  KEY `fk_transactions_1_idx` (`transaction_account`),
  CONSTRAINT `fk_transactions_1` FOREIGN KEY (`transaction_account`) REFERENCES `accounts` (`account_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactions`
--

LOCK TABLES `transactions` WRITE;
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `transactions` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-11-20 21:57:11
