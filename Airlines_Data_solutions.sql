USE airlines;
select * from airlines_data;
-- Some Advanced MySQL Questions for Airlines Dataset Analysis:

-- 1.  Find the average ticket price per airline.

SELECT airline, ROUND(AVG(price),2) AS avg_price
FROM airlines_data
GROUP BY airline;

-- 2. List the top 5 most expensive routes (source to destination).

SELECT source_city, destination_city, ROUND(AVG(price),2) AS price
FROM airlines_data
GROUP BY source_city, destination_city
ORDER BY price DESC
LIMIT 5 ;

-- 3. Which airline offers the lowest average ticket price for Business class? 

SELECT airline, ROUND(MIN(price),2) AS min_price
FROM airlines_data
WHERE class_type= "Business"
GROUP BY airline
ORDER BY min_price
LIMIT 1;

-- 4. Find routes with more than 50 flights and their average ticket prices.

SELECT source_city, destination_city, COUNT(*) AS total_flights, ROUND(AVG(price),2) AS avg_price
FROM airlines_data
GROUP BY source_city, destination_city
HAVING COUNT(*) > 50;

-- 5. Compare average price difference between Economy and Business class per airline.

SELECT airline,
				AVG(CASE WHEN class_type = "Economy" THEN price END) AS avg_economy,
                AVG(CASE WHEN class_type = "Business" THEN price END) AS avg_busniess,
                (AVG(CASE WHEN class_type = "Economy" THEN price END) - 
                AVG(CASE WHEN class_type = "Business" THEN price END))AS price_diff
 
 FROM airlines_data
 GROUP BY airline;

-- 6. Which cities have the most incoming flights? 

SELECT destination_city, COUNT(*) AS incoming_flights
FROM airlines_data
GROUP BY destination_city
ORDER BY incoming_flights DESC;

 -- 7. Which cities have the most outgoing flights? 
 
SELECT source_city, COUNT(*) AS outgoing_flight
FROM airlines_data
GROUP BY source_city
ORDER BY outgoing_flight DESC;

-- 8. Find the busiest route (most number of flights).

SELECT source_city, destination_city, COUNT(*) AS busiest_route
FROM airlines_data
GROUP BY source_city, destination_city
ORDER BY busiest_route DESC
LIMIT 1;

-- 9. List the top 3 airlines with cheapest average prices for each route.

SELECT source_city, destination_city, airline,avg_price
FROM( 
		SELECT source_city, destination_city, airline, AVG(price) AS avg_price,
				ROW_NUMBER() OVER(PARTITION BY source_city, destination_city ORDER BY AVG(price)) as rn
		FROM airlines_data
		GROUP BY source_city, destination_city, airline)
			AS ranked
WHERE rn <=3;
    
-- 10. Find flights with duration more than 5 hours but priced below average.

SELECT * FROM airlines_data
WHERE duration > 5
and price <(SELECT AVG(price) FROM airlines_data);
    
-- 11. Which flight class shows the highest average price variation (std deviation)? 

SELECT class_type, STDDEV(price) AS std_price
FROM airlines_data
GROUP BY class_type
ORDER BY std_price DESC;

-- 12. Find how ticket prices vary with number of days left before departure. 

SELECT days_left, ROUND(AVG(price),2) AS avg_price
FROM airlines_data
GROUP BY days_left
ORDER BY days_left;

-- 13. Which time of day (Morning, Evening, etc.) has the highest average ticket price? 

SELECT departure_time, ROUND(AVG(price),2) AS avg_price
FROM airlines_data
GROUP BY departure_time
ORDER BY avg_price DESC
LIMIT 1;

-- 14. Find Price trends by airline and travel class

SELECT airline, class_type, ROUND(AVG(price),2) AS Avg_price
FROM airlines_data
GROUP BY airline, class_type
ORDER BY airline, class_type;

-- 15. Compare the airlines average prices for non-stop vs. 1-stop vs. 2+ stops flights. 

SELECT airline, stops, ROUND(AVG(price),2) AS Avg_price
FROM airlines_data
GROUP BY airline, stops
ORDER BY airline, Avg_price;



