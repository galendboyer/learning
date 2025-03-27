-- 4. Spotify - Aggregation and Window Functions in SQL
-- 4-Spotify-AggregationAndWindowFunctions
-- https://lnkd.in/gtfaugd3


WITH cte AS (
SELECT 
        songs.artist_id
,       COUNT(1) as no_of_appearances
FROM songs 
INNER JOIN global_song_rank AS gsr ON gsr.song_id = songs.song_id
WHERE gsr.rank <= 10
GROUP BY songs.artist_id
)

, cte2 AS (
SELECT cte.*
,      DENSE_RANK() OVER (ORDER BY no_of_appearances DESC) as rn
FROM cte 
)

SELECT
       artists.artist_name
,      cte2.rn
FROM cte2
INNER JOIN artists ON artists.artist_id = cte2.artist_id
WHERE rn <= 5
ORDER BY 2,1
