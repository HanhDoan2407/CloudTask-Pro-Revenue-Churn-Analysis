# CloudTask-Pro-Revenue-Churn-Analysis
CloudTask Pro is a SaaS company that has grown from 0 to 600 customers since 2022. While revenue has been growing, the board has raised concerns about a high churn rate. The CFO wants to understand the monthly churn trends, which customer segments are most at risk, and what the company’s unit economics look like (MRR per customer, customer acquisition cost vs. lifetime value). You have access to a subscription-level dataset with customer details, plan info, and churn status, as well as a monthly revenue summary.
# Questions to answer
- What is the overall churn rate, and how has the monthly churn rate trended over the past 4 years? Is churn improving or getting worse?
- Which subscription plan (Starter, Professional, Business, Enterprise) has the highest churn rate? Does billing cycle (monthly vs. annual) significantly impact retention?
- What are the top 3 reasons customers churn, and do these reasons differ by plan type or company size?
- What is the average Customer Lifetime Value (CLV) by plan? How does this compare to Customer Acquisition Cost (CAC), and which plans are the most and least profitable?
# Tech Stack
- SQL
- Excel
- Power BI
# Overall churn rate
Q1: The 𝗼𝘃𝗲𝗿𝗮𝗹𝗹 𝗰𝗵𝘂𝗿𝗻 𝗿𝗮𝘁𝗲 𝗶𝘀 𝟱𝟮.𝟭𝟳 𝗽𝗲𝗿𝗰𝗲𝗻𝘁. Out of 600 clients, 313 have departed. This means CloudTask Pro is working twice as hard to stay in the same spot, since for every customer it acquires, it loses one existing one.

Average churn rate is 4.57 % across 48 months.
Is churn improving or getting worse? Monthly churn increased from 0% in January 2022 to 1.42% in December 2025, suggesting that retention has deteriorated despite customer and revenue growth.

# Q2: Which plan has the highest churn?
Starter customers have the highest churn rate at 70.51%, followed by Professional at 47.98%, Business at 41.25%, and Enterprise at 22.00%.

Key finding: Starter customers are the highest-risk segment, with a churn rate more than three times that of Enterprise customers. This suggests that CloudTask Pro should prioritize retention strategies for Starter customers, while investigating what factors contribute to the stronger retention of Enterprise customers.

Does billing cycle affect retention?
| Billing Cycle | Customers | Churned Customers | Churn Rate |
|---|---:|---:|---:|
| Monthly | 352 | 213 | 60.51% |
| Annual | 248 | 100 | 40.32% |

Billing cycle has a significant association with customer retention. Monthly-billed customers have a churn rate of 60.51%, compared with 40.32% for annual-billed customers—a difference of 20.19 percentage points. This suggests that annual billing is associated with stronger customer retention, while monthly subscribers represent a higher-risk churn segment.

### Churn Rate by Plan and Billing Cycle

| Plan | Monthly Churn Rate | Annual Churn Rate | Difference (pp) |
|---|---:|---:|---:|
| Business | 52.87% | 27.40% | **25.48** |
| Professional | 57.58% | 35.14% | **22.44** |
| Starter | 76.87% | 60.24% | **16.62** |
| Enterprise | 21.88% | 22.22% | **-0.35** |

**Key insight:** Annual billing is associated with lower churn for Business, Professional, and Starter customers. The largest difference is observed for Business customers, whose annual churn rate is **25.48 percentage points lower** than monthly customers. Enterprise customers show virtually no difference, with annual churn being slightly higher by **0.35 percentage points**.

### What are the top 3 reasons customers churn, and do these reasons differ by plan type or company size?
[Visualization]
Finding: Budget Cuts is the most common churn reason, affecting 53 customers, followed by Price Too High (51) and Company Closed (48). This indicates that financial pressure and cost-related factors are major contributors to overall customer churn.
### Churn Reasons by Plan

[Visualization]

**Key Finding:** Churn drivers vary considerably by subscription plan. Business customers are primarily affected by missing features and support issues, while Professional and Starter customers show greater sensitivity to pricing and budget constraints. Enterprise churn is more strongly associated with company closure and changing customer needs. These differences suggest that retention strategies should be tailored to each customer segment rather than applying a single approach across all plans.

### Churn reasons by company size
Visualization

Finding: Churn drivers vary by company size. Budget Cuts is the leading churn reason among most segments, particularly for companies with 201–500 employees (23.40%) and 1–10 employees (22.47%). In contrast, companies with 11–50 employees are most likely to churn because the service is No Longer Needed (18.28%), while Poor Support is the leading reason among the largest companies (500+, 20.83%). This suggests that retention strategies should consider company size, with cost-related concerns being particularly important for smaller and mid-sized customers and support quality becoming more important for larger customers.

# Question 4: Customer Lifetime Value
## Unit Economics: CLV vs. CAC

Customer Lifetime Value (CLV) was estimated using:

**CLV = Average MRR per Customer × Average Customer Lifetime**

The analysis shows substantial differences in customer value across subscription plans.

| Plan         |  Avg. MRR | Avg. Lifetime (months) |  Estimated CLV |
| ------------ | --------: | ---------------------: | -------------: |
| Enterprise   | $2,984.99 |                  14.36 | **$42,875.35** |
| Business     | $1,303.64 |                  14.18 | **$18,487.93** |
| Professional |   $497.04 |                  10.24 |  **$5,090.18** |
| Starter      |   $215.54 |                   6.22 |  **$1,339.75** |

Enterprise customers generate the highest estimated CLV at **$42,875.35**, while Starter customers have the lowest at **$1,339.75**. The difference is driven by both higher average monthly revenue and longer customer lifetimes among higher-tier plans.

### CLV-to-CAC Analysis

The average Customer Acquisition Cost (CAC) across the available monthly data is **$200.04**. Since the dataset does not provide CAC by individual plan, the same average CAC is used as a benchmark for each plan.

| Plan         | Estimated CLV | Avg. CAC | CLV/CAC Ratio |
| ------------ | ------------: | -------: | ------------: |
| Enterprise   |    $42,875.35 |  $200.04 |   **214.33x** |
| Business     |    $18,487.93 |  $200.04 |    **92.42x** |
| Professional |     $5,090.18 |  $200.04 |    **25.45x** |
| Starter      |     $1,339.75 |  $200.04 |     **6.70x** |

### Key Insight

Enterprise customers demonstrate the strongest unit economics, with an estimated **CLV/CAC ratio of 214.33x**, followed by Business at **92.42x**. Professional customers generate a **25.45x** ratio, while Starter has the lowest ratio at **6.70x**.

This suggests that higher-tier customers provide substantially greater customer value relative to the company's average acquisition cost. Starter customers remain economically attractive based on this simplified CLV/CAC measure, but their lower lifetime value and higher churn rate indicate that they represent the weakest-performing segment among the four plans.

**Business implication:** CloudTask Pro should prioritize retention and acquisition strategies for higher-value Business and Enterprise customers while investigating ways to improve retention and customer lifetime among Starter and Professional customers.

**Note:** CLV is an estimate based on average MRR and observed customer lifetime. CAC is available only as a company-level monthly metric, so the same average CAC is used as a benchmark across plans. Therefore, the CLV/CAC ratios should be interpreted as indicative unit-economics benchmarks rather than plan-specific profitability measures.


