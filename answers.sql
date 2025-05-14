-- Creating a new table in 1NF to separate each product into its own row
CREATE TABLE ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(100)
);

-- Inserting data into the new table by separating the products
INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product)
SELECT OrderID, CustomerName, 'Laptop' AS Product FROM ProductDetail WHERE FIND_IN_SET('Laptop', Products)
UNION ALL
SELECT OrderID, CustomerName, 'Mouse' AS Product FROM ProductDetail WHERE FIND_IN_SET('Mouse', Products)
UNION ALL
SELECT OrderID, CustomerName, 'Tablet' AS Product FROM ProductDetail WHERE FIND_IN_SET('Tablet', Products)
UNION ALL
SELECT OrderID, CustomerName, 'Keyboard' AS Product FROM ProductDetail WHERE FIND_IN_SET('Keyboard', Products)
UNION ALL
SELECT OrderID, CustomerName, 'Phone' AS Product FROM ProductDetail WHERE FIND_IN_SET('Phone', Products);

-- Verifying the transformation into
-- Creating two tables to achieve 2NF: one for Orders and one for Customers
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

CREATE TABLE OrderDetails_2NF (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Inserting data into the Orders table (CustomerName is now stored separately)
INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName FROM OrderDetails;

-- Inserting data into the OrderDetails_2NF table (Only OrderID, Product, and Quantity)
INSERT INTO OrderDetails_2NF (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity FROM OrderDetails;

-- Verifying the normalization into 2NF
SELECT * FROM Orders;
SELECT * FROM OrderDetails_2NF;
