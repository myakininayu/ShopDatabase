-- MySQL dump 10.13  Distrib 8.0.23, for Win64 (x86_64)
--
-- Host: localhost    Database: clothes_shop
-- ------------------------------------------------------
-- Server version	8.0.23

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `abstract_products`
--

DROP TABLE IF EXISTS `abstract_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `abstract_products` (
  `vendor_code` int unsigned NOT NULL AUTO_INCREMENT,
  `price` int DEFAULT NULL,
  `category` varchar(45) DEFAULT NULL,
  `rating` float DEFAULT NULL,
  `model` varchar(45) DEFAULT NULL,
  `material` varchar(45) DEFAULT NULL,
  `department` varchar(45) DEFAULT NULL,
  `id_brand` int unsigned DEFAULT NULL,
  PRIMARY KEY (`vendor_code`),
  KEY `fk_abstract_products_brand_1_idx` (`id_brand`),
  CONSTRAINT `fk_abstract_products_to_brands_1` FOREIGN KEY (`id_brand`) REFERENCES `brands` (`id_brand`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abstract_products`
--

LOCK TABLES `abstract_products` WRITE;
/*!40000 ALTER TABLE `abstract_products` DISABLE KEYS */;
INSERT INTO `abstract_products` VALUES (1,1899,'Джинсы',4.5,'Mom','Деним','женский',2),(2,1599,'Рубашки',4.8,'Regular Fit','Хлопок','мужской',2),(3,3999,'Платья',4.8,'Облегающее','Трикотаж','женский',1),(4,5000,'Куртки',5,'Oversize','Кожа','мужской',5);
/*!40000 ALTER TABLE `abstract_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bookings`
--

DROP TABLE IF EXISTS `bookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookings` (
  `id_booking` int unsigned NOT NULL AUTO_INCREMENT,
  `date_time` datetime DEFAULT NULL,
  `payment_method` enum('наличные','карта') DEFAULT NULL,
  `id_client` int unsigned NOT NULL,
  `id_employee` int unsigned NOT NULL,
  PRIMARY KEY (`id_booking`),
  KEY `fk_bookings_to_employees_1_idx` (`id_employee`),
  KEY `fk_bookings_to_clients_1_idx` (`id_client`),
  CONSTRAINT `fk_bookings_to_clients_1` FOREIGN KEY (`id_client`) REFERENCES `clients` (`id_client`),
  CONSTRAINT `fk_bookings_to_employees_1` FOREIGN KEY (`id_employee`) REFERENCES `employees` (`id_employee`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookings`
--

LOCK TABLES `bookings` WRITE;
/*!40000 ALTER TABLE `bookings` DISABLE KEYS */;
INSERT INTO `bookings` VALUES (1,'2021-02-01 13:29:00','карта',3,1),(2,'2021-02-01 14:12:00','наличные',2,1),(3,'2021-02-01 18:15:00','карта',4,2);
/*!40000 ALTER TABLE `bookings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `brands`
--

DROP TABLE IF EXISTS `brands`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `brands` (
  `id_brand` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `year_of_foundation` year DEFAULT NULL,
  `country` varchar(45) DEFAULT NULL,
  `logo` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_brand`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `brands`
--

LOCK TABLES `brands` WRITE;
/*!40000 ALTER TABLE `brands` DISABLE KEYS */;
INSERT INTO `brands` VALUES (1,'HM',2006,'Швеция',NULL),(2,'Mango',1984,'Испания',NULL),(3,'Gucci',1921,'Италия',NULL),(4,'Uniqlo',1949,'Япония',NULL),(5,'Zara',1975,'Испания',NULL),(6,'Lacoste',1933,'Франция',NULL),(7,'Calvin Clein',1968,'США',NULL),(8,'Diesel',1978,'Италия',NULL);
/*!40000 ALTER TABLE `brands` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `brands_to_founders`
--

DROP TABLE IF EXISTS `brands_to_founders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `brands_to_founders` (
  `id_brand` int unsigned NOT NULL,
  `id_founder` int unsigned NOT NULL,
  PRIMARY KEY (`id_brand`,`id_founder`),
  KEY `id_founder_idx` (`id_founder`),
  CONSTRAINT `fk_brands_to_founders_brands_1` FOREIGN KEY (`id_brand`) REFERENCES `brands` (`id_brand`),
  CONSTRAINT `fk_brands_to_founders_founders_1` FOREIGN KEY (`id_founder`) REFERENCES `founders` (`id_founder`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `brands_to_founders`
--

LOCK TABLES `brands_to_founders` WRITE;
/*!40000 ALTER TABLE `brands_to_founders` DISABLE KEYS */;
INSERT INTO `brands_to_founders` VALUES (1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(6,7),(7,8),(7,9),(8,10),(8,11);
/*!40000 ALTER TABLE `brands_to_founders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clients` (
  `id_client` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `gender` enum('мужской','женский') DEFAULT NULL,
  `age` tinyint DEFAULT NULL,
  `phone` char(12) DEFAULT NULL,
  PRIMARY KEY (`id_client`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clients`
--

LOCK TABLES `clients` WRITE;
/*!40000 ALTER TABLE `clients` DISABLE KEYS */;
INSERT INTO `clients` VALUES (1,'Иванова Екатерина','женский',18,'89095647832'),(2,'Васильев Дмитрий','мужской',26,'89053498611'),(3,'Жданова Марина','женский',34,'89603439967'),(4,'Иванов Виктор','мужской',32,'89054478219'),(5,'Николаев Роман','мужской',28,'89046687321'),(6,'Сергеев Алексей','мужской',21,'89037784390'),(7,'Васильева Ольга','женский',19,'89053895422'),(8,'Обломов Дмитрий','мужской',29,'89091865683'),(9,'Егорова Наталья','женский',42,'89057870439'),(10,'Антипова Валерия','женский',28,'89617962031');
/*!40000 ALTER TABLE `clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `components`
--

DROP TABLE IF EXISTS `components`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `components` (
  `id_component` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id_component`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `components`
--

LOCK TABLES `components` WRITE;
/*!40000 ALTER TABLE `components` DISABLE KEYS */;
INSERT INTO `components` VALUES (1,'Хлопок'),(2,'Эластан'),(3,'Вискоза'),(4,'Полиэстер'),(5,'Полиамид');
/*!40000 ALTER TABLE `components` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deliveries`
--

DROP TABLE IF EXISTS `deliveries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `deliveries` (
  `id_delivery` int unsigned NOT NULL AUTO_INCREMENT,
  `address` varchar(150) NOT NULL,
  `price` int DEFAULT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id_delivery`),
  CONSTRAINT `fk_deliveries_to_bookings_1` FOREIGN KEY (`id_delivery`) REFERENCES `bookings` (`id_booking`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deliveries`
--

LOCK TABLES `deliveries` WRITE;
/*!40000 ALTER TABLE `deliveries` DISABLE KEYS */;
INSERT INTO `deliveries` VALUES (2,'Еременко,56',300,'2021-02-05 00:00:00'),(3,'Лавочкина,10',0,'2021-02-05 00:00:00');
/*!40000 ALTER TABLE `deliveries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `discount_cards`
--

DROP TABLE IF EXISTS `discount_cards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `discount_cards` (
  `id_discount_card` int unsigned NOT NULL AUTO_INCREMENT,
  `current_bonuses_amounts` smallint DEFAULT NULL,
  `date` date DEFAULT NULL,
  PRIMARY KEY (`id_discount_card`),
  CONSTRAINT `fk_discount_cards_to_clients_1` FOREIGN KEY (`id_discount_card`) REFERENCES `clients` (`id_client`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discount_cards`
--

LOCK TABLES `discount_cards` WRITE;
/*!40000 ALTER TABLE `discount_cards` DISABLE KEYS */;
INSERT INTO `discount_cards` VALUES (1,156,NULL),(2,21,NULL),(3,344,NULL),(4,2568,NULL),(5,0,NULL),(6,29,NULL),(7,430,NULL),(8,95,NULL),(9,67,NULL),(10,0,NULL);
/*!40000 ALTER TABLE `discount_cards` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `discounts_to_spendings`
--

DROP TABLE IF EXISTS `discounts_to_spendings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `discounts_to_spendings` (
  `spending` int unsigned NOT NULL,
  `%` tinyint unsigned NOT NULL,
  PRIMARY KEY (`spending`),
  UNIQUE KEY `spending_UNIQUE` (`spending`),
  UNIQUE KEY `%_UNIQUE` (`%`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discounts_to_spendings`
--

LOCK TABLES `discounts_to_spendings` WRITE;
/*!40000 ALTER TABLE `discounts_to_spendings` DISABLE KEYS */;
INSERT INTO `discounts_to_spendings` VALUES (5000,3),(10000,5),(15000,8),(20000,10),(30000,15);
/*!40000 ALTER TABLE `discounts_to_spendings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employees` (
  `id_employee` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `position` varchar(45) DEFAULT NULL,
  `salary` int DEFAULT NULL,
  `education` enum('высшее','среднее') DEFAULT NULL,
  `hiring_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id_employee`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` VALUES (1,'Полякова Ульяна','Продавец-консультант',19000,'среднее',NULL),(2,'Соколова Мария','Продавец-консультант',18000,'среднее',NULL),(3,'Сидорова Виктория','Менеджер',27000,'высшее',NULL),(4,'Анфиногенов Андрей','Менеджер',27000,'высшее',NULL),(5,'Павлова Александра','Продавец-консультант',17000,'среднее',NULL),(6,'Денисов Артем','Продавец-консультант',17000,'среднее',NULL),(7,'Золотов Евгений','Продавец-консультант',16000,'высшее',NULL),(8,'Рублева Виктория','Продавец-консультант',16000,'высшее',NULL),(9,'Карпова Елизавета','Менеджер',25000,'высшее',NULL),(10,'Афанасьев Вадим','Продавец-консультант',16000,'среднее',NULL),(11,'Каральник Игорь','Продавец-консультант',16000,'среднее',NULL);
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `example_products`
--

DROP TABLE IF EXISTS `example_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `example_products` (
  `id_example_products` int unsigned NOT NULL AUTO_INCREMENT,
  `size` char(2) DEFAULT NULL,
  `color` varchar(45) DEFAULT NULL,
  `amount` int DEFAULT NULL,
  `vendor_code` int unsigned DEFAULT NULL,
  `id_storage` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id_example_products`),
  KEY `fk_ex_products_storage_1_idx` (`id_storage`),
  KEY `fk_ex_products_vendor_code_1_idx` (`vendor_code`),
  CONSTRAINT `fk_ex_products_to_abs_products_1` FOREIGN KEY (`vendor_code`) REFERENCES `abstract_products` (`vendor_code`),
  CONSTRAINT `fk_ex_products_to_storages_1` FOREIGN KEY (`id_storage`) REFERENCES `storages` (`id_storage`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `example_products`
--

LOCK TABLES `example_products` WRITE;
/*!40000 ALTER TABLE `example_products` DISABLE KEYS */;
INSERT INTO `example_products` VALUES (1,'34','Черный',7,1,1),(2,'36','Белый',10,1,1),(3,'M','Голубой',3,2,1),(4,'L','Серый',21,2,2),(5,'M','Черный',16,3,2),(6,'38','Синий',18,1,3),(7,'L','Серый',25,2,4),(8,'S','Черный',44,3,3),(9,'M','Черный',30,3,4),(10,'M','Синий',4,4,1),(11,'M','Красный',5,4,1);
/*!40000 ALTER TABLE `example_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `example_products_to_bookings`
--

DROP TABLE IF EXISTS `example_products_to_bookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `example_products_to_bookings` (
  `id_example_product` int unsigned NOT NULL,
  `id_booking` int unsigned NOT NULL,
  `amount` tinyint NOT NULL,
  PRIMARY KEY (`id_example_product`,`id_booking`),
  KEY `fk_ex_products_to_bookings_booking_1_idx` (`id_booking`),
  CONSTRAINT `fk_ex_products_to_bookings_to_bookings_1` FOREIGN KEY (`id_booking`) REFERENCES `bookings` (`id_booking`),
  CONSTRAINT `fk_ex_products_to_bookings_to_ex_products_1` FOREIGN KEY (`id_example_product`) REFERENCES `example_products` (`id_example_products`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `example_products_to_bookings`
--

LOCK TABLES `example_products_to_bookings` WRITE;
/*!40000 ALTER TABLE `example_products_to_bookings` DISABLE KEYS */;
INSERT INTO `example_products_to_bookings` VALUES (1,1,2),(2,2,3),(3,1,2),(10,3,2),(11,3,2);
/*!40000 ALTER TABLE `example_products_to_bookings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `founders`
--

DROP TABLE IF EXISTS `founders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `founders` (
  `id_founder` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id_founder`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `founders`
--

LOCK TABLES `founders` WRITE;
/*!40000 ALTER TABLE `founders` DISABLE KEYS */;
INSERT INTO `founders` VALUES (1,'Эрлинг Перссон'),(2,'Исаак Андик'),(3,'Гуччио Гучи'),(4,'Тадаси Янаи'),(5,'Амансио Ортега'),(6,'Рене Лакост'),(7,'Андре Жилье'),(8,'Кельвин Кляйн'),(9,'Барри Шварц'),(10,'Ренцо Россо'),(11,'Андиано Голдшмид');
/*!40000 ALTER TABLE `founders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products_to_components`
--

DROP TABLE IF EXISTS `products_to_components`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products_to_components` (
  `id_product` int unsigned NOT NULL,
  `id_component` int unsigned NOT NULL,
  `%` tinyint NOT NULL,
  PRIMARY KEY (`id_product`,`id_component`),
  KEY `fk_products_to_components_component_1_idx` (`id_component`),
  CONSTRAINT `fk_products_to_components_to_abs_products_1` FOREIGN KEY (`id_product`) REFERENCES `abstract_products` (`vendor_code`),
  CONSTRAINT `fk_products_to_components_to_components_1` FOREIGN KEY (`id_component`) REFERENCES `components` (`id_component`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products_to_components`
--

LOCK TABLES `products_to_components` WRITE;
/*!40000 ALTER TABLE `products_to_components` DISABLE KEYS */;
INSERT INTO `products_to_components` VALUES (1,1,99),(1,2,1),(2,1,100),(3,3,71),(3,4,2),(3,5,27);
/*!40000 ALTER TABLE `products_to_components` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schedules`
--

DROP TABLE IF EXISTS `schedules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `schedules` (
  `id_schedule` int unsigned NOT NULL AUTO_INCREMENT,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  PRIMARY KEY (`id_schedule`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedules`
--

LOCK TABLES `schedules` WRITE;
/*!40000 ALTER TABLE `schedules` DISABLE KEYS */;
INSERT INTO `schedules` VALUES (1,'08:00:00','17:00:00'),(2,'16:00:00','22:00:00'),(3,'10:00:00','16:00:00');
/*!40000 ALTER TABLE `schedules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schedules_to_employees`
--

DROP TABLE IF EXISTS `schedules_to_employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `schedules_to_employees` (
  `id_schedule` int unsigned NOT NULL,
  `id_employee` int unsigned NOT NULL,
  `week_day` tinyint DEFAULT NULL,
  PRIMARY KEY (`id_schedule`,`id_employee`),
  KEY `fk_schedules_to_employees_to_employees_1_idx` (`id_employee`),
  CONSTRAINT `fk_schedules_to_employees_to_employees_1` FOREIGN KEY (`id_employee`) REFERENCES `employees` (`id_employee`),
  CONSTRAINT `fk_schedules_to_employees_to_schedules_1` FOREIGN KEY (`id_schedule`) REFERENCES `schedules` (`id_schedule`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedules_to_employees`
--

LOCK TABLES `schedules_to_employees` WRITE;
/*!40000 ALTER TABLE `schedules_to_employees` DISABLE KEYS */;
INSERT INTO `schedules_to_employees` VALUES (1,1,1),(1,3,1),(2,2,1);
/*!40000 ALTER TABLE `schedules_to_employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `storages`
--

DROP TABLE IF EXISTS `storages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `storages` (
  `id_storage` int unsigned NOT NULL AUTO_INCREMENT,
  `address` varchar(150) NOT NULL,
  `type` enum('склад','магазин') DEFAULT NULL,
  PRIMARY KEY (`id_storage`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `storages`
--

LOCK TABLES `storages` WRITE;
/*!40000 ALTER TABLE `storages` DISABLE KEYS */;
INSERT INTO `storages` VALUES (1,'Репина,15','магазин'),(2,'Библиотечная,9','магазин'),(3,'Землячки,48','склад'),(4,'Штеменко,19','склад');
/*!40000 ALTER TABLE `storages` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-04-01 21:37:29
