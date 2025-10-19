Create database OnlineRetaildb

use onlineretaildb

Create table Customers( 
Customer_id int identity (1,1) Primary key,
Name varchar(255) Not Null,
Email varchar(255) Not NUll,
City Varchar(255),
Join_Date Date default GetDate()
);
	
Create Table Products(
Product_ID Int identity (1,1) Primary key,
Product_Name Varchar(255) Not NULL,
Category varchar(255),
Price Decimal(10,2) Not Null,
Stock Int Default 0
);

Create Table Orders(
Order_Id int identity (1,1) Primary key,
Customer_id Int not null,
Order_Date Date Default Getdate(),
constraint FK_orders_customers Foreign key (Customer_Id) References Customers(Customer_Id)
);

CREATE TABLE Order_Details (
Detail_id INT IDENTITY(1,1) PRIMARY KEY,
Order_id INT NOT NULL,
Product_id INT NOT NULL,
Quantity INT NOT NULL CHECK (quantity > 0),
CONSTRAINT FK_OD_Orders FOREIGN KEY (order_id) REFERENCES Orders(order_id),
CONSTRAINT FK_OD_Products FOREIGN KEY (product_id) REFERENCES Products(product_id)
);


Create Table Payment(
Payment_Id INT identity (1,1) Primary key,
Order_Id Int not null,
Payment_Mode Varchar(255),
Payment_Status Varchar(255),
Amount decimal(12,2) Not null,
Constraint Fk_Payments_Orders Foreign key (order_id) References Orders(order_id)
);

SET IDENTITY_INSERT Customers ON;
INSERT INTO Customers (customer_id, name, email, city, join_date) VALUES
(1, 'Amit Sharma', 'amit@example.com', 'Pune', '2024-01-15'),
(2, 'Sita Patel', 'sita@example.com', 'Mumbai', '2024-02-10'),
(3, 'Rahul Verma', 'rahul@example.com', 'Delhi', '2024-03-05'),
(4, 'Neha Singh', 'neha@example.com', 'Bengaluru', '2024-04-20'),
(5, 'Pooja Rao', 'pooja@example.com', 'Hyderabad', '2024-05-01');
SET IDENTITY_INSERT Customers OFF;

SET IDENTITY_INSERT Products ON;
INSERT INTO Products (product_id, product_name, category, price, stock) VALUES
(1, 'Wireless Mouse', 'Electronics', 649.00, 150),
(2, 'USB-C Charger', 'Electronics', 799.00, 100),
(3, 'Water Bottle 1L', 'Home', 199.00, 300),
(4, 'Notebook A4', 'Stationery', 49.00, 500),
(5, 'Bluetooth Headset', 'Electronics', 1299.00, 80),
(6, 'Coffee Mug', 'Home', 249.00, 200),
(7, 'Desk Lamp', 'Home', 999.00, 60),
(8, 'T-shirt (M)', 'Apparel', 399.00, 120);
SET IDENTITY_INSERT Products OFF;

SET IDENTITY_INSERT Orders ON;
INSERT INTO Orders (order_id, customer_id, order_date) VALUES
(1, 1, '2024-07-01'),
(2, 2, '2024-07-02'),
(3, 1, '2024-07-04'),
(4, 4, '2024-07-05');
SET IDENTITY_INSERT Orders OFF;

SET IDENTITY_INSERT Order_Details ON;
INSERT INTO Order_Details (detail_id, order_id, product_id, quantity) VALUES
(1, 1, 1, 2),  -- Amit bought 2 Wireless Mouse
(2, 1, 4, 5),  -- Amit bought 5 Notebooks
(3, 2, 3, 3),  -- Sita bought 3 Water Bottles
(4, 3, 5, 1),  -- Amit bought 1 Headset
(5, 4, 7, 1);  -- Neha bought 1 Desk Lamp
SET IDENTITY_INSERT Order_Details OFF;

SET IDENTITY_INSERT Payment ON;
INSERT INTO Payment (payment_id, order_id, payment_mode, payment_status, amount) VALUES
(1, 1, 'Credit Card', 'Completed', 2*649.00 + 5*49.00),
(2, 2, 'UPI', 'Completed', 3*199.00),
(3, 3, 'COD', 'Pending', 1*1299.00),
(4, 4, 'Debit Card', 'Completed', 1*999.00);
SET IDENTITY_INSERT Payment OFF;

DBCC CHECKIDENT ('Customers', RESEED, 5);
DBCC CHECKIDENT ('Products', RESEED, 8);
DBCC CHECKIDENT ('Orders', RESEED, 4);
DBCC CHECKIDENT ('Order_Details', RESEED, 5);
DBCC CHECKIDENT ('Payment', RESEED, 4);

SELECT TOP 10 * FROM Customers;
SELECT TOP 10 * FROM Products;
SELECT o.order_id, c.name, o.order_date, p.amount FROM Orders o JOIN Customers c ON o.customer_id = c.customer_id
LEFT JOIN Payment p ON o.order_id = p.order_id;

-- Top Products by Revenue

create View View_Topproducts as 
select 
p.product_name,
sum(o.quantity*p.price) as Total_Revenue,
Count(Distinct o.order_id) as Total_Orders
from Order_Details o Inner join Products p on o.product_id=p.product_id
group by p.Product_Name
go

select * from View_Topproducts order by total_revenue Desc

-- Best Customers by spending 

create view View_Topcustomers as 
select 
c.name as Customer_name,
sum(p.amount) as Total_spent,
Count(o.order_id) as Total_Orders
from Customers c inner join Orders o on c.Customer_id=o.Customer_id
inner join Payment p on o.Order_Id=p.Order_Id
group by c.Name
go

select * from View_Topcustomers order by Total_spent desc

-- Monthly sales 

create View View_Monthly_Sales as
select 
FORMAT(o.order_date,'yyyy-MM') as month,
sum (p.amount) as  Monthly_Revenue
from Orders o inner join Payment p on o.Order_Id=p.Order_Id
group by format(o.Order_Date,'yyyy-MM')
go

select * from View_Monthly_Sales order by month


--Triggers
--Trigger for Auto-Stock Update

Create Trigger Trg_Update_stock
on Order_Details
after insert 
as
begin
update Products
set Stock=Stock-i.quantity
from Products p Inner join inserted i on p.Product_ID=i.Product_id
end
go

insert into Order_Details(Order_id,Product_id,Quantity) values (1,2,1)

select PRODUCT_id , product_name, stock from Products where Product_ID= 2

--monthly_sales_summary
Create procedure Monthly_Sales_Summary
as begin
select
FORMAT(o.order_date, 'yyyy-MM') AS Month,
SUM(p.amount) AS Total_Sales,
COUNT(DISTINCT o.order_id) AS Orders_Count
FROM Orders o
INNER JOIN Payment p ON o.order_id = p.order_id
 GROUP BY FORMAT(o.order_date, 'yyyy-MM')
 ORDER BY Month;
 End
 go

 EXEC monthly_sales_summary

 --Top 3 cities by revenvue

 Select top 3 c.city, sum(p.amount) as revenue from Customers c
 inner join orders o on c.Customer_id=o.Customer_id
 inner join Payment p on o.Order_Id=p.Order_Id
 group by c.City
 order by revenue desc 

 -- products on low stock 

 Select product_name, stock from Products where stock < 50

 --Average order value 

 select avg(amount) as  Avg_Order_Value from Payment

 -- Top products with Ranking 

 select p.product_name,
 sum(od.quantity*p.price) as revenue,
 Rank() over (order by sum(od.quantity*p.price)desc) as Rank_position
 from Order_Details od inner join Products p on od.Product_id=p.Product_ID
 group by p.product_name
