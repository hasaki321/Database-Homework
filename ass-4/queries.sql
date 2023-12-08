--Requirement query
--(1) Query all the comments that belongs to a user
SELECT * FROM comments WHERE uid = 10008;

--(2) Find out the number of posts for a certain user.
SELECT COUNT(*) FROM posts WHERE uid = 10006;

--(3) Query which categories a user A subscribes to the same as user B.
SELECT DISTINCT s1.cat_id FROM subscribe s1, subscribe s2
WHERE s1.uid = 10006 AND s2.uid = 10011 AND s1.cat_id = s2.cat_id;

--(4) Queries the number of the same users in two different groups
SELECT COUNT(*) FROM join_group g1, join_group g2
WHERE g1.uid = g2.uid AND g1.gid <> g2.gid AND g1.gid = 50001 AND g2.gid = 50002;

--(5) Query the IDs of all advertisements posted by the administrator
SELECT id FROM advertisement WHERE uid = 10003;

--(6)Get a limited number of posts from the database except the posts published by the users in the black list of a certain user.
SELECT * FROM posts
WHERE uid NOT IN (SELECT other_uid FROM black_list WHERE uid = 10006)
LIMIT 3;

--(7) Administrator create a group given a group id and description
INSERT INTO groups (gid, des) VALUES (50010, 'Group 10 Description');

--(8) Find out the commenter according to a comment in a certain post
SELECT c.uid, u.email FROM comments c
JOIN users u ON c.uid = u.uid
WHERE c.pid = 8;

--(9) Find out all the posts that belong to a selected category
SELECT * FROM posts
WHERE pid IN (SELECT pid FROM classify WHERE cat_id = 40006);

--(10) Show up all the posts that the poster is in the friend list of the current user.
SELECT p.* FROM posts p
WHERE p.uid IN (
    SELECT f.uid
    FROM friend_list f
    WHERE f.other_uid = 10011
    UNION 
    SELECT f.other_uid
    FROM friend_list f
    WHERE f.uid = 10011
);



-- New query
-- TYPE 1: Joins involving the same table twice (6 in all)
-- Query all other posts by the author of a certain post
SELECT p2.pid
FROM posts p1, posts p2
WHERE p1.uid = p2.uid
AND p1.pid = 1
AND p2.pid <> 1;

-- Find other comments under the post by the user who posted a comment under the post
select c2.cid 
from comments c1, comments c2
where c1.uid = c2.uid
and c1.cid = 20011
and c2.cid <> c1.cid;

-- Find users in a certain group who have joined more than one group 
SELECT j1.uid
FROM join_group j1
JOIN join_group j2 ON j1.uid = j2.uid
WHERE j1.gid = 50001
GROUP BY j1.uid
HAVING COUNT(j1.uid) > 1;

-- Find all posts published on the same day
SELECT *
FROM
    posts p1
JOIN
    posts p2 ON p1.datetime = p2.datetime
            AND p1.pid <> p2.pid
ORDER BY
    p1.datetime;


-- Look for pairs of users that block each other
select b1.uid, b1.other_uid
from black_list b1, black_list b2
where b1.other_uid=b2.uid 
and b2.other_uid = b1.uid 
and b1.uid < b1.other_uid;

-- Find the friends of all the friends of a user
select distinct f2.other_uid 
from friend_list f1, friend_list f2
where
    f1.other_uid = f2.uid
and
    f1.uid = 10010;


-- type 2 Aggregation with a group by and having clause (5 in all)
-- Find users who have posted more than 1 posts after the specified date
select uid, count(pid)
from posts
where datetime > '2023-01-04 12:00:00'
group by uid
having count(pid)>1;

-- Find the category with the most subscribers
SELECT cat_id
FROM subscribe
GROUP BY cat_id
ORDER BY COUNT(uid) DESC
LIMIT 1;

-- Display user information and the number of posts 
select u.uid, u.email, p.post_count
from users u
join (select uid, count(pid) as post_count
      from posts
      group by uid) p on u.uid = p.uid;

--Find the top 3 users who post the most
SELECT uid, COUNT(pid) AS post_count
FROM posts
GROUP BY uid
ORDER BY post_count DESC
LIMIT 3;

-- Query the categories with more than 1 posts
SELECT cat_id
FROM classify
GROUP BY cat_id
HAVING COUNT(pid) > 1;

-- TYPE 3: Nesting with aggregation (6 in all)

-- Average number of comments per post
select avg(total_comments)
from 
(select count(cid) as total_comments
from comments
group by pid) as total_table;

-- Average number of posts per user among users who published posts
select avg(total_amount)
from 
(select count(pid) as total_amount
from posts
group by uid) as total_table;

-- The average number of comments per person
select avg(total_comments)
from 
(select count(cid) as total_comments
from comments
group by uid) as total_table;


-- Find how many users join more than one group at a time
SELECT COUNT(total_users)
FROM
(
  SELECT uid
  FROM join_group
  GROUP BY uid
  HAVING COUNT(gid) > 1
) AS total_users;


-- Look for the average number of announcements owned by a group
select avg(total_ann)
from 
(select count(aid) as total_ann
from announcement
group by gid) AS group_announcements;

-- How many ads are posted per admin on average
select avg(total_adv)
from 
(select count(id) as total_adv
from advertisement
group by uid) AS admin_adv;

-- TYPE 4: Nested negation, involving NOT EXISTS or NOT IN (4 in all)

-- Find users who haven't joined the group yet
SELECT uid
FROM users
WHERE NOT EXISTS (
SELECT uid
FROM join_group
WHERE join_group.uid = users.uid
);

-- List all non-admin users who have published at least one article
SELECT DISTINCT users.uid, email, profile
FROM users
RIGHT JOIN posts ON users.uid = posts.uid
WHERE users.uid NOT IN (SELECT uid FROM admin);

-- Query for users who haven't added friends yet
SELECT uid
FROM users
WHERE uid
NOT IN (
SELECT DISTINCT uid
FROM friend_list
UNION
SELECT DISTINCT other_uid AS uid
FROM friend_list
);

-- Find a list that is not blacklisted and is not an administrator
select uid, email
from users u
where not exists (
    select 1
    from black_list b
    where b.uid = u.uid
) and not exists(
	select 2
	from admin a
	where a.uid = u.uid
);

-- TYPE 5: Outer join (8 in all)
-- Query for comments under posts with pid=1
select * from comments
right join posts 
on posts.pid = comments.pid
where posts.pid = 1;

-- Find the 5 most recent posts in a user's category
select * from posts p
right join classify c
    on p.pid = c.pid
right join subscribe s
    on s.cat_id = c.cat_id
where s.uid = 10010
order by datetime desc
limit 5;

-- Find the last three comments on a user's post
select * from comments c
right join posts p
    on c.pid = p.pid
where p.uid = 10006
order by c.datetime desc
limit 5;

-- Find the 5 most recent comments in a category
select * from comments c
right join classify cl
    on c.pid = cl.pid
where cl.cat_id = 40001
order by c.datetime desc
limit 5;

-- Find all administrators responsible for the category to which a post belongs
select a.uid from admin a
right join manage m
    on a.uid = m.uid
right join classify c
    on m.cat_id = c.cat_id
where c.pid = 1;

-- Query all users with more than 1 post in a group managed by an administrator
select s1.uid from
(select m.gid from manage_group m
where m.uid = 10001) as s2
left join 
(select j.uid,j.gid from join_group j
where j.uid in
(select uid from posts
group by uid
having count(pid)>1)) as s1
on s1.gid = s2.gid;

-- Query which groups a user is a member of
select groups.gid as group_id, groups.des
from groups
right join join_group on groups.gid = join_group.gid
where join_group.uid = 10008;

-- Find articles without comments
SELECT posts.pid, title
FROM posts
LEFT JOIN comments ON posts.pid = comments.pid
WHERE comments.cid IS NULL;

-- TYPE 6:  Usage of an auxiliary view (4 in all)
-- Find the average number of comments per person
create view comments_users as
(select count(cid) as total_comments
from comments
group by uid);

select avg(total_comments)
from comments_users;

-- Find how many users join more than one group at a time
CREATE VIEW total_users_group AS
(
  SELECT uid
  FROM join_group
  GROUP BY uid
  HAVING COUNT(gid) > 1
);

SELECT COUNT(total_users_group)
FROM total_users_group;

-- Query for users who haven't added friends yet
create view friend_uid as (
SELECT DISTINCT uid
FROM friend_list
UNION
SELECT DISTINCT other_uid AS uid
FROM friend_list
);

SELECT uid
FROM users
WHERE uid
NOT IN (SELECT uid FROM friend_uid);

-- Query all users with more than 1 post in a group managed by an administrator
CREATE VIEW s2 AS
(select m.gid from manage_group m
where m.uid = 10001);

CREATE VIEW s1 AS
(select j.uid,j.gid from join_group j
where j.uid in
(select uid from posts
group by uid
having count(pid)>1));

select s1.uid from
s1 left join s2
on s1.gid = s2.gid;