-- phpMyAdmin SQL Dump
-- version 3.5.2.2
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: May 12, 2013 at 01:31 PM
-- Server version: 5.5.27
-- PHP Version: 5.4.7

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `wsms`
--
DROP SCHEMA IF EXISTS `wsms` ;
CREATE SCHEMA IF NOT EXISTS `wsms` DEFAULT CHARACTER SET utf8 ;
USE `wsms` ;
-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE IF NOT EXISTS `customer` (
  `ssn` varchar(9) NOT NULL,
  `name` varchar(45) NOT NULL,
  `surname` varchar(45) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `cellphone` varchar(20) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `address` varchar(100) NOT NULL,
  `zipCode` varchar(10) NOT NULL,
  `city` varchar(45) NOT NULL,
  `version` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ssn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`ssn`, `name`, `surname`, `phone`, `cellphone`, `email`, `address`, `zipCode`, `city`, `version`) VALUES
('1111', 'alkis', 'kalogeris', NULL, NULL, NULL, 'zwhs 1', '12233', 'athens', 0);

--
-- Triggers `customer`
--
DROP TRIGGER IF EXISTS `IncreaseCustomerVersionTrigger`;
DELIMITER //
CREATE TRIGGER `IncreaseCustomerVersionTrigger` BEFORE UPDATE ON `customer`
 FOR EACH ROW BEGIN
	SET NEW.version = NEW.version + 1;
END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `customer_has_discount`
--

CREATE TABLE IF NOT EXISTS `customer_has_discount` (
  `sku` varchar(20) NOT NULL,
  `ssn` varchar(9) NOT NULL,
  `discount` decimal(4,3) NOT NULL DEFAULT '0.000',
  PRIMARY KEY (`sku`,`ssn`),
  KEY `fk_ProductSale_has_Customer_Customer1_idx` (`ssn`),
  KEY `fk_ProductSale_has_Customer_ProductSale1_idx` (`sku`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `history_customer`
--

CREATE TABLE IF NOT EXISTS `history_customer` (
  `idHistoryCustomer` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `surname` varchar(45) NOT NULL,
  `address` varchar(100) NOT NULL,
  `zipCode` varchar(10) NOT NULL,
  `city` varchar(45) NOT NULL,
  `customerSsn` varchar(9) NOT NULL,
  `version` int(11) NOT NULL,
  PRIMARY KEY (`idHistoryCustomer`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `history_product`
--

CREATE TABLE IF NOT EXISTS `history_product` (
  `idHistoryProduct` int(11) NOT NULL AUTO_INCREMENT,
  `description` text NOT NULL,
  `priceSale` decimal(10,2) NOT NULL,
  `priceSupply` decimal(10,2) NOT NULL,
  `sku` varchar(20) NOT NULL,
  `version` int(11) NOT NULL,
  PRIMARY KEY (`idHistoryProduct`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `history_provider`
--

CREATE TABLE IF NOT EXISTS `history_provider` (
  `idHistoryProvider` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `surname` varchar(45) NOT NULL,
  `address` varchar(100) NOT NULL,
  `zipCode` varchar(10) NOT NULL,
  `city` varchar(45) NOT NULL,
  `providerSsn` varchar(9) NOT NULL,
  `version` int(11) NOT NULL,
  PRIMARY KEY (`idHistoryProvider`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `history_saleorder`
--

CREATE TABLE IF NOT EXISTS `history_saleorder` (
  `idHistorySaleOrder` int(11) NOT NULL AUTO_INCREMENT,
  `idSaleOrder` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDue` datetime NOT NULL,
  `dateClosed` datetime NOT NULL,
  `idHistoryCustomer` int(11) NOT NULL,
  `status` enum('closed','problem') NOT NULL,
  PRIMARY KEY (`idHistorySaleOrder`),
  KEY `fk_HistorySaleOrder_InstanceCustomer1_idx` (`idHistoryCustomer`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `history_saleorder_has_history_product`
--

CREATE TABLE IF NOT EXISTS `history_saleorder_has_history_product` (
  `idHistorySaleOrder` int(11) NOT NULL,
  `idHistoryProduct` int(11) NOT NULL,
  `discount` decimal(4,3) NOT NULL,
  `quantityCreated` int(11) NOT NULL,
  `quantityClosed` int(11) NOT NULL,
  PRIMARY KEY (`idHistorySaleOrder`,`idHistoryProduct`),
  KEY `fk_HistorySaleOrder_has_InstanceProduct_InstanceProduct1_idx` (`idHistoryProduct`),
  KEY `fk_HistorySaleOrder_has_InstanceProduct_HistorySaleOrder1_idx` (`idHistorySaleOrder`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `history_supplyorder`
--

CREATE TABLE IF NOT EXISTS `history_supplyorder` (
  `idHistorySupplyOrder` int(11) NOT NULL AUTO_INCREMENT,
  `idSupplyOrder` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateDue` datetime NOT NULL,
  `dateClosed` datetime NOT NULL,
  `idHistoryProvider` int(11) NOT NULL,
  PRIMARY KEY (`idHistorySupplyOrder`),
  KEY `fk_HistorySupplyOrder_HistoryProvider1_idx` (`idHistoryProvider`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `history_supplyorder_has_history_product`
--

CREATE TABLE IF NOT EXISTS `history_supplyorder_has_history_product` (
  `idHistorySupplyOrder` int(11) NOT NULL,
  `idHistoryProduct` int(11) NOT NULL,
  `quantityCreated` int(11) NOT NULL,
  `quantityClosed` int(11) NOT NULL,
  PRIMARY KEY (`idHistorySupplyOrder`,`idHistoryProduct`),
  KEY `fk_HistorySupplyOrder_has_HistoryProduct_HistoryProduct1_idx` (`idHistoryProduct`),
  KEY `fk_HistorySupplyOrder_has_HistoryProduct_HistorySupplyOrder_idx` (`idHistorySupplyOrder`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE IF NOT EXISTS `product` (
  `sku` varchar(20) NOT NULL,
  `description` text NOT NULL,
  `priceSale` decimal(10,2) NOT NULL,
  `priceSupply` decimal(10,2) NOT NULL,
  `availableSum` int(11) NOT NULL,
  `reservedSum` int(11) NOT NULL,
  `orderedSum` int(11) NOT NULL,
  `criticalSum` int(11) NOT NULL,
  `version` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`sku`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`sku`, `description`, `priceSale`, `priceSupply`, `availableSum`, `reservedSum`, `orderedSum`, `criticalSum`, `version`) VALUES
('DINO.0001', 'Δεινοσαυράκι', 5.00, 5.00, 5, 5, 5, 5, 0),
('DINO.0004', 'MIA ORAIA FANTA', 34.00, 4.00, 45, 45, 5, 5, 0);

--
-- Triggers `product`
--
DROP TRIGGER IF EXISTS `IncreaseProductVersionTrigger`;
DELIMITER //
CREATE TRIGGER `IncreaseProductVersionTrigger` BEFORE UPDATE ON `product`
 FOR EACH ROW BEGIN
	SET NEW.version = NEW.version + 1;
END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `provider`
--

CREATE TABLE IF NOT EXISTS `provider` (
  `ssn` varchar(9) NOT NULL,
  `name` varchar(45) NOT NULL,
  `surname` varchar(45) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `cellphone` varchar(20) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `address` varchar(100) NOT NULL,
  `zipCode` varchar(10) NOT NULL,
  `city` varchar(45) NOT NULL,
  `version` int(11) NOT NULL,
  PRIMARY KEY (`ssn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Triggers `provider`
--
DROP TRIGGER IF EXISTS `IncreaseProviderVersionTrigger`;
DELIMITER //
CREATE TRIGGER `IncreaseProviderVersionTrigger` BEFORE UPDATE ON `provider`
 FOR EACH ROW BEGIN
	SET NEW.version = NEW.version + 1;
END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `saleorder`
--

CREATE TABLE IF NOT EXISTS `saleorder` (
  `idSaleOrder` int(11) NOT NULL AUTO_INCREMENT,
  `dateUpdated` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateClosed` datetime DEFAULT NULL,
  `dateDue` datetime DEFAULT NULL,
  `customerSsn` varchar(9) NOT NULL,
  `idUser` int(11) NOT NULL,
  `status` enum('active','inactive','closed','problem') NOT NULL,
  PRIMARY KEY (`idSaleOrder`,`dateUpdated`),
  KEY `fk_OrderSale_Customer1_idx` (`customerSsn`),
  KEY `fk_OrderSale_User1_idx` (`idUser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Triggers `saleorder`
--
DROP TRIGGER IF EXISTS `SaleOrderTrigger`;
DELIMITER //
CREATE TRIGGER `SaleOrderTrigger` BEFORE DELETE ON `saleorder`
 FOR EACH ROW BEGIN 

        IF( (OLD.status='closed') OR (OLD.status='problem') ) THEN

            SET @customerVersion := (
                SELECT version
                FROM provider
                WHERE ssn = OLD.customerSsn
            );


            SET @historyCustomerId := (
                SELECT idHistoryCustomer
                FROM history_customer
                WHERE customerSsn = OLD.customerSsn
                AND version = @customerVersion
            );

            IF(@historyCustomerId IS NULL) THEN

                INSERT INTO history_customer 
                (name,surname,address,zipCode,city,customerSsn,version) 
                SELECT name,surname,address,zipCode,city,ssn,version
                FROM customer
                WHERE ssn = OLD.customerSsn;

                SET @historyCustomerId := LAST_INSERT_ID();
    
            END IF;
                

            INSERT INTO history_saleorder 
            (idSaleOrder,dateCreated,dateUpdated,dateDue,dateClosed,idHistoryCustomer,status)
            VALUES 
			(OLD.idSaleOrder,OLD.dateCreated,OLD.dateUpdated,OLD.dateDue,OLD.dateClosed,@historyCustomerId,OLD.status);

        END IF;

        DELETE FROM saleorder_has_product  
        WHERE (idSaleOrder = OLD.idSaleOrder AND dateUpdated = OLD.dateUpdated);
    END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `saleorder_has_product`
--

CREATE TABLE IF NOT EXISTS `saleorder_has_product` (
  `sku` varchar(20) NOT NULL,
  `idSaleOrder` int(11) NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `quantityCreated` int(11) NOT NULL,
  `quantityClosed` int(11) DEFAULT NULL,
  `currentDiscount` decimal(4,3) NOT NULL,
  `currentPriceSale` decimal(10,2) NOT NULL,
  `currentPriceSupply` decimal(10,2) NOT NULL,
  `currentVersion` int(11) DEFAULT NULL,
  `currentDescription` text NOT NULL,
  PRIMARY KEY (`sku`,`idSaleOrder`,`dateUpdated`),
  KEY `fk_Product_has_SaleOrder_Product1_idx` (`sku`),
  KEY `fk_SaleOrderHasProduct_SaleOrder1_idx` (`idSaleOrder`,`dateUpdated`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Triggers `saleorder_has_product`
--
DROP TRIGGER IF EXISTS `CurrentValuesSaleOrderTrigger`;
DELIMITER //
CREATE TRIGGER `CurrentValuesSaleOrderTrigger` BEFORE INSERT ON `saleorder_has_product`
 FOR EACH ROW BEGIN
	SELECT version
	INTO @currentVersion
	FROM product
	WHERE NEW.sku = sku;
	
	SET NEW.currentVersion = @currentVersion;
END
//
DELIMITER ;
DROP TRIGGER IF EXISTS `SaleOrderHasProductTrigger`;
DELIMITER //
CREATE TRIGGER `SaleOrderHasProductTrigger` BEFORE DELETE ON `saleorder_has_product`
 FOR EACH ROW BEGIN

        IF( (SELECT status FROM saleorder WHERE idSaleOrder=OLD.idSaleOrder)='closed' OR 'problem' ) THEN
            
            SET @historyProductId := (
                SELECT idHistoryProduct 
                FROM history_product
                WHERE sku = OLD.sku 
                AND version = OLD.currentVersion
            );

            IF(@historyProductId IS NULL) THEN

                INSERT INTO history_product 
                (description,priceSale,priceSupply,sku,version) 
                VALUES 
                (OLD.currentDescription,OLD.currentPriceSale,OLD.currentpriceSupply,OLD.sku,OLD.currentVersion);
                
                SET @historyProductId := LAST_INSERT_ID();

            END IF;


            SET @idHistorySaleOrder :=(
                SELECT idHistorySaleOrder 
                FROM history_saleorder 
                WHERE idSaleOrder = OLD.idSaleOrder 
                AND dateUpdated = OLD.dateUpdated);
            
            INSERT INTO history_saleorder_has_history_product 
            (idHistorySaleOrder,idHistoryProduct,discount,quantityCreated,quantityClosed) 
            VALUES 
            (@idHistorySaleOrder,@historyProductId,OLD.currentDiscount,OLD.quantityCreated,OLD.quantityClosed);

            IF( OLD.quantityCreated != OLD.quantityClosed ) THEN 
                UPDATE history_saleorder SET status := 'problem' 
				WHERE idSaleOrder = OLD.idSaleOrder 
                AND dateUpdated = OLD.dateUpdated;
            END IF;

        END IF;

    END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `supplyorder`
--

CREATE TABLE IF NOT EXISTS `supplyorder` (
  `idSupplyOrder` int(11) NOT NULL AUTO_INCREMENT,
  `dateUpdated` datetime NOT NULL,
  `dateClosed` datetime DEFAULT NULL,
  `dateDue` datetime NOT NULL,
  `providerSsn` varchar(9) NOT NULL,
  `idUser` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `status` enum('active','closed') NOT NULL,
  PRIMARY KEY (`idSupplyOrder`,`dateUpdated`),
  KEY `fk_OrderSupply_Provider1_idx` (`providerSsn`),
  KEY `fk_OrderSupply_User1_idx` (`idUser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Triggers `supplyorder`
--
DROP TRIGGER IF EXISTS `SupplyOrderTrigger`;
DELIMITER //
CREATE TRIGGER `SupplyOrderTrigger` BEFORE DELETE ON `supplyorder`
 FOR EACH ROW BEGIN 

        IF(OLD.status = 'closed') THEN
			
			SET @providerVersion := (
				SELECT version 
				FROM provider 
				WHERE ssn = OLD.providerSsn 
			);
			
			SET @historyProviderId := (
				SELECT idHistoryProvider 
				FROM history_provider 
				WHERE providerSsn = OLD.providerSsn 
				AND version = @providerVersion
			);
			
			IF( @historyProviderId IS NULL ) THEN
                
				INSERT INTO history_provider (name, surname, address, zipCode, city, providerSsn, version) 
				SELECT name, surname, address, zipCode, city, ssn, version 
				FROM provider
				WHERE ssn = OLD.providerSsn;
            
				SET @historyProviderId := LAST_INSERT_ID();
            END IF;
            
            INSERT INTO history_supplyorder 
			(idSupplyOrder, dateCreated, dateDue, dateClosed, idHistoryProvider) 
			VALUES 
			(OLD.idSupplyOrder, OLD.dateCreated, OLD.dateDue, OLD.dateClosed, @historyProviderId);
        END IF;


	DELETE FROM supplyorder_has_product  
	WHERE (idSupplyOrder = OLD.idSupplyOrder);

    END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `supplyorder_has_product`
--

CREATE TABLE IF NOT EXISTS `supplyorder_has_product` (
  `idSupplyOrder` int(11) NOT NULL,
  `sku` varchar(20) NOT NULL,
  `quantityCreated` int(11) NOT NULL,
  `quantityClosed` int(11) DEFAULT NULL,
  `currentPriceSupply` decimal(10,2) NOT NULL,
  `currentDescription` text NOT NULL,
  `currentVersion` int(11) DEFAULT NULL,
  `currentPriceSale` decimal(10,2) NOT NULL,
  PRIMARY KEY (`sku`,`idSupplyOrder`),
  KEY `fk_SupplyOrder_has_Product_Product1_idx` (`sku`),
  KEY `fk_SupplyOrder_has_Product_SupplyOrder1_idx` (`idSupplyOrder`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Triggers `supplyorder_has_product`
--
DROP TRIGGER IF EXISTS `CurrentValuesSupplyOrderTrigger`;
DELIMITER //
CREATE TRIGGER `CurrentValuesSupplyOrderTrigger` BEFORE INSERT ON `supplyorder_has_product`
 FOR EACH ROW BEGIN
	
		SELECT priceSupply, version, description, priceSale 
		INTO @currentPriceSupply, @currentVersion, @currentDescription, @currentPriceSale
		FROM product
		WHERE  sku = NEW.sku;

		SET	NEW.currentPriceSale := @currentPriceSale;
		SET	NEW.currentPriceSupply := @currentPriceSupply;
		SET	NEW.currentVersion := @currentVersion;
		SET	NEW.currentDescription := @currentDescription;
END
//
DELIMITER ;
DROP TRIGGER IF EXISTS `SupplyOrderHasProductTrigger`;
DELIMITER //
CREATE TRIGGER `SupplyOrderHasProductTrigger` BEFORE DELETE ON `supplyorder_has_product`
 FOR EACH ROW BEGIN

        IF( (SELECT status FROM supplyorder WHERE idSupplyOrder = OLD.idSupplyOrder)='closed' ) THEN
            
            SET @historyProductId := (
                SELECT idHistoryProduct 
                FROM history_product
                WHERE sku = OLD.sku 
                AND version = OLD.currentVersion
            );

            IF(@historyProductId IS NULL) THEN

                INSERT INTO history_product 
                (description,priceSale,priceSupply,sku,version) 
                VALUES 
                (OLD.currentDescription,OLD.currentPriceSale,OLD.currentPriceSupply,OLD.sku,OLD.currentVersion);
                
                SET @historyProductId := LAST_INSERT_ID();

            END IF;


            SET @idHistorySupplyOrder :=(
                SELECT idHistorySupplyOrder 
                FROM history_supplyorder 
                WHERE idSupplyOrder = OLD.idSupplyOrder 
            );
            
            INSERT INTO history_supplyorder_has_history_product 
            (idHistorySupplyOrder,idHistoryProduct,quantityCreated,quantityClosed) 
            VALUES 
            (@idHistorySupplyOrder,@historyProductId,OLD.quantityCreated,OLD.quantityClosed);

        END IF;

    END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `idUser` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `role` enum('MANAGER','SELLER','SCHEDULER','STOREKEEPER') NOT NULL,
  PRIMARY KEY (`idUser`),
  UNIQUE KEY `username_UNIQUE` (`username`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`idUser`, `username`, `password`, `email`, `role`) VALUES
(1, 'manager', 'manager', 'manager@wsms.gr', 'MANAGER'),
(2, 'seller', 'seller', 'seller@wsms.gr', 'SELLER'),
(3, 'scheduler', 'scheduler', 'scheduler@wsms.gr', 'SCHEDULER'),
(4, 'storekeeper', 'storekeeper', 'storekeeper@wsms.gr', 'STOREKEEPER');

-- --------------------------------------------------------

--
-- Table structure for table `wishproduct`
--

CREATE TABLE IF NOT EXISTS `wishproduct` (
  `idWishProduct` int(11) NOT NULL AUTO_INCREMENT,
  `quantity` int(11) NOT NULL,
  `description` varchar(45) NOT NULL,
  `idUser` int(11) NOT NULL,
  PRIMARY KEY (`idWishProduct`),
  KEY `fk_WishProduct_User1_idx` (`idUser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `customer_has_discount`
--
ALTER TABLE `customer_has_discount`
  ADD CONSTRAINT `fk_ProductSale_has_Customer_Customer1` FOREIGN KEY (`ssn`) REFERENCES `customer` (`ssn`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_ProductSale_has_Customer_ProductSale1` FOREIGN KEY (`sku`) REFERENCES `product` (`sku`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `history_saleorder`
--
ALTER TABLE `history_saleorder`
  ADD CONSTRAINT `fk_HistorySaleOrder_InstanceCustomer1` FOREIGN KEY (`idHistoryCustomer`) REFERENCES `history_customer` (`idHistoryCustomer`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `history_saleorder_has_history_product`
--
ALTER TABLE `history_saleorder_has_history_product`
  ADD CONSTRAINT `fk_HistorySaleOrder_has_InstanceProduct_HistorySaleOrder1` FOREIGN KEY (`idHistorySaleOrder`) REFERENCES `history_saleorder` (`idHistorySaleOrder`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_HistorySaleOrder_has_InstanceProduct_InstanceProduct1` FOREIGN KEY (`idHistoryProduct`) REFERENCES `history_product` (`idHistoryProduct`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `history_supplyorder`
--
ALTER TABLE `history_supplyorder`
  ADD CONSTRAINT `fk_HistorySupplyOrder_HistoryProvider1` FOREIGN KEY (`idHistoryProvider`) REFERENCES `history_provider` (`idHistoryProvider`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `history_supplyorder_has_history_product`
--
ALTER TABLE `history_supplyorder_has_history_product`
  ADD CONSTRAINT `fk_HistorySupplyOrder_has_HistoryProduct_HistoryProduct1` FOREIGN KEY (`idHistoryProduct`) REFERENCES `history_product` (`idHistoryProduct`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_HistorySupplyOrder_has_HistoryProduct_HistorySupplyOrder1` FOREIGN KEY (`idHistorySupplyOrder`) REFERENCES `history_supplyorder` (`idHistorySupplyOrder`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `saleorder`
--
ALTER TABLE `saleorder`
  ADD CONSTRAINT `fk_OrderSale_Customer1` FOREIGN KEY (`customerSsn`) REFERENCES `customer` (`ssn`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_OrderSale_User1` FOREIGN KEY (`idUser`) REFERENCES `user` (`idUser`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `saleorder_has_product`
--
ALTER TABLE `saleorder_has_product`
  ADD CONSTRAINT `fk_Product_has_SaleOrder_Product1` FOREIGN KEY (`sku`) REFERENCES `product` (`sku`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_SaleOrderHasProduct_SaleOrder1` FOREIGN KEY (`idSaleOrder`, `dateUpdated`) REFERENCES `saleorder` (`idSaleOrder`, `dateUpdated`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `supplyorder`
--
ALTER TABLE `supplyorder`
  ADD CONSTRAINT `fk_OrderSupply_Provider1` FOREIGN KEY (`providerSsn`) REFERENCES `provider` (`ssn`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_OrderSupply_User1` FOREIGN KEY (`idUser`) REFERENCES `user` (`idUser`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `supplyorder_has_product`
--
ALTER TABLE `supplyorder_has_product`
  ADD CONSTRAINT `fk_SupplyOrder_has_Product_Product1` FOREIGN KEY (`sku`) REFERENCES `product` (`sku`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_SupplyOrder_has_Product_SupplyOrder1` FOREIGN KEY (`idSupplyOrder`) REFERENCES `supplyorder` (`idSupplyOrder`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `wishproduct`
--
ALTER TABLE `wishproduct`
  ADD CONSTRAINT `fk_WishProduct_User1` FOREIGN KEY (`idUser`) REFERENCES `user` (`idUser`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
