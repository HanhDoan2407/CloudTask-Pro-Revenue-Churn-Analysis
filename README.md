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
