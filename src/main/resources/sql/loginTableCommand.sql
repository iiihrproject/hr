use hrdb;

drop table IF EXISTS [dbo].[authorities]; 
drop table IF EXISTS [dbo].[personnel];
drop table IF EXISTS [dbo].[loginModel];
drop table IF EXISTS [dbo].[departmentDetail];

use hrdb;

create table departmentDetail(
	dept_no int not null primary key identity,
	name nvarchar(max) not null,
	managerEmpId nvarchar(max) not null,
);

insert into departmentDetail(
	name,
	managerEmpId
)
values('HR', 1);

insert into departmentDetail(
	name,
	managerEmpId
)
values('RD', 3);

insert into departmentDetail(
	name,
	managerEmpId
)
values('SALES', 5);

create table loginModel(
	emp_id int not null identity primary key,
	role nvarchar(20) not null,
	personalIdNumber nvarchar(20) not null, 
	name nvarchar(max) not null,
	gender nvarchar(10) not null,
	empNo nvarchar(max) not null,
	pwd nvarchar(max) not null,
	dept_No int not null foreign key references departmentDetail(dept_no),
	employedDate date not null,
	non_Expired bit not null,
	non_Locked bit not null,
	credentials_Non_Expired bit not null,
	last_Change date not null,
	is_Enable bit not null
);

create table authorities(
	id int not null identity primary key,
	emp_id int not null foreign key references loginModel(emp_id),
	authorityName nvarchar(max) not null
);

insert into loginModel( 
	role,
	personalIdNumber,
	name,
	gender,
	empNo,
	pwd,
	dept_No,
	employedDate,
	non_Expired,
	non_Locked,
	credentials_Non_Expired,
	last_Change,
	is_Enable)
values(
	'HR MANAGER',
	'A222222222',
	'神盾局長',
	'male',
	'hrmanager',
	'$2a$12$sjCtNizDZiEeweYdVpfxGOmRCOyP4XSrVKXM6R812BUVeOEutKn7y',
	1,
	'2010-07-09',
	1,
	1,
	1,
	'2020-05-01',
	1
);

insert into authorities (
	emp_id,
	authorityName)
values(
	1,
	'ROLE_HR');

insert into authorities (
	emp_id,
	authorityName)
values(
	1,
	'ROLE_HR_MANAGER');
	
insert into loginModel( 
	role,
	personalIdNumber,
	name,
	gender,
	empNo,
	pwd,
	dept_No,
	employedDate,
	non_Expired,
	non_Locked,
	credentials_Non_Expired,
	last_Change,
	is_Enable)
values(
	'HR',
	'B222222222',
	'黑寡婦',
	'female',
	'hr1',
	'$2a$12$sjCtNizDZiEeweYdVpfxGOmRCOyP4XSrVKXM6R812BUVeOEutKn7y',
	1,
	'2011-01-31',
	1,
	1,
	1,
	'2020-08-11',
	1
);

insert into authorities (
	emp_id,
	authorityName)
values(
	2,
	'ROLE_HR');

insert into loginModel( 
	role,
	personalIdNumber,
	name,
	gender,
	empNo,
	pwd,
	dept_No,
	employedDate,
	non_Expired,
	non_Locked,
	credentials_Non_Expired,
	last_Change,
	is_Enable)
values(
	'RD MANAGER',
	'C222222222',
	'鋼鐵人',
	'male',
	'rdmanager',
	'$2a$12$sjCtNizDZiEeweYdVpfxGOmRCOyP4XSrVKXM6R812BUVeOEutKn7y',
	2,
	'2013-12-04',
	1,
	1,
	1,
	'2020-08-07',
	1
);

	
insert into authorities (
	emp_id,
	authorityName)
values(
	3,
	'ROLE_RD');

insert into authorities (
	emp_id,
	authorityName)
values(
	3,
	'ROLE_RD_MANAGER');

insert into loginModel( 
	role,
	personalIdNumber,
	name,
	gender,
	empNo,
	pwd,
	dept_No,
	employedDate,
	non_Expired,
	non_Locked,
	credentials_Non_Expired,
	last_Change,
	is_Enable)
values(
	'RD',
	'D111111111',
	'蜘蛛人',
	'male',
	'rd1',
	'$2a$12$sjCtNizDZiEeweYdVpfxGOmRCOyP4XSrVKXM6R812BUVeOEutKn7y',
	2,
	'2014-09-16',
	1,
	1,
	1,
	'2020-06-21',
	1
);

insert into authorities (
	emp_id,
	authorityName)
values(
	4,
	'ROLE_RD');

insert into loginModel( 
	role,
	personalIdNumber,
	name,
	gender,
	empNo,
	pwd,
	dept_No,
	employedDate,
	non_Expired,
	non_Locked,
	credentials_Non_Expired,
	last_Change,
	is_Enable)
values(
	'Sales MANAGER',
	'E222222222',
	'美國隊長',
	'male',
	'salesmanager',
	'$2a$12$sjCtNizDZiEeweYdVpfxGOmRCOyP4XSrVKXM6R812BUVeOEutKn7y',
	3,
	'2014-02-28',
	1,
	1,
	1,
	'2020-07-13',
	1
);
	
insert into authorities (
	emp_id,
	authorityName)
values(
	5,
	'ROLE_SALES');

insert into authorities (
	emp_id,
	authorityName)
values(
	5,
	'ROLE_SALES_MANAGER');

	
insert into loginModel( 
	role,
	personalIdNumber,
	name,
	gender,
	empNo,
	pwd,
	dept_No,
	employedDate,
	non_Expired,
	non_Locked,
	credentials_Non_Expired,
	last_Change,
	is_Enable)
values(
	'Sales',
	'E222222222',
	'緋紅女巫',
	'female',
	'sales1',
	'$2a$12$sjCtNizDZiEeweYdVpfxGOmRCOyP4XSrVKXM6R812BUVeOEutKn7y',
	3,
	'2017-05-24',
	1,
	1,
	1,
	'2020-08-20',
	1
);

insert into authorities (
	emp_id,
	authorityName)
values(
	6,
	'ROLE_SALES');
	

insert into loginModel( 
	role,
	personalIdNumber,
	name,
	gender,
	empNo,
	pwd,
	dept_No,
	employedDate,
	non_Expired,
	non_Locked,
	credentials_Non_Expired,
	last_Change,
	is_Enable)
values(
	'RD',
	'G111111111',
	'浩克',
	'male',
	'rd2',
	'$2a$12$sjCtNizDZiEeweYdVpfxGOmRCOyP4XSrVKXM6R812BUVeOEutKn7y',
	2,
	'2006-03-12',
	1,
	1,
	1,
	'2020-04-21',
	1
);

insert into authorities (
	emp_id,
	authorityName)
values(
	7,
	'ROLE_RD');

insert into loginModel( 
	role,
	personalIdNumber,
	name,
	gender,
	empNo,
	pwd,
	dept_No,
	employedDate,
	non_Expired,
	non_Locked,
	credentials_Non_Expired,
	last_Change,
	is_Enable)
values(
	'RD',
	'H111333666',
	'鷹眼',
	'male',
	'sales2',
	'$2a$12$sjCtNizDZiEeweYdVpfxGOmRCOyP4XSrVKXM6R812BUVeOEutKn7y',
	3,
	'2008-05-02',
	1,
	1,
	1,
	'2020-03-17',
	1
);

insert into authorities (
	emp_id,
	authorityName)
values(
	8,
	'ROLE_SALES');

insert into loginModel( 
	role,
	personalIdNumber,
	name,
	gender,
	empNo,
	pwd,
	dept_No,
	employedDate,
	non_Expired,
	non_Locked,
	credentials_Non_Expired,
	last_Change,
	is_Enable)
values(
	'RD',
	'I222111111',
	'幻視',
	'male',
	'rd4',
	'$2a$12$sjCtNizDZiEeweYdVpfxGOmRCOyP4XSrVKXM6R812BUVeOEutKn7y',
	2,
	'2009-10-19',
	1,
	1,
	1,
	'2020-08-25',
	1
);

insert into authorities (
	emp_id,
	authorityName)
values(
	9,
	'ROLE_RD');

insert into loginModel( 
	role,
	personalIdNumber,
	name,
	gender,
	empNo,
	pwd,
	dept_No,
	employedDate,
	non_Expired,
	non_Locked,
	credentials_Non_Expired,
	last_Change,
	is_Enable)
values(
	'RD',
	'J111222555777',
	'雷神索爾',
	'male',
	'rd5',
	'$2a$12$sjCtNizDZiEeweYdVpfxGOmRCOyP4XSrVKXM6R812BUVeOEutKn7y',
	2,
	'2016-08-13',
	1,
	1,
	1,
	'2020-06-30',
	1
);

insert into authorities (
	emp_id,
	authorityName)
values(
	10,
	'ROLE_RD');

	insert into loginModel( 
	role,
	personalIdNumber,
	name,
	gender,
	empNo,
	pwd,
	dept_No,
	employedDate,
	non_Expired,
	non_Locked,
	credentials_Non_Expired,
	last_Change,
	is_Enable)
values(
	'RD',
	'K111333666',
	'洛基',
	'male',
	'sales3',
	'$2a$12$sjCtNizDZiEeweYdVpfxGOmRCOyP4XSrVKXM6R812BUVeOEutKn7y',
	3,
	'2008-04-19',
	1,
	1,
	1,
	'2020-03-17',
	1
);

insert into authorities (
	emp_id,
	authorityName)
values(
	11,
	'ROLE_SALES');
create table personnel(
	emp_id int not null foreign key references loginModel(emp_id),
	phoneNumber nvarchar(20) null,
	address nvarchar(max) null,
	email nvarchar(max) null
);

insert into [personnel] (
		[emp_id]
      ,[phoneNumber]
      ,[address]
      ,[email])
values (1, 0987654321, '', '');

insert into [personnel] (
		[emp_id]
      ,[phoneNumber]
      ,[address]
      ,[email])
values (2, 0912345678, 'Taipei', '');

insert into [personnel] (
		[emp_id]
      ,[phoneNumber]
      ,[address]
      ,[email])
values (3, '', 'usa', '');

insert into [personnel] (
		[emp_id]
      ,[phoneNumber]
      ,[address]
      ,[email])
values (4, '0945678123', 'New Taipei', 'example@test.com');

insert into [personnel] (
		[emp_id]
      ,[phoneNumber]
      ,[address]
      ,[email])
values (5, '0945678123', 'New Taipei', 'example@test.com');

insert into [personnel] (
		[emp_id]
      ,[phoneNumber]
      ,[address]
      ,[email])
values (6, '0945678123', 'New Taipei', 'example@test.com');

insert into [personnel] (
		[emp_id]
      ,[phoneNumber]
      ,[address]
      ,[email])
values (7, '0945678123', 'New Taipei', 'example@test.com');

insert into [personnel] (
		[emp_id]
      ,[phoneNumber]
      ,[address]
      ,[email])
values (8, '0945678123', 'New Taipei', 'example@test.com');

insert into [personnel] (
		[emp_id]
      ,[phoneNumber]
      ,[address]
      ,[email])
values (9, '0945678123', 'New Taipei', 'example@test.com');

insert into [personnel] (
		[emp_id]
      ,[phoneNumber]
      ,[address]
      ,[email])
values (10, '0945678123', 'New Taipei', 'example@test.com');
