-- MySQL dump 10.13  Distrib 8.0.41, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: mysql
-- ------------------------------------------------------
-- Server version	8.0.41-google

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `personal_finance`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `personal_finance` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `personal_finance`;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `type` enum('income','expense') NOT NULL,
  `description` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transactions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `amount` decimal(15,2) NOT NULL,
  `type` enum('income','expense') NOT NULL,
  `description` text,
  `transaction_date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_transactions_date` (`transaction_date`),
  KEY `idx_transactions_type` (`type`),
  KEY `idx_transactions_user` (`user_id`),
  CONSTRAINT `transactions_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactions`
--

LOCK TABLES `transactions` WRITE;
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
INSERT INTO `transactions` VALUES (53,41,'Makan siang di restaurant',250000.00,'income','Makan siang di restaurant yang enak','2025-10-31','2025-11-04 00:53:44','2025-11-04 00:53:44'),(54,40,'Makan siang',50000.00,'expense','restaurant yang enak','2025-10-31','2025-11-04 00:56:21','2025-11-04 00:56:21'),(55,27,'Gaji',3500000.00,'income','Gaji','2025-11-01','2025-11-04 01:00:12','2025-11-04 01:00:12'),(56,27,'hasil nabung',35000.00,'income','hasil nabung','2025-11-06','2025-11-04 01:11:30','2025-11-04 02:39:50'),(57,27,'makan malam',35000.00,'expense','makan malam','2025-11-05','2025-11-04 01:12:51','2025-11-04 01:12:51'),(59,27,'makan malam',30500.00,'expense','makan malam','2025-11-05','2025-11-04 01:21:55','2025-11-04 02:39:40'),(60,41,'Makan siang di restaurant',250000.00,'expense','Makan siang di restaurant yang enak','2025-10-31','2025-11-04 01:28:26','2025-11-04 01:28:26'),(61,27,'main',55000.00,'expense','main','2025-11-05','2025-11-04 02:57:21','2025-11-04 02:57:21'),(62,27,'utang',36000.00,'income','utang','2025-11-04','2025-11-04 02:59:27','2025-11-04 02:59:27'),(63,44,'uang jajan',50000.00,'income','uang jajan','2025-11-04','2025-11-04 03:22:41','2025-11-04 03:22:41'),(64,44,'test',5000.00,'income','test','2025-11-04','2025-11-04 03:23:16','2025-11-04 03:23:16'),(65,27,'duit kompensasi',300000.00,'income','duit kompensasi','2025-10-08','2025-11-09 13:42:09','2025-11-09 13:42:09'),(67,44,'test',20000.00,'expense','test','2025-11-09','2025-11-09 14:02:48','2025-11-09 14:02:48'),(70,45,'makan',30000.00,'expense','makan','2025-11-10','2025-11-10 06:31:34','2025-11-10 06:31:34'),(71,45,'jatah',1000000.00,'income','jatah','2025-11-10','2025-11-10 06:31:59','2025-11-10 06:31:59'),(72,45,'bensin',12000.00,'expense','bensin','2025-11-10','2025-11-10 06:32:13','2025-11-10 06:32:13'),(73,45,'topup',20000.00,'expense','topup','2025-11-04','2025-11-10 06:32:32','2025-11-10 06:32:32'),(74,45,'dikasih',100000.00,'income','dikasih','2025-11-06','2025-11-10 06:32:57','2025-11-10 06:32:57'),(76,27,'padang',13000.00,'expense','padang','2025-11-10','2025-11-10 10:51:08','2025-11-10 10:51:08'),(77,45,'jajan',2000.00,'expense','jajan','2025-11-11','2025-11-10 11:20:58','2025-11-10 11:23:58'),(79,46,'jajan',10000.00,'income','jajan','2025-11-10','2025-11-10 14:48:19','2025-11-10 14:48:19'),(80,46,'gaji',1000000.00,'income','gaji','2025-10-25','2025-11-10 23:02:20','2025-11-10 23:02:20'),(81,46,'jajan',1000.00,'expense','jajan','2025-11-11','2025-11-10 23:05:34','2025-11-10 23:05:34'),(82,46,'jajan',9000.00,'expense','jajan','2025-11-13','2025-11-10 23:05:51','2025-11-10 23:05:51'),(83,47,'uang bulanan',1000000.00,'income','uang bulanan','2025-11-11','2025-11-10 23:54:56','2025-11-10 23:54:56'),(86,49,'beli kuota',30000.00,'expense','beli kuota','2025-11-06','2025-11-11 02:37:46','2025-11-11 02:38:27'),(88,27,'waw',20000.00,'income','waw','2025-11-11','2025-11-11 05:06:57','2025-11-11 05:06:57'),(90,50,'Makan siang di restaurant',250000.00,'income','Makan siang di restaurant yang enak','2025-10-31','2025-11-13 04:20:14','2025-11-13 04:20:14');
/*!40000 ALTER TABLE `transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `uid` varchar(255) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `url_foto` varchar(255) DEFAULT NULL,
  `foto_filename` varchar(255) DEFAULT NULL,
  `dibuat_pada` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid` (`uid`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (16,'c888c9a4-3f6e-4e24-9657-7cc40b168258','King','super@admin.com','$2b$12$EXBfLoe3vhC/iWTYko4ow.IA9d5nd5hHjHPhTcvcA1h5tBa6Cfex.',NULL,NULL,'2025-11-01 06:10:53'),(17,'129fd6ec-3947-48b7-9d83-e79ba8c98167','test','memetsss@example.com','$2b$12$qkS8GDmy1sjs04sEdkRHc.MMew.Y/6fcQxXbei7n97M5JVg0P7EHK',NULL,NULL,'2025-11-01 06:11:06'),(18,'ec64282c-4e3c-4475-83c6-1807a052fb94','Siti Rahayusss','siti.rahayuss@example.com','$2b$12$OiO7EQ6Mm3iVGQ8B0PabuukMeSaPac3esLHKmp3eiLcCFNkeYooy6','http://personal-finance-api-114056315885.asia-southeast2.run.app/uploads/profile-photos/profile-1761983592084-483053601.jpeg','profile-1761983592084-483053601.jpeg','2025-11-01 07:53:12'),(19,'d6f990ee-e637-4393-8d5e-5d34dd99569c','Siti Rahayu','siti.rahayu@example.com','$2b$12$TM3ujFVVLGV1m/u34qhxBOuK2TGuPzCH3ZbrKfDwSvC/SwDqYWN7K',NULL,NULL,'2025-11-01 11:24:09'),(20,'806c8331-1e8a-435e-b754-e1b19d904cda','Ahmad Nugraha','ahmad.nugraha@example.com','$2b$12$yHN9ErRMfG1Z0PYe1R62ouVl1pefRDusl5qTP8dj1AoehqOCHYm86',NULL,NULL,'2025-11-01 11:26:42'),(21,'6519dc34-af66-4050-8cd3-f74160451392','Upiyah','upiyah280@gmail.com','$2b$12$H/YGA6G1oURg.vxeRU1jQeDoEaBG2opRtKj78ETi/TgkHLTxGwCVi',NULL,NULL,'2025-11-01 11:43:56'),(22,'82df2db2-f672-45ca-bb11-a8b03ab2880b','akjsb','test1@gmail.com','$2b$12$as4BJOE6P46WFoekNOi8/.ITapISa8Wd.5MZB4NYPqtskr4f3qdGO',NULL,NULL,'2025-11-01 11:56:12'),(23,'ab25d655-84c5-4ca4-8eec-d777f289842c','test2','test2@gmail.com','$2b$12$wP1mIXtp/MuO2ww0GqpqY.ii3pqtlc6gKQILMAHqjSrLHIQBGNaci',NULL,NULL,'2025-11-01 12:04:56'),(24,'2a31978c-6d24-445d-9eee-967de3b572c6','Test3','test3@gmail.com','$2b$12$OtAGdjxM56aUasGpBKzWF.b3qjR28WvMEqS8cnsuRailR6sVByX5W',NULL,NULL,'2025-11-01 12:09:55'),(25,'9faae084-b05c-45fa-b3cd-7fa238694413','UPIYAH','upiy20@gmail.com','$2b$12$mYvIBZ3Vl/ReVurEZN3l1ug7CeMpkZmbRMKAXIYobc7tLOWjvXgu2',NULL,NULL,'2025-11-01 12:15:02'),(26,'6bd2a36d-9953-415e-92c5-36325dcbcfbd','madel','madel@gmail.com','$2b$12$U1LFYc70xI2nFl5IMahEK.JkA1A.4X815IpRYD8Him7nT8ithZii6',NULL,NULL,'2025-11-01 12:25:06'),(27,'9226363e-c072-40e1-9702-2766680b5403','sahrul','sahrul@test.com','$2b$12$X/4kDdaPtNJxAa/5qxlXqenXddYhiXnLVMD8Qz4SmFYh3jbN5Ax6K',NULL,NULL,'2025-11-01 14:51:59'),(28,'69b2df24-1516-4a5e-806f-bf65ae46a972','test','test@gmail.com','$2b$12$VuNmejtoeKVqG7VEzeuxqOiySY7au4siOhY7bPMYsnjOK.GV7ztGm',NULL,NULL,'2025-11-02 03:11:41'),(29,'743bcce7-2b04-41d2-86f3-6e98a9f9e2f4','upiyah','upiyah@gmail.com','$2b$12$jCQU4mjqalP71RdnMuKrquhE8bsCKQUDkDoA4NAbpSw1jW/8zyOhu',NULL,NULL,'2025-11-02 03:27:53'),(30,'a9295de1-5b67-424f-8e18-db35540f8fa6','Madelyra','madelyra@gmail.com','$2b$12$GhInsQu1AzTEfdINjkNbk.tyKLaNOFvL.CEeDp/t.bnJDFJchdB52',NULL,NULL,'2025-11-02 05:10:56'),(31,'14b4a025-6671-4cad-b812-39d928fcac42','sahrul1','sahrul1@test.com','$2b$12$hU3R8/qOH3XZA0/kjONT6esaVx6bqVxvMD7NxttImNqsd6SfzcMjy',NULL,NULL,'2025-11-02 08:03:13'),(32,'c746e175-7fc3-4582-94c8-d7a9bd22aaa0','Putra','putra@gmail.com','$2b$12$p5IIgJdazkR0SXoIgHSq.uZW0t2EmGhakTAmqCDi3htw/tXAjbwgG',NULL,NULL,'2025-11-02 09:50:55'),(33,'17ad35a7-873b-4f00-89eb-933773f7613b','Ahmad Nugraha','testfixbug@example.com','$2b$12$htkpJRDDp4TJ5B/BUfWWxuGsG3tuGfhTMpInBxB8tpId2YyfeuoEe',NULL,NULL,'2025-11-02 11:16:45'),(34,'373fa13d-18d2-4678-a313-13ce10e92246','sahrul123616','sahrul123616@gmail.com','$2b$12$VIsEj3BaIGu4qejr/cQbkuIUHf7EsRk6vLbxl0wqsHvZ1x81f/3wK',NULL,NULL,'2025-11-03 03:29:35'),(35,'b524ded7-6302-4c13-be00-d1d7c8565955','UPIYAH','tester1@gmail.com','$2b$12$4ZouoHV3Ay.TCysyV3fvMev7Cc85erSss/zcEAgd9jv7.LlFLU9XW',NULL,NULL,'2025-11-03 05:26:35'),(36,'4af63a87-0392-466e-abc0-3430f8778030','Upiyah','upiyah1@gmail.com','$2b$12$GVZixiuK9SHvZg0ePPgNJexAr1I4W5qDOBiW.i4uRvaP1hu2TtIC2',NULL,NULL,'2025-11-03 05:44:04'),(37,'ecff8c09-23d1-40c8-b681-38c4d74561c1','John Doe','testfixbug2@example.com','$2b$12$/VZ0kb6x0TtsAkALSNayp.rAdKNlvg1vgXcZazGwy/vzYWAM5ND/e',NULL,NULL,'2025-11-03 06:08:40'),(38,'e2909c92-17e6-473d-b463-c1226a748b8a','sahrul keren','sahrul2@test.com','$2b$12$K/44k1okhXDUO7m8eC8FE.K7Ed7TL3hYNMMTFhfE0jAvs432m0G3K',NULL,NULL,'2025-11-03 12:25:38'),(39,'027fe25c-c1fc-42c1-a468-5a7a0a894d0d','MADEL','madel@example.com','$2b$12$cTtyeaEse7iqbgDHFzlJMebN2lgQB5gsxrz16nJKiFnLmMisx.cy2',NULL,NULL,'2025-11-03 13:08:49'),(40,'2c53b83d-e65a-44fe-b9bf-f0f18e470682','Jason Nig','js@example.com','$2b$12$UX.hMDgv/EKHm0MhEeoz5.c7RG1G73PoPM4DI3b5Y3JbK0hmQXRoq',NULL,NULL,'2025-11-03 13:34:11'),(41,'49221721-57a2-4f68-865c-5563ab1f5c45','Ahmad Nugraha','ahmad.updated@example.com','$2b$12$5AUi7cHbnGBUoXzHEG6HGOtfQ7vamzz6fE.KEIaKFZoxdWtIneATi',NULL,NULL,'2025-11-03 16:00:51'),(42,'6d71b136-8fb7-4fea-b65e-9a111e2a5b81','ahmad','ahmad@mail.com','$2b$12$0gWaAv3qoFklqTaD1PKOE.O6vUg/MaMvTU3o.sgb.KRHcw2mOm8Ey',NULL,NULL,'2025-11-03 16:03:08'),(43,'dd6edf55-534a-4f7a-9ffc-220ce3dc5649','test','test6@gmail.com','$2b$12$Waid9IUF01TqQGtl1l7jlOIeWH7Bxij2/FW1gGO8Yk.D7vhj5O58C',NULL,NULL,'2025-11-04 03:20:35'),(44,'3aca7e26-b2fd-4540-a393-fcd3c9f094d8','rsms','rama@gmail.com','$2b$12$IQgOlxcXSj.fefBJb6mbmegxcGYkK4fOK3qmUlNZLsAAFG4m6qnYS',NULL,NULL,'2025-11-04 03:21:58'),(45,'471a6048-92ae-440c-9058-20252545c0d9','Upiyah','upiy@gmail.com','$2b$12$.e884yGWnon/K7tDQ.aJsO6Jxlzca0pnZ4b/F3lwfzJLWQR5b.wY.',NULL,NULL,'2025-11-10 05:54:10'),(46,'7d694714-89fe-43f9-9a79-60e3460b99dd','tester','tester@gmail.com','$2b$12$azuynnew/CpbhQCJla4H2uP9iEfjDsPUGPc8a766KPfRIOlNTdfPO',NULL,NULL,'2025-11-10 10:44:48'),(47,'9aee4523-b18b-4f70-9979-4819651ee305','Upiyah','upi@gmail.com','$2b$12$uWLyCgegMZSy7uAqQAO33.xnmAhLZk/9GSdiwQ0KQMMOMgPKPKg.a',NULL,NULL,'2025-11-10 23:53:49'),(48,'dd507e3b-749f-456c-930d-3d663f6f0286','Dev AMAT','dev@amat.com','$2b$12$N3Fv8wDgq6iLXSpM.makzuT8lDqrszURgZqkvKyHmRSXwASrcaDNu',NULL,NULL,'2025-11-11 00:28:38'),(49,'f6346063-7dcf-455b-ab33-413dfee0f29f','unsera','unsera@test.com','$2b$12$ibthsg2wArhu.hGRj0xede2ISK1hr6dFdPdY6O3EJbEhk961Tbjh.',NULL,NULL,'2025-11-11 02:36:38'),(50,'74f6351d-124a-4414-9026-7ae027709240','Unsera Dev','devunsera@example.com','$2b$12$h6FCYHSSMtFclbLmn3SaHOxK8z0IN/FWdw.KE.0xwGnwHx5pZU8S2',NULL,NULL,'2025-11-13 04:17:25'),(51,'0725b137-d9f6-4ac1-ae8a-9af32b464db3','Siti Rahayu','testbug21@example.com','$2b$12$E4mVn9VfjKgSdohoPC4hK.fdnWK44zLNhDhPgxNr2x/w5ItLyKP5m','http://personal-finance-api-114056315885.asia-southeast2.run.app/uploads/profile-photos/profile-1763007467757-137829893.jpeg','profile-1763007467757-137829893.jpeg','2025-11-13 04:17:48');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-13 10:33:41
