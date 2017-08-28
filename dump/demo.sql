# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.7.18)
# Database: hsspm_dev
# Generation Time: 2017-08-25 20:36:20 +0000
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
	(6,1),
	(7,1),
	(8,2);

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
  KEY `index_demographies_on_human_id` (`human_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `demographies` WRITE;
/*!40000 ALTER TABLE `demographies` DISABLE KEYS */;

INSERT INTO `demographies` (`id`, `human_id`, `data`, `created_at`, `updated_at`)
VALUES
	(1,1,'height: 74 inches\r\nweight: 120 lbs','2017-08-25 18:04:21','2017-08-25 18:04:21'),
	(2,2,'Height: 68 inches\r\nWeight: 130 lbs\r\nEducation: 12 years\r\nHandedness: right\r\nPhysical condition: high blood pressure\r\nSmoking?: Yes\r\nPack per day: 2\r\nCurrent medication: none\r\nPast medication: Aspirin\r\nFamily History: Unknown\r\nReferral: Dr. XXX\r\nDate of diagnosis: 2017-XX-XX','2017-08-25 18:05:09','2017-08-25 18:05:09'),
	(3,4,'Height: 70 inches\r\nWeight: 150lbs\r\nHandedness: left\r\nSmoke?: No\r\nFamily History: Father, diabetes\r\nCurrent medication: none\r\nPast medication: none','2017-08-25 18:06:02','2017-08-25 18:06:02'),
	(4,7,'Height: 60 inches\r\nWeight: 180 lbs','2017-08-25 18:06:34','2017-08-25 18:06:34'),
	(5,8,'Height: 68 inches\r\nWeight: 140 lbs\r\nHandedness: right\r\nPhysical condition: diabetes\r\nSmoking?: Yes\r\nPack per day: 0.5\r\nCurrent medication: none\r\nPast medication: Aspirin\r\nFamily History: Unknown\r\nDate of diagnosis: 2016-01-05','2017-08-25 18:09:12','2017-08-25 18:09:12');

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
	(2,3),
	(4,2),
	(5,2),
	(5,3);

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
	(1,1,1,'10 uL','2017-08-15',2,'box D - slot 2',NULL,'John','2017-08-25 17:50:14','2017-08-25 17:50:14',NULL,'Subject0001_1_WB_1',NULL,'10 uL'),
	(2,2,2,'10 uL','2017-08-16',1,'tube 123',NULL,NULL,'2017-08-25 17:50:14','2017-08-25 17:50:14',NULL,'Subject0002_1_Plasma_5',NULL,'10 uL'),
	(3,3,6,'15 uL','2017-08-15',2,'box A - slot 5','WB','Mary','2017-08-25 17:50:14','2017-08-25 17:50:14',NULL,'Subject0004_1_DNA_2','2 nM','15 uL'),
	(4,2,7,'15 uL','2017-08-15',1,'tube 114','','','2017-08-25 17:50:14','2017-08-25 18:00:15','','Subject0004_2_Plasma_4','','5 uL'),
	(5,4,9,'5 uL','2017-08-15',1,'tube 257',NULL,NULL,'2017-08-25 17:50:14','2017-08-25 17:50:14',NULL,'Subject0006_1_PBMC_3',NULL,'5 uL');

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
	(1,'Subject0001','',2,1,'',1,'2017-08-25 17:38:48','2017-08-25 18:04:21'),
	(2,'Subject0002','',1,2,'',1,'2017-08-25 17:38:48','2017-08-25 18:05:09'),
	(3,'Subject0003',NULL,1,1,'excluded due to not comply rules',2,'2017-08-25 17:38:48','2017-08-25 17:38:48'),
	(4,'Subject0004','',2,2,'',1,'2017-08-25 17:38:48','2017-08-25 18:06:02'),
	(5,'Subject0005',NULL,1,1,NULL,1,'2017-08-25 17:38:48','2017-08-25 17:38:48'),
	(6,'Subject0006',NULL,2,2,NULL,1,'2017-08-25 17:38:48','2017-08-25 17:38:48'),
	(7,'Subject0007','',1,2,'',1,'2017-08-25 17:38:48','2017-08-25 18:06:34'),
	(8,'Subject0008','',1,1,'',1,'2017-08-25 17:38:48','2017-08-25 18:09:12');

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
	(7,2),
	(8,2);

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
	(7,2),
	(8,2),
	(8,3);

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
	(1,'RNA-Seq project','Study the gene expression changes between patients and controls','Tom','Mary, John,Ben','2017-08-25 17:51:51','2017-08-25 17:51:51',30),
	(2,'MRI project','Study the brain volume changes during disease development','Tom','Jack, Sarah','2017-08-25 17:52:34','2017-08-25 17:52:34',80),
	(3,'Serum study','Study the protein concentration changes between patients and controls','Tom','Hong, bety','2017-08-25 17:53:10','2017-08-25 17:53:10',50),
	(4,'Metabolome Project','','Tom','Lucy, Robert','2017-08-25 17:54:42','2017-08-25 17:54:42',100),
	(5,'fcMRI','Study functional interactions between brain regions','James','Ann, Emma','2017-08-25 17:55:31','2017-08-25 17:55:31',100),
	(6,'Chip-Seq project','','Tom','Mary,John','2017-08-25 17:56:05','2017-08-25 18:10:44',10);

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
	('20170822152518'),
	('20170825151948'),
	('20170825163126');

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
  KEY `index_transfers_on_human_sample_id` (`human_sample_id`)
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
	(2,'root','test@gmail.com','','','$2a$10$wgRIJVrYxfqdGQ/Uyg4mU.3hKcsvtqIcNMT9jSMGvcsmXr2JJ03qa','2017-08-15 17:58:02','2017-08-25 15:13:25','root'),
	(3,'Clinical RA','',NULL,'','$2a$10$woDeITn9uYLEAPWtKp3lzOwJQCagJRvDc1Uz/bJUzRD2qq7VfPlTC','2017-08-25 17:42:31','2017-08-25 17:42:31','ra');

/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table versions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `versions`;

CREATE TABLE `versions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_type` varchar(191) NOT NULL,
  `item_id` int(11) NOT NULL,
  `event` varchar(255) NOT NULL,
  `whodunnit` varchar(255) DEFAULT NULL,
  `object` longtext,
  `created_at` datetime DEFAULT NULL,
  `object_changes` longtext,
  PRIMARY KEY (`id`),
  KEY `index_versions_on_item_type_and_item_id` (`item_type`,`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `versions` WRITE;
/*!40000 ALTER TABLE `versions` DISABLE KEYS */;

INSERT INTO `versions` (`id`, `item_type`, `item_id`, `event`, `whodunnit`, `object`, `created_at`, `object_changes`)
VALUES
	(1,'Human',1,'create','2',NULL,'2017-08-25 17:38:48','---\nid:\n- \n- 1\naccession:\n- \n- Subject0001\npopulation_id:\n- \n- 2\ngender_id:\n- \n- 1\nstatus_id:\n- \n- 1\n'),
	(2,'Human',2,'create','2',NULL,'2017-08-25 17:38:48','---\nid:\n- \n- 2\naccession:\n- \n- Subject0002\npopulation_id:\n- \n- 1\ngender_id:\n- \n- 2\nstatus_id:\n- \n- 1\n'),
	(3,'Human',3,'create','2',NULL,'2017-08-25 17:38:48','---\nid:\n- \n- 3\naccession:\n- \n- Subject0003\npopulation_id:\n- \n- 1\ngender_id:\n- \n- 1\nnote:\n- \n- excluded due to not comply rules\nstatus_id:\n- \n- 2\n'),
	(4,'Human',4,'create','2',NULL,'2017-08-25 17:38:48','---\nid:\n- \n- 4\naccession:\n- \n- Subject0004\npopulation_id:\n- \n- 2\ngender_id:\n- \n- 2\nstatus_id:\n- \n- 1\n'),
	(5,'Human',5,'create','2',NULL,'2017-08-25 17:38:48','---\nid:\n- \n- 5\naccession:\n- \n- Subject0005\npopulation_id:\n- \n- 1\ngender_id:\n- \n- 1\nstatus_id:\n- \n- 1\n'),
	(6,'Human',6,'create','2',NULL,'2017-08-25 17:38:48','---\nid:\n- \n- 6\naccession:\n- \n- Subject0006\npopulation_id:\n- \n- 2\ngender_id:\n- \n- 2\nstatus_id:\n- \n- 1\n'),
	(7,'Human',7,'create','2',NULL,'2017-08-25 17:38:48','---\nid:\n- \n- 7\naccession:\n- \n- Subject0007\nother_ids:\n- \n- p124\npopulation_id:\n- \n- 1\ngender_id:\n- \n- 2\nstatus_id:\n- \n- 1\n'),
	(8,'Human',8,'create','2',NULL,'2017-08-25 17:38:48','---\nid:\n- \n- 8\naccession:\n- \n- Subject0008\npopulation_id:\n- \n- 1\ngender_id:\n- \n- 1\nstatus_id:\n- \n- 1\n'),
	(9,'Visit',1,'create','2',NULL,'2017-08-25 17:41:31','---\nid:\n- \n- 1\nhuman_id:\n- \n- 1\nvisit_type_id:\n- \n- 1\nage:\n- \n- 23\n'),
	(10,'Visit',2,'create','2',NULL,'2017-08-25 17:41:31','---\nid:\n- \n- 2\nhuman_id:\n- \n- 2\nvisit_type_id:\n- \n- 1\ndiagnosis:\n- \n- disease A\nage:\n- \n- 32\n'),
	(11,'Visit',3,'create','2',NULL,'2017-08-25 17:41:31','---\nid:\n- \n- 3\nhuman_id:\n- \n- 2\nvisit_type_id:\n- \n- 2\ndiagnosis:\n- \n- disease A\nage:\n- \n- 33\n'),
	(12,'Visit',4,'create','2',NULL,'2017-08-25 17:41:31','---\nid:\n- \n- 4\nhuman_id:\n- \n- 3\nvisit_type_id:\n- \n- 1\ndiagnosis:\n- \n- disease A\nnote:\n- \n- didn\'t get blood draw\nage:\n- \n- 22\n'),
	(13,'Visit',5,'create','2',NULL,'2017-08-25 17:41:31','---\nid:\n- \n- 5\nhuman_id:\n- \n- 3\nvisit_type_id:\n- \n- 2\ndiagnosis:\n- \n- disease A\nage:\n- \n- 23\n'),
	(14,'Visit',6,'create','2',NULL,'2017-08-25 17:41:31','---\nid:\n- \n- 6\nhuman_id:\n- \n- 4\nvisit_type_id:\n- \n- 1\nage:\n- \n- 18\n'),
	(15,'Visit',7,'create','2',NULL,'2017-08-25 17:41:31','---\nid:\n- \n- 7\nhuman_id:\n- \n- 4\nvisit_type_id:\n- \n- 2\nage:\n- \n- 19\n'),
	(16,'Visit',8,'create','2',NULL,'2017-08-25 17:41:31','---\nid:\n- \n- 8\nhuman_id:\n- \n- 5\nvisit_type_id:\n- \n- 1\ndiagnosis:\n- \n- disease A\nage:\n- \n- 20\n'),
	(17,'Visit',9,'create','2',NULL,'2017-08-25 17:41:31','---\nid:\n- \n- 9\nhuman_id:\n- \n- 6\nvisit_type_id:\n- \n- 1\nage:\n- \n- 34\n'),
	(18,'Visit',10,'create','2',NULL,'2017-08-25 17:41:31','---\nid:\n- \n- 10\nhuman_id:\n- \n- 7\nvisit_type_id:\n- \n- 1\ndiagnosis:\n- \n- Disease A\nage:\n- \n- 26\n'),
	(19,'HumanSample',1,'create','2',NULL,'2017-08-25 17:50:14','---\nid:\n- \n- 1\nsample_type_id:\n- \n- 1\nvisit_id:\n- \n- 1\namount:\n- \n- 10 uL\ncreated_on:\n- \n- 2017-08-15\nmain_location_id:\n- \n- 2\nsub_location:\n- \n- box D - slot 2\nprepared_by:\n- \n- John\naccession:\n- \n- Subject0001_1_WB_1\navail_amount:\n- \n- 10 uL\n'),
	(20,'HumanSample',2,'create','2',NULL,'2017-08-25 17:50:14','---\nid:\n- \n- 2\nsample_type_id:\n- \n- 2\nvisit_id:\n- \n- 2\namount:\n- \n- 10 uL\ncreated_on:\n- \n- 2017-08-16\nmain_location_id:\n- \n- 1\nsub_location:\n- \n- tube 123\naccession:\n- \n- Subject0002_1_Plasma_5\navail_amount:\n- \n- 10 uL\n'),
	(21,'HumanSample',3,'create','2',NULL,'2017-08-25 17:50:14','---\nid:\n- \n- 3\nsample_type_id:\n- \n- 3\nvisit_id:\n- \n- 6\namount:\n- \n- 15 uL\ncreated_on:\n- \n- 2017-08-15\nmain_location_id:\n- \n- 2\nsub_location:\n- \n- box A - slot 5\nsource:\n- \n- WB\nprepared_by:\n- \n- Mary\naccession:\n- \n- Subject0004_1_DNA_2\nconcentration:\n- \n- 2 nM\navail_amount:\n- \n- 15 uL\n'),
	(22,'HumanSample',4,'create','2',NULL,'2017-08-25 17:50:14','---\nid:\n- \n- 4\nsample_type_id:\n- \n- 2\nvisit_id:\n- \n- 7\namount:\n- \n- 15 uL\ncreated_on:\n- \n- 2017-08-15\nmain_location_id:\n- \n- 1\nsub_location:\n- \n- tube 114\naccession:\n- \n- Subject0004_2_Plasma_4\navail_amount:\n- \n- 15 uL\n'),
	(23,'HumanSample',5,'create','2',NULL,'2017-08-25 17:50:14','---\nid:\n- \n- 5\nsample_type_id:\n- \n- 4\nvisit_id:\n- \n- 9\namount:\n- \n- 5 uL\ncreated_on:\n- \n- 2017-08-15\nmain_location_id:\n- \n- 1\nsub_location:\n- \n- tube 257\naccession:\n- \n- Subject0006_1_PBMC_3\navail_amount:\n- \n- 5 uL\n'),
	(24,'Project',1,'create','2',NULL,'2017-08-25 17:51:51','---\nid:\n- \n- 1\nname:\n- \n- RNA-Seq project\ndescription:\n- \n- Study the gene expression changes between patients and controls\nPI:\n- \n- Tom\nmembers:\n- \n- Mary, John,Ben\nprogress:\n- \n- 30\n'),
	(25,'Project',2,'create','2',NULL,'2017-08-25 17:52:34','---\nid:\n- \n- 2\nname:\n- \n- MRI project\ndescription:\n- \n- Study the brain volume changes during disease development\nPI:\n- \n- Tom\nmembers:\n- \n- Jack, Sarah\nprogress:\n- \n- 80\n'),
	(26,'Project',3,'create','2',NULL,'2017-08-25 17:53:10','---\nid:\n- \n- 3\nname:\n- \n- Serum study\ndescription:\n- \n- Study the protein concentration changes between patients and controls\nPI:\n- \n- Tom\nmembers:\n- \n- Hong, bety\nprogress:\n- \n- 50\n'),
	(27,'Project',4,'create','2',NULL,'2017-08-25 17:54:42','---\nid:\n- \n- 4\nname:\n- \n- Metabolome Project\ndescription:\n- \n- \'\'\nPI:\n- \n- Tom\nmembers:\n- \n- Lucy, Robert\nprogress:\n- \n- 100\n'),
	(28,'Project',5,'create','2',NULL,'2017-08-25 17:55:31','---\nid:\n- \n- 5\nname:\n- \n- fcMRI\ndescription:\n- \n- Study functional interactions between brain regions\nPI:\n- \n- James\nmembers:\n- \n- Ann, Emma\nprogress:\n- \n- 100\n'),
	(29,'Project',6,'create','2',NULL,'2017-08-25 17:56:05','---\nid:\n- \n- 6\nname:\n- \n- Chip-Seq project\ndescription:\n- \n- \'\'\nPI:\n- \n- Tom\nmembers:\n- \n- Mary\nprogress:\n- \n- 10\n'),
	(30,'HumanSample',4,'update','2','---\nid: 4\nsample_type_id: 2\nvisit_id: 7\namount: 15 uL\ncreated_on: 2017-08-15\nmain_location_id: 1\nsub_location: tube 114\nsource: \nprepared_by: \ncreated_at: 2017-08-25 17:50:14.000000000 Z\nupdated_at: 2017-08-25 17:50:14.000000000 Z\nnote: \naccession: Subject0004_2_Plasma_4\nconcentration: \navail_amount: 15 uL\n','2017-08-25 18:00:15','---\navail_amount:\n- 15 uL\n- 5 uL\nconcentration:\n- \n- \'\'\nsource:\n- \n- \'\'\nprepared_by:\n- \n- \'\'\nnote:\n- \n- \'\'\n'),
	(31,'Human',1,'update','3','---\nid: 1\naccession: Subject0001\nother_ids: \npopulation_id: 2\ngender_id: 1\nnote: \nstatus_id: 1\ncreated_at: 2017-08-25 17:38:48.000000000 Z\nupdated_at: 2017-08-25 17:38:48.000000000 Z\n','2017-08-25 18:04:21','---\nother_ids:\n- \n- \'\'\nnote:\n- \n- \'\'\n'),
	(32,'Demography',1,'create','3',NULL,'2017-08-25 18:04:21','---\nid:\n- \n- 1\nhuman_id:\n- \n- 1\ndata:\n- \n- \"height: 74 inches\\r\\nweight: 120 lbs\"\n'),
	(33,'Visit',1,'update','3','---\nid: 1\nhuman_id: 1\nvisit_type_id: 1\ndiagnosis: \nnote: \ncreated_at: 2017-08-25 17:41:31.000000000 Z\nupdated_at: 2017-08-25 17:41:31.000000000 Z\nage: 23\nvisit_date: \n','2017-08-25 18:04:21','---\ndiagnosis:\n- \n- \'\'\nnote:\n- \n- \'\'\n'),
	(34,'Human',2,'update','3','---\nid: 2\naccession: Subject0002\nother_ids: \npopulation_id: 1\ngender_id: 2\nnote: \nstatus_id: 1\ncreated_at: 2017-08-25 17:38:48.000000000 Z\nupdated_at: 2017-08-25 17:38:48.000000000 Z\n','2017-08-25 18:05:09','---\nother_ids:\n- \n- \'\'\nnote:\n- \n- \'\'\n'),
	(35,'Demography',2,'create','3',NULL,'2017-08-25 18:05:09','---\nid:\n- \n- 2\nhuman_id:\n- \n- 2\ndata:\n- \n- \"Height: 68 inches\\r\\nWeight: 130 lbs\\r\\nEducation: 12 years\\r\\nHandedness: right\\r\\nPhysical\n  condition: high blood pressure\\r\\nSmoking?: Yes\\r\\nPack per day: 2\\r\\nCurrent medication:\n  none\\r\\nPast medication: Aspirin\\r\\nFamily History: Unknown\\r\\nReferral: Dr. XXX\\r\\nDate\n  of diagnosis: 2017-XX-XX\"\n'),
	(36,'Visit',2,'update','3','---\nid: 2\nhuman_id: 2\nvisit_type_id: 1\ndiagnosis: disease A\nnote: \ncreated_at: 2017-08-25 17:41:31.000000000 Z\nupdated_at: 2017-08-25 17:41:31.000000000 Z\nage: 32\nvisit_date: \n','2017-08-25 18:05:09','---\nnote:\n- \n- \'\'\n'),
	(37,'Visit',3,'update','3','---\nid: 3\nhuman_id: 2\nvisit_type_id: 2\ndiagnosis: disease A\nnote: \ncreated_at: 2017-08-25 17:41:31.000000000 Z\nupdated_at: 2017-08-25 17:41:31.000000000 Z\nage: 33\nvisit_date: \n','2017-08-25 18:05:09','---\nnote:\n- \n- \'\'\n'),
	(38,'Human',4,'update','3','---\nid: 4\naccession: Subject0004\nother_ids: \npopulation_id: 2\ngender_id: 2\nnote: \nstatus_id: 1\ncreated_at: 2017-08-25 17:38:48.000000000 Z\nupdated_at: 2017-08-25 17:38:48.000000000 Z\n','2017-08-25 18:06:02','---\nother_ids:\n- \n- \'\'\nnote:\n- \n- \'\'\n'),
	(39,'Demography',3,'create','3',NULL,'2017-08-25 18:06:02','---\nid:\n- \n- 3\nhuman_id:\n- \n- 4\ndata:\n- \n- \"Height: 70 inches\\r\\nWeight: 150lbs\\r\\nHandedness: left\\r\\nSmoke?: No\\r\\nFamily\n  History: Father, diabetes\\r\\nCurrent medication: none\\r\\nPast medication: none\"\n'),
	(40,'Visit',6,'update','3','---\nid: 6\nhuman_id: 4\nvisit_type_id: 1\ndiagnosis: \nnote: \ncreated_at: 2017-08-25 17:41:31.000000000 Z\nupdated_at: 2017-08-25 17:41:31.000000000 Z\nage: 18\nvisit_date: \n','2017-08-25 18:06:02','---\ndiagnosis:\n- \n- \'\'\nnote:\n- \n- \'\'\n'),
	(41,'Visit',7,'update','3','---\nid: 7\nhuman_id: 4\nvisit_type_id: 2\ndiagnosis: \nnote: \ncreated_at: 2017-08-25 17:41:31.000000000 Z\nupdated_at: 2017-08-25 17:41:31.000000000 Z\nage: 19\nvisit_date: \n','2017-08-25 18:06:02','---\ndiagnosis:\n- \n- \'\'\nnote:\n- \n- \'\'\n'),
	(42,'Human',7,'update','3','---\nid: 7\naccession: Subject0007\nother_ids: p124\npopulation_id: 1\ngender_id: 2\nnote: \nstatus_id: 1\ncreated_at: 2017-08-25 17:38:48.000000000 Z\nupdated_at: 2017-08-25 17:38:48.000000000 Z\n','2017-08-25 18:06:34','---\nother_ids:\n- p124\n- \'\'\nnote:\n- \n- \'\'\n'),
	(43,'Demography',4,'create','3',NULL,'2017-08-25 18:06:34','---\nid:\n- \n- 4\nhuman_id:\n- \n- 7\ndata:\n- \n- \"Height: 60 inches\\r\\nWeight: 180 lbs\"\n'),
	(44,'Visit',10,'update','3','---\nid: 10\nhuman_id: 7\nvisit_type_id: 1\ndiagnosis: Disease A\nnote: \ncreated_at: 2017-08-25 17:41:31.000000000 Z\nupdated_at: 2017-08-25 17:41:31.000000000 Z\nage: 26\nvisit_date: \n','2017-08-25 18:06:34','---\nnote:\n- \n- \'\'\n'),
	(45,'Human',8,'update','3','---\nid: 8\naccession: Subject0008\nother_ids: \npopulation_id: 1\ngender_id: 1\nnote: \nstatus_id: 1\ncreated_at: 2017-08-25 17:38:48.000000000 Z\nupdated_at: 2017-08-25 17:38:48.000000000 Z\n','2017-08-25 18:09:12','---\nother_ids:\n- \n- \'\'\nnote:\n- \n- \'\'\n'),
	(46,'Demography',5,'create','3',NULL,'2017-08-25 18:09:12','---\nid:\n- \n- 5\nhuman_id:\n- \n- 8\ndata:\n- \n- \"Height: 68 inches\\r\\nWeight: 140 lbs\\r\\nHandedness: right\\r\\nPhysical condition:\n  diabetes\\r\\nSmoking?: Yes\\r\\nPack per day: 0.5\\r\\nCurrent medication: none\\r\\nPast\n  medication: Aspirin\\r\\nFamily History: Unknown\\r\\nDate of diagnosis: 2016-01-05\"\n'),
	(47,'Visit',11,'create','3',NULL,'2017-08-25 18:09:12','---\nid:\n- \n- 11\nhuman_id:\n- \n- 8\nvisit_type_id:\n- \n- 2\ndiagnosis:\n- \n- disease C\nnote:\n- \n- \'\'\nage:\n- \n- 34\nvisit_date:\n- \n- 2016-03-02\n'),
	(48,'Project',6,'update','2','---\nid: 6\nname: Chip-Seq project\ndescription: \'\'\nPI: Tom\nmembers: Mary\ncreated_at: 2017-08-25 17:56:05.000000000 Z\nupdated_at: 2017-08-25 17:56:05.000000000 Z\nprogress: 10\n','2017-08-25 18:10:44','---\nmembers:\n- Mary\n- Mary,John\n');

/*!40000 ALTER TABLE `versions` ENABLE KEYS */;
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
	(1,1,1,'','','2017-08-25 17:41:31','2017-08-25 18:04:21',23,NULL),
	(2,2,1,'disease A','','2017-08-25 17:41:31','2017-08-25 18:05:09',32,NULL),
	(3,2,2,'disease A','','2017-08-25 17:41:31','2017-08-25 18:05:09',33,NULL),
	(4,3,1,'disease A','didn\'t get blood draw','2017-08-25 17:41:31','2017-08-25 17:41:31',22,NULL),
	(5,3,2,'disease A',NULL,'2017-08-25 17:41:31','2017-08-25 17:41:31',23,NULL),
	(6,4,1,'','','2017-08-25 17:41:31','2017-08-25 18:06:02',18,NULL),
	(7,4,2,'','','2017-08-25 17:41:31','2017-08-25 18:06:02',19,NULL),
	(8,5,1,'disease A',NULL,'2017-08-25 17:41:31','2017-08-25 17:41:31',20,NULL),
	(9,6,1,NULL,NULL,'2017-08-25 17:41:31','2017-08-25 17:41:31',34,NULL),
	(10,7,1,'Disease A','','2017-08-25 17:41:31','2017-08-25 18:06:34',26,NULL),
	(11,8,2,'disease C','','2017-08-25 18:09:12','2017-08-25 18:09:12',34,'2016-03-02');

/*!40000 ALTER TABLE `visits` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
