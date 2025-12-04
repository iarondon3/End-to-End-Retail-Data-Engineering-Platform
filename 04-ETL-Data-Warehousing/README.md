# 🏭 Unit 4: ETL, Data Warehousing & Business Intelligence

## 📌 Overview
While the previous modules focused on data storage and architecture, this module focuses on **Data Value**. We transformed the raw operational data into a **Star Schema Data Mart** optimized for analytical querying (OLAP).

**Objective:** Build a robust ETL pipeline to clean, enrich, and load data into a Data Warehouse, enabling the creation of strategic dashboards for decision-making.

## 🛠️ Key Techniques Applied
* **Dimensional Modeling:** Designed a **Star Schema** (`Fact_Ventas` + Dimensions) to optimize query performance for aggregations.
* **ETL Orchestration:** Used **Pentaho Data Integration (Spoon)** to extract data, perform transformations (calc fields, lookups), and load the target warehouse.
* **Data Enrichment:** Generated synthetic business metrics (e.g., `Unit Cost`) during the ETL process to enable profitability analysis.
* **Visualization:** Built an interactive dashboard in **Metabase** to track KPIs like AOV, Gross Margin, and Sales Trends.

## 📄 Files in this Folder
**[`etl_bi_showcase.md`](./etl_bi_showcase.md)**: A visual walkthrough of the Data Model, the ETL logic applied, and the final Business Intelligence dashboard.

---
*Return to [Main Portfolio](../README.md)*
