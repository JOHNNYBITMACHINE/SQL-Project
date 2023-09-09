use music;

-- 7 2. Let's invite the artists who have written the most rock music in our dataset.
--  Write a query that returns the Artist name and total track count of the top 10 rock bands 



select * from artist; 
select * from album;
select * from track;



 select a.artist_name, a.Rock_tracks  
				from 
					(with ctxx as 
							(select a.artist_name, count(track_name) as Rock_tracks
										from
									(with cty as 
											(with ctx as 
														(with ct as
																	(select alb.album_id, b.name  from album alb left join artist b on alb.artist_id = b.artist_id)
																
                                                                select Tra.genre_id ,tra.name as track_name,  b.name as artist_name from track tra left join ct b on tra.album_id = b.album_id) 
													
                                                    select a.track_name, a.artist_name, b.name as genre_name from ctx a left join genre b on a.genre_id = b.genre_id  where lower(b.name) = 'rock')
                                                    
										select distinct track_name, artist_name, genre_name from cty)
                                        
							a group by a.artist_name order by Rock_tracks desc)

select artist_name, Rock_tracks , dense_rank() over (order by Rock_tracks desc) as rnk  from ctxx)  a  where rnk <11;














