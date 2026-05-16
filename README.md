<div align="center">
  <img src="https://upload.wikimedia.org/wikipedia/commons/2/26/Spotify_logo_with_text.svg" alt="Spotify Logo" width="400">
  
  # Spotify & YouTube Advanced Data Analysis (SQL)
  
  🗣️ **An End-to-End SQL Analytics Project Exploring Dual-Platform Music Performance Metrics**
</div>

---

## 📌 Project Overview
This repository contains a comprehensive SQL-based analytics project focused on executing Exploratory Data Analysis (EDA) and advanced business intelligence querying on a dual-platform dataset containing over 20,000 music tracks shared across **Spotify** and **YouTube**. 

The queries are structured into three progressively challenging categories (**Easy, Intermediate, and Advanced**) designed to solve realistic data warehouse reconciliation and performance metric analysis problems.

## 🛠️ Key Technical Features Demonstrated
* **Advanced Window Functions:** Implementing running totals with explicit frame controls (`ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW`) to prevent tie-breaking data bugs, and partitioning for ranking (`DENSE_RANK()`).
* **Data Integrity & Safe Arithmetic:** Utilizing `NULLIF()` and dynamic data casting (`CAST AS FLOAT`) to eliminate runtime `Divide-by-Zero` errors during multi-column ratio metrics calculations.
* **Performance Optimization & CTEs:** Architecting Common Table Expressions (CTEs) combined with `INNER JOIN` logic to deduplicate track listings and contrast concurrent metrics side-by-side.
* **Exploratory Data Analysis (EDA):** Executing data scrubbing routines (identifying and purging zero-duration anomalies), and conducting core distribution checks.

---

## 📂 Project Structure & Schema Definition

The core database operates on a single consolidated star-schema style table named `spotify_tbl`. The analysis targets structural properties such as `views`, `likes`, `stream`, `energy`, `liveness`, and platform-specific identifiers.

### Data Analysis Roadmap

### 1. Exploratory Data Analysis (EDA)
Initial data quality assessments and sanitization routines:
* Validation of record insertion counts.
* Distribution profiling of categorical variables (`album_type`, `most_playedon`).
* Identification and deletion of structural anomalies (e.g., records where `Duration_min = 0`).

### 2. Easy Category
Fundamental metrics and standard operational filters:
* Isolating high-performing milestone content (tracks with $> 1\text{ Billion}$ views).
* Unique listing mapping between artists and associated albums.
* Global licensed content auditing via analytical aggregation windows.

### 3. Intermediate Category
Multi-dimensional structural processing and conditional logic:
* Aggregating platform viewership benchmarks partitioned by individual `album` containers.
* Cross-platform streaming comparison using a deduplicated `CTE Self-Join` architecture to identify tracks outperforming on Spotify compared to YouTube.
* Ranking high-energy operational thresholds.

### 4. Advanced Category (The Analytical Core)
Solving complex analytical problems with advanced SQL Server capabilities:
* **Top-N Analysis:** Extracting the top 3 most-viewed tracks per artist using isolated `DENSE_RANK()` partitioning to accurately handle identical view metrics.
* **Global Average Benchmarking:** Identifying tracks with outlier `liveness` ratings exceeding the global table average using decoupled subqueries.
* **Dynamic Range Evaluation:** Computing energy fluctuations (`MAX - MIN`) mapped specifically across unique tracks encapsulated inside their respective albums.
* **Safe Ratio Pipelines:** Generating an `energy`-to-`liveness` balance ratio utilizing defensive `NULLIF` zero-checks.
* **Advanced Cumulative Metrics:** Constructing a bulletproof running total (`SUM OVER`) of likes ordered by popularity, using precise row frames to preserve transactional chronology.

---

## 🚀 How to Use This Repository

1.  **Database Engine:** This script is optimized for **Microsoft SQL Server (T-SQL)**.
2.  **Setup:** * Create a database named `SpotifyDB`.
    * Import the source CSV dataset into a table named `spotify_tbl`.
    * Execute the script sections sequentially to observe data scrubbing transitions and analytical output generations.

## 📊 Sample Insights Generated
* **Data Consistency:** Safely extracted 213 unique tracks that definitively outperform YouTube viewership when isolated by max-streaming thresholds on Spotify.
* **Running Aggregations:** Accurately calculated sequential cumulative milestones across 20,594 operational rows without platform group collisions.

---

## 🤝 Connect with Me
If you have any questions about this project, career opportunities, or just want to chat about Data Engineering and Analytics, feel free to reach out!

<div align="center">

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/sherif-mohammed-8a0aa3162/)
&nbsp;&nbsp;&nbsp;&nbsp;
[![Gmail](https://img.shields.io/badge/Gmail-D14836?style=for-the-badge&logo=gmail&logoColor=white)](mailto:sherifmohammed611@gmail.com)

</div>
