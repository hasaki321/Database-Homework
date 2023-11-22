INSERT INTO users (email, password, profile) VALUES
('admin1@example.com', 'password1', 'Profile 1'),
('admin2@example.com', 'password2', 'Profile 2'),
('admin3@example.com', 'password3', 'Profile 3'),
('admin4@example.com', 'password4', 'Profile 4'),
('admin5@example.com', 'password5', 'Profile 5'),
('user1@example.com', 'password6', 'Profile 6'),
('user2@example.com', 'password7', 'Profile 7'),
('user3@example.com', 'password8', 'Profile 8'),
('user4@example.com', 'password9', 'Profile 9'),
('user5@example.com', 'password10', 'Profile 10'),
('user6@example.com', 'password11', 'Profile 11'),
('user7@example.com', 'password12', 'Profile 12'),
('user8@example.com', 'password13', 'Profile 13'),
('user9@example.com', 'password14', 'Profile 14'),
('user10@example.com', 'password15', 'Profile 15');

INSERT INTO posts (title, content, datetime, uid) VALUES
('Title 1', 'Content 1', '2023-01-01 12:00:00', 6),
('Title 2', 'Content  2', '2023-01-02 12:30:00', 6),
('Title 3', 'Content 3', '2023-01-03 13:00:00', 7),
('Title 4', 'Content 4', '2023-01-04 12:00:00', 8),
('Title 5', 'Content 5', '2023-01-05 12:30:00', 9),
('Title 6', 'Content 6', '2023-01-06 12:00:00', 6),
('Title 7', 'Content 7', '2023-01-07 12:30:00', 7),
('Title 8', 'Content 8', '2023-01-08 12:00:00', 8),
('Title 9', 'Content 9', '2023-01-09 12:30:00', 9),
('Title 0', 'Content 0', '2023-01-10 12:00:00', 10);

INSERT INTO comments (content, datetime, uid, pid) VALUES
('Comment 1', '2023-01-01 12:15:00', 8, 1),
('Comment 2', '2023-01-02 13:00:00', 8, 2),
('Comment 3', '2023-01-03 14:00:00', 7, 1),
('Comment 4', '2023-01-04 12:15:00', 9, 4),
('Comment 5', '2023-01-05 13:00:00', 8, 4),
('Comment 6', '2023-01-06 14:00:00', 6, 6),
('Comment 7', '2023-01-07 12:15:00', 7, 7),
('Comment 8', '2023-01-08 13:00:00', 8, 8),
('Comment 9', '2023-01-09 14:00:00', 9, 9),
('Comment 10', '2023-01-10 12:15:00', 10, 10);

-- ²åÈë¹ÜÀíÔ±Êý¾Ý
INSERT INTO admin (uid,permission_level) VALUES
(1,1),
(2,2),
(3,3),
(4,1),
(5,2);


INSERT INTO advertisement (content, uid) VALUES
('Ad Content 1', 1),
('Ad Content 2', 1),
('Ad Content 3', 3),
('Ad Content 4', 4),
('Ad Content 5', 5);

-- ²åÈë·ÖÀàÊý¾Ý
INSERT INTO categories (cat_name, cat_desc) VALUES
('Category 1', 'Description 1'),
('Category 2', 'Description 2'),
('Category 3', 'Description 3'),
('Category 4', 'Description 4'),
('Category 5', 'Description 5'),
('Category 6', 'Description 6'),
('Category 7', 'Description 7'),
('Category 8', 'Description 8'),
('Category 9', 'Description 9'),
('Category 10', 'Description 10');

-- ²åÈë¹ÜÀí¹ØÏµÊý¾Ý
INSERT INTO manage (uid, cat_id) VALUES
(1, 1),
(1, 2),
(2, 3),
(2, 4),
(3, 5),
(3, 6),
(4, 7),
(4, 8),
(5, 9),
(5, 10);

-- ²åÈë¶©ÔÄ¹ØÏµÊý¾Ý
INSERT INTO subscribe (uid, cat_id) VALUES
(6, 1),
(7, 2),
(8, 3),
(9, 4),
(10, 5),
(11, 1),
(12, 2),
(13, 3),
(14, 4),
(15, 5);

-- ²åÈë·ÖÀà¹ØÏµÊý¾Ý
INSERT INTO classify (pid, cat_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);


-- ²åÈëÈº×éÊý¾Ý
INSERT INTO groups (des) VALUES
('Group 1 Description'),
('Group 2 Description'),
('Group 3 Description'),
('Group 4 Description'),
('Group 5 Description'),
('Group 6 Description'),
('Group 7 Description'),
('Group 8 Description');

-- ²åÈëÈº×é¹ÜÀí¹ØÏµÊý¾Ý
INSERT INTO manage_group (uid, gid) VALUES
(1, 1),
(1, 2),
(2, 3),
(2, 4),
(2, 5),
(3, 6),
(3, 7),
(4, 8);

-- ²åÈëÈº×é³ÉÔ±¹ØÏµÊý¾Ý
INSERT INTO join_group (uid, gid) VALUES
(6, 1),
(7, 1),
(8, 2),
(9, 2),
(10, 3),
(11, 4),
(12, 4),
(13, 5),
(14, 6),
(15, 8);


-- ²åÈë¹«¸æÊý¾Ý
insert into announcement (gid, title, content) values
(1, 'New Product Launch', 'Content1.'), 
(2, 'Company Expansion', 'Content2.'), 
(3, 'Employee Recognition', 'Content3.'), 
(4, 'Special Promotion', 'Content4'), 
(5, 'Charity Event', 'Content5'), 
(1, 'New Partnership', 'Content6.'), 
(1, 'Company Milestone', 'Content7.'), 
(2, 'Product Update', 'Content8.'), 
(3, 'Employee Training', 'Content9.'), 
(4, 'New Office Opening', 'Content10');

-- ²åÈëºÚÃûµ¥Êý¾Ý
INSERT INTO black_list (uid, other_uid) VALUES
(6, 7),
(6, 8),
(6, 9),
(6, 10),
(8, 9),
(10, 11),
(11, 12),
(12, 13),
(13, 14),
(14, 15);


-- ²åÈëºÃÓÑ¹ØÏµÊý¾Ý
INSERT INTO friend_list (uid, other_uid) VALUES
(6, 8),
(7, 9),
(8, 10),
(9, 10),
(10, 11);