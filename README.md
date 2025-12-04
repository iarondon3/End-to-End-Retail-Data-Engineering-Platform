# 🚀End-to-End-Retail-Data-Ecosystem
Transforming Raw Transactional Data into Strategic Behavioral Insights

***📋Executive Summary***



This project demonstrates the design, implementation, and evolution of a complete data ecosystem for a high-volume retail environment (simulating Walgreens operations). The architecture evolves from a traditional OLTP system to a Distributed Architecture, integrates a NoSQL layer for customer flexibility, consolidates data into an OLAP Data Mart via ETL, and finally leverages Big Data/Spark for advanced behavioral analytics.



The goal was not just to store data, but to build a pipeline that transforms operational noise into actionable business intelligence, identifying critical revenue leakages and cross-selling opportunities.



## **🏗️ Architecture & Modules**



This repository is organized into five core modules, representing the lifecycle of data maturity:



### **📂 [01-SQL-Optimization](./01-SQL-Optimization)** ### 

*High-Performance OLTP Tuning*


- Challenge: High latency in transactional queries due to volume growth.
- Solution: Deep analysis of query execution plans (EXPLAIN ANALYZE) and implementation of advanced B-Tree indexing strategies.
- Outcome: Transformed Sequential Scans into Index Scans, drastically reducing computational cost and query response time for the POS system.



### **📂 [02-Distributed-Architecture](./02-Distributed-Architecture)**

*Horizontal Scaling & Sharding*
- Challenge: The monolithic database could not sustain the write-throughput of concurrent store transactions.
- Solution: Designed a Sharded Architecture using PostgreSQL/Citus, partitioning data horizontally by geography (Country/Branch).
- Outcome: Achieved linear scalability and high availability, ensuring that a failure in one region does not paralyze the global operation.



### **📂 [03-NoSQL-Integration](./03-NoSQL-Integration)**   

*Flexible Customer Data Modeling*
- Challenge: The relational model was too rigid to capture dynamic customer profiles and nested interaction logs.
- Solution: Integrated MongoDB as a document store. Designed a denormalized schema embedding transactional snapshots within customer documents.
- Outcome: Enabled fast, single-read retrieval of complex customer histories without expensive SQL joins, facilitating real-time profile lookups.


### **📂  [04-ETL-Data-Warehousing](./04-ETL-Data-Warehousing)** 
*Business Intelligence & Dimensional Modeling*

- Challenge: Operational data was siloed and optimized for writing, not reading/reporting.

- Solution:
  
    - Designed a Star Schema Data Mart in PostgreSQL.
    - Built robust ETL pipelines using Pentaho Data Integration (Spoon) to clean, transform, and enrich data (e.g., calculating synthetic Gross Margin).
    - Deployed interactive dashboards in Metabase and Power BI.
  
- Outcome: Empowered stakeholders to visualize KPI trends, such as "Average Order Value (AOV) by Day" and "Month-over-Month Growth by Channel."

### **📂  [05-Big-Data-Analytics](./05-Big-Data-Analytics)**

*Spark SQL & Behavioral Analysis*

- Challenge: Traditional BI tools could not process millions of clickstream and cart events to understand why users were not buying.
- Solution:
  - Generated massive synthetic datasets (Clickstream, Cart Events, Payment Attempts) using Python/Faker.
  - Utilized Apache Spark on Databricks to perform wide-transformation queries on massive datasets.
- Outcome:
  - Identified a critical bottleneck: Discovered a 75% failure rate at the payment gateway stage.
  - Uncovered Cross-Sell opportunities: Identified high-intent products (viewed but not bought) for specific customer segments using Anti-Joins.


## **📉 Key Business Insights Uncovered**

Through this engineering pipeline, we moved from "guessing" to "knowing":



- **The "Broken Funnel"**: Advanced Spark analysis revealed that the biggest revenue loss wasn't in product selection, but in technical payment failures (75% drop-off at checkout).



- **Hidden Demand**: Cross-sell analysis identified that customers buying low-margin staples (e.g., Mineral Water) frequently browsed high-margin Personal Care items without purchasing, signaling a prime opportunity for bundling strategies.


- **Channel Behavior**: The BI layer revealed distinct growth patterns between Online and Physical stores, allowing for channel-specific inventory optimization.

## **🛠️ Tech Stack**


- Relational Database: PostgreSQL (Local & Distributed/Citus).

- NoSQL Database: MongoDB (Atlas).

- ETL & Orchestration: Pentaho Data Integration (Spoon).

- Big Data Processing: Apache Spark (PySpark & Spark SQL) on Databricks.

- Visualization: Metabase / Power BI.

- Languages: SQL.
  

#### 👤 Author

Isabella Rondón - *Data Analyst | BI Developer | Big Data Enthusiast*
