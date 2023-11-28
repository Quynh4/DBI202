USE master;
IF EXISTS (SELECT * FROM sys.databases WHERE name = 'InternetCafe')
BEGIN
	DROP DATABASE InternetCafe;
END


CREATE DATABASE InternetCafe;
USE InternetCafe;

CREATE TABLE [Customer] (
  customer_id INT IDENTITY(1, 1) PRIMARY KEY,
  customer_name VARCHAR(50) NOT NULL,
  date_of_birth DATE,
  phone VARCHAR(10)
);


CREATE TABLE [Staff] (
  staff_id INT IDENTITY(1, 1) PRIMARY KEY,
  staff_name VARCHAR(30) NOT NULL,
  salary MONEY NOT NULL,
  phone VARCHAR(10),
  date_of_birth DATE,
  job_title VARCHAR(20)
);


CREATE TABLE [Equipment] (
  equipment_id INT IDENTITY(1, 1) PRIMARY KEY,
  equipment_name VARCHAR(50),
  condition CHAR(1) NOT NULL CHECK(condition IN ('G', 'B', 'O')) DEFAULT 'G'
);

CREATE TABLE [Computer] (
  computer_id INT IDENTITY(1, 1) PRIMARY KEY,
  computer_name VARCHAR(50) NOT NULL,
  [status] BIT NOT NULL CHECK([status] IN (1, 0)) DEFAULT 0,
  manufacturer VARCHAR(50) NOT NULL
);


CREATE TABLE [Pantry] (
  item_id INT IDENTITY(1, 1) PRIMARY KEY,
  item_name VARCHAR(50) NOT NULL,
  unit VARCHAR(20) NOT NULL,
  price_per_unit MONEY NOT NULL
);


CREATE TABLE [Account] (
  account_id INT IDENTITY(1, 1) PRIMARY KEY,
  username VARCHAR(15) NOT NULL UNIQUE,
  [password] VARCHAR(128) NOT NULL CHECK(LEN([password]) >= 8),
  remaining_time_in_seconds INT NOT NULL DEFAULT 0,
  customer_id INT NOT NULL FOREIGN KEY REFERENCES Customer(customer_id),
);


CREATE TABLE [SessionLog] (
  log_id INT IDENTITY(1, 1) PRIMARY KEY,
  computer_id INT NOT NULL FOREIGN KEY REFERENCES Computer(computer_id),
  account_id INT FOREIGN KEY REFERENCES Account(account_id),
  log_start DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  log_end DATETIME,
  log_description VARCHAR(255),
);

CREATE TABLE [PaymentMethod] (
  id INT IDENTITY(1, 1) PRIMARY KEY,
  [name] VARCHAR(30),
);

CREATE TABLE [Promotion] (
  id INT IDENTITY(1, 1) PRIMARY KEY,
  [name] VARCHAR(20) NOT NULL,
  [description] VARCHAR(255) 
);


CREATE TABLE [ProviderType] (
  id INT IDENTITY(1, 1) PRIMARY KEY,
  [name] VARCHAR(50) NOT NULL,
  [description] VARCHAR(255)
);

CREATE TABLE [Provider] (
  id INT IDENTITY(1, 1) PRIMARY KEY,
  [name] VARCHAR(50) NOT NULL,
  phone VARCHAR(50) NOT NULL,
  [address] VARCHAR(50) NOT NULL,
  [type_id] INT NOT NULL FOREIGN KEY REFERENCES ProviderType(id),
);
-------------------
CREATE TABLE [EquipmentProvidingHistory] (
  id INT IDENTITY(1, 1) PRIMARY KEY,
  provider_id INT NOT NULL FOREIGN KEY REFERENCES [Provider](id),
  equipment_id INT NOT NULL FOREIGN KEY REFERENCES [Equipment](id),
  receiving_time DATETIME NOT NULL,
);


CREATE TABLE [ComputerProvidingHistory] (
  id INT IDENTITY(1, 1) PRIMARY KEY,
  provider_id INT NOT NULL FOREIGN KEY REFERENCES [Provider](id),
  computer_id INT NOT NULL FOREIGN KEY REFERENCES [Computer](id),
  receiving_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);



CREATE TABLE [PantryProvidingHistory] (
  id INT IDENTITY(1, 1) PRIMARY KEY,
  provider_id INT NOT NULL FOREIGN KEY REFERENCES [Provider](id),
  item_id INT NOT NULL FOREIGN KEY REFERENCES [Pantry](item_id),
  receiving_time DATETIME NOT NULL,
);


CREATE TABLE [Invoice] (
  id INT IDENTITY(1, 1) PRIMARY KEY,
  customer_id INT NOT NULL FOREIGN KEY REFERENCES Customer(id),
  staff_id INT NOT NULL FOREIGN KEY REFERENCES Staff(id),
  [session_id] INT NOT NULL FOREIGN KEY REFERENCES SessionLog(id),
  payment_method_id INT NOT NULL FOREIGN KEY REFERENCES PaymentMethod(id),
  promotion_id INT FOREIGN KEY REFERENCES Promotion(id),
  amount MONEY NOT NULL
);


CREATE TABLE [PantryOrderHistory] (
  history_id INT IDENTITY(1, 1) PRIMARY KEY,
  customer_id INT NOT NULL FOREIGN KEY REFERENCES Customer(id),
  [session_id] INT NOT NULL FOREIGN KEY REFERENCES SessionLog(id),
  quantity INT NOT NULL,
);


CREATE TABLE [Maintainer] (
  id INT IDENTITY(1, 1) PRIMARY KEY,
  [name] VARCHAR(50) NOT NULL,
  phone VARCHAR(10) NOT NULL,
  [type] VARCHAR(20) NOT NULL CHECK ([type] IN ('Computer', 'Maintainer')),
);

CREATE TABLE [ComputerMaintenanceHistory] (
  id INT IDENTITY(1, 1) PRIMARY KEY,
  maintainer_id INT NOT NULL FOREIGN KEY REFERENCES Maintainer(id),
  computer_id INT NOT NULL FOREIGN KEY REFERENCES Computer(id),
  maintenance_time DATETIME NOT NULL,
  amount MONEY NOT NULL
);

CREATE TABLE [EquipmentMaintenanceHistory] (
  id INT IDENTITY(1, 1) PRIMARY KEY,
  maintainer_id INT NOT NULL FOREIGN KEY REFERENCES Maintainer(id),
  equipment_id INT NOT NULL FOREIGN KEY REFERENCES Equipment(id),
  maintenance_time DATETIME NOT NULL,
  amount MONEY NOT NULL
);
