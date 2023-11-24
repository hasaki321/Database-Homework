INSERT INTO users (uid, email, password, profile) VALUES
(10001, 'admin1@example.com', 'password 1', 'Profile 1'),
(10002, 'admin2@example.com', 'password 2', 'Profile 2'),
(10003, 'admin3@example.com', 'password 3', 'Profile 3'),
(10004, 'admin4@example.com', 'password 4', 'Profile 4'),
(10005, 'admin5@example.com', 'password 5', 'Profile 5'),
(10006, 'user1@example.com', 'password 6', 'Profile 6'),
(10007, 'user2@example.com', 'password 7', 'Profile 7'),
(10008, 'user3@example.com', 'password 8', 'Profile 8'),
(10009, 'user4@example.com', 'password 9', 'Profile 9'),
(10010, 'user5@example.com', 'password 10', 'Profile 10'),
(10011, 'user6@example.com', 'password 11', 'Profile 11'),
(10012, 'user7@example.com', 'password 12', 'Profile 12'),
(10013, 'user8@example.com', 'password 13', 'Profile 13'),
(10014, 'user9@example.com', 'password 14', 'Profile 14'),
(10015, 'user10@example.com', 'password 15', 'Profile 15');

INSERT INTO posts (pid, title, content, datetime, uid) VALUES
(1, 'Title 1', 'Content 1', '2023-01-01 12:00:00', 10006),
(2, 'Title 2', 'Content 2', '2023-01-02 12:30:00', 10006),
(3, 'Title 3', 'Content 3', '2023-01-03 13:00:00', 10007),
(4, 'Title 4', 'Content 4', '2023-01-04 12:00:00', 10008),
(5, 'Title 5', 'Content 5', '2023-01-05 12:30:00', 10009),
(6, 'Title 6', 'Content 6', '2023-01-06 12:00:00', 10006),
(7, 'Title 7', 'Content 7', '2023-01-07 12:30:00', 10007),
(8, 'Title 8', 'Content 8', '2023-01-08 12:00:00', 10008),
(9, 'Title 9', 'Content 9', '2023-01-09 12:30:00', 10009),
(10, 'Title 10', 'Content 10', '2023-01-10 12:00:00', 10010);

INSERT INTO comments (cid, content, datetime, uid, pid) VALUES
(20001, 'Comment 1', '2023-01-01 12:15:00', 10008, 1),
(20002, 'Comment 2', '2023-01-02 13:00:00', 10008, 2),
(20003, 'Comment 3', '2023-01-03 14:00:00', 10007, 1),
(20004, 'Comment 4', '2023-01-04 12:15:00', 10009, 4),
(20005, 'Comment 5', '2023-01-05 13:00:00', 10008, 4),
(20006, 'Comment 6', '2023-01-06 14:00:00', 10006, 6),
(20007, 'Comment 7', '2023-01-07 12:15:00', 10007, 7),
(20008, 'Comment 8', '2023-01-08 13:00:00', 10008, 8),
(20009, 'Comment 9', '2023-01-09 14:00:00', 10009, 9),
(20010, 'Comment 10', '2023-01-10 12:15:00', 10010, 10);

INSERT INTO admin (uid, permission_level) VALUES
(10001, 1),
(10002, 2),
(10003, 3),
(10004, 1),
(10005, 2);

INSERT INTO advertisement (id, content, uid) VALUES
(30001, 'Ad Content 1', 10001),
(30002, 'Ad Content 2', 10001),
(30003, 'Ad Content 3', 10003),
(30004, 'Ad Content 4', 10004),
(30005, 'Ad Content 5', 10005);

INSERT INTO categories (cat_id, cat_name, cat_desc) VALUES
(40001, 'Category 1', 'Description 1'),
(40002, 'Category 2', 'Description 2'),
(40003, 'Category 3', 'Description 3'),
(40004, 'Category 4', 'Description 4'),
(40005, 'Category 5', 'Description 5'),
(40006, 'Category 6', 'Description 6'),
(40007, 'Category 7', 'Description 7'),
(40008, 'Category 8', 'Description 8'),
(40009, 'Category 9', 'Description 9'),
(40010, 'Category 10', 'Description 10');

INSERT INTO manage (uid, cat_id) VALUES
(10001, 40001),
(10001, 40002),
(10002, 40003),
(10002, 40004),
(10003, 40005),
(10003, 40006),
(10004, 40007),
(10004, 40008),
(10005, 40009),
(10005, 40010);

INSERT INTO subscribe (uid, cat_id) VALUES
(10006, 40001),
(10007, 40002),
(10008, 40003),
(10009, 40004),
(10010, 40005),
(10011, 40001),
(10012, 40002),
(10013, 40003),
(10014, 40004),
(10015, 40005);

INSERT INTO classify (pid, cat_id) VALUES
(1, 40001),
(2, 40002),
(3, 40003),
(4, 40004),
(5, 40005),
(6, 40006),
(7, 40007),
(8, 40008),
(9, 40009),
(10, 40010);

INSERT INTO groups (gid, des) VALUES
(50001, 'Group 1 Description'),
(50002, 'Group 2 Description'),
(50003, 'Group 3 Description'),
(50004, 'Group 4 Description'),
(50005, 'Group 5 Description'),
(50006, 'Group 6 Description'),
(50007, 'Group 7 Description'),
(50008, 'Group 8 Description');

INSERT INTO manage_group (uid, gid) VALUES
(10001, 50001),
(10001, 50002),
(10002, 50003),
(10002, 50004),
(10002, 50005),
(10003, 50006),
(10003, 50007),
(10004, 50008);

INSERT INTO join_group (uid, gid) VALUES
(10006, 50001),
(10007, 50001),
(10008, 50002),
(10009, 50002),
(10010, 50003),
(10011, 50004),
(10012, 50004),
(10013, 50005),
(10014, 50006),
(10015, 50008);

insert into announcement (aid, gid, title, content) values
(60001, 50001, 'New Product Launch', 'Content 1.'), 
(60002, 50002, 'Company Expansion', 'Content 2.'), 
(60003, 50003, 'Employee Recognition', 'Content 3.'), 
(60004, 50004, 'Special Promotion', 'Content 4'), 
(60005, 50005, 'Charity Event', 'Content 5.'), 
(60006, 50001, 'New Partnership', 'Content 6.'), 
(60007, 50001, 'Company Milestone', 'Content 7.'), 
(60008, 50002, 'Product Update', 'Content 8.'), 
(60009, 50003, 'Employee Training', 'Content 9.'), 
(60010, 50004, 'New Office Opening', 'Content 10.');

INSERT INTO black_list (uid, other_uid) VALUES
(10006, 10007),
(10006, 10008),
(10006, 10009),
(10006, 10010),
(10007, 10009),
(10007, 10010),
(10008, 10007),
(10008, 10009),
(10008, 10010),
(10010, 10012);

INSERT INTO friend_list (uid, other_uid) VALUES
(10010, 10011),
(10010, 10013),
(10010, 10014),
(10011, 10012),
(10011, 10013),
(10011, 10014),
(10012, 10013),
(10012, 10014),
(10013, 10014),
(10013, 10015),
(10014, 10015);
