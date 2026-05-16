/*
===================================================================================================
📌 PROJECT TITLE : Spotify & YouTube Advanced Data Analysis (EDA & DA)
👨‍💻 DEVELOPER     : Sherif (https://github.com/Sherif944)
🛠️ ENVIRONMENT   : Microsoft SQL Server (T-SQL)
📂 DATASET SIZE  : 20,000+ Operational Rows (Music Tracks Shared Across Platforms)
===================================================================================================

📖 PROJECT DESCRIPTION:
-----------------------
An end-to-end SQL analytics script focused on executing deep Exploratory Data Analysis (EDA) 
and solving complex business intelligence questions. This script benchmarks track metrics 
concurrently across Spotify and YouTube, tackling data cleaning, cross-platform performance, 
and advanced transactional tracking.

🎯 KEY SQL CONCEPTS & TECHNIQUES DEMONSTRATED:
----------------------------------------------
1. EXPLORATORY DATA ANALYSIS (EDA): Profiling categorical fields and data sanitization routines.
2. ADVANCED WINDOW FUNCTIONS      : Complex Top-N partitioning via DENSE_RANK() and precise 
                                    row-frame handling (ROWS BETWEEN...) for running totals.
3. OPTIMIZED DATATYPE CASTING     : Defensive math engineering utilizing NULLIF() to prevent 
                                    division-by-zero errors and CAST AS FLOAT for precise metrics.
4. PERFORMANCE-TUNED CTEs & JOINS : Multi-layered Common Table Expressions and self-joins 
                                    engineered to deduplicate platform-level grouping anomalies.

🗂️ SCRIPT ROADMAP:
------------------
   🔹 Section 01: Exploratory Data Analysis (EDA) & Data Cleansing
   🔹 Section 02: Easy Category (Core Filtering & Milestones)
   🔹 Section 03: Intermediate Category (Multi-Dimensional Aggregations & Platform Duels)
   🔹 Section 04: Advanced Category (The Analytical Engine - Window Functions & Safe Ratios)

===================================================================================================
*/

-- EXPLORATORY DATA ANALYSIS

-- Check that all data are inserted successfully 
SELECT COUNT(*) FROM spotify_tbl

-- Check all the album types in your data
SELECT DISTINCT	album_type FROM spotify_tbl

-- Check the MAX and MIN Duration_min 
SELECT
	MAX(Duration_min) max_duration_min
FROM spotify_tbl

SELECT
	MIN(Duration_min) min_duration_min
FROM spotify_tbl

-- Delete the songs where duration_min = 0
DELETE FROM spotify_tbl
WHERE Duration_min = 0
SELECT * FROM spotify_tbl
WHERE Duration_min = 0
SELECT COUNT(*) FROM spotify_tbl

-- How many channels in the data
SELECT DISTINCT 
	channel
FROM spotify_tbl
where channel = 'OasisVEVO'

-- Check which channel the songs that are most played on
SELECT
	most_playedon,
	COUNT(*) Number_songs_played_on
FROM spotify_tbl
GROUP BY most_playedon

-- ==============================
-- Data Analysis -- Easy Category
-- ==============================


-- Retrive the names of all tracks that have more than 1 billion views 
SELECT
	TRACK,
	VIEWS
FROM spotify_tbl
WHERE VIEWS >= 1000000000


-- list all the albums along with their respective artists
SELECT DISTINCT
	album,
	Artist
FROM spotify_tbl
ORDER BY album


-- Get the total number of comments for tracks where licensed = True
SELECT
	comments,
	licensed,
	SUM(comments) OVER () total_number_of_comments
FROM spotify_tbl
WHERE LICENSED = 'True'


-- Find all tracks that belong to the album type single
SELECT
	track,
	Album_type
FROM spotify_tbl
WHERE album_type = 'Single'


-- Count the total number of tracks by each artist
SELECT
	artist,
	COUNT(track) Nr_tracks_by_artist
FROM spotify_tbl
GROUP BY artist
ORDER BY COUNT(track)



-- ======================================
-- Data Analysis -- intermediate category
-- ======================================
SELECT 
*
FROM spotify_tbl



-- Calculate the average danceability of tracks in each album.
SELECT
	track,
	AVG(Danceability) average_danceability
FROM spotify_tbl
GROUP BY track


-- Find the top 5 tracks with the highest energy values.
SELECT TOP 5
	track,
	Energy
FROM spotify_tbl
ORDER BY Energy DESC

-- List all tracks along with their views and likes where official_video = TRUE .
SELECT
	track,
	views,
	likes,
	official_video
FROM spotify_tbl
WHERE official_video = 'True'


-- For each album, calculate the total views of all associated tracks.
SELECT
	track,
	album,
	views,
	SUM(views) OVER (PARTITION BY album) total_views 
FROM spotify_tbl



-- Retrieve the track names that have been streamed on Spotify more than YouTube. 
-- First, we aggregate the data with max equation so that the doubled tracks are grouped with the max number of stream either in youtube or spotify
-- Second, we use the self join to separat the streams from spotify and youtube in two different columns so that we can compare between them
WITH most_played_on AS(
	SELECT
		track,
		most_playedon,
		MAX(stream)  AS  mostplayedon
	FROM spotify_tbl
	GROUP BY track, most_playedon
)

SELECT
	S.track,
	s.mostplayedon AS spotify_stream,
	y.mostplayedon AS youtube_stream
FROM most_played_on s
INNER JOIN most_played_on y
ON s.track = y.track
WHERE s.most_playedon = 'Spotify'
AND y.most_playedon = 'Youtube'
AND s.mostplayedon > y.mostplayedon

-- ======================================
-- Data Analysis -- Advanced category
-- ======================================

-- Find the top 3 most viewed track for each artist using window function
SELECT
	*
FROM
(
SELECT
	artist,
	track,
	views,
	DENSE_RANK () OVER (PARTITION BY artist ORDER BY views DESC) ranking_views
FROM spotify_tbl
)t
WHERE ranking_views <= 3

-- Write a query to find tracks where the liveness score is above the average
SELECT
	*
FROM (
	SELECT DISTINCT
		track,
		liveness,
		AVG(liveness) OVER () average_liveness
	FROM spotify_tbl
)t
WHERE liveness > average_liveness

-- Use a with clause to calculate the difference between the highest and the lowest energy values for tracks in each album
WITH spotify_average_energy AS(
SELECT
	track,
	album,
	MAX(energy) OVER (PARTITION BY album, track) max_energy,
	MIN(energy) OVER (PARTITION BY album, track) min_energy
FROM spotify_tbl)

SELECT DISTINCT
	track,
	album,
	max_energy - min_energy AS diff_energy
FROM spotify_average_energy
ORDER BY diff_energy DESC

-- Find tracks where the energy to liveness ratio is higher than 1.2
SELECT
	track,
	CAST(energy AS FLOAT) / NULLIF(liveness, 0) AS energy_liveness_ratio
FROM spotify_tbl
WHERE energy / NULLIF(liveness, 0) > 1.2

-- Calculate the total cumulative sum of likes for all tracks ordered by the number of views

SELECT
	track,
	likes,
	views,
	SUM(likes) OVER (
		ORDER BY VIEWS DESC
		ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) cumulative_likes
FROM spotify_tbl

