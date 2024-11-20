/* Pizza Sales Full Data */
SELECT *
FROM pizza_sales$

/* Total Revenue */
SELECT SUM(total_price) AS total_revenue
FROM pizza_sales$

/* Average Order Value */
SELECT (SUM(total_price) / COUNT (DISTINCT order_id)) AS averag_order_value
FROM pizza_sales$

/* Total Pizzas Sold */
SELECT SUM(quantity) AS total_pizzas_sold
FROM pizza_sales$

/* Total Orders */
SELECT COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales$

/* Average Pizzas Per Order */
SELECT CAST(CAST(SUM (quantity)AS decimal (10,2)) / 
CAST(COUNT (DISTINCT order_id) AS decimal (10,2)) AS decimal (10,2))
AS average_pizzas_per_order
FROM pizza_sales$




/* Queries for Dashboard Charts */

/* Hourly Trend for Total Pizzas Sold */
SELECT DATEPART(HOUR, order_time) AS hour_time,
SUM(quantity) AS total_pizzas
FROM pizza_sales$
GROUP BY DATEPART(HOUR, order_time)
ORDER BY DATEPART(HOUR, order_time)


/* Weekly Trend for Total Orders */
SELECT DATEPART(ISO_WEEK, order_date) AS week_number,
YEAR(order_date) AS year,
COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales$
GROUP BY DATEPART(ISO_WEEK, order_date), YEAR(order_date)
ORDER BY YEAR(order_date) ASC, total_orders DESC


/* Percentage of sales by Pizza Category*/
SELECT pizza_category, CAST(SUM(total_price) AS decimal (10,2)) AS category_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales$) AS decimal (10,2))
AS percentage
FROM pizza_sales$
GROUP BY pizza_category

/* Percentage of sales by Pizza Size */
SELECT pizza_size, CAST(SUM(total_price) AS decimal (10,2)) AS size_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales$) AS decimal (10,2))
AS percentage
FROM pizza_sales$
GROUP BY pizza_size
ORDER BY pizza_size

/* Total Pizzas Sold by Pizza Category */
SELECT pizza_category, SUM(quantity) AS total_pizzas
FROM pizza_sales$
GROUP BY pizza_category
ORDER BY total_pizzas


/* Top 5 Best Sellers by Revenue */
SELECT TOP 5 pizza_name, SUM(total_price) total_revenue
FROM pizza_sales$
GROUP BY pizza_name
ORDER BY total_revenue DESC

/* Bottom 5 Sellers by Revenue */
SELECT TOP 5 pizza_name, SUM(total_price) total_revenue
FROM pizza_sales$
GROUP BY pizza_name
ORDER BY total_revenue ASC


/* Top 5 Best Sellers by Total Quantity */
SELECT TOP 5 pizza_name, SUM(quantity) total_quantity
FROM pizza_sales$
GROUP BY pizza_name
ORDER BY total_quantity DESC

/* Bottom 5 Sellers by Total Quantity */
SELECT TOP 5 pizza_name, SUM(quantity) total_quantity
FROM pizza_sales$
GROUP BY pizza_name
ORDER BY total_quantity ASC


/* Top 5 Best Sellers by Total Orders */
SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) total_orders
FROM pizza_sales$
GROUP BY pizza_name
ORDER BY total_orders DESC


/* Bottom 5 Sellers by Total Orders */
SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) total_orders
FROM pizza_sales$
GROUP BY pizza_name
ORDER BY total_orders ASC