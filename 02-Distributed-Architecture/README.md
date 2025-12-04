# 🌐 Unit 2: Distributed Database Architecture

## 📌 Overview
In this module, we transitioned the monolithic PostgreSQL database into a **Distributed Cluster** using the **Citus** extension. The goal was to achieve horizontal scalability to support the growing transaction volume across multiple countries (Spain, Colombia, Mexico, Chile).

**Objective:** Distribute the write load across multiple nodes while maintaining data consistency and minimizing network latency.

## 🛠️ Key Techniques Applied
* **Horizontal Sharding:** Partitioned data across 4 worker nodes based on a composite key including `id_pais` (Country ID).
* **Shard Key Strategy:** Selected `(id_pais, id_sucursal)` as the distribution key to isolate data by geography.
* **Co-location:** Enforced that related data (Sales, Details, Products) resides on the same node to allow local joins without network overhead.
* **Query Routing:** Analyzed the performance difference between **Co-located Joins** (local execution) and **Repartition Joins** (heavy data movement).

## 📄 Files in this Folder
***[`sharding_architecture.md`](./sharding_architecture.md)**: A technical walkthrough of the cluster setup (Docker Compose), the sharding implementation code, and a deep-dive performance analysis of distributed queries.

---
*Return to [Main Portfolio](../README.md)*
