use johnny_hi;

-- 5 oldest users.

select * from users
order by created_at asc
limit 5;


-- What day of the week do most users register on?   We need to figure out when to schedule an ad campgain



with ct as (select dayname(created_at) as day, count(*) as most  from users group by 1)
select day , most from ct ;


-- We want to target our inactive users with an email campaign. Find the users who have never posted a photo.



select username from users u 
left join photos p
on u.id = p.user_id 
where p.user_id is null;


-- We're running a new contest to see who can get the most likes on a single photo. WHO WON?



SELECT users.username, photos.id, photos.image_url, COUNT(*) AS Total_Likes
FROM 
    photos 
JOIN 
    users 
ON 
    photos.user_id = users.id 
LEFT JOIN 
    likes 
ON 
    photos.id = likes.photo_id 
GROUP BY 
    photos.id 
ORDER BY 
    COUNT(*) DESC 
limit 10;


-- user ranking by postings higher to lower



SELECT users.username, COUNT(photos.image_url)
FROM users
LEFT JOIN photos ON users.id = photos.user_id
GROUP BY users.id
ORDER BY COUNT(photos.image_url) DESC;


-- Total Posts by users (longer versionof SELECT COUNT(*)FROM photos)



SELECT SUM(post_count) AS total_posts FROM (
  SELECT COUNT(*) AS post_count
  FROM photos
  GROUP BY user_id
) subquery;


-- Total numbers of users who have posted at least one time



SELECT COUNT(DISTINCT user_id) AS total_number_of_users_with_posts
FROM photos;


-- A brand wants to know which hashtags to use in a post. What are the top 5 most commonly used hashtags?



SELECT tags.tag_name, COUNT(*) AS count
FROM photo_tags
JOIN tags 
ON photo_tags.tag_id = tags.id 
GROUP BY photo_tags.tag_id
ORDER BY count DESC;


-- We have a small problem with bots on our site. Find users who have liked every single photo on the site



SELECT users.id, users.username, COUNT(DISTINCT photo_id) AS total_likes_by_user
FROM users
JOIN likes
ON users.id = likes.user_id
GROUP BY likes.user_id
HAVING COUNT(DISTINCT photo_id) = (SELECT COUNT(*) FROM photos);



-- We also have a problem with celebrities. Find users who have never commented on a photo



SELECT username, comments.comment_text
FROM users
LEFT JOIN comments
ON users.id = comments.user_id
WHERE comments.comment_text IS NULL;



-- Are we overrun with bots and celebrity accounts? Find the percentage of our users who have either never commented on a photo or have commented on every photo



SELECT tableA.total_A AS 'Number Of Users who never commented',(tableA.total_A/(SELECT COUNT(*) FROM users))*100 AS '%',tableB.total_B AS 'Number of Users who likes on every photos',(tableB.total_B/(SELECT COUNT(*) FROM users))*100 AS '%'FROM(SELECT COUNT(*) AS total_A 
FROM(SELECT username,comment_text 
FROM users 
LEFT JOIN comments 
ON users.id =comments.user_id 
GROUP BY users.id 
HAVING comment_text IS NULL) 
AS total_number_of_users_without_comments) 

AS tableA 

JOIN

(SELECT COUNT(*) AS total_B 

FROM
	(SELECT user_id AS id,username,count(*) AS total_likes_by_user FROM likes INNER JOIN users ON likes.user_id=users.id GROUP BY user_id  HAVING COUNT(*) = (SELECT COUNT(*) FROM photos)) AS total_number_users_with_likes)
AS tableB;





-- Find users who have ever commented on a photo






SELECT username,comment_text 
FROM users 
LEFT JOIN comments ON users.id = comments.user_id 
GROUP BY users.id 
HAVING comment_text IS NOT NULL;




-- Are we overrun with bots and celebrity accounts? Find the percentage of our users who have either never commented on a photo or have commented on photos before.



SELECT tableA.total_A AS 'Number Of Users who never commented',
(tableB.total_B/(SELECT COUNT(*) FROM users))*100 AS '%',
tableB.total_B AS 'Number of Users who commented on photos' 
FROM
(SELECT COUNT(*) AS total_A 
FROM 
(SELECT username,comment_text 
FROM users 
LEFT JOIN comments 
ON users.id = comments.user_id 
GROUP BY users.id 
HAVING comment_text IS NULL) 
AS total_number_of_users_without_comments) 
AS tableA JOIN	
(SELECT COUNT(*) AS total_B 
FROM
(SELECT username,comment_text 
FROM users 
LEFT JOIN comments 
ON users.id = comments.user_id 
GROUP BY users.id 
HAVING comment_text IS NOT NULL) 
AS total_number_users_with_comments)
AS tableB;




