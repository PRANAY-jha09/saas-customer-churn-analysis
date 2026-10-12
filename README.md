# SaaS Customer Churn & Revenue-at-Risk Analysis

## Project Overview

This project analyses customer churn and revenue-at-risk for **RavenStack**, a synthetic SaaS business dataset. The goal is to identify high-risk customer segments, understand churn drivers, quantify revenue exposure and create business recommendations to improve customer retention.

The project uses **SQL, SQLite, Python, Power BI, VS Code and Git/GitHub** to create an end-to-end analytics workflow from raw data loading to executive dashboard development.

## Business Problem

RavenStack wants to understand why customers are leaving before its public launch and which customer segments create the greatest recurring revenue risk.

The key business questions are:

* What is the overall customer churn rate?
* Which plan tiers have the highest churn?
* Which industries are most at risk?
* Which referral sources bring higher-churn customers?
* Which customer seat-size groups churn the most?
* What are the most common churn reasons?
* How much monthly and annual recurring revenue is at risk?
* How do product usage and support experience differ between active and churned customers?
* Which segments should be prioritised for retention?

## Tools Used

* **VS Code** – project development environment
* **Git & GitHub** – version control and portfolio presentation
* **SQLite** – local relational database
* **SQL** – data quality checks, churn analysis and revenue-at-risk analysis
* **Python** – CSV loading, analytical datasets, churn visualisations and insight summary
* **Pandas** – data manipulation and aggregation
* **Matplotlib** – Python chart outputs

## Dataset

Dataset: RavenStack Synthetic SaaS Dataset
Author: River @ Rivalytics
Format: CSV, multi-table relational dataset
License: Educational and portfolio use permitted with credit to the original author.

The dataset contains:

| Table           |   Rows | Description                                   |
| --------------- | -----: | --------------------------------------------- |
| accounts        |    500 | Customer account-level information            |
| subscriptions   |  5,000 | Subscription, MRR, ARR and billing details    |
| feature_usage   | 25,000 | Product usage and feature activity            |
| support_tickets |  2,000 | Customer support interactions                 |
| churn_events    |    600 | Churn reasons, churn dates and churn feedback |

## Database Structure

The dataset follows a relational structure:

```text
accounts.account_id
│
├── subscriptions.account_id
│   └── feature_usage.subscription_id
│
├── support_tickets.account_id
└── churn_events.account_id
```

## Project Workflow

### 1. Project Setup

The project was structured in VS Code with separate folders for raw data, cleaned data, SQL scripts, Python scripts, Power BI files, reports and screenshots.

### 2. Data Loading

A Python script was used to load the raw CSV files into a local SQLite database.

File used:

```text
python/load_data_to_sqlite.py
```

### 3. Data Quality Checks

SQL checks were performed to validate:

* Row counts across all five tables
* Duplicate primary key checks
* Missing values in key account and subscription fields
* Broken relationships between linked tables

File used:

```text
sql/02_data_quality_checks.sql
```

### 4. Churn Analysis

SQL queries were used to analyse:

* Overall customer churn rate
* Churn rate by plan tier
* Churn rate by industry
* Churn rate by referral source
* Churn rate by seat-size group
* Top churn reasons
* Churn reasons by plan tier

File used:

```text
sql/03_churn_analysis.sql
```

### 5. Revenue-at-Risk Analysis

SQL queries were used to analyse:

* Total revenue by churn status
* Monthly and annual revenue at risk
* Revenue at risk by plan tier
* Revenue at risk by industry
* Revenue at risk by referral source
* Average revenue by plan tier and churn status
* High-value churned accounts

File used:

```text
sql/04_revenue_risk_analysis.sql
```

### 6. Python Analysis

Python was used to extend the SQL analysis by creating account-level and subscription-level analytical datasets. The Python analysis focused on churn behaviour, product usage, support experience and business insight generation.

File used:

```text
python/01_churn_usage_support_analysis.ipynb
```

Python outputs saved:

```text
reports/python_charts
reports/python_insights_summary.csv
```

## Data Quality Findings

* All five CSV files were successfully loaded into SQLite.
* Row counts matched the dataset documentation.
* No missing values were found in key account or subscription fields.
* No broken relationships were found between accounts, subscriptions, feature usage, support tickets and churn events.
* Duplicate `usage_id` values were identified in the `feature_usage` table. Since all feature usage records link correctly to valid subscription IDs, the analysis uses `subscription_id` for joins rather than relying on `usage_id` as a unique identifier.

## SQL Churn Analysis Results

### 1. Overall Customer Churn Rate

![Overall Churn Rate](reports/screenshots/01_overall_churn_rate.png)

The overall churn rate is **22.0%**, with **110 churned accounts** out of **500 total accounts**.

This means that around one in every five customers has churned, making retention a clear business concern for RavenStack.

### 2. Churn Rate by Plan Tier

![Churn by Plan Tier](reports/screenshots/02_churn_by_plan_tier.png)

| Plan Tier  | Total Accounts | Churned Accounts | Churn Rate |
| ---------- | -------------: | ---------------: | ---------: |
| Enterprise |            154 |               34 |     22.08% |
| Basic      |            168 |               37 |     22.02% |
| Pro        |            178 |               39 |     21.91% |

Churn is almost evenly distributed across all three plan tiers. Enterprise has the highest churn rate at **22.08%**, but the difference between Enterprise, Basic and Pro is very small.

This suggests that churn is not limited to one pricing tier. Product experience, support quality and perceived value may be affecting customers across all plans.

### 3. Churn Rate by Industry

![Churn by Industry](reports/screenshots/03_churn_by_industry.png)

| Industry      | Total Accounts | Churned Accounts | Churn Rate |
| ------------- | -------------: | ---------------: | ---------: |
| DevTools      |            113 |               35 |     30.97% |
| FinTech       |            112 |               25 |     22.32% |
| HealthTech    |             96 |               21 |     21.88% |
| EdTech        |             79 |               13 |     16.46% |
| Cybersecurity |            100 |               16 |     16.00% |

The **DevTools** segment has the highest churn rate at **30.97%**, which is significantly higher than the overall churn rate of **22.0%**.

This suggests that DevTools customers may have stronger feature expectations, more technical requirements or lower tolerance for product limitations.

### 4. Churn Rate by Referral Source

![Churn by Referral Source](reports/screenshots/04_churn_by_referral_source.png)

| Referral Source | Total Accounts | Churned Accounts | Churn Rate |
| --------------- | -------------: | ---------------: | ---------: |
| Event           |             96 |               29 |     30.21% |
| Other           |            103 |               25 |     24.27% |
| Ads             |             98 |               23 |     23.47% |
| Organic         |            114 |               20 |     17.54% |
| Partner         |             89 |               13 |     14.61% |

Customers acquired through **events** have the highest churn rate at **30.21%**, while partner referrals have the lowest churn rate at **14.61%**.

This suggests that partner-led acquisition may bring better-fit customers, while event-led acquisition may need stronger qualification, onboarding or expectation-setting.

### 5. Churn Rate by Seat Size Group

![Churn by Seat Size Group](reports/screenshots/05_churn_by_seat_size_group.png)

| Seat Size Group | Total Accounts | Churned Accounts | Churn Rate |
| --------------- | -------------: | ---------------: | ---------: |
| 6–20 seats      |            188 |               47 |     25.00% |
| 50+ seats       |             37 |                8 |     21.62% |
| 1–5 seats       |            126 |               26 |     20.63% |
| 21–50 seats     |            149 |               29 |     19.46% |

The **6–20 seats** segment has the highest churn rate at **25.0%**.

This may indicate that small-to-mid-sized teams are large enough to require value from collaboration features, but may still be sensitive to onboarding, budget and support issues.

### 6. Top Churn Reasons

![Top Churn Reasons](reports/screenshots/06_top_churn_reasons.png)

| Reason Code | Churn Events | Percentage of Churn Events |
| ----------- | -----------: | -------------------------: |
| Features    |          114 |                     19.00% |
| Budget      |          104 |                     17.33% |
| Support     |          104 |                     17.33% |
| Unknown     |           95 |                     15.83% |
| Competitor  |           92 |                     15.33% |
| Pricing     |           91 |                     15.17% |

The most common churn reason is **features**, accounting for **19.0%** of churn events.

Budget and support are also major churn drivers, each representing **17.33%** of churn events. This suggests that churn is driven by a mix of product value, affordability and customer experience.

### 7. Churn Reasons by Plan Tier

![Churn Reasons by Plan Tier](reports/screenshots/07_churn_reasons_by_plan_tier.png)

Key patterns by plan tier:

* **Basic:** Support is the top churn reason.
* **Enterprise:** Features are the top churn reason.
* **Pro:** Support and features are the top churn reasons.

This suggests that each plan tier requires a different retention strategy. Basic users may need faster support and clearer onboarding, while Enterprise customers may need stronger feature depth, product reliability and roadmap alignment.

## SQL Churn Key Insights

1. The overall churn rate is **22.0%**, meaning customer retention is a clear business risk.
2. Churn is almost equal across Basic, Pro and Enterprise plans, suggesting the issue is not limited to one pricing tier.
3. **DevTools customers** show the highest churn rate at **30.97%**, making them the most at-risk industry segment.
4. **Event-acquired customers** have the highest churn rate at **30.21%**, while partner-acquired customers have the lowest churn rate at **14.61%**.
5. Customers with **6–20 seats** have the highest churn rate at **25.0%**.
6. The top churn reason is **features**, followed by **budget** and **support**.
7. Retention strategy should be segmented by plan tier, acquisition source and industry.

## Revenue-at-Risk Analysis

### 8. Total Revenue by Churn Status

![Total Revenue by Churn Status](reports/screenshots/08_total_revenue_by_churn_status.png)

Churned subscriptions represent **$1,179,139 in monthly revenue at risk** and **$14,149,668 in annual revenue at risk**.

This shows that churn is not only a customer retention issue, but also a significant recurring revenue risk.

### 9. Revenue-at-Risk Summary

![Revenue-at-Risk Summary](reports/screenshots/09_revenue_at_risk_summary.png)

The total revenue-at-risk from churned subscription records is:

| Metric                                     |       Value |
| ------------------------------------------ | ----------: |
| Accounts with Churned Subscription Records |         312 |
| Monthly Revenue at Risk                    |  $1,179,139 |
| Annual Revenue at Risk                     | $14,149,668 |

This highlights the financial impact of churn and provides a clear business case for retention initiatives.

### 10. Revenue-at-Risk by Plan Tier

![Revenue-at-Risk by Plan Tier](reports/screenshots/10_revenue_at_risk_by_plan_tier.png)

| Plan Tier  | Churned Accounts | Monthly Revenue at Risk | Annual Revenue at Risk |
| ---------- | ---------------: | ----------------------: | ---------------------: |
| Enterprise |              146 |                $926,345 |            $11,116,140 |
| Pro        |              141 |                $180,271 |             $2,163,252 |
| Basic      |              132 |                 $72,523 |               $870,276 |

The **Enterprise** segment contributes the largest revenue risk, with over **$11.1 million ARR at risk**.

Although churn rates were similar across plans, Enterprise churn has a much larger revenue impact because Enterprise customers generate higher recurring revenue.

### 11. Revenue-at-Risk by Industry

![Revenue-at-Risk by Industry](reports/screenshots/11_revenue_at_risk_by_industry.png)

| Industry      | Churned Accounts | Monthly Revenue at Risk | Annual Revenue at Risk |
| ------------- | ---------------: | ----------------------: | ---------------------: |
| Cybersecurity |               65 |                $279,062 |             $3,348,744 |
| FinTech       |               55 |                $253,446 |             $3,041,352 |
| DevTools      |               80 |                $238,611 |             $2,863,332 |
| HealthTech    |               68 |                $209,277 |             $2,511,324 |
| EdTech        |               44 |                $198,743 |             $2,384,916 |

The **Cybersecurity** segment has the highest annual revenue at risk at **$3.35 million**, even though DevTools had the highest churn rate.

This shows why churn rate and revenue impact must be analysed together. A segment may not have the highest churn percentage, but it can still create the largest financial loss.

### 12. Revenue-at-Risk by Referral Source

![Revenue-at-Risk by Referral Source](reports/screenshots/12_revenue_at_risk_by_referral_source.png)

| Referral Source | Churned Accounts | Monthly Revenue at Risk | Annual Revenue at Risk |
| --------------- | ---------------: | ----------------------: | ---------------------: |
| Other           |               65 |                $273,644 |             $3,283,728 |
| Organic         |               78 |                $265,637 |             $3,187,644 |
| Event           |               58 |                $260,954 |             $3,131,448 |
| Ads             |               61 |                $194,077 |             $2,328,924 |
| Partner         |               50 |                $184,827 |             $2,217,924 |

The **Other**, **Organic** and **Event** referral sources create the largest revenue-at-risk exposure.

Event-acquired customers also showed the highest churn rate, so this channel should be reviewed carefully for customer fit, onboarding quality and expectation-setting.

### 13. Average Revenue by Plan and Churn Status

![Average Revenue by Plan and Churn Status](reports/screenshots/13_average_revenue_by_plan_and_churn_status.png)

Enterprise churned subscriptions have a higher average MRR than active Enterprise subscriptions.

This suggests that some high-value Enterprise customers are churning, making Enterprise retention a priority for revenue protection.

### 14. High-Value Churned Accounts

![High-Value Churned Accounts](reports/screenshots/14_high_value_churned_accounts.png)

The highest-value churned account lost **$623,268 ARR**, and all top 10 high-value churned accounts are from the Enterprise plan.

This supports a targeted retention strategy focused on high-value Enterprise accounts before churn occurs.

## Revenue-at-Risk Key Insights

1. Churned subscriptions represent **$1.18 million MRR** and **$14.15 million ARR** at risk.
2. Enterprise customers create the largest financial risk, with **$11.12 million ARR at risk**.
3. Cybersecurity has the highest industry-level ARR risk at **$3.35 million**.
4. Event-acquired customers show both high churn rate and high revenue exposure.
5. High-value churned accounts are concentrated in the Enterprise plan.

## Python Analysis

Python was used to extend the SQL analysis by creating account-level and subscription-level analytical datasets. The Python analysis focused on product usage, support experience and churn-related behaviour.

File used:

```text
python/01_churn_usage_support_analysis.ipynb
```

Python outputs saved:

```text
reports/python_charts
reports/python_insights_summary.csv
```

### 15. Customer Count by Churn Status

![Customer Count by Churn Status](reports/python_charts/01_customer_count_by_churn_status.png)

The Python analysis confirms the account-level churn split:

* Active accounts: 390
* Churned accounts: 110
* Overall churn rate: 22.0%

This validates the SQL churn calculation and provides a visual summary of the customer base.

The Python chart confirms that **DevTools** customers have the highest churn rate at **30.97%**.

This segment should be reviewed further because it shows a materially higher churn rate than the overall customer base.

The Python analysis confirms that **event-acquired customers** have the highest churn rate at **30.21%**.

This suggests that customers acquired through events may require better qualification, onboarding and expectation-setting.

Feature usage levels are very similar between active and churned subscriptions.

| Metric                       |        Active |       Churned |
| ---------------------------- | ------------: | ------------: |
| Average Usage Count          |         50.56 |         49.29 |
| Average Usage Duration       | 3,040.11 secs | 3,032.42 secs |
| Average Errors               |          2.85 |          2.78 |
| Average Unique Features Used |          4.74 |          4.63 |
| Average Beta Feature Events  |          0.51 |          0.50 |

This suggests that churn is not strongly explained by low product usage alone. Customers appear to be using the product, but may still churn because of feature gaps, budget constraints, support issues or competitor alternatives.


Support experience is broadly similar between active and churned accounts.

| Metric                      |        Active |       Churned |
| --------------------------- | ------------: | ------------: |
| Average Tickets             |          4.02 |          3.93 |
| Average Resolution Time     |   35.89 hours |   34.84 hours |
| Average First Response Time | 88.20 minutes | 83.38 minutes |
| Average Satisfaction Score  |          3.69 |          3.71 |
| Average Escalations         |          0.18 |          0.22 |

The main difference is that churned accounts show slightly higher escalations. This suggests that complex or unresolved support issues may matter more than total ticket volume.

## Python Key Insights

1. Python analysis confirms the overall **22.0% churn rate**.
2. **DevTools** remains the highest-risk industry segment.
3. **Event-acquired customers** remain the highest-risk acquisition source.
4. Product usage is similar between active and churned subscriptions, so churn is not explained by low usage alone.
5. Support experience is broadly similar, but churned accounts show slightly higher escalations.
6. Churn is likely driven by a combination of feature fit, customer expectations, support complexity and revenue risk.


## Business Recommendations

### 1. Improve feature fit for DevTools customers

DevTools customers have the highest churn rate. RavenStack should analyse feature usage patterns for this segment, identify product gaps and prioritise improvements for technical users.

### 2. Strengthen onboarding for event-acquired customers

Event-acquired customers churn at the highest rate and show high revenue exposure. RavenStack should improve qualification, onboarding and expectation-setting for customers acquired through events.

### 3. Prioritise Enterprise retention

Enterprise customers create the largest revenue risk, with over **$11.1 million ARR at risk**. RavenStack should monitor high-MRR accounts and build early-warning indicators before renewal periods.

### 4. Build a targeted retention plan for 6–20 seat customers

The 6–20 seat segment has the highest churn rate by seat size. This group may need better onboarding, clearer team adoption support and stronger value communication.

### 5. Monitor support escalations

Support volume and response time are similar across active and churned accounts, but churned accounts show slightly higher escalations. RavenStack should create escalation-risk flags for customer success teams.

## Repository Structure

```text
SaaS Customer Churn Revenue Risk Analysis
│
├── data_raw
│   ├── README.md
│   ├── ravenstack_accounts.csv
│   ├── ravenstack_subscriptions.csv
│   ├── ravenstack_feature_usage.csv
│   ├── ravenstack_support_tickets.csv
│   └── ravenstack_churn_events.csv
│
├── data_cleaned
│   ├── account_analysis.csv
│   ├── usage_analysis.csv
│   ├── support_analysis.csv
│   ├── python_insights_summary.csv
│   └── subscription_revenue_analysis.csv
│
├── database
│   └── ravenstack.db
│
├── sql
│   ├── 01_create_tables.sql
│   ├── 02_data_quality_checks.sql
│   ├── 03_churn_analysis.sql
│   └── 04_revenue_risk_analysis.sql
│
├── python
│   ├── load_data_to_sqlite.py
│   └── 01_churn_usage_support_analysis.ipynb
│
|
│
├── reports
│   |
│   |
│   |
│   ├── screenshots
│   │   ├── 01_overall_churn_rate.png
│   │   ├── 02_churn_by_plan_tier.png
│   │   ├── 03_churn_by_industry.png
│   │   ├── 04_churn_by_referral_source.png
│   │   ├── 05_churn_by_seat_size_group.png
│   │   ├── 06_top_churn_reasons.png
│   │   ├── 07_churn_reasons_by_plan_tier.png
│   │   ├── 08_total_revenue_by_churn_status.png
│   │   ├── 09_revenue_at_risk_summary.png
│   │   ├── 10_revenue_at_risk_by_plan_tier.png
│   │   ├── 11_revenue_at_risk_by_industry.png
│   │   ├── 12_revenue_at_risk_by_referral_source.png
│   │   ├── 13_average_revenue_by_plan_and_churn_status.png
│   │   └── 14_high_value_churned_accounts.png
│   │
│   |
│
└── README.md
```

## Final CV-Ready Project Description

**SaaS Customer Churn & Revenue-at-Risk Analysis | SQL, Python, GitHub**

* Built an end-to-end SaaS churn and revenue-at-risk analysis project using **SQL, SQLite, Python and Power BI** to identify high-risk customer segments and recurring revenue exposure.
* Loaded, cleaned and analysed **500 accounts**, **5,000 subscriptions**, **25,000 feature usage records**, **2,000 support tickets** and **600 churn events** from a multi-table relational dataset.
* Identified a **22.0% overall churn rate**, with the highest churn among **DevTools customers**, **event-acquired customers** and **6–20 seat accounts**.
* Quantified **$1.18M monthly revenue at risk** and **$14.15M annual revenue at risk**, with Enterprise customers contributing the largest financial exposure.
* Translated findings into business recommendations focused on onboarding, feature fit, support escalation monitoring and Enterprise customer retention.

## Dataset Credit

This project uses the RavenStack synthetic SaaS dataset created by **River @ Rivalytics**. The dataset is fully synthetic and used for educational and portfolio purposes.

