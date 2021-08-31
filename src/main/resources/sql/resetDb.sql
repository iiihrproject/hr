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
	[Approval01Name] [nvarchar](50) NULL,
	[Approval01Signature] [image] NULL,
	[Approval01Date] [smalldatetime] NULL,
 CONSTRAINT [PK__LeaveOfA__4AD829323DD693E6] PRIMARY KEY CLUSTERED 
(
	[APPLICATIONNO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
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