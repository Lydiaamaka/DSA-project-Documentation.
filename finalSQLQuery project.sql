select * from dbo.kmscasestudy

-------case scenerIO1
----4. Advice the management of kms on what to do to increase their Revenuefrom the bottom 10 customers-----/
---5 KMS incurred the most cost ing which shipping method?
---- case scenerio 11.
---6 who was the most vauable customer s and what product or services do they typically purchase?
-- 7 which small businness customers had the highest  sales?
---8 which coeporate customer placed the most order s in 2009 - 2012?
---9 which consumer customer was the most peofitable one?
----WHERE [Returned] 
---- top 3 highest paid employee 
----case scenerio1--

----1.which product in category had the highest sales?
---answer:Technology	5984248.17547321

select top 1 Product_Category,  SUM(Sales)AS totalsales
from dbo.kmscasestudy
group  by Product_Category 
order by totalsales desc


----2.what are  the top 3 and botom 3 regions in terms ot sales?
----top 3 regionsare:
--West	3597549.269871
--Ontario	3063212.47638369
--Prarie	2837304.60503292
 --top3 bottom are :
 -------Nunavut	116376.48383522
--------Northwest Territories	800847.330903053
--------Yukon	975867.375723362

select top 3  Region,   SUM(Sales ) As totalsales
from dbo.kmscasestudy
group by Region
order by totalsales desc


select top 3 region,   SUM(Sales) As totalsales
from dbo.kmscasestudy
group by Region
order by totalsales asc



select*from dbo.kmscasestudy

----3.what were the total sales of appliance in Ontario?
---Answer:202346.83963017

select SUM(sales) As TotalsaleapplianceSales_Ontario 
from dbo.kmscasestudy 
where Province='Ontario' 
AND Product_Sub_Category='appliances'

----4. Advice the management of kms on what to do to increase their Revenuefrom the bottom 10 customers-----/

---answer:To increase revenue from the bottom 10 customers the folllowing should be done
----1.The management should target bottom 10 customers with good discount.
----2.they should offer exclusive membership with mouth watering benefits.
---	3.they should follow up these customer with reminders and recommendations through emails and calls.
----4.They shoould review their delivery method to ensure the right method is appriopriated to the customers for continues patronage.
----
select top 10 [Customer_Name], sum([Sales])
As totalsales
from dbo.kmscasestudy 
group by Customer_Name
Order by totalsales asc

---answer:
--Customer_Name     Totalsales
--1.Jeremy Farry	85.7200021743774
--2.Natalie DeCherney	125.900001525879
--3.Nicole Fjeld	153.030006408691
--4.Katrina Edelman	180.760005950928
--5.Dorothy Dickinson	198.080001831055
--6.Christine Kargatis	293.2200050354
--7.Eric Murdock	343.32799911499
--8.Chris McAfee	350.180004119873
--9.Rick Huthwaite	415.819980621338
--10.Mark Hamilton	450.990005493164



---5 KMS incurred the most cost using which shipping method? 
---ANSWER:delivery truck:51971.9397373199.
select top 1 Ship_Mode,   SUM(Shipping_Cost) As totalshippingcost
from dbo.kmscasestudy
group by ship_mode
order by totalshippingcost desc

---6 who are the most vauable customers and what product or services do they typically purchase?

select  top 5 Customer_Name,Product_name,  SUM(sales) As totalsales
from dbo.kmscasestudy
group by customer_name,product_name
order by totalsales desc


select  top 5 Customer_Name, product_category,
count(*)As purchaseCount 
from dbo.kmscasestudy
where customer_Name IN ( select[Customer_Name]
from dbo.kmscasestudy
group by Customer_Name
order by  SUM(sales) desc 
) group By Customer_Name, Product_Category
order by customer_name, purchaseCount
desc
 


--7 which small business customer had the highest sales?
--Answer:Jeremy Farry	85.7200021743774

select top 1 Customer_Name ,  SUM(sales) As totalsales from dbo.kmscasestudy
where Customer_Segment ='small Business'
Group by Customer_Name
order by totalsales

---8 which coeporate customer placed the most order s in 2009 - 2012?
--ANSWER:Adam Hart	:20

select top 1 customer_name , COUNT(Order_ID) As OrderCount from dbo.kmscasestudy
where Customer_Segment= 'corporate' AND   CAST([Order_Date] As Date)
Between '2009-01-01' And '2012-01-31'
group by Customer_Name
order by OrderCount desc

---9 which consumer customer was the most peofitable one?

Select top 1 Customer_Name, SUM (profit) As totalprofit 
from dbo.kmscasestudy
WHERE Customer_Segment= 'Consumer'
Group by Customer_Name
order by totalprofit desc

---ANSWER:-Emily ---34005.4392166138 total profit

---join table order status to kmscasestudy



	SElECT Customer_Name, Customer_Segment,[Status] from  [dbo].[Order_Status] 
	join [dbo].[kmscasestudy]on [dbo].[Order_status].[Order_ID]=[dbo].[kmscasestudy].[Order_ID]

	--10 which customer returned items,and what segment do they belong to?
	
	select Customer_Name,Customer_Segment
	from dbo.kmscasestudy WHERE [Status]='Returned'
	group by customer_name,customer_Segment

	select top 10 customer_name,customer_segment from [dbo].[kmscasestudy]
	where[Status] ='returned'
	group by customer_name,customer_segment
	
	select*from kmscasestudy

----11.  if the delivery truck is the most economical but the slowest shipping method and express air is the fastest
---but the most expensive one, do you think the company appriopriately spent shipping costs based on the order
--priority Explain your answer.---


 SELECT [Order_Priority], Ship_Mode,
 COUNT([Order_ID]) AS [OrderCount], ROUND(Sum (sales-profit),2) AS [estimated shipping cost],
 AVG(DATEDIFF(DAY,[Order_Date],[Ship_Date]))
 AS[Avg Ship DAYS] From [kmscasestudy]
 group by [Order_Priority],[Ship_Mode]
 Order by Order_Priority,Ship_Mode desc

 Answer--no kms did not  allocate shipping cost appropriatly based on order priority.
 --they relied too much on delivery trucks, which could be the reason for many bottom customers.
 --delivery truck which is more apprioprate for heavybor non-urgent shipments, and underutilized 
 --express air,which is designed for high_ priority or urgent orders.
 --This mismatch between shipping method, delivery speed and order urgentcy resulted in inefficient
 --spending and unnecessary costs.
 ---since delivery truck incurred the most cost,it means they used it more  orders
 
   

 















    

