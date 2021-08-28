USE [HRDB]
GO

drop table IF EXISTS [dbo].[dimEmpAvailability];
drop table IF EXISTS [dbo].[dimShift];
drop table IF EXISTS [dbo].[factSchedule];
drop table IF EXISTS [dbo].[IsHoliday];
drop table IF EXISTS [dbo].[LeaveOfAbsense];
drop table IF EXISTS [dbo].[ListSetting];
/****** Object:  Table [dbo].[dimEmpAvailability]    Script Date: 2021/8/28 上午 08:23:16 ******/
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
