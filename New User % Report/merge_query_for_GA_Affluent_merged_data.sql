SELECT Date,	Brand,	Publisher_ID,	Publisher,	Channel,	Publisher_Group,	Publisher_Commission_Gross,	Network_Commission_Gross,	Total_Commission_Gross,	Revenue_Gross,	Num_of_Actions,	Leads_Gross,	Clicks,	Impressions,	CR,	CTR,	AOV,	Average_Commission,	RoAS,	New_Actions,	Repeat_Actions,	Percent_New_Actions,	Rev_New,	Rev_Repeat,	Percent_New_Revenue_Gr,	the_date,	account,	webPropertyName,	publisher_name,	SUM(new_visits_noncalc) AS new_visits_noncalc,	SUM(users) AS users,	merged_publisher_name,	SUM(item_revenue) AS item_revenue,	string_field_0,	string_field_1,	string_field_2

FROM (

SELECT * FROM `ltpautomatedpublisherscorecard.raw_data.affluent_all_data`
LEFT JOIN
(SELECT * FROM
(SELECT date AS the_date, account, webPropertyName, publisher_name, new_visits_noncalc, users, `ltpautomatedpublisherscorecard.merged_data.lookup_table`.merged_publisher_name, item_revenue
FROM `ltpautomatedpublisherscorecard.raw_data.ga_all_data` As temp_user_table
INNER JOIN `ltpautomatedpublisherscorecard.merged_data.lookup_table`
ON temp_user_table.medium IN ('affiliate', 'Affiliate', 'Affiliates', 'affiliates')
AND `ltpautomatedpublisherscorecard.merged_data.lookup_table`.publisher_id = temp_user_table.keyword

OR (temp_user_table.medium = 'referral'
AND temp_user_table.source = 'impact'
AND temp_user_table.account = 'Cuyana'
AND `ltpautomatedpublisherscorecard.merged_data.lookup_table`.publisher_id = temp_user_table.keyword)

OR (temp_user_table.medium = 'affiliate'
AND temp_user_table.webPropertyName IN ('Cheryls: Production', '1-800-Baskets: Production', '1-800-Flowers.CA: Production', '1-800-Flowers: Production', 'Florists.com: Production', 'Fruit Bouquets: Production', 'Harry and David: Production', 'Personalization Mall', 'Plants.com', "Shari's Berries: Production", 'Simply Chocolate Production', 'The Popcorn Factory: Production', 'Vital Choice: Production', "Wolferman's: Production")
AND `ltpautomatedpublisherscorecard.merged_data.lookup_table`.publisher_id = temp_user_table.campaign)

OR (temp_user_table.medium = 'referral'
AND temp_user_table.source = 'impact'
AND temp_user_table.account = 'ParachuteHome'
AND `ltpautomatedpublisherscorecard.merged_data.lookup_table`.publisher_id = temp_user_table.keyword)

OR (temp_user_table.medium = 'mediapartner'
AND temp_user_table.account = 'Universal Standard Shopify'
AND `ltpautomatedpublisherscorecard.merged_data.lookup_table`.publisher_id = temp_user_table.keyword)

OR (temp_user_table.medium = 'impact'
AND temp_user_table.source = 'affiliate'
AND temp_user_table.account = 'Prose'
AND `ltpautomatedpublisherscorecard.merged_data.lookup_table`.publisher_id = temp_user_table.keyword)


) AS temp_user_table_2
INNER JOIN `ltpautomatedpublisherscorecard.merged_data.lookup_table_brand`
ON temp_user_table_2.webPropertyName = `ltpautomatedpublisherscorecard.merged_data.lookup_table_brand`.string_field_2)
AS temp_table
ON `ltpautomatedpublisherscorecard.raw_data.affluent_all_data`.Publisher = temp_table.merged_publisher_name
AND CAST(`ltpautomatedpublisherscorecard.raw_data.affluent_all_data`.Date AS DATE) = temp_table.the_date
AND `ltpautomatedpublisherscorecard.raw_data.affluent_all_data`.Brand = temp_table.string_field_1

) GROUP BY Date,	Brand,	Publisher_ID,	Publisher,	Channel,	Publisher_Group,	Publisher_Commission_Gross,	Network_Commission_Gross,	Total_Commission_Gross,	Revenue_Gross,	Num_of_Actions,	Leads_Gross,	Clicks,	Impressions,	CR,	CTR,	AOV,	Average_Commission,	RoAS,	New_Actions,	Repeat_Actions,	Percent_New_Actions,	Rev_New,	Rev_Repeat,	Percent_New_Revenue_Gr,	the_date,	account,	webPropertyName,	publisher_name,	merged_publisher_name,	string_field_0,	string_field_1,	string_field_2

ORDER BY Publisher
