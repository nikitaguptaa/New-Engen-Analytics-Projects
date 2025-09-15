# Google Analytics + Affiliate Network data(Affluent) Traffic Scheduled Queries :

## GA_Traffic - Grouping query (Publisher group) for merged data
This replaces the publisher group 'coupon' with 'coupons' within the merged_data dataset under GA_Traffic table

GA_Traffic - GA_Affluent Merged data
This is a merge of Affluent + GA data - this creates a dataset named - 'merged_data' and is further used in the New user % report to show data insights (New users %) from GA and Affiliate Network data

GA_traffic-Flag query dynamically switching revenue from Year to Month
This query takes GA_Affluent merged dataset (dataset within merged data) and is left join on the same GA_Affluent merged dataset to get the final dataset for the 1st LTP Analytics Extension dashboard . The dataset created is - 'Flag_data_for_year_to_month' with GA_Traffic table. (this is the final dataset used in the Publisher GA revenue by category (total 1 -Current,Previous period revenue) dashboard)

GA_traffic-Clicks and Conversions -Influencer data
This query includes only those publisher ids which are INFLUENCERS (rewardStyle, ShopStyle collective &inc ,Magiclinks,Mavely) from first_last_conversions dataset and creates a new dataset 'first_last_conversions_influencer_data) (this is the final dataset used in the new traffic analysis (total 2 -influencer) dashboard)

GA_traffic-Time period based clicks data
This query creates columns such as Previous year first conversions,Current year first conversions, Previous month first conversions, Previous day first conversions and creates a dataset named-'time_period_based_clicks' (this is the final dataset used in the conversions(total 3 -first,last,first&last) dashboard)
