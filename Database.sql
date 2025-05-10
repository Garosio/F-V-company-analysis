DROP DATABASE IF EXISTS `F&V company`;
CREATE DATABASE `F&V company`;
USE `F&V company`;

SET NAMES utf8 ; 

CREATE TABLE Products (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Segment VARCHAR(50), -- e.g., 'Fresh' or 'Transformed'
    Category VARCHAR(50), -- like veg/fruits
    SubCategory  VARCHAR(50), -- like species??
    UnitofMeasure VARCHAR(50)
    
);

CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    ContactName VARCHAR(100),
    Phone VARCHAR(50),
    Email VARCHAR(100),
    Address TEXT
);

CREATE TABLE ProductSupplier (
    ProductID INT,                             -- Foreign key from Products table
    SupplierID INT,                            -- Foreign key from Suppliers table
    LeadTime DATE,
    Incoterm VARCHAR(10),  -- DDP or FCA
    PRIMARY KEY (ProductID, SupplierID),       -- Composite primary key (ensures uniqueness)
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE,
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID) ON DELETE CASCADE
);

CREATE TABLE PurchaseContracts (
	ContractID INT PRIMARY KEY AUTO_INCREMENT,
    ContractCurrency VARCHAR(5),
    UnitofMeasure VARCHAR(50),
    ProductID INT,
    ContractVolume DECIMAL(20,2),
    ContractPrice DECIMAL(10,2),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);


CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    CustomerType VARCHAR(10), -- Business / Consumer
    Email VARCHAR(100),
    Phone VARCHAR(20),
    Address TEXT
);

CREATE TABLE Plant (
	PlantID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Country VARCHAR(20),
    Address VARCHAR(100),
    ZIPCode VARCHAR(20)
);
INSERT INTO Plant (Name, Country, Address, ZIPCode)
	VALUES
	('Roma', 'Italy', 'Via del Governo Vecchio, 20', '246'),
    ('Lentate sul Seveso', 'Italy', 'Via Alberto da Giussano, 18', '135'),
    ('Munich', 'Germany', 'EinZweiDrei Straße, 45', '789'),
    ('Cabot Cove', 'Maine', 'Murders she wrote road, 35', '123'),
    ('Saskatoon', 'Saskatchewan', 'Saskastreet, 75', '456')
    ;
    

CREATE TABLE SalesOrders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    OrderCreationDate DATE,
    DeliveryDate DATE,
	ProductID INT,
    PlantID INT,
    OrderVolume DECIMAL(20,2),
	FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
	FOREIGN KEY (PlantID) REFERENCES Plant(PlantID)
);

CREATE TABLE PurchaseOrders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    SupplierID INT,
    OrderCreationDate DATE,
    DeliveryDate DATE,
    PlantID INT,
    ProductID INT,
    OrderVolume DECIMAL(20,2),
    OrderPrice DECIMAL(10,2),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (PlantID) REFERENCES Plant(PlantID),
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);


    
    