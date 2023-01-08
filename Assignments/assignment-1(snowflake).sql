use kpr_warehouse;

use database kpr_database;

----- Create table and load in database -------
  
create or replace table kpr_sales_data(
      order_id varchar(30) primary key
     ,order_date date 
     ,ship_date date
     ,ship_mode varchar(50)
     ,customer_name varchar(50)
     ,segment varchar(50)
     ,state varchar(50)
     ,country varchar(50)
     ,market varchar(50)
     ,region varchar(50)
     ,product_id varchar(80)
     ,category varchar(50)
     ,sub_category varchar(50)
     ,product_name varchar(200)
     ,sales int
     ,quantity int
     ,discount float
     ,profit float
     ,shipping_cost float
     ,order_priority varchar(40)
     ,year int);


select * from kpr_sales_data;

---Load the given dataset into snowflake with a primary key to Order Date column---

alter table kpr_sales_data
drop primary key;

--Change the Primary key to Order Id Column---
ALTER TABLE kpr_sales_data
add PRIMARY KEY(ORDER_ID);

select * from kpr_sales_data;


--Check the data type for Order date and Ship date and mention in what data type it should be--

SELECT * FROM kpr_sales_data
ORDER BY ORDER_DATE, SHIP_DATE;

--Create a new column called order_extract and extract the number after the last ‘–‘from Order ID column.

ALTER TABLE kpr_SALES_DATA
ADD COLUMN ORDER_EXTRACT varchar(15);

UPDATE kpr_SALES_DATA
SET Order_extract = SUBSTR(ORDER_ID ,9, 10);


SELECT ORDER_ID, order_extract FROM kpr_SALES_DATA;

ALTER TABLE kpr_SALES_DATA
ADD COLUMN DISCOUNT_1 varchar(30);

 
--Create a new column called Discount Flag and categorize it based on discount.
--Use ‘Yes’ if the discount is greater than zero else ‘No’.

select * case when discount > '0' then 'YES'
 else 'FALSE'
    end as if_discounted
    from kpr_sales_data;


---Create a new column called process days and calculate how many days it takes
--for each order id to process from the order to its shipment.


select datediff(day, SHIP_DATE,ORDER_DATE) FROM kpr_SALES_DATA;

---Create a new column called Rating and then based on the Process dates give
--rating like given below.
--a. If process days less than or equal to 3days then rating should be 5
--b. If process days are greater than 3 and less than or equal to 6 then rating
--should be 4
--c. If process days are greater than 6 and less than or equal to 10 then rating
--should be 3
--d. If process days are greater than 10 then the rating should be 2.

SELECT *,
    CASE when (DISCOUNT) > '0' then 'yes'
    else 'FALSE'
    end as DSCOUNTED_value
    from kpr_sales_data;