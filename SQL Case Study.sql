------SQL Case Study 1------

Create database administrator

Select *from Location
Select *from Product
Select *from Fact

---Tasks to be performed---
---1. Display the number of states present in the LocationTable.--- 

Select Count(Distinct State) from Location

---2. How many products are of regular type?---

Select Count(Product_Type)from Product Where Type='Regular'

---3. How much spending has been done on marketing of product ID 1?---
 
 Select Sum(Marketing)from Fact Where ProductId= 1

---4. What is the minimum sales of a product?---

Select Product,Sales from Fact F
Join Product P
On F.ProductId=P.ProductId
Where Sales=
(
Select MIN(sales) from Fact
)

Select Product,Sales from Fact F
Join Product P
On F.ProductId=P.ProductId
Where Sales=17

---5. Display the max Cost of Good Sold (COGS).---

Select *from Fact
Where COGS=
(
Select MAX(COGS) from Fact
)

---6. Display the details of the product where product type is coffee.---

Select *from Product
Where Product_Type= 'Coffee'

---7. Display the details where total expenses are greater than 40.--- 

Select *from Fact
Where Total_Expenses >40

---8. What is the average sales in area code 719?---

Select AVG(Sales) from Fact
Where Area_Code=719

---9. Find out the total profit generated by Colorado State---

Select SUM(Profit) from Fact F 
Join Location L
On F.Area_Code=L.Area_Code
Where State= 'Colorado'

---10. Display the average inventory for each product ID.---

Select ProductId,AVG(Inventory) avg_inventory from fact
Group by ProductId
order by ProductId

---11. Display state in a sequential order in a Location Table.---

Select distinct State from Location
Order By State Desc

---12. Display the average budget of the Product where the average budget margin should be greater than 100.---

Select P.Product,AVG(budget_margin) from Fact F
join Product P
on F.ProductId=P.ProductId
group by Product
having AVG(Budget_Margin)>100

---13. What is the total sales done on date 2010-01-01?---

Select Sum(Sales) from fact
where date='2010/01/01'

---14. Display the average total expense of each product ID on an individual date.--- 

Select Date,ProductId,AVG(Total_Expenses) from fact
group by Date,ProductId
order by Date,ProductId

---15. Display the table with the following attributes such as date, productID, product_type, product, sales, profit, state, area_code.---

Select date, F.productID, product_type, product, sales, profit, state, L.Area_Code
from Fact F
join
Product P
on F.ProductId=P.ProductId
join Location L
on F.Area_Code=L.Area_Code

---16. Display the rank without any gap to show the sales wise rank.--- 

Select Sales,DENSE_RANK() over(order by sales desc) as Rank from fact

---17. Find the state wise profit and sales.---

Select State,Sum(Profit)Profit,Sum(Sales)Sales from Fact F
join Location L
on F.Area_Code=L.Area_Code
group by State

---18. Find the state wise profit and sales along with the productname.--- 

Select State,Product,Sum(Profit)Profit,Sum(Sales)Sales from Fact F
join Location L
on F.Area_Code=L.Area_Code
join Product P
on F.ProductId=P.ProductId
group by State,Product
order by State,Product

---19. If there is an increase in sales of 5%, calculate the increasedsales.---

Select Sales,(Sales*0.05)five_per,(Sales+(Sales*0.05))increasedsales from fact
-----------
Select Sales,(Sales*1.05) from fact

---20. Find the maximum profit along with the product ID and producttype---

Select P.ProductId,P.Product_Type,Profit from fact F
join Product P
on F.ProductId=P.ProductId
where Profit=
(
Select MAx(Profit) from fact
)

---21. Create a stored procedure to fetch the result according to the product typefrom Product Table.---

Create or alter procedure sp_product @val varchar(20)
as
begin
Select * from Product 
where Product_Type= @val 
end

exec sp_product @val='tea'
exec sp_product @val='coffee'

---22. Write a query by creating a condition in which if the total expenses is lessthan60 then it is a profit or else loss.---

Select Total_Expenses,IIF
(Total_Expenses>60,'Profit','Loss')
from fact

---23. Give the total weekly sales value with the date and product IDdetails. Useroll-up to pull the data in hierarchical order.--- 

Select DATEPART(WEEK,Date)Week,Productid,Sum(Sales)total_sales
from fact 
group by DATEPART(WEEK,Date),Productid
with rollup

---24. Apply union and intersection operator on the tables which consist of attribute area code.--- 

Select Area_Code from fact
union
Select area_code from Location

Select Area_Code from fact
intersect
Select area_code from Location

---25. Create a user-defined function for the product table to fetch a particular product type based upon the user�s preference.--- 

Create function fn_product(@value varchar(20))
returns table
as
return
	select * from Product where Product_Type=@value

Select * from dbo.fn_product('Tea')

---26. Change the product type from coffee to tea where product IDis 1 andundoit.---

Select * from Product

begin transaction
update Product set Product_Type='Tea' where ProductId=1

rollback transaction

---27. Display the date, product ID and sales where total expenses are between 100 to 200.---

Select Date,ProductId,Sales
from fact
where Total_Expenses between 100 and 200
order by date, ProductId

---28. Delete the records in the Product Table for regular type. ---

Select * from Product

delete from Product
where type='Regular'

---29. Display the ASCII value of the fifth character from the columnProduct---

Select * from Product

Select Product, SUBSTRING(Product,5,1)fifth_char,
ASCII(SUBSTRING(Product,5,1)) Ascii_value
from Product