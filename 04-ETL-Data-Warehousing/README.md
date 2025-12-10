# 🏭 Unit 4: ETL, Data Warehousing & Business Intelligence

## 📌 Overview
While previous modules focused on architecture, this module focuses on **Data Value**. We transform raw operational data (OLTP) into a **Star Schema Data Mart** (OLAP) optimized for strategic decision-making.

**Objective:** Build a robust ETL pipeline to clean, enrich, and load data into a Data Warehouse, enabling the creation of strategic dashboards for decision-making.

### 🔄 Hybrid Tech Stack approach
* **Original Implementation:** Built using **Pentaho Data Integration (Spoon)** for visual ETL orchestration and **Metabase** for dashboarding.
* **Interactive Lab (Cloud Demo):** To make this portfolio reproducible in the browser, I have simulated the exact same logic using a **Modern Data Stack** approach: **Python/Pandas** (Transformation), **DuckDB** (In-Memory Data Warehouse), and **Plotly** (Interactive BI).

## 🛠️ Key Techniques Applied
* **Dimensional Modeling:** Designed a **Star Schema** (`Fact_Sales` + Dimensions) with sorted Surrogate Keys to optimize query performance.
* **ETL Business Logic:** Enriched raw data by calculating financial metrics (e.g., **Gross Margin**, **Profitability %**) during the transformation phase, and load the target warehouse
* **Automated Data Storytelling:** Developed a script that automatically detects the top-performing region via SQL and generates a customized Deep-Dive report, simulating an automated BI alert system.

[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/drive/1IUhApOP9g4f8o9TobiKzsigJ1jxARklb#scrollTo=cysyx-CjvXiH)

## 📄 Files in this Folder
* **[`etl_warehouse_lab.ipynb`](./etl_warehouse_lab.ipynb)**: 🌟 **Interactive BI Lab.** A complete "Code-First" ETL pipeline. It generates dirty data, cleans it, builds a Star Schema in DuckDB, and executes automated SQL analysis. **(Click the Badge above to run).**
* **[`etl_bi_showcase.md`](./etl_bi_showcase.md)**: A visual walkthrough of the original Data Model, the ETL logic applied in Spoon, and the final dashboard in Metabase.

---
*Return to [Main Portfolio](../README.md)*
