
-- type 1
-- 寻找相互拉黑的成对用户
select b1.uid, b1.other_uid
from black_list b1, black_list b2
where b1.other_uid=b2.uid 
and b2.other_uid = b1.uid 
and b1.uid < b1.other_uid

-- type 2
-- 查询在指定日期后发表帖子数大于1的用户
select uid, count(pid)
from posts
where datetime > '2023-01-04 12:00:00'
group by uid
having count(pid)>1

-- type 3
-- 已发布帖子用户中每个用户平均发布多少帖子
select avg(total_amount)
from 
(select count(pid) as total_amount
from posts
group by uid) as total_table

--type4
-- 查询非管理员发表的帖子
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