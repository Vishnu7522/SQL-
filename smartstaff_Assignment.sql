/* Converting the utc time to local time useing date_add function and saving the table as shifts_dur*/
select
`Shift ID`,`Shift created on`,`Shift confirmed by worker at`,start_time,end_time,updated_at,business_id,`Worker ID`,`Worker Onboarded on`,`Worker Date of Birth`,
date_add(`Shift created on`, interval 330 minute) as shift_created_updated_time,
date_add(`Shift confirmed by worker at`, interval 330 minute) as shift_confirmed_updated_time,
date_add(start_time, interval 330 minute) as start_updated_time,
date_add(end_time, interval 330 minute) as end_updated_time
from smartstaff;

/*Seperating the start and end time and date seperately into seperate column and saving in a seperate table as shift_per*/

SELECT `Worker ID`,business_id,
substring_index(assignment.shifts_dur.start_updated_time,' ',1) as Date,
substring_index(assignment.shifts_dur.start_updated_time,' ',-1) as start,
substring_index(assignment.shifts_dur.end_updated_time,' ',-1) as end,
abs(substring_index (assignment.shifts_dur.start_updated_time,' ',-1) - substring_index(assignment.shifts_dur.end_updated_time,' ',-1)) as Duration
from assignment.shifts_dur;


select * from shifts_per;

/*Seperating the shift created and updated time and date seperately into 
seperate column and saving in a seperate table as shift_split*/

SELECT 
substring_index(assignment.shifts_dur.start_updated_time,' ',1) as Date,
`Worker ID`,
substring_index(assignment.shifts_dur.shift_created_updated_time,' ',1) as shift_created_date,
substring_index(assignment.shifts_dur.shift_created_updated_time,' ',-1) as shift_created_time,
substring_index(assignment.shifts_dur.shift_confirmed_updated_time,' ',1) as shift_confirmed_date,
substring_index(assignment.shifts_dur.shift_confirmed_updated_time,' ',-1) as shift_confirmed_time,
abs(substring_index(assignment.shifts_dur.shift_created_updated_time,' ',-1)-substring_index(assignment.shifts_dur.shift_confirmed_updated_time,' ',-1)) as time_taken,
substring_index(assignment.shifts_dur.shift_created_updated_time,' ',1) -substring_index(assignment.shifts_dur.shift_confirmed_updated_time,' ',1) as days_taken
FROM assignment.shifts_dur;

/* Adding index value to the shift_split table in reference to the business id*/

select *,row_number() over(partition by business_id)  as index_value
from assignment.shifts_split;

select * from shifts_split;

/*Query to find the duration of a specific worker in refernce with the worker id*/

SELECT `Worker ID`,Duration as totalworkers
FROM assignment.shifts_split where `Worker ID`=436;

/*Query to find the correlation bewteen business id and worker id in refernce with the business id*/

select `Worker ID`,business_id 
from assignment.shifts_split where business_id=42 order by `Worker ID`;

/*Query to find the correlation bewteen business id and worker id in refernce with the worker id*/

select `Worker ID`,business_id 
from assignment.shifts_split where `Worker ID`=301 order by business_id;

/*Query to find the total number of distinct workers working*/

SELECT count( distinct`Worker ID`) as totalworkers
FROM assignment.shifts_dur;

/*Query to find the overall average duration of the shift*/

select round(avg(duraction),0) as Average_Duration_by_allworkers
from assignment.shifts_per ;

/*Query to find average duration of a particular worker*/

select round(avg(duraction),0) as Average_Duration ,`Worker ID` 
from assignment.shifts_per  where `Worker ID` = 301 order by `Worker ID`;

/*using case function we have build a query to assign shift according to the 
start time,end time and duration and saved in a table named shifts_time */

SELECT  
case 
     when start >= '05:00:00' and start<='20:00:00' and Duration <= 9 then "Day Shift"
     when start >= '05:00:00' and start<='20:00:00' and Duration > 9 then "Day Heavy Shift"
     when start >='20:00:00'  and Duration <= 9 then "Night Shift"
     when start >='20:00:00'  and Duration > 9 then "Night Heavy Shift"
end as Shift,Date,start,end,Duration,`Worker ID`,business_id
     FROM assignment.shifts_per;

/* Query to find the shift performed by worker and ordered by worker id*/

SELECT `Worker ID`,business_id,Shift 
FROM assignment.shifts_split where Shift = 'Night Heavy Shift' order by 'Worker ID' desc;

/*Query to find the shift in reference with the business_id*/

SELECT `Worker ID`,business_id,Shift 
FROM assignment.shifts_split where business_id = 42 group by Shift;

/* query to find the shift and worker attribute for a week*/

select Date,Shift,`Worker ID`
from assignment.shifts_split 
where Date between '2021-02-26' and '2021-03-04' order by Date;

select * from shifts_split;