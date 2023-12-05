

-- [requirement]请将查询语句中查询/修改/删除的内容更改或者向数据库中增加值以完成正常查询操作


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
where cat_id = 1) 

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




-- type 1
-- 寻找相互拉黑的成对用户
select b1.uid, b1.other_uid
from black_list b1, black_list b2
where b1.other_uid=b2.uid 
and b2.other_uid = b1.uid 
and b1.uid < b1.other_uid

-- 寻找该帖子的作者的其他帖子
select p2.pid
from posts p1, posts p2
where p1.uid = p2.uid
and p1.pid = 1
except pid=1

-- type 2
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

-- [TODO]查询用户数量大于1的群组
-- [TODO]查询发帖数量大于1的类别

-- type 3
-- 已发布帖子用户中每个用户平均发布多少帖子
select avg(total_amount)
from 
(select count(pid) as total_amount
from posts
group by uid) as total_table

-- [TODO]平均发布多少评论
-- [TODO]每个帖子平均拥有多少评论

--type4
-- 查询非管理员用户发表的帖子
select * from posts
where uid 
not in
(select uid from admin)

--type 5 
-- 查询pid=1的帖子下的评论
select * from comments
right join posts 
on posts.pid = comments.pid
where posts.pid = 1