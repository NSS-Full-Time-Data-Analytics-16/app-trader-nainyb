/*Develop some general recommendations about the price range, genre, content rating, or any other app characteristics that the company should target
*/

SElECT Category,SIZE,rating,price,  P.* FROm play_store_apps as P
Group By category, price, size ,genre
--9659 name  (10840)


SELECT * from play_store_apps
SELECT *		FROM app_store_apps
SELECT category, name , sum(review_count) as review_count from play_store_apps
Group BY category, name
order by review_count desc


SELECT  genres, Sum(PSA.review_count)  as review_count,PSA.price,
case when ASp.price between 0  and 2.5 Then '25000'
			When ASp.price > 2.5 Then ASp.price * 10000
			END   as Payment_price_in_thousand
From play_store_apps as PSA inner Join app_store_apps ASp Using (name)
WHERE ASP.rating >=4.5 AND PSA.rating >= 4.5
Group BY genres, Payment_price_in_thousand,PSA.price
--Order By   review_count DESC--- FOR Review count
Order by Payment_price_in_thousand desc-- Total amout for an app to built.




SELECT  genres, Sum(PSA.review_count)  as review_count,name , PSa.Price 
From play_store_apps as PSA
inner Join app_store_apps ASp Using (name)
Group BY genres, PSa.Price ,name
Order By review_count DESC--- FREE APPS has HIGHEST review_count




SELECT * FROM  app_store_apps

SELECT genres , Count(RATING) as rating FROM play_store_apps PSA 
WHere PSA.rating =5
GROUP BY genres 
UNION
SELECT primary_genre, Count(RATING) as rating FROM app_store_apps ASA 
WHere ASA.rating =5
GROUP BY primary_genre 
Order BY rating desc-- rating

SELECT primary_genre, Count(RATING) as rating  ,


WIth LONGIVTIVIty_table as(
SELECT
 Case When rating =0  THEN 1
 	  When rating  between 1 and 2 THEN 3
	   When rating Between 2 AND 3 THEN 5
	   When rating Between 3 AND 4 THEN 7
	   When rating > 4  THEN 9 ELSE 0 END
 		 AS LONGIVTIVIty, primary_genre, SUm(review_count::numeric) as review_count,Name
FROM app_store_apps 
Group By primary_genre, review_count,LONGIVTIVIty,name
Order BY LONGIVTIVIty desc) ------- GIVES LONGIVTIVItY app

SELECT * FROM LONGIVTIVIty_table Inner join play_store_apps on LONGIVTIVIty_table.primary_genre= play_store_apps.geners






SELECT DISTINCT rating FRom app_store_apps
WHere ASA.rating =5
GROUP BY primary_genre 
Order BY rating desc


----*** TO see how much does each app makes 

SELECT  genres, Sum(PSA.review_count)  as review_count,ASp.price,
			case when ASp.price between 0  and 2.5 Then '25000'
				When ASp.price > 2.5 Then ASp.price * 10000
				END   as App_trader_purchase_price_in_thousand
			--Case When App_trader_purchase_price_in_thousand =25000
			
From play_store_apps as PSA
inner Join app_store_apps ASp Using (name)
WHERE ASP.rating >=4.5 AND PSA.rating >= 4.5
Group BY genres, App_trader_purchase_price_in_thousand, ASp.price
Order By   review_count DESC--- FOR Review count



SELECT Case when 


FROM app_store_apps
Inner JOin Play_store_apps Using(name)


--- Develop a Top 10 List of the apps that App Trader should buy based on profitability/return on investment as the sole priority.
WITH prof_per_month AS(
SELECT DISTINCT(name),
		asa.price::money AS asa_price,
		ps.price::money AS ps_price,
		asa.rating AS asa_rating,
		ps.rating AS ps_rating,
		ps.install_count,
		genres,
		(CASE WHEN asa.price::numeric BETWEEN 0 AND 2.49 THEN '25000' 	-- used 0 between 2.49 because all apps used were less than 2.50
		     ELSE asa.price::numeric * 10000 							-- 10000 times the price if it is 2.50 and above
			 END)::money AS app_price,
		(CASE WHEN asa.price::numeric BETWEEN 0 AND 5 THEN '10000'	 	--needed a profit line per month and choose between 0 and 5	
		     END)::money AS profit_per_mon
FROM app_store_apps AS asa INNER JOIN play_store_apps AS ps USING(name)
WHERE asa.rating > 4.0 and ps.rating > 4.0								-- choose 4.0 rating as reference since it will give at least 9 years	
ORDER BY install_count
LIMIT 10)
SELECT SUM(app_price) AS purchase_right,
	   SUM(profit_per_mon - 1000::money) * 12 AS one_year,--12 is the number of months
	   SUM(profit_per_mon - 1000::money) * 24 AS two_year,
	   SUM(profit_per_mon - 1000::money) * 36 AS three_year,
	   SUM(profit_per_mon - 1000::money) * 48 AS four_year,
	   SUM(profit_per_mon - 1000::money) * 108 AS ninth_year
FROM prof_per_month-$90,000/month


---TOP 4 JUly 4th themed apps
---Develop a Top 4 list of the apps that App Trader should buy that are profitable but that also are thematically appropriate for the upcoming Fourth of July themed campaign.

SELECT DISTINCT(name), --"Weather", "Music", "Social", "Food & Drink"
		asa.price::money AS asa_price,
		ps.price::money AS ps_price,
		asa.rating AS asa_rating,
		ps.rating AS ps_rating,
		genres,
		ps.install_count,
		(CASE WHEN asa.price::numeric BETWEEN 0 AND 2.49 THEN '25000' 	-- used 0 between 2.49 because all apps used were less than 2.50
		     ELSE asa.price::numeric * 10000 							-- 10000 times the price if it is 2.50 and above
			 END)::money AS app_price,
		(CASE WHEN asa.price::numeric BETWEEN 0 AND 5 THEN '10000'	 	--needed a profit line per month and choose between 0 and 5	
		     END)::money AS profit_per_mon
FROM app_store_apps AS asa JOIN play_store_apps AS ps USING(name)
WHERE genres = 'Weather' OR genres = 'Music' OR genres = 'Social' OR genres = 'Food & Drink' OR genres = 'Travel & Local'
ORDER BY ps.install_count
LIMIT 4








