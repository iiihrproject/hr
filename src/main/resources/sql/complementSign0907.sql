USE [HRDB]
drop table IF EXISTS [dbo].[ComplementSignAuditted];
drop table IF EXISTS [dbo].[ComplementSignPendingApproval];
GO
/****** Object:  Table [dbo].[ComplementSignAuditted]    Script Date: 2021/9/7 下午 10:45:49 ******/
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
/****** Object:  Table [dbo].[ComplementSignPendingApproval]    Script Date: 2021/9/7 下午 10:45:49 ******/
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
	[reason] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_ComplementSignPendingApproval] PRIMARY KEY CLUSTERED 
(
	[Serial_Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[ComplementSignAuditted] ON 

INSERT [dbo].[ComplementSignAuditted] ([empname], [empno], [date], [type], [managerNo], [applied_date], [Serial_Number], [Status], [reason]) VALUES (N'蜘蛛人', N'rd1', CAST(N'2021-08-11' AS Date), N'CheckIn', 3, CAST(N'2021-08-10T09:00:00.000' AS DateTime), 39, N'Pass', N'早上忘記打卡')
INSERT [dbo].[ComplementSignAuditted] ([empname], [empno], [date], [type], [managerNo], [applied_date], [Serial_Number], [Status], [reason]) VALUES (N'蜘蛛人', N'rd1', CAST(N'2021-08-12' AS Date), N'CheckOut', 3, CAST(N'2021-08-11T18:00:00.000' AS DateTime), 40, N'Pass', N'太忙忘了打卡')
INSERT [dbo].[ComplementSignAuditted] ([empname], [empno], [date], [type], [managerNo], [applied_date], [Serial_Number], [Status], [reason]) VALUES (N'蜘蛛人', N'rd1', CAST(N'2021-08-14' AS Date), N'CheckIn', 3, CAST(N'2021-08-13T09:00:00.000' AS DateTime), 41, N'Pass', N'早上衝忙進公司')
INSERT [dbo].[ComplementSignAuditted] ([empname], [empno], [date], [type], [managerNo], [applied_date], [Serial_Number], [Status], [reason]) VALUES (N'浩克', N'rd2', CAST(N'2021-08-12' AS Date), N'CheckIn', 3, CAST(N'2021-08-11T09:00:00.000' AS DateTime), 42, N'Pass', N'早上太衝忙忘記了')
INSERT [dbo].[ComplementSignAuditted] ([empname], [empno], [date], [type], [managerNo], [applied_date], [Serial_Number], [Status], [reason]) VALUES (N'蜘蛛人', N'rd1', CAST(N'2021-09-07' AS Date), N'CheckOut', 3, CAST(N'2021-08-24T18:00:00.000' AS DateTime), 43, N'Pass', N'太忙忘記打卡')
SET IDENTITY_INSERT [dbo].[ComplementSignAuditted] OFF
GO
SET IDENTITY_INSERT [dbo].[ComplementSignPendingApproval] ON 

INSERT [dbo].[ComplementSignPendingApproval] ([empname], [empno], [date], [type], [managerNo], [applied_date], [Serial_Number], [Status], [reason]) VALUES (N'蜘蛛人', N'rd1', CAST(N'2021-08-18' AS Date), N'CheckIn', 3, CAST(N'2021-08-17T09:00:00.000' AS DateTime), 88, N'pending', N'早上忘記打卡')
INSERT [dbo].[ComplementSignPendingApproval] ([empname], [empno], [date], [type], [managerNo], [applied_date], [Serial_Number], [Status], [reason]) VALUES (N'蜘蛛人', N'rd1', CAST(N'2021-08-19' AS Date), N'CheckIn', 3, CAST(N'2021-08-18T09:00:00.000' AS DateTime), 89, N'pending', N'早上忘了打 會再改進')
INSERT [dbo].[ComplementSignPendingApproval] ([empname], [empno], [date], [type], [managerNo], [applied_date], [Serial_Number], [Status], [reason]) VALUES (N'蜘蛛人', N'rd1', CAST(N'2021-08-20' AS Date), N'CheckOut', 3, CAST(N'2021-08-19T18:00:00.000' AS DateTime), 90, N'pending', N'太忙忘了打')
INSERT [dbo].[ComplementSignPendingApproval] ([empname], [empno], [date], [type], [managerNo], [applied_date], [Serial_Number], [Status], [reason]) VALUES (N'浩克', N'rd2', CAST(N'2021-08-25' AS Date), N'CheckOut', 3, CAST(N'2021-08-24T18:00:00.000' AS DateTime), 92, N'pending', N'處理公事')
INSERT [dbo].[ComplementSignPendingApproval] ([empname], [empno], [date], [type], [managerNo], [applied_date], [Serial_Number], [Status], [reason]) VALUES (N'浩克', N'rd2', CAST(N'2021-08-26' AS Date), N'CheckOut', 3, CAST(N'2021-08-25T18:00:00.000' AS DateTime), 93, N'pending', N'研發產品忘記打')
INSERT [dbo].[ComplementSignPendingApproval] ([empname], [empno], [date], [type], [managerNo], [applied_date], [Serial_Number], [Status], [reason]) VALUES (N'浩克', N'rd2', CAST(N'2021-08-31' AS Date), N'CheckOut', 3, CAST(N'2021-08-30T18:00:00.000' AS DateTime), 94, N'pending', N'趕產品開發進度')
INSERT [dbo].[ComplementSignPendingApproval] ([empname], [empno], [date], [type], [managerNo], [applied_date], [Serial_Number], [Status], [reason]) VALUES (N'蜘蛛人', N'rd1', CAST(N'2021-08-21' AS Date), N'CheckIn', 3, CAST(N'2021-08-20T09:00:00.000' AS DateTime), 95, N'pending', N'早上開會未打卡')
SET IDENTITY_INSERT [dbo].[ComplementSignPendingApproval] OFF
GO
