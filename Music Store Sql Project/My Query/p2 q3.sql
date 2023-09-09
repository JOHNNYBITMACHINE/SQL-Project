use music;

-- 3. Return all the track names that have a song length longer than the average song length.
 -- Return the Name and Milliseconds for each track. 
 -- Order by the song length with the longest songs listed first




with ct as 
(select name, milliseconds, avg(milliseconds) over () as avg_length from track)
					select name as Song_name, milliseconds as Track_length_sec from ct where milliseconds>avg_length order by milliseconds desc ;
