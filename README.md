# E-Commerce Customer Churn Analysis & Retention Strategy 📊

## 📌 Executive Summary
This project analyzes a dataset of **5,630 customers** to identify key drivers of attrition (churn). By implementing an end-to-end data pipeline—from SQL-based ETL to Python statistical analysis and Power BI visualization—I uncovered that operational inefficiencies (specifically late deliveries) and poor onboarding experiences are the primary reasons for customer loss.

**Key Finding:** Operational failures are costing the business significantly. Customers experiencing **Late Deliveries** have a **39.9% churn rate**, compared to just **19.7%** for on-time deliveries—effectively doubling the attrition risk.

---

## 📂 Project Structure
* **`data_cleaning_pipeline.sql`**: SQL scripts used to extract raw data, handle NULLs (imputation), and standardize categorical values (ETL).
* **`churn_analysis.ipynb`**: Python Jupyter Notebook containing the correlation analysis, statistical testing, and generation of the "Death Zone" heatmaps.
* **`dashboard.pbix`**: High-level view of the Power BI Executive Dashboard.
* **`Clean Churn Data.csv`**: The final processed dataset used for visualization.

---

## 🔍 Business Problem
The e-commerce platform was experiencing an unacceptably high churn rate (**16.8% average**). The Operations and Marketing teams lacked visibility into *why* customers were leaving—whether it was price sensitivity, service quality, or product dissatisfaction. 

**Objective:** Reduce churn by identifying "At-Risk" segments and recommending data-backed retention strategies.

---

## 🛠️ Methodology & Tech Stack
1.  **Data Extraction & Transformation (SQL):**
    * Staged raw data into a relational database.
    * Performed data cleaning (handled missing `Tenure` values, standardized `PreferredLoginDevice` text).
    * Engineered new features: Created a `Delivery_Status` flag to track logistics performance.
2.  **Exploratory Data Analysis (Python/Pandas):**
    * Conducted multivariate analysis to test hypotheses (e.g., "Do complaints drive churn?").
    * Generated correlation matrices to identify strong negative correlations between **Satisfaction Score (-0.35)** and Churn.
3.  **Visualization & Reporting (Power BI):**
    * Designed an interactive dashboard for stakeholders to filter by demographics (City Tier, Gender).
    * Built custom DAX measures for dynamic churn rate calculation.

---

## 💡 Key Insights & Findings

### 1. The "Logistics" Trap
* **Insight:** Late delivery is the single biggest manageable risk factor.
* **Data:** Churn rate jumps from **19% (On-time)** to **40% (Late)**.
* **Impact:** Improving logistics reliability could potentially save ~20% of the currently churning customer base.

### 2. The "Mobile Phone" Segment Risk
* **Insight:** High-value electronics buyers are the most sensitive to service quality.
* **Data:** **Mobile Phone** buyers have a **32% churn rate**, nearly 3x higher than **Grocery** buyers (11%).
* **Hypothesis:** Expectation mismatches regarding warranty or shipping safety for expensive items.

### 3. The "Death Zone" (Payment & Cashback)
* **Insight:** E-Wallet users are highly price-sensitive.
* **Data:** E-Wallet users receiving **Low Cashback** churn at **42.2%**. However, UPI users are highly stable (7% churn) when incentivized correctly.
* **Visual:** (See Heatmap in Dashboard)

### 4. The "Month Zero" Cliff
* **Insight:** Customer loyalty is determined in the first 30 days.
* **Data:** The tenure analysis shows a massive spike in churn during **Month 0-1**. If a user stays beyond **6 months**, their churn probability drops to <5%.

---

## 📢 Strategic Recommendations

Based on the analysis, I propose the following actions for the stakeholders:

1.  **Operation Sprint:** Prioritize "Mobile Phone" shipments. Implement a "Priority Dispatch" tag for this category to mitigate the 32% churn risk.
2.  **Onboarding Campaign:** Launch a 30-day "New User" engagement series (email/push notifications) to bridge the "Month Zero" gap, as surviving this period ensures long-term retention.
3.  **Targeted Incentives:** Stop subsidizing Cash-On-Delivery (COD) users with cashback, as it yields diminishing returns. Redirect that budget to **E-Wallet users**, where higher cashback correlates directly with a 20% drop in churn.
4.  **Service Recovery:** With **46%** of churners having logged complaints, the Customer Support team must implement a "Churn-Risk" flag for any user who logs a ticket in their first month.

---

## 🚀 How to Run This Project
1.  **SQL:** Import the raw CSV into MySQL/PostgreSQL and run `data_cleaning_pipeline.sql` to generate the clean table.
2.  **Python:** Open `churn_analysis.ipynb` (requires Pandas, Seaborn) to reproduce the statistical findings and heatmaps.
3.  **Power BI:** Open the `.pbix` file or view `dashboard_screenshot.png` for the final report structure.

---
*Author: Saurabh Vishwakarma*
