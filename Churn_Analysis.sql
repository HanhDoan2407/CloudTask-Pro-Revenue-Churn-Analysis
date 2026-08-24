#-- data audit
USE `cloudtask-pro-revenue-churn-analysis` ;
SELECT *
FROM subscriptions
LIMIT 10;
SELECT *
FROM monthly_revenue
LIMIT 10;
SELECT COUNT(*) AS total_customers
FROM subscriptions;
SELECT 
	COUNT(*) AS total_rows,
	COUNT(DISTINCT customer_id) AS unique_customers
FROM subscriptions;
#Check the categorical variables
SELECT
	plan,
    COUNT(*) AS customers
FROM subscriptions
GROUP BY plan
ORDER BY customers DESC;
#billing_cycle
SELECT 
    billing_cycle,
    COUNT(*) AS customers
FROM subscriptions
GROUP BY billing_cycle
ORDER BY customers DESC;
#churn_status
SELECT 
    churned,
    COUNT(*) AS customers
FROM subscriptions
GROUP BY churned
ORDER BY customers DESC;
#churned_reason
SELECT 
    churn_reason,
    COUNT(*) AS customers
FROM subscriptions
GROUP BY churn_reason
ORDER BY customers DESC;
#Company size
SELECT 
    company_size,
    COUNT(*) AS customers
FROM subscriptions
GROUP BY company_size
ORDER BY customers DESC;

#Overall churn rate_What is the overall churn rate?
#Overall churn rate = churned customers / total customers
SELECT
	COUNT(*) AS total_customers,
    SUM(CASE WHEN churned = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(100* SUM(CASE WHEN churned = 'Yes' THEN 1 ELSE 0 END)/ COUNT(*), 2) AS overall_churn_rate_pct
FROM subscriptions;

# Monthly churn trend
SELECT
    ROUND(AVG(monthly_churn_rate_pct), 2) AS avg_monthly_churn_rate
FROM monthly_revenue;
#Is churn improving or getting worse?
SELECT *
FROM monthly_revenue
WHERE month IN (
    (SELECT MIN(month) FROM monthly_revenue),
    (SELECT MAX(month) FROM monthly_revenue)
);

# Which plan has the highest churn?
SELECT
	plan,
    SUM(CASE WHEN churned = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND( 100 * (SUM(CASE WHEN churned = 'Yes' THEN 1 ELSE 0 END) / COUNT(*)), 2) AS churn_rate_pct
FROM subscriptions
GROUP BY plan
ORDER BY churn_rate_pct DESC;

# Does billing cycle affect retention?
SELECT
    billing_cycle,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN churned = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        100.0 * SUM(CASE WHEN churned = 'Yes' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS churn_rate_pct
FROM subscriptions
GROUP BY billing_cycle
ORDER BY churn_rate_pct DESC;

#Does annual billing reduce churn consistently across all plans?
SELECT
    plan,
    billing_cycle,
    different_in_percentage_point,
    COUNT(*) AS customers,
    SUM(CASE WHEN churned = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        100.0 * SUM(CASE WHEN churned = 'Yes' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS churn_rate_pct
FROM subscriptions
GROUP BY
    plan,
    billing_cycle
ORDER BY
    plan,
    churn_rate_pct DESC;
# difference in churn rate between monthly and annual billing for each plan
#Monthly churn − Annual churn, positive numbers means annual has lower churn
SELECT
    plan,
    ROUND(
        100.0 * SUM(CASE WHEN billing_cycle = 'Monthly' AND churned = 'Yes' THEN 1 ELSE 0 END)
        / SUM(CASE WHEN billing_cycle = 'Monthly' THEN 1 ELSE 0 END),
        2
    ) AS monthly_churn_rate,
    
    ROUND(
        100.0 * SUM(CASE WHEN billing_cycle = 'Annual' AND churned = 'Yes' THEN 1 ELSE 0 END)
        / SUM(CASE WHEN billing_cycle = 'Annual' THEN 1 ELSE 0 END),
        2
    ) AS annual_churn_rate,

    ROUND(
        (
            100.0 * SUM(CASE WHEN billing_cycle = 'Monthly' AND churned = 'Yes' THEN 1 ELSE 0 END)
            / SUM(CASE WHEN billing_cycle = 'Monthly' THEN 1 ELSE 0 END)
        )
        -
        (
            100.0 * SUM(CASE WHEN billing_cycle = 'Annual' AND churned = 'Yes' THEN 1 ELSE 0 END)
            / SUM(CASE WHEN billing_cycle = 'Annual' THEN 1 ELSE 0 END)
        ),
        2
    ) AS difference_percentage_points

FROM subscriptions
GROUP BY plan
ORDER BY difference_percentage_points DESC;

## Top 3 reasons that customer churns
SELECT
    churn_reason,
    COUNT(*) AS churned_customers
FROM subscriptions
WHERE churned = 'Yes'
GROUP BY churn_reason
ORDER BY churned_customers DESC
LIMIT 3;
## do reasons differ by plan?
WITH churn_reasons AS (
    SELECT
        plan,
        churn_reason,
        COUNT(*) AS churn_count
    FROM subscriptions
    WHERE churned = 'Yes'
      AND churn_reason IS NOT NULL
    GROUP BY plan, churn_reason
),
ranked_reasons AS (
    SELECT
        plan,
        churn_reason,
        churn_count,
        ROUND(
            100.0 * churn_count /
            SUM(churn_count) OVER (PARTITION BY plan),
            2
        ) AS percentage,
        ROW_NUMBER() OVER (
            PARTITION BY plan
            ORDER BY churn_count DESC
        ) AS reason_rank
    FROM churn_reasons
)
SELECT
    plan,
    churn_reason,
    churn_count,
    percentage
FROM ranked_reasons
WHERE reason_rank <= 3
ORDER BY plan, reason_rank;

## does reason differ by company size?
SELECT
    company_size,
    churn_reason,
    COUNT(*) AS churned_customers,
    ROUND(
        100.0 * COUNT(*) /
        SUM(COUNT(*)) OVER (PARTITION BY company_size),
        2
    ) AS pct_of_size_churn
FROM subscriptions
WHERE churned = 'Yes'
GROUP BY
    company_size,
    churn_reason
ORDER BY
    company_size,
    pct_of_size_churn DESC;

# Question 4: Customer Lifetime Value
# Calculate customer lifetime
SELECT
    customer_id,
    plan,
    monthly_revenue,
    signup_date,
    churn_date,
    churned,
    TIMESTAMPDIFF(
        MONTH,
        signup_date,
        COALESCE(churn_date, '2025-12-31')
    ) AS lifetime_months
FROM subscriptions;
# Calculate CLV by plan
WITH customer_lifetime AS (
    SELECT
        customer_id,
        plan,
        monthly_revenue,
        TIMESTAMPDIFF(
            MONTH,
            signup_date,
            COALESCE(churn_date, '2025-12-31')
        ) AS lifetime_months
    FROM subscriptions
)

SELECT
    plan,
    ROUND(AVG(monthly_revenue), 2) AS avg_mrr,
    ROUND(AVG(lifetime_months), 2) AS avg_lifetime_months,
    ROUND(
        AVG(monthly_revenue) * AVG(lifetime_months),
        2
    ) AS estimated_clv
FROM customer_lifetime
GROUP BY plan
ORDER BY estimated_clv DESC;
#inspect CAC
SELECT
    month,
    customer_acquisition_cost
FROM monthly_revenue
ORDER BY month;
SELECT
    ROUND(AVG(customer_acquisition_cost), 2) AS avg_cac
FROM monthly_revenue;
#Compare CLV vs CAC
WITH customer_lifetime AS (
    SELECT
        plan,
        monthly_revenue,
        TIMESTAMPDIFF(
            MONTH,
            signup_date,
            COALESCE(churn_date, '2025-12-31')
        ) AS lifetime_months
    FROM subscriptions
),

clv_by_plan AS (
    SELECT
        plan,
        AVG(monthly_revenue) AS avg_mrr,
        AVG(lifetime_months) AS avg_lifetime,
        AVG(monthly_revenue) * AVG(lifetime_months) AS clv
    FROM customer_lifetime
    GROUP BY plan
),

avg_cac AS (
    SELECT 
        AVG(customer_acquisition_cost) AS cac
    FROM monthly_revenue
)

SELECT
    c.plan,
    ROUND(c.avg_mrr, 2) AS avg_mrr,
    ROUND(c.avg_lifetime, 2) AS avg_lifetime_months,
    ROUND(c.clv, 2) AS clv,
    ROUND(a.cac, 2) AS cac,
    ROUND(c.clv / a.cac, 2) AS clv_cac_ratio
FROM clv_by_plan c
CROSS JOIN avg_cac a
ORDER BY clv_cac_ratio DESC;