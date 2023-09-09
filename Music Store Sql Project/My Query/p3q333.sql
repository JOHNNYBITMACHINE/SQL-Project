--  2. Let's invite the artists who have written the most rock music in our dataset.
--  Write a query that returns the Artist name and total track count of the top 10 rock bands 


SELECT  count(*) FROM ARTIST;
SELECT count(*) FROM ALBUM;

select count(*) from track;

select count(*) from genre;

select a.artist, a.rock_music from 
									(with ct as 
											(with cty as 
													(with ctx as 
																(with ct as 
																		(select  a.artist_id, a.name as artist , b.album_id  from album b left join artist a on a.artist_id = b.artist_id)
                                                                        
																select a.artist_id, a.artist,b.track_id, b.name as track_name , b.genre_id from track b left join ct a on a.album_id = b.album_id)
                                                                
													select a.artist, a.track_id , a.track_name, b.name as song_name , b.genre_id  from ctx a left join genre b on a.genre_id = b.genre_id where b.genre_id=1)
                                                    
											select artist, count(track_name) as rock_music from  cty group by artist)
                                            
								select artist, rock_music, dense_rank() over (order by rock_music desc) as rnk from ct )
			a where a.rnk <11;
;






