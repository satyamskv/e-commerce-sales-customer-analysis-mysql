# E-Commerce Sales and Customer Analysis Using MySQL

## Project Overview

This project uses MySQL to analyse a fictional e-commerce company's customer, product, order, and order-detail data. The SQL workbook contains 24 business questions and follow-up interpretations covering customer behaviour, product performance, monthly sales trends, and purchasing patterns.

The goal is to demonstrate how SQL can be used to investigate business questions and turn transactional data into insights that inform marketing, sales, and operational planning.

## Objectives

- Analyse customer locations and order frequency.
- Compare product revenue, purchase quantities, and customer reach by category.
- Examine monthly sales revenue, month-on-month changes, and average order value.
- Identify frequently purchased products and products with lower customer reach.
- Review monthly first purchases and periods with higher recorded sales revenue.

## Dataset

The project uses four CSV files containing **827 rows in total**.

| File / Table | Rows | Main columns | Purpose |
|---|---:|---|---|
| `Customers.csv` / `customers` | 100 | `customer_id`, `name`, `location` | Customer details and locations |
| `Products.csv` / `products` | 8 | `product_id`, `name`, `category`, `price` | Product catalogue and listed prices |
| `Orders.csv` / `orders` | 200 | `order_id`, `order_date`, `customer_id`, `total_amount` | Order dates, customers, and recorded order totals |
| `Orderdetails.csv` / `orderdetails` | 519 | `order_id`, `product_id`, `quantity`, `price_per_unit` | Products and quantities in order lines |

The recorded order dates range from **March 2023 to February 2024**.

### Table Relationships

The tables can be connected through these keys:

- `customers.customer_id` → `orders.customer_id`
- `orders.order_id` → `orderdetails.order_id`
- `products.product_id` → `orderdetails.product_id`

These relationships support customer, order, and product analysis using SQL joins.

## Analysis Scope: 24 Business Questions

The workbook includes questions and result interpretations across five areas:

1. **Customer analysis:** Table structure, top customer locations, order-frequency distribution, and customer purchasing patterns.
2. **Product and category analysis:** Average purchase quantity, product revenue, and unique customers by category.
3. **Sales trends:** Monthly revenue changes, the largest revenue decline, and changes in average order value.
4. **Product demand and customer reach:** Frequently appearing products in order details and products purchased by fewer than 40% of customers.
5. **Customer acquisition and peak periods:** Monthly first recorded purchases and the months with the highest recorded sales revenue.

Each question is documented in the SQL file. Follow-up questions that ask for interpretation use the preceding query's result rather than duplicating the same SQL calculation.

## Key Findings Recorded in the Workbook

- **Customer locations:** Delhi, Chennai, and Jaipur are identified as the top locations for customer-focused marketing review.
- **Order frequency:** The customer count decreases as the number of orders per customer increases; the workbook describes the most common group as occasional shoppers.
- **Product performance:** Product 1 is identified as the highest-revenue product among products with an average purchase quantity of two.
- **Category reach:** Electronics is identified as the category purchased by the greatest number of unique customers.
- **Monthly sales:** February 2024 is identified as the month with the largest month-on-month revenue decline. The March-to-August pattern is described as fluctuating without a clear trend.
- **Average order value:** December is identified as the month with the highest change in average order value.
- **Product purchase frequency:** Product ID 7 is identified as appearing most frequently in order details.
- **Customer acquisition:** Monthly first-purchase counts are interpreted as showing a downward trend. These counts alone do not prove whether a particular marketing campaign was effective.
- **Operational review:** September and December are flagged in the workbook as months to investigate for potential staffing and replenishment planning. Confirm such decisions against the complete monthly sales output and other operational data.

These are the qualitative findings recorded in the workbook. Add supporting values from the query outputs where useful, and treat possible explanations—such as low product visibility—as hypotheses rather than proven causes.

## Tools and SQL Concepts

- **Database:** MySQL
- **SQL environment:** MySQL Workbench
- **Input data:** CSV files
- **SQL concepts used:** `SELECT`, `GROUP BY`, `HAVING`, aggregate functions (`COUNT`, `SUM`, `AVG`, `MIN`), `INNER JOIN`, `LEFT JOIN`, `COUNT(DISTINCT ...)`, subqueries, Common Table Expressions (CTEs), date functions such as `DATE_FORMAT()`, and the `LAG()` window function.
- **Data preparation:** Table and column inspection, standardising imported column names when a byte-order mark (BOM) is present, converting `order_date` to the `DATE` data type, and checking for duplicate customer and order IDs.

## Repository Structure

```text
e-commerce-sales-customer-analysis-mysql/
├── data/
│   ├── Customers.csv
│   ├── Products.csv
│   ├── Orders.csv
│   └── Orderdetails.csv
├── ecommerce_sales_customer_analysis.sql
├── README.md
└── .gitignore
```

The single SQL workbook contains the database setup statements, data preparation and exploration steps, all 24 questions, SQL queries, and short interpretation comments.

## How to Run the Project

1. Install MySQL Server and MySQL Workbench. Use **MySQL 8.0 or later** for support for CTEs and window functions.
2. Clone or download this repository and connect to your MySQL server in Workbench.
3. Run the workbook's initial `CREATE DATABASE ecommerce;` and `USE ecommerce;` statements to create and select the schema.
4. Import the four CSV files into the `ecommerce` schema using MySQL Workbench's **Table Data Import Wizard**. Use these table names: `customers`, `products`, `orders`, and `orderdetails`.
5. Check the imported column names and data types. The workbook includes column-renaming statements for headers that retain a BOM prefix. If your import process already removed the BOM, skip or comment out the applicable rename statements before running the cleaning section.
6. Run the remaining SQL statements in order, starting with the table inspection and data preparation section. If the schema already exists, do not rerun `CREATE DATABASE ecommerce;` without changing it to `CREATE DATABASE IF NOT EXISTS ecommerce;`.

## Data Quality and Interpretation Notes

- The workbook inspects table structures and checks for repeated `customer_id` values in `customers` and repeated `order_id` values in `orders`.
- The workbook uses `orders.total_amount` for sales revenue and `orderdetails.quantity` for units purchased. Revenue and sales volume are different measures.
- The first recorded order for a customer is used to group customers by first-purchase month. Monthly new-customer counts are not the same as the growth rate of the total customer base.
- A product's frequency in the order-detail data is a demand indicator, not a true inventory turnover rate.
- Potential explanations for low customer reach, such as limited product visibility, are hypotheses; the dataset does not directly measure product exposure or reasons for non-purchase.

## Limitations

The available data covers customer, product, order, and order-line information. It does not include current stock levels, supplier lead times, marketing campaign spend or attribution, product costs, profit margins, or staffing and fulfilment workload.

Therefore, the analysis can highlight patterns and suggest areas for further investigation, but it cannot independently establish campaign effectiveness, profitability, exact restocking requirements, or staffing levels. Those decisions would require additional data.

## Learning Outcomes

This project provides practice in:

- Translating business questions into SQL queries.
- Joining relational tables and summarising transactional data.
- Analysing customer purchase frequency, product performance, and monthly sales trends.
- Using CTEs, subqueries, date functions, and window functions for business analysis.
- Interpreting query outputs carefully and documenting data limitations.
