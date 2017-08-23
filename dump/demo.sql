# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.7.18)
# Database: hsspm_dev
# Generation Time: 2017-08-23 15:07:12 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table ar_internal_metadata
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ar_internal_metadata`;

CREATE TABLE `ar_internal_metadata` (
  `key` varchar(255) NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `ar_internal_metadata` WRITE;
/*!40000 ALTER TABLE `ar_internal_metadata` DISABLE KEYS */;

INSERT INTO `ar_internal_metadata` (`key`, `value`, `created_at`, `updated_at`)
VALUES
	('environment','development','2017-08-15 17:47:17','2017-08-15 17:47:17');

/*!40000 ALTER TABLE `ar_internal_metadata` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table carts
# ------------------------------------------------------------

DROP TABLE IF EXISTS `carts`;

CREATE TABLE `carts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `human_sample_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_carts_on_user_id` (`user_id`),
  KEY `index_carts_on_human_sample_id` (`human_sample_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `carts` WRITE;
/*!40000 ALTER TABLE `carts` DISABLE KEYS */;

INSERT INTO `carts` (`id`, `user_id`, `human_sample_id`, `created_at`, `updated_at`)
VALUES
	(1,2,1,'2017-08-15 20:53:00','2017-08-15 20:53:00'),
	(2,2,2,'2017-08-18 19:33:02','2017-08-18 19:33:02'),
	(3,2,3,'2017-08-18 19:33:05','2017-08-18 19:33:05');

/*!40000 ALTER TABLE `carts` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table clinic_files
# ------------------------------------------------------------

DROP TABLE IF EXISTS `clinic_files`;

CREATE TABLE `clinic_files` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `file` varchar(255) DEFAULT NULL,
  `note` text,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `clinic_files` WRITE;
/*!40000 ALTER TABLE `clinic_files` DISABLE KEYS */;

INSERT INTO `clinic_files` (`id`, `title`, `file`, `note`, `created_at`, `updated_at`)
VALUES
	(1,'SANS test result','Subject0001_year-1_SANS_test_score.xls','','2017-08-22 15:20:34','2017-08-22 15:20:34');

/*!40000 ALTER TABLE `clinic_files` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cohorts
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cohorts`;

CREATE TABLE `cohorts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `note` text,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `cohorts` WRITE;
/*!40000 ALTER TABLE `cohorts` DISABLE KEYS */;

INSERT INTO `cohorts` (`id`, `name`, `note`, `created_at`, `updated_at`)
VALUES
	(1,'cohortA','cohort example','2017-08-15 18:43:17','2017-08-15 18:43:17'),
	(2,'cohortB','cohort example','2017-08-15 18:43:31','2017-08-15 18:43:31');

/*!40000 ALTER TABLE `cohorts` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cohorts_humen
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cohorts_humen`;

CREATE TABLE `cohorts_humen` (
  `human_id` int(11) NOT NULL,
  `cohort_id` int(11) NOT NULL,
  KEY `index_cohorts_humen_on_human_id_and_cohort_id` (`human_id`,`cohort_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `cohorts_humen` WRITE;
/*!40000 ALTER TABLE `cohorts_humen` DISABLE KEYS */;

INSERT INTO `cohorts_humen` (`human_id`, `cohort_id`)
VALUES
	(1,1),
	(2,2),
	(3,1),
	(4,2),
	(5,1),
	(6,1);

/*!40000 ALTER TABLE `cohorts_humen` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table datasets
# ------------------------------------------------------------

DROP TABLE IF EXISTS `datasets`;

CREATE TABLE `datasets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `human_id` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `file` varchar(255) DEFAULT NULL,
  `availability` text,
  `contributors` text,
  `pi` varchar(255) DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_datasets_on_human_id` (`human_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `datasets` WRITE;
/*!40000 ALTER TABLE `datasets` DISABLE KEYS */;

INSERT INTO `datasets` (`id`, `human_id`, `title`, `file`, `availability`, `contributors`, `pi`, `note`, `created_at`, `updated_at`)
VALUES
	(1,1,'RNA-Seq data example','Subject0001_RNA-Seq_data.csv','online','Mary','Tom','','2017-08-15 20:27:51','2017-08-15 20:27:51'),
	(2,4,'MRI Image','MRI_image_example.jpg','online','Sarah','Tom','','2017-08-15 20:48:36','2017-08-15 20:48:36'),
	(3,4,'Chip-Seq raw data',NULL,'On external hard drive 0001, folder \"NGS/Chip-Seq/Subject0004\"','Mary','Tom','','2017-08-22 15:56:34','2017-08-22 15:56:34');

/*!40000 ALTER TABLE `datasets` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table datasets_projects
# ------------------------------------------------------------

DROP TABLE IF EXISTS `datasets_projects`;

CREATE TABLE `datasets_projects` (
  `dataset_id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  KEY `index_datasets_projects_on_dataset_id_and_project_id` (`dataset_id`,`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `datasets_projects` WRITE;
/*!40000 ALTER TABLE `datasets_projects` DISABLE KEYS */;

INSERT INTO `datasets_projects` (`dataset_id`, `project_id`)
VALUES
	(1,1),
	(2,2),
	(3,6);

/*!40000 ALTER TABLE `datasets_projects` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table demographies
# ------------------------------------------------------------

DROP TABLE IF EXISTS `demographies`;

CREATE TABLE `demographies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `human_id` int(11) DEFAULT NULL,
  `data` longtext,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_demographies_on_human_id` (`human_id`),
  CONSTRAINT `fk_rails_2825a7f9c7` FOREIGN KEY (`human_id`) REFERENCES `humen` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `demographies` WRITE;
/*!40000 ALTER TABLE `demographies` DISABLE KEYS */;

INSERT INTO `demographies` (`id`, `human_id`, `data`, `created_at`, `updated_at`)
VALUES
	(3,1,'height: 74 inches\r\nweight: 120 lbs','2017-08-17 17:59:21','2017-08-17 18:15:08'),
	(4,2,'Height: 68 inches\r\nWeight: 130 lbs\r\nEducation: 12 years\r\nHandedness: right\r\nPhysical condition: high blood pressure\r\nSmoking?: Yes\r\nPack per day: 2\r\nCurrent medication: none\r\nPast medication: Aspirin\r\nFamily History: Unknown\r\nReferral: Dr. XXX\r\nDate of diagnosis: 2017-XX-XX','2017-08-17 18:35:16','2017-08-17 18:36:53'),
	(5,4,'Height: 70 inches\r\nWeight: 150lbs\r\nHandedness: left\r\nSmoke?: No\r\nFamily History: Father, diabetes\r\nCurrent medication: none\r\nPast medication: none','2017-08-17 19:07:59','2017-08-17 19:07:59'),
	(6,7,'Height: 60 inches\r\nWeight: 180 lbs','2017-08-17 19:28:27','2017-08-17 19:28:27'),
	(7,5,'','2017-08-22 15:38:26','2017-08-22 15:38:26'),
	(8,6,'','2017-08-22 15:38:46','2017-08-22 15:38:46'),
	(9,3,'','2017-08-22 15:39:10','2017-08-22 15:39:10');

/*!40000 ALTER TABLE `demographies` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table events
# ------------------------------------------------------------

DROP TABLE IF EXISTS `events`;

CREATE TABLE `events` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `start` datetime DEFAULT NULL,
  `stop` datetime DEFAULT NULL,
  `place` varchar(255) DEFAULT NULL,
  `note` text,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `events` WRITE;
/*!40000 ALTER TABLE `events` DISABLE KEYS */;

INSERT INTO `events` (`id`, `title`, `start`, `stop`, `place`, `note`, `created_at`, `updated_at`)
VALUES
	(1,'Schedule biopsy with Subject0006 ','2017-09-16 10:00:00','2017-08-16 10:30:00','','2nd visit','2017-08-16 20:03:01','2017-08-17 14:43:31'),
	(2,'RA meeting','2017-10-10 12:00:00','2017-10-10 14:00:00','Building A, room XX','','2017-08-17 14:42:10','2017-08-17 14:42:10'),
	(3,'Monthly report due','2017-09-05 09:00:00','2017-09-05 09:10:00','','','2017-08-17 14:44:52','2017-08-17 14:44:52'),
	(4,'Contact new subject to get consent','2017-09-20 14:00:00','2017-09-20 14:20:00','','','2017-08-17 14:46:12','2017-08-17 14:46:12'),
	(5,'Reschedule MRI with Subject0004','2017-10-15 09:30:00','2017-08-15 10:00:00','','','2017-08-17 14:47:57','2017-08-17 14:47:57'),
	(6,'Monthly report due','2017-10-05 09:00:00','2017-10-05 09:10:00','','','2017-08-17 14:49:00','2017-08-17 14:49:00'),
	(7,'Group meeting','2017-09-29 16:00:00','2017-09-29 17:00:00','building A, room XX','Discuss new recruitment plan','2017-08-17 14:50:47','2017-08-17 14:50:47'),
	(8,'Call Subject0002','2017-10-26 13:00:00','2017-10-26 13:30:00','','follow up','2017-08-17 14:52:05','2017-08-17 14:52:05'),
	(9,'Update IRB Study CR000123','2017-08-15 11:00:00','2017-08-15 11:10:00','','','2017-08-17 15:43:16','2017-08-17 15:43:16');

/*!40000 ALTER TABLE `events` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table fav_samples
# ------------------------------------------------------------

DROP TABLE IF EXISTS `fav_samples`;

CREATE TABLE `fav_samples` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `human_sample_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_fav_samples_on_user_id` (`user_id`),
  KEY `index_fav_samples_on_human_sample_id` (`human_sample_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `fav_samples` WRITE;
/*!40000 ALTER TABLE `fav_samples` DISABLE KEYS */;

INSERT INTO `fav_samples` (`id`, `user_id`, `human_sample_id`, `created_at`, `updated_at`)
VALUES
	(1,2,4,'2017-08-15 20:53:02','2017-08-15 20:53:02'),
	(2,2,5,'2017-08-18 19:33:25','2017-08-18 19:33:25'),
	(3,2,2,'2017-08-18 19:33:27','2017-08-18 19:33:27');

/*!40000 ALTER TABLE `fav_samples` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table fav_subjects
# ------------------------------------------------------------

DROP TABLE IF EXISTS `fav_subjects`;

CREATE TABLE `fav_subjects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `human_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_fav_subjects_on_user_id` (`user_id`),
  KEY `index_fav_subjects_on_human_id` (`human_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `fav_subjects` WRITE;
/*!40000 ALTER TABLE `fav_subjects` DISABLE KEYS */;

INSERT INTO `fav_subjects` (`id`, `user_id`, `human_id`, `created_at`, `updated_at`)
VALUES
	(1,2,5,'2017-08-15 20:53:07','2017-08-15 20:53:07'),
	(2,2,6,'2017-08-15 20:53:08','2017-08-15 20:53:08');

/*!40000 ALTER TABLE `fav_subjects` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table genders
# ------------------------------------------------------------

DROP TABLE IF EXISTS `genders`;

CREATE TABLE `genders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `note` text,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `genders` WRITE;
/*!40000 ALTER TABLE `genders` DISABLE KEYS */;

INSERT INTO `genders` (`id`, `name`, `note`, `created_at`, `updated_at`)
VALUES
	(1,'M','Male','2017-08-15 18:44:06','2017-08-15 18:44:06'),
	(2,'F','Female','2017-08-15 18:44:16','2017-08-15 18:44:16');

/*!40000 ALTER TABLE `genders` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table groups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `groups`;

CREATE TABLE `groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `note` text,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `groups` WRITE;
/*!40000 ALTER TABLE `groups` DISABLE KEYS */;

INSERT INTO `groups` (`id`, `name`, `note`, `created_at`, `updated_at`)
VALUES
	(1,'admin','Administrator: can access administration panel, can add/edit/delete data ','2017-05-16 14:45:00','2017-05-16 14:45:00'),
	(2,'sample','Members who can access stock portal','2017-05-16 14:45:00','2017-07-19 17:06:49'),
	(3,'disabled','Previous members: not allowed to access the website anymote','2017-05-16 14:45:00','2017-05-16 14:45:00'),
	(4,'project','Members who can access project portal','2017-07-19 17:07:23','2017-07-19 17:07:23'),
	(5,'clinic','Members who can access clinical data','2017-07-19 17:07:52','2017-07-19 17:07:52');

/*!40000 ALTER TABLE `groups` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table groups_users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `groups_users`;

CREATE TABLE `groups_users` (
  `group_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  KEY `index_groups_users_on_group_id_and_user_id` (`group_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `groups_users` WRITE;
/*!40000 ALTER TABLE `groups_users` DISABLE KEYS */;

INSERT INTO `groups_users` (`group_id`, `user_id`)
VALUES
	(1,1),
	(1,2),
	(2,2),
	(4,2),
	(5,2);

/*!40000 ALTER TABLE `groups_users` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table human_samples
# ------------------------------------------------------------

DROP TABLE IF EXISTS `human_samples`;

CREATE TABLE `human_samples` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sample_type_id` int(11) DEFAULT NULL,
  `visit_id` int(11) DEFAULT NULL,
  `amount` varchar(255) DEFAULT NULL,
  `created_on` date DEFAULT NULL,
  `main_location_id` int(11) DEFAULT NULL,
  `sub_location` varchar(255) DEFAULT NULL,
  `source` varchar(255) DEFAULT NULL,
  `prepared_by` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `note` text,
  `accession` varchar(255) DEFAULT NULL,
  `concentration` varchar(255) DEFAULT NULL,
  `avail_amount` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_human_samples_on_sample_type_id` (`sample_type_id`),
  KEY `index_human_samples_on_visit_id` (`visit_id`),
  KEY `index_human_samples_on_main_location_id` (`main_location_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `human_samples` WRITE;
/*!40000 ALTER TABLE `human_samples` DISABLE KEYS */;

INSERT INTO `human_samples` (`id`, `sample_type_id`, `visit_id`, `amount`, `created_on`, `main_location_id`, `sub_location`, `source`, `prepared_by`, `created_at`, `updated_at`, `note`, `accession`, `concentration`, `avail_amount`)
VALUES
	(1,1,1,'10 uL','2017-08-15',2,NULL,'','John','2017-08-15 19:49:07','2017-08-15 19:49:07','','Subject0001_1_WB_1','','10 uL'),
	(2,3,4,'','2017-08-15',2,NULL,'WB','Mary','2017-08-15 19:50:28','2017-08-15 19:50:28','','Subject0004_1_DNA_2','2 nM',''),
	(3,4,6,'5 uL','2017-08-15',1,NULL,'','','2017-08-15 19:51:31','2017-08-15 19:51:31','','Subject0006_1_PBMC_3','','5 uL'),
	(4,2,9,'15 uL','2017-08-15',1,NULL,'','','2017-08-15 19:52:24','2017-08-15 19:54:04','','Subject0004_2_Plasma_4','','5 uL'),
	(5,2,2,'10 uL','2017-08-16',1,NULL,'','','2017-08-16 17:58:26','2017-08-16 17:58:26','','Subject0002_1_Plasma_5','','10 uL');

/*!40000 ALTER TABLE `human_samples` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table humen
# ------------------------------------------------------------

DROP TABLE IF EXISTS `humen`;

CREATE TABLE `humen` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `accession` varchar(255) DEFAULT NULL,
  `other_ids` text,
  `population_id` int(11) DEFAULT NULL,
  `gender_id` int(11) DEFAULT NULL,
  `note` text,
  `status_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_humen_on_population_id` (`population_id`),
  KEY `index_humen_on_gender_id` (`gender_id`),
  KEY `index_humen_on_status_id` (`status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `humen` WRITE;
/*!40000 ALTER TABLE `humen` DISABLE KEYS */;

INSERT INTO `humen` (`id`, `accession`, `other_ids`, `population_id`, `gender_id`, `note`, `status_id`, `created_at`, `updated_at`)
VALUES
	(1,'Subject0001','',2,1,'',1,'2017-08-15 19:05:50','2017-08-15 19:10:24'),
	(2,'Subject0002','',1,2,'',1,'2017-08-15 19:06:21','2017-08-15 19:06:21'),
	(3,'Subject0003','',1,1,'excluded due to not comply rules',2,'2017-08-15 19:07:53','2017-08-15 19:07:53'),
	(4,'Subject0004','',2,2,'',1,'2017-08-15 19:08:26','2017-08-15 19:08:26'),
	(5,'Subject0005','',1,1,'',1,'2017-08-15 19:11:03','2017-08-15 19:11:03'),
	(6,'Subject0006','',2,2,'',1,'2017-08-15 19:11:34','2017-08-15 19:11:34'),
	(7,'Subject0007','p124',1,2,'',1,'2017-08-17 19:28:27','2017-08-17 19:28:27');

/*!40000 ALTER TABLE `humen` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table humen_irbs
# ------------------------------------------------------------

DROP TABLE IF EXISTS `humen_irbs`;

CREATE TABLE `humen_irbs` (
  `human_id` int(11) NOT NULL,
  `irb_id` int(11) NOT NULL,
  KEY `index_humen_irbs_on_human_id_and_irb_id` (`human_id`,`irb_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `humen_irbs` WRITE;
/*!40000 ALTER TABLE `humen_irbs` DISABLE KEYS */;

INSERT INTO `humen_irbs` (`human_id`, `irb_id`)
VALUES
	(1,1),
	(2,2),
	(3,1),
	(4,1),
	(5,1),
	(6,2),
	(7,2);

/*!40000 ALTER TABLE `humen_irbs` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table humen_races
# ------------------------------------------------------------

DROP TABLE IF EXISTS `humen_races`;

CREATE TABLE `humen_races` (
  `human_id` int(11) NOT NULL,
  `race_id` int(11) NOT NULL,
  KEY `index_humen_races_on_human_id_and_race_id` (`human_id`,`race_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `humen_races` WRITE;
/*!40000 ALTER TABLE `humen_races` DISABLE KEYS */;

INSERT INTO `humen_races` (`human_id`, `race_id`)
VALUES
	(1,1),
	(2,2),
	(3,3),
	(4,2),
	(5,3),
	(6,1),
	(7,2);

/*!40000 ALTER TABLE `humen_races` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table irbs
# ------------------------------------------------------------

DROP TABLE IF EXISTS `irbs`;

CREATE TABLE `irbs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number` varchar(255) DEFAULT NULL,
  `name` text,
  `pi` varchar(255) DEFAULT NULL,
  `note` text,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `irbs` WRITE;
/*!40000 ALTER TABLE `irbs` DISABLE KEYS */;

INSERT INTO `irbs` (`id`, `number`, `name`, `pi`, `note`, `created_at`, `updated_at`, `address`)
VALUES
	(1,'CR000123','Study molecular biomarker changes during disease XX development','Tom','some note','2017-08-17 16:34:35','2017-08-22 15:37:18','https://irb/example/CR000123'),
	(2,'CR000124','Longitudinal Characterization of Molecular changes of disease XX','Jack','','2017-08-17 16:36:32','2017-08-17 16:36:32',NULL);

/*!40000 ALTER TABLE `irbs` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table main_locations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `main_locations`;

CREATE TABLE `main_locations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `location` text,
  `note` text,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `main_locations` WRITE;
/*!40000 ALTER TABLE `main_locations` DISABLE KEYS */;

INSERT INTO `main_locations` (`id`, `name`, `location`, `note`, `created_at`, `updated_at`)
VALUES
	(1,'Core facility','Building A','','2017-08-15 19:47:36','2017-08-15 19:47:36'),
	(2,'lab -80 freezer','third floor of building B','','2017-08-15 19:48:09','2017-08-15 19:48:09');

/*!40000 ALTER TABLE `main_locations` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table materials
# ------------------------------------------------------------

DROP TABLE IF EXISTS `materials`;

CREATE TABLE `materials` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `file` varchar(255) DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `materials` WRITE;
/*!40000 ALTER TABLE `materials` DISABLE KEYS */;

INSERT INTO `materials` (`id`, `title`, `file`, `note`, `created_at`, `updated_at`)
VALUES
	(1,'Experimental protocol for RNA-Seq','RNASeq_protocol.docx','','2017-08-15 20:42:29','2017-08-15 20:42:29');

/*!40000 ALTER TABLE `materials` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table populations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `populations`;

CREATE TABLE `populations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `note` text,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `populations` WRITE;
/*!40000 ALTER TABLE `populations` DISABLE KEYS */;

INSERT INTO `populations` (`id`, `name`, `note`, `created_at`, `updated_at`)
VALUES
	(1,'Patient','','2017-08-15 18:48:14','2017-08-15 18:48:14'),
	(2,'Control','','2017-08-15 18:48:37','2017-08-15 18:48:37');

/*!40000 ALTER TABLE `populations` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table projects
# ------------------------------------------------------------

DROP TABLE IF EXISTS `projects`;

CREATE TABLE `projects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  `PI` varchar(255) DEFAULT NULL,
  `members` text,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `progress` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `projects` WRITE;
/*!40000 ALTER TABLE `projects` DISABLE KEYS */;

INSERT INTO `projects` (`id`, `name`, `description`, `PI`, `members`, `created_at`, `updated_at`, `progress`)
VALUES
	(1,'RNA-Seq project','Study the gene expression changes between patients and controls','Tom','Mary, John','2017-08-15 20:33:41','2017-08-15 20:33:41',30),
	(2,'MRI project','Study the brain volume changes during disease development','Tom','Jack, Sarah','2017-08-15 20:36:21','2017-08-15 20:36:21',80),
	(3,'Serum study','Study the protein concentration changes between patients and controls','Tom','Hong, bety','2017-08-15 20:39:07','2017-08-15 20:39:07',50),
	(4,'Metabolome Project','','Tom','Lucy, Robert','2017-08-16 15:42:12','2017-08-16 15:42:12',100),
	(5,'fcMRI','Study functional interactions between brain regions','James','Ann, Emma','2017-08-16 15:45:21','2017-08-16 15:45:21',100),
	(6,'Chip-Seq project','','Tom','Mary','2017-08-22 16:03:46','2017-08-22 16:03:46',10);

/*!40000 ALTER TABLE `projects` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table races
# ------------------------------------------------------------

DROP TABLE IF EXISTS `races`;

CREATE TABLE `races` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `note` text,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `races` WRITE;
/*!40000 ALTER TABLE `races` DISABLE KEYS */;

INSERT INTO `races` (`id`, `name`, `note`, `created_at`, `updated_at`)
VALUES
	(1,'Asian','','2017-08-15 18:44:37','2017-08-15 18:44:37'),
	(2,'AA','African American ','2017-08-15 18:45:05','2017-08-15 18:45:05'),
	(3,'Cauc','Caucasian','2017-08-15 18:45:50','2017-08-15 18:45:50');

/*!40000 ALTER TABLE `races` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sample_types
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sample_types`;

CREATE TABLE `sample_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `note` text,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `sample_types` WRITE;
/*!40000 ALTER TABLE `sample_types` DISABLE KEYS */;

INSERT INTO `sample_types` (`id`, `name`, `note`, `created_at`, `updated_at`)
VALUES
	(1,'WB','Whole Blood','2017-08-15 19:43:42','2017-08-15 19:43:42'),
	(2,'Plasma','','2017-08-15 19:44:00','2017-08-15 19:44:00'),
	(3,'DNA','','2017-08-15 19:44:21','2017-08-15 19:44:21'),
	(4,'PBMC','peripheral blood mononuclear cell ','2017-08-15 19:45:01','2017-08-15 19:45:01');

/*!40000 ALTER TABLE `sample_types` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table schema_migrations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `schema_migrations`;

CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `schema_migrations` WRITE;
/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;

INSERT INTO `schema_migrations` (`version`)
VALUES
	('20170511173947'),
	('20170511175903'),
	('20170511175931'),
	('20170511192859'),
	('20170515205728'),
	('20170516164327'),
	('20170516164448'),
	('20170516164527'),
	('20170516171613'),
	('20170516171710'),
	('20170516174009'),
	('20170516183755'),
	('20170516184008'),
	('20170516205759'),
	('20170518163654'),
	('20170518163902'),
	('20170518234544'),
	('20170522201218'),
	('20170523141134'),
	('20170524191055'),
	('20170524200233'),
	('20170525142209'),
	('20170525161842'),
	('20170525161902'),
	('20170525182025'),
	('20170525210234'),
	('20170531195527'),
	('20170728174456'),
	('20170728182338'),
	('20170801164629'),
	('20170802183416'),
	('20170815191436'),
	('20170815203026'),
	('20170816183723'),
	('20170817145627'),
	('20170817150635'),
	('20170817163943'),
	('20170817183841'),
	('20170822150134'),
	('20170822152518');

/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table statuses
# ------------------------------------------------------------

DROP TABLE IF EXISTS `statuses`;

CREATE TABLE `statuses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `note` text,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `statuses` WRITE;
/*!40000 ALTER TABLE `statuses` DISABLE KEYS */;

INSERT INTO `statuses` (`id`, `name`, `note`, `created_at`, `updated_at`)
VALUES
	(1,'Valid','','2017-08-15 18:49:03','2017-08-15 18:49:03'),
	(2,'Invalid','excluded from study','2017-08-15 18:51:02','2017-08-15 18:51:02');

/*!40000 ALTER TABLE `statuses` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table transfers
# ------------------------------------------------------------

DROP TABLE IF EXISTS `transfers`;

CREATE TABLE `transfers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `human_sample_id` int(11) DEFAULT NULL,
  `trans_from` varchar(255) DEFAULT NULL,
  `trans_to` varchar(255) DEFAULT NULL,
  `amount` varchar(255) DEFAULT NULL,
  `note` text,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_transfers_on_human_sample_id` (`human_sample_id`),
  CONSTRAINT `fk_rails_efa90ac8d3` FOREIGN KEY (`human_sample_id`) REFERENCES `human_samples` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `transfers` WRITE;
/*!40000 ALTER TABLE `transfers` DISABLE KEYS */;

INSERT INTO `transfers` (`id`, `human_sample_id`, `trans_from`, `trans_to`, `amount`, `note`, `created_at`, `updated_at`)
VALUES
	(1,4,'Core facility','Jack','10 uL','For research x','2017-08-15 19:53:30','2017-08-15 19:53:30');

/*!40000 ALTER TABLE `transfers` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `gmail` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password_digest` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;

INSERT INTO `users` (`id`, `name`, `gmail`, `phone`, `email`, `password_digest`, `created_at`, `updated_at`, `username`)
VALUES
	(2,'root','',NULL,'','$2a$10$yqZWNj.NPo7Ydp6Jtknhsu3BD5viDq2mICwhIS9rBKQ7osnPqr6ni','2017-08-15 17:58:02','2017-08-15 17:58:02','root');

/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table visit_types
# ------------------------------------------------------------

DROP TABLE IF EXISTS `visit_types`;

CREATE TABLE `visit_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `value` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `visit_types` WRITE;
/*!40000 ALTER TABLE `visit_types` DISABLE KEYS */;

INSERT INTO `visit_types` (`id`, `value`, `created_at`, `updated_at`)
VALUES
	(1,'1st visit','2017-08-15 18:51:31','2017-08-15 18:51:31'),
	(2,'2nd visit','2017-08-15 18:51:53','2017-08-15 18:51:53');

/*!40000 ALTER TABLE `visit_types` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table visits
# ------------------------------------------------------------

DROP TABLE IF EXISTS `visits`;

CREATE TABLE `visits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `human_id` int(11) DEFAULT NULL,
  `visit_type_id` int(11) DEFAULT NULL,
  `diagnosis` text,
  `note` text,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `age` int(11) DEFAULT NULL,
  `visit_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_visits_on_human_id` (`human_id`),
  KEY `index_visits_on_visit_type_id` (`visit_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `visits` WRITE;
/*!40000 ALTER TABLE `visits` DISABLE KEYS */;

INSERT INTO `visits` (`id`, `human_id`, `visit_type_id`, `diagnosis`, `note`, `created_at`, `updated_at`, `age`, `visit_date`)
VALUES
	(1,1,1,'','','2017-08-15 19:43:11','2017-08-17 19:29:42',23,NULL),
	(2,2,1,'disease A','','2017-08-15 19:43:11','2017-08-22 15:37:46',32,NULL),
	(3,3,1,'disease A','didn\'t get blood draw','2017-08-15 19:43:11','2017-08-15 19:43:11',22,NULL),
	(4,4,1,'','','2017-08-15 19:43:11','2017-08-17 19:07:59',18,'2016-06-06'),
	(5,5,1,'disease A','','2017-08-15 19:43:11','2017-08-22 15:38:26',20,NULL),
	(6,6,1,'','','2017-08-15 19:43:11','2017-08-17 19:17:13',34,'2015-04-09'),
	(7,2,2,'disease A','','2017-08-15 19:43:11','2017-08-22 15:37:46',33,NULL),
	(8,3,2,'disease A','','2017-08-15 19:43:11','2017-08-22 15:39:10',23,NULL),
	(9,4,2,'','','2017-08-15 19:43:11','2017-08-17 19:07:59',19,'2017-07-01'),
	(10,7,1,'Disease A','','2017-08-17 19:28:27','2017-08-17 19:28:27',26,'2017-08-13');

/*!40000 ALTER TABLE `visits` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
