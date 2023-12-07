/*
Group S
Qinru Yang -320220940961
Rongsen He -320220940271
Ronghao Li -320220940401
Rongxuan Wang -320220940781
*/


--To keep user accounts secure, password should not be empty.
create table users (
    uid int primary key,
    email char(30),
    password char(20) not null,
    profile varchar(100)
);

--Admin is a user and its uid reference to users
--Admin permission need to be deleted before the deletion of corresponding user
--So it should be on delelte no action and permission_level should be not null
create table admin (
    uid int primary key,
    permission_level int not null,

    foreign key (uid) 
    references users
    on delete no action
);

--Posts and users have a N-to-1 relationship. 
--Posts is written by user and its uid reference to users. 
--So if a user be signed out，user's posts will be deleted.
create table posts (
    pid int primary key,
    title varchar(40) not null,
    content varchar(500) not null,
    datetime timestamp,
    uid int,

    foreign key (uid)
    references users
    on delete cascade
);

--Comments have a N-to-1 relationship with posts and user. 
--Comments is written by user and it is owned by a post. So it has uid and pid reference to users and posts.
--So if a user or a post is deleted，correlative comments will be deleted.
create table comments (
    cid int primary key,
    content varchar(100) not null,
    datetime timestamp,
    uid int,
    pid int,

    foreign key (uid)
    references users,
    foreign key (pid)
    references posts
    on delete cascade
);

--An advertisement is publish by an admin and it has uid reference to admin.
--If an admin is deleted, advertisement should not be deleted, so just need set foreign key null.
create table advertisement (
    id int primary key,
    content varchar(200) not null,
    uid int,

    foreign key (uid)
    references admin
    on delete set null
);

--To facilitate user identification, category names should not be empty
create table categories(
    cat_id int primary key,
    cat_name char(20) not null,
    cat_desc varchar(50)
);

--manage relation is a n-to-n relation, so the relation has two references.
--If a category is deleted, its data in this table should be deleted. 
--If an admin is deleted, the data in this table should be deleted. 
create table manage(
    uid int,
    cat_id int,

    primary key (uid,cat_id),

    foreign key (uid)
    references admin
    on delete cascade,
    foreign key (cat_id)
    references categories
    on delete cascade
);

--subscribe relation is a n-to-n relation, reference to both users and category
--If a category is deleted, its data in this table should be deleted.
--If a user is deleted, its data in this table should be deleted.
create table subscribe(
    uid int,
    cat_id int,

    primary key(uid,cat_id),

    foreign key (uid)
    references users
    on delete cascade,
    foreign key (cat_id)
    references categories
    on delete cascade
);

--classify relation is a n-to-n relation, reference to both posts and categories
--If a category is deleted, its data in this table should be deleted
--If a post is deleted, its data in this table should be deleted
create table classify(
    pid int,
    cat_id int,

    primary key(pid,cat_id),

    foreign key (pid)
    references posts
    on delete cascade,
    foreign key (cat_id)
    references categories
    on delete cascade
);

create table groups(
    gid int primary key,
    des varchar(100)
);

--manage_group is a n-to-n relation. So it have both key reference to admin and group
--If a group is deleted, its data in this table should be deleted
--If a admin is deleted, its data in this table should be deleted
create table manage_group(
    uid int,
    gid int,

    primary key(uid,gid),

    foreign key (uid)
    references admin
    on delete cascade,
    foreign key (gid)
    references groups
    on delete cascade
);

--join_group is a n-to-n relation, so it have foreign key reference to user and group
--If a group is deleted, its data in this table should be deleted
--If a user is deleted, its data in this table should be deleted
create table join_group(
    uid int,
    gid int,

    primary key(uid,gid),

    foreign key (uid)
    references users
    on delete cascade,
    foreign key (gid)
    references groups
    on delete cascade
);

--It is a weak entity that links to group, so one of its primary key reference to group
--If a group is deleted, its announcements should be deleted
--Announcements often must have non-empty titles and content
create table announcement(
    aid int,
    gid int,
    title char(40) not null,
    content varchar(100) not null,

    primary key(aid,gid),

    foreign key (gid)
    references groups
    on delete cascade
);

--One user could add others into blacklist，so both of its key reference to user.uid
--If a user is deleted, its data in this table should be deleted
create table black_list(
    uid int,
    other_uid int,

    primary key(uid,other_uid),

    foreign key (uid)
    references users(uid)
    on delete cascade,
    foreign key (other_uid)
    references users(uid)
    on delete cascade
);

--One user could add others into friend list，so both of its key reference to user.uid
--If a user is deleted, its data in this table should be deleted
create table friend_list(
    uid int,
    other_uid int,

    primary key(uid,other_uid),

    foreign key (uid)
    references users(uid)
    on delete cascade,
    foreign key (other_uid)
    references users(uid)
    on delete cascade
);



