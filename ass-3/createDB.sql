create table users (
    uid serial primary key,
    email char(20),
    password char(20) not null,
    profile varchar(100)
);

--admin is a user and its uid reference to users
create table admin (
    uid int primary key,
    permission_level int,

    foreign key (uid) 
    references users
    on delete no action
);

-- posts is written by user and its uid reference to users
create table posts (
    pid serial primary key,
    title varchar(40) not null,
    content varchar(500) not null,
    datetime timestamp,
    uid int,

    foreign key (uid)
    references users
    on delete cascade
);


-- comments is written by user 
-- and it is owned by a post
-- so it have uid and pid reference to users and posts
create table comments (
    cid serial primary key,
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

-- an ad is publish by and admin 
-- and it have uid reference to admin
create table advertisement (
    id serial primary key,
    content varchar(200) not null,
    uid int,

    foreign key (uid)
    references admin
    on delete set null
);

create table categories(
    cat_id serial primary key,
    cat_name char(10) not null,
    cat_desc varchar(50)
);

-- an cat is managed by an admin
-- so the relation has two references
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

-- a relation ship of subscribe,
-- reference to both users and cat
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

-- a relation of categorie classification
-- its two keys reference to posts and cat
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
    gid serial primary key,
    des varchar(100)
);

-- a group could managed by admin
-- so it have both key reference to admin and group
create table manage_g(
    uid int,
    gid int,

    primary key(uid,gid),

    foreign key (uid)
    references admin
    on delete cascade,
    foreign key (gid)
    references categories
    on delete cascade
);

-- a table of group join relation
-- have foreign key reference to user and group
create table join_g(
    uid int,
    gid int,

    primary key(uid,gid),

    foreign key (uid)
    references users
    on delete cascade,
    foreign key (gid)
    references categories
    on delete cascade
);

-- a weak entity that links to group
-- so one of its primary key reference to group
create table announcement(
    aid serial,
    gid int,
    title char(40) not null,
    content varchar(100),

    primary key(aid,gid),

    foreign key (gid)
    references groups
    on delete cascade
);

-- one user could add others into blacklist
-- so both of its key reference to user.uid
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

-- almost the same as above
-- both of the key reference to user.uid
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



