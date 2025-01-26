SELECT * FROM Coffee_Shop_Sales.coffee_shop_sales;
describe Coffee_Shop_Sales.coffee_shop_sales;
/*Data cleaning*/
/* 1- set date data _Types*/
SELECT * FROM Coffee_Shop_Sales.coffee_shop_sales;
 UPDATE Coffee_Shop_Sales.coffee_shop_sales
SET transaction_date = STR_TO_DATE(transaction_date, '%Y-%m-%d'); -- Adjust the format here as needed
  Alter table Coffee_Shop_Sales.coffee_shop_sales
 modify column transaction_date date;
 /* 2 - set time data _Types*/
  UPDATE Coffee_Shop_Sales.coffee_shop_sales
  set transaction_time=time_format(str_to_date(transaction_time,'%H:%i:%s'),'%H:%i:%s');
  Alter table Coffee_Shop_Sales.coffee_shop_sales
 modify column transaction_time time;
  /* 3 - set text to int data _Types*/
  select unit_price 
  from Coffee_Shop_Sales.coffee_shop_sales
  where unit_price not  REGEXP '^-?[0-9]+(\.[0-9]+)?$'; 
  
  update Coffee_Shop_Sales.coffee_shop_sales
  set unit_price=null
  where unit_price not REGEXP '^-?[0-9]+(\.[0-9]+)?$';
  
  update Coffee_Shop_Sales.coffee_shop_sales 
  set unit_price=replace(unit_price,',' ,'');
  update Coffee_Shop_Sales.coffee_shop_sales 
  set unit_price=Trim(unit_price);
  Alter table Coffee_Shop_Sales.coffee_shop_sales
  modify column unit_price double;
  /*KPIs Requirements   Total Sales Analysis*/

  /*1.1- caculate the total sales for each respective month */
  SELECT sum(unit_price*transaction_qty) as Total_sales,month(transaction_date) as month
  FROM Coffee_Shop_Sales.coffee_shop_sales
  group by  month(transaction_date);

  /*1.2 Determine the month-on-month increase or decrease in sales */
  select month(transaction_date) as month, sum(unit_price*transaction_qty) as Tottal_sales,
  round((sum(unit_price*transaction_qty)-lag(sum(unit_price*transaction_qty),1)over (order by month(transaction_date)))/lag(sum(unit_price*transaction_qty),1)over (order by month(transaction_date))* 100 ,2)as MOM_increase
  from Coffee_Shop_Sales.coffee_shop_sales
  group by month(transaction_date)
  order by month(transaction_date);

  /*1.3 Calculate the difference in sales between the selected month and previous month*/
   select month(transaction_date) as month, sum(unit_price*transaction_qty)as total_sales,
  (sum(unit_price*transaction_qty)-lag(sum(unit_price*transaction_qty),1)over (order by month(transaction_date)) ) /lag(sum(unit_price*transaction_qty),1)over (order by month(transaction_date))*100 as MOM_Per
  from Coffee_Shop_Sales.coffee_shop_sales
   where month(transaction_date) in (4,5)
  group by  month(transaction_date)
  order by  month(transaction_date);
 
 /* 2.1 caculate the total no of  orders for each respective month*/
 select month(transaction_date)as month,count(transaction_id)as Total_orders
 from coffee_Shop_Sales.coffee_shop_sales
 group by month(transaction_date);

/*2.2 Determine the month-on-month increase or decrease in NO.of orders */
select month(transaction_date) as month,count(transaction_id)as total_sales,
round((count(transaction_id)- lag(count(transaction_id),1)over (order by month(transaction_date)))/lag(count(transaction_id),1)over (order by month(transaction_date))*100 ,2)as diff_sales
from Coffee_Shop_Sales.coffee_shop_sales
group by month(transaction_date) 
order by month(transaction_date) ;

 /*2.3 Calculate the difference in No. of orders between the selected month and previous month*/
select month(transaction_date) as month,count(transaction_id)as total_sales,
round((count(transaction_id)- lag(count(transaction_id),1)over (order by month(transaction_date)))/lag(count(transaction_id),1)over (order by month(transaction_date))*100 ,2)as diff_sales
from Coffee_Shop_Sales.coffee_shop_sales
where month(transaction_date) in (4,5)
group by month(transaction_date) 
order by month(transaction_date);

/* 3.1 caculate the total nqauntity sold for each respective month*/
select sum(transaction_qty)as Total_qty
from Coffee_Shop_Sales.coffee_shop_sales
group by month(transaction_date);

/*3.2 Determine the month-on-month increase or decrease in total quantity sold */
select month(transaction_date) as month,sum(transaction_qty)as Total_qty,
(sum(transaction_qty)-lag(sum(transaction_qty),1)
over(order by month(transaction_date)))/lag(sum(transaction_qty),1)
over(order by month(transaction_date))*100 as diff
from Coffee_Shop_Sales.coffee_shop_sales
group by month(transaction_date) 
order by month(transaction_date);

/*3.3 Calculate the difference in the total quantity sold between the selected month and previous month*/
select month(transaction_date) as month,sum(transaction_qty)as Total_qty,
(sum(transaction_qty)-lag(sum(transaction_qty),1)
over(order by month(transaction_date)))/lag(sum(transaction_qty),1)
over(order by month(transaction_date))*100 as diff
from Coffee_Shop_Sales.coffee_shop_sales
where month(transaction_date) in (4,5)
group by month(transaction_date) 
order by month(transaction_date);
 
 
 
 /*Charts Requirements*/
 /*CALENDAR TABLE – DAILY SALES, QUANTITY and TOTAL ORDERS*/
 select concat(round(sum(unit_price * transaction_qty)/1000,1),'K')AS total_sales, 
 sum(transaction_qty) as Daily_Quantity,
 count(transaction_id) as Total_orders
 from Coffee_Shop_Sales.coffee_shop_sales
 where transaction_date='2023-05-18';
 
/*SALES TREND OVER PERIOD*/
SELECT
    CASE 
        WHEN DAYOFWEEK(transaction_date) IN (1, 7) THEN 'weekend' 
        ELSE 'weekday' 
    END AS day_of_week,
   concat(round(sum(unit_price * transaction_qty)/10000,1),'K') AS weekly_sales
FROM 
    Coffee_Shop_Sales.coffee_shop_sales
WHERE 
    MONTH(transaction_date) = 2
GROUP BY 
    CASE 
        WHEN DAYOFWEEK(transaction_date) IN (1, 7) THEN 'weekend' 
        ELSE 'weekday' 
    END;
/*Sales by store location*/
select store_location,
concat(round(sum(unit_price*transaction_qty)/100000,2),'K')as total_sales
from Coffee_Shop_Sales.coffee_shop_sales
where month(transaction_date)=5
group by store_location;


 /*average sales*/
 SELECT AVG(total_sales) AS Average_sales
FROM (
    SELECT
        SUM(unit_price * transaction_qty)  AS total_sales
    FROM Coffee_Shop_Sales.Coffee_Shop_Sales
    WHERE MONTH(transaction_date) = 5
    GROUP BY transaction_date
) AS internal_query;

/*daily sales*/ 
 SELECT day(transaction_date),
        SUM(unit_price * transaction_qty)  AS total_sales
    FROM Coffee_Shop_Sales.Coffee_Shop_Sales
    WHERE MONTH(transaction_date) = 5
    GROUP BY day(transaction_date);
    
    
/*COMPARING DAILY SALES WITH AVERAGE SALES – IF GREATER THAN “ABOVE AVERAGE” and LESSER THAN “BELOW AVERAGE”*/
SELECT 
    day_of_month,
    CASE 
        WHEN total_sales > avg_sales THEN 'Above Average'
        WHEN total_sales < avg_sales THEN 'Below Average'
        ELSE 'Average'
    END AS sales_status,
    total_sales
from(
    SELECT 
        DAY(transaction_date) AS day_of_month,
        SUM(unit_price * transaction_qty) AS total_sales,
        AVG(SUM(unit_price * transaction_qty)) OVER () AS avg_sales
    FROM 
        coffee_shop_sales.Coffee_Shop_Sales
    WHERE 
        MONTH(transaction_date) = 5  -- Filter for May
    GROUP BY 
        DAY(transaction_date)

   ) as Sales_data
   order by day_of_month;
   
    /*Sales by Product category*/
    select product_category,
    sum(unit_price*transaction_qty)as total_sales
    from Coffee_Shop_Sales.coffee_shop_sales
    group by product_category;
    /*Sales by Product category top 10 */ 
    SELECT 
	product_type,
	ROUND(SUM(unit_price * transaction_qty),1) as Total_Sales
FROM coffee_shop_sales.Coffee_Shop_Sales
WHERE
	MONTH(transaction_date) = 5 and product_category='coffee'
GROUP BY product_type
ORDER BY SUM(unit_price * transaction_qty) DESC
LIMIT 10;
    /*Sales by day/hour*/ 
    
    SELECT 
    ROUND(SUM(unit_price * transaction_qty)) AS Total_Sales,
    SUM(transaction_qty) AS Total_Quantity,
    COUNT(*) AS Total_Orders
FROM 
    coffee_shop_sales.coffee_shop_sales
WHERE 
    DAYOFWEEK(transaction_date) = 3 -- Filter for Tuesday (1 is Sunday, 2 is Monday, ..., 7 is Saturday)
    AND HOUR(transaction_time) = 8 -- Filter for hour number 8
    AND MONTH(transaction_date) = 5; -- Filter for May (month number 5);
    /*sales by dAY*/
    SELECT 
    CASE 
        WHEN DAYOFWEEK(transaction_date) = 2 THEN 'Monday'
        WHEN DAYOFWEEK(transaction_date) = 3 THEN 'Tuesday'
        WHEN DAYOFWEEK(transaction_date) = 4 THEN 'Wednesday'
        WHEN DAYOFWEEK(transaction_date) = 5 THEN 'Thursday'
        WHEN DAYOFWEEK(transaction_date) = 6 THEN 'Friday'
        WHEN DAYOFWEEK(transaction_date) = 7 THEN 'Saturday'
        ELSE 'Sunday'
    END AS Day_of_Week,
    ROUND(SUM(unit_price * transaction_qty)) AS Total_Sales
FROM 
    coffee_shop_sales.Coffee_Shop_Sales
WHERE 
    MONTH(transaction_date) = 5 -- Filter for May (month number 5)
    group by day_of_week;
    
    
     /*sales by hour*/
     
     select hour(transaction_time) as hour_of_day,
     ROUND(SUM(unit_price * transaction_qty)) AS Total_Sales
FROM 
    coffee_shop_sales.Coffee_Shop_Sales
WHERE 
    MONTH(transaction_date) = 5 -- Filter for May (month number 5)
    group by hour_of_day;
     

