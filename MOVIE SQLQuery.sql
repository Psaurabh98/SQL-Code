--there are 3 rows in a movie hall containing 10 seats each
--Write a query to find 10 consecutive empty seats in every row

--Code for creating table
create table movie(
seat varchar(50),occupancy int
);
insert into movie values('a1',1),('a2',1),('a3',0),('a4',0),('a5',0),('a6',0),('a7',1),('a8',1),('a9',0),('a10',0),
('b1',0),('b2',0),('b3',0),('b4',1),('b5',1),('b6',1),('b7',1),('b8',0),('b9',0),('b10',0),
('c1',0),('c2',1),('c3',0),('c4',1),('c5',1),('c6',0),('c7',1),('c8',0),('c9',0),('c10',1);


---for segregating seat  
with CTE1 AS (
Select * ,substring(seat,1,1)as row_seat,Cast(substring(seat,2,2)as Integer) as Seatnumber
 from movie)
 --For summation of occupancy to find whether it is empty or not and also counting it to consider 4 consecutive rows over partition 
, CTE2 AS (

 SELECT *,
 SUM(Occupancy) over (Partition by Row_seat order by seatnumber rows between current row and 3 following) as IS_4_seat_empty,
 Count(Occupancy) over (Partition by Row_seat order by seatnumber rows between current row and 3 following) as Cnt
  FROM CTE1)
  ,CTE3 AS (
  --Where conditions are fullfilled according to the need
  Select * from CTE2 WHERE IS_4_seat_empty=0 AND Cnt=4)
  --Inner Joining with CTE2 to get the details of other seats
  SELECT CTE2.* FROM CTE3 Inner Join CTE2 on CTE3.ROW_SEAT=CTE2.ROW_Seat and CTE2.seatNUMBER  BETWEEN CTE3.Seatnumber and CTE3.Seatnumber+3
