# OnlineRetail-Sales-Analytics
End-to-end Retail Sales Analytics project using SQL Server and Power BI with interactive dashboards and KPIs for business insights.
#  Online Retail Sales Analytics System

###  Overview
This project demonstrates an **end-to-end Retail Sales Analytics system** built using **MS SQL Server** and **Power BI**.  
It helps analyze customer, product, order, and payment data to uncover insights such as top products, revenue trends, and customer behavior.

---

###  Features
- Designed and normalized a retail sales database with relationships between customers, orders, and payments.  
- Implemented **SQL Views, Triggers, and Stored Procedures** for analytical and automated tasks.  
- Integrated **SQL Server with Power BI** for real-time data visualization.  
- Developed Key Performance Indicators (KPIs) for:
  -  Total Revenue  
  -  Total Orders  
  -  Total Customers  
  -  Average Order Value  
- Built interactive dashboards showcasing:
  - Top Products by Revenue  
  - Top Customers by Spending  
  - Monthly Sales Trends  
  - Revenue by City  

---

###  Technologies Used
| Tool | Purpose |
|------|----------|
| **MS SQL Server** | Database design, T-SQL queries, triggers, procedures |
| **Power BI Desktop** | Data modeling, DAX measures, dashboards |
| **GitHub** | Version control & portfolio hosting |

---

###  Project Files
| File | Description |
|------|-------------|
| `OnlineRetailDB.sql` | SQL script to create tables, insert sample data, and define triggers/views/procedures |
| `OnlineRetail_Analytics.pbix` | Power BI Dashboard connected to SQL Server |
| `OnlineRetail_Dashboard.png` | Screenshot preview of the dashboard |
| `README.md` | Project documentation |

---

###  Dashboard Preview
![Dashboard Screenshot](OnlineRetail_Dashboard.png)

---

###  SQL Highlights
- **Views Created:**  
  - `vw_TopProducts` – Top-selling products by revenue  
  - `vw_TopCustomers` – Best customers by spending  
  - `vw_MonthlySales` – Monthly revenue trends  
- **Trigger:** Automatically updates product stock after new orders  
- **Stored Procedure:** Generates monthly sales summaries  

---

###  Power BI Insights
- Interactive dashboard with slicers for **Month** and **City**  
- KPIs at the top to display real-time metrics  
- Trend, pie, and bar charts for quick decision-making  

---

###  Author
**Siddharth Parab**  
 *Created: October 2025*  
 If you found this useful, give this repository a star!

---

###  How to Run This Project
1. Restore or run the SQL script `OnlineRetailDB.sql` in **MS SQL Server Management Studio**.  
2. Open **Power BI Desktop** and connect to your SQL Server instance.  
3. Load tables & views from `OnlineRetailDB`.  
4. Refresh visuals and explore the interactive dashboard.

---

###  Project Outcome
This project showcases how SQL and Power BI can work together to transform raw data into meaningful insights through data modeling, KPI design, and visualization.  
It demonstrates practical skills in **data analysis, business intelligence, and database management**.

---

> 💬 *“Data speaks best when visualized — this project brings retail insights to life using SQL and Power BI.”*
