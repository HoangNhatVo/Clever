-- MySQL dump 10.13  Distrib 5.7.27, for Linux (x86_64)
--
-- Host: localhost    Database: elearningv1
-- ------------------------------------------------------
-- Server version	5.7.27-0ubuntu0.18.04.1

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts`
--

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
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
  `assignment_id` int(11) NOT NULL,
  `question_id` int(11) NOT NULL,
  `point` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`assignment_id`,`question_id`),
  KEY `fk_as_qu_2_idx` (`question_id`),
  CONSTRAINT `fk_as_qu_1` FOREIGN KEY (`assignment_id`) REFERENCES `assignments` (`assignment_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_as_qu_2` FOREIGN KEY (`question_id`) REFERENCES `questions` (`question_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
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
  `account_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `co_ac_role` varchar(10) NOT NULL DEFAULT 'student',
  PRIMARY KEY (`account_id`,`course_id`),
  KEY `fk_co_ac_2_idx` (`course_id`),
  CONSTRAINT `fk_co_ac_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`account_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_co_ac_2` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `co_ac`
--

LOCK TABLES `co_ac` WRITE;
/*!40000 ALTER TABLE `co_ac` DISABLE KEYS */;
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
  PRIMARY KEY (`course_id`),
  KEY `fk_courses_1_idx` (`course_subject`),
  CONSTRAINT `fk_courses_1` FOREIGN KEY (`course_subject`) REFERENCES `subjects` (`subject_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses`
--

LOCK TABLES `courses` WRITE;
/*!40000 ALTER TABLE `courses` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subjects`
--

LOCK TABLES `subjects` WRITE;
/*!40000 ALTER TABLE `subjects` DISABLE KEYS */;
/*!40000 ALTER TABLE `subjects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transactions` (
  `transaction_id` int(11) NOT NULL,
  `transaction_account` int(11) NOT NULL,
  `transaction_type` varchar(45) NOT NULL DEFAULT 'bank',
  `transaction_description` varchar(45) DEFAULT NULL,
  `transaction_amount` varchar(45) NOT NULL DEFAULT '0',
  PRIMARY KEY (`transaction_id`),
  KEY `fk_transactions_1_idx` (`transaction_account`),
  CONSTRAINT `fk_transactions_1` FOREIGN KEY (`transaction_account`) REFERENCES `accounts` (`account_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
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

-- Dump completed on 2019-11-10  8:53:07
