USE [HRDB];

drop table IF EXISTS [dbo].[dimEmpAvailability];
drop table IF EXISTS [dbo].[dimShift];
drop table IF EXISTS [dbo].[factSchedule];
drop table IF EXISTS [dbo].[IsHoliday];
drop table IF EXISTS [dbo].[LeaveOfAbsense];
drop table IF EXISTS [dbo].[ListSetting];
drop table IF EXISTS [dbo].[calendartask];
drop table IF EXISTS [dbo].[bulletin];
drop table IF EXISTS [dbo].[bulLike];
drop table IF EXISTS [dbo].[bulMessage];
drop table IF EXISTS [dbo].[bulEnroll];
drop table IF EXISTS [dbo].[checksystem];
drop table IF EXISTS [dbo].[ComplementSignAuditted];
drop table IF EXISTS [dbo].[ComplementSignPendingApproval];
drop table IF EXISTS [dbo].[overtimeapplicationauditted];
drop table IF EXISTS [dbo].[overtimeapplicationpending];
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

INSERT [dbo].[personnel] ([emp_id], [phoneNumber], [address], [email]) VALUES (1, N'0945678123', N'USA', N'nickFury@hr.com')
INSERT [dbo].[personnel] ([emp_id], [phoneNumber], [address], [email]) VALUES (2, N'0945678123', N'Soviet Union', N'natashaRomanoff@hr.com')
INSERT [dbo].[personnel] ([emp_id], [phoneNumber], [address], [email]) VALUES (3, N'0945678123', N'	Manhattan, NY', N'tonyStark@hr.com')
INSERT [dbo].[personnel] ([emp_id], [phoneNumber], [address], [email]) VALUES (4, N'0945678123', N'Queens, NY', N'peterParker@hr.com')
INSERT [dbo].[personnel] ([emp_id], [phoneNumber], [address], [email]) VALUES (5, N'0945678123', N'	Brooklyn, NY', N'steveRogers@hr.com')
INSERT [dbo].[personnel] ([emp_id], [phoneNumber], [address], [email]) VALUES (6, N'0945678123', N'Sokovia', N'wandaMaximoff@hr.com')
INSERT [dbo].[personnel] ([emp_id], [phoneNumber], [address], [email]) VALUES (7, N'0945678123', N'Dayton, Ohio', N'bruceBanner@hr.com')
INSERT [dbo].[personnel] ([emp_id], [phoneNumber], [address], [email]) VALUES (8, N'0945678123', N'USA', N'clintBarton@hr.com')
INSERT [dbo].[personnel] ([emp_id], [phoneNumber], [address], [email]) VALUES (9, N'0945678123', N'New Taipei', N'vision@hr.com')
INSERT [dbo].[personnel] ([emp_id], [phoneNumber], [address], [email]) VALUES (10, N'0945678123', N'Asgard', N'thor@hr.com')
INSERT [dbo].[personnel] ([emp_id], [phoneNumber], [address], [email]) VALUES (11, N'0945678123', N'Asgard', N'loki@hr.com')
GO

CREATE TABLE calendartask(
	no int not null primary key IDENTITY,
	empNO nvarchar(max) not null,
	starttime datetime not null,
	endtime datetime not null,
	colortag nvarchar(max) not null,
	tasktitle nvarchar(max) not null,
	tasktext nvarchar(max) not null,
	createtime nvarchar(max) not null,
	edittime nvarchar(max) not null,
	taskstatus bit not null,	
);

INSERT INTO calendartask(empNo, starttime, endtime, colortag, tasktitle, tasktext, createtime, edittime, taskstatus)
VALUES('hrmanager', '2021-09-01 13:30', '2021-09-01 15:00', '#f5002f', '月例會', '大溪地計畫進度匯報', '2021-08-31 16:55', '2021-08-31 16:55', '0');
INSERT INTO calendartask(empNo, starttime, endtime, colortag, tasktitle, tasktext, createtime, edittime, taskstatus)
VALUES('hrmanager', '2021-08-20 00:00', '2021-08-20 23:59', '#f5002f', '生日會報名', '今年記得要報名', '2021-08-31 16:55', '2021-08-31 16:55', '0');
INSERT INTO calendartask(empNo, starttime, endtime, colortag, tasktitle, tasktext, createtime, edittime, taskstatus)
VALUES('hrmanager', '2021-08-12 09:30', '2021-08-18 18:00', '#f5002f', '出差', '10點飛行器出發', '2021-08-31 16:55', '2021-08-31 16:55', '0');
INSERT INTO calendartask(empNo, starttime, endtime, colortag, tasktitle, tasktext, createtime, edittime, taskstatus)
VALUES('hrmanager', '2021-09-07 11:50', '2021-09-07 13:00', '#f5002f', '午餐會議', '東尼要來(還沒決定餐廳)', '2021-08-31 16:55', '2021-08-31 16:55', '0');
INSERT INTO calendartask(empNo, starttime, endtime, colortag, tasktitle, tasktext, createtime, edittime, taskstatus)
VALUES('hrmanager', '2021-09-15 00:00', '2021-09-18 23:59', '#f5002f', '年度休假', '機票&飯店發票要記得打統編', '2021-08-31 16:55', '2021-08-31 16:55', '0');
INSERT INTO calendartask(empNo, starttime, endtime, colortag, tasktitle, tasktext, createtime, edittime, taskstatus)
VALUES('hrmanager', '2021-09-20 17:00', '2021-09-20 18:00', '#f5002f', '預算報告', '2022年度預算報告，5點前要寫完', '2021-08-31 16:55', '2021-08-31 16:55', '0');
INSERT INTO calendartask(empNo, starttime, endtime, colortag, tasktitle, tasktext, createtime, edittime, taskstatus)
VALUES('hrmanager', '2021-09-28 15:00', '2021-09-28 15:05', '#f5002f', '資產預估報告', '2022年度資產預估，3點要交', '2021-08-31 16:55', '2021-08-31 16:55', '0');

INSERT INTO calendartask(empNo, starttime, endtime, colortag, tasktitle, tasktext, createtime, edittime, taskstatus)
VALUES('rdmanager', '2021-09-20 17:03', '2021-09-20 17:38', '#ff0d00', '預算', '算明年要花的錢 煩', '2021-08-31 16:55', '2021-08-31 16:55', '0');
INSERT INTO calendartask(empNo, starttime, endtime, colortag, tasktitle, tasktext, createtime, edittime, taskstatus)
VALUES('rdmanager', '2021-09-28 14:47', '2021-09-28 15:11', '#7a5e85', '資產預估', '明年要買的東西', '2021-08-31 16:55', '2021-08-31 16:55', '0');
INSERT INTO calendartask(empNo, starttime, endtime, colortag, tasktitle, tasktext, createtime, edittime, taskstatus)
VALUES('rdmanager', '2021-09-03 09:14', '2021-09-03 12:56', '#79fcac', '開會', '每個月都要 煩煩煩', '2021-08-31 16:55', '2021-08-31 16:55', '0');
INSERT INTO calendartask(empNo, starttime, endtime, colortag, tasktitle, tasktext, createtime, edittime, taskstatus)
VALUES('rdmanager', '2021-09-08 00:14', '2021-09-11 22:56', '#ff0d00', '休假', '休假', '2021-08-31 16:55', '2021-08-31 16:55', '0');
INSERT INTO calendartask(empNo, starttime, endtime, colortag, tasktitle, tasktext, createtime, edittime, taskstatus)
VALUES('rdmanager', '2021-08-29 09:14', '2021-08-31 20:41', '#ffc4a3', '馬賽', '跟小辣椒一起出國', '2021-08-31 16:55', '2021-08-31 16:55', '0');
INSERT INTO calendartask(empNo, starttime, endtime, colortag, tasktitle, tasktext, createtime, edittime, taskstatus)
VALUES('rdmanager', '2021-08-18 09:14', '2021-08-18 20:41', '#009421', '小辣椒紀念日', '.', '2021-08-31 16:55', '2021-08-31 16:55', '0');
INSERT INTO calendartask(empNo, starttime, endtime, colortag, tasktitle, tasktext, createtime, edittime, taskstatus)
VALUES('rdmanager', '2021-09-30 00:57', '2021-10-03 21:55', '#40ffed', '出差', '公假', '2021-08-31 16:55', '2021-08-31 16:55', '0');

INSERT INTO calendartask(empNo, starttime, endtime, colortag, tasktitle, tasktext, createtime, edittime, taskstatus)
VALUES('hr1', '2021-08-16 09:30', '2021-08-19 17:30', '#ff0d00', '年中教育訓練', '四天 每個部門至少一人參加', '2021-08-31 16:55', '2021-08-31 16:55', '0');
INSERT INTO calendartask(empNo, starttime, endtime, colortag, tasktitle, tasktext, createtime, edittime, taskstatus)
VALUES('hr1', '2021-08-30 16:00', '2021-08-30 16:30', '#ff0d00', '武器庫盤點支援名單', '名單回收截止日', '2021-08-31 16:55', '2021-08-31 16:55', '0');
INSERT INTO calendartask(empNo, starttime, endtime, colortag, tasktitle, tasktext, createtime, edittime, taskstatus)
VALUES('hr1', '2021-09-29 16:00', '2021-09-29 16:30', '#ff0d00', '武器庫盤點支援名單', '名單回收截止日', '2021-08-31 16:55', '2021-08-31 16:55', '0');
INSERT INTO calendartask(empNo, starttime, endtime, colortag, tasktitle, tasktext, createtime, edittime, taskstatus)
VALUES('hr1', '2021-09-05 08:00', '2021-09-05 19:30', '#ff0d00', '武器庫盤點', '支援人員加班造冊', '2021-08-31 16:55', '2021-08-31 16:55', '0');
INSERT INTO calendartask(empNo, starttime, endtime, colortag, tasktitle, tasktext, createtime, edittime, taskstatus)
VALUES('hr1', '2021-10-07 08:00', '2021-10-07 19:30', '#ff0d00', '武器庫盤點', '支援人員加班造冊', '2021-08-31 16:55', '2021-08-31 16:55', '0');
INSERT INTO calendartask(empNo, starttime, endtime, colortag, tasktitle, tasktext, createtime, edittime, taskstatus)
VALUES('hr1', '2021-09-01 13:00', '2021-09-01 15:30', '#ff0d00', '部門會議', '進度報告', '2021-08-31 16:55', '2021-08-31 16:55', '0');
INSERT INTO calendartask(empNo, starttime, endtime, colortag, tasktitle, tasktext, createtime, edittime, taskstatus)
VALUES('hr1', '2021-09-03 19:00', '2021-09-03 20:00', '#04d45b', '聚會', '女生酒吧聚會', '2021-08-31 16:55', '2021-08-31 16:55', '0');
INSERT INTO calendartask(empNo, starttime, endtime, colortag, tasktitle, tasktext, createtime, edittime, taskstatus)
VALUES('hr1', '2021-09-14 10:00', '2021-09-14 11:00', '#96ccff', '牙醫', '預約10月回診', '2021-08-31 16:55', '2021-08-31 16:55', '0');
INSERT INTO calendartask(empNo, starttime, endtime, colortag, tasktitle, tasktext, createtime, edittime, taskstatus)
VALUES('hr1', '2021-09-16 10:00', '2021-09-16 11:00', '#04d45b', 'LINE熊大路跑', '確認報名結果', '2021-08-31 16:55', '2021-08-31 16:55', '0');
INSERT INTO calendartask(empNo, starttime, endtime, colortag, tasktitle, tasktext, createtime, edittime, taskstatus)
VALUES('hr1', '2021-09-25 19:00', '2021-09-25 22:00', '#04d45b', '聚會', '幻視家晚餐聚會', '2021-08-31 16:55', '2021-08-31 16:55', '0');
INSERT INTO calendartask(empNo, starttime, endtime, colortag, tasktitle, tasktext, createtime, edittime, taskstatus)
VALUES('hr1', '2021-09-26 14:00', '2021-09-26 16:00', '#96ccff', '美容中心', '熱石SPA', '2021-08-31 16:55', '2021-08-31 16:55', '0');

INSERT INTO calendartask(empNo, starttime, endtime, colortag, tasktitle, tasktext, createtime, edittime, taskstatus)
VALUES('rd1', '2021-09-03 09:00', '2021-09-03 21:56', '#0048e8', '部門會議', '開會', '2021-08-31 16:55', '2021-08-31 16:55', '0');
INSERT INTO calendartask(empNo, starttime, endtime, colortag, tasktitle, tasktext, createtime, edittime, taskstatus)
VALUES('rd1', '2021-08-16 09:30', '2021-08-19 10:30', '#ff0d00', '公司上課', '年中教育訓練', '2021-08-31 16:55', '2021-08-31 16:55', '0');
INSERT INTO calendartask(empNo, starttime, endtime, colortag, tasktitle, tasktext, createtime, edittime, taskstatus)
VALUES('rd1', '2021-09-05 08:00', '2021-09-05 09:48', '#ff0d00', '盤點', '8點集合遲到沒有早餐吃 下個月換浩克!!!!', '2021-08-31 16:55', '2021-08-31 16:55', '0');
INSERT INTO calendartask(empNo, starttime, endtime, colortag, tasktitle, tasktext, createtime, edittime, taskstatus)
VALUES('rd1', '2021-09-07 13:00', '2021-09-07 18:59', '#0048e8', '進度報告', '每個禮拜都要回報東尼', '2021-08-31 16:55', '2021-08-31 16:55', '0');
INSERT INTO calendartask(empNo, starttime, endtime, colortag, tasktitle, tasktext, createtime, edittime, taskstatus)
VALUES('rd1', '2021-09-14 13:00', '2021-09-07 18:59', '#ff0d00', '進度報告', '每個禮拜都要回報東尼', '2021-08-31 16:55', '2021-08-31 16:55', '0');
INSERT INTO calendartask(empNo, starttime, endtime, colortag, tasktitle, tasktext, createtime, edittime, taskstatus)
VALUES('rd1', '2021-09-21 13:00', '2021-09-07 18:59', '#0048e8', '進度報告', '每個禮拜都要回報東尼', '2021-08-31 16:55', '2021-08-31 16:55', '0');
INSERT INTO calendartask(empNo, starttime, endtime, colortag, tasktitle, tasktext, createtime, edittime, taskstatus)
VALUES('rd1', '2021-09-28 13:00', '2021-09-07 18:59', '#ff0d00', '進度報告', '每個禮拜都要回報東尼', '2021-08-31 16:55', '2021-08-31 16:55', '0');

INSERT INTO calendartask(empNo, starttime, endtime, colortag, tasktitle, tasktext, createtime, edittime, taskstatus)
VALUES('rd2', '2021-09-03 09:00', '2021-09-03 21:56', '#327a3d', '開會', '開會', '2021-08-31 16:55', '2021-08-31 16:55', '0');
INSERT INTO calendartask(empNo, starttime, endtime, colortag, tasktitle, tasktext, createtime, edittime, taskstatus)
VALUES('rd2', '2021-09-07 13:00', '2021-09-07 18:59', '#187031', '報告', '報告', '2021-08-31 16:55', '2021-08-31 16:55', '0');
INSERT INTO calendartask(empNo, starttime, endtime, colortag, tasktitle, tasktext, createtime, edittime, taskstatus)
VALUES('rd2', '2021-09-14 13:00', '2021-09-07 18:59', '#14a346', '報告', '報告', '2021-08-31 16:55', '2021-08-31 16:55', '0');
INSERT INTO calendartask(empNo, starttime, endtime, colortag, tasktitle, tasktext, createtime, edittime, taskstatus)
VALUES('rd2', '2021-09-21 13:00', '2021-09-07 18:59', '#2e522b', '報告', '報告', '2021-08-31 16:55', '2021-08-31 16:55', '0');
INSERT INTO calendartask(empNo, starttime, endtime, colortag, tasktitle, tasktext, createtime, edittime, taskstatus)
VALUES('rd2', '2021-09-28 13:00', '2021-09-07 18:59', '#1f2e07', '報告', '報告', '2021-08-31 16:55', '2021-08-31 16:55', '0');
INSERT INTO calendartask(empNo, starttime, endtime, colortag, tasktitle, tasktext, createtime, edittime, taskstatus)
VALUES('rd2', '2021-10-07 08:00', '2021-10-07 19:30', '#2e522b', '盤點', '盤點', '2021-08-31 16:55', '2021-08-31 16:55', '0');

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dimEmpAvailability](
	[AvailabilityId] [int] NOT NULL,
	[empno] [nvarchar](50) NULL,
	[DateAvailability] [datetime2](7) NULL,
	[StatusAvailability] [nvarchar](50) NULL,
	[Notes] [nvarchar](200) NULL,
	[CreatedTime] [datetime2](7) NULL,
 CONSTRAINT [PK_dimEmployeeAvailability] PRIMARY KEY CLUSTERED 
(
	[AvailabilityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dimShift]    Script Date: 2021/8/28 上午 08:23:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dimShift](
	[KeyShift] [int] IDENTITY(1,1) NOT NULL,
	[DimShift] [nvarchar](50) NULL,
	[StartTime] [time](7) NULL,
	[EndTime] [time](7) NULL,
	[Hours] [float] NULL,
	[Position] [nvarchar](50) NULL,
 CONSTRAINT [PK__dimShift__47705F70A091DD4E] PRIMARY KEY CLUSTERED 
(
	[KeyShift] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[factSchedule]    Script Date: 2021/8/28 上午 08:23:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[factSchedule](
	[KeySchedule] [int] IDENTITY(1,1) NOT NULL,
	[empID] [nvarchar](50) NULL,
	[HoursOfWork] [float] NULL,
	[Start] [varchar](50) NULL,
	[EndOfShift] [varchar](50) NULL,
	[Title] [nvarchar](50) NULL,
	[KeyAvailability] [int] NULL,
	[IsHoliday] [int] NULL,
	[Date] [datetime2](7) NULL,
	[ShiftId] [varchar](255) NULL,
 CONSTRAINT [PK__factSche__CD26B40FCDFBBE33] PRIMARY KEY CLUSTERED 
(
	[KeySchedule] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[IsHoliday]    Script Date: 2021/8/28 上午 08:23:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IsHoliday](
	[KeyDate] [int] IDENTITY(1,1) NOT NULL,
	[FullDate] [datetime2](7) NULL,
	[IsHoliday] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[KeyDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LeaveOfAbsense]    Script Date: 2021/8/28 上午 08:23:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LeaveOfAbsense](
	[APPLICATIONNO] [varchar](255) NOT NULL,
	[TYPEOFFORM] [varchar](255) NOT NULL,
	[empNo] [varchar](255) NOT NULL,
	[deptNo] [int] NOT NULL,
	[REQUESTDATE] [date] NOT NULL,
	[reason_id] [varchar](255) NOT NULL,
	[STARTDATE] [date] NOT NULL,
	[STARTTIME] [time](7) NOT NULL,
	[ENDDATE] [date] NOT NULL,
	[ENDTIME] [time](7) NOT NULL,
	[DAYS] [float] NULL,
	[COMMENTS] [nvarchar](100) NULL,
	[HANDOFF] [nvarchar](50) NULL,
	[HANDOFFEMAIL] [varchar](255) NULL,
	[SUPPORTINGDOC] [varbinary](max) NULL,
	[STATUS] [varchar](255) NULL,
	[Approval01MGR] [nvarchar](50) NULL,
	[Approval01Date] [smalldatetime] NULL,
	[Approval01Sig] [nvarchar](max) NULL,
 CONSTRAINT [PK__LeaveOfA__4AD829323DD693E6] PRIMARY KEY CLUSTERED 
(
	[APPLICATIONNO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[LeaveOfAbsense] ([APPLICATIONNO], [TYPEOFFORM], [empNo], [deptNo], [REQUESTDATE], [reason_id], [STARTDATE], [STARTTIME], [ENDDATE], [ENDTIME], [DAYS], [COMMENTS], [HANDOFF], [HANDOFFEMAIL], [SUPPORTINGDOC], [STATUS], [Approval01MGR], [Approval01Date], [Approval01Sig]) VALUES (N'L210830200530', N'Leave', N'hr1', 1, CAST(N'2021-08-30' AS Date), N'R07', CAST(N'2021-01-03' AS Date), CAST(N'09:00:00' AS Time), CAST(N'2021-01-03' AS Date), CAST(N'18:00:00' AS Time), 1, N'需要請假', N'1', N'nickFury@hr.com', NULL, N'S04', N'1', CAST(N'2021-08-31T20:11:00' AS SmallDateTime), N'data:image/png;base64,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')
INSERT [dbo].[LeaveOfAbsense] ([APPLICATIONNO], [TYPEOFFORM], [empNo], [deptNo], [REQUESTDATE], [reason_id], [STARTDATE], [STARTTIME], [ENDDATE], [ENDTIME], [DAYS], [COMMENTS], [HANDOFF], [HANDOFFEMAIL], [SUPPORTINGDOC], [STATUS], [Approval01MGR], [Approval01Date], [Approval01Sig]) VALUES (N'L210830200537', N'Leave', N'hr1', 1, CAST(N'2021-08-30' AS Date), N'R09', CAST(N'2021-09-28' AS Date), CAST(N'09:00:00' AS Time), CAST(N'2021-09-28' AS Date), CAST(N'18:00:00' AS Time), 1, N'需要請假', N'1', N'nickFury@hr.com', NULL, N'S03', N'1', CAST(N'2021-08-31T19:42:00' AS SmallDateTime), N'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAASwAAACWCAYAAABkW7XSAAAAAXNSR0IArs4c6QAAEspJREFUeF7tnXvoL0UZxh9LPZW30szMMg9hRdlFssIySfsjQrpLSEWkFmiFWRIUFRSYQZlJEXSRxDTCP0qM6r/0SEWWGaUYiKanu1Fa3spLNx7PjmfOtt/due7M7D5fOJwfv9/szDufd+b5vvPu7Oxu0EcEREAEGiGwWyN2ykwREAERgARLg0AERKAZAhKsZlwlQ0VABCRYGgMiIALNEJBgNeMqGSoCIiDB0hgQARFohoAEqxlXyVAREAEJlsaACIhAMwQkWM24SoaKgAhIsDQGREAEmiEgwWrGVTJUBERAgqUxIAIi0AwBCVYzrpKhIiACEiyNAREQgWYISLCacVXThm4HcCiA4wBc1XRPZHxRAhKsovhX0/h/gIdOBvkYgI+vptfqaHICEqzkSFVhj8CtAA7rfscIa5sIiUAoAQlWKDld50rARFcsL8FypaZygwQkWBoYOQncAmArAIrWIyRYOVGvo24J1jr8XKqXJrriOPuvBKuUG5bTrgRrOb6srSf/BPCoLrp6pATrYfd8F8CrALwewOW1Oa12eyRYtXuoXfsYUfFjxpgirB08+lza9XAByyVYBaCvoMl/dzmruwDs1/VXgrUjl2fmnOZewEQQtABoumSSAMWJ/5hoN5+1C9YFAE7tuHDeae5NDqP/LyBoAdB0ySgBO9FuF1y7YN0G4CAr2rTFXEPKkYAEyxGUijkR6CfaJVg7CdjLwQcB7OlEVIV2ISDB0oBISWAsobz2CMsWrJsBHJ4S/FrqkmCtxdP5+2kS7XcD2HegubULlsnrcc69FsC387tkeS1IsJbn01I9Gkq095eE/wCwVykDC7dLPmbHv+ZdoDMELhBc7zKzFOKv7wWwd5pqm6llU6LddMBEX2sdb+8H8BkA9wPYojuE4eN6rQMonNjwlRQsTkqzo3tNd4DGEu2G1pSgpfZHbfWZ/nOcaEtDhHckWBHwrEs5EM8C8One3qOPAPhEmiaqrcVl5/bUcrHaziUwzERX93SRd39/WoIm1lOFBCuNr41gnQfgX12VjLaWLlhTiXZDd82C1X8AXFsaIuacBCsCXi/C6ueuOEmXLliuQsRyFPI90uBuppb3AeCXGKOrfbpd7trSEOE+CVYEvO7SsZ3dSz4S2DUvxYhi95UmmvuMKNyvBvCd+GG3zhokWPF+3xRl8PcfBXB2fBPV1WBEiBOSS9+xj6uwVdfJSIPOBPBZK7q6ojsPTHMuAqzgRcDrLt203OHvlxphuS4FiWitgtXvN5eF3IOmORcx5wQvAt7EZFyqYLncFbSp+ohbnDfqufq9AM63oqs1C3dSr0iw4nBumowPdAnmpUVYJmo4GsDVjujMDu+ppaNjdU0UG4oq1yjcyZ0lwYpDOrYcZM1L4msmIbcyMInu8uGd08csjMNUv38H4Mm96IrXcKxoS8MUvYm/L2lCRaIIupyDkLeuGf6bz1JzNiERwhofydm0ZObvbwLw9KCRposeIiDBihsIfcG6r3tWbGm7mUOFZ6nivWnUjPWXY+JSACfFDbl1Xy3BivN/X7BCJ3acFfmvDhWekKgsf2/ytGCWv3zAmW8Lsj93dkfuaL5FshfAOIB9wQqd2HFW5L86VHjWlHAfYxTKL79nG2tBghXnsL5gLXVghgiP2Vy6hjOwprZ68O98C/bT4oabrpZgxY0BW7BMdDW0JIhrpfzV7Oemk0Q3WbdU8e731/j9RgDPHIBxDYCjlC9OM4glWHEczaQ0HJeWbCedkLzcVMQRR72eq3nHj0I15velpgmKeEGCFY7dLHlYwxKFypDxnXCm/Br2HLkIM8vwkEPuR9MnkoAEKwyg/QaU7QC2hlXTxFU+Szsj4ksW8L6Qnwjgmxs8+TYAFwE4FsAPmvB25UZKsPwcZAsVJ+Uajrv1Sbj7iJsf+bpK/xzAkQ6RtdmXp3mWyH8C6Q7SPpebZ7b7LpXcW6qrJEXIHEA3ZpnL8qiunoVb49pXH7EPt2ZFV0qwpp19O4D9u2L2c3RriSbYzxcD+OkIqjXlrXy+qMhuW3cO1vRIU4lJAhKscUTmDhlL9VlJsHawW1Peamw3e38k/R7AIdrOMKlBXgUkWJtx9ZeA/ZIULJ+TC7wcU1HhqQhrLcJNl/j01XXZWJGr6zdFgjXsIzPYxo4AZpm/A3hc/W6OsnBMsOaelHbEazrlckxzFIDuYt++svwdAA5I0bjq2EFAgrXrSOCbXcxBc38FcODIQOGA5MmSn1v4YNokWHPnreyI1/xsv7A251t5pnaz94fAxQDeqvmVfmZIsHYynVoCDi0JSwuWvc3Ctu+NAL6VaLgMCdbceaupiNcnEe6LxWU3e79O88Wn+eVLe6K8gO4AZCaEz4bHkhGWLVT82djPvjBCzC1YPrmc2CFr+ja1c953yeZqV0i9vCZnxOdq++LKrV2wzNnrdOzUhKghwuoL1dA56ZwsKc+SZ33vAfCFwFxO6KSxH31yGafcSX6Mw2ZOH3sM77Hd7EP1kRlf8cXX1OuTkIDLQEjYXFVV2ZM/hMOcEZadbJ5KMtMu3wk25hjW9yIAPHVgrrxV6JLTcJpi5DIQfwPg0AAB1GF9LnQDy4RM1MCmqrnMnvw+S8ChCCtlJLMJkLHXxVYTMeYQrJ90SWQXO2KdHbPkNKJ6FYCXRxgSshQ06YU5GEV0rd1L1yRYvwDwPGtZY99hCvEgB+UZAD4fcrHjNT5iZSYL/0/pVyMerHOOiRgqFDbS2DqM6L0EwI8dfWWKsW0d1ucJzbV4yoHt2maJcvbyL1UyNLdg+YpVrjtlU3foUvrT9OG5AK6PrDgmSgu99mcAXpD4CyMSw7IuX7pgpVr+DXk9p2D5ipVveZdRzDOczMsU5jjPyYhVqqcH7DundvQzFVnHRGe5vjRc/LWKMksVLH47H5Fw+bdJsHJMZJ6B/miP5VcOservKH8hAEYPuT6hSfZN9hixpfhwjFNI+DFitWlpa3KANwM4PKCzrDfHmAgwZZmXLFGwciz/+t4POTbYdQT5fMP7bnZ1saFfJ+3JLVihS7BN/bEjHfOzuXM4xizGjpMBfLXbWvEjF9Aq409gSYKVc/nXJ5sr9Dc7pKfybLn62p/c7Dcn8WkAvuQ/vJyu8BFopwoHzirr92voFI5Yn+qwPlfvRJRbgmDdAOBZmZd/fcQx38Rj7pqq9+sA3pyhr2d2Gx1ZdX8DLW3iW1+ujRhnU5FQiiS73cYQx75ofQjAOd1F/ILYPWDzcL/NFPu/MmBeTpWtC9Ycy78hb3NCpB6c5lv/FAAXDjSaq6/2A99D4yGXYKVOsk8JFv8+FEHGbiA27ZKTDuvLrI0tCRYPT2My+p0AvuyQQM2FziSIUydXN0VXuZZ/9gQe21+VQ7BMcjvXvq6xL5RNOS1beKbuJPbH1h8APEnbGXJNuZ31tiRYfJHn3haSXIN9ivrUsm3q+qG/D+VPLgXwpgzLP9O+a8I+h2DlyFuZfplTQb8I4PQNzrBFi+JkxtLYCbNTS3n+vaX5FDJOi1/TEmB7MPk+qJwKdK6JZougvUSh3Tn6avrhsucp9fI3Nrk95UvXL5SxpaBvn1meZ/8/fso4/T2OQCuCZUcDtLmE3caG1ALSFyh61Ey6odMYYjzuewLCprxPqA1zLAVdI53+XjM7J+kqemzrEgBvKTQmQ/3Q7HUlJr4vLBMN2Jv/5l4Opt6ceT+APXqD3Hyr825Vjo/rEnBsyRp7oyFXhGoLK3NJf3IAuCmq/TCAsz3eOanD+hxgpypSs2Bx0D2x6yi/mbcAMPkJ03/uCt8rFYwN9aQSKw5s5kv6zHOLL98paBjFtDV0h80Hfc6loO8dxyFb7LPRTL9c5geZTu2b8+GksiMEXBxSAuDYrXbzzWhsj5mEU32LiUpY99BLE2ivsT33QLeXm5cDeN1Uhyf+HipacywFXceBEfC7AOw30F/6xHxcol22eyWA4yPZ6nIHAjUK1pRIGBEw0ZbpQ+xyxcZlT3TXev8GYN8NS4l+foRt5WSfKqpKtTzMuRSkjaz/YAC3OYx5n/zUVHU8RmZrZl9O2bCqv+ecNCEgp8TK1NkfdLbAXGede+Vrg49QUTg33QAYS5rzbycA+J6vcY7lU0dVsaKVcylojwcXwUptS85nSh3dva5iNQmWz632obzSUA4ixJtDEdWm/JP5dqft3DdlHpsZa5dlc5xUmjOq8hEtbqhlvtGOIl2XayH+co2wzB1S14jZxRb2a448qostqyhTg2CZh0YJnMuq/R3J25GEPWjsHIRjVQ8XY87C3MGzJ5z9Tc6fKY7mrCjfNnII1hxR1ZhobWKQa3tGv72pJeEHAXzS48geV5+yXZ44y5Nn9ZmBQGnBCt1ZbNCYF1bmQsUBSRu5BSHFh4nefQCcC+ADCSqcO6oaMtn+guB4Sr13zAXTlGDlyKH9EgAf2i49h1z4LKZMSdiu+SoX2DFRlV3/HBMuNuk7lDtLcQfQhXOtZcj0+QAoIkPR11C0HNsX7b+KJRhwfSnBSilWAd0ueolP4pdLTy5TN52iwIlaIqIpCnCDKHHP3p97fzOs+fYcvkUn5Yfszf7AlPWqrhECJQTLhOe59yDV6viQmwOGGfNrPLFCn10JkE9fsIxY/QXAEzIAY5uXAXhDhrpV5QYCcwpWyHNsS3WcyxJ2juXpUvj2BSt0g6srj+93G0XnnD+uti263FzA17wEXPQAqqRzJgK1zcm5lcJEyXPNn0owlzdjDuASq/J+XroFfOqh/8n5jCnFcK0pjaJjKadgMd+yZ9c7Obeom9V4YgIULL4Z55jE9aq6CQK5BMveyJirDTlXBEoQ+AaAk7T/qgT6PJvetAQs40u1Og8B85JWfRHPw3uXVlJC1xKwgAPV5OwEzNMPLkfPzG7c0htMJVhaAi59pKh/hgAF61cAni0k8xNIIVhaAs7vN7VYhgAfoOaD1CnmTZkeNN5qDHgtARt3vsz3JmAeNo+ZN96N6oKdBGLA53gCXr4RgZoJcMynPE+r5r5WaVuMYFXZIRklAhkJULB+C+CpGdtQ1SMEJFgaHiLgRuDtAC5U/soNVq5SEqxcZFXv0gjwNNzHSrDKulWCVZa/Wm+HgHK2FfhKglWBE2RCEwQoWLnO1moCQA1GSrBq8IJsqJ3AEQCuB/AyAD+s3dgl2yfBWrJ31bdUBPiC1oOUv0qFM7weCVY4O125HgJ6YWolvpZgVeIImVE1Aeav7uzuElZtaIBxBwB4RXfk8y0APhVQx2yXSLBmQ62GGiZAwToPwFkN98E2/bhOpChUfLciz6i/ovt3Xc19lGDV7B3ZVgOBrwB4R+P5q+dYAnV89/5GI1D8v5mPBKsZV8nQQgT4KM5TGhOsg61lHqMoHlRgBIrR1O2FWEY3K8GKRqgKFk7AnEpS81zhuxMYOfEfBWprT6BuXIqPanbCUhirH20T4OkM/FfbCaNHWQJFoeJLMRhFMYLiz4v8SLAW6VZ1KiEBJtzvAMC7aSU/h/UEiss6I1D8/+6Sxs3VtgRrLtJqp1UCFKwrO7GYsw979wTqwJ5A3TqnMbW0JcGqxROyo1YCFKyjAVw9g4EvtXJRfAzIjqCumaH96puQYFXvIhlYkMAFAE7NeIfwGb1k+XZrTxRzUQ8U7HuVTUuwqnSLjKqEQK4tDecDeCWAvXoC9cdK+l2tGRKsal0jwyogkHpLw7EALgbAfBSjtzMq6GNTJkiwmnKXjJ2ZQMotDZcDeE2Xl+JeKX0CCEiwAqDpktUQSLGl4V0A+D5DvuL+dACXrYZeho5KsDJAVZWLIUDB4p26kIiI2xK2ATgSwEUATlkMlYIdkWAVhK+mqydAwQo5ZZRJ9XcDuAnACQBWuWcqh3clWDmoqs6lEKBgbfHYXmAn1c8GcM5SQNTSDwlWLZ6QHTUS8BEsJdVn8KAEawbIaqJZAhQs5qLuHemBSarfB+A0JdXz+lqClZevam+bAAWLR7c8ONANO6n+NQAnt93VNqyXYLXhJ1lZhgAFax8AJ3aP0PA44UMA7NuZ82sl1ed1jARrXt5qrS0C5m3P/J9RFo9w4eMzNwC4FsC5bXWnfWslWO37UD3IR4A5qUsA3JOvCdXsQ0CC5UNLZUVABIoSkGAVxa/GRUAEfAhIsHxoqawIiEBRAhKsovjVuAiIgA8BCZYPLZUVAREoSkCCVRS/GhcBEfAhIMHyoaWyIiACRQlIsIriV+MiIAI+BCRYPrRUVgREoCgBCVZR/GpcBETAh4AEy4eWyoqACBQlIMEqil+Ni4AI+BCQYPnQUlkREIGiBCRYRfGrcREQAR8CEiwfWiorAiJQlIAEqyh+NS4CIuBDQILlQ0tlRUAEihKQYBXFr8ZFQAR8CEiwfGiprAiIQFECEqyi+NW4CIiADwEJlg8tlRUBEShKQIJVFL8aFwER8CEgwfKhpbIiIAJFCfwPJwLvxPIbfJ8AAAAASUVORK5CYII=')
INSERT [dbo].[LeaveOfAbsense] ([APPLICATIONNO], [TYPEOFFORM], [empNo], [deptNo], [REQUESTDATE], [reason_id], [STARTDATE], [STARTTIME], [ENDDATE], [ENDTIME], [DAYS], [COMMENTS], [HANDOFF], [HANDOFFEMAIL], [SUPPORTINGDOC], [STATUS], [Approval01MGR], [Approval01Date], [Approval01Sig]) VALUES (N'L210831071416', N'Leave', N'rd2', 2, CAST(N'2021-08-30' AS Date), N'R09', CAST(N'2021-03-03' AS Date), CAST(N'09:00:00' AS Time), CAST(N'2021-03-03' AS Date), CAST(N'18:00:00' AS Time), 1, N'需要請假', N'4', N'peterParker@hr.com', NULL, N'S03', N'3', CAST(N'2021-08-31T07:16:00' AS SmallDateTime), N'data:image/png;base64,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')
INSERT [dbo].[LeaveOfAbsense] ([APPLICATIONNO], [TYPEOFFORM], [empNo], [deptNo], [REQUESTDATE], [reason_id], [STARTDATE], [STARTTIME], [ENDDATE], [ENDTIME], [DAYS], [COMMENTS], [HANDOFF], [HANDOFFEMAIL], [SUPPORTINGDOC], [STATUS], [Approval01MGR], [Approval01Date], [Approval01Sig]) VALUES (N'L210831071422', N'Leave', N'rd2', 2, CAST(N'2021-08-30' AS Date), N'R08', CAST(N'2021-05-21' AS Date), CAST(N'09:00:00' AS Time), CAST(N'2021-05-21' AS Date), CAST(N'18:00:00' AS Time), 1, N'需要請假', N'4', N'peterParker@hr.com', NULL, N'S03', N'3', CAST(N'2021-08-31T07:22:00' AS SmallDateTime), N'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAASwAAACWCAYAAABkW7XSAAAAAXNSR0IArs4c6QAACa1JREFUeF7t3d/rJXMcx/HXsiyyCCFttuydSOLKP6BkWRu2lCRRcuFeufEPSHuBEiWlsH4steXCtRvc+HGjyKLY8jMW61dvZpjvceacmfeZ857Pe87z1ObCfD6f9zw+n/P6zpkzM2ebeCGAAAJJBLYlqZMyEUAAARFYLAIEEEgjQGClmSoKRQABAos1gAACaQQIrDRTRaEIIEBgsQYQQCCNAIGVZqooFAEECCzWAAIIpBEgsNJMFYUigACBxRpAAIE0AgRWmqmiUAQQILBYAwggkEaAwEozVRSKAAIEFmsAAQTSCBBYaaaKQhFAgMBiDSCAQBoBAivNVFEoAggQWKwBBBBII0BgpZkqCkUAAQKLNYAAAmkECKw0U0WhCCBAYLEGEEAgjQCBlWaqKBQBBAgs1gACCKQRILDSTBWFIoAAgcUaQACBNAIEVpqpolCHwG+STqr+OZrTpDQBAqu0GaGeVQR+l/7+NfPZdc06X0W1oLZMZEGTQSm9BdoC6k9Jf0ja3rtHGhQtQGAVPT0U1xB4W9JVc46ebBMLKAuvUxCbtgCBNe35zbx3xyXtWBBQRyXtzryD1N5fgMDqb0aL9QickHTynICyoyf7d5ukQ+sZml6zCBBYWWZqenUelHT/goCy8OKFwBYBAosFESkw7yR5fQRFQEXORNKxCKykE5ek7EUf896XdEWS/aDMQgQIrEImYiJlPCLpgZaPeVxmMJFJHnM3CKwx9acxNh/zpjGPKfaCwEoxTUUVuehizQ8kXV5UtRQzKQECa1LTOejOHJN0XtXjvHXC1eSDctNZFwECq4vS9LepbxJuWw/1N3lHJN0wfQ72sFQBAqvUmVlPXa9I2ttyg3A9IkdO67Gn1wEECKwBEAvt4tfGzb9tH+ms9K8lnV/oPlAWAlsECKxpLIgvJF3Uct+d7SEXZ05jnjd+LwisvEtgXkhZMNmLJxfknVcqXyBAYOVaHm0hZeem9ufaFapFoL8AgdXfLLpFW0i9Kunm6GIYD4ExBQisMfXbx24LqcOS9pVZMlUhsH4BAmv9xl1HaAup1yTd1LUTtkNgygIE1riz+52knTPf7tmJc0Jq3Hlh9EIFCKz4iZl3VbmF1OuSbowvhxERyCNAYMXMlV1mYL+P13xZSO2R9HFMCYyCQH4BAms9c2jnnF6ecyGnPROKJ2uux5xeN0CAwBpukj+VtGvO+SgeXDecMT1tuACBtdoCaAupbxqPZlltBFojgMC/AgRW/8XQFlIvSDrQvztaIIBAVwECq5tUW0i9WP1eXrde2AoBBFYSILDa+dqeVW4/5nnrSuo0RgABlwCB9Q9b23PK7f/Z5QcvSbrFJUwjBBAYTGATA+tbSWe1PDuqfjzLZ5IuGUyZjhBAYBCBTQmsto93hnhU0u5BNOkEAQTWKjDlwLLrn2b3z46gZq84XyswnSOAwHACUwishyU92PhhheY+8Wjg4dYKPSEwukCmwLIjJnstq9lC6ntJ54yuSwF9BB6TdF+jQT3fffqYty1H1KsKFtR+2Zu/oFJVf8SrT4zbf3+sTqCXVCe1LBf4WdKpjc3qdfh4I7TqeV7e2/ItZvsixJabFblFpsAqEpCilgo8IemeDkfHz0q6Y2lv/TZ4SJKdMpj3Yu33syxiayatiGmYVBGLfkXajnTsspJzR9zjuyU92SFARyyRodsECCzWxioCy8LJAupKSe+tMsga2hJaa0CN6HIKgdV2cvYnSWdGIG7IGF9VvxC96Fek35V0dRIPQivJRDXLnEJgdTk5y/VXvsXZ9qRU6+0dSdf4ui2mFaFVzFR0K2QKgbVoT9vecDxUb75a21HU1AO//qP3hqTrur112GoMgakHVtP0I0mXtlz9/paka8eYgALGbAv1HySdXUB9USXUl83YLxlxDV+Ues9xNimwZmna7i+0v7ZTfu76seppqNy29P83ywlJ26W/r/mb8hroGRPlbL7JgdWchTslPd1y9FVvV9/mYxc92gP9Dkqyq7MzvDiK6j5LX0q6oNqc90d3t5AtmZD5zMcl7ehwG1DXSeryxUDXvvpsx1FUH63/trXrtOyEvL2ek3S7rxtaDS1AYK0m+qikfdVf5PpWk3mmYzlbUG7auajVZnRr6/q81i+SThuyY/ryCYz1RvJVSysE4gXsyvz6ywfeL/H+W0ZkAkaeAIZPIXCXpKeqSj+UdFmKqidYJIE1wUlll9YmUH95wbeIayNe3DGBNRI8w6YVsOv59lTVXy/pSNo9SVg4gZVw0ii5CIH6m1/7le8xnz5RBEZUEQRWlDTjTFHAvj20b4enfutSMXNHYBUzFRSSVOCwpL1V7c9LOpB0P1KUTWClmCaKTCBQn5C3OyFOT1BvyhIJrJTTRtGFCnwu6eKqtgsl2dMveA0oQGANiElXCFQ/yvtJJWEBtguV4QQIrOEs6QmBpoB9NLT7Ue2E/L2N58ijtIIAgbUCHk0RWCJwSNL+xjZ2U/0ZqPkFCCy/HS0R6Cpgj5J+U9LO6nlbdoKel0OAwHKg0QQBp4Ddk/iMJALLCUhgOeFohgAC8QIEVrw5IyKAgFOAwHLC0QwBBOIFCKx4c0ZEAAGnAIHlhKMZAgjECxBY8eaMiAACTgECywlHMwQQiBcgsOLNGREBBJwCBJYTjmYIIBAvQGDFmzMiAgg4BQgsJxzNEEAgXoDAijdnRAQQcAoQWE44miGAQLwAgRVvzogIIOAUILCccDRDAIF4AQIr3pwREUDAKUBgOeFohgAC8QIEVrw5IyKAgFOAwHLC0QwBBOIFCKx4c0ZEAAGnAIHlhKMZAgjECxBY8eaMiAACTgECywlHMwQQiBcgsOLNGREBBJwCBJYTjmYIIBAvQGDFmzMiAgg4BQgsJxzNEEAgXoDAijdnRAQQcAoQWE44miGAQLwAgRVvzogIIOAUILCccDRDAIF4AQIr3pwREUDAKUBgOeFohgAC8QIEVrw5IyKAgFOAwHLC0QwBBOIFCKx4c0ZEAAGnAIHlhKMZAgjECxBY8eaMiAACTgECywlHMwQQiBcgsOLNGREBBJwCBJYTjmYIIBAvQGDFmzMiAgg4BQgsJxzNEEAgXoDAijdnRAQQcAoQWE44miGAQLwAgRVvzogIIOAUILCccDRDAIF4AQIr3pwREUDAKUBgOeFohgAC8QIEVrw5IyKAgFOAwHLC0QwBBOIFCKx4c0ZEAAGnAIHlhKMZAgjECxBY8eaMiAACTgECywlHMwQQiBcgsOLNGREBBJwCBJYTjmYIIBAvQGDFmzMiAgg4BQgsJxzNEEAgXoDAijdnRAQQcAr8BVpL1JePLxtHAAAAAElFTkSuQmCC')
INSERT [dbo].[LeaveOfAbsense] ([APPLICATIONNO], [TYPEOFFORM], [empNo], [deptNo], [REQUESTDATE], [reason_id], [STARTDATE], [STARTTIME], [ENDDATE], [ENDTIME], [DAYS], [COMMENTS], [HANDOFF], [HANDOFFEMAIL], [SUPPORTINGDOC], [STATUS], [Approval01MGR], [Approval01Date], [Approval01Sig]) VALUES (N'L210831071427', N'Leave', N'rd2', 2, CAST(N'2021-08-30' AS Date), N'R06', CAST(N'2021-08-28' AS Date), CAST(N'09:00:00' AS Time), CAST(N'2021-08-28' AS Date), CAST(N'18:00:00' AS Time), 1, N'需要請假', N'4', N'peterParker@hr.com', NULL, N'S03', N'3', CAST(N'2021-08-31T07:23:00' AS SmallDateTime), N'data:image/png;base64,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')
INSERT [dbo].[LeaveOfAbsense] ([APPLICATIONNO], [TYPEOFFORM], [empNo], [deptNo], [REQUESTDATE], [reason_id], [STARTDATE], [STARTTIME], [ENDDATE], [ENDTIME], [DAYS], [COMMENTS], [HANDOFF], [HANDOFFEMAIL], [SUPPORTINGDOC], [STATUS], [Approval01MGR], [Approval01Date], [Approval01Sig]) VALUES (N'L210831071430', N'Leave', N'rd2', 2, CAST(N'2021-08-30' AS Date), N'R02', CAST(N'2021-08-21' AS Date), CAST(N'09:00:00' AS Time), CAST(N'2021-08-21' AS Date), CAST(N'18:00:00' AS Time), 1, N'需要請假', N'8', N'hankPym@hr.com', NULL, N'S03', N'3', CAST(N'2021-08-31T07:23:00' AS SmallDateTime), N'data:image/png;base64,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')
INSERT [dbo].[LeaveOfAbsense] ([APPLICATIONNO], [TYPEOFFORM], [empNo], [deptNo], [REQUESTDATE], [reason_id], [STARTDATE], [STARTTIME], [ENDDATE], [ENDTIME], [DAYS], [COMMENTS], [HANDOFF], [HANDOFFEMAIL], [SUPPORTINGDOC], [STATUS], [Approval01MGR], [Approval01Date], [Approval01Sig]) VALUES (N'L210831071433', N'Leave', N'rd2', 2, CAST(N'2021-08-30' AS Date), N'R10', CAST(N'2021-12-05' AS Date), CAST(N'09:00:00' AS Time), CAST(N'2021-12-05' AS Date), CAST(N'18:00:00' AS Time), 1, N'需要請假', N'3', N'tonyStark@hr.com', NULL, N'S03', N'3', CAST(N'2021-08-31T07:34:00' AS SmallDateTime), N'data:image/png;base64,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')
INSERT [dbo].[LeaveOfAbsense] ([APPLICATIONNO], [TYPEOFFORM], [empNo], [deptNo], [REQUESTDATE], [reason_id], [STARTDATE], [STARTTIME], [ENDDATE], [ENDTIME], [DAYS], [COMMENTS], [HANDOFF], [HANDOFFEMAIL], [SUPPORTINGDOC], [STATUS], [Approval01MGR], [Approval01Date], [Approval01Sig]) VALUES (N'L210831071436', N'Leave', N'rd2', 2, CAST(N'2021-08-30' AS Date), N'R03', CAST(N'2021-07-01' AS Date), CAST(N'09:00:00' AS Time), CAST(N'2021-07-01' AS Date), CAST(N'18:00:00' AS Time), 1, N'需要請假', N'9', N'victorShade@hr.com', NULL, N'S03', N'3', CAST(N'2021-08-31T07:36:00' AS SmallDateTime), N'data:image/png;base64,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')
INSERT [dbo].[LeaveOfAbsense] ([APPLICATIONNO], [TYPEOFFORM], [empNo], [deptNo], [REQUESTDATE], [reason_id], [STARTDATE], [STARTTIME], [ENDDATE], [ENDTIME], [DAYS], [COMMENTS], [HANDOFF], [HANDOFFEMAIL], [SUPPORTINGDOC], [STATUS], [Approval01MGR], [Approval01Date], [Approval01Sig]) VALUES (N'L210831071438', N'Leave', N'rd2', 2, CAST(N'2021-08-30' AS Date), N'R07', CAST(N'2021-09-20' AS Date), CAST(N'09:00:00' AS Time), CAST(N'2021-09-20' AS Date), CAST(N'18:00:00' AS Time), 1, N'需要請假', N'3', N'tonyStark@hr.com', NULL, N'S04', N'3', CAST(N'2021-08-31T08:55:00' AS SmallDateTime), N'data:image/png;base64,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')
INSERT [dbo].[LeaveOfAbsense] ([APPLICATIONNO], [TYPEOFFORM], [empNo], [deptNo], [REQUESTDATE], [reason_id], [STARTDATE], [STARTTIME], [ENDDATE], [ENDTIME], [DAYS], [COMMENTS], [HANDOFF], [HANDOFFEMAIL], [SUPPORTINGDOC], [STATUS], [Approval01MGR], [Approval01Date], [Approval01Sig]) VALUES (N'L210831071443', N'Leave', N'rd2', 2, CAST(N'2021-08-30' AS Date), N'R05', CAST(N'2021-01-23' AS Date), CAST(N'09:00:00' AS Time), CAST(N'2021-01-23' AS Date), CAST(N'18:00:00' AS Time), 1, N'需要請假', N'4', N'peterParker@hr.com', NULL, N'S03', N'3', CAST(N'2021-08-31T08:55:00' AS SmallDateTime), N'data:image/png;base64,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')
INSERT [dbo].[LeaveOfAbsense] ([APPLICATIONNO], [TYPEOFFORM], [empNo], [deptNo], [REQUESTDATE], [reason_id], [STARTDATE], [STARTTIME], [ENDDATE], [ENDTIME], [DAYS], [COMMENTS], [HANDOFF], [HANDOFFEMAIL], [SUPPORTINGDOC], [STATUS], [Approval01MGR], [Approval01Date], [Approval01Sig]) VALUES (N'L210831071446', N'Leave', N'rd2', 2, CAST(N'2021-08-30' AS Date), N'R08', CAST(N'2021-08-27' AS Date), CAST(N'09:00:00' AS Time), CAST(N'2021-08-27' AS Date), CAST(N'18:00:00' AS Time), 1, N'需要請假', N'8', N'hankPym@hr.com', NULL, N'S04', N'3', CAST(N'2021-08-31T18:21:00' AS SmallDateTime), N'data:image/png;base64,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')
INSERT [dbo].[LeaveOfAbsense] ([APPLICATIONNO], [TYPEOFFORM], [empNo], [deptNo], [REQUESTDATE], [reason_id], [STARTDATE], [STARTTIME], [ENDDATE], [ENDTIME], [DAYS], [COMMENTS], [HANDOFF], [HANDOFFEMAIL], [SUPPORTINGDOC], [STATUS], [Approval01MGR], [Approval01Date], [Approval01Sig]) VALUES (N'L210831071449', N'Leave', N'rd2', 2, CAST(N'2021-08-30' AS Date), N'R04', CAST(N'2021-01-14' AS Date), CAST(N'09:00:00' AS Time), CAST(N'2021-01-14' AS Date), CAST(N'18:00:00' AS Time), 1, N'需要請假', N'9', N'victorShade@hr.com', NULL, N'S03', N'3', CAST(N'2021-08-31T18:29:00' AS SmallDateTime), N'data:image/png;base64,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')
INSERT [dbo].[LeaveOfAbsense] ([APPLICATIONNO], [TYPEOFFORM], [empNo], [deptNo], [REQUESTDATE], [reason_id], [STARTDATE], [STARTTIME], [ENDDATE], [ENDTIME], [DAYS], [COMMENTS], [HANDOFF], [HANDOFFEMAIL], [SUPPORTINGDOC], [STATUS], [Approval01MGR], [Approval01Date], [Approval01Sig]) VALUES (N'L210831071451', N'Leave', N'rd2', 2, CAST(N'2021-08-30' AS Date), N'R10', CAST(N'2021-10-15' AS Date), CAST(N'09:00:00' AS Time), CAST(N'2021-10-15' AS Date), CAST(N'18:00:00' AS Time), 1, N'需要請假', N'9', N'victorShade@hr.com', NULL, N'S04', N'3', CAST(N'2021-08-31T11:42:00' AS SmallDateTime), N'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAASwAAACWCAYAAABkW7XSAAAAAXNSR0IArs4c6QAABGJJREFUeF7t1AEJAAAMAsHZv/RyPNwSyDncOQIECEQEFskpJgECBM5geQICBDICBitTlaAECBgsP0CAQEbAYGWqEpQAAYPlBwgQyAgYrExVghIgYLD8AAECGQGDlalKUAIEDJYfIEAgI2CwMlUJSoCAwfIDBAhkBAxWpipBCRAwWH6AAIGMgMHKVCUoAQIGyw8QIJARMFiZqgQlQMBg+QECBDICBitTlaAECBgsP0CAQEbAYGWqEpQAAYPlBwgQyAgYrExVghIgYLD8AAECGQGDlalKUAIEDJYfIEAgI2CwMlUJSoCAwfIDBAhkBAxWpipBCRAwWH6AAIGMgMHKVCUoAQIGyw8QIJARMFiZqgQlQMBg+QECBDICBitTlaAECBgsP0CAQEbAYGWqEpQAAYPlBwgQyAgYrExVghIgYLD8AAECGQGDlalKUAIEDJYfIEAgI2CwMlUJSoCAwfIDBAhkBAxWpipBCRAwWH6AAIGMgMHKVCUoAQIGyw8QIJARMFiZqgQlQMBg+QECBDICBitTlaAECBgsP0CAQEbAYGWqEpQAAYPlBwgQyAgYrExVghIgYLD8AAECGQGDlalKUAIEDJYfIEAgI2CwMlUJSoCAwfIDBAhkBAxWpipBCRAwWH6AAIGMgMHKVCUoAQIGyw8QIJARMFiZqgQlQMBg+QECBDICBitTlaAECBgsP0CAQEbAYGWqEpQAAYPlBwgQyAgYrExVghIgYLD8AAECGQGDlalKUAIEDJYfIEAgI2CwMlUJSoCAwfIDBAhkBAxWpipBCRAwWH6AAIGMgMHKVCUoAQIGyw8QIJARMFiZqgQlQMBg+QECBDICBitTlaAECBgsP0CAQEbAYGWqEpQAAYPlBwgQyAgYrExVghIgYLD8AAECGQGDlalKUAIEDJYfIEAgI2CwMlUJSoCAwfIDBAhkBAxWpipBCRAwWH6AAIGMgMHKVCUoAQIGyw8QIJARMFiZqgQlQMBg+QECBDICBitTlaAECBgsP0CAQEbAYGWqEpQAAYPlBwgQyAgYrExVghIgYLD8AAECGQGDlalKUAIEDJYfIEAgI2CwMlUJSoCAwfIDBAhkBAxWpipBCRAwWH6AAIGMgMHKVCUoAQIGyw8QIJARMFiZqgQlQMBg+QECBDICBitTlaAECBgsP0CAQEbAYGWqEpQAAYPlBwgQyAgYrExVghIgYLD8AAECGQGDlalKUAIEDJYfIEAgI2CwMlUJSoCAwfIDBAhkBAxWpipBCRAwWH6AAIGMgMHKVCUoAQIGyw8QIJARMFiZqgQlQMBg+QECBDICBitTlaAECBgsP0CAQEbAYGWqEpQAAYPlBwgQyAgYrExVghIgYLD8AAECGQGDlalKUAIEDJYfIEAgI2CwMlUJSoCAwfIDBAhkBAxWpipBCRAwWH6AAIGMgMHKVCUoAQIGyw8QIJARMFiZqgQlQMBg+QECBDICBitTlaAECBgsP0CAQEbAYGWqEpQAgQdWMQCX4yW9owAAAABJRU5ErkJggg==')
INSERT [dbo].[LeaveOfAbsense] ([APPLICATIONNO], [TYPEOFFORM], [empNo], [deptNo], [REQUESTDATE], [reason_id], [STARTDATE], [STARTTIME], [ENDDATE], [ENDTIME], [DAYS], [COMMENTS], [HANDOFF], [HANDOFFEMAIL], [SUPPORTINGDOC], [STATUS], [Approval01MGR], [Approval01Date], [Approval01Sig]) VALUES (N'L210831071453', N'Leave', N'rd2', 2, CAST(N'2021-08-30' AS Date), N'R04', CAST(N'2021-10-13' AS Date), CAST(N'09:00:00' AS Time), CAST(N'2021-10-13' AS Date), CAST(N'18:00:00' AS Time), 1, N'需要請假', N'8', N'hankPym@hr.com', NULL, N'S03', N'3', CAST(N'2021-08-31T18:29:00' AS SmallDateTime), N'data:image/png;base64,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')
INSERT [dbo].[LeaveOfAbsense] ([APPLICATIONNO], [TYPEOFFORM], [empNo], [deptNo], [REQUESTDATE], [reason_id], [STARTDATE], [STARTTIME], [ENDDATE], [ENDTIME], [DAYS], [COMMENTS], [HANDOFF], [HANDOFFEMAIL], [SUPPORTINGDOC], [STATUS], [Approval01MGR], [Approval01Date], [Approval01Sig]) VALUES (N'L210831071457', N'Leave', N'rd2', 2, CAST(N'2021-08-30' AS Date), N'R11', CAST(N'2021-05-10' AS Date), CAST(N'09:00:00' AS Time), CAST(N'2021-05-10' AS Date), CAST(N'18:00:00' AS Time), 1, N'需要請假', N'4', N'peterParker@hr.com', NULL, N'S03', N'3', CAST(N'2021-08-31T18:31:00' AS SmallDateTime), N'data:image/png;base64,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')
INSERT [dbo].[LeaveOfAbsense] ([APPLICATIONNO], [TYPEOFFORM], [empNo], [deptNo], [REQUESTDATE], [reason_id], [STARTDATE], [STARTTIME], [ENDDATE], [ENDTIME], [DAYS], [COMMENTS], [HANDOFF], [HANDOFFEMAIL], [SUPPORTINGDOC], [STATUS], [Approval01MGR], [Approval01Date], [Approval01Sig]) VALUES (N'L210831071459', N'Leave', N'rd2', 2, CAST(N'2021-08-30' AS Date), N'R10', CAST(N'2021-06-08' AS Date), CAST(N'09:00:00' AS Time), CAST(N'2021-06-08' AS Date), CAST(N'18:00:00' AS Time), 1, N'需要請假', N'10', N'brandt@hr.com', NULL, N'S03', N'3', CAST(N'2021-08-31T18:34:00' AS SmallDateTime), N'data:image/png;base64,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')
INSERT [dbo].[LeaveOfAbsense] ([APPLICATIONNO], [TYPEOFFORM], [empNo], [deptNo], [REQUESTDATE], [reason_id], [STARTDATE], [STARTTIME], [ENDDATE], [ENDTIME], [DAYS], [COMMENTS], [HANDOFF], [HANDOFFEMAIL], [SUPPORTINGDOC], [STATUS], [Approval01MGR], [Approval01Date], [Approval01Sig]) VALUES (N'L210831071502', N'Leave', N'rd2', 2, CAST(N'2021-08-30' AS Date), N'R09', CAST(N'2021-02-16' AS Date), CAST(N'09:00:00' AS Time), CAST(N'2021-02-16' AS Date), CAST(N'18:00:00' AS Time), 1, N'需要請假', N'8', N'hankPym@hr.com', NULL, N'S04', N'3', CAST(N'2021-08-31T18:40:00' AS SmallDateTime), N'data:image/png;base64,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')
INSERT [dbo].[LeaveOfAbsense] ([APPLICATIONNO], [TYPEOFFORM], [empNo], [deptNo], [REQUESTDATE], [reason_id], [STARTDATE], [STARTTIME], [ENDDATE], [ENDTIME], [DAYS], [COMMENTS], [HANDOFF], [HANDOFFEMAIL], [SUPPORTINGDOC], [STATUS], [Approval01MGR], [Approval01Date], [Approval01Sig]) VALUES (N'L210831165606', N'Leave', N'rd1', 2, CAST(N'2021-08-31' AS Date), N'R02', CAST(N'2021-12-05' AS Date), CAST(N'09:00:00' AS Time), CAST(N'2021-12-05' AS Date), CAST(N'18:00:00' AS Time), 1, N'需要請假', N'10', N'example@test.com', NULL, N'S01', N'待處理...', NULL, NULL)
GO
/****** Object:  Table [dbo].[ListSetting]    Script Date: 2021/8/28 上午 08:23:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ListSetting](
	[code] [nvarchar](50) NOT NULL,
	[category] [nchar](50) NOT NULL,
	[desc_zh] [nvarchar](50) NOT NULL,
	[desc_en] [nchar](50) NULL,
 CONSTRAINT [PK_ListSetting] PRIMARY KEY CLUSTERED 
(
	[code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[dimShift] ON 

INSERT [dbo].[dimShift] ([KeyShift], [DimShift], [StartTime], [EndTime], [Hours], [Position]) VALUES (1, N'日班', CAST(N'09:00:00' AS Time), CAST(N'18:00:00' AS Time), 8, N'客服')
INSERT [dbo].[dimShift] ([KeyShift], [DimShift], [StartTime], [EndTime], [Hours], [Position]) VALUES (2, N'午班', CAST(N'11:00:00' AS Time), CAST(N'20:00:00' AS Time), 8, N'裝貨')
INSERT [dbo].[dimShift] ([KeyShift], [DimShift], [StartTime], [EndTime], [Hours], [Position]) VALUES (3, N'晚班', CAST(N'14:00:00' AS Time), CAST(N'23:00:00' AS Time), 8, N'結算')
SET IDENTITY_INSERT [dbo].[dimShift] OFF
GO
SET IDENTITY_INSERT [dbo].[factSchedule] ON 

INSERT [dbo].[factSchedule] ([KeySchedule], [empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (2006, N'1', NULL, N'2021-08-21T09:00:00', N'2021-08-21T18:00:00', N'fdafdsa', NULL, NULL, NULL, NULL)
INSERT [dbo].[factSchedule] ([KeySchedule], [empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (2007, N'2', NULL, N'2021-08-22T09:00:00', N'2021-08-22T18:00:00', N'Teaching', NULL, NULL, NULL, NULL)
INSERT [dbo].[factSchedule] ([KeySchedule], [empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (2009, N'1', NULL, N'2021-08-23T09:00:00', N'2021-08-23T18:00:00', N'上班', NULL, NULL, NULL, NULL)
INSERT [dbo].[factSchedule] ([KeySchedule], [empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (2010, N'2', NULL, N'2021-08-23T09:00:00', N'2021-08-23T18:00:00', N'上班', NULL, NULL, NULL, NULL)
INSERT [dbo].[factSchedule] ([KeySchedule], [empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (2012, N'2', NULL, N'2021-08-23T09:00:00', N'2021-08-23T18:00:00', N'遠距上班', NULL, NULL, NULL, NULL)
INSERT [dbo].[factSchedule] ([KeySchedule], [empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (2014, N'2', NULL, N'2021-08-24T09:00:00', N'2021-08-24T18:00:00', N'遠距上班', NULL, NULL, NULL, NULL)
INSERT [dbo].[factSchedule] ([KeySchedule], [empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (2015, N'2', NULL, N'2021-08-25T09:00:00', N'2021-08-25T18:00:00', N'遠距上班', NULL, NULL, NULL, NULL)
INSERT [dbo].[factSchedule] ([KeySchedule], [empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (2016, N'2', NULL, N'2021-08-26T09:00:00', N'2021-08-26T18:00:00', N'遠距上班', NULL, NULL, NULL, NULL)
INSERT [dbo].[factSchedule] ([KeySchedule], [empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (2017, N'2', NULL, N'2021-08-27T09:00:00', N'2021-08-27T18:00:00', N'遠距上班', NULL, NULL, NULL, NULL)
INSERT [dbo].[factSchedule] ([KeySchedule], [empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (2020, N'2', NULL, N'2021-08-30T09:00:00', N'2021-08-30T18:00:00', N'遠距上班', NULL, NULL, NULL, NULL)
INSERT [dbo].[factSchedule] ([KeySchedule], [empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (2021, N'2', NULL, N'2021-08-31T09:00:00', N'2021-08-31T18:00:00', N'遠距上班', NULL, NULL, NULL, NULL)
INSERT [dbo].[factSchedule] ([KeySchedule], [empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (2022, N'2', NULL, N'2021-09-01T09:00:00', N'2021-09-01T18:00:00', N'遠距上班', NULL, NULL, NULL, NULL)
INSERT [dbo].[factSchedule] ([KeySchedule], [empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (2023, N'2', NULL, N'2021-09-02T09:00:00', N'2021-09-02T18:00:00', N'遠距上班', NULL, NULL, NULL, NULL)
INSERT [dbo].[factSchedule] ([KeySchedule], [empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (2024, N'2', NULL, N'2021-09-03T09:00:00', N'2021-09-03T18:00:00', N'遠距上班', NULL, NULL, NULL, NULL)
INSERT [dbo].[factSchedule] ([KeySchedule], [empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (2025, N'2', NULL, N'2021-09-06T09:00:00', N'2021-09-06T18:00:00', N'遠距上班', NULL, NULL, NULL, NULL)
INSERT [dbo].[factSchedule] ([KeySchedule], [empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (2027, N'2', NULL, N'2021-09-07T09:00:00', N'2021-09-07T18:00:00', N'遠距上班', NULL, NULL, NULL, NULL)
INSERT [dbo].[factSchedule] ([KeySchedule], [empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (2028, N'2', NULL, N'2021-09-08T09:00:00', N'2021-09-08T18:00:00', N'遠距上班', NULL, NULL, NULL, NULL)
INSERT [dbo].[factSchedule] ([KeySchedule], [empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (2029, N'2', NULL, N'2021-09-09T09:00:00', N'2021-09-09T18:00:00', N'遠距上班', NULL, NULL, NULL, NULL)
INSERT [dbo].[factSchedule] ([KeySchedule], [empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (2030, N'2', NULL, N'2021-09-10T09:00:00', N'2021-09-10T18:00:00', N'遠距上班', NULL, NULL, NULL, NULL)
INSERT [dbo].[factSchedule] ([KeySchedule], [empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (2031, N'2', NULL, N'2021-09-13T09:00:00', N'2021-09-13T18:00:00', N'遠距上班', NULL, NULL, NULL, NULL)
INSERT [dbo].[factSchedule] ([KeySchedule], [empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (2032, N'2', NULL, N'2021-09-14T09:00:00', N'2021-09-14T18:00:00', N'遠距上班', NULL, NULL, NULL, NULL)
INSERT [dbo].[factSchedule] ([KeySchedule], [empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (2033, N'2', NULL, N'2021-09-15T09:00:00', N'2021-09-15T18:00:00', N'遠距上班', NULL, NULL, NULL, NULL)
INSERT [dbo].[factSchedule] ([KeySchedule], [empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (2034, N'2', NULL, N'2021-09-16T09:00:00', N'2021-09-16T18:00:00', N'遠距上班', NULL, NULL, NULL, NULL)
INSERT [dbo].[factSchedule] ([KeySchedule], [empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (2035, N'2', NULL, N'2021-09-17T09:00:00', N'2021-09-17T18:00:00', N'遠距上班', NULL, NULL, NULL, NULL)
INSERT [dbo].[factSchedule] ([KeySchedule], [empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (2036, N'2', NULL, N'2021-09-20T09:00:00', N'2021-09-20T18:00:00', N'遠距上班', NULL, NULL, NULL, NULL)
INSERT [dbo].[factSchedule] ([KeySchedule], [empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (2037, N'2', NULL, N'2021-09-21T09:00:00', N'2021-09-21T18:00:00', N'遠距上班', NULL, NULL, NULL, NULL)
INSERT [dbo].[factSchedule] ([KeySchedule], [empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (2038, N'2', NULL, N'2021-09-22T09:00:00', N'2021-09-22T18:00:00', N'遠距上班', NULL, NULL, NULL, NULL)
INSERT [dbo].[factSchedule] ([KeySchedule], [empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (2039, N'2', NULL, N'2021-09-23T09:00:00', N'2021-09-23T18:00:00', N'遠距上班', NULL, NULL, NULL, NULL)
INSERT [dbo].[factSchedule] ([KeySchedule], [empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (2040, N'2', NULL, N'2021-09-24T09:00:00', N'2021-09-24T18:00:00', N'遠距上班', NULL, NULL, NULL, NULL)
INSERT [dbo].[factSchedule] ([KeySchedule], [empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (2041, N'2', NULL, N'2021-09-27T09:00:00', N'2021-09-27T18:00:00', N'遠距上班', NULL, NULL, NULL, NULL)
INSERT [dbo].[factSchedule] ([KeySchedule], [empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (2042, N'2', NULL, N'2021-09-28T09:00:00', N'2021-09-28T18:00:00', N'遠距上班', NULL, NULL, NULL, NULL)
INSERT [dbo].[factSchedule] ([KeySchedule], [empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (2043, N'2', NULL, N'2021-09-29T09:00:00', N'2021-09-29T18:00:00', N'遠距上班', NULL, NULL, NULL, NULL)
INSERT [dbo].[factSchedule] ([KeySchedule], [empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (2044, N'2', NULL, N'2021-09-30T09:00:00', N'2021-09-30T18:00:00', N'遠距上班', NULL, NULL, NULL, NULL)
INSERT [dbo].[factSchedule] ([KeySchedule], [empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (2045, N'4', NULL, N'2021-08-23T09:00:00', N'2021-08-23T18:00:00', N'到公司上班', NULL, NULL, NULL, NULL)
INSERT [dbo].[factSchedule] ([KeySchedule], [empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (2046, N'4', NULL, N'2021-08-24T09:00:00', N'2021-08-24T18:00:00', N'到公司上班', NULL, NULL, NULL, NULL)
INSERT [dbo].[factSchedule] ([KeySchedule], [empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (2047, N'4', NULL, N'2021-08-25T09:00:00', N'2021-08-25T18:00:00', N'到公司上班', NULL, NULL, NULL, NULL)
INSERT [dbo].[factSchedule] ([KeySchedule], [empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (2048, N'4', NULL, N'2021-08-26T09:00:00', N'2021-08-26T18:00:00', N'到公司上班', NULL, NULL, NULL, NULL)
INSERT [dbo].[factSchedule] ([KeySchedule], [empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (2049, N'4', NULL, N'2021-08-27T09:00:00', N'2021-08-27T18:00:00', N'到公司上班', NULL, NULL, NULL, NULL)
INSERT [dbo].[factSchedule] ([KeySchedule], [empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (2050, N'4', NULL, N'2021-08-30T09:00:00', N'2021-08-30T18:00:00', N'到公司上班', NULL, NULL, NULL, NULL)
INSERT [dbo].[factSchedule] ([KeySchedule], [empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (2051, N'4', NULL, N'2021-08-31T09:00:00', N'2021-08-31T18:00:00', N'到公司上班', NULL, NULL, NULL, NULL)
INSERT [dbo].[factSchedule] ([KeySchedule], [empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (2052, N'4', NULL, N'2021-09-01T09:00:00', N'2021-09-01T18:00:00', N'到公司上班', NULL, NULL, NULL, NULL)
INSERT [dbo].[factSchedule] ([KeySchedule], [empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (2053, N'4', NULL, N'2021-09-02T09:00:00', N'2021-09-02T18:00:00', N'到公司上班', NULL, NULL, NULL, NULL)
INSERT [dbo].[factSchedule] ([KeySchedule], [empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (2054, N'4', NULL, N'2021-09-03T09:00:00', N'2021-09-03T18:00:00', N'到公司上班', NULL, NULL, NULL, NULL)
INSERT [dbo].[factSchedule] ([KeySchedule], [empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (2055, N'4', NULL, N'2021-09-06T09:00:00', N'2021-09-06T18:00:00', N'到公司上班', NULL, NULL, NULL, NULL)
INSERT [dbo].[factSchedule] ([KeySchedule], [empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (2056, N'4', NULL, N'2021-09-07T09:00:00', N'2021-09-07T18:00:00', N'到公司上班', NULL, NULL, NULL, NULL)
INSERT [dbo].[factSchedule] ([KeySchedule], [empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (2057, N'4', NULL, N'2021-09-08T09:00:00', N'2021-09-08T18:00:00', N'到公司上班', NULL, NULL, NULL, NULL)
INSERT [dbo].[factSchedule] ([KeySchedule], [empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (2058, N'4', NULL, N'2021-09-09T09:00:00', N'2021-09-09T18:00:00', N'到公司上班', NULL, NULL, NULL, NULL)
INSERT [dbo].[factSchedule] ([KeySchedule], [empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (2059, N'4', NULL, N'2021-09-10T09:00:00', N'2021-09-10T18:00:00', N'到公司上班', NULL, NULL, NULL, NULL)
INSERT [dbo].[factSchedule] ([KeySchedule], [empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (2060, N'4', NULL, N'2021-09-13T09:00:00', N'2021-09-13T18:00:00', N'到公司上班', NULL, NULL, NULL, NULL)
INSERT [dbo].[factSchedule] ([KeySchedule], [empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (2061, N'4', NULL, N'2021-09-14T09:00:00', N'2021-09-14T18:00:00', N'到公司上班', NULL, NULL, NULL, NULL)
INSERT [dbo].[factSchedule] ([KeySchedule], [empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (2062, N'4', NULL, N'2021-09-15T09:00:00', N'2021-09-15T18:00:00', N'到公司上班', NULL, NULL, NULL, NULL)
INSERT [dbo].[factSchedule] ([KeySchedule], [empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (2063, N'4', NULL, N'2021-09-16T09:00:00', N'2021-09-16T18:00:00', N'到公司上班', NULL, NULL, NULL, NULL)
INSERT [dbo].[factSchedule] ([KeySchedule], [empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (2064, N'4', NULL, N'2021-09-20T09:00:00', N'2021-09-20T18:00:00', N'到公司上班', NULL, NULL, NULL, NULL)
INSERT [dbo].[factSchedule] ([KeySchedule], [empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (2065, N'4', NULL, N'2021-09-17T09:00:00', N'2021-09-17T18:00:00', N'到公司上班', NULL, NULL, NULL, NULL)
INSERT [dbo].[factSchedule] ([KeySchedule], [empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (2066, N'4', NULL, N'2021-09-21T09:00:00', N'2021-09-21T18:00:00', N'到公司上班', NULL, NULL, NULL, NULL)
INSERT [dbo].[factSchedule] ([KeySchedule], [empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (2067, N'4', NULL, N'2021-09-22T09:00:00', N'2021-09-22T18:00:00', N'到公司上班', NULL, NULL, NULL, NULL)
INSERT [dbo].[factSchedule] ([KeySchedule], [empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (2068, N'4', NULL, N'2021-09-23T09:00:00', N'2021-09-23T18:00:00', N'到公司上班', NULL, NULL, NULL, NULL)
INSERT [dbo].[factSchedule] ([KeySchedule], [empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (2069, N'4', NULL, N'2021-09-24T09:00:00', N'2021-09-24T18:00:00', N'到公司上班', NULL, NULL, NULL, NULL)
INSERT [dbo].[factSchedule] ([KeySchedule], [empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (2070, N'4', NULL, N'2021-09-27T09:00:00', N'2021-09-27T18:00:00', N'到公司上班', NULL, NULL, NULL, NULL)
INSERT [dbo].[factSchedule] ([KeySchedule], [empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (2071, N'4', NULL, N'2021-09-28T09:00:00', N'2021-09-28T18:00:00', N'到公司上班', NULL, NULL, NULL, NULL)
INSERT [dbo].[factSchedule] ([KeySchedule], [empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (2072, N'4', NULL, N'2021-09-29T09:00:00', N'2021-09-29T18:00:00', N'到公司上班', NULL, NULL, NULL, NULL)
INSERT [dbo].[factSchedule] ([KeySchedule], [empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (2073, N'4', NULL, N'2021-09-30T09:00:00', N'2021-09-30T18:00:00', N'到公司上班', NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[factSchedule] OFF
GO
INSERT [dbo].[ListSetting] ([code], [category], [desc_zh], [desc_en]) VALUES (N'R01', N'REASON_ID                                         ', N'病假', N'Sick Leave                                        ')
INSERT [dbo].[ListSetting] ([code], [category], [desc_zh], [desc_en]) VALUES (N'R02', N'REASON_ID                                         ', N'事假', N'Personal Leave                                    ')
INSERT [dbo].[ListSetting] ([code], [category], [desc_zh], [desc_en]) VALUES (N'R03', N'REASON_ID                                         ', N'特休', N'Annual Paid Leave                                 ')
INSERT [dbo].[ListSetting] ([code], [category], [desc_zh], [desc_en]) VALUES (N'R04', N'REASON_ID                                         ', N'公假', N'Official Leave                                    ')
INSERT [dbo].[ListSetting] ([code], [category], [desc_zh], [desc_en]) VALUES (N'R05', N'REASON_ID                                         ', N'產假', N'Maternity Leave                                   ')
INSERT [dbo].[ListSetting] ([code], [category], [desc_zh], [desc_en]) VALUES (N'R06', N'REASON_ID                                         ', N'陪產假', N'Paternity Leave                                   ')
INSERT [dbo].[ListSetting] ([code], [category], [desc_zh], [desc_en]) VALUES (N'R07', N'REASON_ID                                         ', N'婚假', N'Marital Leave                                     ')
INSERT [dbo].[ListSetting] ([code], [category], [desc_zh], [desc_en]) VALUES (N'R08', N'REASON_ID                                         ', N'喪假', N'Bereavement Leave                                 ')
INSERT [dbo].[ListSetting] ([code], [category], [desc_zh], [desc_en]) VALUES (N'R09', N'REASON_ID                                         ', N'育嬰假', N'Parental Leave                                    ')
INSERT [dbo].[ListSetting] ([code], [category], [desc_zh], [desc_en]) VALUES (N'R10', N'REASON_ID                                         ', N'生理假', N'Menstrual Leave                                   ')
INSERT [dbo].[ListSetting] ([code], [category], [desc_zh], [desc_en]) VALUES (N'R11', N'REASON_ID                                         ', N'無薪假', N'Unpaid Leave                                      ')
INSERT [dbo].[ListSetting] ([code], [category], [desc_zh], [desc_en]) VALUES (N'S01', N'STATUS_ID                                         ', N'提出申請', N'Pending                                           ')
INSERT [dbo].[ListSetting] ([code], [category], [desc_zh], [desc_en]) VALUES (N'S02', N'STATUS_ID                                         ', N'取消', N'Canceled                                          ')
INSERT [dbo].[ListSetting] ([code], [category], [desc_zh], [desc_en]) VALUES (N'S03', N'STATUS_ID                                         ', N'通過', N'Approved                                          ')
INSERT [dbo].[ListSetting] ([code], [category], [desc_zh], [desc_en]) VALUES (N'S04', N'STATUS_ID                                         ', N'否決', N'Rejected                                          ')
INSERT [dbo].[ListSetting] ([code], [category], [desc_zh], [desc_en]) VALUES (N'T01', N'TYPEOFFORM_ID                                     ', N'請假', N'Leave                                             ')
INSERT [dbo].[ListSetting] ([code], [category], [desc_zh], [desc_en]) VALUES (N'T02', N'TYPEOFFORM_ID                                     ', N'加班', N'OverTime                                          ')
INSERT [dbo].[ListSetting] ([code], [category], [desc_zh], [desc_en]) VALUES (N'T03', N'TYPEOFFORM_ID                                     ', N'補簽', N'LateCheckIn                                       ')
GO
ALTER TABLE [dbo].[LeaveOfAbsense]  WITH CHECK ADD  CONSTRAINT [FKdlv9ihu85m3vwqmwqumqll20h] FOREIGN KEY([deptNo])
REFERENCES [dbo].[departmentDetail] ([dept_no])
GO
ALTER TABLE [dbo].[LeaveOfAbsense] CHECK CONSTRAINT [FKdlv9ihu85m3vwqmwqumqll20h]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[overtimeapplicationauditted](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Type] [nvarchar](50) NOT NULL,
	[DateOfApplication] [date] NOT NULL,
	[managerEmpId] [int] NULL,
	[EmpNo] [nvarchar](50) NOT NULL,
	[EmpName] [nvarchar](50) NOT NULL,
	[department] [nvarchar](50) NOT NULL,
	[position] [nvarchar](50) NOT NULL,
	[OvertimeCategory] [nvarchar](50) NOT NULL,
	[OverTimeDate] [date] NOT NULL,
	[StartingTime] [nchar](5) NOT NULL,
	[EndingTime] [nchar](5) NOT NULL,
	[OverTimeHours] [nvarchar](50) NOT NULL,
	[reason] [nvarchar](50) NOT NULL,
	[Remarks] [nvarchar](50) NULL,
	[result] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_overtimeapplicationauditted] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[overtimeapplicationpending]    Script Date: 2021/8/31 上午 02:57:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[overtimeapplicationpending](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Type] [nvarchar](50) NOT NULL,
	[DateOfApplication] [date] NOT NULL,
	[managerEmpId] [int] NULL,
	[EmpNo] [nvarchar](50) NOT NULL,
	[EmpName] [nvarchar](50) NOT NULL,
	[department] [nvarchar](50) NOT NULL,
	[position] [nvarchar](50) NOT NULL,
	[OvertimeCategory] [nvarchar](50) NOT NULL,
	[OverTimeDate] [date] NOT NULL,
	[StartingTime] [nchar](5) NOT NULL,
	[EndingTime] [nchar](5) NOT NULL,
	[OverTimeHours] [nvarchar](50) NOT NULL,
	[reason] [nvarchar](50) NOT NULL,
	[Remarks] [nvarchar](50) NULL,
	[result] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_overtimeapplicationpending] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[overtimeapplicationauditted] ON 

INSERT [dbo].[overtimeapplicationauditted] ([ID], [Type], [DateOfApplication], [managerEmpId], [EmpNo], [EmpName], [department], [position], [OvertimeCategory], [OverTimeDate], [StartingTime], [EndingTime], [OverTimeHours], [reason], [Remarks], [result]) VALUES (91, N'submit', CAST(N'2021-08-31' AS Date), NULL, N'rd1', N'蜘蛛人', N'RD', N'RD', N'平日加班', CAST(N'2021-08-24' AS Date), N'18:00', N'19:00', N'1.0', N'協助公司營運', N'無', N'Pass')
INSERT [dbo].[overtimeapplicationauditted] ([ID], [Type], [DateOfApplication], [managerEmpId], [EmpNo], [EmpName], [department], [position], [OvertimeCategory], [OverTimeDate], [StartingTime], [EndingTime], [OverTimeHours], [reason], [Remarks], [result]) VALUES (92, N'submit', CAST(N'2021-08-31' AS Date), NULL, N'rd1', N'蜘蛛人', N'RD', N'RD', N'平日加班', CAST(N'2021-08-25' AS Date), N'18:00', N'19:00', N'1.0', N'協助公司營運', N'無', N'Pass')
SET IDENTITY_INSERT [dbo].[overtimeapplicationauditted] OFF
GO
SET IDENTITY_INSERT [dbo].[overtimeapplicationpending] ON 

INSERT [dbo].[overtimeapplicationpending] ([ID], [Type], [DateOfApplication], [managerEmpId], [EmpNo], [EmpName], [department], [position], [OvertimeCategory], [OverTimeDate], [StartingTime], [EndingTime], [OverTimeHours], [reason], [Remarks], [result]) VALUES (104, N'submit', CAST(N'2021-08-31' AS Date), 3, N'rd1', N'蜘蛛人', N'RD', N'RD', N'平日加班', CAST(N'2021-08-26' AS Date), N'18:00', N'20:00', N'2.0', N'協助公司營運', N'無', N'pending')
INSERT [dbo].[overtimeapplicationpending] ([ID], [Type], [DateOfApplication], [managerEmpId], [EmpNo], [EmpName], [department], [position], [OvertimeCategory], [OverTimeDate], [StartingTime], [EndingTime], [OverTimeHours], [reason], [Remarks], [result]) VALUES (105, N'submit', CAST(N'2021-08-31' AS Date), 3, N'rd1', N'蜘蛛人', N'RD', N'RD', N'平日加班', CAST(N'2021-08-30' AS Date), N'18:00', N'21:00', N'3.0', N'協助公司營運', N'無', N'pending')
INSERT [dbo].[overtimeapplicationpending] ([ID], [Type], [DateOfApplication], [managerEmpId], [EmpNo], [EmpName], [department], [position], [OvertimeCategory], [OverTimeDate], [StartingTime], [EndingTime], [OverTimeHours], [reason], [Remarks], [result]) VALUES (106, N'submit', CAST(N'2021-08-31' AS Date), 3, N'rd1', N'蜘蛛人', N'RD', N'RD', N'平日加班', CAST(N'2021-08-12' AS Date), N'18:00', N'21:30', N'3.5', N'協助公司營運', N'無', N'pending')
INSERT [dbo].[overtimeapplicationpending] ([ID], [Type], [DateOfApplication], [managerEmpId], [EmpNo], [EmpName], [department], [position], [OvertimeCategory], [OverTimeDate], [StartingTime], [EndingTime], [OverTimeHours], [reason], [Remarks], [result]) VALUES (107, N'submit', CAST(N'2021-08-31' AS Date), 3, N'rd1', N'蜘蛛人', N'RD', N'RD', N'平日加班', CAST(N'2021-08-23' AS Date), N'18:00', N'20:30', N'2.5', N'研發新型發射器', N'無', N'pending')
SET IDENTITY_INSERT [dbo].[overtimeapplicationpending] OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bulEnroll](
	[enrollId] [int] IDENTITY(1,1) NOT NULL,
	[empDept] [nvarchar](50) NOT NULL,
	[empName] [nvarchar](50) NOT NULL,
	[empNo] [nvarchar](50) NOT NULL,
	[enrollStatus] [nvarchar](50) NOT NULL,
	[postno] [int] NOT NULL,
	[updateTime] [datetime2](7) NOT NULL,
	[createTime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK__bulEnrol__6B68B61BD81BA5FE] PRIMARY KEY CLUSTERED 
(
	[enrollId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bulletin]    Script Date: 2021/8/30 上午 12:12:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bulletin](
	[type] [nvarchar](50) NOT NULL,
	[title] [nvarchar](50) NOT NULL,
	[postdate] [date] NOT NULL,
	[description] [nvarchar](max) NOT NULL,
	[exp] [date] NOT NULL,
	[postno] [int] IDENTITY(1,1) NOT NULL,
	[poststatus] [nvarchar](50) NOT NULL,
	[createTime] [datetime2](7) NOT NULL,
	[quotatype] [nvarchar](50) NULL,
	[quota] [int] NULL,
	[desText] [nvarchar](max) NOT NULL,
	[file1] [nvarchar](50) NULL,
	[picture] [varbinary](max) NULL,
	[endDate] [date] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bulLike]    Script Date: 2021/8/30 上午 12:12:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bulLike](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[empNo] [nvarchar](50) NOT NULL,
	[likeStatus] [nvarchar](50) NOT NULL,
	[postno] [int] NOT NULL,
 CONSTRAINT [PK__bulLike__3213E83FFDB618E5] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bulMessage]    Script Date: 2021/8/30 上午 12:12:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bulMessage](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[createTime] [datetime2](7) NULL,
	[empName] [nvarchar](50) NULL,
	[empNo] [nvarchar](50) NULL,
	[message] [nvarchar](max) NULL,
	[messageDate] [date] NULL,
	[postno] [int] NOT NULL,
	[msgStatus] [nvarchar](50) NULL,
 CONSTRAINT [PK__bulMessa__3213E83F6B724FE8] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[bulEnroll] ON 

INSERT [dbo].[bulEnroll] ([enrollId], [empDept], [empName], [empNo], [enrollStatus], [postno], [updateTime], [createTime]) VALUES (1, N'HR', N'Natasha Alianovna Romanoff', N'hr1', N'參加', 11, CAST(N'2021-08-29T22:16:35.3880000' AS DateTime2), CAST(N'2021-08-29T22:16:35.3880000' AS DateTime2))
INSERT [dbo].[bulEnroll] ([enrollId], [empDept], [empName], [empNo], [enrollStatus], [postno], [updateTime], [createTime]) VALUES (2, N'RD', N'Peter Benjamin Parker', N'rd1', N'參加', 11, CAST(N'2021-08-29T22:17:52.9560000' AS DateTime2), CAST(N'2021-08-29T22:17:52.9560000' AS DateTime2))
INSERT [dbo].[bulEnroll] ([enrollId], [empDept], [empName], [empNo], [enrollStatus], [postno], [updateTime], [createTime]) VALUES (3, N'RD', N'Peter Benjamin Parker', N'rd1', N'參加', 9, CAST(N'2021-08-29T22:19:31.3000000' AS DateTime2), CAST(N'2021-08-29T22:19:31.3000000' AS DateTime2))
INSERT [dbo].[bulEnroll] ([enrollId], [empDept], [empName], [empNo], [enrollStatus], [postno], [updateTime], [createTime]) VALUES (4, N'SALES', N'Steve Rogers', N'salesmanager', N'參加', 11, CAST(N'2021-08-29T22:21:55.6250000' AS DateTime2), CAST(N'2021-08-29T22:21:55.6250000' AS DateTime2))
INSERT [dbo].[bulEnroll] ([enrollId], [empDept], [empName], [empNo], [enrollStatus], [postno], [updateTime], [createTime]) VALUES (5, N'SALES', N'Steve Rogers', N'salesmanager', N'參加', 6, CAST(N'2021-08-29T22:22:10.8450000' AS DateTime2), CAST(N'2021-08-29T22:22:10.8450000' AS DateTime2))
INSERT [dbo].[bulEnroll] ([enrollId], [empDept], [empName], [empNo], [enrollStatus], [postno], [updateTime], [createTime]) VALUES (6, N'RD', N'Hank Pym', N'rd3', N'取消參加', 9, CAST(N'2021-08-29T22:24:07.0780000' AS DateTime2), CAST(N'2021-08-29T22:23:31.5900000' AS DateTime2))
INSERT [dbo].[bulEnroll] ([enrollId], [empDept], [empName], [empNo], [enrollStatus], [postno], [updateTime], [createTime]) VALUES (7, N'SALES', N'Wanda Maximoff', N'sales1', N'參加', 11, CAST(N'2021-08-29T23:42:53.4010000' AS DateTime2), CAST(N'2021-08-29T23:42:04.0480000' AS DateTime2))
INSERT [dbo].[bulEnroll] ([enrollId], [empDept], [empName], [empNo], [enrollStatus], [postno], [updateTime], [createTime]) VALUES (8, N'RD', N'Brandt', N'rd5', N'參加', 11, CAST(N'2021-08-29T23:43:21.1340000' AS DateTime2), CAST(N'2021-08-29T23:43:21.1340000' AS DateTime2))
SET IDENTITY_INSERT [dbo].[bulEnroll] OFF
GO
SET IDENTITY_INSERT [dbo].[bulletin] ON 

INSERT [dbo].[bulletin] ([type], [title], [postdate], [description], [exp], [postno], [poststatus], [createTime], [quotatype], [quota], [desText], [file1], [picture], [endDate]) VALUES (N'公告', N'COVID-19防疫注意事項', CAST(N'2021-06-01' AS Date), N'<p>內容待補</p>', CAST(N'2021-12-31' AS Date), 1, N'normal', CAST(N'2021-08-29T19:44:15.8930000' AS DateTime2), N'', 0, N'內容待補', NULL, NULL, NULL)
INSERT [dbo].[bulletin] ([type], [title], [postdate], [description], [exp], [postno], [poststatus], [createTime], [quotatype], [quota], [desText], [file1], [picture], [endDate]) VALUES (N'公告', N'端午節禮金發送', CAST(N'2021-06-07' AS Date), N'<p>內容待補</p>', CAST(N'2021-06-18' AS Date), 2, N'normal', CAST(N'2021-08-29T19:59:17.0710000' AS DateTime2), N'', NULL, N'內容待補', NULL, NULL, NULL)
INSERT [dbo].[bulletin] ([type], [title], [postdate], [description], [exp], [postno], [poststatus], [createTime], [quotatype], [quota], [desText], [file1], [picture], [endDate]) VALUES (N'公告', N'今年度家庭日延期舉辦', CAST(N'2021-06-10' AS Date), N'<p>內容待補</p>', CAST(N'2021-06-30' AS Date), 3, N'normal', CAST(N'2021-08-29T19:59:53.9180000' AS DateTime2), N'', NULL, N'內容待補', NULL, NULL, NULL)
INSERT [dbo].[bulletin] ([type], [title], [postdate], [description], [exp], [postno], [poststatus], [createTime], [quotatype], [quota], [desText], [file1], [picture], [endDate]) VALUES (N'活動', N'7月份生日會', CAST(N'2021-06-25' AS Date), N'<p>內容待補</p>', CAST(N'2021-07-31' AS Date), 4, N'normal', CAST(N'2021-08-29T20:00:49.8710000' AS DateTime2), N'限制', 20, N'內容待補', NULL, NULL, CAST(N'2021-06-30' AS Date))
INSERT [dbo].[bulletin] ([type], [title], [postdate], [description], [exp], [postno], [poststatus], [createTime], [quotatype], [quota], [desText], [file1], [picture], [endDate]) VALUES (N'公告', N'新增特約店家-住宿9折優惠', CAST(N'2021-07-01' AS Date), N'<p>內容待補內容待補內容待補</p>', CAST(N'2021-09-30' AS Date), 5, N'normal', CAST(N'2021-08-29T20:01:32.3350000' AS DateTime2), N'', NULL, N'內容待補內容待補內容待補', NULL, NULL, NULL)
INSERT [dbo].[bulletin] ([type], [title], [postdate], [description], [exp], [postno], [poststatus], [createTime], [quotatype], [quota], [desText], [file1], [picture], [endDate]) VALUES (N'活動', N'8月份生日會', CAST(N'2021-07-25' AS Date), N'<p>內容待補內容待補</p>', CAST(N'2021-08-31' AS Date), 6, N'normal', CAST(N'2021-08-29T20:02:56.1300000' AS DateTime2), N'限制', 20, N'內容待補內容待補', NULL, NULL, CAST(N'2021-07-31' AS Date))
INSERT [dbo].[bulletin] ([type], [title], [postdate], [description], [exp], [postno], [poststatus], [createTime], [quotatype], [quota], [desText], [file1], [picture], [endDate]) VALUES (N'公告', N'人事異動通知：洛基升任阿斯嘉國王', CAST(N'2021-08-01' AS Date), N'<p>內容待補內容待補</p>', CAST(N'2021-10-31' AS Date), 7, N'normal', CAST(N'2021-08-29T20:04:46.6980000' AS DateTime2), N'', NULL, N'內容待補內容待補', NULL, NULL, NULL)
INSERT [dbo].[bulletin] ([type], [title], [postdate], [description], [exp], [postno], [poststatus], [createTime], [quotatype], [quota], [desText], [file1], [picture], [endDate]) VALUES (N'公告', N'新增特約店家-餐飲滿千85折', CAST(N'2021-08-03' AS Date), N'<p>內容待補內容待補</p>', CAST(N'2021-09-30' AS Date), 8, N'normal', CAST(N'2021-08-29T20:15:33.5480000' AS DateTime2), N'', NULL, N'內容待補內容待補', NULL, NULL, NULL)
INSERT [dbo].[bulletin] ([type], [title], [postdate], [description], [exp], [postno], [poststatus], [createTime], [quotatype], [quota], [desText], [file1], [picture], [endDate]) VALUES (N'活動', N'模仿大賽 (洛基禁止參加)', CAST(N'2021-08-10' AS Date), N'<p>內容待補內容待補</p>', CAST(N'2021-08-31' AS Date), 9, N'normal', CAST(N'2021-08-29T20:17:11.3960000' AS DateTime2), N'限制', 10, N'內容待補內容待補', NULL, NULL, CAST(N'2021-08-20' AS Date))
INSERT [dbo].[bulletin] ([type], [title], [postdate], [description], [exp], [postno], [poststatus], [createTime], [quotatype], [quota], [desText], [file1], [picture], [endDate]) VALUES (N'活動', N'9月份生日會', CAST(N'2021-08-25' AS Date), N'<p>內容待補內容待補</p>', CAST(N'2021-09-30' AS Date), 10, N'normal', CAST(N'2021-08-29T20:19:06.1980000' AS DateTime2), N'限制', 20, N'內容待補內容待補', NULL, NULL, CAST(N'2021-08-31' AS Date))
INSERT [dbo].[bulletin] ([type], [title], [postdate], [description], [exp], [postno], [poststatus], [createTime], [quotatype], [quota], [desText], [file1], [picture], [endDate]) VALUES (N'活動', N'誰能拿起雷神之鎚', CAST(N'2021-08-27' AS Date), N'<p>內容待補內容待補內容待補內容待補</p>', CAST(N'2021-09-20' AS Date), 11, N'normal', CAST(N'2021-08-29T20:20:10.4130000' AS DateTime2), N'限制', 5, N'內容待補內容待補內容待補內容待補', NULL, NULL, CAST(N'2021-09-15' AS Date))
INSERT [dbo].[bulletin] ([type], [title], [postdate], [description], [exp], [postno], [poststatus], [createTime], [quotatype], [quota], [desText], [file1], [picture], [endDate]) VALUES (N'公告', N'年度員工健康檢查', CAST(N'2021-08-30' AS Date), N'<p>內容待補內容待補內容待補內容待補</p>', CAST(N'2021-09-20' AS Date), 12, N'normal', CAST(N'2021-08-29T20:21:00.6860000' AS DateTime2), N'', NULL, N'內容待補內容待補內容待補內容待補', NULL, NULL, NULL)
INSERT [dbo].[bulletin] ([type], [title], [postdate], [description], [exp], [postno], [poststatus], [createTime], [quotatype], [quota], [desText], [file1], [picture], [endDate]) VALUES (N'公告', N'清潔消毒通知', CAST(N'2021-08-31' AS Date), N'<p>內容待補內容待補內容待補內容待補</p>', CAST(N'2021-09-10' AS Date), 13, N'normal', CAST(N'2021-08-29T20:21:55.6630000' AS DateTime2), N'', NULL, N'內容待補內容待補內容待補內容待補', NULL, NULL, NULL)
INSERT [dbo].[bulletin] ([type], [title], [postdate], [description], [exp], [postno], [poststatus], [createTime], [quotatype], [quota], [desText], [file1], [picture], [endDate]) VALUES (N'活動', N'中秋歌唱大賽', CAST(N'2021-09-01' AS Date), N'<p>內容待補內容待補</p>', CAST(N'2021-10-31' AS Date), 14, N'normal', CAST(N'2021-08-29T20:23:23.0570000' AS DateTime2), N'限制', 15, N'內容待補內容待補', NULL, NULL, CAST(N'2021-09-30' AS Date))
INSERT [dbo].[bulletin] ([type], [title], [postdate], [description], [exp], [postno], [poststatus], [createTime], [quotatype], [quota], [desText], [file1], [picture], [endDate]) VALUES (N'公告', N'新社團成立-冥想社', CAST(N'2021-09-03' AS Date), N'<p>內容待補內容待補內容待補內容待補</p>', CAST(N'2021-10-31' AS Date), 15, N'normal', CAST(N'2021-08-29T20:24:33.3990000' AS DateTime2), N'', NULL, N'內容待補內容待補內容待補內容待補', NULL, NULL, NULL)
INSERT [dbo].[bulletin] ([type], [title], [postdate], [description], [exp], [postno], [poststatus], [createTime], [quotatype], [quota], [desText], [file1], [picture], [endDate]) VALUES (N'活動', N'網球比賽', CAST(N'2021-09-05' AS Date), N'<p>內容待補內容待補</p>', CAST(N'2021-09-30' AS Date), 16, N'normal', CAST(N'2021-08-29T20:25:56.9860000' AS DateTime2), N'限制', 10, N'內容待補內容待補', NULL, NULL, CAST(N'2021-09-20' AS Date))
INSERT [dbo].[bulletin] ([type], [title], [postdate], [description], [exp], [postno], [poststatus], [createTime], [quotatype], [quota], [desText], [file1], [picture], [endDate]) VALUES (N'公告', N'中秋禮金發送', CAST(N'2021-09-16' AS Date), N'<p>內容待補內容待補</p>', CAST(N'2021-09-30' AS Date), 17, N'normal', CAST(N'2021-08-29T20:26:42.6570000' AS DateTime2), N'', NULL, N'內容待補內容待補', NULL, NULL, NULL)
INSERT [dbo].[bulletin] ([type], [title], [postdate], [description], [exp], [postno], [poststatus], [createTime], [quotatype], [quota], [desText], [file1], [picture], [endDate]) VALUES (N'活動', N'10月份生日會', CAST(N'2021-09-25' AS Date), N'<p>內容待補內容待補</p>', CAST(N'2021-10-31' AS Date), 18, N'normal', CAST(N'2021-08-29T20:27:47.6080000' AS DateTime2), N'限制', 20, N'內容待補內容待補', NULL, NULL, CAST(N'2021-09-30' AS Date))
SET IDENTITY_INSERT [dbo].[bulletin] OFF
GO
SET IDENTITY_INSERT [dbo].[bulLike] ON 

INSERT [dbo].[bulLike] ([id], [empNo], [likeStatus], [postno]) VALUES (1, N'rd1', N'喜歡', 9)
INSERT [dbo].[bulLike] ([id], [empNo], [likeStatus], [postno]) VALUES (2, N'rd1', N'喜歡', 8)
INSERT [dbo].[bulLike] ([id], [empNo], [likeStatus], [postno]) VALUES (3, N'salesmanager', N'喜歡', 11)
INSERT [dbo].[bulLike] ([id], [empNo], [likeStatus], [postno]) VALUES (4, N'salesmanager', N'喜歡', 6)
INSERT [dbo].[bulLike] ([id], [empNo], [likeStatus], [postno]) VALUES (5, N'rd3', N'喜歡', 9)
INSERT [dbo].[bulLike] ([id], [empNo], [likeStatus], [postno]) VALUES (6, N'hr1', N'喜歡', 7)
INSERT [dbo].[bulLike] ([id], [empNo], [likeStatus], [postno]) VALUES (7, N'sales1', N'喜歡', 11)
SET IDENTITY_INSERT [dbo].[bulLike] OFF
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[checksystem](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[EmpNO] [nvarchar](50) NOT NULL,
	[DepName] [nvarchar](50) NULL,
	[CheckInTime] [datetime2](0) NULL,
	[CheckOutTime] [datetime2](0) NULL,
	[IsLateCheckIn] [nvarchar](1) NULL,
	[IsOnTimeCheckOut] [nvarchar](1) NULL,
	[WorkingHours] [decimal](18, 1) NULL,
	[UpdateTime] [datetime2](0) NOT NULL,
	[CreateTime] [datetime2](0) NOT NULL,
 CONSTRAINT [PK_checksystem] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[checksystem] ON 

INSERT [dbo].[checksystem] ([ID], [EmpNO], [DepName], [CheckInTime], [CheckOutTime], [IsLateCheckIn], [IsOnTimeCheckOut], [WorkingHours], [UpdateTime], [CreateTime]) VALUES (189, N'rd1', N'RD', CAST(N'2021-07-15T09:00:00.0000000' AS DateTime2), CAST(N'2021-07-15T18:00:00.0000000' AS DateTime2), N'Y', N'Y', CAST(0.0 AS Decimal(18, 1)), CAST(N'2021-07-15T09:00:00.0000000' AS DateTime2), CAST(N'2021-07-15T09:00:00.0000000' AS DateTime2))
INSERT [dbo].[checksystem] ([ID], [EmpNO], [DepName], [CheckInTime], [CheckOutTime], [IsLateCheckIn], [IsOnTimeCheckOut], [WorkingHours], [UpdateTime], [CreateTime]) VALUES (190, N'rd1', N'RD', CAST(N'2021-07-16T09:00:00.0000000' AS DateTime2), CAST(N'2021-07-16T18:00:00.0000000' AS DateTime2), N'Y', N'Y', CAST(9.0 AS Decimal(18, 1)), CAST(N'2021-07-16T09:00:00.0000000' AS DateTime2), CAST(N'2021-07-16T09:00:00.0000000' AS DateTime2))
INSERT [dbo].[checksystem] ([ID], [EmpNO], [DepName], [CheckInTime], [CheckOutTime], [IsLateCheckIn], [IsOnTimeCheckOut], [WorkingHours], [UpdateTime], [CreateTime]) VALUES (191, N'rd1', N'RD', CAST(N'2021-07-19T09:00:00.0000000' AS DateTime2), CAST(N'2021-07-19T18:00:00.0000000' AS DateTime2), N'Y', N'Y', CAST(9.0 AS Decimal(18, 1)), CAST(N'2021-07-19T09:00:00.0000000' AS DateTime2), CAST(N'2021-07-19T09:00:00.0000000' AS DateTime2))
INSERT [dbo].[checksystem] ([ID], [EmpNO], [DepName], [CheckInTime], [CheckOutTime], [IsLateCheckIn], [IsOnTimeCheckOut], [WorkingHours], [UpdateTime], [CreateTime]) VALUES (192, N'rd1', N'RD', CAST(N'2021-07-20T09:00:00.0000000' AS DateTime2), CAST(N'2021-07-20T18:00:00.0000000' AS DateTime2), N'Y', N'Y', CAST(9.0 AS Decimal(18, 1)), CAST(N'2021-07-20T09:00:00.0000000' AS DateTime2), CAST(N'2021-07-20T09:00:00.0000000' AS DateTime2))
INSERT [dbo].[checksystem] ([ID], [EmpNO], [DepName], [CheckInTime], [CheckOutTime], [IsLateCheckIn], [IsOnTimeCheckOut], [WorkingHours], [UpdateTime], [CreateTime]) VALUES (193, N'rd1', N'RD', CAST(N'2021-07-21T09:00:00.0000000' AS DateTime2), CAST(N'2021-07-21T18:00:00.0000000' AS DateTime2), N'Y', N'Y', CAST(9.0 AS Decimal(18, 1)), CAST(N'2021-07-21T09:00:00.0000000' AS DateTime2), CAST(N'2021-07-21T09:00:00.0000000' AS DateTime2))
INSERT [dbo].[checksystem] ([ID], [EmpNO], [DepName], [CheckInTime], [CheckOutTime], [IsLateCheckIn], [IsOnTimeCheckOut], [WorkingHours], [UpdateTime], [CreateTime]) VALUES (194, N'rd1', N'RD', CAST(N'2021-07-22T09:00:00.0000000' AS DateTime2), CAST(N'2021-07-22T18:00:00.0000000' AS DateTime2), N'Y', N'Y', CAST(9.0 AS Decimal(18, 1)), CAST(N'2021-07-22T09:00:00.0000000' AS DateTime2), CAST(N'2021-07-22T09:00:00.0000000' AS DateTime2))
INSERT [dbo].[checksystem] ([ID], [EmpNO], [DepName], [CheckInTime], [CheckOutTime], [IsLateCheckIn], [IsOnTimeCheckOut], [WorkingHours], [UpdateTime], [CreateTime]) VALUES (195, N'rd1', N'RD', CAST(N'2021-07-23T09:00:00.0000000' AS DateTime2), CAST(N'2021-07-23T18:00:00.0000000' AS DateTime2), N'Y', N'Y', CAST(9.0 AS Decimal(18, 1)), CAST(N'2021-07-23T09:00:00.0000000' AS DateTime2), CAST(N'2021-07-23T09:00:00.0000000' AS DateTime2))
INSERT [dbo].[checksystem] ([ID], [EmpNO], [DepName], [CheckInTime], [CheckOutTime], [IsLateCheckIn], [IsOnTimeCheckOut], [WorkingHours], [UpdateTime], [CreateTime]) VALUES (196, N'rd1', N'RD', CAST(N'2021-07-26T09:00:00.0000000' AS DateTime2), CAST(N'2021-07-26T18:00:00.0000000' AS DateTime2), N'Y', N'Y', CAST(9.0 AS Decimal(18, 1)), CAST(N'2021-07-26T09:00:00.0000000' AS DateTime2), CAST(N'2021-07-26T09:00:00.0000000' AS DateTime2))
INSERT [dbo].[checksystem] ([ID], [EmpNO], [DepName], [CheckInTime], [CheckOutTime], [IsLateCheckIn], [IsOnTimeCheckOut], [WorkingHours], [UpdateTime], [CreateTime]) VALUES (197, N'rd1', N'RD', CAST(N'2021-07-27T09:00:00.0000000' AS DateTime2), CAST(N'2021-07-27T18:00:00.0000000' AS DateTime2), N'Y', N'Y', CAST(9.0 AS Decimal(18, 1)), CAST(N'2021-07-27T09:00:00.0000000' AS DateTime2), CAST(N'2021-07-27T09:00:00.0000000' AS DateTime2))
INSERT [dbo].[checksystem] ([ID], [EmpNO], [DepName], [CheckInTime], [CheckOutTime], [IsLateCheckIn], [IsOnTimeCheckOut], [WorkingHours], [UpdateTime], [CreateTime]) VALUES (198, N'rd1', N'RD', CAST(N'2021-07-28T09:00:00.0000000' AS DateTime2), CAST(N'2021-07-28T18:00:00.0000000' AS DateTime2), N'Y', N'Y', CAST(9.0 AS Decimal(18, 1)), CAST(N'2021-07-28T09:00:00.0000000' AS DateTime2), CAST(N'2021-07-28T09:00:00.0000000' AS DateTime2))
INSERT [dbo].[checksystem] ([ID], [EmpNO], [DepName], [CheckInTime], [CheckOutTime], [IsLateCheckIn], [IsOnTimeCheckOut], [WorkingHours], [UpdateTime], [CreateTime]) VALUES (199, N'rd1', N'RD', CAST(N'2021-07-29T09:00:00.0000000' AS DateTime2), CAST(N'2021-07-29T18:00:00.0000000' AS DateTime2), N'Y', N'Y', CAST(9.0 AS Decimal(18, 1)), CAST(N'2021-07-29T09:00:00.0000000' AS DateTime2), CAST(N'2021-07-29T09:00:00.0000000' AS DateTime2))
INSERT [dbo].[checksystem] ([ID], [EmpNO], [DepName], [CheckInTime], [CheckOutTime], [IsLateCheckIn], [IsOnTimeCheckOut], [WorkingHours], [UpdateTime], [CreateTime]) VALUES (200, N'rd1', N'RD', CAST(N'2021-07-30T09:00:00.0000000' AS DateTime2), CAST(N'2021-07-30T18:00:00.0000000' AS DateTime2), N'Y', N'Y', CAST(9.0 AS Decimal(18, 1)), CAST(N'2021-07-30T09:00:00.0000000' AS DateTime2), CAST(N'2021-07-30T09:00:00.0000000' AS DateTime2))
INSERT [dbo].[checksystem] ([ID], [EmpNO], [DepName], [CheckInTime], [CheckOutTime], [IsLateCheckIn], [IsOnTimeCheckOut], [WorkingHours], [UpdateTime], [CreateTime]) VALUES (201, N'rd1', N'RD', CAST(N'2021-08-02T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-02T18:00:00.0000000' AS DateTime2), N'Y', N'Y', CAST(9.0 AS Decimal(18, 1)), CAST(N'2021-08-02T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-02T09:00:00.0000000' AS DateTime2))
INSERT [dbo].[checksystem] ([ID], [EmpNO], [DepName], [CheckInTime], [CheckOutTime], [IsLateCheckIn], [IsOnTimeCheckOut], [WorkingHours], [UpdateTime], [CreateTime]) VALUES (202, N'rd1', N'RD', CAST(N'2021-08-03T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-03T18:00:00.0000000' AS DateTime2), N'Y', N'Y', CAST(9.0 AS Decimal(18, 1)), CAST(N'2021-08-03T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-03T09:00:00.0000000' AS DateTime2))
INSERT [dbo].[checksystem] ([ID], [EmpNO], [DepName], [CheckInTime], [CheckOutTime], [IsLateCheckIn], [IsOnTimeCheckOut], [WorkingHours], [UpdateTime], [CreateTime]) VALUES (203, N'rd1', N'RD', CAST(N'2021-08-04T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-04T18:00:00.0000000' AS DateTime2), N'Y', N'Y', CAST(9.0 AS Decimal(18, 1)), CAST(N'2021-08-04T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-04T09:00:00.0000000' AS DateTime2))
INSERT [dbo].[checksystem] ([ID], [EmpNO], [DepName], [CheckInTime], [CheckOutTime], [IsLateCheckIn], [IsOnTimeCheckOut], [WorkingHours], [UpdateTime], [CreateTime]) VALUES (204, N'rd1', N'RD', CAST(N'2021-08-05T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-05T18:00:00.0000000' AS DateTime2), N'Y', N'Y', CAST(9.0 AS Decimal(18, 1)), CAST(N'2021-08-05T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-05T09:00:00.0000000' AS DateTime2))
INSERT [dbo].[checksystem] ([ID], [EmpNO], [DepName], [CheckInTime], [CheckOutTime], [IsLateCheckIn], [IsOnTimeCheckOut], [WorkingHours], [UpdateTime], [CreateTime]) VALUES (205, N'rd1', N'RD', CAST(N'2021-08-06T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-06T18:00:00.0000000' AS DateTime2), N'Y', N'Y', CAST(9.0 AS Decimal(18, 1)), CAST(N'2021-08-06T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-06T09:00:00.0000000' AS DateTime2))
INSERT [dbo].[checksystem] ([ID], [EmpNO], [DepName], [CheckInTime], [CheckOutTime], [IsLateCheckIn], [IsOnTimeCheckOut], [WorkingHours], [UpdateTime], [CreateTime]) VALUES (206, N'rd1', N'RD', CAST(N'2021-08-09T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-09T18:00:00.0000000' AS DateTime2), N'Y', N'Y', CAST(9.0 AS Decimal(18, 1)), CAST(N'2021-08-09T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-09T09:00:00.0000000' AS DateTime2))
INSERT [dbo].[checksystem] ([ID], [EmpNO], [DepName], [CheckInTime], [CheckOutTime], [IsLateCheckIn], [IsOnTimeCheckOut], [WorkingHours], [UpdateTime], [CreateTime]) VALUES (207, N'rd1', N'RD', CAST(N'2021-08-10T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-10T18:00:00.0000000' AS DateTime2), N'Y', N'Y', CAST(9.0 AS Decimal(18, 1)), CAST(N'2021-08-10T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-10T09:00:00.0000000' AS DateTime2))
INSERT [dbo].[checksystem] ([ID], [EmpNO], [DepName], [CheckInTime], [CheckOutTime], [IsLateCheckIn], [IsOnTimeCheckOut], [WorkingHours], [UpdateTime], [CreateTime]) VALUES (208, N'rd1', N'RD', CAST(N'2021-08-11T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-11T18:00:00.0000000' AS DateTime2), N'Y', N'Y', CAST(9.0 AS Decimal(18, 1)), CAST(N'2021-08-11T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-11T09:00:00.0000000' AS DateTime2))
INSERT [dbo].[checksystem] ([ID], [EmpNO], [DepName], [CheckInTime], [CheckOutTime], [IsLateCheckIn], [IsOnTimeCheckOut], [WorkingHours], [UpdateTime], [CreateTime]) VALUES (209, N'rd1', N'RD', CAST(N'2021-08-12T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-12T18:00:00.0000000' AS DateTime2), N'Y', N'Y', CAST(9.0 AS Decimal(18, 1)), CAST(N'2021-08-12T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-12T09:00:00.0000000' AS DateTime2))
INSERT [dbo].[checksystem] ([ID], [EmpNO], [DepName], [CheckInTime], [CheckOutTime], [IsLateCheckIn], [IsOnTimeCheckOut], [WorkingHours], [UpdateTime], [CreateTime]) VALUES (210, N'rd1', N'RD', CAST(N'2021-08-13T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-13T18:00:00.0000000' AS DateTime2), N'Y', N'Y', CAST(9.0 AS Decimal(18, 1)), CAST(N'2021-08-13T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-13T09:00:00.0000000' AS DateTime2))
INSERT [dbo].[checksystem] ([ID], [EmpNO], [DepName], [CheckInTime], [CheckOutTime], [IsLateCheckIn], [IsOnTimeCheckOut], [WorkingHours], [UpdateTime], [CreateTime]) VALUES (211, N'rd1', N'RD', CAST(N'2021-08-16T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-16T18:00:00.0000000' AS DateTime2), N'Y', N'Y', CAST(9.0 AS Decimal(18, 1)), CAST(N'2021-08-16T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-16T09:00:00.0000000' AS DateTime2))
INSERT [dbo].[checksystem] ([ID], [EmpNO], [DepName], [CheckInTime], [CheckOutTime], [IsLateCheckIn], [IsOnTimeCheckOut], [WorkingHours], [UpdateTime], [CreateTime]) VALUES (212, N'rd1', N'RD', CAST(N'2021-08-17T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-17T18:00:00.0000000' AS DateTime2), N'Y', N'Y', CAST(9.0 AS Decimal(18, 1)), CAST(N'2021-08-17T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-17T09:00:00.0000000' AS DateTime2))
INSERT [dbo].[checksystem] ([ID], [EmpNO], [DepName], [CheckInTime], [CheckOutTime], [IsLateCheckIn], [IsOnTimeCheckOut], [WorkingHours], [UpdateTime], [CreateTime]) VALUES (213, N'rd1', N'RD', CAST(N'2021-08-18T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-18T18:00:00.0000000' AS DateTime2), N'Y', N'Y', CAST(9.0 AS Decimal(18, 1)), CAST(N'2021-08-18T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-18T09:00:00.0000000' AS DateTime2))
INSERT [dbo].[checksystem] ([ID], [EmpNO], [DepName], [CheckInTime], [CheckOutTime], [IsLateCheckIn], [IsOnTimeCheckOut], [WorkingHours], [UpdateTime], [CreateTime]) VALUES (214, N'rd1', N'RD', CAST(N'2021-08-19T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-19T18:00:00.0000000' AS DateTime2), N'Y', N'Y', CAST(9.0 AS Decimal(18, 1)), CAST(N'2021-08-19T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-19T09:00:00.0000000' AS DateTime2))
INSERT [dbo].[checksystem] ([ID], [EmpNO], [DepName], [CheckInTime], [CheckOutTime], [IsLateCheckIn], [IsOnTimeCheckOut], [WorkingHours], [UpdateTime], [CreateTime]) VALUES (215, N'rd1', N'RD', CAST(N'2021-08-20T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-20T18:00:00.0000000' AS DateTime2), N'Y', N'Y', CAST(9.0 AS Decimal(18, 1)), CAST(N'2021-08-20T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-20T09:00:00.0000000' AS DateTime2))
INSERT [dbo].[checksystem] ([ID], [EmpNO], [DepName], [CheckInTime], [CheckOutTime], [IsLateCheckIn], [IsOnTimeCheckOut], [WorkingHours], [UpdateTime], [CreateTime]) VALUES (216, N'rd1', N'RD', CAST(N'2021-08-23T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-23T18:00:00.0000000' AS DateTime2), N'Y', N'Y', CAST(9.0 AS Decimal(18, 1)), CAST(N'2021-08-23T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-23T09:00:00.0000000' AS DateTime2))
INSERT [dbo].[checksystem] ([ID], [EmpNO], [DepName], [CheckInTime], [CheckOutTime], [IsLateCheckIn], [IsOnTimeCheckOut], [WorkingHours], [UpdateTime], [CreateTime]) VALUES (217, N'rd1', N'RD', CAST(N'2021-08-24T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-24T18:00:00.0000000' AS DateTime2), N'Y', N'Y', CAST(9.0 AS Decimal(18, 1)), CAST(N'2021-08-24T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-24T09:00:00.0000000' AS DateTime2))
INSERT [dbo].[checksystem] ([ID], [EmpNO], [DepName], [CheckInTime], [CheckOutTime], [IsLateCheckIn], [IsOnTimeCheckOut], [WorkingHours], [UpdateTime], [CreateTime]) VALUES (218, N'rd1', N'RD', CAST(N'2021-08-25T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-25T18:00:00.0000000' AS DateTime2), N'Y', N'N', CAST(9.0 AS Decimal(18, 1)), CAST(N'2021-08-31T02:40:12.0000000' AS DateTime2), CAST(N'2021-08-25T09:00:00.0000000' AS DateTime2))
INSERT [dbo].[checksystem] ([ID], [EmpNO], [DepName], [CheckInTime], [CheckOutTime], [IsLateCheckIn], [IsOnTimeCheckOut], [WorkingHours], [UpdateTime], [CreateTime]) VALUES (219, N'rd1', N'RD', CAST(N'2021-08-26T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-26T18:00:00.0000000' AS DateTime2), N'Y', N'Y', CAST(9.0 AS Decimal(18, 1)), CAST(N'2021-08-26T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-26T09:00:00.0000000' AS DateTime2))
INSERT [dbo].[checksystem] ([ID], [EmpNO], [DepName], [CheckInTime], [CheckOutTime], [IsLateCheckIn], [IsOnTimeCheckOut], [WorkingHours], [UpdateTime], [CreateTime]) VALUES (220, N'rd1', N'RD', NULL, CAST(N'2021-08-27T18:00:00.0000000' AS DateTime2), N'Y', N'Y', CAST(9.0 AS Decimal(18, 1)), CAST(N'2021-08-27T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-27T09:00:00.0000000' AS DateTime2))
INSERT [dbo].[checksystem] ([ID], [EmpNO], [DepName], [CheckInTime], [CheckOutTime], [IsLateCheckIn], [IsOnTimeCheckOut], [WorkingHours], [UpdateTime], [CreateTime]) VALUES (221, N'rd1', N'RD', CAST(N'2021-08-30T09:00:00.0000000' AS DateTime2), NULL, N'Y', N'N', CAST(4.0 AS Decimal(18, 1)), CAST(N'2021-08-30T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-30T09:00:00.0000000' AS DateTime2))
INSERT [dbo].[checksystem] ([ID], [EmpNO], [DepName], [CheckInTime], [CheckOutTime], [IsLateCheckIn], [IsOnTimeCheckOut], [WorkingHours], [UpdateTime], [CreateTime]) VALUES (222, N'hr1', N'HR', CAST(N'2021-07-15T09:00:00.0000000' AS DateTime2), CAST(N'2021-07-15T18:00:00.0000000' AS DateTime2), N'Y', N'Y', CAST(9.0 AS Decimal(18, 1)), CAST(N'2021-07-15T09:00:00.0000000' AS DateTime2), CAST(N'2021-07-15T09:00:00.0000000' AS DateTime2))
INSERT [dbo].[checksystem] ([ID], [EmpNO], [DepName], [CheckInTime], [CheckOutTime], [IsLateCheckIn], [IsOnTimeCheckOut], [WorkingHours], [UpdateTime], [CreateTime]) VALUES (223, N'hr1', N'HR', CAST(N'2021-07-16T09:00:00.0000000' AS DateTime2), CAST(N'2021-07-16T18:00:00.0000000' AS DateTime2), N'Y', N'Y', CAST(9.0 AS Decimal(18, 1)), CAST(N'2021-07-16T09:00:00.0000000' AS DateTime2), CAST(N'2021-07-16T09:00:00.0000000' AS DateTime2))
INSERT [dbo].[checksystem] ([ID], [EmpNO], [DepName], [CheckInTime], [CheckOutTime], [IsLateCheckIn], [IsOnTimeCheckOut], [WorkingHours], [UpdateTime], [CreateTime]) VALUES (224, N'hr1', N'HR', CAST(N'2021-07-19T09:00:00.0000000' AS DateTime2), CAST(N'2021-07-19T18:00:00.0000000' AS DateTime2), N'Y', N'Y', CAST(9.0 AS Decimal(18, 1)), CAST(N'2021-07-19T09:00:00.0000000' AS DateTime2), CAST(N'2021-07-19T09:00:00.0000000' AS DateTime2))
INSERT [dbo].[checksystem] ([ID], [EmpNO], [DepName], [CheckInTime], [CheckOutTime], [IsLateCheckIn], [IsOnTimeCheckOut], [WorkingHours], [UpdateTime], [CreateTime]) VALUES (225, N'hr1', N'HR', CAST(N'2021-07-20T09:00:00.0000000' AS DateTime2), CAST(N'2021-07-20T18:00:00.0000000' AS DateTime2), N'Y', N'Y', CAST(9.0 AS Decimal(18, 1)), CAST(N'2021-07-20T09:00:00.0000000' AS DateTime2), CAST(N'2021-07-20T09:00:00.0000000' AS DateTime2))
INSERT [dbo].[checksystem] ([ID], [EmpNO], [DepName], [CheckInTime], [CheckOutTime], [IsLateCheckIn], [IsOnTimeCheckOut], [WorkingHours], [UpdateTime], [CreateTime]) VALUES (226, N'hr1', N'HR', CAST(N'2021-07-21T09:00:00.0000000' AS DateTime2), CAST(N'2021-07-21T18:00:00.0000000' AS DateTime2), N'Y', N'Y', CAST(9.0 AS Decimal(18, 1)), CAST(N'2021-07-21T09:00:00.0000000' AS DateTime2), CAST(N'2021-07-21T09:00:00.0000000' AS DateTime2))
INSERT [dbo].[checksystem] ([ID], [EmpNO], [DepName], [CheckInTime], [CheckOutTime], [IsLateCheckIn], [IsOnTimeCheckOut], [WorkingHours], [UpdateTime], [CreateTime]) VALUES (227, N'hr1', N'HR', CAST(N'2021-07-22T09:00:00.0000000' AS DateTime2), CAST(N'2021-07-22T18:00:00.0000000' AS DateTime2), N'Y', N'Y', CAST(9.0 AS Decimal(18, 1)), CAST(N'2021-07-22T09:00:00.0000000' AS DateTime2), CAST(N'2021-07-22T09:00:00.0000000' AS DateTime2))
INSERT [dbo].[checksystem] ([ID], [EmpNO], [DepName], [CheckInTime], [CheckOutTime], [IsLateCheckIn], [IsOnTimeCheckOut], [WorkingHours], [UpdateTime], [CreateTime]) VALUES (228, N'hr1', N'HR', CAST(N'2021-07-23T09:00:00.0000000' AS DateTime2), CAST(N'2021-07-23T18:00:00.0000000' AS DateTime2), N'Y', N'Y', CAST(9.0 AS Decimal(18, 1)), CAST(N'2021-07-23T09:00:00.0000000' AS DateTime2), CAST(N'2021-07-23T09:00:00.0000000' AS DateTime2))
INSERT [dbo].[checksystem] ([ID], [EmpNO], [DepName], [CheckInTime], [CheckOutTime], [IsLateCheckIn], [IsOnTimeCheckOut], [WorkingHours], [UpdateTime], [CreateTime]) VALUES (229, N'hr1', N'HR', CAST(N'2021-07-26T09:00:00.0000000' AS DateTime2), CAST(N'2021-07-26T18:00:00.0000000' AS DateTime2), N'Y', N'Y', CAST(9.0 AS Decimal(18, 1)), CAST(N'2021-07-26T09:00:00.0000000' AS DateTime2), CAST(N'2021-07-26T09:00:00.0000000' AS DateTime2))
INSERT [dbo].[checksystem] ([ID], [EmpNO], [DepName], [CheckInTime], [CheckOutTime], [IsLateCheckIn], [IsOnTimeCheckOut], [WorkingHours], [UpdateTime], [CreateTime]) VALUES (230, N'hr1', N'HR', CAST(N'2021-07-27T09:00:00.0000000' AS DateTime2), CAST(N'2021-07-27T18:00:00.0000000' AS DateTime2), N'Y', N'Y', CAST(9.0 AS Decimal(18, 1)), CAST(N'2021-07-27T09:00:00.0000000' AS DateTime2), CAST(N'2021-07-27T09:00:00.0000000' AS DateTime2))
INSERT [dbo].[checksystem] ([ID], [EmpNO], [DepName], [CheckInTime], [CheckOutTime], [IsLateCheckIn], [IsOnTimeCheckOut], [WorkingHours], [UpdateTime], [CreateTime]) VALUES (231, N'hr1', N'HR', CAST(N'2021-07-28T09:00:00.0000000' AS DateTime2), CAST(N'2021-07-28T18:00:00.0000000' AS DateTime2), N'Y', N'Y', CAST(9.0 AS Decimal(18, 1)), CAST(N'2021-07-28T09:00:00.0000000' AS DateTime2), CAST(N'2021-07-28T09:00:00.0000000' AS DateTime2))
INSERT [dbo].[checksystem] ([ID], [EmpNO], [DepName], [CheckInTime], [CheckOutTime], [IsLateCheckIn], [IsOnTimeCheckOut], [WorkingHours], [UpdateTime], [CreateTime]) VALUES (232, N'hr1', N'HR', CAST(N'2021-07-29T09:00:00.0000000' AS DateTime2), CAST(N'2021-07-29T18:00:00.0000000' AS DateTime2), N'Y', N'Y', CAST(9.0 AS Decimal(18, 1)), CAST(N'2021-07-29T09:00:00.0000000' AS DateTime2), CAST(N'2021-07-29T09:00:00.0000000' AS DateTime2))
INSERT [dbo].[checksystem] ([ID], [EmpNO], [DepName], [CheckInTime], [CheckOutTime], [IsLateCheckIn], [IsOnTimeCheckOut], [WorkingHours], [UpdateTime], [CreateTime]) VALUES (233, N'hr1', N'HR', CAST(N'2021-07-30T09:00:00.0000000' AS DateTime2), CAST(N'2021-07-30T18:00:00.0000000' AS DateTime2), N'Y', N'Y', CAST(9.0 AS Decimal(18, 1)), CAST(N'2021-07-30T09:00:00.0000000' AS DateTime2), CAST(N'2021-07-30T09:00:00.0000000' AS DateTime2))
INSERT [dbo].[checksystem] ([ID], [EmpNO], [DepName], [CheckInTime], [CheckOutTime], [IsLateCheckIn], [IsOnTimeCheckOut], [WorkingHours], [UpdateTime], [CreateTime]) VALUES (234, N'hr1', N'HR', CAST(N'2021-08-02T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-02T18:00:00.0000000' AS DateTime2), N'Y', N'Y', CAST(9.0 AS Decimal(18, 1)), CAST(N'2021-08-02T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-02T09:00:00.0000000' AS DateTime2))
INSERT [dbo].[checksystem] ([ID], [EmpNO], [DepName], [CheckInTime], [CheckOutTime], [IsLateCheckIn], [IsOnTimeCheckOut], [WorkingHours], [UpdateTime], [CreateTime]) VALUES (235, N'hr1', N'HR', CAST(N'2021-08-03T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-03T18:00:00.0000000' AS DateTime2), N'Y', N'Y', CAST(9.0 AS Decimal(18, 1)), CAST(N'2021-08-03T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-03T09:00:00.0000000' AS DateTime2))
INSERT [dbo].[checksystem] ([ID], [EmpNO], [DepName], [CheckInTime], [CheckOutTime], [IsLateCheckIn], [IsOnTimeCheckOut], [WorkingHours], [UpdateTime], [CreateTime]) VALUES (236, N'hr1', N'HR', CAST(N'2021-08-04T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-04T18:00:00.0000000' AS DateTime2), N'Y', N'Y', CAST(9.0 AS Decimal(18, 1)), CAST(N'2021-08-04T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-04T09:00:00.0000000' AS DateTime2))
INSERT [dbo].[checksystem] ([ID], [EmpNO], [DepName], [CheckInTime], [CheckOutTime], [IsLateCheckIn], [IsOnTimeCheckOut], [WorkingHours], [UpdateTime], [CreateTime]) VALUES (237, N'hr1', N'HR', CAST(N'2021-08-05T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-05T18:00:00.0000000' AS DateTime2), N'Y', N'Y', CAST(9.0 AS Decimal(18, 1)), CAST(N'2021-08-05T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-05T09:00:00.0000000' AS DateTime2))
INSERT [dbo].[checksystem] ([ID], [EmpNO], [DepName], [CheckInTime], [CheckOutTime], [IsLateCheckIn], [IsOnTimeCheckOut], [WorkingHours], [UpdateTime], [CreateTime]) VALUES (238, N'hr1', N'HR', CAST(N'2021-08-06T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-06T18:00:00.0000000' AS DateTime2), N'Y', N'Y', CAST(9.0 AS Decimal(18, 1)), CAST(N'2021-08-06T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-06T09:00:00.0000000' AS DateTime2))
INSERT [dbo].[checksystem] ([ID], [EmpNO], [DepName], [CheckInTime], [CheckOutTime], [IsLateCheckIn], [IsOnTimeCheckOut], [WorkingHours], [UpdateTime], [CreateTime]) VALUES (239, N'hr1', N'HR', CAST(N'2021-08-09T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-09T18:00:00.0000000' AS DateTime2), N'Y', N'Y', CAST(9.0 AS Decimal(18, 1)), CAST(N'2021-08-09T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-09T09:00:00.0000000' AS DateTime2))
INSERT [dbo].[checksystem] ([ID], [EmpNO], [DepName], [CheckInTime], [CheckOutTime], [IsLateCheckIn], [IsOnTimeCheckOut], [WorkingHours], [UpdateTime], [CreateTime]) VALUES (240, N'hr1', N'HR', CAST(N'2021-08-10T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-10T18:00:00.0000000' AS DateTime2), N'Y', N'Y', CAST(9.0 AS Decimal(18, 1)), CAST(N'2021-08-10T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-10T09:00:00.0000000' AS DateTime2))
INSERT [dbo].[checksystem] ([ID], [EmpNO], [DepName], [CheckInTime], [CheckOutTime], [IsLateCheckIn], [IsOnTimeCheckOut], [WorkingHours], [UpdateTime], [CreateTime]) VALUES (241, N'hr1', N'HR', CAST(N'2021-08-11T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-11T18:00:00.0000000' AS DateTime2), N'Y', N'Y', CAST(9.0 AS Decimal(18, 1)), CAST(N'2021-08-11T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-11T09:00:00.0000000' AS DateTime2))
INSERT [dbo].[checksystem] ([ID], [EmpNO], [DepName], [CheckInTime], [CheckOutTime], [IsLateCheckIn], [IsOnTimeCheckOut], [WorkingHours], [UpdateTime], [CreateTime]) VALUES (242, N'hr1', N'HR', CAST(N'2021-08-12T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-12T18:00:00.0000000' AS DateTime2), N'Y', N'Y', CAST(9.0 AS Decimal(18, 1)), CAST(N'2021-08-12T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-12T09:00:00.0000000' AS DateTime2))
INSERT [dbo].[checksystem] ([ID], [EmpNO], [DepName], [CheckInTime], [CheckOutTime], [IsLateCheckIn], [IsOnTimeCheckOut], [WorkingHours], [UpdateTime], [CreateTime]) VALUES (243, N'hr1', N'HR', CAST(N'2021-08-13T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-13T18:00:00.0000000' AS DateTime2), N'Y', N'Y', CAST(9.0 AS Decimal(18, 1)), CAST(N'2021-08-13T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-13T09:00:00.0000000' AS DateTime2))
INSERT [dbo].[checksystem] ([ID], [EmpNO], [DepName], [CheckInTime], [CheckOutTime], [IsLateCheckIn], [IsOnTimeCheckOut], [WorkingHours], [UpdateTime], [CreateTime]) VALUES (244, N'hr1', N'HR', CAST(N'2021-08-16T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-16T18:00:00.0000000' AS DateTime2), N'Y', N'Y', CAST(9.0 AS Decimal(18, 1)), CAST(N'2021-08-16T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-16T09:00:00.0000000' AS DateTime2))
INSERT [dbo].[checksystem] ([ID], [EmpNO], [DepName], [CheckInTime], [CheckOutTime], [IsLateCheckIn], [IsOnTimeCheckOut], [WorkingHours], [UpdateTime], [CreateTime]) VALUES (245, N'hr1', N'HR', CAST(N'2021-08-17T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-17T18:00:00.0000000' AS DateTime2), N'Y', N'Y', CAST(9.0 AS Decimal(18, 1)), CAST(N'2021-08-17T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-17T09:00:00.0000000' AS DateTime2))
INSERT [dbo].[checksystem] ([ID], [EmpNO], [DepName], [CheckInTime], [CheckOutTime], [IsLateCheckIn], [IsOnTimeCheckOut], [WorkingHours], [UpdateTime], [CreateTime]) VALUES (246, N'hr1', N'HR', CAST(N'2021-08-18T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-18T18:00:00.0000000' AS DateTime2), N'Y', N'Y', CAST(9.0 AS Decimal(18, 1)), CAST(N'2021-08-18T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-18T09:00:00.0000000' AS DateTime2))
INSERT [dbo].[checksystem] ([ID], [EmpNO], [DepName], [CheckInTime], [CheckOutTime], [IsLateCheckIn], [IsOnTimeCheckOut], [WorkingHours], [UpdateTime], [CreateTime]) VALUES (247, N'hr1', N'HR', CAST(N'2021-08-19T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-19T18:00:00.0000000' AS DateTime2), N'Y', N'Y', CAST(9.0 AS Decimal(18, 1)), CAST(N'2021-08-19T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-19T09:00:00.0000000' AS DateTime2))
INSERT [dbo].[checksystem] ([ID], [EmpNO], [DepName], [CheckInTime], [CheckOutTime], [IsLateCheckIn], [IsOnTimeCheckOut], [WorkingHours], [UpdateTime], [CreateTime]) VALUES (248, N'hr1', N'HR', CAST(N'2021-08-20T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-20T18:00:00.0000000' AS DateTime2), N'Y', N'Y', CAST(9.0 AS Decimal(18, 1)), CAST(N'2021-08-20T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-20T09:00:00.0000000' AS DateTime2))
INSERT [dbo].[checksystem] ([ID], [EmpNO], [DepName], [CheckInTime], [CheckOutTime], [IsLateCheckIn], [IsOnTimeCheckOut], [WorkingHours], [UpdateTime], [CreateTime]) VALUES (249, N'hr1', N'HR', CAST(N'2021-08-23T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-23T18:00:00.0000000' AS DateTime2), N'Y', N'Y', CAST(9.0 AS Decimal(18, 1)), CAST(N'2021-08-23T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-23T09:00:00.0000000' AS DateTime2))
INSERT [dbo].[checksystem] ([ID], [EmpNO], [DepName], [CheckInTime], [CheckOutTime], [IsLateCheckIn], [IsOnTimeCheckOut], [WorkingHours], [UpdateTime], [CreateTime]) VALUES (250, N'hr1', N'HR', CAST(N'2021-08-24T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-24T18:00:00.0000000' AS DateTime2), N'Y', N'Y', CAST(9.0 AS Decimal(18, 1)), CAST(N'2021-08-24T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-24T09:00:00.0000000' AS DateTime2))
INSERT [dbo].[checksystem] ([ID], [EmpNO], [DepName], [CheckInTime], [CheckOutTime], [IsLateCheckIn], [IsOnTimeCheckOut], [WorkingHours], [UpdateTime], [CreateTime]) VALUES (251, N'hr1', N'HR', CAST(N'2021-08-25T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-25T18:00:00.0000000' AS DateTime2), N'Y', N'Y', CAST(9.0 AS Decimal(18, 1)), CAST(N'2021-08-25T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-25T09:00:00.0000000' AS DateTime2))
INSERT [dbo].[checksystem] ([ID], [EmpNO], [DepName], [CheckInTime], [CheckOutTime], [IsLateCheckIn], [IsOnTimeCheckOut], [WorkingHours], [UpdateTime], [CreateTime]) VALUES (252, N'hr1', N'HR', CAST(N'2021-08-26T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-26T18:00:00.0000000' AS DateTime2), N'Y', N'Y', CAST(9.0 AS Decimal(18, 1)), CAST(N'2021-08-26T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-26T09:00:00.0000000' AS DateTime2))
INSERT [dbo].[checksystem] ([ID], [EmpNO], [DepName], [CheckInTime], [CheckOutTime], [IsLateCheckIn], [IsOnTimeCheckOut], [WorkingHours], [UpdateTime], [CreateTime]) VALUES (253, N'hr1', N'HR', CAST(N'2021-08-27T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-27T18:00:00.0000000' AS DateTime2), N'Y', N'Y', CAST(9.0 AS Decimal(18, 1)), CAST(N'2021-08-27T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-27T09:00:00.0000000' AS DateTime2))
INSERT [dbo].[checksystem] ([ID], [EmpNO], [DepName], [CheckInTime], [CheckOutTime], [IsLateCheckIn], [IsOnTimeCheckOut], [WorkingHours], [UpdateTime], [CreateTime]) VALUES (254, N'hr1', N'HR', CAST(N'2021-08-30T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-30T18:00:00.0000000' AS DateTime2), N'Y', N'N', CAST(4.0 AS Decimal(18, 1)), CAST(N'2021-08-30T09:00:00.0000000' AS DateTime2), CAST(N'2021-08-30T09:00:00.0000000' AS DateTime2))
SET IDENTITY_INSERT [dbo].[checksystem] OFF
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ComplementSignAuditted](
	[empname] [nvarchar](50) NOT NULL,
	[empno] [nvarchar](50) NOT NULL,
	[date] [date] NOT NULL,
	[type] [nvarchar](10) NOT NULL,
	[managerNo] [int] NOT NULL,
	[applied_date] [datetime] NOT NULL,
	[Serial_Number] [int] IDENTITY(1,1) NOT NULL,
	[Status] [nvarchar](10) NOT NULL,
	[reason] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_ComplementSignAuditted] PRIMARY KEY CLUSTERED 
(
	[Serial_Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ComplementSignPendingApproval]    Script Date: 2021/8/31 上午 02:59:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ComplementSignPendingApproval](
	[empname] [nvarchar](50) NOT NULL,
	[empno] [nvarchar](50) NOT NULL,
	[date] [date] NOT NULL,
	[type] [nvarchar](10) NOT NULL,
	[managerNo] [int] NOT NULL,
	[applied_date] [datetime] NOT NULL,
	[Serial_Number] [int] IDENTITY(1,1) NOT NULL,
	[Status] [nvarchar](10) NOT NULL,
	[reason] [nvarchar](50) NOT NULL
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[ComplementSignAuditted] ON 

INSERT [dbo].[ComplementSignAuditted] ([empname], [empno], [date], [type], [managerNo], [applied_date], [Serial_Number], [Status], [reason]) VALUES (N'蜘蛛人', N'rd1', CAST(N'2021-08-31' AS Date), N'CheckOut', 3, CAST(N'2021-08-25T18:00:00.000' AS DateTime), 24, N'Pass', N'忘記打卡')
SET IDENTITY_INSERT [dbo].[ComplementSignAuditted] OFF
GO
SET IDENTITY_INSERT [dbo].[ComplementSignPendingApproval] ON 

INSERT [dbo].[ComplementSignPendingApproval] ([empname], [empno], [date], [type], [managerNo], [applied_date], [Serial_Number], [Status], [reason]) VALUES (N'蜘蛛人', N'rd1', CAST(N'2021-08-31' AS Date), N'CheckIn', 3, CAST(N'2021-08-27T09:00:00.000' AS DateTime), 43, N'pending', N'忘記打卡')
INSERT [dbo].[ComplementSignPendingApproval] ([empname], [empno], [date], [type], [managerNo], [applied_date], [Serial_Number], [Status], [reason]) VALUES (N'蜘蛛人', N'rd1', CAST(N'2021-08-31' AS Date), N'CheckOut', 3, CAST(N'2021-08-30T18:00:00.000' AS DateTime), 44, N'pending', N'忘記打卡')
SET IDENTITY_INSERT [dbo].[ComplementSignPendingApproval] OFF
GO