
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
DROP TABLE IF EXISTS `admin_backoffice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin_backoffice` (
  `id_usuario` int(11) NOT NULL,
  PRIMARY KEY (`id_usuario`),
  CONSTRAINT `admin_backoffice_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `admin_backoffice` WRITE;
/*!40000 ALTER TABLE `admin_backoffice` DISABLE KEYS */;
INSERT INTO `admin_backoffice` VALUES (1);
/*!40000 ALTER TABLE `admin_backoffice` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `barrendero`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `barrendero` (
  `id_usuario` int(11) NOT NULL,
  `fecha_aprobacion` datetime DEFAULT NULL,
  PRIMARY KEY (`id_usuario`),
  CONSTRAINT `barrendero_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `barrendero` WRITE;
/*!40000 ALTER TABLE `barrendero` DISABLE KEYS */;
INSERT INTO `barrendero` VALUES (15,NULL),(16,NULL),(17,NULL),(18,NULL),(19,NULL),(20,NULL),(21,NULL),(22,NULL),(23,NULL),(24,NULL),(25,NULL),(26,NULL),(27,NULL),(28,NULL),(29,NULL),(30,NULL),(31,'2026-09-06 22:18:13'),(32,'2026-09-06 22:18:13'),(33,'2026-09-06 22:18:13'),(34,'2026-09-06 22:18:13'),(35,'2026-09-06 22:18:13'),(36,'2026-09-09 06:32:23'),(37,'2026-09-09 06:37:18');
/*!40000 ALTER TABLE `barrendero` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `camion_asignaciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `camion_asignaciones` (
  `id_asignacion` int(11) NOT NULL AUTO_INCREMENT,
  `id_camion` int(11) NOT NULL,
  `id_chofer` int(11) DEFAULT NULL,
  `id_cuadrilla` varchar(20) DEFAULT NULL,
  `id_ruta` int(11) DEFAULT NULL,
  `fecha_asignacion` datetime NOT NULL DEFAULT current_timestamp(),
  `fecha_finalizacion` datetime DEFAULT NULL,
  `estado` varchar(30) DEFAULT NULL,
  `estado_ruta` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id_asignacion`),
  KEY `id_camion` (`id_camion`),
  KEY `id_chofer` (`id_chofer`),
  KEY `id_cuadrilla` (`id_cuadrilla`),
  KEY `id_ruta` (`id_ruta`),
  CONSTRAINT `camion_asignaciones_ibfk_1` FOREIGN KEY (`id_camion`) REFERENCES `camiones` (`id_camion`) ON DELETE CASCADE,
  CONSTRAINT `camion_asignaciones_ibfk_2` FOREIGN KEY (`id_chofer`) REFERENCES `chofer` (`id_usuario`),
  CONSTRAINT `camion_asignaciones_ibfk_3` FOREIGN KEY (`id_cuadrilla`) REFERENCES `cuadrilla` (`id_cuadrilla`),
  CONSTRAINT `camion_asignaciones_ibfk_4` FOREIGN KEY (`id_ruta`) REFERENCES `rutas` (`id_ruta`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `camion_asignaciones` WRITE;
/*!40000 ALTER TABLE `camion_asignaciones` DISABLE KEYS */;
INSERT INTO `camion_asignaciones` VALUES (1,5,8,'B-02',9,'2026-09-08 16:41:34',NULL,'Activa','Asignada'),(2,6,9,NULL,16,'2026-09-08 16:41:34',NULL,'Activa','Asignada'),(3,7,10,NULL,NULL,'2026-09-08 16:41:34',NULL,'Activa',NULL),(4,8,11,'CH_03',9,'2026-09-08 16:41:34',NULL,'Activa','Asignada');
/*!40000 ALTER TABLE `camion_asignaciones` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `camiones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `camiones` (
  `id_camion` int(11) NOT NULL AUTO_INCREMENT,
  `matricula` varchar(20) NOT NULL,
  `tipo` varchar(30) NOT NULL,
  `estado` varchar(50) NOT NULL,
  `marca` varchar(50) DEFAULT NULL,
  `modelo` varchar(50) DEFAULT NULL,
  `chasis` varchar(100) DEFAULT NULL,
  `km_total` decimal(12,2) DEFAULT 0.00,
  `ult_carga_combustible` datetime DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT 1,
  `km_en_turno` decimal(10,2) DEFAULT 0.00,
  `tiempo_activo` time DEFAULT '00:00:00',
  `gps` varchar(255) DEFAULT NULL,
  `capacidad_kg` decimal(10,2) DEFAULT NULL,
  `peso_recolectado_kg` decimal(10,2) DEFAULT 0.00,
  `contenedores_asignados` int(11) DEFAULT 0,
  `contenedores_recolectados` int(11) DEFAULT 0,
  `turno` varchar(30) DEFAULT NULL,
  `id_chofer` int(11) DEFAULT NULL,
  `id_cuadrilla` varchar(20) DEFAULT NULL,
  `id_ruta` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_camion`),
  UNIQUE KEY `matricula` (`matricula`),
  UNIQUE KEY `chasis` (`chasis`),
  KEY `tipo` (`tipo`),
  KEY `id_chofer` (`id_chofer`),
  KEY `id_cuadrilla` (`id_cuadrilla`),
  KEY `id_ruta` (`id_ruta`),
  CONSTRAINT `camiones_ibfk_1` FOREIGN KEY (`tipo`) REFERENCES `tipo_residuo` (`tipo`),
  CONSTRAINT `camiones_ibfk_2` FOREIGN KEY (`id_chofer`) REFERENCES `chofer` (`id_usuario`),
  CONSTRAINT `camiones_ibfk_3` FOREIGN KEY (`id_cuadrilla`) REFERENCES `cuadrilla` (`id_cuadrilla`),
  CONSTRAINT `camiones_ibfk_4` FOREIGN KEY (`id_ruta`) REFERENCES `rutas` (`id_ruta`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `camiones` WRITE;
/*!40000 ALTER TABLE `camiones` DISABLE KEYS */;
INSERT INTO `camiones` VALUES (5,'SBK-3265','mixto','Recolectando','Scania','P250','CH-SBK-3265-001',134567.00,'2026-07-23 00:00:00',1,65.00,'06:34:00','CH_102',8000.00,3502.56,62,25,'Nocturno',8,'B-02',9),(6,'SAE-5268','reciclaje','En circuito','Iveco','Eurocargo','CH-SAE-5268-002',98320.00,'2026-07-23 00:00:00',1,76.40,'05:48:00','C_102',7000.00,2100.10,48,31,'Nocturno',9,NULL,16),(7,'SCE-1235','mixto','En base','Volkswagen','Constellation','CH-SCE-1235-003',110845.00,'2026-07-22 00:00:00',1,0.00,'00:00:00','CH_114',8000.00,0.00,0,0,'Nocturno',10,NULL,NULL),(8,'SDT-5632','general','Dirigiéndose a vertedero','Scania','P280','CH-SDT-5632-004',145230.00,'2026-07-23 00:00:00',1,128.10,'06:12:00','CH_102',8000.00,7250.00,58,58,'Nocturno',11,'CH_03',9);
/*!40000 ALTER TABLE `camiones` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `chofer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chofer` (
  `id_usuario` int(11) NOT NULL,
  `fecha_aprobacion` datetime DEFAULT NULL,
  `licencia` varchar(50) NOT NULL,
  PRIMARY KEY (`id_usuario`),
  CONSTRAINT `chofer_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `chofer` WRITE;
/*!40000 ALTER TABLE `chofer` DISABLE KEYS */;
INSERT INTO `chofer` VALUES (5,'2026-09-05 21:11:28','CAT-C-DEMO'),(8,'2026-09-06 08:19:34','CAT-C-3265'),(9,'2026-09-06 08:19:36','CAT-C-5268'),(10,'2026-09-06 08:19:36','CAT-C-1235'),(11,'2026-09-06 08:19:37','CAT-C-5632');
/*!40000 ALTER TABLE `chofer` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `circuitos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `circuitos` (
  `id_circuito` varchar(30) NOT NULL,
  `municipio` varchar(100) DEFAULT NULL,
  `zona` varchar(100) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `estado` varchar(30) NOT NULL DEFAULT 'activo',
  PRIMARY KEY (`id_circuito`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `circuitos` WRITE;
/*!40000 ALTER TABLE `circuitos` DISABLE KEYS */;
INSERT INTO `circuitos` VALUES ('A_101','A',NULL,NULL,'activo'),('A_102','A',NULL,NULL,'activo'),('A_103','A',NULL,NULL,'activo'),('B_01','B',NULL,NULL,'activo'),('B_02','B',NULL,NULL,'activo'),('B_03','B',NULL,NULL,'activo'),('B_04','B',NULL,NULL,'activo'),('B_05','B',NULL,NULL,'activo'),('B_06','B',NULL,NULL,'activo'),('B_7','B',NULL,NULL,'activo'),('C_102','C',NULL,NULL,'activo'),('CH_102','CH',NULL,NULL,'activo'),('CH_105','CH',NULL,NULL,'activo'),('CH_108','CH',NULL,NULL,'activo'),('CH_109','CH',NULL,NULL,'activo'),('CH_114','CH',NULL,NULL,'activo'),('CH_115','CH',NULL,NULL,'activo'),('D_101','D',NULL,NULL,'activo'),('D_102','D',NULL,NULL,'activo'),('D_103','D',NULL,NULL,'activo'),('E_102','E',NULL,NULL,'activo'),('E_103','E',NULL,NULL,'activo'),('E_106','E',NULL,NULL,'activo'),('F_101','F',NULL,NULL,'activo'),('F_102','F',NULL,NULL,'activo'),('F_103','F',NULL,NULL,'activo'),('G_101','G',NULL,NULL,'activo'),('G_102','G',NULL,NULL,'activo'),('G_103','G',NULL,NULL,'activo');
/*!40000 ALTER TABLE `circuitos` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `contenedores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contenedores` (
  `id_contenedor` int(11) NOT NULL AUTO_INCREMENT,
  `codigo` varchar(50) NOT NULL,
  `modelo` varchar(100) DEFAULT NULL,
  `tipo` varchar(30) NOT NULL,
  `capacidad` decimal(10,2) DEFAULT NULL,
  `estado` varchar(30) NOT NULL,
  `dias_sin_recoleccion` int(11) DEFAULT 0,
  `id_ubicacion` int(11) DEFAULT NULL,
  `circuito` varchar(30) DEFAULT NULL,
  `ultimo_registro` date DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_contenedor`),
  UNIQUE KEY `codigo` (`codigo`),
  KEY `id_ubicacion` (`id_ubicacion`),
  KEY `tipo` (`tipo`),
  KEY `fk_contenedores_circuito` (`circuito`),
  CONSTRAINT `contenedores_ibfk_1` FOREIGN KEY (`id_ubicacion`) REFERENCES `ubicacion` (`id_ubicacion`),
  CONSTRAINT `contenedores_ibfk_3` FOREIGN KEY (`tipo`) REFERENCES `tipo_residuo` (`tipo`),
  CONSTRAINT `fk_contenedores_circuito` FOREIGN KEY (`circuito`) REFERENCES `circuitos` (`id_circuito`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=291 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `contenedores` WRITE;
/*!40000 ALTER TABLE `contenedores` DISABLE KEYS */;
INSERT INTO `contenedores` VALUES (1,'CONT-B01-01','Ecopunto','general',3.00,'funcional',2,1,'B_01','2026-09-05',1),(2,'CONT-B01-02','EASY','reciclaje',2.25,'funcional',2,2,'B_01','2026-09-05',1),(3,'CONT-B01-03','Metálico','mixto',3.00,'funcional',4,3,'B_01','2026-09-05',1),(4,'CONT-B01-04','Ecopunto','general',3.00,'funcional',4,4,'B_01','2026-09-05',1),(5,'CONT-B01-05','EASY','reciclaje',2.25,'funcional',4,5,'B_01','2026-09-05',1),(6,'CONT-B01-06','Metálico','mixto',3.00,'funcional',6,6,'B_01','2026-09-05',1),(7,'CONT-B01-07','Ecopunto','general',3.00,'funcional',6,7,'B_01','2026-09-05',1),(8,'CONT-B01-08','EASY','reciclaje',2.25,'funcional',6,8,'B_01','2026-09-03',1),(9,'CONT-B01-09','Metálico','mixto',3.00,'funcional',6,9,'B_01','2026-09-03',1),(10,'CONT-B01-10','Ecopunto','general',3.00,'roto',6,10,'B_01','2026-09-01',1),(11,'CONT-B02-01','Ecopunto','general',3.00,'funcional',2,11,'B_02','2026-09-05',1),(12,'CONT-B02-02','EASY','reciclaje',2.25,'funcional',2,12,'B_02','2026-09-05',1),(13,'CONT-B02-03','Metálico','mixto',3.00,'funcional',2,13,'B_02','2026-09-05',1),(14,'CONT-B02-04','Ecopunto','general',3.00,'funcional',2,14,'B_02','2026-09-05',1),(15,'CONT-B02-05','EASY','reciclaje',2.25,'funcional',2,15,'B_02','2026-09-03',1),(16,'CONT-B02-06','Metálico','mixto',3.00,'funcional',2,16,'B_02','2026-09-03',1),(17,'CONT-B02-07','Ecopunto','general',3.00,'funcional',2,17,'B_02','2026-09-03',1),(18,'CONT-B02-08','EASY','reciclaje',2.25,'funcional',4,18,'B_02','2026-09-03',1),(19,'CONT-B02-09','Metálico','mixto',3.00,'desbordado',4,19,'B_02','2026-09-01',1),(20,'CONT-B02-10','Ecopunto','general',3.00,'roto',6,20,'B_02','2026-09-01',1),(21,'CONT-B03-01','Ecopunto','general',3.00,'funcional',2,21,'B_03','2026-09-05',1),(22,'CONT-B03-02','EASY','reciclaje',2.25,'funcional',2,22,'B_03','2026-09-05',1),(23,'CONT-B03-03','Metálico','mixto',3.00,'funcional',4,23,'B_03','2026-09-03',1),(24,'CONT-B03-04','Ecopunto','general',3.00,'funcional',4,24,'B_03','2026-09-03',1),(25,'CONT-B03-05','EASY','reciclaje',2.25,'funcional',4,25,'B_03','2026-09-03',1),(26,'CONT-B03-06','Metálico','mixto',3.00,'roto',6,26,'B_03','2026-09-01',1),(27,'CONT-B03-07','Ecopunto','general',3.00,'desbordado',6,27,'B_03','2026-09-01',1),(28,'CONT-B03-08','EASY','reciclaje',2.25,'roto',6,28,'B_03','2026-09-01',1),(29,'CONT-B03-09','Metálico','mixto',3.00,'desbordado',6,29,'B_03','2026-09-01',1),(30,'CONT-B03-10','Ecopunto','general',3.00,'roto',6,30,'B_03','2026-09-01',1),(31,'CONT-B04-01','Ecopunto','general',3.00,'funcional',2,31,'B_04','2026-09-05',1),(32,'CONT-B04-02','EASY','reciclaje',2.25,'funcional',2,32,'B_04','2026-09-05',1),(33,'CONT-B04-03','Metálico','mixto',3.00,'funcional',2,33,'B_04','2026-09-05',1),(34,'CONT-B04-04','Ecopunto','general',3.00,'funcional',2,34,'B_04','2026-09-05',1),(35,'CONT-B04-05','EASY','reciclaje',2.25,'funcional',2,35,'B_04','2026-09-05',1),(36,'CONT-B04-06','Metálico','mixto',3.00,'funcional',2,36,'B_04','2026-09-05',1),(37,'CONT-B04-07','Ecopunto','general',3.00,'funcional',2,37,'B_04','2026-09-05',1),(38,'CONT-B04-08','EASY','reciclaje',2.25,'funcional',4,38,'B_04','2026-09-05',1),(39,'CONT-B04-09','Metálico','mixto',3.00,'funcional',4,39,'B_04','2026-09-03',1),(40,'CONT-B04-10','Ecopunto','general',3.00,'funcional',6,40,'B_04','2026-09-03',1),(41,'CONT-CH102-01','Ecopunto','general',3.00,'funcional',2,41,'CH_102','2026-09-05',1),(42,'CONT-CH102-02','EASY','reciclaje',2.25,'funcional',2,42,'CH_102','2026-09-05',1),(43,'CONT-CH102-03','Metálico','mixto',3.00,'funcional',4,43,'CH_102','2026-09-05',1),(44,'CONT-CH102-04','Ecopunto','general',3.00,'funcional',4,44,'CH_102','2026-09-05',1),(45,'CONT-CH102-05','EASY','reciclaje',2.25,'funcional',4,45,'CH_102','2026-09-05',1),(46,'CONT-CH102-06','Metálico','mixto',3.00,'funcional',6,46,'CH_102','2026-09-03',1),(47,'CONT-CH102-07','Ecopunto','general',3.00,'funcional',6,47,'CH_102','2026-09-03',1),(48,'CONT-CH102-08','EASY','reciclaje',2.25,'funcional',6,48,'CH_102','2026-09-03',1),(49,'CONT-CH102-09','Metálico','mixto',3.00,'desbordado',6,49,'CH_102','2026-09-01',1),(50,'CONT-CH102-10','Ecopunto','general',3.00,'roto',6,50,'CH_102','2026-09-01',1),(51,'CONT-CH105-01','Ecopunto','general',3.00,'funcional',2,51,'CH_105','2026-09-05',1),(52,'CONT-CH105-02','EASY','reciclaje',2.25,'funcional',2,52,'CH_105','2026-09-05',1),(53,'CONT-CH105-03','Metálico','mixto',3.00,'funcional',2,53,'CH_105','2026-09-05',1),(54,'CONT-CH105-04','Ecopunto','general',3.00,'funcional',2,54,'CH_105','2026-09-03',1),(55,'CONT-CH105-05','EASY','reciclaje',2.25,'funcional',2,55,'CH_105','2026-09-03',1),(56,'CONT-CH105-06','Metálico','mixto',3.00,'funcional',2,56,'CH_105','2026-09-03',1),(57,'CONT-CH105-07','Ecopunto','general',3.00,'desbordado',2,57,'CH_105','2026-09-01',1),(58,'CONT-CH105-08','EASY','reciclaje',2.25,'roto',4,58,'CH_105','2026-09-01',1),(59,'CONT-CH105-09','Metálico','mixto',3.00,'desbordado',4,59,'CH_105','2026-09-01',1),(60,'CONT-CH105-10','Ecopunto','general',3.00,'roto',6,60,'CH_105','2026-09-01',1),(61,'CONT-CH108-01','Ecopunto','general',3.00,'funcional',2,61,'CH_108','2026-09-05',1),(62,'CONT-CH108-02','EASY','reciclaje',2.25,'funcional',2,62,'CH_108','2026-09-05',1),(63,'CONT-CH108-03','Metálico','mixto',3.00,'funcional',4,63,'CH_108','2026-09-05',1),(64,'CONT-CH108-04','Ecopunto','general',3.00,'funcional',4,64,'CH_108','2026-09-05',1),(65,'CONT-CH108-05','EASY','reciclaje',2.25,'funcional',4,65,'CH_108','2026-09-05',1),(66,'CONT-CH108-06','Metálico','mixto',3.00,'funcional',6,66,'CH_108','2026-09-05',1),(67,'CONT-CH108-07','Ecopunto','general',3.00,'funcional',6,67,'CH_108','2026-09-03',1),(68,'CONT-CH108-08','EASY','reciclaje',2.25,'funcional',6,68,'CH_108','2026-09-03',1),(69,'CONT-CH108-09','Metálico','mixto',3.00,'funcional',6,69,'CH_108','2026-09-03',1),(70,'CONT-CH108-10','Ecopunto','general',3.00,'roto',6,70,'CH_108','2026-09-01',1),(71,'CONT-CH109-01','Ecopunto','general',3.00,'funcional',2,71,'CH_109','2026-09-05',1),(72,'CONT-CH109-02','EASY','reciclaje',2.25,'funcional',2,72,'CH_109','2026-09-05',1),(73,'CONT-CH109-03','Metálico','mixto',3.00,'funcional',4,73,'CH_109','2026-09-05',1),(74,'CONT-CH109-04','Ecopunto','general',3.00,'funcional',4,74,'CH_109','2026-09-03',1),(75,'CONT-CH109-05','EASY','reciclaje',2.25,'funcional',4,75,'CH_109','2026-09-03',1),(76,'CONT-CH109-06','Metálico','mixto',3.00,'funcional',6,76,'CH_109','2026-09-03',1),(77,'CONT-CH109-07','Ecopunto','general',3.00,'funcional',6,77,'CH_109','2026-09-03',1),(78,'CONT-CH109-08','EASY','reciclaje',2.25,'funcional',6,78,'CH_109','2026-09-03',1),(79,'CONT-CH109-09','Metálico','mixto',3.00,'desbordado',6,79,'CH_109','2026-09-01',1),(80,'CONT-CH109-10','Ecopunto','general',3.00,'roto',6,80,'CH_109','2026-09-01',1),(81,'CONT-CH114-01','Ecopunto','general',3.00,'funcional',2,81,'CH_114','2026-09-05',1),(82,'CONT-CH114-02','EASY','reciclaje',2.25,'funcional',2,82,'CH_114','2026-09-05',1),(83,'CONT-CH114-03','Metálico','mixto',3.00,'funcional',2,83,'CH_114','2026-09-03',1),(84,'CONT-CH114-04','Ecopunto','general',3.00,'funcional',2,84,'CH_114','2026-09-03',1),(85,'CONT-CH114-05','EASY','reciclaje',2.25,'funcional',2,85,'CH_114','2026-09-03',1),(86,'CONT-CH114-06','Metálico','mixto',3.00,'funcional',2,86,'CH_114','2026-09-03',1),(87,'CONT-CH114-07','Ecopunto','general',3.00,'desbordado',2,87,'CH_114','2026-09-01',1),(88,'CONT-CH114-08','EASY','reciclaje',2.25,'roto',4,88,'CH_114','2026-09-01',1),(89,'CONT-CH114-09','Metálico','mixto',3.00,'desbordado',4,89,'CH_114','2026-09-01',1),(90,'CONT-CH114-10','Ecopunto','general',3.00,'roto',6,90,'CH_114','2026-09-01',1),(91,'CONT-A101-01','Ecopunto','general',3.00,'funcional',2,91,'A_101','2026-09-05',1),(92,'CONT-A101-02','EASY','reciclaje',2.25,'funcional',2,92,'A_101','2026-09-05',1),(93,'CONT-A101-03','Metálico','mixto',3.00,'funcional',4,93,'A_101','2026-09-05',1),(94,'CONT-A101-04','Ecopunto','general',3.00,'funcional',4,94,'A_101','2026-09-05',1),(95,'CONT-A101-05','EASY','reciclaje',2.25,'funcional',4,95,'A_101','2026-09-05',1),(96,'CONT-A101-06','Metálico','mixto',3.00,'funcional',6,96,'A_101','2026-09-05',1),(97,'CONT-A101-07','Ecopunto','general',3.00,'funcional',6,97,'A_101','2026-09-03',1),(98,'CONT-A101-08','EASY','reciclaje',2.25,'funcional',6,98,'A_101','2026-09-03',1),(99,'CONT-A101-09','Metálico','mixto',3.00,'funcional',6,99,'A_101','2026-09-03',1),(100,'CONT-A101-10','Ecopunto','general',3.00,'roto',6,100,'A_101','2026-09-01',1),(101,'CONT-A102-01','Ecopunto','general',3.00,'funcional',2,101,'A_102','2026-09-05',1),(102,'CONT-A102-02','EASY','reciclaje',2.25,'funcional',2,102,'A_102','2026-09-05',1),(103,'CONT-A102-03','Metálico','mixto',3.00,'funcional',4,103,'A_102','2026-09-05',1),(104,'CONT-A102-04','Ecopunto','general',3.00,'funcional',4,104,'A_102','2026-09-05',1),(105,'CONT-A102-05','EASY','reciclaje',2.25,'funcional',4,105,'A_102','2026-09-05',1),(106,'CONT-A102-06','Metálico','mixto',3.00,'funcional',6,106,'A_102','2026-09-05',1),(107,'CONT-A102-07','Ecopunto','general',3.00,'funcional',6,107,'A_102','2026-09-03',1),(108,'CONT-A102-08','EASY','reciclaje',2.25,'funcional',6,108,'A_102','2026-09-03',1),(109,'CONT-A102-09','Metálico','mixto',3.00,'funcional',6,109,'A_102','2026-09-03',1),(110,'CONT-A102-10','Ecopunto','general',3.00,'roto',6,110,'A_102','2026-09-01',1),(111,'CONT-A103-01','Ecopunto','general',3.00,'funcional',2,111,'A_103','2026-09-05',1),(112,'CONT-A103-02','EASY','reciclaje',2.25,'funcional',2,112,'A_103','2026-09-05',1),(113,'CONT-A103-03','Metálico','mixto',3.00,'funcional',4,113,'A_103','2026-09-05',1),(114,'CONT-A103-04','Ecopunto','general',3.00,'funcional',4,114,'A_103','2026-09-05',1),(115,'CONT-A103-05','EASY','reciclaje',2.25,'funcional',4,115,'A_103','2026-09-05',1),(116,'CONT-A103-06','Metálico','mixto',3.00,'funcional',6,116,'A_103','2026-09-05',1),(117,'CONT-A103-07','Ecopunto','general',3.00,'funcional',6,117,'A_103','2026-09-03',1),(118,'CONT-A103-08','EASY','reciclaje',2.25,'funcional',6,118,'A_103','2026-09-03',1),(119,'CONT-A103-09','Metálico','mixto',3.00,'funcional',6,119,'A_103','2026-09-03',1),(120,'CONT-A103-10','Ecopunto','general',3.00,'roto',6,120,'A_103','2026-09-01',1),(121,'CONT-B05-01','Ecopunto','general',3.00,'funcional',2,121,'B_05','2026-09-05',1),(122,'CONT-B05-02','EASY','reciclaje',2.25,'funcional',2,122,'B_05','2026-09-05',1),(123,'CONT-B05-03','Metálico','mixto',3.00,'funcional',2,123,'B_05','2026-09-05',1),(124,'CONT-B05-04','Ecopunto','general',3.00,'funcional',2,124,'B_05','2026-09-05',1),(125,'CONT-B05-05','EASY','reciclaje',2.25,'funcional',2,125,'B_05','2026-09-05',1),(126,'CONT-B05-06','Metálico','mixto',3.00,'funcional',2,126,'B_05','2026-09-05',1),(127,'CONT-B05-07','Ecopunto','general',3.00,'funcional',2,127,'B_05','2026-09-03',1),(128,'CONT-B05-08','EASY','reciclaje',2.25,'funcional',4,128,'B_05','2026-09-03',1),(129,'CONT-B05-09','Metálico','mixto',3.00,'funcional',4,129,'B_05','2026-09-03',1),(130,'CONT-B05-10','Ecopunto','general',3.00,'roto',6,130,'B_05','2026-09-01',1),(131,'CONT-B06-01','Ecopunto','general',3.00,'funcional',2,131,'B_06','2026-09-05',1),(132,'CONT-B06-02','EASY','reciclaje',2.25,'funcional',2,132,'B_06','2026-09-05',1),(133,'CONT-B06-03','Metálico','mixto',3.00,'funcional',2,133,'B_06','2026-09-05',1),(134,'CONT-B06-04','Ecopunto','general',3.00,'funcional',2,134,'B_06','2026-09-05',1),(135,'CONT-B06-05','EASY','reciclaje',2.25,'funcional',4,135,'B_06','2026-09-05',1),(136,'CONT-B06-06','Metálico','mixto',3.00,'funcional',4,136,'B_06','2026-09-05',1),(137,'CONT-B06-07','Ecopunto','general',3.00,'funcional',4,137,'B_06','2026-09-03',1),(138,'CONT-B06-08','EASY','reciclaje',2.25,'funcional',4,138,'B_06','2026-09-03',1),(139,'CONT-B06-09','Metálico','mixto',3.00,'funcional',6,139,'B_06','2026-09-03',1),(140,'CONT-B06-10','Ecopunto','general',3.00,'roto',6,140,'B_06','2026-09-01',1),(141,'CONT-B7-01','Ecopunto','general',3.00,'funcional',2,141,'B_7','2026-09-05',1),(142,'CONT-B7-02','EASY','reciclaje',2.25,'funcional',2,142,'B_7','2026-09-05',1),(143,'CONT-B7-03','Metálico','mixto',3.00,'funcional',2,143,'B_7','2026-09-05',1),(144,'CONT-B7-04','Ecopunto','general',3.00,'funcional',2,144,'B_7','2026-09-05',1),(145,'CONT-B7-05','EASY','reciclaje',2.25,'funcional',2,145,'B_7','2026-09-05',1),(146,'CONT-B7-06','Metálico','mixto',3.00,'funcional',2,146,'B_7','2026-09-05',1),(147,'CONT-B7-07','Ecopunto','general',3.00,'funcional',2,147,'B_7','2026-09-03',1),(148,'CONT-B7-08','EASY','reciclaje',2.25,'funcional',4,148,'B_7','2026-09-03',1),(149,'CONT-B7-09','Metálico','mixto',3.00,'funcional',4,149,'B_7','2026-09-03',1),(150,'CONT-B7-10','Ecopunto','general',3.00,'roto',6,150,'B_7','2026-09-01',1),(151,'CONT-C102-01','Ecopunto','general',3.00,'funcional',2,151,'C_102','2026-09-05',1),(152,'CONT-C102-02','EASY','reciclaje',2.25,'funcional',2,152,'C_102','2026-09-05',1),(153,'CONT-C102-03','Metálico','mixto',3.00,'funcional',2,153,'C_102','2026-09-05',1),(154,'CONT-C102-04','Ecopunto','general',3.00,'funcional',2,154,'C_102','2026-09-05',1),(155,'CONT-C102-05','EASY','reciclaje',2.25,'funcional',2,155,'C_102','2026-09-05',1),(156,'CONT-C102-06','Metálico','mixto',3.00,'funcional',2,156,'C_102','2026-09-05',1),(157,'CONT-C102-07','Ecopunto','general',3.00,'funcional',2,157,'C_102','2026-09-03',1),(158,'CONT-C102-08','EASY','reciclaje',2.25,'funcional',4,158,'C_102','2026-09-03',1),(159,'CONT-C102-09','Metálico','mixto',3.00,'funcional',4,159,'C_102','2026-09-03',1),(160,'CONT-C102-10','Ecopunto','general',3.00,'roto',6,160,'C_102','2026-09-01',1),(161,'CONT-CH115-01','Ecopunto','general',3.00,'funcional',2,161,'CH_115','2026-09-05',1),(162,'CONT-CH115-02','EASY','reciclaje',2.25,'funcional',2,162,'CH_115','2026-09-05',1),(163,'CONT-CH115-03','Metálico','mixto',3.00,'funcional',2,163,'CH_115','2026-09-05',1),(164,'CONT-CH115-04','Ecopunto','general',3.00,'funcional',2,164,'CH_115','2026-09-05',1),(165,'CONT-CH115-05','EASY','reciclaje',2.25,'funcional',4,165,'CH_115','2026-09-05',1),(166,'CONT-CH115-06','Metálico','mixto',3.00,'funcional',4,166,'CH_115','2026-09-05',1),(167,'CONT-CH115-07','Ecopunto','general',3.00,'funcional',4,167,'CH_115','2026-09-03',1),(168,'CONT-CH115-08','EASY','reciclaje',2.25,'funcional',4,168,'CH_115','2026-09-03',1),(169,'CONT-CH115-09','Metálico','mixto',3.00,'funcional',6,169,'CH_115','2026-09-03',1),(170,'CONT-CH115-10','Ecopunto','general',3.00,'roto',6,170,'CH_115','2026-09-01',1),(171,'CONT-D101-01','Ecopunto','general',3.00,'funcional',2,171,'D_101','2026-09-05',1),(172,'CONT-D101-02','EASY','reciclaje',2.25,'funcional',2,172,'D_101','2026-09-05',1),(173,'CONT-D101-03','Metálico','mixto',3.00,'funcional',2,173,'D_101','2026-09-05',1),(174,'CONT-D101-04','Ecopunto','general',3.00,'funcional',2,174,'D_101','2026-09-05',1),(175,'CONT-D101-05','EASY','reciclaje',2.25,'funcional',4,175,'D_101','2026-09-05',1),(176,'CONT-D101-06','Metálico','mixto',3.00,'funcional',4,176,'D_101','2026-09-05',1),(177,'CONT-D101-07','Ecopunto','general',3.00,'funcional',4,177,'D_101','2026-09-03',1),(178,'CONT-D101-08','EASY','reciclaje',2.25,'funcional',4,178,'D_101','2026-09-03',1),(179,'CONT-D101-09','Metálico','mixto',3.00,'funcional',6,179,'D_101','2026-09-03',1),(180,'CONT-D101-10','Ecopunto','general',3.00,'roto',6,180,'D_101','2026-09-01',1),(181,'CONT-D102-01','Ecopunto','general',3.00,'funcional',2,181,'D_102','2026-09-05',1),(182,'CONT-D102-02','EASY','reciclaje',2.25,'funcional',2,182,'D_102','2026-09-05',1),(183,'CONT-D102-03','Metálico','mixto',3.00,'funcional',2,183,'D_102','2026-09-05',1),(184,'CONT-D102-04','Ecopunto','general',3.00,'funcional',2,184,'D_102','2026-09-05',1),(185,'CONT-D102-05','EASY','reciclaje',2.25,'funcional',4,185,'D_102','2026-09-05',1),(186,'CONT-D102-06','Metálico','mixto',3.00,'funcional',4,186,'D_102','2026-09-05',1),(187,'CONT-D102-07','Ecopunto','general',3.00,'funcional',4,187,'D_102','2026-09-03',1),(188,'CONT-D102-08','EASY','reciclaje',2.25,'funcional',4,188,'D_102','2026-09-03',1),(189,'CONT-D102-09','Metálico','mixto',3.00,'funcional',6,189,'D_102','2026-09-03',1),(190,'CONT-D102-10','Ecopunto','general',3.00,'roto',6,190,'D_102','2026-09-01',1),(191,'CONT-D103-01','Ecopunto','general',3.00,'funcional',2,191,'D_103','2026-09-05',1),(192,'CONT-D103-02','EASY','reciclaje',2.25,'funcional',2,192,'D_103','2026-09-05',1),(193,'CONT-D103-03','Metálico','mixto',3.00,'funcional',2,193,'D_103','2026-09-05',1),(194,'CONT-D103-04','Ecopunto','general',3.00,'funcional',2,194,'D_103','2026-09-05',1),(195,'CONT-D103-05','EASY','reciclaje',2.25,'funcional',2,195,'D_103','2026-09-05',1),(196,'CONT-D103-06','Metálico','mixto',3.00,'funcional',2,196,'D_103','2026-09-05',1),(197,'CONT-D103-07','Ecopunto','general',3.00,'funcional',2,197,'D_103','2026-09-03',1),(198,'CONT-D103-08','EASY','reciclaje',2.25,'funcional',4,198,'D_103','2026-09-03',1),(199,'CONT-D103-09','Metálico','mixto',3.00,'funcional',4,199,'D_103','2026-09-03',1),(200,'CONT-D103-10','Ecopunto','general',3.00,'roto',6,200,'D_103','2026-09-01',1),(201,'CONT-E102-01','Ecopunto','general',3.00,'funcional',2,201,'E_102','2026-09-05',1),(202,'CONT-E102-02','EASY','reciclaje',2.25,'funcional',2,202,'E_102','2026-09-05',1),(203,'CONT-E102-03','Metálico','mixto',3.00,'funcional',4,203,'E_102','2026-09-05',1),(204,'CONT-E102-04','Ecopunto','general',3.00,'funcional',4,204,'E_102','2026-09-05',1),(205,'CONT-E102-05','EASY','reciclaje',2.25,'funcional',4,205,'E_102','2026-09-05',1),(206,'CONT-E102-06','Metálico','mixto',3.00,'funcional',6,206,'E_102','2026-09-05',1),(207,'CONT-E102-07','Ecopunto','general',3.00,'funcional',6,207,'E_102','2026-09-03',1),(208,'CONT-E102-08','EASY','reciclaje',2.25,'funcional',6,208,'E_102','2026-09-03',1),(209,'CONT-E102-09','Metálico','mixto',3.00,'funcional',6,209,'E_102','2026-09-03',1),(210,'CONT-E102-10','Ecopunto','general',3.00,'roto',6,210,'E_102','2026-09-01',1),(211,'CONT-E103-01','Ecopunto','general',3.00,'funcional',2,211,'E_103','2026-09-05',1),(212,'CONT-E103-02','EASY','reciclaje',2.25,'funcional',2,212,'E_103','2026-09-05',1),(213,'CONT-E103-03','Metálico','mixto',3.00,'funcional',2,213,'E_103','2026-09-05',1),(214,'CONT-E103-04','Ecopunto','general',3.00,'funcional',2,214,'E_103','2026-09-05',1),(215,'CONT-E103-05','EASY','reciclaje',2.25,'funcional',4,215,'E_103','2026-09-05',1),(216,'CONT-E103-06','Metálico','mixto',3.00,'funcional',4,216,'E_103','2026-09-05',1),(217,'CONT-E103-07','Ecopunto','general',3.00,'funcional',4,217,'E_103','2026-09-03',1),(218,'CONT-E103-08','EASY','reciclaje',2.25,'funcional',4,218,'E_103','2026-09-03',1),(219,'CONT-E103-09','Metálico','mixto',3.00,'funcional',6,219,'E_103','2026-09-03',1),(220,'CONT-E103-10','Ecopunto','general',3.00,'roto',6,220,'E_103','2026-09-01',1),(221,'CONT-E106-01','Ecopunto','general',3.00,'funcional',2,221,'E_106','2026-09-05',1),(222,'CONT-E106-02','EASY','reciclaje',2.25,'funcional',2,222,'E_106','2026-09-05',1),(223,'CONT-E106-03','Metálico','mixto',3.00,'funcional',2,223,'E_106','2026-09-05',1),(224,'CONT-E106-04','Ecopunto','general',3.00,'funcional',2,224,'E_106','2026-09-05',1),(225,'CONT-E106-05','EASY','reciclaje',2.25,'funcional',4,225,'E_106','2026-09-05',1),(226,'CONT-E106-06','Metálico','mixto',3.00,'funcional',4,226,'E_106','2026-09-05',1),(227,'CONT-E106-07','Ecopunto','general',3.00,'funcional',4,227,'E_106','2026-09-03',1),(228,'CONT-E106-08','EASY','reciclaje',2.25,'funcional',4,228,'E_106','2026-09-03',1),(229,'CONT-E106-09','Metálico','mixto',3.00,'funcional',6,229,'E_106','2026-09-03',1),(230,'CONT-E106-10','Ecopunto','general',3.00,'roto',6,230,'E_106','2026-09-01',1),(231,'CONT-F101-01','Ecopunto','general',3.00,'funcional',2,231,'F_101','2026-09-05',1),(232,'CONT-F101-02','EASY','reciclaje',2.25,'funcional',2,232,'F_101','2026-09-05',1),(233,'CONT-F101-03','Metálico','mixto',3.00,'funcional',2,233,'F_101','2026-09-05',1),(234,'CONT-F101-04','Ecopunto','general',3.00,'funcional',2,234,'F_101','2026-09-05',1),(235,'CONT-F101-05','EASY','reciclaje',2.25,'funcional',2,235,'F_101','2026-09-05',1),(236,'CONT-F101-06','Metálico','mixto',3.00,'funcional',2,236,'F_101','2026-09-05',1),(237,'CONT-F101-07','Ecopunto','general',3.00,'funcional',2,237,'F_101','2026-09-03',1),(238,'CONT-F101-08','EASY','reciclaje',2.25,'funcional',4,238,'F_101','2026-09-03',1),(239,'CONT-F101-09','Metálico','mixto',3.00,'funcional',4,239,'F_101','2026-09-03',1),(240,'CONT-F101-10','Ecopunto','general',3.00,'roto',6,240,'F_101','2026-09-01',1),(241,'CONT-F102-01','Ecopunto','general',3.00,'funcional',2,241,'F_102','2026-09-05',1),(242,'CONT-F102-02','EASY','reciclaje',2.25,'funcional',2,242,'F_102','2026-09-05',1),(243,'CONT-F102-03','Metálico','mixto',3.00,'funcional',2,243,'F_102','2026-09-05',1),(244,'CONT-F102-04','Ecopunto','general',3.00,'funcional',2,244,'F_102','2026-09-05',1),(245,'CONT-F102-05','EASY','reciclaje',2.25,'funcional',4,245,'F_102','2026-09-05',1),(246,'CONT-F102-06','Metálico','mixto',3.00,'funcional',4,246,'F_102','2026-09-05',1),(247,'CONT-F102-07','Ecopunto','general',3.00,'funcional',4,247,'F_102','2026-09-03',1),(248,'CONT-F102-08','EASY','reciclaje',2.25,'funcional',4,248,'F_102','2026-09-03',1),(249,'CONT-F102-09','Metálico','mixto',3.00,'funcional',6,249,'F_102','2026-09-03',1),(250,'CONT-F102-10','Ecopunto','general',3.00,'roto',6,250,'F_102','2026-09-01',1),(251,'CONT-F103-01','Ecopunto','general',3.00,'funcional',2,251,'F_103','2026-09-05',1),(252,'CONT-F103-02','EASY','reciclaje',2.25,'funcional',2,252,'F_103','2026-09-05',1),(253,'CONT-F103-03','Metálico','mixto',3.00,'funcional',4,253,'F_103','2026-09-05',1),(254,'CONT-F103-04','Ecopunto','general',3.00,'funcional',4,254,'F_103','2026-09-05',1),(255,'CONT-F103-05','EASY','reciclaje',2.25,'funcional',4,255,'F_103','2026-09-05',1),(256,'CONT-F103-06','Metálico','mixto',3.00,'funcional',6,256,'F_103','2026-09-05',1),(257,'CONT-F103-07','Ecopunto','general',3.00,'funcional',6,257,'F_103','2026-09-03',1),(258,'CONT-F103-08','EASY','reciclaje',2.25,'funcional',6,258,'F_103','2026-09-03',1),(259,'CONT-F103-09','Metálico','mixto',3.00,'funcional',6,259,'F_103','2026-09-03',1),(260,'CONT-F103-10','Ecopunto','general',3.00,'roto',6,260,'F_103','2026-09-01',1),(261,'CONT-G101-01','Ecopunto','general',3.00,'funcional',2,261,'G_101','2026-09-05',1),(262,'CONT-G101-02','EASY','reciclaje',2.25,'funcional',2,262,'G_101','2026-09-05',1),(263,'CONT-G101-03','Metálico','mixto',3.00,'funcional',4,263,'G_101','2026-09-05',1),(264,'CONT-G101-04','Ecopunto','general',3.00,'funcional',4,264,'G_101','2026-09-05',1),(265,'CONT-G101-05','EASY','reciclaje',2.25,'funcional',4,265,'G_101','2026-09-05',1),(266,'CONT-G101-06','Metálico','mixto',3.00,'funcional',6,266,'G_101','2026-09-05',1),(267,'CONT-G101-07','Ecopunto','general',3.00,'funcional',6,267,'G_101','2026-09-03',1),(268,'CONT-G101-08','EASY','reciclaje',2.25,'funcional',6,268,'G_101','2026-09-03',1),(269,'CONT-G101-09','Metálico','mixto',3.00,'funcional',6,269,'G_101','2026-09-03',1),(270,'CONT-G101-10','Ecopunto','general',3.00,'roto',6,270,'G_101','2026-09-01',1),(271,'CONT-G102-01','Ecopunto','general',3.00,'funcional',2,271,'G_102','2026-09-05',1),(272,'CONT-G102-02','EASY','reciclaje',2.25,'funcional',2,272,'G_102','2026-09-05',1),(273,'CONT-G102-03','Metálico','mixto',3.00,'funcional',2,273,'G_102','2026-09-05',1),(274,'CONT-G102-04','Ecopunto','general',3.00,'funcional',2,274,'G_102','2026-09-05',1),(275,'CONT-G102-05','EASY','reciclaje',2.25,'funcional',2,275,'G_102','2026-09-05',1),(276,'CONT-G102-06','Metálico','mixto',3.00,'funcional',2,276,'G_102','2026-09-05',1),(277,'CONT-G102-07','Ecopunto','general',3.00,'funcional',2,277,'G_102','2026-09-03',1),(278,'CONT-G102-08','EASY','reciclaje',2.25,'funcional',4,278,'G_102','2026-09-03',1),(279,'CONT-G102-09','Metálico','mixto',3.00,'funcional',4,279,'G_102','2026-09-03',1),(280,'CONT-G102-10','Ecopunto','general',3.00,'roto',6,280,'G_102','2026-09-01',1),(281,'CONT-G103-01','Ecopunto','general',3.00,'funcional',2,281,'G_103','2026-09-05',1),(282,'CONT-G103-02','EASY','reciclaje',2.25,'funcional',2,282,'G_103','2026-09-05',1),(283,'CONT-G103-03','Metálico','mixto',3.00,'funcional',2,283,'G_103','2026-09-05',1),(284,'CONT-G103-04','Ecopunto','general',3.00,'funcional',2,284,'G_103','2026-09-05',1),(285,'CONT-G103-05','EASY','reciclaje',2.25,'funcional',4,285,'G_103','2026-09-05',1),(286,'CONT-G103-06','Metálico','mixto',3.00,'funcional',4,286,'G_103','2026-09-05',1),(287,'CONT-G103-07','Ecopunto','general',3.00,'funcional',4,287,'G_103','2026-09-03',1),(288,'CONT-G103-08','EASY','reciclaje',2.25,'funcional',4,288,'G_103','2026-09-03',1),(289,'CONT-G103-09','Metálico','mixto',3.00,'funcional',6,289,'G_103','2026-09-03',1),(290,'CONT-G103-10','Ecopunto','general',3.00,'roto',6,290,'G_103','2026-09-01',1);
/*!40000 ALTER TABLE `contenedores` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `cuadrilla`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cuadrilla` (
  `id_cuadrilla` varchar(20) NOT NULL,
  `id_responsable` int(11) DEFAULT NULL,
  `turno` varchar(30) DEFAULT NULL,
  `estado` varchar(30) DEFAULT NULL,
  `ubicacion_actual` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_cuadrilla`),
  KEY `id_responsable` (`id_responsable`),
  CONSTRAINT `cuadrilla_ibfk_1` FOREIGN KEY (`id_responsable`) REFERENCES `usuarios` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `cuadrilla` WRITE;
/*!40000 ALTER TABLE `cuadrilla` DISABLE KEYS */;
INSERT INTO `cuadrilla` VALUES ('A-01',36,'Nocturno','En base',NULL),('B-02',31,'Nocturno','En servicio','B_01'),('B-03',32,'Nocturno','Regresando','B_03'),('CH_01',34,'Nocturno','En servicio','CH_109'),('CH_02',35,'Nocturno','Esperando circuito','CH_102'),('CH_03',33,'Nocturno','En base','CH_114');
/*!40000 ALTER TABLE `cuadrilla` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `cuadrilla_integrantes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cuadrilla_integrantes` (
  `id_cuadrilla` varchar(20) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `fecha_asignacion` datetime NOT NULL DEFAULT current_timestamp(),
  `fecha_finalizacion` datetime DEFAULT NULL,
  PRIMARY KEY (`id_cuadrilla`,`id_usuario`,`fecha_asignacion`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `cuadrilla_integrantes_ibfk_1` FOREIGN KEY (`id_cuadrilla`) REFERENCES `cuadrilla` (`id_cuadrilla`) ON DELETE CASCADE,
  CONSTRAINT `cuadrilla_integrantes_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `cuadrilla_integrantes` WRITE;
/*!40000 ALTER TABLE `cuadrilla_integrantes` DISABLE KEYS */;
INSERT INTO `cuadrilla_integrantes` VALUES ('A-01',37,'2026-09-09 06:37:46',NULL),('B-02',15,'2026-05-10 00:00:00',NULL),('B-02',16,'2026-05-10 00:00:00',NULL),('B-02',17,'2026-05-12 00:00:00',NULL),('B-02',18,'2026-05-12 00:00:00',NULL),('B-03',19,'2026-05-18 00:00:00',NULL),('B-03',20,'2026-05-18 00:00:00',NULL),('B-03',21,'2026-05-20 00:00:00',NULL),('B-03',22,'2026-05-20 00:00:00',NULL),('CH_01',27,'2026-06-04 00:00:00',NULL),('CH_01',28,'2026-06-04 00:00:00',NULL),('CH_01',29,'2026-06-05 00:00:00',NULL),('CH_01',30,'2026-06-05 00:00:00',NULL),('CH_02',15,'2026-05-10 00:00:00',NULL),('CH_02',16,'2026-05-10 00:00:00',NULL),('CH_02',17,'2026-05-12 00:00:00',NULL),('CH_02',18,'2026-05-12 00:00:00',NULL),('CH_03',23,'2026-06-01 00:00:00',NULL),('CH_03',24,'2026-06-01 00:00:00',NULL),('CH_03',25,'2026-06-02 00:00:00',NULL),('CH_03',26,'2026-06-02 00:00:00',NULL);
/*!40000 ALTER TABLE `cuadrilla_integrantes` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `cuadrilla_rutas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cuadrilla_rutas` (
  `id_asignacion` int(11) NOT NULL AUTO_INCREMENT,
  `id_cuadrilla` varchar(20) NOT NULL,
  `id_ruta` int(11) NOT NULL,
  `fecha_asignacion` datetime NOT NULL DEFAULT current_timestamp(),
  `fecha_finalizacion` datetime DEFAULT NULL,
  `estado` varchar(30) NOT NULL DEFAULT 'Asignada',
  `prioridad` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id_asignacion`),
  KEY `id_cuadrilla` (`id_cuadrilla`),
  KEY `id_ruta` (`id_ruta`),
  CONSTRAINT `cuadrilla_rutas_ibfk_1` FOREIGN KEY (`id_cuadrilla`) REFERENCES `cuadrilla` (`id_cuadrilla`),
  CONSTRAINT `cuadrilla_rutas_ibfk_2` FOREIGN KEY (`id_ruta`) REFERENCES `rutas` (`id_ruta`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `cuadrilla_rutas` WRITE;
/*!40000 ALTER TABLE `cuadrilla_rutas` DISABLE KEYS */;
INSERT INTO `cuadrilla_rutas` VALUES (1,'B-02',1,'2026-07-20 00:00:00','2026-07-20 00:00:00','Finalizada','Media'),(2,'B-02',2,'2026-07-24 00:00:00',NULL,'Asignada','Media'),(3,'B-03',3,'2026-07-21 00:00:00','2026-07-21 00:00:00','Finalizada','Media'),(4,'B-03',4,'2026-07-24 00:00:00','2026-07-24 00:00:00','Finalizada','Media'),(5,'CH_03',5,'2026-07-22 00:00:00','2026-07-22 00:00:00','Finalizada','Media'),(6,'CH_01',6,'2026-07-23 00:00:00','2026-07-23 00:00:00','Finalizada','Media'),(7,'CH_01',7,'2026-07-25 00:00:00',NULL,'Asignada','Media'),(8,'CH_02',8,'2026-07-24 00:00:00','2026-07-24 00:00:00','Finalizada','Media'),(9,'CH_02',9,'2026-07-25 00:00:00',NULL,'Asignada','Media');
/*!40000 ALTER TABLE `cuadrilla_rutas` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `datos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `datos` (
  `id_datos` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL,
  `password` varchar(255) NOT NULL,
  `documento` varchar(30) NOT NULL,
  `telefono` varchar(30) DEFAULT NULL,
  `email` varchar(150) NOT NULL,
  PRIMARY KEY (`id_datos`),
  UNIQUE KEY `id_usuario` (`id_usuario`),
  UNIQUE KEY `documento` (`documento`),
  UNIQUE KEY `email` (`email`),
  CONSTRAINT `datos_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `datos` WRITE;
/*!40000 ALTER TABLE `datos` DISABLE KEYS */;
INSERT INTO `datos` VALUES (1,1,'$2y$12$Hlwa4LsPJE/txoq3xOJXxOIv.yZaygvueGOG9fQQHhM4linsETNeC','5.000.008-7','099000001','admin@sigeru.uy'),(2,2,'$2y$12$uLotuA9237JQxm1YS0OkXe29Z6i/hid7N65eNI.EtqIepSeVlCOka','5.000.001-6','099000002','vecino@sigeru.uy'),(3,3,'$2y$12$OM8ThfNWcM4LsibJH52OGumQ/WeCjt/EfOO3g.t0hH0AJaVnUZ0Fm','5.000.002-2','099000003','cuadrilla@sigeru.uy'),(4,4,'$2y$12$CwUmFTsb/izgMmsJZRiEe.jWfGJZxXJoXWI/2gCoTJzFfW0XmeBFu','5.000.003-8','099000004','operario@sigeru.uy'),(5,5,'$2y$12$qkCN5y3IkN3H2PqvuFUxV.fW0KMwJuLtUQpGHUEK522Igmomp/ism','5.000.004-4','099000005','chofer@sigeru.uy'),(6,6,'$2y$12$koiboyuQOIynghLB4N5h6uNk7B4Yhhx4ZoW5AzIVEvjXvomYns182','5.001.000-5','099000111','prueba@sigeru.uy'),(7,7,'$2y$12$vtYyr8LjUBFnrb3tx.lHJ.HWx7NrDK1gT3Vxk340rYBKRfrLaS9XS','5.001.000-6','099000112','prueba2@sigeru.uy'),(8,8,'$2y$12$tcOpWqWNiyxXg7RxzMPN3.s/xgvCeA1fp.FkQ4zoSnH7V51vYmfem','4.111.111-1','099111111','albert@sigeru.uy'),(9,9,'$2y$12$iUYyUF0jhxDLLMH9SckWaeL.w8tUqnxpIvZd0iVcI.R9CvWYxHT6C','4.222.222-2','099222222','leonardo@sigeru.uy'),(10,10,'$2y$12$ICt/Jku7Z5ZMObVtgec92uayRKyu5KAbm3Ox1dbl9pLYd8Pnc5ZBG','4.333.333-3','099333333','frida@sigeru.uy'),(11,11,'$2y$12$u0vyLBJ2g/7ybeg6lTtqi.BFURn7jseL6LFAoRWohTq4Xbvqivj2W','4.666.666-6','099666666','julio@sigeru.uy'),(12,12,'$2y$12$aJnupQ1Osu0r8KdSO8Da4OGTVWgHYc2IEppLXizaytPxHwV75/kXG','4.444.444-4','099444444','maria@sigeru.uy'),(13,13,'$2y$12$mCzFwUxkIPka9HMNMk2jS.mAvW/uZPB5QUEFhRl6yd.qAx.PLDqbu','4.555.555-5','099555555','carlos@sigeru.uy'),(14,14,'$2y$12$ffr9OtRFc.iTAc99TBt14uc58zKLn5b/FxMywnXr76JV2zuoLLgAG','4.777.777-7','099777777','lucia@sigeru.uy'),(15,15,'$2y$12$QbDAIk3CkunZOMcutkC67ezit16lcCj4UzyYzhrHRj8PV57npSodS','5.101.201-1','098301401','edinson.cavani@sigeru.uy'),(16,16,'$2y$12$Fhz1OPGHoeB6/bsHTuDuLuDORXte.tO9VM3ucX8dDw2LvSBBrNFJC','5.102.202-2','098302402','federico.valverde@sigeru.uy'),(17,17,'$2y$12$KYUO2IVRKet/8zlNcbfAqePFjFIHT.fr87dKs5J8Gm9MaRQGAFDo2','5.103.203-3','098303403','valeria.ripoll@sigeru.uy'),(18,18,'$2y$12$R7DlEKksFaqu5gF0qZWNlOTdh3pu.5U8v2kqOBOnHdTjZF6R2B0Am','5.104.204-4','098304404','victoria.rodriguez@sigeru.uy'),(19,19,'$2y$12$Wb55hCByTdbY15yqDyN1PeSxHQWB3B.q09rmrnptM3CeRn6dF/Kme','5.105.205-5','098305405','rodrigo.bentancur@sigeru.uy'),(20,20,'$2y$12$v2zH0UdHzm85fToCHmh75uCWkSEeoLiQyPPaxNIe57U7/o1M4BG/2','5.106.206-6','098306406','jose.maria.gimenez@sigeru.uy'),(21,21,'$2y$12$LAcotSESppyxTE0qHQIFA.TvPLXCoaLNnqEQbBSTjI5i5cynon/OO','5.107.207-7','098307407','sergio.rochet@sigeru.uy'),(22,22,'$2y$12$fsMCefwk5H1O1WfYopb2GeMP3WE09Nc.PUqtYRTHPH4k8uF8E1JDK','5.108.208-8','098308408','nicolas.de.la.cruz@sigeru.uy'),(23,23,'$2y$12$nOCbFC/gkUzLJwgeIHQ2N.1ASkSWoBjorh6T/zk.URzd4s9XKqHzC','5.109.209-9','098309409','delmira.agustini@sigeru.uy'),(24,24,'$2y$12$7sfTYJOrZaaCab7iygXyB.QLy.Y4HcULrNx/8Ig/ynLsSt.q2BpAq','5.110.210-0','098310410','idea.vilarino@sigeru.uy'),(25,25,'$2y$12$ONDkcFzpvpqGAMkad.VkWefAqEADi3KWdhlzq4OkymxpCaovCKK6e','5.111.211-1','091311411','mario.benedetti@sigeru.uy'),(26,26,'$2y$12$G9i5ieSfm7UJcDykb1l82uQiiBL.8He.r7y3ZmKS6Ur92zUTN0Jm2','5.112.212-2','098312412','amanda.berenguer@sigeru.uy'),(27,27,'$2y$12$ICPSa1bt.8IkzlxhQLPLEen85Bcrg7WUk1glZKOE7U2gUHrsUuWnC','5.113.213-3','098313413','estela.medina@sigeru.uy'),(28,28,'$2y$12$Fsx1VSTFm0j/wUno1yqzeetH.seMq2HWlmbdkvvhfePBtPEj7C9wC','5.114.214-4','098314414','antonio.larreta@sigeru.uy'),(29,29,'$2y$12$F9LxDbNfqlNYksvhKE/aZ.itFjuDQ4t/cpGgsmBe0UqFNGJoy3Xyi','5.115.215-5','098315415','dahd.sfeir@sigeru.uy'),(30,30,'$2y$12$LEX6pgRaKB6X/AEpkx3KVe.OMeV8m9grrzAFOrnJ.eB1a0JFw/f2W','5.116.216-6','098316416','walter.reyno@sigeru.uy'),(31,31,'$2y$12$ji9zjUcdQqGofWyJ0RPC7uTHov7sgaWfnxu/qFuIVEA6NDpFTT3yy','5.201.201-1','098201201','diego.forlan@sigeru.uy'),(32,32,'$2y$12$gNXBsHYqO3ldSyDwck51uOjXtVWqYSDPJbQgswlDKk3gUFp/8nGy2','5.202.202-2','098202202','luis.suarez@sigeru.uy'),(33,33,'$2y$12$UUMsLTh/jofcmA4yZWgSMO4Rd9b48lDYk8o.0OPuL2ITqZxwX3Ale','5.203.203-3','098203203','juana.ibarbourou@sigeru.uy'),(34,34,'$2y$12$3JLHKFd00n6S8Mmi1s6/dOH4XG/eltaVWL/DK.jmCT/DlSRPAlKIK','5.204.204-4','098204204','china.zorrilla@sigeru.uy'),(35,35,'$2y$12$o0QMrQlEnf4MYJq.NwZraeqVZZD/LvwNGMigp77tkwvS0Pv/BF/pa','5.205.205-5','098205205','natalia.oreiro@sigeru.uy'),(36,36,'$2y$12$iPaQzs2TH38IPBZbpp4k7O6w32sdHyp7ooKERIVtq8ohVYdcIoAaG','5.001.007-5','099111111','barrendero2@sigeru.uy'),(37,37,'$2y$12$URpqB014WQmWlxVVtLNQreAevh7aYqcwMlQs7z/IDjT6dV8l4Bmli','5.001.007-6','092794222','barrendero3@sigeru.uy'),(38,38,'$2y$12$RoPWF1p/AXsl0KJYrodd1uQ.I9e/InEs79yqoeq6KqaTTckjSL7j6','4.776.777-4','092111333','barrendero8@sigeru.uy'),(39,39,'$2y$12$YudW4XXuetpeZolec1MEcezFImQKX/c9ltZmyvnd6X6FkEamIHGOi','5.177.777-7','099223333','prueba5@sigeru.uy');
/*!40000 ALTER TABLE `datos` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `historial_contenedores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `historial_contenedores` (
  `id_historial` int(11) NOT NULL AUTO_INCREMENT,
  `id_contenedor` int(11) NOT NULL,
  `fecha` datetime NOT NULL DEFAULT current_timestamp(),
  `estado_anterior` varchar(30) DEFAULT NULL,
  `estado_nuevo` varchar(30) DEFAULT NULL,
  `id_ubicacion_anterior` int(11) DEFAULT NULL,
  `id_ubicacion_nueva` int(11) DEFAULT NULL,
  `motivo` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_historial`),
  KEY `id_contenedor` (`id_contenedor`),
  KEY `id_ubicacion_anterior` (`id_ubicacion_anterior`),
  KEY `id_ubicacion_nueva` (`id_ubicacion_nueva`),
  CONSTRAINT `historial_contenedores_ibfk_1` FOREIGN KEY (`id_contenedor`) REFERENCES `contenedores` (`id_contenedor`) ON DELETE CASCADE,
  CONSTRAINT `historial_contenedores_ibfk_2` FOREIGN KEY (`id_ubicacion_anterior`) REFERENCES `ubicacion` (`id_ubicacion`),
  CONSTRAINT `historial_contenedores_ibfk_3` FOREIGN KEY (`id_ubicacion_nueva`) REFERENCES `ubicacion` (`id_ubicacion`)
) ENGINE=InnoDB AUTO_INCREMENT=291 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `historial_contenedores` WRITE;
/*!40000 ALTER TABLE `historial_contenedores` DISABLE KEYS */;
INSERT INTO `historial_contenedores` VALUES (1,1,'2026-09-07 22:13:02',NULL,'funcional',NULL,1,'Alta: Contenedor incorporado al circuito B_01.'),(2,2,'2026-09-07 22:13:02',NULL,'funcional',NULL,2,'Alta: Contenedor incorporado al circuito B_01.'),(3,3,'2026-09-07 22:13:04',NULL,'funcional',NULL,3,'Alta: Contenedor incorporado al circuito B_01.'),(4,4,'2026-09-07 22:13:04',NULL,'funcional',NULL,4,'Alta: Contenedor incorporado al circuito B_01.'),(5,5,'2026-09-07 22:13:04',NULL,'funcional',NULL,5,'Alta: Contenedor incorporado al circuito B_01.'),(6,6,'2026-09-07 22:13:04',NULL,'funcional',NULL,6,'Alta: Contenedor incorporado al circuito B_01.'),(7,7,'2026-09-07 22:13:04',NULL,'funcional',NULL,7,'Alta: Contenedor incorporado al circuito B_01.'),(8,8,'2026-09-07 22:13:04',NULL,'funcional',NULL,8,'Alta: Contenedor incorporado al circuito B_01.'),(9,9,'2026-09-07 22:13:05',NULL,'funcional',NULL,9,'Alta: Contenedor incorporado al circuito B_01.'),(10,10,'2026-09-07 22:13:05',NULL,'roto',NULL,10,'Alta: Contenedor incorporado al circuito B_01.'),(11,11,'2026-09-07 22:13:05',NULL,'funcional',NULL,11,'Alta: Contenedor incorporado al circuito B_02.'),(12,12,'2026-09-07 22:13:05',NULL,'funcional',NULL,12,'Alta: Contenedor incorporado al circuito B_02.'),(13,13,'2026-09-07 22:13:05',NULL,'funcional',NULL,13,'Alta: Contenedor incorporado al circuito B_02.'),(14,14,'2026-09-07 22:13:05',NULL,'funcional',NULL,14,'Alta: Contenedor incorporado al circuito B_02.'),(15,15,'2026-09-07 22:13:06',NULL,'funcional',NULL,15,'Alta: Contenedor incorporado al circuito B_02.'),(16,16,'2026-09-07 22:13:06',NULL,'funcional',NULL,16,'Alta: Contenedor incorporado al circuito B_02.'),(17,17,'2026-09-07 22:13:06',NULL,'funcional',NULL,17,'Alta: Contenedor incorporado al circuito B_02.'),(18,18,'2026-09-07 22:13:06',NULL,'funcional',NULL,18,'Alta: Contenedor incorporado al circuito B_02.'),(19,19,'2026-09-07 22:13:06',NULL,'desbordado',NULL,19,'Alta: Contenedor incorporado al circuito B_02.'),(20,20,'2026-09-07 22:13:07',NULL,'roto',NULL,20,'Alta: Contenedor incorporado al circuito B_02.'),(21,21,'2026-09-07 22:13:07',NULL,'funcional',NULL,21,'Alta: Contenedor incorporado al circuito B_03.'),(22,22,'2026-09-07 22:13:07',NULL,'funcional',NULL,22,'Alta: Contenedor incorporado al circuito B_03.'),(23,23,'2026-09-07 22:13:07',NULL,'funcional',NULL,23,'Alta: Contenedor incorporado al circuito B_03.'),(24,24,'2026-09-07 22:13:07',NULL,'funcional',NULL,24,'Alta: Contenedor incorporado al circuito B_03.'),(25,25,'2026-09-07 22:13:07',NULL,'funcional',NULL,25,'Alta: Contenedor incorporado al circuito B_03.'),(26,26,'2026-09-07 22:13:08',NULL,'roto',NULL,26,'Alta: Contenedor incorporado al circuito B_03.'),(27,27,'2026-09-07 22:13:08',NULL,'desbordado',NULL,27,'Alta: Contenedor incorporado al circuito B_03.'),(28,28,'2026-09-07 22:13:08',NULL,'roto',NULL,28,'Alta: Contenedor incorporado al circuito B_03.'),(29,29,'2026-09-07 22:13:08',NULL,'desbordado',NULL,29,'Alta: Contenedor incorporado al circuito B_03.'),(30,30,'2026-09-07 22:13:09',NULL,'roto',NULL,30,'Alta: Contenedor incorporado al circuito B_03.'),(31,31,'2026-09-07 22:13:09',NULL,'funcional',NULL,31,'Alta: Contenedor incorporado al circuito B_04.'),(32,32,'2026-09-07 22:13:09',NULL,'funcional',NULL,32,'Alta: Contenedor incorporado al circuito B_04.'),(33,33,'2026-09-07 22:13:09',NULL,'funcional',NULL,33,'Alta: Contenedor incorporado al circuito B_04.'),(34,34,'2026-09-07 22:13:10',NULL,'funcional',NULL,34,'Alta: Contenedor incorporado al circuito B_04.'),(35,35,'2026-09-07 22:13:10',NULL,'funcional',NULL,35,'Alta: Contenedor incorporado al circuito B_04.'),(36,36,'2026-09-07 22:13:10',NULL,'funcional',NULL,36,'Alta: Contenedor incorporado al circuito B_04.'),(37,37,'2026-09-07 22:13:11',NULL,'funcional',NULL,37,'Alta: Contenedor incorporado al circuito B_04.'),(38,38,'2026-09-07 22:13:11',NULL,'funcional',NULL,38,'Alta: Contenedor incorporado al circuito B_04.'),(39,39,'2026-09-07 22:13:12',NULL,'funcional',NULL,39,'Alta: Contenedor incorporado al circuito B_04.'),(40,40,'2026-09-07 22:13:14',NULL,'funcional',NULL,40,'Alta: Contenedor incorporado al circuito B_04.'),(41,41,'2026-09-07 22:13:16',NULL,'funcional',NULL,41,'Alta: Contenedor incorporado al circuito CH_102.'),(42,42,'2026-09-07 22:13:16',NULL,'funcional',NULL,42,'Alta: Contenedor incorporado al circuito CH_102.'),(43,43,'2026-09-07 22:13:16',NULL,'funcional',NULL,43,'Alta: Contenedor incorporado al circuito CH_102.'),(44,44,'2026-09-07 22:13:16',NULL,'funcional',NULL,44,'Alta: Contenedor incorporado al circuito CH_102.'),(45,45,'2026-09-07 22:13:16',NULL,'funcional',NULL,45,'Alta: Contenedor incorporado al circuito CH_102.'),(46,46,'2026-09-07 22:13:18',NULL,'funcional',NULL,46,'Alta: Contenedor incorporado al circuito CH_102.'),(47,47,'2026-09-07 22:13:18',NULL,'funcional',NULL,47,'Alta: Contenedor incorporado al circuito CH_102.'),(48,48,'2026-09-07 22:13:18',NULL,'funcional',NULL,48,'Alta: Contenedor incorporado al circuito CH_102.'),(49,49,'2026-09-07 22:13:18',NULL,'desbordado',NULL,49,'Alta: Contenedor incorporado al circuito CH_102.'),(50,50,'2026-09-07 22:13:18',NULL,'roto',NULL,50,'Alta: Contenedor incorporado al circuito CH_102.'),(51,51,'2026-09-07 22:13:19',NULL,'funcional',NULL,51,'Alta: Contenedor incorporado al circuito CH_105.'),(52,52,'2026-09-07 22:13:19',NULL,'funcional',NULL,52,'Alta: Contenedor incorporado al circuito CH_105.'),(53,53,'2026-09-07 22:13:19',NULL,'funcional',NULL,53,'Alta: Contenedor incorporado al circuito CH_105.'),(54,54,'2026-09-07 22:13:19',NULL,'funcional',NULL,54,'Alta: Contenedor incorporado al circuito CH_105.'),(55,55,'2026-09-07 22:13:19',NULL,'funcional',NULL,55,'Alta: Contenedor incorporado al circuito CH_105.'),(56,56,'2026-09-07 22:13:20',NULL,'funcional',NULL,56,'Alta: Contenedor incorporado al circuito CH_105.'),(57,57,'2026-09-07 22:13:20',NULL,'desbordado',NULL,57,'Alta: Contenedor incorporado al circuito CH_105.'),(58,58,'2026-09-07 22:13:20',NULL,'roto',NULL,58,'Alta: Contenedor incorporado al circuito CH_105.'),(59,59,'2026-09-07 22:13:20',NULL,'desbordado',NULL,59,'Alta: Contenedor incorporado al circuito CH_105.'),(60,60,'2026-09-07 22:13:20',NULL,'roto',NULL,60,'Alta: Contenedor incorporado al circuito CH_105.'),(61,61,'2026-09-07 22:13:20',NULL,'funcional',NULL,61,'Alta: Contenedor incorporado al circuito CH_108.'),(62,62,'2026-09-07 22:13:20',NULL,'funcional',NULL,62,'Alta: Contenedor incorporado al circuito CH_108.'),(63,63,'2026-09-07 22:13:20',NULL,'funcional',NULL,63,'Alta: Contenedor incorporado al circuito CH_108.'),(64,64,'2026-09-07 22:13:21',NULL,'funcional',NULL,64,'Alta: Contenedor incorporado al circuito CH_108.'),(65,65,'2026-09-07 22:13:21',NULL,'funcional',NULL,65,'Alta: Contenedor incorporado al circuito CH_108.'),(66,66,'2026-09-07 22:13:21',NULL,'funcional',NULL,66,'Alta: Contenedor incorporado al circuito CH_108.'),(67,67,'2026-09-07 22:13:21',NULL,'funcional',NULL,67,'Alta: Contenedor incorporado al circuito CH_108.'),(68,68,'2026-09-07 22:13:21',NULL,'funcional',NULL,68,'Alta: Contenedor incorporado al circuito CH_108.'),(69,69,'2026-09-07 22:13:22',NULL,'funcional',NULL,69,'Alta: Contenedor incorporado al circuito CH_108.'),(70,70,'2026-09-07 22:13:22',NULL,'roto',NULL,70,'Alta: Contenedor incorporado al circuito CH_108.'),(71,71,'2026-09-07 22:13:22',NULL,'funcional',NULL,71,'Alta: Contenedor incorporado al circuito CH_109.'),(72,72,'2026-09-07 22:13:22',NULL,'funcional',NULL,72,'Alta: Contenedor incorporado al circuito CH_109.'),(73,73,'2026-09-07 22:13:22',NULL,'funcional',NULL,73,'Alta: Contenedor incorporado al circuito CH_109.'),(74,74,'2026-09-07 22:13:22',NULL,'funcional',NULL,74,'Alta: Contenedor incorporado al circuito CH_109.'),(75,75,'2026-09-07 22:13:23',NULL,'funcional',NULL,75,'Alta: Contenedor incorporado al circuito CH_109.'),(76,76,'2026-09-07 22:13:23',NULL,'funcional',NULL,76,'Alta: Contenedor incorporado al circuito CH_109.'),(77,77,'2026-09-07 22:13:23',NULL,'funcional',NULL,77,'Alta: Contenedor incorporado al circuito CH_109.'),(78,78,'2026-09-07 22:13:23',NULL,'funcional',NULL,78,'Alta: Contenedor incorporado al circuito CH_109.'),(79,79,'2026-09-07 22:13:25',NULL,'desbordado',NULL,79,'Alta: Contenedor incorporado al circuito CH_109.'),(80,80,'2026-09-07 22:13:26',NULL,'roto',NULL,80,'Alta: Contenedor incorporado al circuito CH_109.'),(81,81,'2026-09-07 22:13:26',NULL,'funcional',NULL,81,'Alta: Contenedor incorporado al circuito CH_114.'),(82,82,'2026-09-07 22:13:27',NULL,'funcional',NULL,82,'Alta: Contenedor incorporado al circuito CH_114.'),(83,83,'2026-09-07 22:13:27',NULL,'funcional',NULL,83,'Alta: Contenedor incorporado al circuito CH_114.'),(84,84,'2026-09-07 22:13:28',NULL,'funcional',NULL,84,'Alta: Contenedor incorporado al circuito CH_114.'),(85,85,'2026-09-07 22:13:28',NULL,'funcional',NULL,85,'Alta: Contenedor incorporado al circuito CH_114.'),(86,86,'2026-09-07 22:13:28',NULL,'funcional',NULL,86,'Alta: Contenedor incorporado al circuito CH_114.'),(87,87,'2026-09-07 22:13:28',NULL,'desbordado',NULL,87,'Alta: Contenedor incorporado al circuito CH_114.'),(88,88,'2026-09-07 22:13:29',NULL,'roto',NULL,88,'Alta: Contenedor incorporado al circuito CH_114.'),(89,89,'2026-09-07 22:13:31',NULL,'desbordado',NULL,89,'Alta: Contenedor incorporado al circuito CH_114.'),(90,90,'2026-09-07 22:13:32',NULL,'roto',NULL,90,'Alta: Contenedor incorporado al circuito CH_114.'),(91,91,'2026-09-07 23:39:18',NULL,'funcional',NULL,91,'Alta: Contenedor incorporado al circuito A_101.'),(92,92,'2026-09-07 23:39:20',NULL,'funcional',NULL,92,'Alta: Contenedor incorporado al circuito A_101.'),(93,93,'2026-09-07 23:39:22',NULL,'funcional',NULL,93,'Alta: Contenedor incorporado al circuito A_101.'),(94,94,'2026-09-07 23:39:28',NULL,'funcional',NULL,94,'Alta: Contenedor incorporado al circuito A_101.'),(95,95,'2026-09-07 23:39:30',NULL,'funcional',NULL,95,'Alta: Contenedor incorporado al circuito A_101.'),(96,96,'2026-09-07 23:39:31',NULL,'funcional',NULL,96,'Alta: Contenedor incorporado al circuito A_101.'),(97,97,'2026-09-07 23:39:32',NULL,'funcional',NULL,97,'Alta: Contenedor incorporado al circuito A_101.'),(98,98,'2026-09-07 23:39:34',NULL,'funcional',NULL,98,'Alta: Contenedor incorporado al circuito A_101.'),(99,99,'2026-09-07 23:39:35',NULL,'funcional',NULL,99,'Alta: Contenedor incorporado al circuito A_101.'),(100,100,'2026-09-07 23:39:36',NULL,'roto',NULL,100,'Alta: Contenedor incorporado al circuito A_101.'),(101,101,'2026-09-07 23:39:39',NULL,'funcional',NULL,101,'Alta: Contenedor incorporado al circuito A_102.'),(102,102,'2026-09-07 23:39:42',NULL,'funcional',NULL,102,'Alta: Contenedor incorporado al circuito A_102.'),(103,103,'2026-09-07 23:39:45',NULL,'funcional',NULL,103,'Alta: Contenedor incorporado al circuito A_102.'),(104,104,'2026-09-07 23:39:48',NULL,'funcional',NULL,104,'Alta: Contenedor incorporado al circuito A_102.'),(105,105,'2026-09-07 23:39:48',NULL,'funcional',NULL,105,'Alta: Contenedor incorporado al circuito A_102.'),(106,106,'2026-09-07 23:39:50',NULL,'funcional',NULL,106,'Alta: Contenedor incorporado al circuito A_102.'),(107,107,'2026-09-07 23:39:52',NULL,'funcional',NULL,107,'Alta: Contenedor incorporado al circuito A_102.'),(108,108,'2026-09-07 23:39:52',NULL,'funcional',NULL,108,'Alta: Contenedor incorporado al circuito A_102.'),(109,109,'2026-09-07 23:39:54',NULL,'funcional',NULL,109,'Alta: Contenedor incorporado al circuito A_102.'),(110,110,'2026-09-07 23:39:57',NULL,'roto',NULL,110,'Alta: Contenedor incorporado al circuito A_102.'),(111,111,'2026-09-07 23:39:57',NULL,'funcional',NULL,111,'Alta: Contenedor incorporado al circuito A_103.'),(112,112,'2026-09-07 23:39:59',NULL,'funcional',NULL,112,'Alta: Contenedor incorporado al circuito A_103.'),(113,113,'2026-09-07 23:40:00',NULL,'funcional',NULL,113,'Alta: Contenedor incorporado al circuito A_103.'),(114,114,'2026-09-07 23:40:00',NULL,'funcional',NULL,114,'Alta: Contenedor incorporado al circuito A_103.'),(115,115,'2026-09-07 23:40:06',NULL,'funcional',NULL,115,'Alta: Contenedor incorporado al circuito A_103.'),(116,116,'2026-09-07 23:40:08',NULL,'funcional',NULL,116,'Alta: Contenedor incorporado al circuito A_103.'),(117,117,'2026-09-07 23:40:09',NULL,'funcional',NULL,117,'Alta: Contenedor incorporado al circuito A_103.'),(118,118,'2026-09-07 23:40:11',NULL,'funcional',NULL,118,'Alta: Contenedor incorporado al circuito A_103.'),(119,119,'2026-09-07 23:40:11',NULL,'funcional',NULL,119,'Alta: Contenedor incorporado al circuito A_103.'),(120,120,'2026-09-07 23:40:14',NULL,'roto',NULL,120,'Alta: Contenedor incorporado al circuito A_103.'),(121,121,'2026-09-07 23:40:20',NULL,'funcional',NULL,121,'Alta: Contenedor incorporado al circuito B_05.'),(122,122,'2026-09-07 23:40:24',NULL,'funcional',NULL,122,'Alta: Contenedor incorporado al circuito B_05.'),(123,123,'2026-09-07 23:40:28',NULL,'funcional',NULL,123,'Alta: Contenedor incorporado al circuito B_05.'),(124,124,'2026-09-07 23:40:30',NULL,'funcional',NULL,124,'Alta: Contenedor incorporado al circuito B_05.'),(125,125,'2026-09-07 23:40:31',NULL,'funcional',NULL,125,'Alta: Contenedor incorporado al circuito B_05.'),(126,126,'2026-09-07 23:40:32',NULL,'funcional',NULL,126,'Alta: Contenedor incorporado al circuito B_05.'),(127,127,'2026-09-07 23:40:34',NULL,'funcional',NULL,127,'Alta: Contenedor incorporado al circuito B_05.'),(128,128,'2026-09-07 23:40:35',NULL,'funcional',NULL,128,'Alta: Contenedor incorporado al circuito B_05.'),(129,129,'2026-09-07 23:40:37',NULL,'funcional',NULL,129,'Alta: Contenedor incorporado al circuito B_05.'),(130,130,'2026-09-07 23:40:38',NULL,'roto',NULL,130,'Alta: Contenedor incorporado al circuito B_05.'),(131,131,'2026-09-07 23:40:38',NULL,'funcional',NULL,131,'Alta: Contenedor incorporado al circuito B_06.'),(132,132,'2026-09-07 23:40:39',NULL,'funcional',NULL,132,'Alta: Contenedor incorporado al circuito B_06.'),(133,133,'2026-09-07 23:40:39',NULL,'funcional',NULL,133,'Alta: Contenedor incorporado al circuito B_06.'),(134,134,'2026-09-07 23:40:40',NULL,'funcional',NULL,134,'Alta: Contenedor incorporado al circuito B_06.'),(135,135,'2026-09-07 23:40:47',NULL,'funcional',NULL,135,'Alta: Contenedor incorporado al circuito B_06.'),(136,136,'2026-09-07 23:40:52',NULL,'funcional',NULL,136,'Alta: Contenedor incorporado al circuito B_06.'),(137,137,'2026-09-07 23:40:53',NULL,'funcional',NULL,137,'Alta: Contenedor incorporado al circuito B_06.'),(138,138,'2026-09-07 23:40:54',NULL,'funcional',NULL,138,'Alta: Contenedor incorporado al circuito B_06.'),(139,139,'2026-09-07 23:40:57',NULL,'funcional',NULL,139,'Alta: Contenedor incorporado al circuito B_06.'),(140,140,'2026-09-07 23:41:00',NULL,'roto',NULL,140,'Alta: Contenedor incorporado al circuito B_06.'),(141,141,'2026-09-07 23:41:05',NULL,'funcional',NULL,141,'Alta: Contenedor incorporado al circuito B_7.'),(142,142,'2026-09-07 23:41:06',NULL,'funcional',NULL,142,'Alta: Contenedor incorporado al circuito B_7.'),(143,143,'2026-09-07 23:41:06',NULL,'funcional',NULL,143,'Alta: Contenedor incorporado al circuito B_7.'),(144,144,'2026-09-07 23:41:07',NULL,'funcional',NULL,144,'Alta: Contenedor incorporado al circuito B_7.'),(145,145,'2026-09-07 23:41:08',NULL,'funcional',NULL,145,'Alta: Contenedor incorporado al circuito B_7.'),(146,146,'2026-09-07 23:41:09',NULL,'funcional',NULL,146,'Alta: Contenedor incorporado al circuito B_7.'),(147,147,'2026-09-07 23:41:11',NULL,'funcional',NULL,147,'Alta: Contenedor incorporado al circuito B_7.'),(148,148,'2026-09-07 23:41:11',NULL,'funcional',NULL,148,'Alta: Contenedor incorporado al circuito B_7.'),(149,149,'2026-09-07 23:41:12',NULL,'funcional',NULL,149,'Alta: Contenedor incorporado al circuito B_7.'),(150,150,'2026-09-07 23:41:12',NULL,'roto',NULL,150,'Alta: Contenedor incorporado al circuito B_7.'),(151,151,'2026-09-07 23:41:13',NULL,'funcional',NULL,151,'Alta: Contenedor incorporado al circuito C_102.'),(152,152,'2026-09-07 23:41:13',NULL,'funcional',NULL,152,'Alta: Contenedor incorporado al circuito C_102.'),(153,153,'2026-09-07 23:41:16',NULL,'funcional',NULL,153,'Alta: Contenedor incorporado al circuito C_102.'),(154,154,'2026-09-07 23:41:17',NULL,'funcional',NULL,154,'Alta: Contenedor incorporado al circuito C_102.'),(155,155,'2026-09-07 23:41:18',NULL,'funcional',NULL,155,'Alta: Contenedor incorporado al circuito C_102.'),(156,156,'2026-09-07 23:41:21',NULL,'funcional',NULL,156,'Alta: Contenedor incorporado al circuito C_102.'),(157,157,'2026-09-07 23:41:22',NULL,'funcional',NULL,157,'Alta: Contenedor incorporado al circuito C_102.'),(158,158,'2026-09-07 23:41:22',NULL,'funcional',NULL,158,'Alta: Contenedor incorporado al circuito C_102.'),(159,159,'2026-09-07 23:41:22',NULL,'funcional',NULL,159,'Alta: Contenedor incorporado al circuito C_102.'),(160,160,'2026-09-07 23:41:24',NULL,'roto',NULL,160,'Alta: Contenedor incorporado al circuito C_102.'),(161,161,'2026-09-07 23:41:24',NULL,'funcional',NULL,161,'Alta: Contenedor incorporado al circuito CH_115.'),(162,162,'2026-09-07 23:41:25',NULL,'funcional',NULL,162,'Alta: Contenedor incorporado al circuito CH_115.'),(163,163,'2026-09-07 23:41:27',NULL,'funcional',NULL,163,'Alta: Contenedor incorporado al circuito CH_115.'),(164,164,'2026-09-07 23:41:34',NULL,'funcional',NULL,164,'Alta: Contenedor incorporado al circuito CH_115.'),(165,165,'2026-09-07 23:41:35',NULL,'funcional',NULL,165,'Alta: Contenedor incorporado al circuito CH_115.'),(166,166,'2026-09-07 23:41:37',NULL,'funcional',NULL,166,'Alta: Contenedor incorporado al circuito CH_115.'),(167,167,'2026-09-07 23:41:37',NULL,'funcional',NULL,167,'Alta: Contenedor incorporado al circuito CH_115.'),(168,168,'2026-09-07 23:41:39',NULL,'funcional',NULL,168,'Alta: Contenedor incorporado al circuito CH_115.'),(169,169,'2026-09-07 23:41:42',NULL,'funcional',NULL,169,'Alta: Contenedor incorporado al circuito CH_115.'),(170,170,'2026-09-07 23:41:43',NULL,'roto',NULL,170,'Alta: Contenedor incorporado al circuito CH_115.'),(171,171,'2026-09-07 23:41:44',NULL,'funcional',NULL,171,'Alta: Contenedor incorporado al circuito D_101.'),(172,172,'2026-09-07 23:41:44',NULL,'funcional',NULL,172,'Alta: Contenedor incorporado al circuito D_101.'),(173,173,'2026-09-07 23:41:45',NULL,'funcional',NULL,173,'Alta: Contenedor incorporado al circuito D_101.'),(174,174,'2026-09-07 23:41:45',NULL,'funcional',NULL,174,'Alta: Contenedor incorporado al circuito D_101.'),(175,175,'2026-09-07 23:41:46',NULL,'funcional',NULL,175,'Alta: Contenedor incorporado al circuito D_101.'),(176,176,'2026-09-07 23:41:46',NULL,'funcional',NULL,176,'Alta: Contenedor incorporado al circuito D_101.'),(177,177,'2026-09-07 23:41:46',NULL,'funcional',NULL,177,'Alta: Contenedor incorporado al circuito D_101.'),(178,178,'2026-09-07 23:41:46',NULL,'funcional',NULL,178,'Alta: Contenedor incorporado al circuito D_101.'),(179,179,'2026-09-07 23:41:47',NULL,'funcional',NULL,179,'Alta: Contenedor incorporado al circuito D_101.'),(180,180,'2026-09-07 23:41:49',NULL,'roto',NULL,180,'Alta: Contenedor incorporado al circuito D_101.'),(181,181,'2026-09-07 23:41:49',NULL,'funcional',NULL,181,'Alta: Contenedor incorporado al circuito D_102.'),(182,182,'2026-09-07 23:41:49',NULL,'funcional',NULL,182,'Alta: Contenedor incorporado al circuito D_102.'),(183,183,'2026-09-07 23:41:50',NULL,'funcional',NULL,183,'Alta: Contenedor incorporado al circuito D_102.'),(184,184,'2026-09-07 23:41:50',NULL,'funcional',NULL,184,'Alta: Contenedor incorporado al circuito D_102.'),(185,185,'2026-09-07 23:41:51',NULL,'funcional',NULL,185,'Alta: Contenedor incorporado al circuito D_102.'),(186,186,'2026-09-07 23:41:53',NULL,'funcional',NULL,186,'Alta: Contenedor incorporado al circuito D_102.'),(187,187,'2026-09-07 23:41:53',NULL,'funcional',NULL,187,'Alta: Contenedor incorporado al circuito D_102.'),(188,188,'2026-09-07 23:41:54',NULL,'funcional',NULL,188,'Alta: Contenedor incorporado al circuito D_102.'),(189,189,'2026-09-07 23:41:57',NULL,'funcional',NULL,189,'Alta: Contenedor incorporado al circuito D_102.'),(190,190,'2026-09-07 23:42:02',NULL,'roto',NULL,190,'Alta: Contenedor incorporado al circuito D_102.'),(191,191,'2026-09-07 23:42:07',NULL,'funcional',NULL,191,'Alta: Contenedor incorporado al circuito D_103.'),(192,192,'2026-09-07 23:42:08',NULL,'funcional',NULL,192,'Alta: Contenedor incorporado al circuito D_103.'),(193,193,'2026-09-07 23:42:09',NULL,'funcional',NULL,193,'Alta: Contenedor incorporado al circuito D_103.'),(194,194,'2026-09-07 23:42:10',NULL,'funcional',NULL,194,'Alta: Contenedor incorporado al circuito D_103.'),(195,195,'2026-09-07 23:42:11',NULL,'funcional',NULL,195,'Alta: Contenedor incorporado al circuito D_103.'),(196,196,'2026-09-07 23:42:12',NULL,'funcional',NULL,196,'Alta: Contenedor incorporado al circuito D_103.'),(197,197,'2026-09-07 23:42:12',NULL,'funcional',NULL,197,'Alta: Contenedor incorporado al circuito D_103.'),(198,198,'2026-09-07 23:42:12',NULL,'funcional',NULL,198,'Alta: Contenedor incorporado al circuito D_103.'),(199,199,'2026-09-07 23:42:14',NULL,'funcional',NULL,199,'Alta: Contenedor incorporado al circuito D_103.'),(200,200,'2026-09-07 23:42:16',NULL,'roto',NULL,200,'Alta: Contenedor incorporado al circuito D_103.'),(201,201,'2026-09-07 23:42:16',NULL,'funcional',NULL,201,'Alta: Contenedor incorporado al circuito E_102.'),(202,202,'2026-09-07 23:42:17',NULL,'funcional',NULL,202,'Alta: Contenedor incorporado al circuito E_102.'),(203,203,'2026-09-07 23:42:17',NULL,'funcional',NULL,203,'Alta: Contenedor incorporado al circuito E_102.'),(204,204,'2026-09-07 23:42:17',NULL,'funcional',NULL,204,'Alta: Contenedor incorporado al circuito E_102.'),(205,205,'2026-09-07 23:42:17',NULL,'funcional',NULL,205,'Alta: Contenedor incorporado al circuito E_102.'),(206,206,'2026-09-07 23:42:18',NULL,'funcional',NULL,206,'Alta: Contenedor incorporado al circuito E_102.'),(207,207,'2026-09-07 23:42:19',NULL,'funcional',NULL,207,'Alta: Contenedor incorporado al circuito E_102.'),(208,208,'2026-09-07 23:42:19',NULL,'funcional',NULL,208,'Alta: Contenedor incorporado al circuito E_102.'),(209,209,'2026-09-07 23:42:19',NULL,'funcional',NULL,209,'Alta: Contenedor incorporado al circuito E_102.'),(210,210,'2026-09-07 23:42:19',NULL,'roto',NULL,210,'Alta: Contenedor incorporado al circuito E_102.'),(211,211,'2026-09-07 23:42:20',NULL,'funcional',NULL,211,'Alta: Contenedor incorporado al circuito E_103.'),(212,212,'2026-09-07 23:42:20',NULL,'funcional',NULL,212,'Alta: Contenedor incorporado al circuito E_103.'),(213,213,'2026-09-07 23:42:20',NULL,'funcional',NULL,213,'Alta: Contenedor incorporado al circuito E_103.'),(214,214,'2026-09-07 23:42:20',NULL,'funcional',NULL,214,'Alta: Contenedor incorporado al circuito E_103.'),(215,215,'2026-09-07 23:42:21',NULL,'funcional',NULL,215,'Alta: Contenedor incorporado al circuito E_103.'),(216,216,'2026-09-07 23:42:22',NULL,'funcional',NULL,216,'Alta: Contenedor incorporado al circuito E_103.'),(217,217,'2026-09-07 23:42:23',NULL,'funcional',NULL,217,'Alta: Contenedor incorporado al circuito E_103.'),(218,218,'2026-09-07 23:42:23',NULL,'funcional',NULL,218,'Alta: Contenedor incorporado al circuito E_103.'),(219,219,'2026-09-07 23:42:24',NULL,'funcional',NULL,219,'Alta: Contenedor incorporado al circuito E_103.'),(220,220,'2026-09-07 23:42:25',NULL,'roto',NULL,220,'Alta: Contenedor incorporado al circuito E_103.'),(221,221,'2026-09-07 23:42:26',NULL,'funcional',NULL,221,'Alta: Contenedor incorporado al circuito E_106.'),(222,222,'2026-09-07 23:42:27',NULL,'funcional',NULL,222,'Alta: Contenedor incorporado al circuito E_106.'),(223,223,'2026-09-07 23:42:28',NULL,'funcional',NULL,223,'Alta: Contenedor incorporado al circuito E_106.'),(224,224,'2026-09-07 23:42:30',NULL,'funcional',NULL,224,'Alta: Contenedor incorporado al circuito E_106.'),(225,225,'2026-09-07 23:42:31',NULL,'funcional',NULL,225,'Alta: Contenedor incorporado al circuito E_106.'),(226,226,'2026-09-07 23:42:32',NULL,'funcional',NULL,226,'Alta: Contenedor incorporado al circuito E_106.'),(227,227,'2026-09-07 23:42:33',NULL,'funcional',NULL,227,'Alta: Contenedor incorporado al circuito E_106.'),(228,228,'2026-09-07 23:42:34',NULL,'funcional',NULL,228,'Alta: Contenedor incorporado al circuito E_106.'),(229,229,'2026-09-07 23:42:37',NULL,'funcional',NULL,229,'Alta: Contenedor incorporado al circuito E_106.'),(230,230,'2026-09-07 23:42:38',NULL,'roto',NULL,230,'Alta: Contenedor incorporado al circuito E_106.'),(231,231,'2026-09-07 23:42:38',NULL,'funcional',NULL,231,'Alta: Contenedor incorporado al circuito F_101.'),(232,232,'2026-09-07 23:42:38',NULL,'funcional',NULL,232,'Alta: Contenedor incorporado al circuito F_101.'),(233,233,'2026-09-07 23:42:39',NULL,'funcional',NULL,233,'Alta: Contenedor incorporado al circuito F_101.'),(234,234,'2026-09-07 23:42:39',NULL,'funcional',NULL,234,'Alta: Contenedor incorporado al circuito F_101.'),(235,235,'2026-09-07 23:42:39',NULL,'funcional',NULL,235,'Alta: Contenedor incorporado al circuito F_101.'),(236,236,'2026-09-07 23:42:39',NULL,'funcional',NULL,236,'Alta: Contenedor incorporado al circuito F_101.'),(237,237,'2026-09-07 23:42:40',NULL,'funcional',NULL,237,'Alta: Contenedor incorporado al circuito F_101.'),(238,238,'2026-09-07 23:42:41',NULL,'funcional',NULL,238,'Alta: Contenedor incorporado al circuito F_101.'),(239,239,'2026-09-07 23:42:42',NULL,'funcional',NULL,239,'Alta: Contenedor incorporado al circuito F_101.'),(240,240,'2026-09-07 23:42:42',NULL,'roto',NULL,240,'Alta: Contenedor incorporado al circuito F_101.'),(241,241,'2026-09-07 23:42:43',NULL,'funcional',NULL,241,'Alta: Contenedor incorporado al circuito F_102.'),(242,242,'2026-09-07 23:42:43',NULL,'funcional',NULL,242,'Alta: Contenedor incorporado al circuito F_102.'),(243,243,'2026-09-07 23:42:43',NULL,'funcional',NULL,243,'Alta: Contenedor incorporado al circuito F_102.'),(244,244,'2026-09-07 23:42:43',NULL,'funcional',NULL,244,'Alta: Contenedor incorporado al circuito F_102.'),(245,245,'2026-09-07 23:42:43',NULL,'funcional',NULL,245,'Alta: Contenedor incorporado al circuito F_102.'),(246,246,'2026-09-07 23:42:46',NULL,'funcional',NULL,246,'Alta: Contenedor incorporado al circuito F_102.'),(247,247,'2026-09-07 23:42:47',NULL,'funcional',NULL,247,'Alta: Contenedor incorporado al circuito F_102.'),(248,248,'2026-09-07 23:42:47',NULL,'funcional',NULL,248,'Alta: Contenedor incorporado al circuito F_102.'),(249,249,'2026-09-07 23:42:47',NULL,'funcional',NULL,249,'Alta: Contenedor incorporado al circuito F_102.'),(250,250,'2026-09-07 23:42:48',NULL,'roto',NULL,250,'Alta: Contenedor incorporado al circuito F_102.'),(251,251,'2026-09-07 23:42:48',NULL,'funcional',NULL,251,'Alta: Contenedor incorporado al circuito F_103.'),(252,252,'2026-09-07 23:42:48',NULL,'funcional',NULL,252,'Alta: Contenedor incorporado al circuito F_103.'),(253,253,'2026-09-07 23:42:48',NULL,'funcional',NULL,253,'Alta: Contenedor incorporado al circuito F_103.'),(254,254,'2026-09-07 23:42:49',NULL,'funcional',NULL,254,'Alta: Contenedor incorporado al circuito F_103.'),(255,255,'2026-09-07 23:42:50',NULL,'funcional',NULL,255,'Alta: Contenedor incorporado al circuito F_103.'),(256,256,'2026-09-07 23:42:53',NULL,'funcional',NULL,256,'Alta: Contenedor incorporado al circuito F_103.'),(257,257,'2026-09-07 23:42:54',NULL,'funcional',NULL,257,'Alta: Contenedor incorporado al circuito F_103.'),(258,258,'2026-09-07 23:42:54',NULL,'funcional',NULL,258,'Alta: Contenedor incorporado al circuito F_103.'),(259,259,'2026-09-07 23:42:55',NULL,'funcional',NULL,259,'Alta: Contenedor incorporado al circuito F_103.'),(260,260,'2026-09-07 23:42:56',NULL,'roto',NULL,260,'Alta: Contenedor incorporado al circuito F_103.'),(261,261,'2026-09-07 23:42:56',NULL,'funcional',NULL,261,'Alta: Contenedor incorporado al circuito G_101.'),(262,262,'2026-09-07 23:42:57',NULL,'funcional',NULL,262,'Alta: Contenedor incorporado al circuito G_101.'),(263,263,'2026-09-07 23:42:59',NULL,'funcional',NULL,263,'Alta: Contenedor incorporado al circuito G_101.'),(264,264,'2026-09-07 23:42:59',NULL,'funcional',NULL,264,'Alta: Contenedor incorporado al circuito G_101.'),(265,265,'2026-09-07 23:43:01',NULL,'funcional',NULL,265,'Alta: Contenedor incorporado al circuito G_101.'),(266,266,'2026-09-07 23:43:01',NULL,'funcional',NULL,266,'Alta: Contenedor incorporado al circuito G_101.'),(267,267,'2026-09-07 23:43:01',NULL,'funcional',NULL,267,'Alta: Contenedor incorporado al circuito G_101.'),(268,268,'2026-09-07 23:43:02',NULL,'funcional',NULL,268,'Alta: Contenedor incorporado al circuito G_101.'),(269,269,'2026-09-07 23:43:04',NULL,'funcional',NULL,269,'Alta: Contenedor incorporado al circuito G_101.'),(270,270,'2026-09-07 23:43:05',NULL,'roto',NULL,270,'Alta: Contenedor incorporado al circuito G_101.'),(271,271,'2026-09-07 23:43:05',NULL,'funcional',NULL,271,'Alta: Contenedor incorporado al circuito G_102.'),(272,272,'2026-09-07 23:43:05',NULL,'funcional',NULL,272,'Alta: Contenedor incorporado al circuito G_102.'),(273,273,'2026-09-07 23:43:05',NULL,'funcional',NULL,273,'Alta: Contenedor incorporado al circuito G_102.'),(274,274,'2026-09-07 23:43:05',NULL,'funcional',NULL,274,'Alta: Contenedor incorporado al circuito G_102.'),(275,275,'2026-09-07 23:43:06',NULL,'funcional',NULL,275,'Alta: Contenedor incorporado al circuito G_102.'),(276,276,'2026-09-07 23:43:06',NULL,'funcional',NULL,276,'Alta: Contenedor incorporado al circuito G_102.'),(277,277,'2026-09-07 23:43:07',NULL,'funcional',NULL,277,'Alta: Contenedor incorporado al circuito G_102.'),(278,278,'2026-09-07 23:43:07',NULL,'funcional',NULL,278,'Alta: Contenedor incorporado al circuito G_102.'),(279,279,'2026-09-07 23:43:08',NULL,'funcional',NULL,279,'Alta: Contenedor incorporado al circuito G_102.'),(280,280,'2026-09-07 23:43:08',NULL,'roto',NULL,280,'Alta: Contenedor incorporado al circuito G_102.'),(281,281,'2026-09-07 23:43:08',NULL,'funcional',NULL,281,'Alta: Contenedor incorporado al circuito G_103.'),(282,282,'2026-09-07 23:43:09',NULL,'funcional',NULL,282,'Alta: Contenedor incorporado al circuito G_103.'),(283,283,'2026-09-07 23:43:09',NULL,'funcional',NULL,283,'Alta: Contenedor incorporado al circuito G_103.'),(284,284,'2026-09-07 23:43:09',NULL,'funcional',NULL,284,'Alta: Contenedor incorporado al circuito G_103.'),(285,285,'2026-09-07 23:43:10',NULL,'funcional',NULL,285,'Alta: Contenedor incorporado al circuito G_103.'),(286,286,'2026-09-07 23:43:10',NULL,'funcional',NULL,286,'Alta: Contenedor incorporado al circuito G_103.'),(287,287,'2026-09-07 23:43:10',NULL,'funcional',NULL,287,'Alta: Contenedor incorporado al circuito G_103.'),(288,288,'2026-09-07 23:43:12',NULL,'funcional',NULL,288,'Alta: Contenedor incorporado al circuito G_103.'),(289,289,'2026-09-07 23:43:13',NULL,'funcional',NULL,289,'Alta: Contenedor incorporado al circuito G_103.'),(290,290,'2026-09-07 23:43:13',NULL,'roto',NULL,290,'Alta: Contenedor incorporado al circuito G_103.');
/*!40000 ALTER TABLE `historial_contenedores` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `incidencias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `incidencias` (
  `id_incidencia` int(11) NOT NULL AUTO_INCREMENT,
  `tipo_recurso` varchar(30) NOT NULL,
  `id_camion` int(11) DEFAULT NULL,
  `id_contenedor` int(11) DEFAULT NULL,
  `tipo` varchar(100) NOT NULL,
  `estado` varchar(30) NOT NULL DEFAULT 'Abierta',
  `fecha_reporte` datetime NOT NULL DEFAULT current_timestamp(),
  `fecha_resolucion` datetime DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `responsable` varchar(150) DEFAULT NULL,
  `resolucion` text DEFAULT NULL,
  `id_cuadrilla` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id_incidencia`),
  KEY `id_camion` (`id_camion`),
  KEY `id_contenedor` (`id_contenedor`),
  KEY `id_cuadrilla` (`id_cuadrilla`),
  CONSTRAINT `incidencias_ibfk_1` FOREIGN KEY (`id_camion`) REFERENCES `camiones` (`id_camion`),
  CONSTRAINT `incidencias_ibfk_2` FOREIGN KEY (`id_contenedor`) REFERENCES `contenedores` (`id_contenedor`),
  CONSTRAINT `incidencias_ibfk_3` FOREIGN KEY (`id_cuadrilla`) REFERENCES `cuadrilla` (`id_cuadrilla`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `incidencias` WRITE;
/*!40000 ALTER TABLE `incidencias` DISABLE KEYS */;
INSERT INTO `incidencias` VALUES (1,'cuadrilla',NULL,NULL,'Contenedor desbordado','Resuelta','2026-06-28 00:00:00','2026-06-28 00:00:00','Se retiraron residuos acumulados y se normalizó el punto.',NULL,NULL,'B-02'),(2,'cuadrilla',NULL,NULL,'Rotura de contenedor','Resuelta','2026-06-19 00:00:00','2026-06-19 00:00:00','Se informó la rotura y se dejó el contenedor fuera de servicio.',NULL,NULL,'CH_03'),(3,'cuadrilla',NULL,NULL,'Falta de recolección','En curso','2026-07-25 00:00:00',NULL,'Circuito pendiente de completar por demora operativa.',NULL,NULL,'CH_02'),(4,'camion',5,NULL,'Mecánica','Resuelta','2026-07-12 00:00:00',NULL,'Revisión del sistema de frenos.',NULL,NULL,NULL),(5,'camion',5,NULL,'Tránsito','Resuelta','2026-07-05 00:00:00',NULL,'Demora operativa registrada durante el recorrido.',NULL,NULL,NULL),(6,'camion',7,NULL,'Sistema hidráulico','Abierta','2026-07-24 00:00:00',NULL,'Falla detectada en el sistema hidráulico. El camión permanece en base para revisión.',NULL,NULL,NULL),(7,'camion',6,NULL,'Mecánica','En curso','2026-07-24 00:00:00',NULL,'Revisión preventiva del sistema de frenos.','Taller municipal','Diagnóstico en proceso.',NULL),(8,'camion',8,NULL,'Neumático','Resuelta','2026-07-20 00:00:00','2026-07-20 00:00:00','Daño en neumático trasero.','Taller municipal','Neumático sustituido.',NULL),(9,'contenedor',NULL,19,'Desborde','Abierta','2026-09-07 22:13:06',NULL,'Contenedor CONT-B02-09 registrado con estado desbordado.',NULL,NULL,NULL),(10,'contenedor',NULL,27,'Desborde','Abierta','2026-09-07 22:13:08',NULL,'Contenedor CONT-B03-07 registrado con estado desbordado.',NULL,NULL,NULL),(11,'contenedor',NULL,29,'Desborde','Abierta','2026-09-07 22:13:08',NULL,'Contenedor CONT-B03-09 registrado con estado desbordado.',NULL,NULL,NULL),(12,'contenedor',NULL,49,'Desborde','Abierta','2026-09-07 22:13:18',NULL,'Contenedor CONT-CH102-09 registrado con estado desbordado.',NULL,NULL,NULL),(13,'contenedor',NULL,57,'Desborde','Abierta','2026-09-07 22:13:20',NULL,'Contenedor CONT-CH105-07 registrado con estado desbordado.',NULL,NULL,NULL),(14,'contenedor',NULL,59,'Desborde','Abierta','2026-09-07 22:13:20',NULL,'Contenedor CONT-CH105-09 registrado con estado desbordado.',NULL,NULL,NULL),(15,'contenedor',NULL,79,'Desborde','Abierta','2026-09-07 22:13:25',NULL,'Contenedor CONT-CH109-09 registrado con estado desbordado.',NULL,NULL,NULL),(16,'contenedor',NULL,87,'Desborde','Abierta','2026-09-07 22:13:28',NULL,'Contenedor CONT-CH114-07 registrado con estado desbordado.',NULL,NULL,NULL),(17,'contenedor',NULL,89,'Desborde','Abierta','2026-09-07 22:13:31',NULL,'Contenedor CONT-CH114-09 registrado con estado desbordado.',NULL,NULL,NULL),(24,'contenedor',NULL,10,'Rotura','Abierta','2026-09-07 22:13:05',NULL,'Contenedor CONT-B01-10 registrado con estado roto.',NULL,NULL,NULL),(25,'contenedor',NULL,20,'Rotura','Abierta','2026-09-07 22:13:07',NULL,'Contenedor CONT-B02-10 registrado con estado roto.',NULL,NULL,NULL),(26,'contenedor',NULL,26,'Rotura','Abierta','2026-09-07 22:13:08',NULL,'Contenedor CONT-B03-06 registrado con estado roto.',NULL,NULL,NULL),(27,'contenedor',NULL,28,'Rotura','Abierta','2026-09-07 22:13:08',NULL,'Contenedor CONT-B03-08 registrado con estado roto.',NULL,NULL,NULL),(28,'contenedor',NULL,30,'Rotura','Abierta','2026-09-07 22:13:09',NULL,'Contenedor CONT-B03-10 registrado con estado roto.',NULL,NULL,NULL),(29,'contenedor',NULL,50,'Rotura','Abierta','2026-09-07 22:13:18',NULL,'Contenedor CONT-CH102-10 registrado con estado roto.',NULL,NULL,NULL),(30,'contenedor',NULL,58,'Rotura','Abierta','2026-09-07 22:13:20',NULL,'Contenedor CONT-CH105-08 registrado con estado roto.',NULL,NULL,NULL),(31,'contenedor',NULL,60,'Rotura','Abierta','2026-09-07 22:13:20',NULL,'Contenedor CONT-CH105-10 registrado con estado roto.',NULL,NULL,NULL),(32,'contenedor',NULL,70,'Rotura','Abierta','2026-09-07 22:13:22',NULL,'Contenedor CONT-CH108-10 registrado con estado roto.',NULL,NULL,NULL),(33,'contenedor',NULL,80,'Rotura','Abierta','2026-09-07 22:13:26',NULL,'Contenedor CONT-CH109-10 registrado con estado roto.',NULL,NULL,NULL),(34,'contenedor',NULL,88,'Rotura','Abierta','2026-09-07 22:13:29',NULL,'Contenedor CONT-CH114-08 registrado con estado roto.',NULL,NULL,NULL),(35,'contenedor',NULL,90,'Rotura','Abierta','2026-09-07 22:13:32',NULL,'Contenedor CONT-CH114-10 registrado con estado roto.',NULL,NULL,NULL),(36,'contenedor',NULL,100,'Rotura','Abierta','2026-09-07 23:39:36',NULL,'Contenedor CONT-A101-10 registrado con estado roto.',NULL,NULL,NULL),(37,'contenedor',NULL,110,'Rotura','Abierta','2026-09-07 23:39:57',NULL,'Contenedor CONT-A102-10 registrado con estado roto.',NULL,NULL,NULL),(38,'contenedor',NULL,120,'Rotura','Abierta','2026-09-07 23:40:14',NULL,'Contenedor CONT-A103-10 registrado con estado roto.',NULL,NULL,NULL),(39,'contenedor',NULL,130,'Rotura','Abierta','2026-09-07 23:40:38',NULL,'Contenedor CONT-B05-10 registrado con estado roto.',NULL,NULL,NULL),(40,'contenedor',NULL,140,'Rotura','Abierta','2026-09-07 23:41:00',NULL,'Contenedor CONT-B06-10 registrado con estado roto.',NULL,NULL,NULL),(41,'contenedor',NULL,150,'Rotura','Abierta','2026-09-07 23:41:12',NULL,'Contenedor CONT-B7-10 registrado con estado roto.',NULL,NULL,NULL),(42,'contenedor',NULL,160,'Rotura','Abierta','2026-09-07 23:41:24',NULL,'Contenedor CONT-C102-10 registrado con estado roto.',NULL,NULL,NULL),(43,'contenedor',NULL,170,'Rotura','Abierta','2026-09-07 23:41:43',NULL,'Contenedor CONT-CH115-10 registrado con estado roto.',NULL,NULL,NULL),(44,'contenedor',NULL,180,'Rotura','Abierta','2026-09-07 23:41:49',NULL,'Contenedor CONT-D101-10 registrado con estado roto.',NULL,NULL,NULL),(45,'contenedor',NULL,190,'Rotura','Abierta','2026-09-07 23:42:02',NULL,'Contenedor CONT-D102-10 registrado con estado roto.',NULL,NULL,NULL),(46,'contenedor',NULL,200,'Rotura','Abierta','2026-09-07 23:42:16',NULL,'Contenedor CONT-D103-10 registrado con estado roto.',NULL,NULL,NULL),(47,'contenedor',NULL,210,'Rotura','Abierta','2026-09-07 23:42:19',NULL,'Contenedor CONT-E102-10 registrado con estado roto.',NULL,NULL,NULL),(48,'contenedor',NULL,220,'Rotura','Abierta','2026-09-07 23:42:25',NULL,'Contenedor CONT-E103-10 registrado con estado roto.',NULL,NULL,NULL),(49,'contenedor',NULL,230,'Rotura','Abierta','2026-09-07 23:42:38',NULL,'Contenedor CONT-E106-10 registrado con estado roto.',NULL,NULL,NULL),(50,'contenedor',NULL,240,'Rotura','Abierta','2026-09-07 23:42:42',NULL,'Contenedor CONT-F101-10 registrado con estado roto.',NULL,NULL,NULL),(51,'contenedor',NULL,250,'Rotura','Abierta','2026-09-07 23:42:48',NULL,'Contenedor CONT-F102-10 registrado con estado roto.',NULL,NULL,NULL),(52,'contenedor',NULL,260,'Rotura','Abierta','2026-09-07 23:42:56',NULL,'Contenedor CONT-F103-10 registrado con estado roto.',NULL,NULL,NULL),(53,'contenedor',NULL,270,'Rotura','Abierta','2026-09-07 23:43:05',NULL,'Contenedor CONT-G101-10 registrado con estado roto.',NULL,NULL,NULL),(54,'contenedor',NULL,280,'Rotura','Abierta','2026-09-07 23:43:08',NULL,'Contenedor CONT-G102-10 registrado con estado roto.',NULL,NULL,NULL),(55,'contenedor',NULL,290,'Rotura','Resuelta','2026-09-07 23:43:13','2026-09-08 21:51:59','Contenedor CONT-G103-10 registrado con estado roto.',NULL,NULL,NULL);
/*!40000 ALTER TABLE `incidencias` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `instalacion_operario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instalacion_operario` (
  `id_asignacion` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL,
  `id_instalacion` int(11) NOT NULL,
  `fecha_asignacion` datetime NOT NULL DEFAULT current_timestamp(),
  `fecha_finalizacion` datetime DEFAULT NULL,
  PRIMARY KEY (`id_asignacion`),
  KEY `id_usuario` (`id_usuario`),
  KEY `id_instalacion` (`id_instalacion`),
  CONSTRAINT `instalacion_operario_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `operario` (`id_usuario`),
  CONSTRAINT `instalacion_operario_ibfk_2` FOREIGN KEY (`id_instalacion`) REFERENCES `instalaciones` (`id_instalacion`) ON DELETE CASCADE,
  CONSTRAINT `chk_instalacion_operario_fechas` CHECK (`fecha_finalizacion` is null or `fecha_finalizacion` >= `fecha_asignacion`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `instalacion_operario` WRITE;
/*!40000 ALTER TABLE `instalacion_operario` DISABLE KEYS */;
INSERT INTO `instalacion_operario` VALUES (1,4,2,'2026-09-09 06:35:14',NULL),(2,14,1,'2026-09-09 06:40:52',NULL),(3,13,3,'2026-09-09 06:41:01',NULL);
/*!40000 ALTER TABLE `instalacion_operario` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `instalacion_tipo_residuo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instalacion_tipo_residuo` (
  `id_instalacion` int(11) NOT NULL,
  `tipo` varchar(30) NOT NULL,
  PRIMARY KEY (`id_instalacion`,`tipo`),
  KEY `tipo` (`tipo`),
  CONSTRAINT `instalacion_tipo_residuo_ibfk_1` FOREIGN KEY (`id_instalacion`) REFERENCES `instalaciones` (`id_instalacion`) ON DELETE CASCADE,
  CONSTRAINT `instalacion_tipo_residuo_ibfk_2` FOREIGN KEY (`tipo`) REFERENCES `tipo_residuo` (`tipo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `instalacion_tipo_residuo` WRITE;
/*!40000 ALTER TABLE `instalacion_tipo_residuo` DISABLE KEYS */;
INSERT INTO `instalacion_tipo_residuo` VALUES (4,'general'),(5,'general'),(6,'general'),(7,'general');
/*!40000 ALTER TABLE `instalacion_tipo_residuo` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `instalaciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instalaciones` (
  `id_instalacion` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `tipo` varchar(50) NOT NULL,
  `capacidad` decimal(10,2) NOT NULL,
  `capacidad_actual` decimal(10,2) NOT NULL DEFAULT 0.00,
  `unidad_capacidad` varchar(20) NOT NULL DEFAULT 'porcentaje',
  `estado` varchar(30) NOT NULL,
  `id_ubicacion` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_instalacion`),
  KEY `id_ubicacion` (`id_ubicacion`),
  CONSTRAINT `instalaciones_ibfk_1` FOREIGN KEY (`id_ubicacion`) REFERENCES `ubicacion` (`id_ubicacion`),
  CONSTRAINT `chk_instalaciones_capacidad` CHECK (`capacidad` > 0 and `capacidad_actual` >= 0 and `capacidad_actual` <= `capacidad`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `instalaciones` WRITE;
/*!40000 ALTER TABLE `instalaciones` DISABLE KEYS */;
INSERT INTO `instalaciones` VALUES (1,'Estación Buceo','Depósito',100.00,85.00,'porcentaje','Operativo',291),(2,'Cantón 2','Depósito',100.00,100.00,'porcentaje','No operativo',292),(3,'Usina 3','Depósito',100.00,50.00,'porcentaje','Operativo',293),(4,'Géminis','Centro de acopio',100.00,85.00,'porcentaje','Operativo',294),(5,'Durán','Centro de acopio',100.00,100.00,'porcentaje','No operativo',295),(6,'Tróccoli','Centro de acopio',100.00,50.00,'porcentaje','Operativo',296),(7,'Felipe Cardoso','Vertedero',100.00,50.00,'porcentaje','Operativo',297);
/*!40000 ALTER TABLE `instalaciones` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `inventario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inventario` (
  `id_inventario` int(11) NOT NULL AUTO_INCREMENT,
  `id_instalacion` int(11) NOT NULL,
  `nombre_item` varchar(100) NOT NULL,
  `estado` varchar(30) DEFAULT NULL,
  `tipo` varchar(50) DEFAULT NULL,
  `cantidad` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_inventario`),
  KEY `id_instalacion` (`id_instalacion`),
  CONSTRAINT `inventario_ibfk_1` FOREIGN KEY (`id_instalacion`) REFERENCES `instalaciones` (`id_instalacion`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `inventario` WRITE;
/*!40000 ALTER TABLE `inventario` DISABLE KEYS */;
INSERT INTO `inventario` VALUES (1,1,'Escoba','Excelente','Limpieza',52),(2,1,'Pala','Carencia','Limpieza',27),(3,1,'Llave inglesa','Óptimo','Mantenimiento',11),(4,1,'Carro de barrendero','Disponible','Equipamiento',18),(5,1,'Escobillón de calle','Disponible','Limpieza',35),(6,1,'Cepillo de cordón','Disponible','Limpieza',34),(7,1,'Recogedor industrial','Disponible','Limpieza',22),(8,1,'Pinza recolectora','Disponible','Limpieza',16),(9,1,'Rastrillo metálico','Disponible','Limpieza',15),(10,1,'Chaleco reflectivo','Disponible','Seguridad',48),(11,1,'Guantes de protección','Disponible','Seguridad',96),(12,1,'Conos de señalización','Disponible','Seguridad',30),(13,1,'Bolsas reforzadas','Disponible','Insumo',240),(16,2,'Escoba','Carencia','Limpieza',4),(17,2,'Pala','Disponible','Limpieza',9),(19,3,'Carro de barrendero','Disponible','Equipamiento',8),(20,3,'Chaleco reflectivo','Disponible','Seguridad',21);
/*!40000 ALTER TABLE `inventario` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `mantenimientos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mantenimientos` (
  `id_mantenimiento` int(11) NOT NULL AUTO_INCREMENT,
  `id_camion` int(11) NOT NULL,
  `estado` varchar(30) DEFAULT NULL,
  `fecha_inicio` datetime DEFAULT NULL,
  `fecha_fin` datetime DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `tipo` varchar(50) DEFAULT NULL,
  `costo` decimal(10,2) DEFAULT NULL,
  `responsable` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id_mantenimiento`),
  KEY `id_camion` (`id_camion`),
  CONSTRAINT `mantenimientos_ibfk_1` FOREIGN KEY (`id_camion`) REFERENCES `camiones` (`id_camion`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `mantenimientos` WRITE;
/*!40000 ALTER TABLE `mantenimientos` DISABLE KEYS */;
INSERT INTO `mantenimientos` VALUES (1,5,'Resuelta','2026-07-18 00:00:00',NULL,'Cambio preventivo de filtros y revisión general.','Mantenimiento',NULL,NULL),(2,6,'Abierta','2026-07-24 00:00:00',NULL,'Revisión preventiva solicitada.','Mantenimiento',NULL,NULL);
/*!40000 ALTER TABLE `mantenimientos` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `operario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `operario` (
  `id_usuario` int(11) NOT NULL,
  `fecha_aprobacion` datetime DEFAULT NULL,
  PRIMARY KEY (`id_usuario`),
  CONSTRAINT `operario_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `operario` WRITE;
/*!40000 ALTER TABLE `operario` DISABLE KEYS */;
INSERT INTO `operario` VALUES (4,'2026-09-05 21:11:28'),(12,'2026-09-06 08:19:37'),(13,'2026-09-06 08:19:38'),(14,'2026-09-06 08:19:40');
/*!40000 ALTER TABLE `operario` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `rec_password`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rec_password` (
  `id_solicitud` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL,
  `estado` varchar(30) NOT NULL DEFAULT 'pendiente',
  `codigo` varchar(100) NOT NULL,
  `fecha_solicitud` datetime NOT NULL DEFAULT current_timestamp(),
  `fecha_expiracion` datetime DEFAULT NULL,
  PRIMARY KEY (`id_solicitud`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `rec_password_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `rec_password` WRITE;
/*!40000 ALTER TABLE `rec_password` DISABLE KEYS */;
/*!40000 ALTER TABLE `rec_password` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `reclamos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reclamos` (
  `id_reclamo` varchar(30) NOT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `reclamante` varchar(200) DEFAULT NULL,
  `contacto` varchar(100) DEFAULT NULL,
  `categoria` varchar(100) NOT NULL,
  `tipo` varchar(100) DEFAULT NULL,
  `zona` varchar(150) DEFAULT NULL,
  `referencia` varchar(200) DEFAULT NULL,
  `ubicacion` varchar(255) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `foto` varchar(255) DEFAULT NULL,
  `estado` varchar(30) NOT NULL DEFAULT 'sin_asignar',
  `prioridad` varchar(20) DEFAULT NULL,
  `id_cuadrilla` varchar(20) DEFAULT NULL,
  `id_contenedor` int(11) DEFAULT NULL,
  `fecha_reporte` datetime NOT NULL DEFAULT current_timestamp(),
  `fecha_finalizacion` datetime DEFAULT NULL,
  `resultado` varchar(255) DEFAULT NULL,
  `notificado` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_reclamo`),
  KEY `id_usuario` (`id_usuario`),
  KEY `id_cuadrilla` (`id_cuadrilla`),
  KEY `id_contenedor` (`id_contenedor`),
  CONSTRAINT `reclamos_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`),
  CONSTRAINT `reclamos_ibfk_2` FOREIGN KEY (`id_cuadrilla`) REFERENCES `cuadrilla` (`id_cuadrilla`),
  CONSTRAINT `reclamos_ibfk_3` FOREIGN KEY (`id_contenedor`) REFERENCES `contenedores` (`id_contenedor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `reclamos` WRITE;
/*!40000 ALTER TABLE `reclamos` DISABLE KEYS */;
INSERT INTO `reclamos` VALUES ('Jun26-1236',NULL,'Juliet Lopez','091 589 965','Contenedor desbordado',NULL,NULL,NULL,'Av. Gral. Rivera esq. Santiago Rivas',NULL,NULL,'completado','Baja','CH_03',NULL,'2026-06-19 00:00:00','2026-06-19 00:00:00','../resources/Contenedor_Reclamo_Completo.png',0),('Jun26-A1234',NULL,NULL,NULL,'Reclamo histórico',NULL,NULL,NULL,NULL,NULL,NULL,'completado',NULL,'B-03',NULL,'2026-06-27 00:00:00','2026-06-27 00:00:00',NULL,0),('Jun26-B7483',NULL,'Juana Castillos','091 589 965','Contenedor desbordado',NULL,NULL,NULL,'Mercedes esq. Río Branco',NULL,NULL,'completado','Media','B-02',NULL,'2026-06-28 00:00:00','2026-06-28 00:00:00',NULL,0),('Jun26-C9753',NULL,'María De María','091 589 965','Contenedor desbordado',NULL,NULL,NULL,'Av. Millán esq. Sitio Grande',NULL,NULL,'sin_asignar','Alta',NULL,NULL,'2026-06-26 00:00:00',NULL,NULL,0),('Jun26-F0056',NULL,NULL,NULL,'Reclamo histórico',NULL,NULL,NULL,NULL,NULL,NULL,'asignado',NULL,'CH_01',NULL,'2026-07-22 00:00:00',NULL,NULL,0);
/*!40000 ALTER TABLE `reclamos` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `recoleccion_contenedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recoleccion_contenedor` (
  `id_recoleccion` int(11) NOT NULL,
  `id_contenedor` int(11) NOT NULL,
  `fecha` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id_recoleccion`,`id_contenedor`),
  KEY `id_contenedor` (`id_contenedor`),
  CONSTRAINT `recoleccion_contenedor_ibfk_1` FOREIGN KEY (`id_recoleccion`) REFERENCES `recolecciones` (`id_recoleccion`) ON DELETE CASCADE,
  CONSTRAINT `recoleccion_contenedor_ibfk_2` FOREIGN KEY (`id_contenedor`) REFERENCES `contenedores` (`id_contenedor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `recoleccion_contenedor` WRITE;
/*!40000 ALTER TABLE `recoleccion_contenedor` DISABLE KEYS */;
/*!40000 ALTER TABLE `recoleccion_contenedor` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `recolecciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recolecciones` (
  `id_recoleccion` int(11) NOT NULL AUTO_INCREMENT,
  `id_camion` int(11) NOT NULL,
  `id_ruta` int(11) DEFAULT NULL,
  `id_cuadrilla` varchar(20) DEFAULT NULL,
  `fecha_inicio` datetime DEFAULT NULL,
  `fecha_fin` datetime DEFAULT NULL,
  `tipo` varchar(30) NOT NULL,
  `volumen_recolectado` decimal(10,2) DEFAULT NULL,
  `peso_recolectado_kg` decimal(10,2) DEFAULT NULL,
  `contenedores_recolectados` int(11) DEFAULT 0,
  `estado` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id_recoleccion`),
  KEY `id_camion` (`id_camion`),
  KEY `id_ruta` (`id_ruta`),
  KEY `id_cuadrilla` (`id_cuadrilla`),
  KEY `tipo` (`tipo`),
  CONSTRAINT `recolecciones_ibfk_1` FOREIGN KEY (`id_camion`) REFERENCES `camiones` (`id_camion`),
  CONSTRAINT `recolecciones_ibfk_2` FOREIGN KEY (`id_ruta`) REFERENCES `rutas` (`id_ruta`),
  CONSTRAINT `recolecciones_ibfk_3` FOREIGN KEY (`id_cuadrilla`) REFERENCES `cuadrilla` (`id_cuadrilla`),
  CONSTRAINT `recolecciones_ibfk_4` FOREIGN KEY (`tipo`) REFERENCES `tipo_residuo` (`tipo`),
  CONSTRAINT `chk_recolecciones_cantidades` CHECK ((`volumen_recolectado` is null or `volumen_recolectado` >= 0) and (`peso_recolectado_kg` is null or `peso_recolectado_kg` >= 0) and (`contenedores_recolectados` is null or `contenedores_recolectados` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `recolecciones` WRITE;
/*!40000 ALTER TABLE `recolecciones` DISABLE KEYS */;
/*!40000 ALTER TABLE `recolecciones` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `rol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rol` (
  `id_rol` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_rol`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `rol` WRITE;
/*!40000 ALTER TABLE `rol` DISABLE KEYS */;
INSERT INTO `rol` VALUES (1,'administrador','Administración y supervisión general del sistema'),(2,'supervisor','Supervisión de operaciones'),(3,'chofer','Conducción de camiones de recolección'),(4,'cuadrilla','Personal de recolección y limpieza'),(5,'barrendero','Personal de limpieza urbana'),(6,'operario','Operación de instalaciones'),(7,'vecino','Usuario vecino del sistema');
/*!40000 ALTER TABLE `rol` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `rutas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rutas` (
  `id_ruta` int(11) NOT NULL AUTO_INCREMENT,
  `circuito` varchar(30) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `municipio` varchar(100) NOT NULL,
  `zona` varchar(100) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `frecuencia` varchar(50) DEFAULT NULL,
  `estado` varchar(30) NOT NULL DEFAULT 'Asignada',
  PRIMARY KEY (`id_ruta`),
  UNIQUE KEY `circuito` (`circuito`),
  CONSTRAINT `fk_rutas_circuito` FOREIGN KEY (`circuito`) REFERENCES `circuitos` (`id_circuito`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `rutas` WRITE;
/*!40000 ALTER TABLE `rutas` DISABLE KEYS */;
INSERT INTO `rutas` VALUES (1,'B_01','Circuito B_01','B',NULL,NULL,NULL,'Asignada'),(2,'B_02','Circuito B_02','B',NULL,NULL,NULL,'Asignada'),(3,'B_03','Circuito B_03','B',NULL,NULL,NULL,'Asignada'),(4,'B_04','Circuito B_04','B',NULL,NULL,NULL,'Asignada'),(5,'CH_114','Circuito CH_114','CH',NULL,NULL,NULL,'Asignada'),(6,'CH_108','Circuito CH_108','CH',NULL,NULL,NULL,'Asignada'),(7,'CH_109','Circuito CH_109','CH',NULL,NULL,NULL,'Asignada'),(8,'CH_105','Circuito CH_105','CH',NULL,NULL,NULL,'Asignada'),(9,'CH_102','Circuito CH_102','CH',NULL,NULL,NULL,'Asignada'),(10,'A_101',NULL,'A',NULL,NULL,NULL,'Asignada'),(11,'A_102',NULL,'A',NULL,NULL,NULL,'Asignada'),(12,'A_103',NULL,'A',NULL,NULL,NULL,'Asignada'),(13,'B_05',NULL,'B',NULL,NULL,NULL,'Asignada'),(14,'B_06',NULL,'B',NULL,NULL,NULL,'Asignada'),(15,'B_7',NULL,'B',NULL,NULL,NULL,'Asignada'),(16,'C_102',NULL,'C',NULL,NULL,NULL,'Asignada'),(17,'CH_115',NULL,'CH',NULL,NULL,NULL,'Asignada'),(18,'D_101',NULL,'D',NULL,NULL,NULL,'Asignada'),(19,'D_102',NULL,'D',NULL,NULL,NULL,'Asignada'),(20,'D_103',NULL,'D',NULL,NULL,NULL,'Asignada'),(21,'E_102',NULL,'E',NULL,NULL,NULL,'Asignada'),(22,'E_103',NULL,'E',NULL,NULL,NULL,'Asignada'),(23,'E_106',NULL,'E',NULL,NULL,NULL,'Asignada'),(24,'F_101',NULL,'F',NULL,NULL,NULL,'Asignada'),(25,'F_102',NULL,'F',NULL,NULL,NULL,'Asignada'),(26,'F_103',NULL,'F',NULL,NULL,NULL,'Asignada'),(27,'G_101',NULL,'G',NULL,NULL,NULL,'Asignada'),(28,'G_102',NULL,'G',NULL,NULL,NULL,'Asignada'),(29,'G_103',NULL,'G',NULL,NULL,NULL,'Asignada');
/*!40000 ALTER TABLE `rutas` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `solicitudes_acceso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `solicitudes_acceso` (
  `id_solicitud` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `documento` varchar(30) NOT NULL,
  `telefono` varchar(30) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password` varchar(255) NOT NULL,
  `perfil` varchar(50) NOT NULL,
  `licencia` varchar(50) DEFAULT NULL,
  `motivo` text NOT NULL,
  `estado` varchar(30) NOT NULL DEFAULT 'pendiente',
  `fecha_solicitud` datetime NOT NULL DEFAULT current_timestamp(),
  `fecha_resolucion` datetime DEFAULT NULL,
  `id_supervisor_resuelve` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_solicitud`),
  KEY `id_supervisor_resuelve` (`id_supervisor_resuelve`),
  CONSTRAINT `solicitudes_acceso_ibfk_1` FOREIGN KEY (`id_supervisor_resuelve`) REFERENCES `usuarios` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `solicitudes_acceso` WRITE;
/*!40000 ALTER TABLE `solicitudes_acceso` DISABLE KEYS */;
INSERT INTO `solicitudes_acceso` VALUES (1,'Vecino','Prueba','5.001.000-5','099000111','prueba@sigeru.uy','$2y$12$koiboyuQOIynghLB4N5h6uNk7B4Yhhx4ZoW5AzIVEvjXvomYns182','vecino',NULL,'Prueba','aprobada','2026-09-05 20:56:38','2026-09-06 07:25:41',NULL),(2,'Vecino','Prueba','5.001.000-6','099000112','prueba2@sigeru.uy','$2y$12$vtYyr8LjUBFnrb3tx.lHJ.HWx7NrDK1gT3Vxk340rYBKRfrLaS9XS','vecino',NULL,'Prueba','aprobada','2026-09-06 04:26:33','2026-09-06 07:26:56',NULL),(3,'Armando','Puentes','5.177.777-7','099223333','prueba5@sigeru.uy','$2y$12$YudW4XXuetpeZolec1MEcezFImQKX/c9ltZmyvnd6X6FkEamIHGOi','vecino',NULL,'Quiero entrar','aprobada','2026-09-09 03:46:03','2026-09-09 17:13:18',NULL),(4,'Vecino','Test','5.555.444-5','099999212','vecino7@sigeru.com','$2y$12$JcocNHYYWWlF2TsUcEv56.5I75Fe9MsGn3fQgsFXCeGSYoj2wzLOK','vecino',NULL,'Entrar','pendiente','2026-09-09 13:48:21',NULL,NULL),(5,'Luis','Gómez','4.776.777-4','092111333','barrendero8@sigeru.uy','$2y$12$RoPWF1p/AXsl0KJYrodd1uQ.I9e/InEs79yqoeq6KqaTTckjSL7j6','cuadrilla',NULL,'Barrer','aprobada','2026-09-09 14:11:34','2026-09-09 17:13:14',NULL);
/*!40000 ALTER TABLE `solicitudes_acceso` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `supervisor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `supervisor` (
  `id_usuario` int(11) NOT NULL,
  `fecha_aprobacion` datetime DEFAULT NULL,
  PRIMARY KEY (`id_usuario`),
  CONSTRAINT `supervisor_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `supervisor` WRITE;
/*!40000 ALTER TABLE `supervisor` DISABLE KEYS */;
/*!40000 ALTER TABLE `supervisor` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `tareas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tareas` (
  `id_tarea` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` text DEFAULT NULL,
  `estado` varchar(30) NOT NULL DEFAULT 'pendiente',
  `fecha_asignacion` datetime DEFAULT NULL,
  `fecha_finalizacion` datetime DEFAULT NULL,
  `id_cuadrilla` varchar(20) DEFAULT NULL,
  `id_supervisor` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_tarea`),
  KEY `id_cuadrilla` (`id_cuadrilla`),
  KEY `id_supervisor` (`id_supervisor`),
  CONSTRAINT `tareas_ibfk_1` FOREIGN KEY (`id_cuadrilla`) REFERENCES `cuadrilla` (`id_cuadrilla`),
  CONSTRAINT `tareas_ibfk_2` FOREIGN KEY (`id_supervisor`) REFERENCES `supervisor` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `tareas` WRITE;
/*!40000 ALTER TABLE `tareas` DISABLE KEYS */;
/*!40000 ALTER TABLE `tareas` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `tipo_residuo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipo_residuo` (
  `tipo` varchar(30) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`tipo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `tipo_residuo` WRITE;
/*!40000 ALTER TABLE `tipo_residuo` DISABLE KEYS */;
INSERT INTO `tipo_residuo` VALUES ('general','Residuos urbanos generales'),('mixto','Residuos generales y reciclables'),('reciclaje','Materiales reciclables');
/*!40000 ALTER TABLE `tipo_residuo` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `ubicacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ubicacion` (
  `id_ubicacion` int(11) NOT NULL AUTO_INCREMENT,
  `calle` varchar(150) DEFAULT NULL,
  `esquina_1` varchar(150) DEFAULT NULL,
  `esquina_2` varchar(150) DEFAULT NULL,
  `municipio` varchar(100) DEFAULT NULL,
  `barrio` varchar(100) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `latitud` decimal(10,8) DEFAULT NULL,
  `longitud` decimal(11,8) DEFAULT NULL,
  PRIMARY KEY (`id_ubicacion`)
) ENGINE=InnoDB AUTO_INCREMENT=298 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `ubicacion` WRITE;
/*!40000 ALTER TABLE `ubicacion` DISABLE KEYS */;
INSERT INTO `ubicacion` VALUES (1,'Calle 1','Esquina 1',NULL,'B','Zona B','Ubicación del contenedor CONT-B01-01',NULL,NULL),(2,'Calle 2','Esquina 2',NULL,'B','Zona B','Ubicación del contenedor CONT-B01-02',NULL,NULL),(3,'Calle 3','Esquina 3',NULL,'B','Zona B','Ubicación del contenedor CONT-B01-03',NULL,NULL),(4,'Calle 4','Esquina 4',NULL,'B','Zona B','Ubicación del contenedor CONT-B01-04',NULL,NULL),(5,'Calle 5','Esquina 5',NULL,'B','Zona B','Ubicación del contenedor CONT-B01-05',NULL,NULL),(6,'Calle 6','Esquina 6',NULL,'B','Zona B','Ubicación del contenedor CONT-B01-06',NULL,NULL),(7,'Calle 7','Esquina 7',NULL,'B','Zona B','Ubicación del contenedor CONT-B01-07',NULL,NULL),(8,'Calle 8','Esquina 8',NULL,'B','Zona B','Ubicación del contenedor CONT-B01-08',NULL,NULL),(9,'Calle 9','Esquina 9',NULL,'B','Zona B','Ubicación del contenedor CONT-B01-09',NULL,NULL),(10,'Calle 10','Esquina 10',NULL,'B','Zona B','Ubicación del contenedor CONT-B01-10',NULL,NULL),(11,'Calle 1','Esquina 1',NULL,'B','Zona B','Ubicación del contenedor CONT-B02-01',NULL,NULL),(12,'Calle 2','Esquina 2',NULL,'B','Zona B','Ubicación del contenedor CONT-B02-02',NULL,NULL),(13,'Calle 3','Esquina 3',NULL,'B','Zona B','Ubicación del contenedor CONT-B02-03',NULL,NULL),(14,'Calle 4','Esquina 4',NULL,'B','Zona B','Ubicación del contenedor CONT-B02-04',NULL,NULL),(15,'Calle 5','Esquina 5',NULL,'B','Zona B','Ubicación del contenedor CONT-B02-05',NULL,NULL),(16,'Calle 6','Esquina 6',NULL,'B','Zona B','Ubicación del contenedor CONT-B02-06',NULL,NULL),(17,'Calle 7','Esquina 7',NULL,'B','Zona B','Ubicación del contenedor CONT-B02-07',NULL,NULL),(18,'Calle 8','Esquina 8',NULL,'B','Zona B','Ubicación del contenedor CONT-B02-08',NULL,NULL),(19,'Calle 9','Esquina 9',NULL,'B','Zona B','Ubicación del contenedor CONT-B02-09',NULL,NULL),(20,'Calle 10','Esquina 10',NULL,'B','Zona B','Ubicación del contenedor CONT-B02-10',NULL,NULL),(21,'Calle 1','Esquina 1',NULL,'B','Zona B','Ubicación del contenedor CONT-B03-01',NULL,NULL),(22,'Calle 2','Esquina 2',NULL,'B','Zona B','Ubicación del contenedor CONT-B03-02',NULL,NULL),(23,'Calle 3','Esquina 3',NULL,'B','Zona B','Ubicación del contenedor CONT-B03-03',NULL,NULL),(24,'Calle 4','Esquina 4',NULL,'B','Zona B','Ubicación del contenedor CONT-B03-04',NULL,NULL),(25,'Calle 5','Esquina 5',NULL,'B','Zona B','Ubicación del contenedor CONT-B03-05',NULL,NULL),(26,'Calle 6','Esquina 6',NULL,'B','Zona B','Ubicación del contenedor CONT-B03-06',NULL,NULL),(27,'Calle 7','Esquina 7',NULL,'B','Zona B','Ubicación del contenedor CONT-B03-07',NULL,NULL),(28,'Calle 8','Esquina 8',NULL,'B','Zona B','Ubicación del contenedor CONT-B03-08',NULL,NULL),(29,'Calle 9','Esquina 9',NULL,'B','Zona B','Ubicación del contenedor CONT-B03-09',NULL,NULL),(30,'Calle 10','Esquina 10',NULL,'B','Zona B','Ubicación del contenedor CONT-B03-10',NULL,NULL),(31,'Calle 1','Esquina 1',NULL,'B','Zona B','Ubicación del contenedor CONT-B04-01',NULL,NULL),(32,'Calle 2','Esquina 2',NULL,'B','Zona B','Ubicación del contenedor CONT-B04-02',NULL,NULL),(33,'Calle 3','Esquina 3',NULL,'B','Zona B','Ubicación del contenedor CONT-B04-03',NULL,NULL),(34,'Calle 4','Esquina 4',NULL,'B','Zona B','Ubicación del contenedor CONT-B04-04',NULL,NULL),(35,'Calle 5','Esquina 5',NULL,'B','Zona B','Ubicación del contenedor CONT-B04-05',NULL,NULL),(36,'Calle 6','Esquina 6',NULL,'B','Zona B','Ubicación del contenedor CONT-B04-06',NULL,NULL),(37,'Calle 7','Esquina 7',NULL,'B','Zona B','Ubicación del contenedor CONT-B04-07',NULL,NULL),(38,'Calle 8','Esquina 8',NULL,'B','Zona B','Ubicación del contenedor CONT-B04-08',NULL,NULL),(39,'Calle 9','Esquina 9',NULL,'B','Zona B','Ubicación del contenedor CONT-B04-09',NULL,NULL),(40,'Calle 10','Esquina 10',NULL,'B','Zona B','Ubicación del contenedor CONT-B04-10',NULL,NULL),(41,'Calle 1','Esquina 1',NULL,'CH','Zona CH','Ubicación del contenedor CONT-CH102-01',NULL,NULL),(42,'Calle 2','Esquina 2',NULL,'CH','Zona CH','Ubicación del contenedor CONT-CH102-02',NULL,NULL),(43,'Calle 3','Esquina 3',NULL,'CH','Zona CH','Ubicación del contenedor CONT-CH102-03',NULL,NULL),(44,'Calle 4','Esquina 4',NULL,'CH','Zona CH','Ubicación del contenedor CONT-CH102-04',NULL,NULL),(45,'Calle 5','Esquina 5',NULL,'CH','Zona CH','Ubicación del contenedor CONT-CH102-05',NULL,NULL),(46,'Calle 6','Esquina 6',NULL,'CH','Zona CH','Ubicación del contenedor CONT-CH102-06',NULL,NULL),(47,'Calle 7','Esquina 7',NULL,'CH','Zona CH','Ubicación del contenedor CONT-CH102-07',NULL,NULL),(48,'Calle 8','Esquina 8',NULL,'CH','Zona CH','Ubicación del contenedor CONT-CH102-08',NULL,NULL),(49,'Calle 9','Esquina 9',NULL,'CH','Zona CH','Ubicación del contenedor CONT-CH102-09',NULL,NULL),(50,'Calle 10','Esquina 10',NULL,'CH','Zona CH','Ubicación del contenedor CONT-CH102-10',NULL,NULL),(51,'Calle 1','Esquina 1',NULL,'CH','Zona CH','Ubicación del contenedor CONT-CH105-01',NULL,NULL),(52,'Calle 2','Esquina 2',NULL,'CH','Zona CH','Ubicación del contenedor CONT-CH105-02',NULL,NULL),(53,'Calle 3','Esquina 3',NULL,'CH','Zona CH','Ubicación del contenedor CONT-CH105-03',NULL,NULL),(54,'Calle 4','Esquina 4',NULL,'CH','Zona CH','Ubicación del contenedor CONT-CH105-04',NULL,NULL),(55,'Calle 5','Esquina 5',NULL,'CH','Zona CH','Ubicación del contenedor CONT-CH105-05',NULL,NULL),(56,'Calle 6','Esquina 6',NULL,'CH','Zona CH','Ubicación del contenedor CONT-CH105-06',NULL,NULL),(57,'Calle 7','Esquina 7',NULL,'CH','Zona CH','Ubicación del contenedor CONT-CH105-07',NULL,NULL),(58,'Calle 8','Esquina 8',NULL,'CH','Zona CH','Ubicación del contenedor CONT-CH105-08',NULL,NULL),(59,'Calle 9','Esquina 9',NULL,'CH','Zona CH','Ubicación del contenedor CONT-CH105-09',NULL,NULL),(60,'Calle 10','Esquina 10',NULL,'CH','Zona CH','Ubicación del contenedor CONT-CH105-10',NULL,NULL),(61,'Calle 1','Esquina 1',NULL,'CH','Zona CH','Ubicación del contenedor CONT-CH108-01',NULL,NULL),(62,'Calle 2','Esquina 2',NULL,'CH','Zona CH','Ubicación del contenedor CONT-CH108-02',NULL,NULL),(63,'Calle 3','Esquina 3',NULL,'CH','Zona CH','Ubicación del contenedor CONT-CH108-03',NULL,NULL),(64,'Calle 4','Esquina 4',NULL,'CH','Zona CH','Ubicación del contenedor CONT-CH108-04',NULL,NULL),(65,'Calle 5','Esquina 5',NULL,'CH','Zona CH','Ubicación del contenedor CONT-CH108-05',NULL,NULL),(66,'Calle 6','Esquina 6',NULL,'CH','Zona CH','Ubicación del contenedor CONT-CH108-06',NULL,NULL),(67,'Calle 7','Esquina 7',NULL,'CH','Zona CH','Ubicación del contenedor CONT-CH108-07',NULL,NULL),(68,'Calle 8','Esquina 8',NULL,'CH','Zona CH','Ubicación del contenedor CONT-CH108-08',NULL,NULL),(69,'Calle 9','Esquina 9',NULL,'CH','Zona CH','Ubicación del contenedor CONT-CH108-09',NULL,NULL),(70,'Calle 10','Esquina 10',NULL,'CH','Zona CH','Ubicación del contenedor CONT-CH108-10',NULL,NULL),(71,'Calle 1','Esquina 1',NULL,'CH','Zona CH','Ubicación del contenedor CONT-CH109-01',NULL,NULL),(72,'Calle 2','Esquina 2',NULL,'CH','Zona CH','Ubicación del contenedor CONT-CH109-02',NULL,NULL),(73,'Calle 3','Esquina 3',NULL,'CH','Zona CH','Ubicación del contenedor CONT-CH109-03',NULL,NULL),(74,'Calle 4','Esquina 4',NULL,'CH','Zona CH','Ubicación del contenedor CONT-CH109-04',NULL,NULL),(75,'Calle 5','Esquina 5',NULL,'CH','Zona CH','Ubicación del contenedor CONT-CH109-05',NULL,NULL),(76,'Calle 6','Esquina 6',NULL,'CH','Zona CH','Ubicación del contenedor CONT-CH109-06',NULL,NULL),(77,'Calle 7','Esquina 7',NULL,'CH','Zona CH','Ubicación del contenedor CONT-CH109-07',NULL,NULL),(78,'Calle 8','Esquina 8',NULL,'CH','Zona CH','Ubicación del contenedor CONT-CH109-08',NULL,NULL),(79,'Calle 9','Esquina 9',NULL,'CH','Zona CH','Ubicación del contenedor CONT-CH109-09',NULL,NULL),(80,'Calle 10','Esquina 10',NULL,'CH','Zona CH','Ubicación del contenedor CONT-CH109-10',NULL,NULL),(81,'Calle 1','Esquina 1',NULL,'CH','Zona CH','Ubicación del contenedor CONT-CH114-01',NULL,NULL),(82,'Calle 2','Esquina 2',NULL,'CH','Zona CH','Ubicación del contenedor CONT-CH114-02',NULL,NULL),(83,'Calle 3','Esquina 3',NULL,'CH','Zona CH','Ubicación del contenedor CONT-CH114-03',NULL,NULL),(84,'Calle 4','Esquina 4',NULL,'CH','Zona CH','Ubicación del contenedor CONT-CH114-04',NULL,NULL),(85,'Calle 5','Esquina 5',NULL,'CH','Zona CH','Ubicación del contenedor CONT-CH114-05',NULL,NULL),(86,'Calle 6','Esquina 6',NULL,'CH','Zona CH','Ubicación del contenedor CONT-CH114-06',NULL,NULL),(87,'Calle 7','Esquina 7',NULL,'CH','Zona CH','Ubicación del contenedor CONT-CH114-07',NULL,NULL),(88,'Calle 8','Esquina 8',NULL,'CH','Zona CH','Ubicación del contenedor CONT-CH114-08',NULL,NULL),(89,'Calle 9','Esquina 9',NULL,'CH','Zona CH','Ubicación del contenedor CONT-CH114-09',NULL,NULL),(90,'Calle 10','Esquina 10',NULL,'CH','Zona CH','Ubicación del contenedor CONT-CH114-10',NULL,NULL),(91,'Calle 1','Esquina 1',NULL,'A','Zona A','Ubicación del contenedor CONT-A101-01',NULL,NULL),(92,'Calle 2','Esquina 2',NULL,'A','Zona A','Ubicación del contenedor CONT-A101-02',NULL,NULL),(93,'Calle 3','Esquina 3',NULL,'A','Zona A','Ubicación del contenedor CONT-A101-03',NULL,NULL),(94,'Calle 4','Esquina 4',NULL,'A','Zona A','Ubicación del contenedor CONT-A101-04',NULL,NULL),(95,'Calle 5','Esquina 5',NULL,'A','Zona A','Ubicación del contenedor CONT-A101-05',NULL,NULL),(96,'Calle 6','Esquina 6',NULL,'A','Zona A','Ubicación del contenedor CONT-A101-06',NULL,NULL),(97,'Calle 7','Esquina 7',NULL,'A','Zona A','Ubicación del contenedor CONT-A101-07',NULL,NULL),(98,'Calle 8','Esquina 8',NULL,'A','Zona A','Ubicación del contenedor CONT-A101-08',NULL,NULL),(99,'Calle 9','Esquina 9',NULL,'A','Zona A','Ubicación del contenedor CONT-A101-09',NULL,NULL),(100,'Calle 10','Esquina 10',NULL,'A','Zona A','Ubicación del contenedor CONT-A101-10',NULL,NULL),(101,'Calle 1','Esquina 1',NULL,'A','Zona A','Ubicación del contenedor CONT-A102-01',NULL,NULL),(102,'Calle 2','Esquina 2',NULL,'A','Zona A','Ubicación del contenedor CONT-A102-02',NULL,NULL),(103,'Calle 3','Esquina 3',NULL,'A','Zona A','Ubicación del contenedor CONT-A102-03',NULL,NULL),(104,'Calle 4','Esquina 4',NULL,'A','Zona A','Ubicación del contenedor CONT-A102-04',NULL,NULL),(105,'Calle 5','Esquina 5',NULL,'A','Zona A','Ubicación del contenedor CONT-A102-05',NULL,NULL),(106,'Calle 6','Esquina 6',NULL,'A','Zona A','Ubicación del contenedor CONT-A102-06',NULL,NULL),(107,'Calle 7','Esquina 7',NULL,'A','Zona A','Ubicación del contenedor CONT-A102-07',NULL,NULL),(108,'Calle 8','Esquina 8',NULL,'A','Zona A','Ubicación del contenedor CONT-A102-08',NULL,NULL),(109,'Calle 9','Esquina 9',NULL,'A','Zona A','Ubicación del contenedor CONT-A102-09',NULL,NULL),(110,'Calle 10','Esquina 10',NULL,'A','Zona A','Ubicación del contenedor CONT-A102-10',NULL,NULL),(111,'Calle 1','Esquina 1',NULL,'A','Zona A','Ubicación del contenedor CONT-A103-01',NULL,NULL),(112,'Calle 2','Esquina 2',NULL,'A','Zona A','Ubicación del contenedor CONT-A103-02',NULL,NULL),(113,'Calle 3','Esquina 3',NULL,'A','Zona A','Ubicación del contenedor CONT-A103-03',NULL,NULL),(114,'Calle 4','Esquina 4',NULL,'A','Zona A','Ubicación del contenedor CONT-A103-04',NULL,NULL),(115,'Calle 5','Esquina 5',NULL,'A','Zona A','Ubicación del contenedor CONT-A103-05',NULL,NULL),(116,'Calle 6','Esquina 6',NULL,'A','Zona A','Ubicación del contenedor CONT-A103-06',NULL,NULL),(117,'Calle 7','Esquina 7',NULL,'A','Zona A','Ubicación del contenedor CONT-A103-07',NULL,NULL),(118,'Calle 8','Esquina 8',NULL,'A','Zona A','Ubicación del contenedor CONT-A103-08',NULL,NULL),(119,'Calle 9','Esquina 9',NULL,'A','Zona A','Ubicación del contenedor CONT-A103-09',NULL,NULL),(120,'Calle 10','Esquina 10',NULL,'A','Zona A','Ubicación del contenedor CONT-A103-10',NULL,NULL),(121,'Calle 1','Esquina 1',NULL,'B','Zona B','Ubicación del contenedor CONT-B05-01',NULL,NULL),(122,'Calle 2','Esquina 2',NULL,'B','Zona B','Ubicación del contenedor CONT-B05-02',NULL,NULL),(123,'Calle 3','Esquina 3',NULL,'B','Zona B','Ubicación del contenedor CONT-B05-03',NULL,NULL),(124,'Calle 4','Esquina 4',NULL,'B','Zona B','Ubicación del contenedor CONT-B05-04',NULL,NULL),(125,'Calle 5','Esquina 5',NULL,'B','Zona B','Ubicación del contenedor CONT-B05-05',NULL,NULL),(126,'Calle 6','Esquina 6',NULL,'B','Zona B','Ubicación del contenedor CONT-B05-06',NULL,NULL),(127,'Calle 7','Esquina 7',NULL,'B','Zona B','Ubicación del contenedor CONT-B05-07',NULL,NULL),(128,'Calle 8','Esquina 8',NULL,'B','Zona B','Ubicación del contenedor CONT-B05-08',NULL,NULL),(129,'Calle 9','Esquina 9',NULL,'B','Zona B','Ubicación del contenedor CONT-B05-09',NULL,NULL),(130,'Calle 10','Esquina 10',NULL,'B','Zona B','Ubicación del contenedor CONT-B05-10',NULL,NULL),(131,'Calle 1','Esquina 1',NULL,'B','Zona B','Ubicación del contenedor CONT-B06-01',NULL,NULL),(132,'Calle 2','Esquina 2',NULL,'B','Zona B','Ubicación del contenedor CONT-B06-02',NULL,NULL),(133,'Calle 3','Esquina 3',NULL,'B','Zona B','Ubicación del contenedor CONT-B06-03',NULL,NULL),(134,'Calle 4','Esquina 4',NULL,'B','Zona B','Ubicación del contenedor CONT-B06-04',NULL,NULL),(135,'Calle 5','Esquina 5',NULL,'B','Zona B','Ubicación del contenedor CONT-B06-05',NULL,NULL),(136,'Calle 6','Esquina 6',NULL,'B','Zona B','Ubicación del contenedor CONT-B06-06',NULL,NULL),(137,'Calle 7','Esquina 7',NULL,'B','Zona B','Ubicación del contenedor CONT-B06-07',NULL,NULL),(138,'Calle 8','Esquina 8',NULL,'B','Zona B','Ubicación del contenedor CONT-B06-08',NULL,NULL),(139,'Calle 9','Esquina 9',NULL,'B','Zona B','Ubicación del contenedor CONT-B06-09',NULL,NULL),(140,'Calle 10','Esquina 10',NULL,'B','Zona B','Ubicación del contenedor CONT-B06-10',NULL,NULL),(141,'Calle 1','Esquina 1',NULL,'B','Zona B','Ubicación del contenedor CONT-B7-01',NULL,NULL),(142,'Calle 2','Esquina 2',NULL,'B','Zona B','Ubicación del contenedor CONT-B7-02',NULL,NULL),(143,'Calle 3','Esquina 3',NULL,'B','Zona B','Ubicación del contenedor CONT-B7-03',NULL,NULL),(144,'Calle 4','Esquina 4',NULL,'B','Zona B','Ubicación del contenedor CONT-B7-04',NULL,NULL),(145,'Calle 5','Esquina 5',NULL,'B','Zona B','Ubicación del contenedor CONT-B7-05',NULL,NULL),(146,'Calle 6','Esquina 6',NULL,'B','Zona B','Ubicación del contenedor CONT-B7-06',NULL,NULL),(147,'Calle 7','Esquina 7',NULL,'B','Zona B','Ubicación del contenedor CONT-B7-07',NULL,NULL),(148,'Calle 8','Esquina 8',NULL,'B','Zona B','Ubicación del contenedor CONT-B7-08',NULL,NULL),(149,'Calle 9','Esquina 9',NULL,'B','Zona B','Ubicación del contenedor CONT-B7-09',NULL,NULL),(150,'Calle 10','Esquina 10',NULL,'B','Zona B','Ubicación del contenedor CONT-B7-10',NULL,NULL),(151,'Calle 1','Esquina 1',NULL,'C','Zona C','Ubicación del contenedor CONT-C102-01',NULL,NULL),(152,'Calle 2','Esquina 2',NULL,'C','Zona C','Ubicación del contenedor CONT-C102-02',NULL,NULL),(153,'Calle 3','Esquina 3',NULL,'C','Zona C','Ubicación del contenedor CONT-C102-03',NULL,NULL),(154,'Calle 4','Esquina 4',NULL,'C','Zona C','Ubicación del contenedor CONT-C102-04',NULL,NULL),(155,'Calle 5','Esquina 5',NULL,'C','Zona C','Ubicación del contenedor CONT-C102-05',NULL,NULL),(156,'Calle 6','Esquina 6',NULL,'C','Zona C','Ubicación del contenedor CONT-C102-06',NULL,NULL),(157,'Calle 7','Esquina 7',NULL,'C','Zona C','Ubicación del contenedor CONT-C102-07',NULL,NULL),(158,'Calle 8','Esquina 8',NULL,'C','Zona C','Ubicación del contenedor CONT-C102-08',NULL,NULL),(159,'Calle 9','Esquina 9',NULL,'C','Zona C','Ubicación del contenedor CONT-C102-09',NULL,NULL),(160,'Calle 10','Esquina 10',NULL,'C','Zona C','Ubicación del contenedor CONT-C102-10',NULL,NULL),(161,'Calle 1','Esquina 1',NULL,'CH','Zona CH','Ubicación del contenedor CONT-CH115-01',NULL,NULL),(162,'Calle 2','Esquina 2',NULL,'CH','Zona CH','Ubicación del contenedor CONT-CH115-02',NULL,NULL),(163,'Calle 3','Esquina 3',NULL,'CH','Zona CH','Ubicación del contenedor CONT-CH115-03',NULL,NULL),(164,'Calle 4','Esquina 4',NULL,'CH','Zona CH','Ubicación del contenedor CONT-CH115-04',NULL,NULL),(165,'Calle 5','Esquina 5',NULL,'CH','Zona CH','Ubicación del contenedor CONT-CH115-05',NULL,NULL),(166,'Calle 6','Esquina 6',NULL,'CH','Zona CH','Ubicación del contenedor CONT-CH115-06',NULL,NULL),(167,'Calle 7','Esquina 7',NULL,'CH','Zona CH','Ubicación del contenedor CONT-CH115-07',NULL,NULL),(168,'Calle 8','Esquina 8',NULL,'CH','Zona CH','Ubicación del contenedor CONT-CH115-08',NULL,NULL),(169,'Calle 9','Esquina 9',NULL,'CH','Zona CH','Ubicación del contenedor CONT-CH115-09',NULL,NULL),(170,'Calle 10','Esquina 10',NULL,'CH','Zona CH','Ubicación del contenedor CONT-CH115-10',NULL,NULL),(171,'Calle 1','Esquina 1',NULL,'D','Zona D','Ubicación del contenedor CONT-D101-01',NULL,NULL),(172,'Calle 2','Esquina 2',NULL,'D','Zona D','Ubicación del contenedor CONT-D101-02',NULL,NULL),(173,'Calle 3','Esquina 3',NULL,'D','Zona D','Ubicación del contenedor CONT-D101-03',NULL,NULL),(174,'Calle 4','Esquina 4',NULL,'D','Zona D','Ubicación del contenedor CONT-D101-04',NULL,NULL),(175,'Calle 5','Esquina 5',NULL,'D','Zona D','Ubicación del contenedor CONT-D101-05',NULL,NULL),(176,'Calle 6','Esquina 6',NULL,'D','Zona D','Ubicación del contenedor CONT-D101-06',NULL,NULL),(177,'Calle 7','Esquina 7',NULL,'D','Zona D','Ubicación del contenedor CONT-D101-07',NULL,NULL),(178,'Calle 8','Esquina 8',NULL,'D','Zona D','Ubicación del contenedor CONT-D101-08',NULL,NULL),(179,'Calle 9','Esquina 9',NULL,'D','Zona D','Ubicación del contenedor CONT-D101-09',NULL,NULL),(180,'Calle 10','Esquina 10',NULL,'D','Zona D','Ubicación del contenedor CONT-D101-10',NULL,NULL),(181,'Calle 1','Esquina 1',NULL,'D','Zona D','Ubicación del contenedor CONT-D102-01',NULL,NULL),(182,'Calle 2','Esquina 2',NULL,'D','Zona D','Ubicación del contenedor CONT-D102-02',NULL,NULL),(183,'Calle 3','Esquina 3',NULL,'D','Zona D','Ubicación del contenedor CONT-D102-03',NULL,NULL),(184,'Calle 4','Esquina 4',NULL,'D','Zona D','Ubicación del contenedor CONT-D102-04',NULL,NULL),(185,'Calle 5','Esquina 5',NULL,'D','Zona D','Ubicación del contenedor CONT-D102-05',NULL,NULL),(186,'Calle 6','Esquina 6',NULL,'D','Zona D','Ubicación del contenedor CONT-D102-06',NULL,NULL),(187,'Calle 7','Esquina 7',NULL,'D','Zona D','Ubicación del contenedor CONT-D102-07',NULL,NULL),(188,'Calle 8','Esquina 8',NULL,'D','Zona D','Ubicación del contenedor CONT-D102-08',NULL,NULL),(189,'Calle 9','Esquina 9',NULL,'D','Zona D','Ubicación del contenedor CONT-D102-09',NULL,NULL),(190,'Calle 10','Esquina 10',NULL,'D','Zona D','Ubicación del contenedor CONT-D102-10',NULL,NULL),(191,'Calle 1','Esquina 1',NULL,'D','Zona D','Ubicación del contenedor CONT-D103-01',NULL,NULL),(192,'Calle 2','Esquina 2',NULL,'D','Zona D','Ubicación del contenedor CONT-D103-02',NULL,NULL),(193,'Calle 3','Esquina 3',NULL,'D','Zona D','Ubicación del contenedor CONT-D103-03',NULL,NULL),(194,'Calle 4','Esquina 4',NULL,'D','Zona D','Ubicación del contenedor CONT-D103-04',NULL,NULL),(195,'Calle 5','Esquina 5',NULL,'D','Zona D','Ubicación del contenedor CONT-D103-05',NULL,NULL),(196,'Calle 6','Esquina 6',NULL,'D','Zona D','Ubicación del contenedor CONT-D103-06',NULL,NULL),(197,'Calle 7','Esquina 7',NULL,'D','Zona D','Ubicación del contenedor CONT-D103-07',NULL,NULL),(198,'Calle 8','Esquina 8',NULL,'D','Zona D','Ubicación del contenedor CONT-D103-08',NULL,NULL),(199,'Calle 9','Esquina 9',NULL,'D','Zona D','Ubicación del contenedor CONT-D103-09',NULL,NULL),(200,'Calle 10','Esquina 10',NULL,'D','Zona D','Ubicación del contenedor CONT-D103-10',NULL,NULL),(201,'Calle 1','Esquina 1',NULL,'E','Zona E','Ubicación del contenedor CONT-E102-01',NULL,NULL),(202,'Calle 2','Esquina 2',NULL,'E','Zona E','Ubicación del contenedor CONT-E102-02',NULL,NULL),(203,'Calle 3','Esquina 3',NULL,'E','Zona E','Ubicación del contenedor CONT-E102-03',NULL,NULL),(204,'Calle 4','Esquina 4',NULL,'E','Zona E','Ubicación del contenedor CONT-E102-04',NULL,NULL),(205,'Calle 5','Esquina 5',NULL,'E','Zona E','Ubicación del contenedor CONT-E102-05',NULL,NULL),(206,'Calle 6','Esquina 6',NULL,'E','Zona E','Ubicación del contenedor CONT-E102-06',NULL,NULL),(207,'Calle 7','Esquina 7',NULL,'E','Zona E','Ubicación del contenedor CONT-E102-07',NULL,NULL),(208,'Calle 8','Esquina 8',NULL,'E','Zona E','Ubicación del contenedor CONT-E102-08',NULL,NULL),(209,'Calle 9','Esquina 9',NULL,'E','Zona E','Ubicación del contenedor CONT-E102-09',NULL,NULL),(210,'Calle 10','Esquina 10',NULL,'E','Zona E','Ubicación del contenedor CONT-E102-10',NULL,NULL),(211,'Calle 1','Esquina 1',NULL,'E','Zona E','Ubicación del contenedor CONT-E103-01',NULL,NULL),(212,'Calle 2','Esquina 2',NULL,'E','Zona E','Ubicación del contenedor CONT-E103-02',NULL,NULL),(213,'Calle 3','Esquina 3',NULL,'E','Zona E','Ubicación del contenedor CONT-E103-03',NULL,NULL),(214,'Calle 4','Esquina 4',NULL,'E','Zona E','Ubicación del contenedor CONT-E103-04',NULL,NULL),(215,'Calle 5','Esquina 5',NULL,'E','Zona E','Ubicación del contenedor CONT-E103-05',NULL,NULL),(216,'Calle 6','Esquina 6',NULL,'E','Zona E','Ubicación del contenedor CONT-E103-06',NULL,NULL),(217,'Calle 7','Esquina 7',NULL,'E','Zona E','Ubicación del contenedor CONT-E103-07',NULL,NULL),(218,'Calle 8','Esquina 8',NULL,'E','Zona E','Ubicación del contenedor CONT-E103-08',NULL,NULL),(219,'Calle 9','Esquina 9',NULL,'E','Zona E','Ubicación del contenedor CONT-E103-09',NULL,NULL),(220,'Calle 10','Esquina 10',NULL,'E','Zona E','Ubicación del contenedor CONT-E103-10',NULL,NULL),(221,'Calle 1','Esquina 1',NULL,'E','Zona E','Ubicación del contenedor CONT-E106-01',NULL,NULL),(222,'Calle 2','Esquina 2',NULL,'E','Zona E','Ubicación del contenedor CONT-E106-02',NULL,NULL),(223,'Calle 3','Esquina 3',NULL,'E','Zona E','Ubicación del contenedor CONT-E106-03',NULL,NULL),(224,'Calle 4','Esquina 4',NULL,'E','Zona E','Ubicación del contenedor CONT-E106-04',NULL,NULL),(225,'Calle 5','Esquina 5',NULL,'E','Zona E','Ubicación del contenedor CONT-E106-05',NULL,NULL),(226,'Calle 6','Esquina 6',NULL,'E','Zona E','Ubicación del contenedor CONT-E106-06',NULL,NULL),(227,'Calle 7','Esquina 7',NULL,'E','Zona E','Ubicación del contenedor CONT-E106-07',NULL,NULL),(228,'Calle 8','Esquina 8',NULL,'E','Zona E','Ubicación del contenedor CONT-E106-08',NULL,NULL),(229,'Calle 9','Esquina 9',NULL,'E','Zona E','Ubicación del contenedor CONT-E106-09',NULL,NULL),(230,'Calle 10','Esquina 10',NULL,'E','Zona E','Ubicación del contenedor CONT-E106-10',NULL,NULL),(231,'Calle 1','Esquina 1',NULL,'F','Zona F','Ubicación del contenedor CONT-F101-01',NULL,NULL),(232,'Calle 2','Esquina 2',NULL,'F','Zona F','Ubicación del contenedor CONT-F101-02',NULL,NULL),(233,'Calle 3','Esquina 3',NULL,'F','Zona F','Ubicación del contenedor CONT-F101-03',NULL,NULL),(234,'Calle 4','Esquina 4',NULL,'F','Zona F','Ubicación del contenedor CONT-F101-04',NULL,NULL),(235,'Calle 5','Esquina 5',NULL,'F','Zona F','Ubicación del contenedor CONT-F101-05',NULL,NULL),(236,'Calle 6','Esquina 6',NULL,'F','Zona F','Ubicación del contenedor CONT-F101-06',NULL,NULL),(237,'Calle 7','Esquina 7',NULL,'F','Zona F','Ubicación del contenedor CONT-F101-07',NULL,NULL),(238,'Calle 8','Esquina 8',NULL,'F','Zona F','Ubicación del contenedor CONT-F101-08',NULL,NULL),(239,'Calle 9','Esquina 9',NULL,'F','Zona F','Ubicación del contenedor CONT-F101-09',NULL,NULL),(240,'Calle 10','Esquina 10',NULL,'F','Zona F','Ubicación del contenedor CONT-F101-10',NULL,NULL),(241,'Calle 1','Esquina 1',NULL,'F','Zona F','Ubicación del contenedor CONT-F102-01',NULL,NULL),(242,'Calle 2','Esquina 2',NULL,'F','Zona F','Ubicación del contenedor CONT-F102-02',NULL,NULL),(243,'Calle 3','Esquina 3',NULL,'F','Zona F','Ubicación del contenedor CONT-F102-03',NULL,NULL),(244,'Calle 4','Esquina 4',NULL,'F','Zona F','Ubicación del contenedor CONT-F102-04',NULL,NULL),(245,'Calle 5','Esquina 5',NULL,'F','Zona F','Ubicación del contenedor CONT-F102-05',NULL,NULL),(246,'Calle 6','Esquina 6',NULL,'F','Zona F','Ubicación del contenedor CONT-F102-06',NULL,NULL),(247,'Calle 7','Esquina 7',NULL,'F','Zona F','Ubicación del contenedor CONT-F102-07',NULL,NULL),(248,'Calle 8','Esquina 8',NULL,'F','Zona F','Ubicación del contenedor CONT-F102-08',NULL,NULL),(249,'Calle 9','Esquina 9',NULL,'F','Zona F','Ubicación del contenedor CONT-F102-09',NULL,NULL),(250,'Calle 10','Esquina 10',NULL,'F','Zona F','Ubicación del contenedor CONT-F102-10',NULL,NULL),(251,'Calle 1','Esquina 1',NULL,'F','Zona F','Ubicación del contenedor CONT-F103-01',NULL,NULL),(252,'Calle 2','Esquina 2',NULL,'F','Zona F','Ubicación del contenedor CONT-F103-02',NULL,NULL),(253,'Calle 3','Esquina 3',NULL,'F','Zona F','Ubicación del contenedor CONT-F103-03',NULL,NULL),(254,'Calle 4','Esquina 4',NULL,'F','Zona F','Ubicación del contenedor CONT-F103-04',NULL,NULL),(255,'Calle 5','Esquina 5',NULL,'F','Zona F','Ubicación del contenedor CONT-F103-05',NULL,NULL),(256,'Calle 6','Esquina 6',NULL,'F','Zona F','Ubicación del contenedor CONT-F103-06',NULL,NULL),(257,'Calle 7','Esquina 7',NULL,'F','Zona F','Ubicación del contenedor CONT-F103-07',NULL,NULL),(258,'Calle 8','Esquina 8',NULL,'F','Zona F','Ubicación del contenedor CONT-F103-08',NULL,NULL),(259,'Calle 9','Esquina 9',NULL,'F','Zona F','Ubicación del contenedor CONT-F103-09',NULL,NULL),(260,'Calle 10','Esquina 10',NULL,'F','Zona F','Ubicación del contenedor CONT-F103-10',NULL,NULL),(261,'Calle 1','Esquina 1',NULL,'G','Zona G','Ubicación del contenedor CONT-G101-01',NULL,NULL),(262,'Calle 2','Esquina 2',NULL,'G','Zona G','Ubicación del contenedor CONT-G101-02',NULL,NULL),(263,'Calle 3','Esquina 3',NULL,'G','Zona G','Ubicación del contenedor CONT-G101-03',NULL,NULL),(264,'Calle 4','Esquina 4',NULL,'G','Zona G','Ubicación del contenedor CONT-G101-04',NULL,NULL),(265,'Calle 5','Esquina 5',NULL,'G','Zona G','Ubicación del contenedor CONT-G101-05',NULL,NULL),(266,'Calle 6','Esquina 6',NULL,'G','Zona G','Ubicación del contenedor CONT-G101-06',NULL,NULL),(267,'Calle 7','Esquina 7',NULL,'G','Zona G','Ubicación del contenedor CONT-G101-07',NULL,NULL),(268,'Calle 8','Esquina 8',NULL,'G','Zona G','Ubicación del contenedor CONT-G101-08',NULL,NULL),(269,'Calle 9','Esquina 9',NULL,'G','Zona G','Ubicación del contenedor CONT-G101-09',NULL,NULL),(270,'Calle 10','Esquina 10',NULL,'G','Zona G','Ubicación del contenedor CONT-G101-10',NULL,NULL),(271,'Calle 1','Esquina 1',NULL,'G','Zona G','Ubicación del contenedor CONT-G102-01',NULL,NULL),(272,'Calle 2','Esquina 2',NULL,'G','Zona G','Ubicación del contenedor CONT-G102-02',NULL,NULL),(273,'Calle 3','Esquina 3',NULL,'G','Zona G','Ubicación del contenedor CONT-G102-03',NULL,NULL),(274,'Calle 4','Esquina 4',NULL,'G','Zona G','Ubicación del contenedor CONT-G102-04',NULL,NULL),(275,'Calle 5','Esquina 5',NULL,'G','Zona G','Ubicación del contenedor CONT-G102-05',NULL,NULL),(276,'Calle 6','Esquina 6',NULL,'G','Zona G','Ubicación del contenedor CONT-G102-06',NULL,NULL),(277,'Calle 7','Esquina 7',NULL,'G','Zona G','Ubicación del contenedor CONT-G102-07',NULL,NULL),(278,'Calle 8','Esquina 8',NULL,'G','Zona G','Ubicación del contenedor CONT-G102-08',NULL,NULL),(279,'Calle 9','Esquina 9',NULL,'G','Zona G','Ubicación del contenedor CONT-G102-09',NULL,NULL),(280,'Calle 10','Esquina 10',NULL,'G','Zona G','Ubicación del contenedor CONT-G102-10',NULL,NULL),(281,'Calle 1','Esquina 1',NULL,'G','Zona G','Ubicación del contenedor CONT-G103-01',NULL,NULL),(282,'Calle 2','Esquina 2',NULL,'G','Zona G','Ubicación del contenedor CONT-G103-02',NULL,NULL),(283,'Calle 3','Esquina 3',NULL,'G','Zona G','Ubicación del contenedor CONT-G103-03',NULL,NULL),(284,'Calle 4','Esquina 4',NULL,'G','Zona G','Ubicación del contenedor CONT-G103-04',NULL,NULL),(285,'Calle 5','Esquina 5',NULL,'G','Zona G','Ubicación del contenedor CONT-G103-05',NULL,NULL),(286,'Calle 6','Esquina 6',NULL,'G','Zona G','Ubicación del contenedor CONT-G103-06',NULL,NULL),(287,'Calle 7','Esquina 7',NULL,'G','Zona G','Ubicación del contenedor CONT-G103-07',NULL,NULL),(288,'Calle 8','Esquina 8',NULL,'G','Zona G','Ubicación del contenedor CONT-G103-08',NULL,NULL),(289,'Calle 9','Esquina 9',NULL,'G','Zona G','Ubicación del contenedor CONT-G103-09',NULL,NULL),(290,'Calle 10','Esquina 10',NULL,'G','Zona G','Ubicación del contenedor CONT-G103-10',NULL,NULL),(291,'Av. Gral. Rivera','Managripé','Vanguardia',NULL,NULL,NULL,NULL,NULL),(292,'Dr. Carlos María de Pena','Cnel. Arana','Filadelfia',NULL,NULL,NULL,NULL,NULL),(293,'Camino Corrales','Pavón','Añagualpo',NULL,NULL,NULL,NULL,NULL),(294,'Géminis','Pilar','Senda',NULL,NULL,NULL,NULL,NULL),(295,'José Durán','Antonio Taddei','Durán Pasaje A',NULL,NULL,NULL,NULL,NULL),(296,'La Paloma','Tróccoli','Joaquín Martorí',NULL,NULL,NULL,NULL,NULL),(297,'Felipe Cardoso','Cepeda','Punta Rieles',NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `ubicacion` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `id_rol` int(11) NOT NULL,
  `fecha_registro` datetime NOT NULL DEFAULT current_timestamp(),
  `apellido` varchar(100) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `estado` varchar(30) NOT NULL DEFAULT 'activo',
  PRIMARY KEY (`id_usuario`),
  KEY `id_rol` (`id_rol`),
  CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `rol` (`id_rol`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,1,'2026-09-05 18:11:26','Demo','Administrador','activo'),(2,7,'2026-09-05 18:11:27','Demo','Vecino','activo'),(3,4,'2026-09-05 18:11:27','Demo','Cuadrilla','activo'),(4,6,'2026-09-05 18:11:27','Demo','Operario','activo'),(5,3,'2026-09-05 18:11:28','Demo','Chofer','activo'),(6,7,'2026-09-06 04:25:40','Prueba','Vecino','activo'),(7,7,'2026-09-06 04:26:56','Prueba','Vecino','activo'),(8,3,'2026-09-06 05:19:33','Einstein','Albert','activo'),(9,3,'2026-09-06 05:19:35','da Vinci','Leonardo','activo'),(10,3,'2026-09-06 05:19:36','Kahlo','Frida','activo'),(11,3,'2026-09-06 05:19:37','César','Julio','activo'),(12,6,'2026-09-06 05:19:37','Pérez','María','activo'),(13,6,'2026-09-06 05:19:37','Silva','Carlos','activo'),(14,6,'2026-09-06 05:19:38','Rodríguez','Lucía','activo'),(15,5,'2026-09-06 05:19:40','Cavani','Edinson','activo'),(16,5,'2026-09-06 05:19:41','Valverde','Federico','activo'),(17,5,'2026-09-06 05:19:41','Ripoll','Valeria','activo'),(18,5,'2026-09-06 05:19:42','Rodríguez','Victoria','activo'),(19,5,'2026-09-06 05:19:42','Bentancur','Rodrigo','activo'),(20,5,'2026-09-06 05:19:43','María Giménez','José','activo'),(21,5,'2026-09-06 05:19:43','Rochet','Sergio','activo'),(22,5,'2026-09-06 05:19:43','de la Cruz','Nicolás','activo'),(23,5,'2026-09-06 05:19:43','Agustini','Delmira','activo'),(24,5,'2026-09-06 05:19:43','Vilariño','Idea','activo'),(25,5,'2026-09-06 05:19:45','Benedetti','Mario','activo'),(26,5,'2026-09-06 05:19:45','Berenguer','Amanda','activo'),(27,5,'2026-09-06 05:19:45','Medina','Estela','activo'),(28,5,'2026-09-06 05:19:45','Larreta','Antonio','activo'),(29,5,'2026-09-06 05:19:46','Sfeir','Dahd','activo'),(30,5,'2026-09-06 05:19:46','Reyno','Walter','activo'),(31,5,'2026-09-06 06:36:32','Forlán','Diego','activo'),(32,5,'2026-09-06 06:36:32','Suárez','Luis','activo'),(33,5,'2026-09-06 06:36:32','de Ibarbourou','Juana','activo'),(34,5,'2026-09-06 06:36:32','Zorrilla','China','activo'),(35,5,'2026-09-06 06:36:33','Oreiro','Natalia','activo'),(36,5,'2026-09-09 03:32:21','Junior','Walter','activo'),(37,5,'2026-09-09 03:37:18','Washington','George','activo'),(38,4,'2026-09-09 14:13:14','Gómez','Luis','activo'),(39,7,'2026-09-09 14:13:18','Puentes','Armando','activo');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
DROP TABLE IF EXISTS `vecino`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vecino` (
  `id_usuario` int(11) NOT NULL,
  PRIMARY KEY (`id_usuario`),
  CONSTRAINT `vecino_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `vecino` WRITE;
/*!40000 ALTER TABLE `vecino` DISABLE KEYS */;
INSERT INTO `vecino` VALUES (2),(6),(7),(39);
/*!40000 ALTER TABLE `vecino` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

