insert into groups (des) values ('Group 1'), ('Group 2'), ('Group 3'), ('Group 4'), ('Group 5'), ('Group 6'), ('Group 7'), ('Group 8'), ('Group 9'), ('Group 10');

insert into manage_g (uid, gid) values (1, 1), (2, 2), (3, 3), (4, 4), (5, 5), (6, 6), (7, 7), (8, 8), (9, 9), (10, 10);

insert into join_g (uid, gid) values (3, 1), (4, 2), (1, 4), (2, 3), (5, 6), (7, 9), (8, 10), (9, 6), (10, 7), (5, 4);

insert into announcement (gid, title, content) values (1, 'New Product Launch', 'Content1.'), (2, 'Company Expansion', 'Content2.'), (3, 'Employee Recognition', 'Content3.'), (4, 'Special Promotion', 'Content4'), (5, 'Charity Event', 'Content5'), (6, 'New Partnership', 'Content6.'), (7, 'Company Milestone', 'Content7.'), (8, 'Product Update', 'Content8.'), (9, 'Employee Training', 'Content9.'), (10, 'New Office Opening', 'Content10');

insert into black_list (uid, other_uid) values (1, 5), (3, 4), (2, 1), (4, 3), (5, 7), (6, 10), (7, 5), (8, 9), (9, 8), (10, 6);

insert into friend_list (uid, other_uid) values (1, 3), (2, 4), (3, 5), (4, 6), (5, 4), (6, 7), (7, 3), (8, 2), (9, 1), (10, 4);