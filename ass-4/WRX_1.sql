--type1
--查询包含多个用户的组
SELECT gid, COUNT(uid) AS user_count
FROM join_group
GROUP BY gid
HAVING COUNT(uid) > 1;

--找出发表文章最多的前3位用户
SELECT uid, COUNT(pid) AS post_count
FROM posts
GROUP BY uid
ORDER BY post_count DESC
LIMIT 3;


--type2
--查询用户数量大于1的群组
SELECT gid, COUNT(DISTINCT uid) AS user_count
FROM join_group
GROUP BY gid
HAVING COUNT(DISTINCT uid) > 1;

--查询发帖数量大于1的类别
SELECT cat_id, COUNT(DISTINCT pid) AS post_count
FROM classify
GROUP BY cat_id
HAVING COUNT(DISTINCT pid) > 1;

--查询具有多个帖子的类别
SELECT cat_id, COUNT(pid) AS post_count
FROM classify
GROUP BY cat_id
HAVING COUNT(pid) > 1;

--找出订阅用户最多的类别
SELECT cat_id
FROM subscribe
GROUP BY cat_id
ORDER BY COUNT(uid) DESC
LIMIT 1;


--type3
--平均发布多少评论
SELECT AVG(comment_count) AS average_comments_per_user
FROM (
  SELECT uid, COUNT(cid) AS comment_count
  FROM comments
  GROUP BY uid
) AS user_comments;

--每个帖子平均拥有多少评论
SELECT AVG(comment_count) AS average_comments_per_post
FROM (
  SELECT pid, COUNT(cid) AS comment_count
  FROM comments
  GROUP BY pid
) AS post_comments;

--找出每个用户的平均评论数
SELECT AVG(comment_count) as average_comments_per_user
FROM (
  SELECT uid, COUNT(cid) as comment_count
  FROM comments
  GROUP BY uid
) AS user_comments;

--计算系统中的评论总数
SELECT COUNT(*) AS total_comments
FROM comments;


--type4
--找出每篇文章的平均评论数
SELECT AVG(comment_count) as average_comments_per_post
FROM (
  SELECT pid, COUNT(cid) as comment_count
  FROM comments
  GROUP BY pid
) AS post_comments;

--列出所有发表过至少一篇文章的非管理员用户
SELECT DISTINCT users.uid, email, profile
FROM users
JOIN posts ON users.uid = posts.uid
WHERE users.uid NOT IN (SELECT uid FROM admin);

--type5
--查询特定文章的评论(pid=1)
SELECT comments.*
FROM comments
JOIN posts ON posts.pid = comments.pid
WHERE posts.pid = 1;

--查找没有评论的文章
SELECT posts.pid, title
FROM posts
LEFT JOIN comments ON posts.pid = comments.pid
WHERE comments.cid IS NULL;
