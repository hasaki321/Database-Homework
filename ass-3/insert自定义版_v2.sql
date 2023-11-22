INSERT INTO users (uid, email, password, profile) VALUES
(10001, 'admin1@example.com', 'password1', 'Profile 1'),
(10002, 'admin2@example.com', 'password2', 'Profile 2'),
(10003, 'admin3@example.com', 'password3', 'Profile 3'),
(10004, 'admin4@example.com', 'password4', 'Profile 4'),
(10005, 'admin5@example.com', 'password5', 'Profile 5'),
(10006, 'user1@example.com', 'password6', 'Profile 6'),
(10007, 'user2@example.com', 'password7', 'Profile 7'),
(10008, 'user3@example.com', 'password8', 'Profile 8'),
(10009, 'user4@example.com', 'password9', 'Profile 9'),
(10010, 'user5@example.com', 'password10', 'Profile 10'),
(10011, 'user6@example.com', 'password11', 'Profile 11'),
(10012, 'user7@example.com', 'password12', 'Profile 12'),
(10013, 'user8@example.com', 'password13', 'Profile 13'),
(10014, 'user9@example.com', 'password14', 'Profile 14'),
(10015, 'user10@example.com', 'password15', 'Profile 15');

INSERT INTO posts (pid, title, content, datetime, uid) VALUES
(00001,'Title 1', 'Content 1', '2023-01-01 12:00:00', 10006),
(00002,'Title 2', 'Content 2', '2023-01-02 12:30:00', 10006),
(00003,'Title 3', 'Content 3', '2023-01-03 13:00:00', 10007),
(00004,'Title 4', 'Content 4', '2023-01-04 12:00:00', 10008),
(00005,'Title 5', 'Content 5', '2023-01-05 12:30:00', 10009),
(00006,'Title 6', 'Content 6', '2023-01-06 12:00:00', 10006),
(00007,'Title 7', 'Content 7', '2023-01-07 12:30:00', 10007),
(00008,'Title 8', 'Content 8', '2023-01-08 12:00:00', 10008),
(00009,'Title 9', 'Content 9', '2023-01-09 12:30:00', 10009),
(00010,'Title 0', 'Content 0', '2023-01-10 12:00:00', 10010);

-- ²åÈëÆÀÂÛÊý¾Ý
INSERT INTO comments (cid, content, datetime, uid, pid) VALUES
(20001, 'Comment 1', '2023-01-01 12:15:00', 10008, 00001),
(20002, 'Comment 2', '2023-01-02 13:00:00', 10008, 00002),
(20003, 'Comment 3', '2023-01-03 14:00:00', 10007, 00001),
(20004, 'Comment 4', '2023-01-04 12:15:00', 10009, 00004),
(20005, 'Comment 5', '2023-01-05 13:00:00', 10008, 00004),
(20006, 'Comment 6', '2023-01-06 14:00:00', 10006, 00006),
(20007, 'Comment 7', '2023-01-07 12:15:00', 10007, 00007),
(20008, 'Comment 8', '2023-01-08 13:00:00', 10008, 00008),
(20009, 'Comment 9', '2023-01-09 14:00:00', 10009, 00009),
(20010, 'Comment 0', '2023-01-10 12:15:00', 10010, 00010);

-- ²åÈë¹ÜÀíÔ±Êý¾Ý
INSERT INTO admin (uid, permission_level) VALUES
(10001, 1),
(10002, 2),
(10003, 3),
(10004, 1),
(10005, 2);

-- ²åÈë¹ã¸æÊý¾Ý
INSERT INTO advertisement (id, content, uid) VALUES
(50001, 'Ad Content 1', 10001),
(50002, 'Ad Content 2', 10001),
(50003, 'Ad Content 3', 10003),
(50004, 'Ad Content 4', 10004),
(50005, 'Ad Content 5', 10005);

-- ²åÈë·ÖÀàÊý¾Ý
INSERT INTO categories (cat_id, cat_name, cat_desc) VALUES
(60001, 'Category 1', 'Description 1'),
(60002, 'Category 2', 'Description 2'),
(60003, 'Category 3', 'Description 3'),
(60004, 'Category 4', 'Description 4'),
(60005, 'Category 5', 'Description 5');

-- ²åÈë¹ÜÀí¹ØÏµÊý¾Ý
INSERT INTO manage (uid, cat_id) VALUES
(10001, 60001),
(10002, 60002),
(10003, 60003),
(10004, 60004),
(10005, 60005);

-- ²åÈë¶©ÔÄ¹ØÏµÊý¾Ý
INSERT INTO subscribe (uid, cat_id) VALUES
(10006, 60001),
(10007, 60002),
(10008, 60003),
(10009, 60004),
(10010, 60005);

-- ²åÈë·ÖÀà¹ØÏµÊý¾Ý
INSERT INTO classify (pid, cat_id) VALUES
(00001, 60001),
(00002, 60002),
(00003, 60003),
(00004, 60004),
(00005, 60005);

-- ²åÈëÈº×éÊý¾Ý
INSERT INTO groups (gid, des) VALUES
(70001, 'Group 1 Description'),
(70002, 'Group 2 Description'),
(70003, 'Group 3 Description');

-- ²åÈëÈº×é¹ÜÀí¹ØÏµÊý¾Ý
INSERT INTO manage_group (uid, gid) VALUES
(10001, 70001),
(10002, 70002),
(10003, 70003);

-- ²åÈëÈº×é³ÉÔ±¹ØÏµÊý¾Ý
INSERT INTO join_group (uid, gid) VALUES
(10006, 70001),
(10007, 70001),
(10008, 70002),
(10009, 70002),
(10010, 70003);

-- ²åÈë¹«¸æÊý¾Ý
INSERT INTO announcement (aid, gid, title, content) VALUES
(80001, 70001, 'Announcement 1', 'Announcement Content 1'),
(80002, 70002, 'Announcement 2', 'Announcement Content 2'),
(80003, 70003, 'Announcement 3', 'Announcement Content 3');

-- ²åÈëºÚÃûµ¥Êý¾Ý
INSERT INTO black_list (uid, other_uid) VALUES
(10006, 10007),
(10008, 10009),
(10010, 10011);

-- ²åÈëºÃÓÑ¹ØÏµÊý¾Ý
INSERT INTO friend_list (uid, other_uid) VALUES
(10006, 10008),
(10007, 10009),
(10008, 10010),
(10009, 10010),
(10010, 10011);