DROP TABLE IF EXISTS vrm_users;
DROP TABLE IF EXISTS vrm_articles;
DROP TABLE IF EXISTS vrm_comments_on_articles;
DROP TABLE IF EXISTS vrm_comments_on_comments;


CREATE TABLE IF NOT EXISTS vrm_users (
  username VARCHAR(20) NOT NULL,
  psw_hash VARCHAR(20) NOT NULL,
  fname VARCHAR(20) NOT NULL,
  lname  VARCHAR(20) NOT NULL,
  dob  date NOT NULL,
  country  VARCHAR(20) NOT NULL,
  description TEXT NOT NULL,
  avatar_icon VARCHAR(50) NOT NULL,
  status VARCHAR(20) NOT NULL,
  PRIMARY KEY (username)
);

CREATE TABLE IF NOT EXISTS vrm_articles (
  article_id INT NOT NULL,
  title VARCHAR(50) NOT NULL,
  username VARCHAR(20) NOT NULL,
  date DATE NOT NULL,
  content TEXT NOT NULL,
  PRIMARY KEY (article_id)
);

CREATE TABLE IF NOT EXISTS vrm_comments_on_articles (
  comment_id INT NOT NULL,
  article_id INT NOT NULL,
  username VARCHAR(20) NOT NULL,
  date DATE NOT NULL,
  content TEXT NOT NULL,
  PRIMARY KEY (comment_id)
);

CREATE TABLE IF NOT EXISTS vrm_comments_on_comments (
  parent_comment_id INT NOT NULL,
  child_comment_id INT NOT NULL,
  username VARCHAR(20) NOT NULL,
  date DATE NOT NULL,
  content TEXT NOT NULL,
  PRIMARY KEY (child_comment_id)
);

ALTER TABLE vrm_users ADD email_address VARCHAR(50);

ALTER TABLE vrm_articles MODIFY COLUMN article_id INT auto_increment;

ALTER TABLE vrm_comments_on_comments Modify COLUMN child_comment_id INT auto_increment;
ALTER TABLE vrm_comments_on_articles Modify COLUMN comment_id INT auto_increment;
