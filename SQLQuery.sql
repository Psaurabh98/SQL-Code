--Write a SQL to determine phone numbers that satisfy below conditions:
--1-the numbers should hve both incoming and outgoing 
--2-the sum of duration of outgoing calls is greater than sum of duration of incoming calls

--Script for creating table
create table call_details  (
call_type varchar(10),
call_number varchar(12),
call_duration int
);

insert into call_details
values ('OUT','181868',13),('OUT','2159010',8)
,('OUT','2159010',178),('SMS','4153810',1),('OUT','2159010',152),('OUT','9140152',18),('SMS','4162672',1)
,('SMS','9168204',1),('OUT','9168204',576),('INC','2159010',5),('INC','2159010',4),('SMS','2159010',1)
,('SMS','4535614',1),('OUT','181868',20),('INC','181868',54),('INC','218748',20),('INC','2159010',9)
,('INC','197432',66),('SMS','2159010',1),('SMS','4535614',1);

--Below written are sql code

with CTE as (

select call_number,Call_type,Sum(call_duration) as summation ,Row_number() over (Partition by Call_number order by call_type desc) as Rn

from call_details
where Call_type != 'SMS'
group by Call_number,Call_type
)
,B as(
select *,Lag(Summation) over (partition by call_number order by Rn ) as Output_summation from CTE )

select call_number from B where  Output_summation>Summation





