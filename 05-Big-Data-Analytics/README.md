# 🐘 Unit 5: Big Data Analytics & Spark

## 📌 Overview
The traditional Data Mart answered "What happened?". In this module, we transitioned to **Big Data** technologies to understand **"Why it happened"**. We processed massive volumes of unstructured behavioral data (clickstream logs, cart interactions, payment attempts) to uncover hidden patterns in the customer journey.

**Objective:** Transition from descriptive BI to diagnostic and prescriptive analytics using **Apache Spark on Databricks**.

## 🛠️ Key Techniques Applied
* **Data Generation at Scale:** Engineered a Python script using `Faker` to synthesize over **1 Million realistic events**, simulating complex user sessions across the web and mobile app.
* **Lakehouse Architecture:** Ingested raw CSV/Parquet files into Databricks tables, creating a unified analytics layer.
* **Spark SQL & Complex Logic:** Executed advanced queries involving **CTEs**, **Anti-Joins**, and **Union** operations to reconstruct user sessions across disparate event logs.
* **Diagnostic Analytics:** Identified critical data integrity issues and bottlenecks in the conversion funnel.

[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/drive/1yQs3jyuxpd3wldkmq9ha2wfPygZ54xnb#scrollTo=qY4EFE4WATmY)

## 📄 Files in this Folder
* **[`spark_analytics_lab.ipynb`](./spark_analytics_lab.ipynb)**: 🌟 **Interactive Big Data Lab.** A PySpark notebook that generates 50k+ raw event logs, executes data engineering transformations, and visualizes the conversion funnel using Plotly. **(Click the Badge above to run).**
**[`spark_analytics_showcase.md`](./spark_analytics_showcase.md)**: A detailed walkthrough of the behavioral analysis, featuring the "Broken Funnel" diagnosis and the Cross-Selling recommendation engine.

---
*Return to [Main Portfolio](../README.md)*
