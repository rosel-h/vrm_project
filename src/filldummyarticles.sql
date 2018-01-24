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


INSERT INTO vrm_articles VALUES
(10,'Pooh Gets A Letter','ruru','2001-09-08','Pooh was puzzled. Someone had pushed something through his letterbox and it wasn’t a pot of honey.

It was a piece of paper with writing on it.

Pooh knew all about writing of course.

He wasn’t, in his opinion, a stupid bear. And he also wasn’t, in most people’s opinion, an intelligent bear. He was in between. He knew enough about stuff he needed to know, which was mostly about honey and he didn’t need to know much about other stuff.

But sometimes life presented challenges and this letter – he knew that much – was one of those he needed to deal with.  He needed to have a big think. And thinking made him hungry. So he got down an especially large pot of honey and started thinking. And eating.

​After he had thought and eaten enough he had decided what to do. He would collect Piglet and they would go and see Owl and ask him about the letter.'),
(11,'Going To See Owl','ruru','1993-07-05','On the way they met up with Tigger who was of course very excited and extra bouncy. “I got a letter!!!!” said Tigger, bouncing alarmingly close to Piglet.

Pooh put a protective arm round Piglet and they all approached the Great Oak where Owl lived.

Eeyore was stood outside Owl’s front door with a letter in his mouth. “It’s probably a bill then” he said. “We can’t all have a birthday on the same day”

​Pooh greeted Eeyore and said not to worry. He knocked on Owl’s front door.');

