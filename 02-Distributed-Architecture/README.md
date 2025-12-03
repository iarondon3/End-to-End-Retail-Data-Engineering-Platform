# 🌐 Unit 2: Distributed Database Architecture

## 📌 Overview
In this module, we transitioned the monolithic PostgreSQL database into a **Distributed Cluster** using **Citus** extension. The goal was to achieve horizontal scalability to support the growing number of transactions across multiple countries.

**Objective:** Implement a **Sharded Architecture** using the **Citus** extension to distribute data and processing across multiple nodes, ensuring high availability, scalability and maintaining data consistency.

## 🛠️ Key Techniques Applied
* **Horizontal Sharding:** Partitioned data across multiple nodes based on a strategic Shard Key (`id_sucursal`).
* **Query Routing:** Optimized queries to target specific shards (Router Execution) vs. cross-shard aggregation (Gather Execution).
* **High Availability:** Configured replication factors to ensure zero downtime in case of node failure.

## 📄 Files in this Folder
* `sharding_architecture.md`: A deep dive into the distribution strategy, showing the table conversion code and query execution plans in a distributed environment.

---
*Return to [Main Portfolio](../README.md)*
