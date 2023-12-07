--查询某一天的所有帖子
select content
from comments
where date(datetime) = '2023-01-01'
and uid = 10008;

--查询某个用户加入了哪些群组
select groups.gid as group_id, groups.des
from groups
join join_group on groups.gid = join_group.gid
where join_group.uid = 10008;

--查询某个管理员的管理员等级权限
select admin.permission_level
from admin
where admin.uid = 10002;

--更改某个管理员的权限等级
update admin
set permission_level = 2
where uid = 10002;

--撤销某个管理员的管理员权限
delete from admin
where uid = 10003;

--显示每个用户及其朋友的电子邮箱地址
select u1.email as user_email, u2.email as friend_email
from friend_list f
join users u1 on f.uid = u1.uid
join users u2 on f.other_uid = u2.uid;

--显示用户信息以及发帖数量
select u.uid, u.email, p.post_count
from users u
join (select uid, count(pid) as post_count
      from posts
      group by uid) p on u.uid = p.uid;

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

--用户及其相关评论的信息
select u.uid, u.email, c.cid
from users u
left join comments c on u.uid = c.uid;

