-- MySQL dump 10.13  Distrib 8.0.35, for Linux (x86_64)
--
-- Host: sql.freedb.tech    Database: freedb_HPcharacters
-- ------------------------------------------------------
-- Server version	8.0.35-0ubuntu0.22.04.1

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
-- Table structure for table `casas`
--

DROP TABLE IF EXISTS `casas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `casas` (
  `idCasa` int NOT NULL AUTO_INCREMENT,
  `nombreCasa` varchar(50) DEFAULT NULL,
  `fantasma` varchar(50) DEFAULT NULL,
  `fundador` varchar(50) DEFAULT NULL,
  `reliquia` varchar(50) DEFAULT NULL,
  `animal` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idCasa`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `casas`
--

LOCK TABLES `casas` WRITE;
/*!40000 ALTER TABLE `casas` DISABLE KEYS */;
INSERT INTO `casas` VALUES (1,'Hufflepuff','Fraile gordo','Helga Hufflepuff','Copa de Hufflepuff.',' tejón'),(2,'Gryffindor','Nick Casi Decapitado','Godric Griffindor ','Espada de Godric Gryffindor',' león'),(3,'Ravenclaw','Dama Gris','Rowena Ravenclaw','La diadema de Rowena Ravenclaw',' águila'),(4,'Slytherin','Barón Sanguinario','Salazar Slytherin ','Guardapelo de Salazar Slytherin',' serpiente');
/*!40000 ALTER TABLE `casas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personajes`
--

DROP TABLE IF EXISTS `personajes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personajes` (
  `idPersonaje` int NOT NULL AUTO_INCREMENT,
  `nombrePj` varchar(50) DEFAULT NULL,
  `apellido` varchar(50) DEFAULT NULL,
  `cumpleaños` date DEFAULT NULL,
  `ocupacion` varchar(50) DEFAULT NULL,
  `boggart` varchar(50) DEFAULT NULL,
  `fkCasa` int NOT NULL,
  PRIMARY KEY (`idPersonaje`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personajes`
--

LOCK TABLES `personajes` WRITE;
/*!40000 ALTER TABLE `personajes` DISABLE KEYS */;
INSERT INTO `personajes` VALUES (1,'Hermione','Granger','1979-09-19','Estudiante','Profesora McGonagall diciendole que ha suspendido ',2),(2,'Ginevra','Weasley','1981-08-11','Estudiante','Ser controlada por Lord Voldemord',2),(3,'Nymphadora','Tonks','1973-08-23','Aurora','Perder sus habilidades',1),(4,'Pomona','Sprout','1942-05-15','Profesora','Lord Voldemort',1),(5,'Bellatrix','Lestrange','1951-05-02','Mortífaga','Voldemort rechazandola',4),(6,'Narcisa','Malfoy','1955-01-03','Ama de casa','Perder a su hijo',4),(7,'Luna','Lovegood','1981-02-13','Estudiante','Ver morir a su padre',3),(8,'Cho','Chang','1979-09-01','Estudiante','Ver a Cedric recriminandola ',3);
/*!40000 ALTER TABLE `personajes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `idUser` int NOT NULL AUTO_INCREMENT,
  `email` varchar(50) DEFAULT NULL,
  `nombreUser` varchar(50) DEFAULT NULL,
  `password` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`idUser`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (4,'pepi@gmail.com','pepi','$2b$10$/s4JgegZH7il6uZLpIH6puK0nsB/yAv7sT4piMPsnhDX7Mkq0iW2m'),(5,'',NULL,NULL);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-11-15 11:28:52
