CREATE TABLE [dbo].[CustomerDemographics] (
    [CustomerTypeID] NCHAR (10) NOT NULL,
    [CustomerDesc]   NTEXT      NULL,
    CONSTRAINT [PK_CustomerDemographics] PRIMARY KEY NONCLUSTERED ([CustomerTypeID] ASC)
);


GO

CREATE TABLE [dbo].[Region] (
    [RegionID]          INT        NOT NULL,
    [RegionDescription] NCHAR (50) NOT NULL,
    CONSTRAINT [PK_Region] PRIMARY KEY NONCLUSTERED ([RegionID] ASC)
);


GO

CREATE TABLE [dbo].[Territories] (
    [TerritoryID]          NVARCHAR (20) NOT NULL,
    [TerritoryDescription] NCHAR (50)    NOT NULL,
    [RegionID]             INT           NOT NULL,
    CONSTRAINT [PK_Territories] PRIMARY KEY NONCLUSTERED ([TerritoryID] ASC),
    CONSTRAINT [FK_Territories_Region] FOREIGN KEY ([RegionID]) REFERENCES [dbo].[Region] ([RegionID])
);


GO

CREATE TABLE [dbo].[EmployeeTerritories] (
    [EmployeeID]  INT           NOT NULL,
    [TerritoryID] NVARCHAR (20) NOT NULL,
    CONSTRAINT [PK_EmployeeTerritories] PRIMARY KEY NONCLUSTERED ([EmployeeID] ASC, [TerritoryID] ASC),
    CONSTRAINT [FK_EmployeeTerritories_Employees] FOREIGN KEY ([EmployeeID]) REFERENCES [dbo].[Employees] ([EmployeeID]),
    CONSTRAINT [FK_EmployeeTerritories_Territories] FOREIGN KEY ([TerritoryID]) REFERENCES [dbo].[Territories] ([TerritoryID])
);


GO

CREATE TABLE [dbo].[Shippers] (
    [ShipperID]   INT           IDENTITY (1, 1) NOT NULL,
    [CompanyName] NVARCHAR (40) NOT NULL,
    [Phone]       NVARCHAR (24) NULL,
    CONSTRAINT [PK_Shippers] PRIMARY KEY CLUSTERED ([ShipperID] ASC)
);


GO

CREATE TABLE [dbo].[Customers] (
    [CustomerID]   NCHAR (5)     NOT NULL,
    [CompanyName]  NVARCHAR (40) NOT NULL,
    [ContactName]  NVARCHAR (30) NULL,
    [ContactTitle] NVARCHAR (30) NULL,
    [Address]      NVARCHAR (60) NULL,
    [City]         NVARCHAR (15) NULL,
    [Region]       NVARCHAR (15) NULL,
    [PostalCode]   NVARCHAR (10) NULL,
    [Country]      NVARCHAR (15) NULL,
    [Phone]        NVARCHAR (24) NULL,
    [Fax]          NVARCHAR (24) NULL,
    CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED ([CustomerID] ASC)
);


GO

CREATE TABLE [dbo].[Orders] (
    [OrderID]        INT           IDENTITY (1, 1) NOT NULL,
    [CustomerID]     NCHAR (5)     NULL,
    [EmployeeID]     INT           NULL,
    [OrderDate]      DATETIME      NULL,
    [RequiredDate]   DATETIME      NULL,
    [ShippedDate]    DATETIME      NULL,
    [ShipVia]        INT           NULL,
    [Freight]        MONEY         CONSTRAINT [DF_Orders_Freight] DEFAULT ((0)) NULL,
    [ShipName]       NVARCHAR (40) NULL,
    [ShipAddress]    NVARCHAR (60) NULL,
    [ShipCity]       NVARCHAR (15) NULL,
    [ShipRegion]     NVARCHAR (15) NULL,
    [ShipPostalCode] NVARCHAR (10) NULL,
    [ShipCountry]    NVARCHAR (15) NULL,
    CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED ([OrderID] ASC),
    CONSTRAINT [FK_Orders_Customers] FOREIGN KEY ([CustomerID]) REFERENCES [dbo].[Customers] ([CustomerID]),
    CONSTRAINT [FK_Orders_Employees] FOREIGN KEY ([EmployeeID]) REFERENCES [dbo].[Employees] ([EmployeeID]),
    CONSTRAINT [FK_Orders_Shippers] FOREIGN KEY ([ShipVia]) REFERENCES [dbo].[Shippers] ([ShipperID])
);


GO

CREATE TABLE [dbo].[Suppliers] (
    [SupplierID]   INT           IDENTITY (1, 1) NOT NULL,
    [CompanyName]  NVARCHAR (40) NOT NULL,
    [ContactName]  NVARCHAR (30) NULL,
    [ContactTitle] NVARCHAR (30) NULL,
    [Address]      NVARCHAR (60) NULL,
    [City]         NVARCHAR (15) NULL,
    [Region]       NVARCHAR (15) NULL,
    [PostalCode]   NVARCHAR (10) NULL,
    [Country]      NVARCHAR (15) NULL,
    [Phone]        NVARCHAR (24) NULL,
    [Fax]          NVARCHAR (24) NULL,
    [HomePage]     NTEXT         NULL,
    CONSTRAINT [PK_Suppliers] PRIMARY KEY CLUSTERED ([SupplierID] ASC)
);


GO

CREATE TABLE [dbo].[Products] (
    [ProductID]       INT           IDENTITY (1, 1) NOT NULL,
    [ProductName]     NVARCHAR (40) NOT NULL,
    [SupplierID]      INT           NULL,
    [CategoryID]      INT           NULL,
    [QuantityPerUnit] NVARCHAR (20) NULL,
    [UnitPrice]       MONEY         CONSTRAINT [DF_Products_UnitPrice] DEFAULT ((0)) NULL,
    [UnitsInStock]    SMALLINT      CONSTRAINT [DF_Products_UnitsInStock] DEFAULT ((0)) NULL,
    [UnitsOnOrder]    SMALLINT      CONSTRAINT [DF_Products_UnitsOnOrder] DEFAULT ((0)) NULL,
    [ReorderLevel]    SMALLINT      CONSTRAINT [DF_Products_ReorderLevel] DEFAULT ((0)) NULL,
    [Discontinued]    BIT           CONSTRAINT [DF_Products_Discontinued] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED ([ProductID] ASC),
    CONSTRAINT [CK_Products_UnitPrice] CHECK ([UnitPrice]>=(0)),
    CONSTRAINT [CK_ReorderLevel] CHECK ([ReorderLevel]>=(0)),
    CONSTRAINT [CK_UnitsInStock] CHECK ([UnitsInStock]>=(0)),
    CONSTRAINT [CK_UnitsOnOrder] CHECK ([UnitsOnOrder]>=(0)),
    CONSTRAINT [FK_Products_Categories] FOREIGN KEY ([CategoryID]) REFERENCES [dbo].[Categories] ([CategoryID]),
    CONSTRAINT [FK_Products_Suppliers] FOREIGN KEY ([SupplierID]) REFERENCES [dbo].[Suppliers] ([SupplierID])
);


GO

CREATE TABLE [dbo].[Categories] (
    [CategoryID]   INT           IDENTITY (1, 1) NOT NULL,
    [CategoryName] NVARCHAR (15) NOT NULL,
    [Description]  NTEXT         NULL,
    [Picture]      IMAGE         NULL,
    CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED ([CategoryID] ASC)
);


GO

CREATE TABLE [dbo].[Order Details] (
    [OrderID]   INT      NOT NULL,
    [ProductID] INT      NOT NULL,
    [UnitPrice] MONEY    CONSTRAINT [DF_Order_Details_UnitPrice] DEFAULT ((0)) NOT NULL,
    [Quantity]  SMALLINT CONSTRAINT [DF_Order_Details_Quantity] DEFAULT ((1)) NOT NULL,
    [Discount]  REAL     CONSTRAINT [DF_Order_Details_Discount] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_Order_Details] PRIMARY KEY CLUSTERED ([OrderID] ASC, [ProductID] ASC),
    CONSTRAINT [CK_Discount] CHECK ([Discount]>=(0) AND [Discount]<=(1)),
    CONSTRAINT [CK_Quantity] CHECK ([Quantity]>(0)),
    CONSTRAINT [CK_UnitPrice] CHECK ([UnitPrice]>=(0)),
    CONSTRAINT [FK_Order_Details_Orders] FOREIGN KEY ([OrderID]) REFERENCES [dbo].[Orders] ([OrderID]),
    CONSTRAINT [FK_Order_Details_Products] FOREIGN KEY ([ProductID]) REFERENCES [dbo].[Products] ([ProductID])
);


GO

CREATE TABLE [dbo].[Employees] (
    [EmployeeID]      INT            IDENTITY (1, 1) NOT NULL,
    [LastName]        NVARCHAR (20)  NOT NULL,
    [FirstName]       NVARCHAR (10)  NOT NULL,
    [Title]           NVARCHAR (30)  NULL,
    [TitleOfCourtesy] NVARCHAR (25)  NULL,
    [BirthDate]       DATETIME       NULL,
    [HireDate]        DATETIME       NULL,
    [Address]         NVARCHAR (60)  NULL,
    [City]            NVARCHAR (15)  NULL,
    [Region]          NVARCHAR (15)  NULL,
    [PostalCode]      NVARCHAR (10)  NULL,
    [Country]         NVARCHAR (15)  NULL,
    [HomePhone]       NVARCHAR (24)  NULL,
    [Extension]       NVARCHAR (4)   NULL,
    [Photo]           IMAGE          NULL,
    [Notes]           NTEXT          NULL,
    [ReportsTo]       INT            NULL,
    [PhotoPath]       NVARCHAR (255) NULL,
    CONSTRAINT [PK_Employees] PRIMARY KEY CLUSTERED ([EmployeeID] ASC),
    CONSTRAINT [CK_Birthdate] CHECK ([BirthDate]<getdate()),
    CONSTRAINT [FK_Employees_Employees] FOREIGN KEY ([ReportsTo]) REFERENCES [dbo].[Employees] ([EmployeeID])
);


GO

CREATE TABLE [dbo].[CustomerCustomerDemo] (
    [CustomerID]     NCHAR (5)  NOT NULL,
    [CustomerTypeID] NCHAR (10) NOT NULL,
    CONSTRAINT [PK_CustomerCustomerDemo] PRIMARY KEY NONCLUSTERED ([CustomerID] ASC, [CustomerTypeID] ASC),
    CONSTRAINT [FK_CustomerCustomerDemo] FOREIGN KEY ([CustomerTypeID]) REFERENCES [dbo].[CustomerDemographics] ([CustomerTypeID]),
    CONSTRAINT [FK_CustomerCustomerDemo_Customers] FOREIGN KEY ([CustomerID]) REFERENCES [dbo].[Customers] ([CustomerID])
);


GO


create view "Alphabetical list of products" AS
SELECT Products.*, Categories.CategoryName
FROM Categories INNER JOIN Products ON Categories.CategoryID = Products.CategoryID
WHERE (((Products.Discontinued)=0))

GO


create view "Order Details Extended" AS
SELECT "Order Details".OrderID, "Order Details".ProductID, Products.ProductName, 
	"Order Details".UnitPrice, "Order Details".Quantity, "Order Details".Discount, 
	(CONVERT(money,("Order Details".UnitPrice*Quantity*(1-Discount)/100))*100) AS ExtendedPrice
FROM Products INNER JOIN "Order Details" ON Products.ProductID = "Order Details".ProductID
--ORDER BY "Order Details".OrderID

GO


create view "Products Above Average Price" AS
SELECT Products.ProductName, Products.UnitPrice
FROM Products
WHERE Products.UnitPrice>(SELECT AVG(UnitPrice) From Products)
--ORDER BY Products.UnitPrice DESC

GO


create view "Product Sales for 1997" AS
SELECT Categories.CategoryName, Products.ProductName, 
Sum(CONVERT(money,("Order Details".UnitPrice*Quantity*(1-Discount)/100))*100) AS ProductSales
FROM (Categories INNER JOIN Products ON Categories.CategoryID = Products.CategoryID) 
	INNER JOIN (Orders 
		INNER JOIN "Order Details" ON Orders.OrderID = "Order Details".OrderID) 
	ON Products.ProductID = "Order Details".ProductID
WHERE (((Orders.ShippedDate) Between '19970101' And '19971231'))
GROUP BY Categories.CategoryName, Products.ProductName

GO


create view "Summary of Sales by Quarter" AS
SELECT Orders.ShippedDate, Orders.OrderID, "Order Subtotals".Subtotal
FROM Orders INNER JOIN "Order Subtotals" ON Orders.OrderID = "Order Subtotals".OrderID
WHERE Orders.ShippedDate IS NOT NULL
--ORDER BY Orders.ShippedDate

GO


create view "Summary of Sales by Year" AS
SELECT Orders.ShippedDate, Orders.OrderID, "Order Subtotals".Subtotal
FROM Orders INNER JOIN "Order Subtotals" ON Orders.OrderID = "Order Subtotals".OrderID
WHERE Orders.ShippedDate IS NOT NULL
--ORDER BY Orders.ShippedDate

GO


create view "Sales Totals by Amount" AS
SELECT "Order Subtotals".Subtotal AS SaleAmount, Orders.OrderID, Customers.CompanyName, Orders.ShippedDate
FROM 	Customers INNER JOIN 
		(Orders INNER JOIN "Order Subtotals" ON Orders.OrderID = "Order Subtotals".OrderID) 
	ON Customers.CustomerID = Orders.CustomerID
WHERE ("Order Subtotals".Subtotal >2500) AND (Orders.ShippedDate BETWEEN '19970101' And '19971231')

GO


create view "Products by Category" AS
SELECT Categories.CategoryName, Products.ProductName, Products.QuantityPerUnit, Products.UnitsInStock, Products.Discontinued
FROM Categories INNER JOIN Products ON Categories.CategoryID = Products.CategoryID
WHERE Products.Discontinued <> 1
--ORDER BY Categories.CategoryName, Products.ProductName

GO


create view "Sales by Category" AS
SELECT Categories.CategoryID, Categories.CategoryName, Products.ProductName, 
	Sum("Order Details Extended".ExtendedPrice) AS ProductSales
FROM 	Categories INNER JOIN 
		(Products INNER JOIN 
			(Orders INNER JOIN "Order Details Extended" ON Orders.OrderID = "Order Details Extended".OrderID) 
		ON Products.ProductID = "Order Details Extended".ProductID) 
	ON Categories.CategoryID = Products.CategoryID
WHERE Orders.OrderDate BETWEEN '19970101' And '19971231'
GROUP BY Categories.CategoryID, Categories.CategoryName, Products.ProductName
--ORDER BY Products.ProductName

GO


create view "Current Product List" AS
SELECT Product_List.ProductID, Product_List.ProductName
FROM Products AS Product_List
WHERE (((Product_List.Discontinued)=0))
--ORDER BY Product_List.ProductName

GO


create view Invoices AS
SELECT Orders.ShipName, Orders.ShipAddress, Orders.ShipCity, Orders.ShipRegion, Orders.ShipPostalCode, 
	Orders.ShipCountry, Orders.CustomerID, Customers.CompanyName AS CustomerName, Customers.Address, Customers.City, 
	Customers.Region, Customers.PostalCode, Customers.Country, 
	(FirstName + ' ' + LastName) AS Salesperson, 
	Orders.OrderID, Orders.OrderDate, Orders.RequiredDate, Orders.ShippedDate, Shippers.CompanyName As ShipperName, 
	"Order Details".ProductID, Products.ProductName, "Order Details".UnitPrice, "Order Details".Quantity, 
	"Order Details".Discount, 
	(CONVERT(money,("Order Details".UnitPrice*Quantity*(1-Discount)/100))*100) AS ExtendedPrice, Orders.Freight
FROM 	Shippers INNER JOIN 
		(Products INNER JOIN 
			(
				(Employees INNER JOIN 
					(Customers INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID) 
				ON Employees.EmployeeID = Orders.EmployeeID) 
			INNER JOIN "Order Details" ON Orders.OrderID = "Order Details".OrderID) 
		ON Products.ProductID = "Order Details".ProductID) 
	ON Shippers.ShipperID = Orders.ShipVia

GO


create view "Order Subtotals" AS
SELECT "Order Details".OrderID, Sum(CONVERT(money,("Order Details".UnitPrice*Quantity*(1-Discount)/100))*100) AS Subtotal
FROM "Order Details"
GROUP BY "Order Details".OrderID

GO


create view "Customer and Suppliers by City" AS
SELECT City, CompanyName, ContactName, 'Customers' AS Relationship 
FROM Customers
UNION SELECT City, CompanyName, ContactName, 'Suppliers'
FROM Suppliers
--ORDER BY City, CompanyName

GO


create view "Category Sales for 1997" AS
SELECT "Product Sales for 1997".CategoryName, Sum("Product Sales for 1997".ProductSales) AS CategorySales
FROM "Product Sales for 1997"
GROUP BY "Product Sales for 1997".CategoryName

GO


create view "Quarterly Orders" AS
SELECT DISTINCT Customers.CustomerID, Customers.CompanyName, Customers.City, Customers.Country
FROM Customers RIGHT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
WHERE Orders.OrderDate BETWEEN '19970101' And '19971231'

GO


create view "Orders Qry" AS
SELECT Orders.OrderID, Orders.CustomerID, Orders.EmployeeID, Orders.OrderDate, Orders.RequiredDate, 
	Orders.ShippedDate, Orders.ShipVia, Orders.Freight, Orders.ShipName, Orders.ShipAddress, Orders.ShipCity, 
	Orders.ShipRegion, Orders.ShipPostalCode, Orders.ShipCountry, 
	Customers.CompanyName, Customers.Address, Customers.City, Customers.Region, Customers.PostalCode, Customers.Country
FROM Customers INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID

GO

CREATE NONCLUSTERED INDEX [EmployeesOrders]
    ON [dbo].[Orders]([EmployeeID] ASC);


GO

CREATE NONCLUSTERED INDEX [OrderDate]
    ON [dbo].[Orders]([OrderDate] ASC);


GO

CREATE NONCLUSTERED INDEX [SuppliersProducts]
    ON [dbo].[Products]([SupplierID] ASC);


GO

CREATE NONCLUSTERED INDEX [EmployeeID]
    ON [dbo].[Orders]([EmployeeID] ASC);


GO

CREATE NONCLUSTERED INDEX [ShippedDate]
    ON [dbo].[Orders]([ShippedDate] ASC);


GO

CREATE NONCLUSTERED INDEX [LastName]
    ON [dbo].[Employees]([LastName] ASC);


GO

CREATE NONCLUSTERED INDEX [ProductID]
    ON [dbo].[Order Details]([ProductID] ASC);


GO

CREATE NONCLUSTERED INDEX [CompanyName]
    ON [dbo].[Customers]([CompanyName] ASC);


GO

CREATE NONCLUSTERED INDEX [PostalCode]
    ON [dbo].[Customers]([PostalCode] ASC);


GO

CREATE NONCLUSTERED INDEX [PostalCode]
    ON [dbo].[Employees]([PostalCode] ASC);


GO

CREATE NONCLUSTERED INDEX [SupplierID]
    ON [dbo].[Products]([SupplierID] ASC);


GO

CREATE NONCLUSTERED INDEX [ProductName]
    ON [dbo].[Products]([ProductName] ASC);


GO

CREATE NONCLUSTERED INDEX [CategoryName]
    ON [dbo].[Categories]([CategoryName] ASC);


GO

CREATE NONCLUSTERED INDEX [CategoryID]
    ON [dbo].[Products]([CategoryID] ASC);


GO

CREATE NONCLUSTERED INDEX [OrdersOrder_Details]
    ON [dbo].[Order Details]([OrderID] ASC);


GO

CREATE NONCLUSTERED INDEX [Region]
    ON [dbo].[Customers]([Region] ASC);


GO

CREATE NONCLUSTERED INDEX [CompanyName]
    ON [dbo].[Suppliers]([CompanyName] ASC);


GO

CREATE NONCLUSTERED INDEX [ProductsOrder_Details]
    ON [dbo].[Order Details]([ProductID] ASC);


GO

CREATE NONCLUSTERED INDEX [PostalCode]
    ON [dbo].[Suppliers]([PostalCode] ASC);


GO

CREATE NONCLUSTERED INDEX [CategoriesProducts]
    ON [dbo].[Products]([CategoryID] ASC);


GO

CREATE NONCLUSTERED INDEX [OrderID]
    ON [dbo].[Order Details]([OrderID] ASC);


GO

CREATE NONCLUSTERED INDEX [ShippersOrders]
    ON [dbo].[Orders]([ShipVia] ASC);


GO

CREATE NONCLUSTERED INDEX [CustomersOrders]
    ON [dbo].[Orders]([CustomerID] ASC);


GO

CREATE NONCLUSTERED INDEX [CustomerID]
    ON [dbo].[Orders]([CustomerID] ASC);


GO

CREATE NONCLUSTERED INDEX [City]
    ON [dbo].[Customers]([City] ASC);


GO

CREATE NONCLUSTERED INDEX [ShipPostalCode]
    ON [dbo].[Orders]([ShipPostalCode] ASC);


GO

CREATE USER [venkat];


GO

CREATE USER [vp];


GO


create procedure "Employee Sales by Country" 
@Beginning_Date DateTime, @Ending_Date DateTime AS
SELECT Employees.Country, Employees.LastName, Employees.FirstName, Orders.ShippedDate, Orders.OrderID, "Order Subtotals".Subtotal AS SaleAmount
FROM Employees INNER JOIN 
	(Orders INNER JOIN "Order Subtotals" ON Orders.OrderID = "Order Subtotals".OrderID) 
	ON Employees.EmployeeID = Orders.EmployeeID
WHERE Orders.ShippedDate Between @Beginning_Date And @Ending_Date

GO

CREATE PROCEDURE CustOrderHist @CustomerID nchar(5)
AS
SELECT ProductName, Total=SUM(Quantity)
FROM Products P, [Order Details] OD, Orders O, Customers C
WHERE C.CustomerID = @CustomerID
AND C.CustomerID = O.CustomerID AND O.OrderID = OD.OrderID AND OD.ProductID = P.ProductID
GROUP BY ProductName

GO


CREATE PROCEDURE CustOrdersOrders @CustomerID nchar(5)
AS
SELECT OrderID, 
	OrderDate,
	RequiredDate,
	ShippedDate
FROM Orders
WHERE CustomerID = @CustomerID
ORDER BY OrderID

GO


create procedure "Sales by Year" 
	@Beginning_Date DateTime, @Ending_Date DateTime AS
SELECT Orders.ShippedDate, Orders.OrderID, "Order Subtotals".Subtotal, DATENAME(yy,ShippedDate) AS Year
FROM Orders INNER JOIN "Order Subtotals" ON Orders.OrderID = "Order Subtotals".OrderID
WHERE Orders.ShippedDate Between @Beginning_Date And @Ending_Date

GO

CREATE PROCEDURE SalesByCategory
    @CategoryName nvarchar(15), @OrdYear nvarchar(4) = '1998'
AS
IF @OrdYear != '1996' AND @OrdYear != '1997' AND @OrdYear != '1998' 
BEGIN
	SELECT @OrdYear = '1998'
END

SELECT ProductName,
	TotalPurchase=ROUND(SUM(CONVERT(decimal(14,2), OD.Quantity * (1-OD.Discount) * OD.UnitPrice)), 0)
FROM [Order Details] OD, Orders O, Products P, Categories C
WHERE OD.OrderID = O.OrderID 
	AND OD.ProductID = P.ProductID 
	AND P.CategoryID = C.CategoryID
	AND C.CategoryName = @CategoryName
	AND SUBSTRING(CONVERT(nvarchar(22), O.OrderDate, 111), 1, 4) = @OrdYear
GROUP BY ProductName
ORDER BY ProductName

GO


create procedure "Ten Most Expensive Products" AS
SET ROWCOUNT 10
SELECT Products.ProductName AS TenMostExpensiveProducts, Products.UnitPrice
FROM Products
ORDER BY Products.UnitPrice DESC

GO


CREATE PROCEDURE CustOrdersDetail @OrderID int
AS
SELECT ProductName,
    UnitPrice=ROUND(Od.UnitPrice, 2),
    Quantity,
    Discount=CONVERT(int, Discount * 100), 
    ExtendedPrice=ROUND(CONVERT(money, Quantity * (1 - Discount) * Od.UnitPrice), 2)
FROM Products P, [Order Details] Od
WHERE Od.ProductID = P.ProductID and Od.OrderID = @OrderID

GO

