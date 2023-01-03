--  Query to start using the database 

use HomeWork3;

-- List Student Names, credits and GPA from each department

select Name as Student_Name, tot_cred, GPA from student where dept_name = 'IDS';

select Name as Student_Name, tot_cred, GPA from student where dept_name = 'Comp.Sci';

select Name as Student_Name, tot_cred, GPA from student where dept_name = 'Music';

-- Query 2 Seach student tuple by name

select * from student where name= 'Gabbie';

-- Query 3 Find Advisor(s) of student 
select S.Name, I.Name from ((Advisor as A inner join student as S on S.ID = A.s_ID) 
Inner join instructor as I on I.id = A.i_ID);

-- Query 4 Avergae GPA of students enrolled in each department 

select avg(GPA), dept_name from student group by dept_name order by avg(gpa) desc;

-- Query 5 Enrollment of students per department 

select count(*) as [No of Students in each department], dept_name from student group by dept_name;

-- Query 6 SQL Like 
select Name from student where name like 'an%';

select Name from instructor where name like 'M%';

select dept_name from department where dept_name like '%i%';

-- Query 7 in 
select Name, dept_name from instructor where dept_name in ('IDS', 'Comp.Sci');

-- Query 8 Number of courses take by each student 

select Distinct S.Name as [Student Name], count(C.Title) as [No of Courses taken]
from ((student as S inner join takes as T on S.ID = T.ID) 
inner join  Course as C on C.course_id = T.course_id)
group by S.Name;

-- Query 9 Avg Salries of instructors in each department 
select avg(salary) as [Avg Salries], dept_name from instructor 
group by dept_name order by avg(Salary) desc;

-- Query 10 No of Instructors in each department 
select count(*) as [No of Instructors], dept_name from instructor 
group by dept_name order by count(*) desc;

-- Query 11 Querying using between operator 
select name, salary, dept_name from instructor 
where salary between 70000 and 80000;

-- Query 12 Finding number of courses offered by each department

select count(Title) as [No of Courses], dept_name from course group by dept_name;

-- Query 13 Querying using  not in:

select distinct name, dept_name from instructor where name in ('Lee', 'Singh');

/* Query 14 Querying using in function and Multiple Left Join :
Different courses taken by particluar students */

select S.Name, C.title as [Course Taken] from ((Student as S left join Takes as T 
on T.ID = S.ID) left join course as C on T.course_id = C.course_id)
where S.Name in ('Anvesh', 'Jahnavi', 'Amitha');


-- Query 15 Name of the instructors who have taught some courses 
select name, course_id from instructor, teaches
where instructor.ID = teaches.id;

-- Query 16 Set operations
-- Find the course that ran in Fall 2009 and Spring 2010 
select course_id from section where semester = 'Fall' and year = 2009
Union
select course_id from section where semester = 'Spring' and year = 2010;

-- Query 17 The total number of instructores who teach a course in the spring 2010
select count(distinct id) as [No of Courses taught] 
from teaches where semester = 'spring' and year = 2010;

-- Query 18 Avergae salries of all departments whose avergae salary is greater tha 42000
select dept_name, avg(Salary) as avg_salary 
from instructor
group by dept_name 
having avg(salary) > 42000;

-- Query 19 Find all the departments with the maxium budget
with max_budget(value) as (Select max(budget) from department)
select department.dept_name from department, max_budget
where department.budget = max_budget.value;

-- Query 20 Insertion 
insert into course
	values('CS 437', 'Database systems', 'Comp.Sci', 4);


-- Query 21 Update salary
-- Give a 5% salary raise to all instructors
update instructor set salary = salary*1.05
-- Give a 5% salary raise to those instructors who earn less than 70000
update instructor set salary = salary*1.05 where salary < 70000;

-- Query 22 A view of instructor without their salary 
create view faculty as select ID, name, dept_name 
from instructor;

select * from [faculty]