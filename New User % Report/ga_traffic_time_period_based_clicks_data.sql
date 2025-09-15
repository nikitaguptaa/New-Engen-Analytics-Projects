with temp as(
  SELECT t1.Date, 
         t1.Brand, 
         t1.Publisher, 
         t1.Publisher_Group, 
         t1.mcf_first_inter_action_conversions as Current_Year_First_Conversions,
         t1.mcf_first_inter_action_value as Current_Year_First_Revenue,
         t1.mcf_last_inter_action_conversions as Current_Year_Last_Conversions,
         t1.mcf_last_inter_action_value as Current_Year_Last_Revenue,
         t2.Date AS Previous_Year_Date,
         t2.Publisher AS Previous_Year_Publisher, 
         t2.Publisher_Group AS Previous_Year_Publisher_Group,
         t2.mcf_first_inter_action_conversions AS Previous_Year_First_Conversions, 
         t2.mcf_first_inter_action_value AS Previous_Year_First_Revenue,
         t2.mcf_last_inter_action_conversions AS Previous_Year_Last_Conversions, 
         t2.mcf_last_inter_action_value AS Previous_Year_Last_Revenue
  FROM `ltpautomatedpublisherscorecard.ga_traffic.first_last_conversions` t1
  LEFT JOIN `ltpautomatedpublisherscorecard.ga_traffic.first_last_conversions` t2
  ON t1.Brand = t2.Brand AND DATE_SUB(t1.Date, INTERVAL 1 YEAR) = t2.Date AND t1.Publisher_Group = t2.Publisher_Group AND t1.Publisher = t2.Publisher
),
temp1 as(
  SELECT t3.Date, 
         t3.Brand, 
         t3.Publisher, 
         t3.Publisher_Group,
         t3.Current_Year_First_Conversions,
         t3.Current_Year_First_Revenue,
         t3.Current_Year_Last_Conversions, 
         t3.Current_Year_Last_Revenue,
         t3.Previous_Year_Date,
         t3.Previous_Year_First_Conversions,
         t3.Previous_Year_First_Revenue,
         t3.Previous_Year_Last_Conversions, 
         t3.Previous_Year_Last_Revenue,
         t3.Date as Current_Month_Date,
         t3.Current_Year_First_Conversions as Current_Month_First_Conversions,
         t3.Current_Year_First_Revenue as Current_Month_First_Revenue,
         t3.Current_Year_Last_Conversions as Current_Month_Last_Conversions,
         t3.Current_Year_Last_Revenue as Current_Month_Last_Revenue,
         t4.Date as Previous_Month_Date,
         t4.mcf_first_inter_action_conversions as Previous_Month_First_Conversions,
         t4.mcf_first_inter_action_value as Previous_Month_First_Revenue,
         t4.mcf_last_inter_action_conversions as Previous_Month_Last_Conversions,
         t4.mcf_last_inter_action_value as Previous_Month_Last_Revenue
  FROM temp t3 
  LEFT JOIN `ltpautomatedpublisherscorecard.ga_traffic.first_last_conversions` t4
  ON t3.Brand = t4.Brand AND DATE_SUB(t3.Date, INTERVAL 1 MONTH) = t4.Date AND t3.Publisher_Group = t4.Publisher_Group AND t3.Publisher = t4.Publisher
)
SELECT t5.Date, 
       t5.Brand, 
       t5.Publisher, 
       t5.Publisher_Group,
       MAX(t5.Current_Year_First_Conversions) AS Current_Year_First_Conversions,MAX(t5.Current_Year_First_Revenue) AS Current_Year_First_Revenue,
       MAX(t5.Current_Year_Last_Conversions) AS Current_Year_Last_Conversions,MAX(t5.Current_Year_Last_Revenue) AS Current_Year_Last_Revenue,
       MAX(t5.Previous_Year_Date) AS Previous_Year_Date ,
       MAX(t5.Previous_Year_First_Conversions) AS Previous_Year_First_Conversions,MAX(t5.Previous_Year_First_Revenue) AS Previous_Year_First_Revenue,
       MAX(t5.Previous_Year_Last_Conversions) AS Previous_Year_Last_Conversions,MAX(t5.Previous_Year_Last_Revenue) AS Previous_Year_Last_Revenue,
       t5.Current_Month_Date,
       MAX(t5.Current_Year_First_Conversions) as Current_Month_First_Conversions,MAX(t5.Current_Year_First_Revenue) as Current_Month_First_Revenue,
       MAX(t5.Current_Year_Last_Conversions) as Current_Month_Last_Conversions,MAX(t5.Current_Year_Last_Revenue) as Current_Month_Last_Revenue,
       MAX(t5.Previous_Month_Date) AS Previous_Month_Date,
       MAX(t5.Previous_Month_First_Conversions) AS Previous_Month_First_Conversions,MAX(t5.Previous_Month_First_Revenue) AS Previous_Month_First_Revenue,
       MAX(t5.Previous_Month_Last_Conversions) AS Previous_Month_Last_Conversions,MAX(t5.Previous_Month_Last_Revenue) AS Previous_Month_Last_Revenue,
       t5.Date as Current_Day_Date,
       MAX(t5.Current_Year_First_Conversions) as Current_Day_First_Conversions,MAX(t5.Current_Year_First_Revenue) as Current_Day_First_Revenue,
       MAX(t5.Current_Year_Last_Conversions) as Current_Day_Last_Conversions,MAX(t5.Current_Year_Last_Revenue) as Current_Day_Last_Revenue,
       MAX(t6.Date) as Previous_Day_Date,
       MAX(t6.mcf_first_inter_action_conversions) as Previous_Day_First_Conversions,MAX(t6.mcf_first_inter_action_value) as Previous_Day_First_Revenue,
       MAX(t6.mcf_last_inter_action_conversions) as Previous_Day_Last_Conversions, MAX(t6.mcf_last_inter_action_value) as Previous_Day_Last_Revenue
from temp1 t5
LEFT JOIN `ltpautomatedpublisherscorecard.ga_traffic.first_last_conversions` t6
ON t5.Brand = t6.Brand AND DATE_SUB(t5.Date, INTERVAL 1 DAY) = t6.Date AND t5.Publisher_Group = t6.Publisher_Group AND t5.Publisher = t6.Publisher
GROUP BY Date, Brand, Publisher, Publisher_Group
