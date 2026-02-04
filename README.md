# Amazon ESCI: E-Commerce Search & Ranking Optimization

<div align="center">

![Python](https://img.shields.io/badge/Python-3776AB?style=flat-square&logo=python&logoColor=white)
![dbt](https://img.shields.io/badge/dbt-FF694B?style=flat-square&logo=dbt&logoColor=white)
![BigQuery](https://img.shields.io/badge/Google%20BigQuery-4285F4?style=flat-square&logo=google-cloud&logoColor=white)
![NLP](https://img.shields.io/badge/NLP-XLM--RoBERTa-green?style=flat-square)
![Tableau](https://img.shields.io/badge/Visualization-Tableau-e97627?style=flat-square&logo=tableau&logoColor=white)

**End-to-end ranking optimization project answering the question: "What did the user search for, and what did we show?" using Analytics Engineering & NLP.**

[Executive Summary](#executive-summary-star-method) • [Technical Architecture](#technical-architecture) • [Setup & Usage](#setup--usage)

</div>

---

## Executive Summary (STAR Method)

In modern e-commerce, over 60% of users search for products without knowing the exact product name (e.g., searching for "large screen tv" instead of "Samsung 55 inch"). Traditional **keyword matching** algorithms fail to capture this **semantic intent**, leading to high rates of **"Irrelevant"** results and lost revenue.

This project leverages the **Amazon ESCI (Exact, Substitute, Complement, Irrelevant)** dataset to bridge the semantic gap using a modern data stack:

| Stage | Details |
| :--- | :--- |
| **Situation** | Analysis of a multilingual (US, JP, ES) e-commerce dataset revealed a significant disconnect between user queries and product results, relying heavily on lexical overlap rather than semantic meaning. |
| **Task** | Design and implement a **Search Ranking System** capable of classifying the relationship between a user Query and a Product into four relevance classes (Exact, Substitute, Complement, Irrelevant) to improve ranking quality. |
| **Action** | <br>• **Analytics Engineering:** Orchestrated an ELT pipeline on **Google BigQuery** using **dbt** to transform raw data (2.6M+ rows) through Staging, Intermediate, and Marts layers.<br>• **NLP Modeling:** Fine-tuned a multilingual **XLM-RoBERTa** Transformer model to generate semantic similarity scores, handling cross-lingual queries effectively.<br>• **Data Governance:** Implemented strict Train/Test splits within dbt models to prevent **Data Leakage** during model training. |
| **Result** | The model achieved high discrimination power in distinguishing between relevant (Exact/Substitute) and irrelevant items. Improved ranking accuracy significantly across Japanese and Spanish locales compared to baseline methods. |

---

## Repository Structure

This repository follows industry-standard **Analytics Engineering** practices, organized into clear layers for data transformation, modeling, and visualization.

```text
amazon-esci-search-ranking/
├── models/                 # ANALYTICS ENGINEERING (dbt)
│   ├── staging/            # Cleaning raw data, type casting, and standardization (Raw -> Staging)
│   ├── intermediate/       # Business logic, JOINs, and Feature Engineering (Train/Test splits)
│   └── marts/              # Final Fact & Dimension tables ready for BI & ML consumption
│
├── notebooks/              # DATA SCIENCE & ML
│   └── ...                 # Jupyter Notebooks for EDA, Feature Engineering, and XLM-RoBERTa Training
│
├── dashboards/             # BUSINESS INTELLIGENCE
│   └── ...                 # Tableau/PowerBI dashboard screenshots and analysis outputs
│
├── macros/                 # UTILITIES
│   └── generate_schema_name.sql # Custom macro for BigQuery dataset schema management
│
└── dbt_project.yml         # Main dbt project configuration file

## Technical Architecture

The project follows a **Modern Data Stack** architecture, leveraging Google Cloud Platform for scalability and dbt for modular data transformation.

```mermaid
flowchart TD
    subgraph Raw_Data [Data Ingestion]
        A[("Amazon ESCI Dataset")] -->|Load| B(Google Cloud Storage)
        B -->|External Table| C[("BigQuery: esci_raw")]
    end

    subgraph ELT_Pipeline [dbt Analytics Engineering]
        direction TB
        C --> D[Staging Layer]
        D --> E[Intermediate Layer]
        E --> F[Marts Layer]
    end

    subgraph Consumption [Downstream Consumers]
        F -->|Training Data| G["XLM-RoBERTa Model"]
        F -->|Analytics| H["Tableau Dashboards"]
    end

    style Raw_Data fill:#f9f9f9,stroke:#333,stroke-width:1px
    style ELT_Pipeline fill:#e1f5fe,stroke:#0277bd,stroke-width:2px
    style Consumption fill:#fff3e0,stroke:#ff9800,stroke-width:2px

## Setup & Usage

### 1. Prerequisites
* **dbt Cloud Account** (Free Developer Plan is sufficient)
* **Google Cloud Platform Account** (BigQuery enabled)
* **Python 3.9+** (Only required for running ML notebooks locally or on Colab)

### 2. Data Pipeline Setup (dbt Cloud)
This project is designed to run seamlessly on **dbt Cloud** without local installation.

1.  **Repository:** Fork or clone this repository to your GitHub account.
2.  **Project Setup:** Create a new project in dbt Cloud and connect it to your GitHub repository.
3.  **Connection:** Select **BigQuery** as the database. Upload your **Service Account JSON Key** (ensure the account has `BigQuery Admin` permissions).
4.  **Execution:** inside the dbt Cloud IDE, run the following command to build the entire pipeline:
    ```bash
    dbt build
    ```
    *This command will seed the data, run all models (Staging -> Marts), and execute schema tests.*

### 3. Model Training (NLP)
The XLM-RoBERTa model training is a separate process handled via Python (Jupyter Notebooks).

1.  Install dependencies:
    ```bash
    pip install -r requirements.txt
    ```
2.  Launch the training notebook:
    ```bash
    # Ensure your GCP Service Account credentials are accessible
    jupyter notebook notebooks/03_model_training_xlm_roberta.ipynb
    ```
    *Note: You can also upload this notebook directly to Google Colab for GPU acceleration.*

---

## Key Results & Analysis

### 1. Model Performance (Discrimination Power)
The XLM-RoBERTa model demonstrated superior capability in distinguishing between relevant and irrelevant products across multiple languages, achieving over **90% separation power**. This proves the model's robustness in handling cross-lingual semantic search.

**Test Case Examples:**

| Locale | Query | Good Match (Score) | Bad Match (Score) | Discrimination Delta |
| :--- | :--- | :--- | :--- | :--- |
| **US (English)** | `gaming monitor 144hz` | ASUS (100%) | Logitech (5%) | **94%** |
| **JP (Japanese)** | `炊飯器` (Rice Cooker) | Panasonic (100%) | Nike (2%) | **97%** |
| **ES (Spanish)** | `teclado mecánico` | Logitech (100%) | Nespresso (5%) | **94%** |

### 2. Business Insights
Analysis of the dataset via dbt marts revealed critical insights for search optimization:
* **Query Length Impact:** Relevance scores consistently drop as query length increases. Long-tail queries (>60 chars) are more prone to irrelevant results.
* **Vocabulary Overlap:** High word overlap between query and product title does not guarantee relevance, highlighting the necessity of semantic models over keyword matching.

### 3. Live Demo Interface
A custom frontend was developed to visualize real-time ranking scores. The interface displays the **AI Confidence** score alongside product metadata, allowing for immediate validation of model predictions.

---

## Contributors

This project was collaboratively developed by the following team:

| Name | GitHub | LinkedIn |
| :--- | :--- | :--- |
| **Cevdet Kopuz** | [cevdetkopuz](https://github.com/cevdetkopuz) | [Profile](https://www.linkedin.com/in/cevdetkopuz/) |
| **Cem Özdoğan** | [gcemozdogan](https://github.com/gcemozdogan) | [Profile](https://www.linkedin.com/in/gcemozdogan/?locale=en_US) |
| **Zehra İstemihan** | [zistemihan](https://github.com/zistemihan) | [Profile](https://www.linkedin.com/in/zehraistemihan) |
| **Emirhan Kümüş** | [emirhankumus](https://github.com/emirhankumus) | [Profile](https://www.linkedin.com/in/emirhankumus/) |
