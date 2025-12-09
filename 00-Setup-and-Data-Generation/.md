# 🏗️ Stage 0: Environment Setup & Data Generation

## 📌 Overview
Before analyzing data, we need to create it. This module contains the reproducible pipeline used to generate the synthetic datasets for the Walgreens POS system.

**Objective:** Provide a self-contained script that allows any engineer to replicate the database schema and populate it with realistic synthetic data using Python.

## 🛠️ Tools Used
* **Python:** Core scripting logic.
* **Faker:** Library for generating realistic dummy data (names, addresses, dates).
* **Pandas:** For data manipulation and CSV export.

## 🚀 How to Run
You can simulate the data generation process directly in your browser without installing any local dependencies:

[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/drive/1d5HqYy7v3fKrU-zRBrxEW8AnAtk_gic8#scrollTo=ANvhAiRSrtWT)

## 📄 Files in this Folder
* `data_generation_pipeline.ipynb`: The Collab Notebook containing the DDL schemas and the Python generation script.
* `schema_definition.sql`: Raw SQL file for table creation (PostgreSQL).

---
*Return to [Main Portfolio](../README.md)*
