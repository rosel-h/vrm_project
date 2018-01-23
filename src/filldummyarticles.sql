INSERT INTO vrm_users VALUE
('AliceInWonder','password1234','Alice','Smith','1990-11-11','America','os et accusamus et iusto odio dignissimos ducimus qui blanditiis','racoon.jpeg','active');

INSERT INTO vrm_users VALUE
('user902','qwerty','Paul','Bastion','1979-02-10','United Kingdom','I am me','koala.jpeg','active');

INSERT INTO vrm_articles VALUES
(1,'Insert Name here','AliceInWonder','2018-01-23','This is the content'),
(2,'Hi Friend','user902','2018-01-23','This was written here'),
(3,'Once upon a time','AliceInWonder','2018-01-01','A fairytal story as told');


INSERT INTO vrm_comments_on_articles VALUES
(1,4,'AliceInWonder','2018-01-23','PS I wrote this'),
(3,5,'user902','2018-01-20','what happens next');

INSERT INTO vrm_comments_on_comments VALUE
(5,6,'AliceInWonder','2018-01-23','wait and see');

