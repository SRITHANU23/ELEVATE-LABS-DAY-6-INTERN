select *from new_schema.salesdata; 

-- Sales Trend Analysis: Monthly Revenue & Order Volume

SELECT
    EXTRACT(YEAR FROM STR_TO_DATE(Date, '%d-%m-%Y')) AS order_year,
    EXTRACT(MONTH FROM STR_TO_DATE(Date, '%d-%m-%Y')) AS order_month,
    SUM(`Total Revenue`) AS monthly_revenue,
    COUNT(DISTINCT `Transaction ID`) AS monthly_orders,
    SUM(SUM(`Total Revenue`)) OVER (ORDER BY 
        EXTRACT(YEAR FROM STR_TO_DATE(Date, '%d-%m-%Y')), 
        EXTRACT(MONTH FROM STR_TO_DATE(Date, '%d-%m-%Y'))
    ) AS cumulative_revenue,
    SUM(COUNT(DISTINCT `Transaction ID`)) OVER (ORDER BY 
        EXTRACT(YEAR FROM STR_TO_DATE(Date, '%d-%m-%Y')), 
        EXTRACT(MONTH FROM STR_TO_DATE(Date, '%d-%m-%Y'))
    ) AS cumulative_orders
FROM salesdata
GROUP BY order_year, order_month
ORDER BY order_year, order_month;


