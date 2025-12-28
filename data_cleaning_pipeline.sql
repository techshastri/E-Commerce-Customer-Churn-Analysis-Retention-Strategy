DROP TABLE IF EXISTS churn_staging;

CREATE TABLE churn_staging (
    CustomerID VARCHAR(255),       -- Changed to VARCHAR to avoid header errors
	Churn VARCHAR(255),             -- Changed to VARCHAR
    Tenure VARCHAR(255),           -- Changed to VARCHAR to handle "NA" or blanks
    PreferredLoginDevice VARCHAR(255),
    CityTier VARCHAR(255),
    WarehouseToHome VARCHAR(255),
    PreferredPaymentMode VARCHAR(255),
    Gender VARCHAR(255),
    HourSpendOnApp VARCHAR(255),
    NumberOfDeviceRegistered VARCHAR(255),
    PreferedOrderCat VARCHAR(255),
    SatisfactionScore VARCHAR(255),
    MaritalStatus VARCHAR(255),
    NumberOfAddress VARCHAR(255),
    Complain VARCHAR(255),
    OrderAmountHikeFromlastYear VARCHAR(255),
    CouponUsed VARCHAR(255),
    OrderCount VARCHAR(255),
    DaySinceLastOrder VARCHAR(255),
    CashbackAmount VARCHAR(255)
);
COPY churn_staging (CustomerID,Churn,Tenure,PreferredLoginDevice,CityTier,WarehouseToHome,PreferredPaymentMode,Gender,
HourSpendOnApp,NumberOfDeviceRegistered,PreferedOrderCat,SatisfactionScore,MaritalStatus,NumberOfAddress,Complain,
OrderAmountHikeFromlastYear,CouponUsed,OrderCount,DaySinceLastOrder,CashbackAmount
)
FROM 'E-Commerce Customer Data.csv'
DELIMITER ','
CSV HEADER;


SELECT * FROM churn_staging;


DROP TABLE IF EXISTS clean_churn_data;

CREATE TABLE clean_churn_data AS
SELECT
    -- 1. IDs
    CAST(CustomerID AS INTEGER) AS CustomerID,
    
    -- 2. Target Variable
    CAST(COALESCE(NULLIF(Churn, ''), '0') AS INTEGER) AS Churn,
    
    -- 3. Key Numeric Metrics (Cleaning Text -> Number)
    CAST(COALESCE(NULLIF(Tenure, ''), '0') AS FLOAT) AS Tenure,
    CAST(COALESCE(NULLIF(NumberOfAddress, ''), '0') AS INTEGER) AS NumberOfAddress,
    CAST(COALESCE(NULLIF(OrderCount, ''), '0') AS NUMERIC) AS OrderCount,
    CAST(COALESCE(NULLIF(WarehouseToHome, ''), '0') AS NUMERIC) AS WarehouseToHome,
    CAST(COALESCE(NULLIF(DaySinceLastOrder, ''), '0') AS NUMERIC) AS DaySinceLastOrder,
    CAST(COALESCE(NULLIF(OrderAmountHikeFromlastYear, ''), '0') AS NUMERIC) AS OrderAmountHikeFromlastYear,
    CAST(COALESCE(NULLIF(CouponUsed, ''), '0') AS NUMERIC) AS CouponUsed,
	CAST(COALESCE(NULLIF(CashbackAmount, ''), '0') AS NUMERIC) AS CashbackAmount,
	-- 4. Categorical Variables (Text Cleaning)
    -- Standardizing 'Phone' to 'Mobile Phone'
    CASE 
        WHEN PreferredLoginDevice IN ('Phone', 'Mobile') 
		THEN 'Mobile Phone'
        ELSE PreferredLoginDevice 
    END AS PreferredLoginDevice,
	CASE 
        WHEN PreferredPaymentMode IN ('CC', 'Credit Card') 
        THEN 'Credit Card'
		WHEN PreferredPaymentMode IN ('COD', 'Cash On Delivery', 'Cash on Delivery') 
        THEN 'Cash On Delivery'
        ELSE PreferredPaymentMode 
    END AS PreferredPaymentMode,
    
    Gender,
	CAST(COALESCE(NULLIF(HourSpendOnApp, ''), '0') AS NUMERIC) AS HourSpendOnApp,
    CAST(COALESCE(NULLIF(NumberOfDeviceRegistered, ''), '0') AS INTEGER) AS NumberOfDeviceRegistered,
    CASE 
        WHEN PreferedOrderCat IN ('Phone', 'Mobile') 
		THEN 'Mobile Phone'
        ELSE PreferedOrderCat 
    END AS PreferedOrderCat,
	SatisfactionScore,
	CityTier, -- Keep as text
    MaritalStatus,

    -- 5. Delivery Status 
    CASE 
        WHEN CAST(COALESCE(NULLIF(DaySinceLastOrder, ''), '0') AS NUMERIC) > 10 THEN 'Late'
        ELSE 'On-Time' 
    END AS Delivery_Status

FROM churn_staging;

SELECT * FROM clean_churn_data;