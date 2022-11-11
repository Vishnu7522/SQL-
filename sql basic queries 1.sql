/*
multi line comment
*/

-- single line comment

show character set;
show databases;
create database logic;
-- drop database logic
use logic;

create table student(
	id int primary key,
     name varchar(30),
     gpa decimal(3,2)
);
describe student;

alter table student add dept varchar(10);
alter table student drop dept;
insert into student values (1,"vishnu",9.9);
insert into student values 
(2,"swag",9.7),
(3,"nav",9.6),
(4,"ana",9.5),
(5,"vin",9.2),
(6,"sourav",8);
insert into student(id,name) values(7,"arun");

select * from student;
select id,name from student;

select count(*)
from EMPLOYEE;
