
-- application domain
-- 向当前帖子下作为某个用户向其中添加评论
INSERT INTO comments (cid, content, datetime, uid, pid) VALUES
(20001, 'Comment 1', '2023-01-01 12:15:00', 10008, 1),
-- [Problem]现在有一个问题，如果不设置自增的话自增将要将值记录在服务器中或者另外定义一套cid生成规则来插入

-- 查询某个帖子下的所有评论
select * 
from comments
where comments.pid = 1

-- 将某个用户添加进管理员并赋予权限
INSERT INTO admin (uid, permission_level) VALUES
(10001, 1)

-- 作为某个用户发布新的帖子并将其归到某个类别下
INSERT INTO posts (pid, title, content, datetime, uid) VALUES
(100, 'Title 1', 'Content 1', '2023-01-01 12:00:00', 10006);
-- [Problem]问题同上，需要手动插入pid
INSERT INTO classify (pid, cat_id) VALUES
(100, 40001)

-- 查询某个类别下所有的帖子内容
select * from posts
where pid in
(select pid 
from classify
where cat_id = 40001)
-- [Fixed] 表classify中没有1这类序号，改为40001之后可正常查询

-- 查询某个用户所有的朋友
(select other_uid
from friend_list 
where uid = 10001)
union
(select uid
from friend_list 
where other_uid = 10001)

-- 作为某个用户取消关注某个类别
delete from subscribe
where uid = 10006

-- 作为某个用户加入某个群组
INSERT INTO join_group (uid, gid) VALUES
(10001, 50001)

-- 作为某个用户移除自己发布的帖子
delete from posts
where uid = 10001

-- 作为一名用户将其他用户加入黑名单并将其移出朋友列表如果是朋友
INSERT INTO black_list (uid, other_uid) VALUES
(10006, 10007);
delete from friend_list
where uid = 10006 and other_uid = 10007
or uid = 10006 and other_uid = 10007




-- type 1 自连接 -6
-- 寻找相互拉黑的成对用户
select b1.uid, b1.other_uid
from black_list b1, black_list b2
where b1.other_uid=b2.uid 
and b2.other_uid = b1.uid 
and b1.uid < b1.other_uid

-- 寻找该帖子的作者的其他帖子
SELECT p2.pid
FROM posts p1, posts p2
WHERE p1.uid = p2.uid
AND p1.pid = 1
AND p2.pid != 1
-- [Fixed] 语法错误 在 "pid" 或附近的LINE 5: except pid=1

-- 寻找在该贴子下发布评论的用户在该贴子下的其他评论
select c2.cid 
from comments c1, comments c2
where c1.uid = c2.uid
and c1.pid = 1
and c2.cid <> c1.cid

-- 寻找在该群组下同时加入了多个群组的用户
SELECT j1.uid
FROM join_group j1
JOIN join_group j2 ON j1.uid = j2.uid
WHERE j1.gid = 50001
GROUP BY j1.uid
HAVING COUNT(j1.uid) > 1;

-- 寻找某个用户所有朋友的朋友
select distinct f2.other_uid 
from friend_list f1, friend_list f2
where
    f1.other_uid = f2.uid
and
    f1.uid = 10010

-- 寻找在同一天发布的所有贴子
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
select uid, count(pid)
from posts
where datetime > '2023-01-04 12:00:00'
group by uid
having count(pid)>1

-- 查询订阅用户数大于1的类别
select cat_id 
from subscribe
group by cat_id
having count(uid)>1

-- 查询用户数量大于1的群组
select gid 
from join_group
group by gid
having count(uid)>1

-- 查询发帖数量大于1的类别
SELECT cat_id, COUNT(pid) AS post_count
FROM classify
GROUP BY cat_id
HAVING COUNT(pid) > 1;
-- [Fixed] 错误： 字段 "classify.pid" 必须出现在 GROUP BY 子句中或者在聚合函数中使用LINE 1: select pid 

--找出订阅用户最多的类别
SELECT cat_id
FROM subscribe
GROUP BY cat_id
ORDER BY COUNT(uid) DESC
LIMIT 1;