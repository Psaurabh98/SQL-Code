--Write a querry to find number of gold medal per swimmer for swimmer who won  only gold medals

--Code for creation of table
CREATE TABLE events (
ID int,
event varchar(255),
YEAR INt,
GOLD varchar(255),
SILVER varchar(255),
BRONZE varchar(255)
);

delete from events;

INSERT INTO events VALUES (1,'100m',2016, 'Amthhew Mcgarray','donald','barbara');
INSERT INTO events VALUES (2,'200m',2016, 'Nichole','Alvaro Eaton','janet Smith');
INSERT INTO events VALUES (3,'500m',2016, 'Charles','Nichole','Susana');
INSERT INTO events VALUES (4,'100m',2016, 'Ronald','maria','paula');
INSERT INTO events VALUES (5,'200m',2016, 'Alfred','carol','Steven');
INSERT INTO events VALUES (6,'500m',2016, 'Nichole','Alfred','Brandon');
INSERT INTO events VALUES (7,'100m',2016, 'Charles','Dennis','Susana');
INSERT INTO events VALUES (8,'200m',2016, 'Thomas','Dawn','catherine');
INSERT INTO events VALUES (9,'500m',2016, 'Thomas','Dennis','paula');
INSERT INTO events VALUES (10,'100m',2016, 'Charles','Dennis','Susana');
INSERT INTO events VALUES (11,'200m',2016, 'jessica','Donald','Stefeney');
INSERT INTO events VALUES (12,'500m',2016,'Thomas','Steven','Catherine');

--Query for required problem

with CTE1 AS (
select Gold,Count(Gold) as no_of_g_medal
 from events
 group by Gold)
,CTE2 AS (

 
select Silver,Count(silver) as no_of_s_medal
 from events
 group by silver),

 CTE3 AS(

 select Bronze,Count(Bronze) as no_of_B_medal
 from events
 group by Bronze)

 Select A.*
 from CTE1  A Left Join CTE2 B on A.GOLD=B.silver 
 Left Join CTE3 C on A.Gold=C.Bronze
 where B.silver Is null and C.Bronze is Null