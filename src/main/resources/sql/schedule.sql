USE [HRDB]
GO
drop table if exists dimEmpAvailability;
drop table if exists dimShift;
drop table if exists factSchedule;
drop table if exists IsHoliday;
drop table if exists LeaveOfAbsense;
drop table if exists ListSetting;
/****** Object:  Table [dbo].[dimEmpAvailability]    Script Date: 2021/9/3 下午 05:26:56 ******/
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
	[CreatedTime] [datetime2](7) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dimShift]    Script Date: 2021/9/3 下午 05:26:56 ******/
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
	[Position] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[factSchedule]    Script Date: 2021/9/3 下午 05:26:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[factSchedule](
	[KeySchedule] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL primary Key,
	[empID] [nvarchar](50) NULL,
	[HoursOfWork] [float] NULL,
	[Start] [varchar](50) NULL,
	[EndOfShift] [varchar](50) NULL,
	[Title] [nvarchar](50) NULL,
	[KeyAvailability] [int] NULL,
	[IsHoliday] [int] NULL,
	[Date] [datetime2](7) NULL,
	[ShiftId] [varchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[IsHoliday]    Script Date: 2021/9/3 下午 05:26:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IsHoliday](
	[KeyDate] [int] IDENTITY(1,1) NOT NULL,
	[FullDate] [datetime2](7) NULL,
	[IsHoliday] [bit] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LeaveOfAbsense]    Script Date: 2021/9/3 下午 05:26:56 ******/
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
	[fileName] [nvarchar](100) NULL,
	[STATUS] [varchar](255) NULL,
	[Approval01MGR] [nvarchar](50) NULL,
	[Approval01Date] [smalldatetime] NULL,
	[Approval01Sig] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ListSetting]    Script Date: 2021/9/3 下午 05:26:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ListSetting](
	[code] [nvarchar](50) NOT NULL,
	[category] [nchar](50) NOT NULL,
	[desc_zh] [nvarchar](50) NOT NULL,
	[desc_en] [nchar](50) NULL
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[dimShift] ON 

INSERT [dbo].[dimShift] ([KeyShift], [DimShift], [StartTime], [EndTime], [Hours], [Position]) VALUES (1, N'日班', CAST(N'09:00:00' AS Time), CAST(N'18:00:00' AS Time), 8, N'客服')
INSERT [dbo].[dimShift] ([KeyShift], [DimShift], [StartTime], [EndTime], [Hours], [Position]) VALUES (2, N'午班', CAST(N'11:00:00' AS Time), CAST(N'20:00:00' AS Time), 8, N'裝貨')
INSERT [dbo].[dimShift] ([KeyShift], [DimShift], [StartTime], [EndTime], [Hours], [Position]) VALUES (3, N'晚班', CAST(N'14:00:00' AS Time), CAST(N'23:00:00' AS Time), 8, N'結算')
SET IDENTITY_INSERT [dbo].[dimShift] OFF
GO
SET IDENTITY_INSERT [dbo].[factSchedule] off

INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'1', NULL, N'2021-08-21T09:00:00', N'2021-08-21T18:00:00', N'指揮中心坐鎮', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'2', NULL, N'2021-08-22T09:00:00', N'2021-08-22T18:00:00', N'日常訓練', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'1', NULL, N'2021-08-23T09:00:00', N'2021-08-23T18:00:00', N'指揮中心坐鎮', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'2', NULL, N'2021-08-23T09:00:00', N'2021-08-23T18:00:00', N'上班', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'2', NULL, N'2021-08-24T09:00:00', N'2021-08-24T18:00:00', N'遠距上班', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'2', NULL, N'2021-08-25T09:00:00', N'2021-08-25T18:00:00', N'遠距上班', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'2', NULL, N'2021-08-26T09:00:00', N'2021-08-26T18:00:00', N'遠距上班', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'2', NULL, N'2021-08-27T09:00:00', N'2021-08-27T18:00:00', N'遠距上班', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'2', NULL, N'2021-08-30T09:00:00', N'2021-08-30T18:00:00', N'遠距上班', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'2', NULL, N'2021-08-31T09:00:00', N'2021-08-31T18:00:00', N'遠距上班', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'2', NULL, N'2021-09-01T09:00:00', N'2021-09-01T18:00:00', N'遠距上班', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'2', NULL, N'2021-09-02T09:00:00', N'2021-09-02T18:00:00', N'遠距上班', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'2', NULL, N'2021-09-03T09:00:00', N'2021-09-03T18:00:00', N'遠距上班', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'2', NULL, N'2021-09-06T09:00:00', N'2021-09-06T18:00:00', N'遠距上班', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'2', NULL, N'2021-09-07T09:00:00', N'2021-09-07T18:00:00', N'遠距上班', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'2', NULL, N'2021-09-08T09:00:00', N'2021-09-08T18:00:00', N'遠距上班', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'2', NULL, N'2021-09-09T09:00:00', N'2021-09-09T18:00:00', N'遠距上班', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'2', NULL, N'2021-09-10T09:00:00', N'2021-09-10T18:00:00', N'遠距上班', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'2', NULL, N'2021-09-13T09:00:00', N'2021-09-13T18:00:00', N'遠距上班', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'2', NULL, N'2021-09-14T09:00:00', N'2021-09-14T18:00:00', N'遠距上班', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'2', NULL, N'2021-09-15T09:00:00', N'2021-09-15T18:00:00', N'遠距上班', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'2', NULL, N'2021-09-16T09:00:00', N'2021-09-16T18:00:00', N'遠距上班', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'2', NULL, N'2021-09-17T09:00:00', N'2021-09-17T18:00:00', N'遠距上班', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'2', NULL, N'2021-09-20T09:00:00', N'2021-09-20T18:00:00', N'遠距上班', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'2', NULL, N'2021-09-21T09:00:00', N'2021-09-21T18:00:00', N'遠距上班', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'2', NULL, N'2021-09-22T09:00:00', N'2021-09-22T18:00:00', N'遠距上班', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'2', NULL, N'2021-09-23T09:00:00', N'2021-09-23T18:00:00', N'遠距上班', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'2', NULL, N'2021-09-24T09:00:00', N'2021-09-24T18:00:00', N'遠距上班', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'2', NULL, N'2021-09-27T09:00:00', N'2021-09-27T18:00:00', N'遠距上班', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'2', NULL, N'2021-09-28T09:00:00', N'2021-09-28T18:00:00', N'遠距上班', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'2', NULL, N'2021-09-29T09:00:00', N'2021-09-29T18:00:00', N'遠距上班', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'2', NULL, N'2021-09-30T09:00:00', N'2021-09-30T18:00:00', N'遠距上班', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'4', NULL, N'2021-08-23T09:00:00', N'2021-08-23T18:00:00', N'到公司上班', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'4', NULL, N'2021-08-24T09:00:00', N'2021-08-24T18:00:00', N'到公司上班', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'4', NULL, N'2021-08-25T09:00:00', N'2021-08-25T18:00:00', N'到公司上班', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'4', NULL, N'2021-08-26T09:00:00', N'2021-08-26T18:00:00', N'到公司上班', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'4', NULL, N'2021-08-27T09:00:00', N'2021-08-27T18:00:00', N'到公司上班', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'4', NULL, N'2021-08-30T09:00:00', N'2021-08-30T18:00:00', N'到公司上班', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'4', NULL, N'2021-08-31T09:00:00', N'2021-08-31T18:00:00', N'到公司上班', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'4', NULL, N'2021-09-01T09:00:00', N'2021-09-01T18:00:00', N'到公司上班', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'4', NULL, N'2021-09-02T09:00:00', N'2021-09-02T18:00:00', N'到公司上班', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'4', NULL, N'2021-09-03T09:00:00', N'2021-09-03T18:00:00', N'到公司上班', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'4', NULL, N'2021-09-06T09:00:00', N'2021-09-06T18:00:00', N'到公司上班', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'4', NULL, N'2021-09-07T09:00:00', N'2021-09-07T18:00:00', N'到公司上班', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'4', NULL, N'2021-09-08T09:00:00', N'2021-09-08T18:00:00', N'到公司上班', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'4', NULL, N'2021-09-09T09:00:00', N'2021-09-09T18:00:00', N'到公司上班', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'4', NULL, N'2021-09-10T09:00:00', N'2021-09-10T18:00:00', N'到公司上班', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'4', NULL, N'2021-09-13T09:00:00', N'2021-09-13T18:00:00', N'到公司上班', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'4', NULL, N'2021-09-14T09:00:00', N'2021-09-14T18:00:00', N'到公司上班', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'4', NULL, N'2021-09-15T09:00:00', N'2021-09-15T18:00:00', N'到公司上班', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'4', NULL, N'2021-09-16T09:00:00', N'2021-09-16T18:00:00', N'到公司上班', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'4', NULL, N'2021-09-20T09:00:00', N'2021-09-20T18:00:00', N'到公司上班', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'4', NULL, N'2021-09-17T09:00:00', N'2021-09-17T18:00:00', N'到公司上班', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'4', NULL, N'2021-09-21T09:00:00', N'2021-09-21T18:00:00', N'到公司上班', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'4', NULL, N'2021-09-22T09:00:00', N'2021-09-22T18:00:00', N'到公司上班', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'4', NULL, N'2021-09-23T09:00:00', N'2021-09-23T18:00:00', N'到公司上班', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'4', NULL, N'2021-09-24T09:00:00', N'2021-09-24T18:00:00', N'到公司上班', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'4', NULL, N'2021-09-27T09:00:00', N'2021-09-27T18:00:00', N'到公司上班', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'4', NULL, N'2021-09-28T09:00:00', N'2021-09-28T18:00:00', N'到公司上班', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'4', NULL, N'2021-09-29T09:00:00', N'2021-09-29T18:00:00', N'到公司上班', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'4', NULL, N'2021-09-30T09:00:00', N'2021-09-30T18:00:00', N'到公司上班', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'1', NULL, N'2021-09-01T10:00:00', N'2021-09-01T19:00:00', N'坐鎮航空母艦', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'1', NULL, N'2021-09-02T10:00:00', N'2021-09-02T19:00:00', N'坐鎮航空母艦', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'1', NULL, N'2021-09-03T10:00:00', N'2021-09-03T19:00:00', N'坐鎮航空母艦', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'1', NULL, N'2021-09-06T10:00:00', N'2021-09-06T19:00:00', N'坐鎮航空母艦', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'1', NULL, N'2021-09-07T10:00:00', N'2021-09-07T19:00:00', N'坐鎮航空母艦', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'1', NULL, N'2021-09-08T10:00:00', N'2021-09-08T19:00:00', N'坐鎮航空母艦', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'1', NULL, N'2021-09-09T10:00:00', N'2021-09-09T19:00:00', N'坐鎮航空母艦', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'1', NULL, N'2021-09-10T10:00:00', N'2021-09-10T19:00:00', N'坐鎮航空母艦', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'1', NULL, N'2021-09-13T10:00:00', N'2021-09-13T19:00:00', N'坐鎮航空母艦', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'1', NULL, N'2021-09-14T10:00:00', N'2021-09-14T19:00:00', N'坐鎮航空母艦', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'1', NULL, N'2021-09-15T10:00:00', N'2021-09-15T19:00:00', N'坐鎮航空母艦', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'1', NULL, N'2021-09-16T10:00:00', N'2021-09-16T19:00:00', N'坐鎮航空母艦', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'1', NULL, N'2021-09-17T10:00:00', N'2021-09-17T19:00:00', N'坐鎮航空母艦', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'1', NULL, N'2021-09-20T10:00:00', N'2021-09-20T19:00:00', N'坐鎮航空母艦', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'1', NULL, N'2021-09-21T10:00:00', N'2021-09-21T19:00:00', N'坐鎮航空母艦', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'1', NULL, N'2021-09-22T10:00:00', N'2021-09-22T19:00:00', N'坐鎮航空母艦', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'1', NULL, N'2021-09-23T10:00:00', N'2021-09-23T19:00:00', N'坐鎮航空母艦', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'1', NULL, N'2021-09-24T10:00:00', N'2021-09-24T19:00:00', N'坐鎮航空母艦', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'1', NULL, N'2021-09-27T10:00:00', N'2021-09-27T19:00:00', N'坐鎮航空母艦', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'1', NULL, N'2021-09-28T10:00:00', N'2021-09-28T19:00:00', N'坐鎮航空母艦', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'1', NULL, N'2021-09-29T10:00:00', N'2021-09-29T19:00:00', N'坐鎮航空母艦', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'1', NULL, N'2021-09-30T10:00:00', N'2021-09-30T19:00:00', N'坐鎮航空母艦', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'1', NULL, N'2021-10-01T10:00:00', N'2021-10-01T19:00:00', N'坐鎮航空母艦', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'7', NULL, N'2021-09-01T09:00:00', N'2021-09-01T18:00:00', N'研究平行時間軸', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'7', NULL, N'2021-09-02T09:00:00', N'2021-09-02T18:00:00', N'研究平行時間軸', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'7', NULL, N'2021-09-03T09:00:00', N'2021-09-03T18:00:00', N'研究平行時間軸', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'7', NULL, N'2021-09-06T09:00:00', N'2021-09-06T18:00:00', N'研究平行時間軸', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'7', NULL, N'2021-09-07T09:00:00', N'2021-09-07T18:00:00', N'研究平行時間軸', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'7', NULL, N'2021-09-08T09:00:00', N'2021-09-08T18:00:00', N'研究平行時間軸', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'7', NULL, N'2021-09-09T09:00:00', N'2021-09-09T18:00:00', N'研究平行時間軸', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'7', NULL, N'2021-09-10T09:00:00', N'2021-09-10T18:00:00', N'研究平行時間軸', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'7', NULL, N'2021-09-13T09:00:00', N'2021-09-13T18:00:00', N'研究平行時間軸', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'7', NULL, N'2021-09-14T09:00:00', N'2021-09-14T18:00:00', N'研究平行時間軸', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'7', NULL, N'2021-09-15T09:00:00', N'2021-09-15T18:00:00', N'研究平行時間軸', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'7', NULL, N'2021-09-16T09:00:00', N'2021-09-16T18:00:00', N'研究平行時間軸', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'7', NULL, N'2021-09-17T09:00:00', N'2021-09-17T18:00:00', N'研究平行時間軸', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'7', NULL, N'2021-09-20T09:00:00', N'2021-09-20T18:00:00', N'研究平行時間軸', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'7', NULL, N'2021-09-21T09:00:00', N'2021-09-21T18:00:00', N'研究平行時間軸', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'7', NULL, N'2021-09-22T09:00:00', N'2021-09-22T18:00:00', N'研究平行時間軸', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'7', NULL, N'2021-09-23T09:00:00', N'2021-09-23T18:00:00', N'研究平行時間軸', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'7', NULL, N'2021-09-24T09:00:00', N'2021-09-24T18:00:00', N'研究平行時間軸', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'7', NULL, N'2021-09-27T09:00:00', N'2021-09-27T18:00:00', N'研究平行時間軸', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'7', NULL, N'2021-09-28T09:00:00', N'2021-09-28T18:00:00', N'研究平行時間軸', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'7', NULL, N'2021-09-29T09:00:00', N'2021-09-29T18:00:00', N'研究平行時間軸', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'7', NULL, N'2021-09-30T09:00:00', N'2021-09-30T18:00:00', N'研究平行時間軸', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'9', NULL, N'2021-09-01T11:30:00', N'2021-09-01T20:30:00', N'學習人類惡習', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'9', NULL, N'2021-09-02T11:30:00', N'2021-09-02T20:30:00', N'學習人類惡習', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'9', NULL, N'2021-09-03T11:30:00', N'2021-09-03T20:30:00', N'學習人類惡習', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'9', NULL, N'2021-09-06T11:30:00', N'2021-09-06T20:30:00', N'學習人類惡習', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'9', NULL, N'2021-09-07T11:30:00', N'2021-09-07T20:30:00', N'學習人類惡習', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'9', NULL, N'2021-09-08T11:30:00', N'2021-09-08T20:30:00', N'學習人類惡習', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'9', NULL, N'2021-09-09T11:30:00', N'2021-09-09T20:30:00', N'學習人類惡習', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'9', NULL, N'2021-09-10T11:30:00', N'2021-09-10T20:30:00', N'學習人類惡習', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'9', NULL, N'2021-09-13T11:30:00', N'2021-09-13T20:30:00', N'學習人類惡習', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'9', NULL, N'2021-09-14T11:30:00', N'2021-09-14T20:30:00', N'學習人類惡習', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'9', NULL, N'2021-09-15T11:30:00', N'2021-09-15T20:30:00', N'學習人類惡習', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'9', NULL, N'2021-09-16T11:30:00', N'2021-09-16T20:30:00', N'學習人類惡習', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'9', NULL, N'2021-09-17T11:30:00', N'2021-09-17T20:30:00', N'學習人類惡習', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'9', NULL, N'2021-09-20T11:30:00', N'2021-09-20T20:30:00', N'學習人類惡習', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'9', NULL, N'2021-09-21T11:30:00', N'2021-09-21T20:30:00', N'學習人類惡習', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'9', NULL, N'2021-09-22T11:30:00', N'2021-09-22T20:30:00', N'學習人類惡習', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'9', NULL, N'2021-09-23T11:30:00', N'2021-09-23T20:30:00', N'學習人類惡習', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'9', NULL, N'2021-09-24T11:30:00', N'2021-09-24T20:30:00', N'學習人類惡習', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'9', NULL, N'2021-09-27T11:30:00', N'2021-09-27T20:30:00', N'學習人類惡習', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'9', NULL, N'2021-09-28T11:30:00', N'2021-09-28T20:30:00', N'學習人類惡習', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'9', NULL, N'2021-09-29T11:30:00', N'2021-09-29T20:30:00', N'學習人類惡習', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'9', NULL, N'2021-09-30T11:30:00', N'2021-09-30T20:30:00', N'學習人類惡習', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'10', NULL, N'2021-09-01T06:00:00', N'2021-09-01T15:00:00', N'健身', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'10', NULL, N'2021-09-02T06:00:00', N'2021-09-02T15:00:00', N'健身', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'10', NULL, N'2021-09-03T06:00:00', N'2021-09-03T15:00:00', N'健身', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'10', NULL, N'2021-09-06T06:00:00', N'2021-09-06T15:00:00', N'健身', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'10', NULL, N'2021-09-07T06:00:00', N'2021-09-07T15:00:00', N'健身', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'10', NULL, N'2021-09-08T06:00:00', N'2021-09-08T15:00:00', N'健身', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'10', NULL, N'2021-09-09T06:00:00', N'2021-09-09T15:00:00', N'健身', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'10', NULL, N'2021-09-10T06:00:00', N'2021-09-10T15:00:00', N'健身', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'10', NULL, N'2021-09-13T06:00:00', N'2021-09-13T15:00:00', N'健身', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'10', NULL, N'2021-09-14T06:00:00', N'2021-09-14T15:00:00', N'健身', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'10', NULL, N'2021-09-15T06:00:00', N'2021-09-15T15:00:00', N'健身', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'10', NULL, N'2021-09-16T06:00:00', N'2021-09-16T15:00:00', N'健身', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'10', NULL, N'2021-09-17T06:00:00', N'2021-09-17T15:00:00', N'健身', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'10', NULL, N'2021-09-20T06:00:00', N'2021-09-20T15:00:00', N'健身', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'10', NULL, N'2021-09-21T06:00:00', N'2021-09-21T15:00:00', N'健身', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'10', NULL, N'2021-09-22T06:00:00', N'2021-09-22T15:00:00', N'健身', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'10', NULL, N'2021-09-23T06:00:00', N'2021-09-23T15:00:00', N'健身', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'10', NULL, N'2021-09-24T06:00:00', N'2021-09-24T15:00:00', N'健身', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'10', NULL, N'2021-09-27T06:00:00', N'2021-09-27T15:00:00', N'健身', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'10', NULL, N'2021-09-28T06:00:00', N'2021-09-28T15:00:00', N'健身', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'10', NULL, N'2021-09-29T06:00:00', N'2021-09-29T15:00:00', N'健身', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'10', NULL, N'2021-09-30T06:00:00', N'2021-09-30T15:00:00', N'健身', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'3', NULL, N'2021-09-07T08:00:00', N'2021-09-07T11:00:00', N'設法普及賈維斯', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'3', NULL, N'2021-09-08T08:00:00', N'2021-09-08T11:00:00', N'設法普及賈維斯', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'3', NULL, N'2021-09-09T08:00:00', N'2021-09-09T11:00:00', N'設法普及賈維斯', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'3', NULL, N'2021-09-10T08:00:00', N'2021-09-10T11:00:00', N'設法普及賈維斯', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'3', NULL, N'2021-09-13T08:00:00', N'2021-09-13T11:00:00', N'設法普及賈維斯', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'3', NULL, N'2021-09-15T08:00:00', N'2021-09-15T11:00:00', N'設法普及賈維斯', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'3', NULL, N'2021-09-16T08:00:00', N'2021-09-16T11:00:00', N'設法普及賈維斯', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'3', NULL, N'2021-09-20T08:00:00', N'2021-09-20T11:00:00', N'設法普及賈維斯', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'3', NULL, N'2021-09-22T08:00:00', N'2021-09-22T11:00:00', N'設法普及賈維斯', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'3', NULL, N'2021-09-23T08:00:00', N'2021-09-23T11:00:00', N'設法普及賈維斯', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'3', NULL, N'2021-09-24T08:00:00', N'2021-09-24T11:00:00', N'設法普及賈維斯', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'3', NULL, N'2021-09-27T08:00:00', N'2021-09-27T11:00:00', N'設法普及賈維斯', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'3', NULL, N'2021-09-28T08:00:00', N'2021-09-28T11:00:00', N'設法普及賈維斯', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'3', NULL, N'2021-09-29T08:00:00', N'2021-09-29T11:00:00', N'設法普及賈維斯', NULL, NULL, NULL, NULL);
INSERT [dbo].[factSchedule] ([empID], [HoursOfWork], [Start], [EndOfShift], [Title], [KeyAvailability], [IsHoliday], [Date], [ShiftId]) VALUES (N'3', NULL, N'2021-09-30T08:00:00', N'2021-09-30T11:00:00', N'設法普及賈維斯', NULL, NULL, NULL, NULL);

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
