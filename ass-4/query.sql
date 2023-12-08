-- 向当前帖子下作为某个用户向其中添加评论
INSERT INTO comments (cid, content, datetime, uid, pid) VALUES
(20011, 'Comment 1', '2023-01-01 12:15:00', 10008, 1);

-- 查询某个帖子下的所有评论
select * 
from comments
where comments.pid = 1;

-- 将某个用户添加进管理员并赋予权限
INSERT INTO admin (uid, permission_level) VALUES
(10006, 1);

-- 作为某个用户发布新的帖子并将其归到某个类别下
INSERT INTO posts (pid, title, content, datetime, uid) VALUES
(100, 'Title 1', 'Content 1', '2023-01-01 12:00:00', 10006);

INSERT INTO classify (pid, cat_id) VALUES
(100, 40001);

-- 查询某个类别下所有的帖子内容
select * from posts
where pid in
(select pid 
from classify
where cat_id = 40001);

-- 查询某个用户所有的朋友
(select other_uid
from friend_list 
where uid = 10001)
union
(select uid
from friend_list 
where other_uid = 10001);

-- 作为某个用户取消关注某个类别
delete from subscribe
where uid = 10006;

-- 作为某个用户加入某个群组
INSERT INTO join_group (uid, gid) VALUES
(10001, 50001);

-- 作为某个用户移除自己发布的帖子
delete from posts
where uid = 10001;

-- 作为一名用户将其他用户加入黑名单并将其移出朋友列表如果是朋友
INSERT INTO black_list (uid, other_uid) VALUES
(10006, 10007);

delete from friend_list
where uid = 10006 and other_uid = 10007
or uid = 10006 and other_uid = 10007;




-- type 1 自连接 -6
-- 寻找相互拉黑的成对用户
-- revealing reciprocal blocking connections between users in the system.
select b1.uid, b1.other_uid
from black_list b1, black_list b2
where b1.other_uid=b2.uid 
and b2.other_uid = b1.uid 
and b1.uid < b1.other_uid;

-- 寻找该帖子的作者的其他帖子
-- providing insights into other posts made by the same user in the system.
SELECT p2.pid
FROM posts p1, posts p2
WHERE p1.uid = p2.uid
AND p1.pid = 1
AND p2.pid <> 1;

-- 寻找在该贴子下发布评论的用户在该贴子下的其他评论
-- providing insights into additional contributions and interactions by the user within the specific post discussion.
select c2.cid 
from comments c1, comments c2
where c1.uid = c2.uid
and c1.cid = 20011
and c2.cid <> c1.cid;

-- 寻找在该群组下同时加入了多个群组的用户
-- revealing individuals with diverse group memberships and potential cross-group interactions.
SELECT j1.uid
FROM join_group j1on
JOIN join_group j2 ON j1.uid = j2.uid
WHERE j1.gid = 50001
GROUP BY j1.uid
HAVING COUNT(j1.uid) > 1;

-- 寻找某个用户所有朋友的朋友
-- unveiling potential secondary connections and expanding the social network view.
select distinct f2.other_uid 
from friend_list f1, friend_list f2
where
    f1.other_uid = f2.uid
and
    f1.uid = 10010;

-- 寻找在同一天发布的所有贴子
-- The query identifies and retrieves pairs of posts that were published on the same day, providing insights into simultaneous content creation events within the system.
SELECT *
FROM
    posts p1
JOIN
    posts p2 ON p1.datetime = p2.datetime
            AND p1.pid <> p2.pid
ORDER BY
    p1.datetime;

-- type 2 聚合 -7
-- 查询在指定日期后发表帖子数大于1的用户
-- The query identifies users who have posted more than one post after the specified date, offering insights into consistently active contributors in the system.
select uid, count(pid)
from posts
where datetime > '2023-01-04 12:00:00'
group by uid
having count(pid)>1;

-- 查询订阅用户数大于1的类别
-- highlighting popular or common interest areas among users in the system.
select cat_id 
from subscribe
group by cat_id
having count(uid)>1;

-- 查询用户数量大于1的群组
-- revealing communities within the system that consist of multiple users sharing common interests or affiliations.
select gid 
from join_group
group by gid
having count(uid)>1;

-- 查询发帖数量大于1的类别
-- indicating active engagement and diverse content within those specific interest areas in the system.
SELECT cat_id
FROM classify
GROUP BY cat_id
HAVING COUNT(pid) > 1;

-- 找出订阅用户最多的类别
-- revealing the most popular interest area with the largest user base in the system.
SELECT cat_id
FROM subscribe
GROUP BY cat_id
ORDER BY COUNT(uid) DESC
LIMIT 1;


----------------------------------------------DIVISION---------------------------------------------

--显示用户信息以及发帖数量
select u.uid, u.email, p.post_count
from users u
join (select uid, count(pid) as post_count
      from posts
      group by uid) p on u.uid = p.uid;

--找出发表文章最多的前3位用户
SELECT uid, COUNT(pid) AS post_count
FROM posts
GROUP BY uid
ORDER BY post_count DESC
LIMIT 3;

-- type 3 复合聚合 -6
-- 已发布帖子用户中每个用户平均发布多少帖子
select avg(total_amount)
from 
(select count(pid) as total_amount
from posts
group by uid) as total_table;

-- 平均每人发布多少评论
create view comments_users as
(select count(cid) as total_comments
from comments
group by uid);

select avg(total_comments)
from comments_users;

-- 每个帖子平均拥有多少评论
create view comments_posts as
(select count(cid) as total_comments
from comments
group by pid);

select avg(total_comments)
from comments_posts;

-- 寻找同时加入一个以上群组的用户有多少
CREATE VIEW total_users_group AS
(
  SELECT uid
  FROM join_group
  GROUP BY uid
  HAVING COUNT(gid) > 1
);

SELECT COUNT(total_users_group)
FROM total_users_group;


-- 寻找一个群组中平均拥有的告示条目
select avg(total_ann)
from 
(select count(aid) as total_ann
from announcement
group by gid) AS group_announcements;

-- 每个管理员平均发布多少条广告
select avg(total_adv)
from 
(select count(id) as total_adv
from advertisement
group by uid) AS admin_adv;

--type4 嵌套否定 -5
-- 查询非管理员用户发表的帖子
select * from posts
where uid 
not in
(select uid from admin);

-- 查询还没有加入群组的用户
SELECT uid
FROM users
WHERE NOT EXISTS (
SELECT uid
FROM join_group
WHERE join_group.uid = users.uid
);

-- 查询还没有添加朋友的用户
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

--查找不在黑名单且不是管理员的名单
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

--列出所有发表过至少一篇文章的非管理员用户
SELECT DISTINCT users.uid, email, profile
FROM users
JOIN posts ON users.uid = posts.uid
WHERE users.uid NOT IN (SELECT uid FROM admin);


--type 5 外连接 -8  
-- 查询pid=1的帖子下的评论
select * from comments
right join posts 
on posts.pid = comments.pid
where posts.pid = 1;

-- 寻找某个用户关注的分类下最新发布的5个贴子
select * from posts p
right join classify c
    on p.pid = c.pid
right join subscribe s
    on s.cat_id = c.cat_id
where s.uid = 10010
order by datetime desc
limit 5;

-- 寻找某用户发布的贴子下最新的3条评论
select * from comments c
right join posts p
    on c.pid = p.pid
where p.uid = 10006
order by c.datetime desc
limit 5;

-- 寻找某类别下的贴子中所有评论中最新的5条
select * from comments c
right join classify cl
    on c.pid = cl.pid
where cl.cat_id = 40001
order by c.datetime desc
limit 5;

-- 寻找负责管理某贴子所属类别的所有管理员
select a.uid from admin a
right join manage m
    on a.uid = m.uid
right join classify c
    on m.cat_id = c.cat_id
where c.pid = 1;

-- 查询某管理员管理的群组下的发帖数量超过1的所有用户
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

--查询某个用户加入了哪些群组
select groups.gid as group_id, groups.des
from groups
right join join_group on groups.gid = join_group.gid
where join_group.uid = 10008;

--查找没有评论的文章
SELECT posts.pid, title
FROM posts
LEFT JOIN comments ON posts.pid = comments.pid
WHERE comments.cid IS NULL;

