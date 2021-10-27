----import data file
select * from ['Assignment - RDBMS Dataset$']

----drop null columns
Alter table ['Assignment - RDBMS Dataset$'] 
drop column F5
Alter table ['Assignment - RDBMS Dataset$'] 
drop column F8

----Separating Employee Data into a new Table EmplyeeBD
select [Table Name: Employee], F2, F3, F4 
into EmplyeeBD
from ['Assignment - RDBMS Dataset$']

----deleting null values from the EmplyeeBD table
delete from EmplyeeBD
where [Table Name: Employee] is null

----renaming columns in EmplyeeBD
sp_rename 'EmplyeeBD.[Table Name: Employee]', EmployeeID
sp_rename 'EmplyeeBD.F2', EmployeeName
sp_rename 'EmplyeeBD.F3', RecruitedBy
sp_rename 'EmplyeeBD.F4', Department
sp_rename 'EmplyeeBD.RecruitedBy', RecruiterID
sp_rename 'EmplyeeBD.Department', DepartmentID

select * from EmplyeeBD

----Separating Recruiter Data into a new Table RecruitrBD
select [Table Name: Recruiter], F7
into RecruitrBD
from ['Assignment - RDBMS Dataset$']

select * from RecruitrBD

----deleting null values from the RecruitrBD table
delete from RecruitrBD
where [Table Name: Recruiter] is null

----renaming columns in RecruitrBD
sp_rename 'RecruitrBD.[Table Name: Recruiter]', RecruiterID
sp_rename 'RecruitrBD.F7', RecuriterName

----Separating Department Data into a new Table DeptBD
select [Table Name: Department], F10
into DeptBD
from ['Assignment - RDBMS Dataset$']

----deleting null values from the DeptBD table
delete from DeptBD
where [Table Name: Department] is null

----renaming columns in DeptBD
sp_rename 'DeptBD.[Table Name: Department]', DepartmentID
sp_rename 'DeptBD.F10', Department

select * from DeptBD

----Joining Tables EmplyeeBD and RecruitrID using common column RecruiterID
select EmplyeeBD.RecruiterID, EmplyeeBD.EmployeeName, EmplyeeBD.DepartmentID, RecruitrBD.RecuriterName into RecruiterDeptJoined from EmplyeeBD
full outer join RecruitrBD
on EmplyeeBD.RecruiterID = RecruitrBD.RecruiterID

select * from RecruiterDeptJoined

----Joining Tables RecruiterDeptJoined and Dept ID using common column DepartmentID. We get a new table with all the data and in a better way.
select RecruiterDeptJoined.* , DeptBD.Department
into RecruiterDeptList from RecruiterDeptJoined
full outer join DeptBD
on RecruiterDeptJoined.DepartmentID = DeptBD.DepartmentID

select * from recruiterDeptList

----Answer 1
select * from RecruiterDeptJoined
where RecruiterID = 2

----Answer 2
select * from RecruiterDeptList
where RecuriterName = 'John Do'

----Answer 3
SELECT Department, count(*)
FROM RecruiterDeptList
WHERE Department is not null
GROUP BY Department