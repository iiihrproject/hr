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
values('Sales', 3);

create table loginModel(
	emp_id int not null identity primary key,
	role nvarchar(10) not null,
	empNo nvarchar(max) not null,
	pwd nvarchar(max) not null,
	dept_No int not null foreign key references departmentDetail(dept_no),
	non_Expired bit not null,
	non_Locked bit not null,
	credentials_Non_Expired bit not null,
	last_Change date not null,
	is_Enable bit not null
);

create table authorities(
	id int not null identity primary key,
	emp_id int not null foreign key references loginModel(emp_id),
	authorityName nvarchar(20) not null
);
/*
 * login password is same as username
 * using default BCrypt strenth which is 10 rounds
 */
insert into loginModel( 
	role,
	empNo,
	pwd,
	dept_No,
	non_Expired,
	non_Locked,
	credentials_Non_Expired,
	last_Change,
	is_Enable)
values(
	'ADMIN',
	'admin',
	'$2a$12$64k2FImhrK9hstivLPWexee5H6B/843r5LLxZQ6CtX82CIHx.7hby',
	1,
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
	1,
	'ROLE_GENERAL');

insert into authorities (
	emp_id,
	authorityName)
values(
	1,
	'ROLE_MANAGER');

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
	'ROLE_ADMIN');
	
insert into loginModel( 
	role,
	empNo,
	pwd,
	dept_No,
	non_Expired,
	non_Locked,
	credentials_Non_Expired,
	last_Change,
	is_Enable)
values(
	'HR',
	'hr',
	'$2a$12$IrOf4wt1RK2vso6F3.SPeOt3ybZJ0ko.dayrLtznN8v.RsOivCV8e',
	1,
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
	'ROLE_GENERAL');

insert into authorities (
	emp_id,
	authorityName)
values(
	2,
	'ROLE_HR');

insert into loginModel( 
	role,
	empNo,
	pwd,
	dept_No,
	non_Expired,
	non_Locked,
	credentials_Non_Expired,
	last_Change,
	is_Enable)
values(
	'MANAGER',
	'manager',
	'$2a$12$5n.p3mUi.l3/BmhftnijC.2lrfMy3OlfK0Y2ik724EbmB/S1l7V.2',
	2,
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
	'ROLE_GENERAL');

insert into authorities (
	emp_id,
	authorityName)
values(
	3,
	'ROLE_MANAGER');

insert into loginModel( 
	role,
	empNo,
	pwd,
	dept_No,
	non_Expired,
	non_Locked,
	credentials_Non_Expired,
	last_Change,
	is_Enable)
values(
	'GENERAL',
	'general',
	'$2a$12$mItWBjCCPoO8zPbhlhil.ub3cKllOyTlqeVSr/wc3qNB0AmUnL4SK',
	2,
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
	4,
	'ROLE_GENERAL');
	
create table personnel(
	emp_id int not null primary key references loginModel(emp_id),
	name nvarchar(max) not null,
	phoneNumber nvarchar(20) null,
	address nvarchar(max) null,
	email nvarchar(max) null
);

insert into [personnel] (
		[emp_id]
      ,[name]
      ,[phoneNumber]
      ,[address]
      ,[email])
values (1, 'Funsa', 0987654321, '', '');

