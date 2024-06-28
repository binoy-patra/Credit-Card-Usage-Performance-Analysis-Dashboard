-- SQL Query to create and import data from csv files:
-- 0. Create a database 
CREATE DATABASE ccdb;

-- 1. Create cc_detail table
CREATE TABLE ccdb.cc_detail (
    Client_Num INT,
    Card_Category VARCHAR(20),
    Annual_Fees INT,
    Activation_30_Days INT,
    Customer_Acq_Cost INT,
    Week_Start_Date DATE,
    Week_Num VARCHAR(20),
    Qtr VARCHAR(10),
    current_year INT,
    Credit_Limit DECIMAL(10,2),
    Total_Revolving_Bal INT,
    Total_Trans_Amt INT,
    Total_Trans_Ct INT,
    Avg_Utilization_Ratio DECIMAL(10,3),
    Use_Chip VARCHAR(10),
    Exp_Type VARCHAR(50),
    Interest_Earned DECIMAL(10,3),
    Delinquent_Acc VARCHAR(5)
);

-- 1.1 Temp Table Create cc_detail table
CREATE TABLE ccdb.cc_detail_temp (
    Client_Num INT,
    Card_Category VARCHAR(20),
    Annual_Fees INT,
    Activation_30_Days INT,
    Customer_Acq_Cost INT,
    Week_Start_Date varchar(255),
    Week_Num VARCHAR(20),
    Qtr VARCHAR(10),
    current_year INT,
    Credit_Limit DECIMAL(10,2),
    Total_Revolving_Bal INT,
    Total_Trans_Amt INT,
    Total_Trans_Ct INT,
    Avg_Utilization_Ratio DECIMAL(10,3),
    Use_Chip VARCHAR(10),
    Exp_Type VARCHAR(50),
    Interest_Earned DECIMAL(10,3),
    Delinquent_Acc VARCHAR(5)
);

-- 2. Create cc_detail table
CREATE TABLE ccdb.cust_detail (
    Client_Num INT,
    Customer_Age INT,
    Gender VARCHAR(5),
    Dependent_Count INT,
    Education_Level VARCHAR(50),
    Marital_Status VARCHAR(20),
    State_cd VARCHAR(50),
    Zipcode VARCHAR(20),
    Car_Owner VARCHAR(5),
    House_Owner VARCHAR(5),
    Personal_Loan VARCHAR(5),
    Contact VARCHAR(50),
    Customer_Job VARCHAR(50),
    Income INT,
    Cust_Satisfaction_Score INT
);

-- 2.1. Create cc_detail table
CREATE TABLE ccdb.cust_detail_temp (
    Client_Num INT,
    Customer_Age INT,
    Gender VARCHAR(5),
    Dependent_Count INT,
    Education_Level VARCHAR(50),
    Marital_Status VARCHAR(20),
    State_cd VARCHAR(50),
    Zipcode VARCHAR(20),
    Car_Owner VARCHAR(5),
    House_Owner VARCHAR(5),
    Personal_Loan VARCHAR(5),
    Contact VARCHAR(50),
    Customer_Job VARCHAR(50),
    Income INT,
    Cust_Satisfaction_Score INT
);

-- 3. Copy csv data into SQL 
-- copy cc_detail table

set global local_infile=1;
set global sql_mode='';
show variables like 'secure_file_priv'; 

load data infile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\credit_card.csv' 
into table ccdb.cc_detail_temp 
fields terminated by ',' 
enclosed by '"' 
lines terminated by '\n'
ignore 1 rows;

-- copy cust_detail table
load data infile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\customer.csv'
into table ccdb.cust_detail
fields terminated by ',' 
enclosed by '"' 
lines terminated by '\n'
ignore 1 rows;

-- Craeting temp table and the final table 
insert into ccdb.cc_detail
select 
    Client_Num, Card_Category ,Annual_Fees, Activation_30_Days, Customer_Acq_Cost,
    STR_TO_DATE(Week_Start_Date,'%d-%m-%Y') AS Week_Start_Date,
    Week_Num , Qtr, current_year, Credit_Limit, Total_Revolving_Bal, Total_Trans_Amt, Total_Trans_Ct, Avg_Utilization_Ratio,
    Use_Chip, Exp_Type, Interest_Earned, Delinquent_Acc
FROM ccdb.cc_detail_temp
where     STR_TO_DATE(Week_Start_Date,'%d-%m-%Y') is not null;

-- Truncate 
Truncate table ccdb.cc_detail_temp;

-- 4. Insert additional data into SQL, using same COPY function
-- copy additional data to Temp Table 
load data infile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\cc_add.csv' 
into table ccdb.cc_detail_temp 
fields terminated by ',' 
enclosed by '"' 
lines terminated by '\n'
ignore 1 rows;

-- copy cust_detail table to Temp Table 
load data infile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\cust_add.csv'
into table ccdb.cust_detail_temp
fields terminated by ',' 
enclosed by '"' 
lines terminated by '\n'
ignore 1 rows;

-- Inserting Addtional Data (From Temp to Main) 
insert into ccdb.cc_detail
select 
    Client_Num, Card_Category ,Annual_Fees, Activation_30_Days, Customer_Acq_Cost,
    STR_TO_DATE(Week_Start_Date,'%d-%m-%Y') AS Week_Start_Date,
    Week_Num , Qtr, current_year, Credit_Limit, Total_Revolving_Bal, Total_Trans_Amt, Total_Trans_Ct, Avg_Utilization_Ratio,
    Use_Chip, Exp_Type, Interest_Earned, Delinquent_Acc
FROM ccdb.cc_detail_temp
where     STR_TO_DATE(Week_Start_Date,'%d-%m-%Y') is not null;

Insert into ccdb.cust_detail 
select * from ccdb.cust_detail_temp;

-- Truncate the temp table 
Truncate table ccdb.cust_detail_temp;
Truncate table ccdb.cc_detail_temp;
