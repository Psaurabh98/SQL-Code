/* WE HAVE TO FIND IN WHICH MATCH AND INNINGS SACHIN HAS SCORED greater than or equal to milestones runs*/


select * from sachin

With CTE as(

select count(Match) over (order by Match) as Milestone_match,
count(Innings) over (order by Match) as Milestone_Inning,sum(Runs) Over (Order by Match) as RS
from sachin)

,CTE2 as (

select 1 as Milestone_number ,1000 as Milestone_runs
union all
select 2 as Milestone_number ,5000 as Milestone_runs
union all
select 1 as Milestone_number ,10000 as Milestone_runs
)

select Milestone_number,Milestone_runs,Min(Milestone_match) as MMM ,Min(Milestone_inning) as MMI
from CTE2 inner Join CTE on RS>Milestone_Runs
group by Milestone_number,Milestone_runs
order by Milestone_Runs
