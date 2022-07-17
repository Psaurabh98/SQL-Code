CREATE TABLE [students](
 [studentid] [int] NULL,
 [studentname] [nvarchar](255) NULL,
 [subject] [nvarchar](255) NULL,
 [marks] [int] NULL,
 [testid] [int] NULL,
 [testdate] [date] NULL
)
data:
insert into students values (2,'Max Ruin','Subject1',63,1,'2022-01-02');
insert into students values (3,'Arnold','Subject1',95,1,'2022-01-02');
insert into students values (4,'Krish Star','Subject1',61,1,'2022-01-02');
insert into students values (5,'John Mike','Subject1',91,1,'2022-01-02');
insert into students values (4,'Krish Star','Subject2',71,1,'2022-01-02');
insert into students values (3,'Arnold','Subject2',32,1,'2022-01-02');
insert into students values (5,'John Mike','Subject2',61,2,'2022-11-02');
insert into students values (1,'John Deo','Subject2',60,1,'2022-01-02');
insert into students values (2,'Max Ruin','Subject2',84,1,'2022-01-02');
insert into students values (2,'Max Ruin','Subject3',29,3,'2022-01-03');
insert into students values (5,'John Mike','Subject3',98,2,'2022-11-02');


--Write a SQL Query to get the list of students who scored above the average marks in each subject
with cte AS (
select Subject ,Avg(marks) as Average_marks
 from Students
 group by subject),
 CTE2 as (

 Select B.Studentid,B.studentname,B.subject,B.marks,A.Average_marks
 from CTE A  Inner Join Students B on A.subject=B.subject)

 Select *
 from CTE2 
 WHERE Average_marks<Marks
 order by studentid

 --Write a SQL Query to get the percentage of students who scored more than 90 in subject amongst the total students
 With CTE AS (
 select Studentname ,Count( Case when marks>90 then 1  end) as CN
 from students
 group by Studentname
 Having Count( Case when marks>90 then 1  end)!=0)

 SELECT ( 100.0*(Select Count(Studentname) from CTE )/(SeLECT COUNT(distinct Studentname)  from Students)) as Percentage

 ---Write SQL Query to get second_highest and second_lowest marks for each subject
 With CTE AS (
 Select subject,marks,Rank() over (Partition by subject order by marks desc) as Rn from students)
 ,CTE2 AS (
 SELECT Subject,Marks,Rn, Count(Rn)over (Partition by Subject)-1 as CNT
 FROM CTE
 )
 SELECT subject,MAX(Case when Rn=2 then marks end) as SECOND_HIGHEST,
MAX(Case when Cnt=Rn then marks end) as SECOND_lowest
 
  FROM CTE2 
  group by subject

  ---FOR Each student and test,identify if their marks is increased or decreased from the previous test

  select *,Case when marks >lag(marks) over (Partition by studentname order by subject) then 'increased' 
  when marks < lag(marks) over (Partition by studentname order by subject) then 'decreased' else Null  end as indication,
  lag(marks) over (Partition by studentname order by subject) as Ab
   from students 
   order by studentid
  
