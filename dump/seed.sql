# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.7.18)
# Database: hsspm_tmp
# Generation Time: 2017-08-23 15:14:58 +0000
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



# Dump of table cohorts_humen
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cohorts_humen`;

CREATE TABLE `cohorts_humen` (
  `human_id` int(11) NOT NULL,
  `cohort_id` int(11) NOT NULL,
  KEY `index_cohorts_humen_on_human_id_and_cohort_id` (`human_id`,`cohort_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



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



# Dump of table datasets_projects
# ------------------------------------------------------------

DROP TABLE IF EXISTS `datasets_projects`;

CREATE TABLE `datasets_projects` (
  `dataset_id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  KEY `index_datasets_projects_on_dataset_id_and_project_id` (`dataset_id`,`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



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



# Dump of table humen_irbs
# ------------------------------------------------------------

DROP TABLE IF EXISTS `humen_irbs`;

CREATE TABLE `humen_irbs` (
  `human_id` int(11) NOT NULL,
  `irb_id` int(11) NOT NULL,
  KEY `index_humen_irbs_on_human_id_and_irb_id` (`human_id`,`irb_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table humen_races
# ------------------------------------------------------------

DROP TABLE IF EXISTS `humen_races`;

CREATE TABLE `humen_races` (
  `human_id` int(11) NOT NULL,
  `race_id` int(11) NOT NULL,
  KEY `index_humen_races_on_human_id_and_race_id` (`human_id`,`race_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



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




/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
