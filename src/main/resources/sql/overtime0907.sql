USE [HRDB]
drop table IF EXISTS [dbo].[overtimeapplicationauditted];
drop table IF EXISTS [dbo].[overtimeapplicationpending];
GO
/****** Object:  Table [dbo].[overtimeapplicationauditted]    Script Date: 2021/9/7 下午 10:46:25 ******/
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
/****** Object:  Table [dbo].[overtimeapplicationpending]    Script Date: 2021/9/7 下午 10:46:25 ******/
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

INSERT [dbo].[overtimeapplicationauditted] ([ID], [Type], [DateOfApplication], [managerEmpId], [EmpNo], [EmpName], [department], [position], [OvertimeCategory], [OverTimeDate], [StartingTime], [EndingTime], [OverTimeHours], [reason], [Remarks], [result]) VALUES (100, N'submit', CAST(N'2021-07-25' AS Date), NULL, N'rd1', N'蜘蛛人', N'RD', N'RD', N'平日加班', CAST(N'2021-07-23' AS Date), N'18:00', N'20:00', N'2.0', N'研發新型蜘蛛絲發射器', N'完成度70%', N'Pass')
INSERT [dbo].[overtimeapplicationauditted] ([ID], [Type], [DateOfApplication], [managerEmpId], [EmpNo], [EmpName], [department], [position], [OvertimeCategory], [OverTimeDate], [StartingTime], [EndingTime], [OverTimeHours], [reason], [Remarks], [result]) VALUES (101, N'submit', CAST(N'2021-07-27' AS Date), NULL, N'rd1', N'蜘蛛人', N'RD', N'RD', N'平日加班', CAST(N'2021-07-26' AS Date), N'18:00', N'18:30', N'0.5', N'研發新型蜘蛛絲發射器', N'完成度80%', N'Pass')
INSERT [dbo].[overtimeapplicationauditted] ([ID], [Type], [DateOfApplication], [managerEmpId], [EmpNo], [EmpName], [department], [position], [OvertimeCategory], [OverTimeDate], [StartingTime], [EndingTime], [OverTimeHours], [reason], [Remarks], [result]) VALUES (102, N'submit', CAST(N'2021-08-05' AS Date), NULL, N'rd1', N'蜘蛛人', N'RD', N'RD', N'平日加班', CAST(N'2021-08-04' AS Date), N'18:00', N'19:30', N'1.5', N'研發二代型蜘蛛絲發射器', N'完成度50%', N'Pass')
INSERT [dbo].[overtimeapplicationauditted] ([ID], [Type], [DateOfApplication], [managerEmpId], [EmpNo], [EmpName], [department], [position], [OvertimeCategory], [OverTimeDate], [StartingTime], [EndingTime], [OverTimeHours], [reason], [Remarks], [result]) VALUES (103, N'submit', CAST(N'2021-08-10' AS Date), NULL, N'rd1', N'蜘蛛人', N'RD', N'RD', N'平日加班', CAST(N'2021-08-09' AS Date), N'18:00', N'19:00', N'1.0', N'研發二代型蜘蛛絲發射器', N'完成度70%', N'Pass')
INSERT [dbo].[overtimeapplicationauditted] ([ID], [Type], [DateOfApplication], [managerEmpId], [EmpNo], [EmpName], [department], [position], [OvertimeCategory], [OverTimeDate], [StartingTime], [EndingTime], [OverTimeHours], [reason], [Remarks], [result]) VALUES (105, N'submit', CAST(N'2021-09-05' AS Date), NULL, N'rd1', N'蜘蛛人', N'RD', N'RD', N'平日加班', CAST(N'2021-09-02' AS Date), N'18:00', N'20:00', N'2.0', N'研發新型蜘蛛絲發射器', N'完成度70%', N'Pass')
SET IDENTITY_INSERT [dbo].[overtimeapplicationauditted] OFF
GO
SET IDENTITY_INSERT [dbo].[overtimeapplicationpending] ON 

INSERT [dbo].[overtimeapplicationpending] ([ID], [Type], [DateOfApplication], [managerEmpId], [EmpNo], [EmpName], [department], [position], [OvertimeCategory], [OverTimeDate], [StartingTime], [EndingTime], [OverTimeHours], [reason], [Remarks], [result]) VALUES (126, N'submit', CAST(N'2021-08-13' AS Date), 3, N'rd1', N'蜘蛛人', N'RD', N'RD', N'平日加班', CAST(N'2021-08-11' AS Date), N'18:00', N'20:00', N'2.0', N'研發二代蜘蛛絲發射器', N'完成度90%', N'pending')
INSERT [dbo].[overtimeapplicationpending] ([ID], [Type], [DateOfApplication], [managerEmpId], [EmpNo], [EmpName], [department], [position], [OvertimeCategory], [OverTimeDate], [StartingTime], [EndingTime], [OverTimeHours], [reason], [Remarks], [result]) VALUES (127, N'submit', CAST(N'2021-08-16' AS Date), 3, N'rd1', N'蜘蛛人', N'RD', N'RD', N'平日加班', CAST(N'2021-08-13' AS Date), N'18:00', N'20:00', N'2.0', N'研發二代蜘蛛絲發射器', N'完成度100%', N'pending')
SET IDENTITY_INSERT [dbo].[overtimeapplicationpending] OFF
GO
