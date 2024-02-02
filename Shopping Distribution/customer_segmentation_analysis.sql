# DATA EXPLORATION
select * from customer;                                                   ##customer table	
select * from customer where invoice_no is null or customer_id is null
or gender is null or age is null or category is null or quantity is null
or price is null or payment_method is null or invoice_date is null 
or shopping_mall is null ;					  	                          #no null values in the dataset
SELECT customer_id, (customer_id) FROM customer group by customer_id;     ##customer_id is a primary key
SELECT invoice_no, (invoice_no) FROM customer group by invoice_no;        ##invoice_no is a primary key
select count(customer_id) from customer;		                          # there are 99457 rows/instances in the table
select distinct gender from customer;									  # two unique values
select age, count(age) from customer group by age;                        # age range of customer is 18-69
select distinct quantity from customer order by quantity;                  # quanity ranges from 1-5
select distinct payment_method from customer;								#three payment methods
select min(invoice_date), max(invoice_date) from customer;					# date of transactions in the dataset range fom 01-01-2021 to 31-12-2022
select count(distinct shopping_mall) from customer;								# there are 10 malls customers visit to buy 
select * from customer where price <=0;										#no price less than or equal to zero 
select min(price), max(price) from customer order by price;                 # when buying something, customers make a minimum payment of 5.23 rupees to 5250 rupees


#SHOPPING DISTRIBUTION ACCORDING TO GENDER
select shopping_mall, category, sum(case when gender='Male' then 1 else 0 end) as Male, 
sum(case when gender='Female'then 1 else 0 end) as Female,
case 
when gender='Male' then sum(price*quantity) else 0 end as Male_revenue,
case 
when gender='Female' then sum(price*quantity) else 0 end as Female_revenue
from customer group by gender, shopping_mall, category;

select shopping_mall,category,gender,count(gender) as genderCount, sum(price*quantity) as revenue
from customer group by shopping_mall,category, gender;    #alternative

select gender,shopping_mall, category, count(gender) as Gender_count,
sum(price*quantity) as revenue from customer group by gender, shopping_mall, category;   #alternate

#which gender did we sell more products to? revenue?
select gender,totalRevenue from (select gender, sum(quantity) as totalQuantity, 
sum(price*quantity) as totalRevenue from customer group by gender order by totalRevenue Desc) as genderrevenue 
limit 1;


#distribution of purchase categories relative to other columns
select category as purchaseCategory, shopping_mall,sum(case when gender='Male' then 1 else 0 end) as Male,
sum(case when gender='Female' then 1 else 0 end) as Female, sum(quantity) as TotalQuantity, sum(price*quantity) as TotalRevenue,
sum(case when payment_method='Cash' then 1 else 0 end) as Cash,
sum(case when payment_method='Credit Card' then 1 else 0 end) as Credit_Card,
sum(case when payment_method='Debit Card' then 1 else 0 end) as Debit_Card
from customer group by category, shopping_mall;

select category as purchaseCategory,sum(case when gender='Male' then 1 else 0 end) as Male,
sum(case when gender='Female' then 1 else 0 end) as Female, sum(quantity) as TotalQuantity, sum(price*quantity) as TotalRevenue,
sum(case when payment_method='Cash' then 1 else 0 end) as Cash,
sum(case when payment_method='Credit Card' then 1 else 0 end) as Credit_Card,
sum(case when payment_method='Debit Card' then 1 else 0 end) as Debit_Card, 
sum(case when shopping_mall='Cevahir AVM' then 1 else 0 end) as Cevahir_AVM,
sum(case when shopping_mall='Emaar Square Mall' then 1 else 0 end) as Emaar_Square_Mall,
sum(case when shopping_mall='Forum Istanbul' then 1 else 0 end) as Forum_Istanbul,
sum(case when shopping_mall='Istinye Park' then 1 else 0 end) as Istinye_Park,
sum(case when shopping_mall='Kanyon' then 1 else 0 end) as Kanyon,
sum(case when shopping_mall='Mall of Istanbul' then 1 else 0 end) as Mall_of_Istanbul,
sum(case when shopping_mall='Metrocity' then 1 else 0 end) as Metrocity,
sum(case when shopping_mall='Metropol AVM' then 1 else 0 end) as Metropol_AVM,
sum(case when shopping_mall='Viaport Outlet' then 1 else 0 end) as Viaport_Outlet,
sum(case when shopping_mall='Zorlu Center' then 1 else 0 end) as Zorlu_Center
from customer group by category;                         #ALTERNATIVE

#SHOPPING DISTRIBUTION ACCORDING TO AGE
select age,shopping_mall,category,gender, sum(price*quantity) as revenue from customer group by age,shopping_mall,category,gender;

#MARKETING DEMOGRAPHIC AGE BRACKETS ARE USUALLY 18-24, 25-34, 35-44, 45-54, 55-64, 65 AND ABOVE  (DEMOGRAPHIC SEGMENTATION BY AGE)

select age,
(case
when age>=18 and age<25 then '18-24'
when age>=25 and age<35 then '25-34'
when age>=35 and age<45 then '35-44'
when age>=45 and age<55 then '45-54'
when age>=55 and age<65 then '55-64'
when age>=65 then '65 and above'
end) as age_category from customer;

#which age category we sold most products to?
select (case
when age>=18 and age<25 then '18-24'
when age>=25 and age<35 then '25-34'
when age>=35 and age<45 then '35-44'
when age>=45 and age<55 then '45-54'
when age>=55 and age<65 then '55-64'
when age>=65 then '65 and above'
end) as age_category, sum(quantity) as total_products from customer group by age_category order by total_products desc;

#which age category generated the most revenue?
select (case
when age>=18 and age<25 then '18-24'
when age>=25 and age<35 then '25-34'
when age>=35 and age<45 then '35-44'
when age>=45 and age<55 then '45-54'
when age>=55 and age<65 then '55-64'
when age>=65 then '65 and above'
end) as age_category, sum(quantity*price) as total_revenue from customer group by age_category order by total_revenue desc;

#distribution of product categories relative to other columns
select category,shopping_mall, gender,
(case
when age>=18 and age<25 then '18-24'
when age>=25 and age<35 then '25-34'
when age>=35 and age<45 then '35-44'
when age>=45 and age<55 then '45-54'
when age>=55 and age<65 then '55-64'
when age>=65 then '65 and above'
end) as age_category from customer group by category, shopping_mall,gender, age_category; 

