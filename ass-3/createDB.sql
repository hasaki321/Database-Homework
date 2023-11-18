create table users (
    uid serial primary key,
    email char(20),
    password char(20),
    profile varchar(100)
);

create table admin (
    uid int primary key,
    permission_level int,

    foreign key (uid) 
    references users
    on delete no action
);

create table posts (
    pid serial primary key,
    title varchar(40),
    content varchar(500),
    datetime timestamp,
    uid int,

    foreign key (uid)
    references users
    on delete cascade
);

create table comments (
    cid serial primary key,
    content varchar(100),
    datetime timestamp,
    uid int,
    pid int,

    foreign key (uid)
    references users,
    foreign key (pid)
    references posts
    on delete cascade
);

create table advertisement (
    id serial primary key,
    content varchar(200),
    uid int,

    foreign key (uid)
    references admin
    on delete cascade
);

create table categories(
    cat_id serial primary key,
    cat_name char(10),
    cat_desc varchar(50)
);

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

create table announcement(
    aid int,
    gid int,
    title char(40),
    content varchar(100),

    primary key(aid,gid),

    foreign key (gid)
    references categories
    on delete cascade
);

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



