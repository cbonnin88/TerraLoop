# 🌍 TerraLoop: End-to-End Product Analytics Pipeline

### **🌟 Impact Statement**
> "By turning raw data into interactive insights, this pipeline enables TerraLoop to optimize its circular economy marketplace, potentially increasing successful recycling completions by identifying and removing user friction."

### **Project Overview**
TerraLoop is a circular economy startup aimed at reducing e-waste and industrial scrap. This project implements a **Modern Data Stack (MDS)** to transform raw, messy event logs into a strategic analytics suite. By modeling user behavior and listing performance, I identified key friction points in the user journey and regional variations in sustainability impact.



---

### **🛠 The Tech Stack**
* **Ingestion:** `Airbyte` (Automated ELT from GCS/Local to BigQuery).
* **Warehouse:** `Google BigQuery` (Scalable cloud data storage).
* **Transformation:** `dbt` (Modular SQL modeling, schema testing, and documentation).
* **Processing Engine:** `Polars` (High-performance Python library for complex joins and time-series math).
* **Visualization:** `Plotly` (Interactive Python charts for product behavior analysis).

---

### **🏗 Data Architecture**
1.  **Staging Layer:** Cleaned raw JSON logs from Airbyte, standardized timestamps, and enforced casing consistency.
2.  **Mart Layer:** Joined User Dimensions with Event Facts to create "Golden Tables" for analysis.
3.  **Analytics Layer:** Used Polars to calculate complex metrics like **7-Day Rolling Averages** and **Cohort Retention**.



---

### **📈 Key Business Insights**
* **The Activation Gap:** Identified a significant drop-off between `session_start` and `start_listing` in the **Basic** user tier, suggesting a need for a simplified onboarding flow.
* **Regional Dominance:** The **EMEA** region showed the highest **Listing Density**, while **NA** led in **Eco-Score Impact** per listing.
* **Category Affinity:** Discovered that **Pro** users have a high affinity for **Industrial** and **Electronics** categories, requiring more specialized listing attributes.

---

### **🚀 Technical Challenges Overcome**
* **ID Synchronization:** Resolved a critical join-key mismatch between distributed event logs and user registries using Python-based data cleaning and `TRIM(UPPER())` standardization.
* **JSON Parsing:** Handled semi-structured data from Airbyte within BigQuery using `JSON_EXTRACT` and `SAFE_CAST` methods.
* **Performance Optimization:** Leveraged Polars' window functions (`.over()`) and rolling means to process time-series data 10x faster than traditional Pandas methods.

---

### **How to Reproduce**
1.  **Data Generation:** Run `python data_gen.py` to create synced CSV files.
2.  **dbt:** Run `dbt deps` and `dbt run` to build the warehouse models.
3.  **Visualization:** Run `python analytics_dashboard.py` to generate interactive Plotly charts.

---

### **Next Steps**
* [ ] Automate the pipeline using GitHub Actions.
* [ ] Implement a Slack notification for dbt test failures using Elementary.
