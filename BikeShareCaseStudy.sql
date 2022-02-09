/*

CASE STUDY 1

Case Study: How Does a Bike-Share Navigate Speedy Success?

This is an analysis of how aimed at maximizing the number of Cyclistic annual members.

The different way in which casual riders and annual members use Cyclistic bikes differently will be analyzed.

Assumptions: Because of low virtual memory when I was downloading the datasets. I am using only 6 months of data rather than
the 12 months of data provided. There are approximately 100,000 records missing from the last rows of the 7/2021 dataset.

Historical Bike data will be analyzed in order to identify trends. 

-----

The data will be cleaned before the analysis. 

*/
USE BikeShareCaseStudy;

-- 2021-02 Divvy Bike Data - added miles traveled and time spent per trip - 
-- dataset does not include null records, all start station id records and end station id records were formatted to text only. 
-- The distance from the start station to end station is showing as 0 miles approximately when the start station is the same as
-- the end station. 

ALTER TABLE divvy202102cleaned
ADD meters_traveled Float

UPDATE divvy202102cleaned
SET meters_traveled = geography::Point(start_lat, start_lng, 4326).STDistance(geography::Point(end_lat, end_lng, 4326))

ALTER TABLE divvy202102cleaned
ADD miles_traveled Float

UPDATE divvy202102cleaned
SET miles_traveled = round(miles_traveled, 3)

ALTER TABLE divvy202102cleaned
DROP COLUMN meters_traveled

Select *
From divvy202102cleaned

ALTER TABLE divvy202102cleaned
ADD time_minutes_per_trip Float

UPDATE divvy202102cleaned
SET time_minutes_per_trip = DATEDIFF(MINUTE, started_at, ended_at)

Select *
From divvy202102cleaned


-- 2021-03 Divvy Bike Data

ALTER TABLE divvy202103cleaned
ADD meters_traveled Float

UPDATE divvy202103cleaned
SET meters_traveled = geography::Point(start_lat, start_lng, 4326).STDistance(geography::Point(end_lat, end_lng, 4326))

ALTER TABLE divvy202103cleaned
ADD miles_traveled Float

UPDATE divvy202103cleaned
SET miles_traveled = meters_traveled/1609.34

UPDATE divvy202103cleaned
SET miles_traveled = round(miles_traveled, 3)

ALTER TABLE divvy202103cleaned
DROP COLUMN meters_traveled

Select *
From divvy202103cleaned

ALTER TABLE divvy202103cleaned
ADD time_minutes_per_trip Float

UPDATE divvy202103cleaned
SET time_minutes_per_trip = DATEDIFF(MINUTE, started_at, ended_at)

Select *
From divvy202103cleaned

-- 2021-04 Divvy Bike Data

ALTER TABLE divvy202104cleaned
ADD meters_traveled Float

UPDATE divvy202104cleaned
SET meters_traveled = geography::Point(start_lat, start_lng, 4326).STDistance(geography::Point(end_lat, end_lng, 4326))

ALTER TABLE divvy202104cleaned
ADD miles_traveled Float

UPDATE divvy202104cleaned
SET miles_traveled = meters_traveled/1609.34

UPDATE divvy202104cleaned
SET miles_traveled = round(miles_traveled, 3)

ALTER TABLE divvy202104cleaned
DROP COLUMN meters_traveled

Select *
From divvy202103cleaned

ALTER TABLE divvy202104cleaned
ADD time_minutes_per_trip Float

UPDATE divvy202104cleaned
SET time_minutes_per_trip = DATEDIFF(MINUTE, started_at, ended_at)

Select *
From divvy202104cleaned

-- 2021-05 Divvy Bike Data

ALTER TABLE divvy202105cleaned
ADD meters_traveled Float

UPDATE divvy202105cleaned
SET meters_traveled = geography::Point(start_lat, start_lng, 4326).STDistance(geography::Point(end_lat, end_lng, 4326))

ALTER TABLE divvy202105cleaned
ADD miles_traveled Float

UPDATE divvy202105cleaned
SET miles_traveled = meters_traveled/1609.34

UPDATE divvy202105cleaned
SET miles_traveled = round(miles_traveled, 3)

ALTER TABLE divvy202105cleaned
DROP COLUMN meters_traveled

Select *
From divvy202105cleaned

ALTER TABLE divvy202105cleaned
ADD time_minutes_per_trip Float

UPDATE divvy202105cleaned
SET time_minutes_per_trip = DATEDIFF(MINUTE, started_at, ended_at)

Select *
From divvy202105cleaned

-- 2021-06 Divvy Bike Data

ALTER TABLE divvy202106cleaned
ADD meters_traveled Float

UPDATE divvy202106cleaned
SET meters_traveled = geography::Point(start_lat, start_lng, 4326).STDistance(geography::Point(end_lat, end_lng, 4326))

ALTER TABLE divvy202106cleaned
ADD miles_traveled Float

UPDATE divvy202106cleaned
SET miles_traveled = meters_traveled/1609.34

UPDATE divvy202106cleaned
SET miles_traveled = round(miles_traveled, 3)

ALTER TABLE divvy202106cleaned
DROP COLUMN meters_traveled

Select *
From divvy202106cleaned

ALTER TABLE divvy202106cleaned
ADD time_minutes_per_trip Float

UPDATE divvy202106cleaned
SET time_minutes_per_trip = DATEDIFF(MINUTE, started_at, ended_at)

Select *
From divvy202106cleaned

-- 2021-07 Divvy Bike Data

ALTER TABLE divvy202107cleaned
ADD meters_traveled Float

UPDATE divvy202107cleaned
SET meters_traveled = geography::Point(start_lat, start_lng, 4326).STDistance(geography::Point(end_lat, end_lng, 4326))

ALTER TABLE divvy202107cleaned
ADD miles_traveled Float

UPDATE divvy202107cleaned
SET miles_traveled = meters_traveled/1609.34

UPDATE divvy202107cleaned
SET miles_traveled = round(miles_traveled, 3)

ALTER TABLE divvy202107cleaned
DROP COLUMN meters_traveled

Select *
From divvy202107cleaned

ALTER TABLE divvy202107cleaned
ADD time_minutes_per_trip Float

UPDATE divvy202107cleaned
SET time_minutes_per_trip = DATEDIFF(MINUTE, started_at, ended_at)

Select *
From divvy202107cleaned

Select A.*
From (Select * From divvy202102cleaned) AS A
UNION Select B.* From (Select * From divvy202103cleaned) AS B
UNION Select C.* From (Select * From divvy202104cleaned) AS C
UNION Select D.* From (Select * From divvy202105cleaned) AS D
UNION Select E.* From (Select * From divvy202106cleaned) AS E
UNION Select F.* From (Select * From divvy202107cleaned) AS F)

CREATE TABLE divvytripdatatemp
(ride_id nvarchar(255), rideable_type nvarchar(255), started_at datetime, ended_at datetime, start_station_name nvarchar(255), start_station_id nvarchar(255),
end_station_name nvarchar(255), end_station_id nvarchar(255), start_lat float, start_lng float, end_lat float, end_lng float, member_casual nvarchar(255),
miles_traveled float, time_minutes_per_trip float)

USE BikeShareCaseStudy
INSERT INTO divvytripdatatemp
Select * From divvy202102cleaned
Select * From divvy202103cleaned
Select * From divvy202104cleaned
Select * From divvy202105cleaned
Select * From divvy202106cleaned
Select * From divvy202107cleaned

Select * From divvytripdatatemp;

-- Summary Statistics - created a temp table to get summary statistics

-- Mean of ride_length

-- Casual riders - 26.1 minutes

Select member_casual, Round(AVG(time_minutes_per_trip), 2) as average_minutes_per_trip
From divvytripdatatemp
Where rideable_type <> 'docked_bike' and member_casual = 'casual'
Group by member_casual;

-- Members - 14.09 minutes

Select member_casual, Round(AVG(time_minutes_per_trip), 2) as average_minutes_per_trip
From divvytripdatatemp
Where rideable_type <> 'docked_bike' and member_casual = 'member'
Group by member_casual;

-- Max ride length 

-- Casual riders - 1496 minutes

Select member_casual, Round(MAX(time_minutes_per_trip), 2) as max_minutes_per_trip
From divvytripdatatemp
Where rideable_type <> 'docked_bike' and member_casual = 'casual'
Group by member_casual;

-- Members - 1495 minutes

Select member_casual, Round(MAX(time_minutes_per_trip), 2) as max_minutes_per_trip
From divvytripdatatemp
Where rideable_type <> 'docked_bike' and member_casual = 'member'
Group by member_casual;

-- Mode of day of week

--Casual riders - Saturday is the day with the most rides overall

Select DATENAME(dw, started_at) as start_day, Count(time_minutes_per_trip) as number_of_trips
From divvytripdatatemp
Where rideable_type <> 'docked_bike' and member_casual = 'casual'
Group by DATENAME(dw, started_at)
Order by number_of_trips desc

-- Members - Wednesday is the day with the most rides overall

Select DATENAME(dw, started_at) as start_day, Count(time_minutes_per_trip) as number_of_trips
From divvytripdatatemp
Where rideable_type <> 'docked_bike' and member_casual = 'member'
Group by DATENAME(dw, started_at)
Order by number_of_trips desc

-- Average ride length by users based on day of week

-- Casual riders - Sunday is the day with the highest average ride length. 

Select Round(AVG(time_minutes_per_trip), 2) as average_ride_length
From divvytripdatatemp
Where member_casual = 'casual' and rideable_type <> 'docked_bike'
Group by DATENAME(dw, started_at)
Order by average_ride_length desc;

--Members - Sunday is the day with the highest average ride length.

Select Round(AVG(time_minutes_per_trip), 2) as average_ride_length
From divvytripdatatemp
Where member_casual = 'member' and rideable_type <> 'docked_bike'
Group by DATENAME(dw, started_at)
Order by average_ride_length desc;

-- Based on Season [Spring (February - April 2021), Summer (May - July)]

-- Spring Season

--Number of rides during Spring season

--Casual riders - 159,709 rides (167051 rides) **NEED TO REVIEW CORRECT NUMBER**

Select member_casual, Count(ride_id) as number_of_rides
From divvytripdatatemp
Where member_casual = 'casual' and rideable_type <> 'docked_bike' and started_at BETWEEN '2/1/2021' AND '4/30/2021'
Group by member_casual
Order by number_of_rides desc

-- Summer Season 

-- Number of rides during Summer season

-- Casual riders - 720,789 rides

Select member_casual, Count(ride_id) as number_of_rides
From divvytripdatatemp
Where member_casual = 'casual' and rideable_type <> 'docked_bike' and started_at BETWEEN '5/1/2021' AND '7/31/2021'
Group by member_casual
Order by number_of_rides desc

--Number of rides during Spring season

-- Members - 335634 rides (370017 rides) **NEED TO CHECK CORRECT NUMBER OF RIDES**

Select member_casual, Count(ride_id) as number_of_rides
From divvytripdatatemp
Where member_casual = 'member' and rideable_type <> 'docked_bike' and started_at BETWEEN '2/1/2021' AND '4/30/2021'
Group by member_casual
Order by number_of_rides desc

--Number of rides during Summer season

--Members - 850,666 rides

Select member_casual, Count(ride_id) as number_of_rides
From divvytripdatatemp
Where member_casual = 'member' and rideable_type <> 'docked_bike' and started_at BETWEEN '5/1/2021' AND '7/31/2021'
Group by member_casual
Order by number_of_rides desc

-- Miles traveled by rider

-- Casual riders

-- February thru April miles - 265,849 miles

Select member_casual, Round(sum(miles_traveled), 2) as total_miles_traveled
FROM divvytripdatatemp
Where member_casual = 'casual' and started_at BETWEEN '2/1/2021' AND '4/30/2021'
Group by member_casual

-- April thru July miles - 1,181,267.94 miles

Select member_casual, Round(sum(miles_traveled), 2) as total_miles_traveled
FROM divvytripdatatemp
Where member_casual = 'casual' and started_at BETWEEN '5/1/2021' AND '7/31/2021'
Group by member_casual

-- Members

-- February thru April miles - 481,269.14 miles

Select member_casual, Round(sum(miles_traveled), 2) as total_miles_traveled
FROM divvytripdatatemp
Where member_casual = 'member' and started_at BETWEEN '2/1/2021' AND '4/30/2021'
Group by member_casual

-- April thru July miles - 1,154,806.94 miles

Select member_casual, Round(sum(miles_traveled), 2) as total_miles_traveled
FROM divvytripdatatemp
Where member_casual = 'member' and started_at BETWEEN '5/1/2021' AND '7/31/2021'
Group by member_casual

INSERT INTO divvytripdatatemp
Select * 
From divvytripdatatemp

ALTER TABLE divvytripdatatemp
ADD day_of_week nvarchar(255)

UPDATE divvytripdatatemp
SET day_of_week = DATENAME(dw, started_at)

Select * 
From divvytripdatatemp;

/* How do annual members and casual riders use Cyclistic Bikes differently?

Based on analyzing the data for 6 months from February 2021 through July 2021, different statistics were obtained for the casual
riders and members. The Mean ride length and Max ride length were calculated based on the rider along with the day of the week 
with the most rides. The average ride length based on the day of the week for the different riders was calculated. In addition,
the number of rides for the Spring and Summer Season were calculated for each rider. The number of miles traveled for each rider
type was also calculated based on whether the ride was in the Spring or Summer months. 

The results are as follows:

Casual riders have higher avg time riding than Members. 
Max riding time is approximately the same between Casual riders and Members.
Casual riders use bikes mostly on Saturdays, while Members use them mostly on Wednesdays.
Sunday has the highest avg ride time between Casual riders and Members.
Casual riders ride more in the Summer than Spring; Same for Members which have higher Spring and Summer rides.
Members ride more miles than Casual riders in Spring.
Members ride slightly less miles than Casual riders in Summer. 

It seems that Members tend to use the bikes the most on Wednesday, a weekday, for shorter periods of time on average and tend to use them for
more miles during the colder months in Spring compared to Casual riders. It seems that Casual riders use the bikes the most on 
Saturday, a weekend day, and for longer periods of time on average compared to Members. They ride more miles during the summer compared to Members. 

*/



----------------------------------------------------------------------

-- Tableau will be used to gain insights into the data 

-- Please refer to Tableau Analysis