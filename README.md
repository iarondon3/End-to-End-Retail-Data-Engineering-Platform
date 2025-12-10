# 🛒 End-to-End Retail Data Ecosystem

![PostgreSQL](https://img.shields.io/badge/PostgreSQL-16-336791?logo=postgresql&logoColor=white)
![MongoDB](https://img.shields.io/badge/MongoDB-6.0-47A248?logo=mongodb&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-Compose-2496ED?logo=docker&logoColor=white)
![Citus](https://img.shields.io/badge/Citus-Distributed-F36C00?logo=postgresql&logoColor=white)
![Pentaho](https://img.shields.io/badge/Pentaho_(Spoon)-ETL-005D8C?logo=hitachi&logoColor=white)
![Databricks](https://img.shields.io/badge/Databricks-Lakehouse-FF3621?logo=databricks&logoColor=white)
![Metabase](https://img.shields.io/badge/Metabase-BI-509EE3?logo=metabase&logoColor=white)
![Apache Spark](https://img.shields.io/badge/Apache%20Spark-Big%20Data-E25A1C?logo=apachespark&logoColor=white)
![Python](https://img.shields.io/badge/Python-3.10-blue?logo=python&logoColor=white)

## 📌 Project Overview
This project demonstrates the design, implementation, and evolution of a complete data ecosystem for a high-volume retail environment (simulating Walgreens operations). The architecture evolves from a traditional OLTP system to a Distributed Architecture, integrates a NoSQL layer for customer flexibility, consolidates data into an OLAP Data Mart via ETL, and finally leverages Big Data/Spark for advanced behavioral analytics.

The goal was not just to store data, but to build a pipeline that transforms operational noise into actionable business intelligence.

**Key Highlights:**
* **Hybrid Architecture:** Integration of SQL (PostgreSQL) for transactions and NoSQL (MongoDB) for analytics.
* **Scalability:** Implementation of **Sharding** using Citus to handle horizontal scaling.
* **Modern Stack:** Usage of **Databricks** concepts for processing and **Metabase** for visualization logic.
* **ETL Workflows:** Data transformation logic inspired by **Pentaho Spoon** and implemented in Python for reproducibility.
* **Performance:** Query optimization strategies reducing execution costs by **99%**.

---

## 🚀 Interactive Portfolio Modules (Click to Run)

| Unit | Topic | Tech Stack | Interactive Lab |
| :--- | :--- | :--- | :--- |
| **00** | **Data Generation Pipeline** | Python, Faker, Pandas | [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/drive/1d5HqYy7v3fKrU-zRBrxEW8AnAtk_gic8?usp=drive_link)|
| **01** | **SQL Optimization & Tuning** | PostgreSQL, Indexing | [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/drive/1f_EAGTVF8MTHsQNBM_mxVcyChgx9OyOd?usp=drive_link)|
| **02** | **Distributed Architecture** | Citus (Sharding), Docker | [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/drive/1bX7tYgi34FtqaQzeatN5pf6vN-6cEx7d?usp=sharing)|
| **03** | **NoSQL Integration (ETL)** | MongoDB, Python ETL | [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/drive/1tlTGU8N8uUloPpfxdKSdtA7okvKdAdHh?usp=drive_link)|
| **04** | **Data Warehousing & BI** | DuckDB, Star Schema | [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/drive/1IUhApOP9g4f8o9TobiKzsigJ1jxARklb?usp=drive_link)|
| **05** | **Big Data Analytics** | Apache Spark, PySpark | [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/drive/1yQs3jyuxpd3wldkmq9ha2wfPygZ54xnb?usp=drive_link)|
---

## 📚 Repository Structure

### 📂 [Unit 0: Setup & Data Generation](./00-Setup-and-Data-Generation)
*Environment Setup & Data Generation Pipeline*
* **Goal:** Create a massive synthetic dataset (up to 500k records) simulating realistic retail transactions.
* **Key Tech:** Python `Faker`, Parametric Configuration.

### 📂 [Unit 1: SQL Optimization](./01-SQL-Optimization)
*High-Performance OLTP Tuning*
* **Goal:** Solve performance bottlenecks in analytical queries.
* **Key Tech:** `EXPLAIN ANALYZE`, B-Tree Indexes, Cost Analysis.
* **Result:** Reduced query execution time from ~600ms to <10ms.

### 📂 [Unit 2: Distributed Architecture](./02-Distributed-Architecture)
*Horizontal Scaling & Sharding*
* **Goal:** Scale the database horizontally to support multi-region operations.
* **Key Tech:** Citus Data, Sharding (Partitioning by State), Docker Compose.
* **Result:** A shared-nothing architecture capable of linear scaling.

### 📂 [Unit 3: NoSQL Integration](./03-NoSQL-Integration)
*Flexible Customer Data Modeling*
* **Goal:** Enable high-speed consumer behavior analytics.
* **Key Tech:** MongoDB, ETL Pipeline (SQL to JSON), Aggregation Framework.
* **Strategy:** "Pure Embedding" pattern to eliminate expensive joins in read-heavy dashboards.

### 📂 [Unit 4: ETL & Data Warehousing](./04-ETL-Data-Warehousing)
*Business Intelligence & Dimensional Modeling*
* **Goal:** Centralize operational data into a **Star Schema** to enable historical reporting and trend analysis.
* **Key Tech:** Pentaho Data Integration (Spoon), Dimensional Modeling, Metabase/Power BI.
* **Result:** Automated calculation of complex KPIs like "Month-over-Month Growth" and synthetic Gross Margins by enriching raw data.

### 📂 [Unit 5: Big Data Analytics](./05-Big-Data-Analytics)
*Spark SQL & Behavioral Analysis*
* **Goal:** Process millions of raw clickstream events to diagnose funnel drop-offs and user intent.
* **Key Tech:** Apache Spark, Databricks, Python/Faker (Clickstream generation).
* **Result:** Identified a critical **75% payment failure rate** and uncovered cross-sell opportunities using Anti-Joins on high-intent user segments.


---

## 👨‍💻 About the Author
*Isabella Rondón* | ***Business Economist & Data Analyst*** 

Specialized in bridging the gap between business strategy and technical implementation. Passionate about building scalable data architectures that drive business intelligence.

[![LinkedIn](https://img.shields.io/badge/Connect-LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](PEGAR_TU_LINK_DE_LINKEDIN_AQUI)
[![GitHub Portfolio](https://img.shields.io/badge/Visit-Portfolio-181717?style=for-the-badge&logo=github&logoColor=white)]([PEGAR_TU_LINK_DEL_REPO_O_PERFIL_AQUI](https://github.com/iarondon3)) 



