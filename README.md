# 🎯 Amazon ESCI: E-Commerce Search & Ranking Optimization

<div align="center">

[![Python](https://img.shields.io/badge/Python-3.9%2B-blue?logo=python&logoColor=white)](https://www.python.org/)
[![dbt](https://img.shields.io/badge/dbt-Analytics_Engineering-orange?logo=dbt&logoColor=white)](https://www.getdbt.com/)
[![BigQuery](https://img.shields.io/badge/Google_Cloud-BigQuery-4285F4?logo=googlecloud&logoColor=white)](https://cloud.google.com/bigquery)
[![HuggingFace](https://img.shields.io/badge/NLP-XLM--RoBERTa-yellow?logo=huggingface&logoColor=black)](https://huggingface.co/)
[![Tableau](https://img.shields.io/badge/Visualization-Tableau-E97627?logo=tableau&logoColor=white)](https://www.tableau.com/)

**End-to-end ranking optimization project answering the question: "What did the user search for, and what did we show?" using Analytics Engineering & NLP.**

[Executive Summary](#-executive-summary-star-method) • [Technical Architecture](#-technical-architecture) • [Setup & Usage](#-setup--usage)

</div>

---

## 💼 Executive Summary (STAR Method)

In modern e-commerce, over 60% of users search for products without knowing the exact product name (e.g., searching for "large screen tv" instead of "Samsung 55 inch"). Traditional **keyword matching** algorithms fail to capture this **semantic intent**, leading to high rates of **"Irrelevant"** results and lost revenue.

This project leverages the **Amazon ESCI (Exact, Substitute, Complement, Irrelevant)** dataset to bridge the semantic gap using a modern data stack:

| Stage | Details |
| :--- | :--- |
| **📍 Situation** | Analysis of a multilingual (US, JP, ES) e-commerce dataset revealed a significant disconnect between user queries and product results, relying heavily on lexical overlap rather than semantic meaning. |
| **🛠 Task** | Design and implement a **Search Ranking System** capable of classifying the relationship between a user Query and a Product into four relevance classes (Exact, Substitute, Complement, Irrelevant) to improve ranking quality. |
| **⚡ Action** | <br>• **Analytics Engineering:** Orchestrated an ELT pipeline on **Google BigQuery** using **dbt** to transform raw data (2.6M+ rows) through Staging, Intermediate, and Marts layers.<br>• **NLP Modeling:** Fine-tuned a multilingual **XLM-RoBERTa** Transformer model to generate semantic similarity scores, handling cross-lingual queries effectively.<br>• **Data Governance:** Implemented strict Train/Test splits within dbt models to prevent **Data Leakage** during model training. |
| **🏆 Result** | The model achieved **90%+ Discrimination Power** in distinguishing between relevant (Exact/Substitute) and irrelevant items. Improved ranking accuracy significantly across Japanese and Spanish locales compared to baseline methods. |

---

## 📂 Repository Structure

This repository follows industry-standard **Analytics Engineering** practices, organized into clear layers for data transformation, modeling, and visualization.

```text
amazon-esci-search-ranking/
├── 📂 models/              # 🧠 ANALYTICS ENGINEERING (dbt)
│   ├── staging/            # Cleaning raw data, type casting, and standardization (Raw -> Staging)
│   ├── intermediate/       # Business logic, JOINs, and Feature Engineering (Train/Test splits)
│   └── marts/              # Final Fact & Dimension tables ready for BI & ML consumption
│
├── 📂 notebooks/           # 🤖 DATA SCIENCE & ML
│   └── ...                 # Jupyter Notebooks for EDA, Feature Engineering, and XLM-RoBERTa Training
│
├── 📂 dashboards/          # 📊 BUSINESS INTELLIGENCE
│   └── ...                 # Tableau/PowerBI dashboard screenshots and analysis outputs
│
├── 📂 macros/              # ⚙️ UTILITIES
│   └── generate_schema_name.sql # Custom macro for BigQuery dataset schema management
│
└── dbt_project.yml         # Main dbt project configuration file
