USE AdventureWorks2012; /*Set current database*/

/*1, Display the total amount collected from the orders for each order date. */
/* Table: Sales.SalesOrderHeader*/
SELECT OrderDate, sum(TotalDue) as TotalDue
FROM Sales.SalesOrderHeader
Group by OrderDate
ORDER BY OrderDate DESC;

/*2, Display the total amount collected from selling the products, 774 and 777. */
/* Table: Sales.SalesOrderDetail*/
SELECT ProductID, sum(LineTotal) as Total 
FROM Sales.SalesOrderDetail
WHERE ProductID = 774 or ProductID = 777
GROUP BY ProductID;
/*Plus find maximum unit price*/
SELECT ProductID, sum(LineTotal) as Total, max(UnitPrice) as MaxUnitPrice 
FROM Sales.SalesOrderDetail
WHERE ProductID = 774 or ProductID = 777
GROUP BY ProductID;

/*3, Write a query to display the sales person BusinessEntityID, last name and first name of all the sales persons and the name of the territory to which they belong.*/
SELECT a.BusinessEntityID, b.FirstName, b.LastName, c.Name
FROM Sales.SalesPerson as a 
LEFT JOIN Person.Person as b
ON a.BusinessEntityID = b.BusinessEntityID
FULL OUTER JOIN Sales.SalesTerritory as c
ON a.TerritoryID=c.TerritoryID;

/*4,  Write a query to display the Business Entities of the customers that have the 'Vista' credit card.*/
/* Tables: Sales.CreditCard, Sales.PersonCreditCard, Person.Person*/
SELECT 
	c.BusinessEntityID
FROM Sales.CreditCard as a 
INNER JOIN Sales.PersonCreditCard as b
ON a.CreditCardID=b.CreditCardID
JOIN Person.Person as c
ON b.BusinessEntityID=c.BusinessEntityID
WHERE CardType =  'Vista'
ORDER BY BusinessEntityID;

/*Show the number of customers for each type of credit cards*/
SELECT CardType, count(CreditCardID) AS NumberOfCustomers
FROM Sales.CreditCard
Group By CardType;

/*5, Write a query to display ALL the country region codes along with their corresponding territory IDs*/
/* tables: Sales.SalesTerritory,  Person.CountryRegion*/
SELECT a.CountryRegionCode, a.Name, b.TerritoryID
FROM Person.CountryRegion as a
LEFT JOIN Sales.SalesTerritory as b
on a.CountryRegionCode = b.CountryRegionCode;
/*List all the countries/regions that do not belong to any territory - CountryRegionCodes that dont belong to any territory*/
SELECT a.CountryRegionCode, a.Name, b.TerritoryID
FROM Person.CountryRegion as a
LEFT JOIN Sales.SalesTerritory as b
on a.CountryRegionCode = b.CountryRegionCode
WHERE b.TerritoryID is NULL;

/*6, Find out the average of the total dues of all the orders.*/
/* tables: Sales.SalesOrderHeader*/
SELECT AVG(TotalDue) as Average_TotalDue
FROM Sales.SalesOrderHeader;

/*7, Write a query to report the sales order ID of those orders where the total due is greater than the average of the total dues of all the orders*/
SELECT SalesOrderID, TotalDue
FROM Sales.SalesOrderHeader
WHERE TotalDue > 
	(SELECT AVG(TotalDue) as Average_TotalDue
	FROM Sales.SalesOrderHeader)
ORDER BY TotalDue;
/*subquery rather than number*/

