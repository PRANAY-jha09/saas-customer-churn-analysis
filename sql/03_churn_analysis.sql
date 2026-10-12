---------------------- Revenue-at-Risk Analysis-------------------------------------------------------
----1. Total revenue by churn status------------------------------------------------------------------

SELECT
    a.churn_flag,
    COUNT(DISTINCT a.account_id) AS total_accounts,
    SUM(s.mrr_amount) AS total_monthly_revenue,
    SUM(s.arr_amount) AS total_annual_revenue
FROM public.saas_accounts AS a
JOIN public.saas_subscriptions AS s
    ON a.account_id = s.account_id
GROUP BY a.churn_flag
ORDER BY a.churn_flag;

-----Monthly and annual revenue at risk-----------

SELECT
    SUM(mrr_amount) AS monthly_revenue_at_risk,
    SUM(arr_amount) AS annual_revenue_at_risk,
    COUNT(DISTINCT account_id) AS churned_accounts
FROM public.saas_subscriptions
WHERE churn_flag = TRUE;
---Revenue at risk by plan tier-----------------
SELECT
    plan_tier,
    COUNT(DISTINCT account_id) AS churned_accounts,
    SUM(mrr_amount) AS monthly_revenue_at_risk,
    SUM(arr_amount) AS annual_revenue_at_risk
FROM public.saas_subscriptions
WHERE churn_flag = TRUE
GROUP BY plan_tier
ORDER BY monthly_revenue_at_risk DESC;


--Revenue at risk by industry

SELECT
    a.industry,
    COUNT(DISTINCT s.account_id) AS churned_accounts,
    SUM(s.mrr_amount) AS monthly_revenue_at_risk,
    SUM(s.arr_amount) AS annual_revenue_at_risk
FROM public.saas_accounts AS a
JOIN public.saas_subscriptions AS s
    ON a.account_id = s.account_id
WHERE s.churn_flag = TRUE
GROUP BY a.industry
ORDER BY monthly_revenue_at_risk DESC;

--Revenue at risk by referral source

SELECT
    a.referral_source,
    COUNT(DISTINCT s.account_id) AS churned_accounts,
    SUM(s.mrr_amount) AS monthly_revenue_at_risk,
    SUM(s.arr_amount) AS annual_revenue_at_risk
FROM public.saas_accounts AS a
JOIN public.saas_subscriptions AS s
    ON a.account_id = s.account_id
WHERE s.churn_flag = TRUE
GROUP BY a.referral_source
ORDER BY monthly_revenue_at_risk DESC;

--Average revenue by plan tier and churn status

SELECT
    plan_tier,
    churn_flag,
    COUNT(*) AS total_subscriptions,
    ROUND(AVG(mrr_amount), 2) AS average_monthly_revenue,
    ROUND(AVG(arr_amount), 2) AS average_annual_revenue
FROM public.saas_subscriptions
GROUP BY
    plan_tier,
    churn_flag
ORDER BY
    plan_tier,
    churn_flag;

--High-value churned accounts

SELECT
    a.account_id,
    a.account_name,
    a.industry,
    a.country,
    s.plan_tier,
    s.mrr_amount,
    s.arr_amount,
    s.seats
FROM public.saas_accounts AS a
JOIN public.saas_subscriptions AS s
    ON a.account_id = s.account_id
WHERE s.churn_flag = TRUE
ORDER BY s.arr_amount DESC NULLS LAST
LIMIT 20;
