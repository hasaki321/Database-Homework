DROP TABLE IF EXISTS  users, posts, comments, admin,
	advertisement, categories, manage, subscribe, classify;
 
CREATE TABLE users (
    uid INTEGER PRIMARY KEY,
    email VARCHAR(255),
    password VARCHAR(255),
    profile VARCHAR(255)
);

CREATE TABLE posts (
    pid INTEGER PRIMARY KEY,
    title VARCHAR(255),
    content VARCHAR(255),
    datetime TIMESTAMP,
    uid INTEGER,
    FOREIGN KEY (uid) REFERENCES users(uid) ON DELETE CASCADE
);

CREATE TABLE comments (
    cid INTEGER PRIMARY KEY,
    content VARCHAR(255),
    datetime TIMESTAMP,
    uid INTEGER,
    pid INTEGER,
    FOREIGN KEY (uid) REFERENCES users(uid) ON DELETE CASCADE,
    FOREIGN KEY (pid) REFERENCES posts(pid) ON DELETE CASCADE
);

CREATE TABLE admin (
    uid INTEGER PRIMARY KEY,
    permission_level INTEGER,
    FOREIGN KEY (uid) REFERENCES users(uid) ON DELETE NO ACTION
);

CREATE TABLE advertisement (
    id INTEGER PRIMARY KEY,
    content VARCHAR(255),
    uid INTEGER,
    FOREIGN KEY (uid) REFERENCES admin(uid) ON DELETE NO ACTION
);

CREATE TABLE categories (
    cat_id INTEGER PRIMARY KEY,
    cat_name VARCHAR(255),
    cat_desc VARCHAR(255)
);

CREATE TABLE manage (
    uid INTEGER,
    cat_id INTEGER,
    FOREIGN KEY (uid) REFERENCES admin(uid) ON DELETE CASCADE,
    FOREIGN KEY (cat_id) REFERENCES categories(cat_id) ON DELETE CASCADE,
    PRIMARY KEY (uid, cat_id)
);

CREATE TABLE subscribe (
    uid INTEGER,
    cat_id INTEGER,
    FOREIGN KEY (uid) REFERENCES users(uid) ON DELETE CASCADE,
    FOREIGN KEY (cat_id) REFERENCES categories(cat_id) ON DELETE CASCADE,
    PRIMARY KEY (uid, cat_id)
);

CREATE TABLE classify (
    pid INTEGER,
    cat_id INTEGER,
    FOREIGN KEY (pid) REFERENCES posts(pid) ON DELETE CASCADE,
    FOREIGN KEY (cat_id) REFERENCES categories(cat_id) ON DELETE CASCADE,
    PRIMARY KEY (pid, cat_id)
);