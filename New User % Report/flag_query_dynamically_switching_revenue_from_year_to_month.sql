with temp as(
  SELECT t1.Date, 
         t1.Brand, 
         t1.Publisher, 
         t1.Publisher_Group,
         t1.item_revenue as Current_Year_Revenue,
         t2.Date AS Previous_Year_Date,
         t2.item_revenue AS Previous_Year_Revenue,
  FROM `ltpautomatedpublisherscorecard.ga_traffic.merged_data` t1
  LEFT JOIN `ltpautomatedpublisherscorecard.ga_traffic.merged_data` t2
  ON t1.Brand = t2.Brand AND t1.Publisher = t2.Publisher AND t1.Publisher_Group = t2.Publisher_Group AND DATE_SUB(t1.Date, INTERVAL 1 YEAR) = t2.Date
)
SELECT t3.Brand, 
       t3.Publisher, 
       t3.Publisher_Group,
       t3.Date,
       t3.Current_Year_Revenue,
       t3.Previous_Year_Date,
       t3.Previous_Year_Revenue,
       t3.Date as Current_Month_Date,
       t3.Current_Year_Revenue as Current_Month_Revenue,
       t4.Date as Previous_Month_Date,
       t4.item_revenue as Previous_Month_Revenue,
       IF(t3.Previous_Year_Revenue < 0.0000001 OR t3.Previous_Year_Revenue IS NULL, 0, 1) AS Flag,
       IF(t3.Previous_Year_Revenue < 0.0000001 OR t3.Previous_Year_Revenue IS NULL, 'Month', 'Year') AS Flag_Period,
       IF(t3.Previous_Year_Revenue < 0.0000001 OR t3.Previous_Year_Revenue IS NULL, t4.item_revenue, t3.Previous_Year_Revenue) AS Final_Revenue
from temp t3
LEFT JOIN `ltpautomatedpublisherscorecard.ga_traffic.merged_data` t4
ON t3.Brand = t4.Brand
AND t3.Publisher = t4.Publisher
AND t3.Publisher_Group = t4.Publisher_Group
AND DATE_SUB(t3.Date, INTERVAL 1 MONTH) = t4.Date
