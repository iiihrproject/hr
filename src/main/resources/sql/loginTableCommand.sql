use hrdb;

create table loginModel(
	emp_id int not null identity primary key,
	role nvarchar(10) not null,
	empNo nvarchar(max) not null,
	pwd nvarchar(max) not null,
	dept_No int not null,
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
 * login password is "admin"
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
	111,
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