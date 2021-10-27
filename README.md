# Recruitment-Assignment---SQL
We clean the data and then find out who was recruited by whom and to which department.
# Recruitment-Assignment---SQL
We clean the data and then find out who was recruited by whom and to which department.

Problem – 
1. A list of all employees recruited by Paul Allen 
2. A list of employees in Marketing recruited by John Do
3. Output the count of employees in each department

Approach- 
1-	First, we drop all the null columns F5 and F8.
2-	We separated Employee data into a new table called EmplyeeBD
3-	We deleted all the null values from EmplyeeBD table to get all the relevant Employee Data.
4-	We rename all the columns for our easier understanding.
5-	We perform the similar steps (2-4) and create table for RecruitrBD and DeptBD.
6-	We then join the EmplyeeBD and RecruitrID using common column RecruiterID and name the table RecruitrDeptJoined
7-	We then join the RecruiterDeptJoined and Dept ID using common column DepartmentID. We get a new table with all the data and in a better way.

Codes and snippets.
----import data file
select * from ['Assignment - RDBMS Dataset$']

![1](https://user-images.githubusercontent.com/91282080/139035983-990b8e44-c2fd-46c1-a3bc-14e6c9ba08d1.JPG)

----drop null columns
Alter table ['Assignment - RDBMS Dataset$'] 
drop column F5
Alter table ['Assignment - RDBMS Dataset$'] 
drop column F8

----Separating Employee Data into a new Table EmplyeeBD
select [Table Name: Employee], F2, F3, F4 
into EmplyeeBD
from ['Assignment - RDBMS Dataset$']

select * from EmplyeeBD

![emplyeebd table](https://user-images.githubusercontent.com/91282080/139036162-9b7ddd51-a6df-421a-a873-71ebcfc1d412.JPG)

----deleting null values from the EmplyeeBD table with null in Table Name:Employee column
delete from EmplyeeBD
where [Table Name: Employee] is null

select * from EmplyeeBD

![Emplyee bd table after deleting null values](https://user-images.githubusercontent.com/91282080/139036284-d34fcafb-4000-4cb4-adb4-0ef732a96ad1.JPG)

----renaming columns in EmplyeeBD
sp_rename 'EmplyeeBD.[Table Name: Employee]', EmployeeID
sp_rename 'EmplyeeBD.F2', EmployeeName
sp_rename 'EmplyeeBD.F3', RecruitedBy
sp_rename 'EmplyeeBD.F4', Department
sp_rename 'EmplyeeBD.RecruitedBy', RecruiterID
sp_rename 'EmplyeeBD.Department', DepartmentID

select * from EmplyeeBD -- Final EmplyeeBD table

![Renamed all columns in EmplyeeBD](https://user-images.githubusercontent.com/91282080/139036598-6350a9ff-675c-4c8c-98d7-5dfe42baf619.JPG)

----Separating Recruiter Data into a new Table RecruitrBD
select [Table Name: Recruiter], F7
into RecruitrBD
from ['Assignment - RDBMS Dataset$']

![RecruiterBD data](https://user-images.githubusercontent.com/91282080/139036702-90acf364-a430-46b5-9797-11e58610690c.JPG)

----deleting null values from the RecruitrBD table
delete from RecruitrBD
where [Table Name: Recruiter] is null

select * from RecruitrBD

![Recruiter BD after del null values](https://user-images.githubusercontent.com/91282080/139036797-100d9968-03bf-4569-b6b1-838b14732251.JPG)

----renaming columns in RecruitrBD
sp_rename 'RecruitrBD.[Table Name: Recruiter]', RecruiterID
sp_rename 'RecruitrBD.F7', RecuriterName

select * from RecruitrBD -- Final RecruitrBD table

![final recruiter data](https://user-images.githubusercontent.com/91282080/139037004-c8421b96-80d6-4c62-8b58-43df08ba4aec.JPG)

----Separating Department Data into a new Table DeptBD
select [Table Name: Department], F10
into DeptBD
from ['Assignment - RDBMS Dataset$']

![Dept bd table separated](https://user-images.githubusercontent.com/91282080/139037123-265b3a23-6393-4c7e-bafc-0c8ecc89d075.JPG)

----deleting null values from the DeptBD table
delete from DeptBD
where [Table Name: Department] is null

Select * from DeptBD

![dropping null values from dept table](https://user-images.githubusercontent.com/91282080/139037175-f94f3418-c77d-4b29-b577-08f063f489be.JPG)

----renaming columns in DeptBD
sp_rename 'DeptBD.[Table Name: Department]', DepartmentID
sp_rename 'DeptBD.F10', Department

select * from DeptBD

![reanmed columns dept bd](https://user-images.githubusercontent.com/91282080/139037258-ca23d573-eff1-4c24-b9fb-61eaf1f307d2.JPG)

----Joining Tables EmplyeeBD and RecruitrID using common column RecruiterID
select EmplyeeBD.RecruiterID, EmplyeeBD.EmployeeName, EmplyeeBD.DepartmentID, RecruitrBD.RecuriterName into RecruiterDeptJoined from EmplyeeBD
full outer join RecruitrBD
on EmplyeeBD.RecruiterID = RecruitrBD.RecruiterID

select * from RecruiterDeptJoined

![Joining Tables EmplyeeBD and RecruitrID using common column RecruiterID](https://user-images.githubusercontent.com/91282080/139037314-00409a06-df8c-40f8-bc6b-de73840bfcdc.JPG)

----Joining Tables RecruiterDeptJoined and Dept ID using common column DepartmentID. We get a new table with all the data and in a better way.
select RecruiterDeptJoined.* , DeptBD.Department
into RecruiterDeptList from RecruiterDeptJoined
full outer join DeptBD
on RecruiterDeptJoined.DepartmentID = DeptBD.DepartmentID

select * from recruiterDeptList

![Joining Tables RecruiterDeptJoined and Dept ID using common column DepartmentID  We get a new table with all the data and in a better way](https://user-images.githubusercontent.com/91282080/139037369-920a0e66-dd81-42b3-84c6-a221cdfa39ea.JPG)

----Answer 1
select * from RecruiterDeptJoined
where RecruiterID = 2

![Anser1](https://user-images.githubusercontent.com/91282080/139037437-c64f8588-ea96-48bf-b5ff-8a12136bebe2.JPG)\

----Answer 2
select * from RecruiterDeptList
where RecuriterName = 'John Do'

![Answer 2](https://user-images.githubusercontent.com/91282080/139037476-91103ccb-f7ec-4343-8def-55c245d9554a.JPG)

----Answer 3
SELECT Department, count(*)
FROM RecruiterDeptList
WHERE Department is not null
GROUP BY Department

![answer 3](https://user-images.githubusercontent.com/91282080/139037499-aac09b9b-262a-4f63-b149-5f4c4936af4a.JPG)





