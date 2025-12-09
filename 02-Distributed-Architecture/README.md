# 🌐 Unit 2: Distributed Database Architecture

## 📌 Overview
In this module, we transitioned the monolithic PostgreSQL database into a **Distributed Cluster** using the **Citus** extension.

**Architectural Context:**
* **Production Strategy (Multi-Country):** The real-world infrastructure (`docker-compose.yml`) was designed to support **4 distinct countries**, with data partitioned by `country_id` to ensure strict geographic isolation (1 Worker Node per Country).
* **Lab Simulation (USA Only):** For this interactive portfolio demo, we generate a synthetic dataset focused on the United States. Therefore, the sharding strategy in the Notebook is adapted to partition data by **State** (e.g., 'TX', 'CA', 'FL').
  
## 🛠️ Key Techniques Applied
* **Horizontal Sharding:**
    * **Strategy:** Partitioned massive transactional tables (`Sale`, `Invoice`) to eliminate write bottlenecks.
    * **Shard Key:** Uses `state` in the interactive lab (adapting to the single-country dataset) to demonstrate how Citus routes queries to specific nodes.
* **Reference Tables:** Implemented replication for small dimension tables (`Product`, `Category`, `Coupon`). These are copied to every node to prevent expensive broadcasting during queries.

[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/drive/1bX7tYgi34FtqaQzeatN5pf6vN-6cEx7d?usp=sharing)

## 📄 Files in this Folder
* **[`distributed_lab.ipynb`](./distributed_lab.ipynb)**: 🌟 **Interactive Sharding Lab.** A Colab Notebook that installs Citus locally and simulates a distributed cluster. It generates data for 10 US States and shards the database by `state` to visualize the distribution mechanics. **(Click the Badge above to run).**
* **[`docker-compose.yml`](./docker-compose.yml)**: The production Infrastructure-as-Code (IaC) configuration. It provisions a **5-Node Cluster** (1 Coordinator + 4 Workers), reflecting the original design intended to support 4 countries.
* **[`sharding_architecture.md`](./sharding_architecture.md)**: A technical deep-dive into the distribution strategy, analyzing the performance difference between Co-located Joins vs. Repartition Joins.
* **[`init_citus.sql`](./init_citus.sql)**: SQL initialization script mapped to the containers to automatically enable the Citus extension upon startup.

---
*Return to [Main Portfolio](../README.md)*
