-- MySQL Code
-- Objective 
-- 1. Customer Demographic 
-- 2. Customer Financial Behaviour
-- 3. Credit Card Usage Analysis
-- 4. Credit Card Performance Analysis
-- 5. Customer Satisfaction 


-- Customer Demographic 
-- Total Customer 
SELECT 
    COUNT(DISTINCT Client_Num) AS Total_Customer
FROM 
    ccdb.cust_detail;

-- Gender Distribution 
SELECT 
    Gender, COUNT(*) AS Count
FROM 
    ccdb.cust_detail
GROUP BY 
    Gender;

-- Education Lavel wise Distribution 
SELECT 
    Education_Level, COUNT(*) AS Count
FROM 
    ccdb.cust_detail
GROUP BY 
    Education_Level;

-- Dependent Count wise Distribution 
SELECT 
    Dependent_Count, COUNT(*) AS Count
FROM 
    ccdb.cust_detail
GROUP BY 
    Dependent_Count;

-- Marital Status wise Distribution 
SELECT 
    Marital_Status, COUNT(*) AS Count
FROM 
    ccdb.cust_detail
GROUP BY 
    Marital_Status;

-- Total Income
SELECT 
    SUM(Income) AS Total_Income
FROM 
    ccdb.cust_detail;

-- Personal Loan 
SELECT 
    Personal_Loan, COUNT(*) AS Count
FROM 
    ccdb.cust_detail
GROUP BY 
    Personal_Loan;

-- Car Ownership 
SELECT 
    Car_Owner, COUNT(*) AS Count
FROM 
    ccdb.cust_detail
GROUP BY 
    Car_Owner;

-- House Ownsership 
SELECT 
    House_Owner, COUNT(*) AS Count
FROM 
    ccdb.cust_detail
GROUP BY 
    House_Owner;

-- Total Revenue
SELECT 
    SUM(Total_Trans_Amt + Interest_Earned + Annual_Fees) AS Total_Revenue
FROM 
    ccdb.cc_detail;

-- Total Interest 
SELECT 
    SUM(Interest_Earned) AS Total_Interest
FROM 
    ccdb.cc_detail;

-- Total Transaction 
SELECT 
    SUM(Total_Trans_Ct) AS Total_Transaction
FROM 
    ccdb.cc_detail;

-- Total Transaction Amopunt 
SELECT 
    SUM(Total_Trans_Amt) AS Total_Transaction_Amount
FROM 
    ccdb.cc_detail;

-- Total State 
SELECT 
    COUNT(DISTINCT State_cd) AS Total_State
FROM 
    ccdb.cust_detail;

-- State wise Customer 
SELECT 
    State_cd, COUNT(*) AS Customer_Count
FROM 
    ccdb.cust_detail
GROUP BY 
    State_cd
ORDER BY 
    Customer_Count DESC Limit 5;

-- Average Satisfaction Score 
SELECT 
    AVG(Cust_Satisfaction_Score) AS Avg_Customer_Satisfaction_Rate
FROM 
    ccdb.cust_detail;

-- Income Group wise Distribution 
SELECT 
    CASE 
        WHEN cd.Income < 35000 THEN 'Low'
        WHEN cd.Income >= 35000 AND cd.Income < 70000 THEN 'Med'
        WHEN cd.Income >= 70000 THEN 'High'
        ELSE 'Unknown'
    END AS IncomeGroup,
    Count(Distinct cd.Client_Num) As Total_Customer,
	SUM(cc.Total_Trans_Ct) AS Total_Transaction,
    SUM(cc.Total_Trans_Amt) AS Total_Transaction_Amount,
    SUM(cc.Total_Trans_Amt + cc.Interest_Earned + cc.Annual_Fees) AS Total_Revenue, 
    Avg(Cust_Satisfaction_Score) as Average_Cust_Satisfaction_Score
FROM 
    ccdb.cust_detail cd
JOIN 
    ccdb.cc_detail cc ON cd.Client_Num = cc.Client_Num
GROUP BY 
    CASE 
        WHEN cd.Income < 35000 THEN 'Low'
        WHEN cd.Income >= 35000 AND cd.Income < 70000 THEN 'Med'
        WHEN cd.Income >= 70000 THEN 'High'
        ELSE 'Unknown'
    END;

-- Age Wise Distribution: 
SELECT 
    CASE 
        WHEN cd.Customer_Age < 30 THEN '20-30'
        WHEN cd.Customer_Age >= 30 AND cd.Customer_Age < 40 THEN '30-40'
        WHEN cd.Customer_Age >= 40 AND cd.Customer_Age < 50 THEN '40-50'
        WHEN cd.Customer_Age >= 50 AND cd.Customer_Age < 60 THEN '50-60'
        WHEN cd.Customer_Age >= 60 THEN '60+'
        ELSE 'Unknown'
    END AS AgeGroup,
    Count(Distinct cd.Client_Num) As Total_Customer,
	SUM(cc.Total_Trans_Ct) AS Total_Transaction,
    SUM(cc.Total_Trans_Amt) AS Total_Transaction_Amount,
    SUM(cc.Total_Trans_Amt + cc.Interest_Earned + cc.Annual_Fees) AS Total_Revenue, 
    Avg(Cust_Satisfaction_Score) as Average_Cust_Satisfaction_Score
FROM 
    ccdb.cust_detail cd
JOIN 
    ccdb.cc_detail cc ON cd.Client_Num = cc.Client_Num
GROUP BY 
    CASE 
        WHEN cd.Customer_Age < 30 THEN '20-30'
        WHEN cd.Customer_Age >= 30 AND cd.Customer_Age < 40 THEN '30-40'
        WHEN cd.Customer_Age >= 40 AND cd.Customer_Age < 50 THEN '40-50'
        WHEN cd.Customer_Age >= 50 AND cd.Customer_Age < 60 THEN '50-60'
        WHEN cd.Customer_Age >= 60 THEN '60+'
        ELSE 'Unknown'
    END;

-- Education Label Wise Distribution: 
SELECT 
    cd.Education_Level,
    COUNT(DISTINCT cd.Client_Num) AS Total_Customer,
    SUM(cc.Total_Trans_Ct) AS Total_Transaction,
    SUM(cc.Total_Trans_Amt) AS Total_Transaction_Amount,
    SUM(cc.Total_Trans_Amt + cc.Interest_Earned + cc.Annual_Fees) AS Total_Revenue,
    AVG(Cust_Satisfaction_Score) AS Average_Cust_Satisfaction_Score
FROM
    ccdb.cust_detail cd
        JOIN
    ccdb.cc_detail cc ON cd.Client_Num = cc.Client_Num
GROUP BY cd.Education_Level;

-- Gender and Marital Status Wise Distribution: 
SELECT 
	cd.Gender,
    cd.Marital_Status,
    COUNT(DISTINCT cd.Client_Num) AS Total_Customer,
    SUM(cc.Total_Trans_Ct) AS Total_Transaction,
    SUM(cc.Total_Trans_Amt) AS Total_Transaction_Amount,
    SUM(cc.Total_Trans_Amt + cc.Interest_Earned + cc.Annual_Fees) AS Total_Revenue,
    AVG(Cust_Satisfaction_Score) AS Average_Cust_Satisfaction_Score
FROM
    ccdb.cust_detail cd
        JOIN
    ccdb.cc_detail cc ON cd.Client_Num = cc.Client_Num
GROUP BY cd.Gender, cd.Marital_Status;

-- Credit Card Usage Analysis
SELECT 
    Card_Category,
    COUNT(*) AS Customer_Count,
    AVG(Credit_Limit) average_credit_limit,
    SUM(Total_Trans_Ct) AS Total_Transaction,
    SUM(Total_Trans_Amt) AS Total_Transaction_Amount,
    SUM(Total_Trans_Amt + Interest_Earned + Annual_Fees) AS Total_Revenue,
    ROUND(AVG(Avg_Utilization_Ratio), 2) AS Average_utilization_ratio
FROM
    ccdb.cc_detail
GROUP BY Card_Category
ORDER BY Total_Revenue DESC;

-- Credit Card Performance Analysis
SELECT 
    Card_Category,
    SUM(Customer_Acq_Cost) AS Total_Customer_Acq_Cost,
    SUM(Interest_Earned ) AS Total_interest_earned
FROM
    ccdb.cc_detail
GROUP BY Card_Category;

-- Expense Type wise Distribution 
SELECT 
    cc.Exp_Type,
    COUNT(DISTINCT cc.Client_Num) AS Used_Count,
    SUM(cc.Total_Trans_Ct) AS Total_Transaction,
    SUM(cc.Total_Trans_Amt) AS Total_Transaction_Amount,
	SUM(Interest_Earned) AS Total_Interest_Earned,
    SUM(cc.Total_Trans_Amt + cc.Interest_Earned + cc.Annual_Fees) AS Total_Revenue
FROM 
    ccdb.cc_detail cc
GROUP BY 
    Exp_Type
ORDER BY 
    Total_Revenue DESC;

-- Top 7 State 
SELECT 
    cd.State_cd, 
    COUNT(*) AS Customer_Count,
	SUM(cc.Total_Trans_Ct) AS Total_Transaction,
    SUM(cc.Total_Trans_Amt) AS Total_Transaction_Amount,
	SUM(Interest_Earned) AS Total_Interest_Earned,
    SUM(cc.Total_Trans_Amt + cc.Interest_Earned + cc.Annual_Fees) AS Total_Revenue
FROM 
    ccdb.cust_detail cd
           JOIN
    ccdb.cc_detail cc ON cd.Client_Num = cc.Client_Num
GROUP BY 
    State_cd
Order by Total_Revenue DESC limit 7;