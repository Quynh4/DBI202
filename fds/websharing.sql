USE [master]
GO
/****** Object:  Database [sourceWebSharing]    Script Date: 05/29/23 7:52:29 PM ******/
CREATE DATABASE [sourceWebSharing]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'sourceWebSharing', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\sourceWebSharing.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'sourceWebSharing_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\sourceWebSharing_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [sourceWebSharing] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [sourceWebSharing].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [sourceWebSharing] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [sourceWebSharing] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [sourceWebSharing] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [sourceWebSharing] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [sourceWebSharing] SET ARITHABORT OFF 
GO
ALTER DATABASE [sourceWebSharing] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [sourceWebSharing] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [sourceWebSharing] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [sourceWebSharing] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [sourceWebSharing] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [sourceWebSharing] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [sourceWebSharing] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [sourceWebSharing] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [sourceWebSharing] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [sourceWebSharing] SET  ENABLE_BROKER 
GO
ALTER DATABASE [sourceWebSharing] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [sourceWebSharing] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [sourceWebSharing] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [sourceWebSharing] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [sourceWebSharing] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [sourceWebSharing] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [sourceWebSharing] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [sourceWebSharing] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [sourceWebSharing] SET  MULTI_USER 
GO
ALTER DATABASE [sourceWebSharing] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [sourceWebSharing] SET DB_CHAINING OFF 
GO
ALTER DATABASE [sourceWebSharing] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [sourceWebSharing] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [sourceWebSharing] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [sourceWebSharing] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [sourceWebSharing] SET QUERY_STORE = OFF
GO
USE [sourceWebSharing]
GO
/****** Object:  Table [dbo].[course]    Script Date: 05/29/23 7:52:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[course](
	[id] [int] NOT NULL,
	[specialization_id] [int] NULL,
	[name] [varchar](100) NOT NULL,
	[commitment] [varchar](200) NOT NULL,
	[description] [text] NOT NULL,
	[course_price] [decimal](8, 2) NOT NULL,
	[active] [char](1) NOT NULL,
 CONSTRAINT [course_pk] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[course_create_by]    Script Date: 05/29/23 7:52:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[course_create_by](
	[id] [int] NOT NULL,
	[course_id] [int] NOT NULL,
	[institution_id] [int] NOT NULL,
 CONSTRAINT [course_create_by_pk] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[course_sesion]    Script Date: 05/29/23 7:52:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[course_sesion](
	[id] [int] NOT NULL,
	[start_date] [date] NOT NULL,
	[end_date] [date] NOT NULL,
	[course_id] [int] NOT NULL,
	[specialization_sesion_id] [int] NOT NULL,
 CONSTRAINT [course_sesion_pk] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[enrolled_course]    Script Date: 05/29/23 7:52:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[enrolled_course](
	[id] [int] NOT NULL,
	[course_sesion_id] [int] NOT NULL,
	[student_id] [int] NOT NULL,
	[enrollment_date] [date] NOT NULL,
	[status_date] [int] NULL,
	[final_grade] [decimal](8, 2) NULL,
	[certificate_ID] [text] NULL,
	[certificate_location] [text] NULL,
	[status_id] [int] NULL,
 CONSTRAINT [enrolled_course_pk] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[enrolled_specialization]    Script Date: 05/29/23 7:52:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[enrolled_specialization](
	[id] [int] NOT NULL,
	[enrollment_date] [int] NOT NULL,
	[status_date] [date] NULL,
	[final_grade] [decimal](8, 2) NULL,
	[certificate_id] [text] NULL,
	[certificate_location] [text] NULL,
	[status_id] [int] NULL,
	[specialization_sesion_id] [int] NOT NULL,
	[student_id] [int] NOT NULL,
 CONSTRAINT [enrolled_specialization_pk] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[institution]    Script Date: 05/29/23 7:52:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[institution](
	[id] [int] NOT NULL,
	[name] [varchar](255) NOT NULL,
	[location] [varchar](255) NOT NULL,
 CONSTRAINT [institution_pk] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lecturer]    Script Date: 05/29/23 7:52:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lecturer](
	[id] [int] NOT NULL,
	[last_name] [nvarchar](255) NOT NULL,
	[first_name] [nvarchar](255) NOT NULL,
	[titile] [nvarchar](100) NOT NULL,
	[institution_id] [int] NOT NULL,
 CONSTRAINT [lecturer_pk] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[material]    Script Date: 05/29/23 7:52:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[material](
	[id] [int] NOT NULL,
	[section_id] [int] NOT NULL,
	[material_type_id] [int] NOT NULL,
	[material_no] [int] NOT NULL,
	[meterial_link] [text] NOT NULL,
 CONSTRAINT [material_pk] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[material_type]    Script Date: 05/29/23 7:52:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[material_type](
	[id] [int] NOT NULL,
	[type_name] [nvarchar](100) NOT NULL,
 CONSTRAINT [material_type_pk] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[on_course]    Script Date: 05/29/23 7:52:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[on_course](
	[id] [int] NOT NULL,
	[course_id] [int] NOT NULL,
	[lecturer_id] [int] NOT NULL,
 CONSTRAINT [on_course_pk] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[on_specialization]    Script Date: 05/29/23 7:52:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[on_specialization](
	[id] [int] NOT NULL,
	[specialization_id] [int] NOT NULL,
	[lecturer_id] [int] NOT NULL,
 CONSTRAINT [on_specialization_pk] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[section]    Script Date: 05/29/23 7:52:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[section](
	[id] [int] NOT NULL,
	[description] [text] NOT NULL,
	[course_id] [int] NOT NULL,
 CONSTRAINT [section_pk] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[specialization]    Script Date: 05/29/23 7:52:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[specialization](
	[id] [int] NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[description] [text] NOT NULL,
	[specialization_discount] [decimal](8, 2) NOT NULL,
	[active] [char](1) NOT NULL,
 CONSTRAINT [specialization_pk] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[specialization_create_by]    Script Date: 05/29/23 7:52:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[specialization_create_by](
	[id] [int] NOT NULL,
	[institution_id] [int] NOT NULL,
	[specialization_id] [int] NOT NULL,
 CONSTRAINT [specialization_create_by_pk] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[specialization_sesion]    Script Date: 05/29/23 7:52:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[specialization_sesion](
	[id] [int] NOT NULL,
	[start_date] [date] NOT NULL,
	[end_date] [date] NOT NULL,
	[specialization_id] [int] NOT NULL,
 CONSTRAINT [specialization_sesion_pk] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[status]    Script Date: 05/29/23 7:52:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[status](
	[id] [int] NOT NULL,
	[status_name] [varchar](255) NOT NULL,
 CONSTRAINT [status_pk] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[student]    Script Date: 05/29/23 7:52:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[student](
	[id] [int] NOT NULL,
	[last_name] [nvarchar](50) NOT NULL,
	[first_name] [nvarchar](50) NOT NULL,
	[user_name] [nvarchar](200) NOT NULL,
	[password] [nvarchar](200) NOT NULL,
	[location] [text] NOT NULL,
 CONSTRAINT [student_pk] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[student_result]    Script Date: 05/29/23 7:52:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[student_result](
	[id] [int] NOT NULL,
	[material_id] [int] NOT NULL,
	[enrolled_course_id] [int] NOT NULL,
	[attempt] [int] NOT NULL,
	[atempt_link] [text] NULL,
	[started] [datetime] NOT NULL,
	[score] [decimal](18, 0) NULL,
 CONSTRAINT [student_result_pk] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[studentData]    Script Date: 05/29/23 7:52:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[studentData](
	[id] [smallint] NOT NULL,
	[last_name] [nvarchar](50) NULL,
	[first_name] [nvarchar](50) NULL,
	[use_name] [nvarchar](50) NULL,
	[password] [nvarchar](50) NULL,
	[location] [nvarchar](50) NULL,
 CONSTRAINT [PK_studentData] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[topic]    Script Date: 05/29/23 7:52:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[topic](
	[id] [int] NOT NULL,
	[name] [nvarchar](200) NOT NULL,
	[parent_id] [int] NOT NULL,
	[type] [nvarchar](100) NOT NULL,
	[total_course] [int] NOT NULL,
	[course_id] [int] NOT NULL,
 CONSTRAINT [topic_pk] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[course]  WITH CHECK ADD  CONSTRAINT [course_specialization] FOREIGN KEY([specialization_id])
REFERENCES [dbo].[specialization] ([id])
GO
ALTER TABLE [dbo].[course] CHECK CONSTRAINT [course_specialization]
GO
ALTER TABLE [dbo].[course_create_by]  WITH CHECK ADD  CONSTRAINT [course_create_by_course] FOREIGN KEY([course_id])
REFERENCES [dbo].[course] ([id])
GO
ALTER TABLE [dbo].[course_create_by] CHECK CONSTRAINT [course_create_by_course]
GO
ALTER TABLE [dbo].[course_create_by]  WITH CHECK ADD  CONSTRAINT [course_create_by_institution] FOREIGN KEY([institution_id])
REFERENCES [dbo].[institution] ([id])
GO
ALTER TABLE [dbo].[course_create_by] CHECK CONSTRAINT [course_create_by_institution]
GO
ALTER TABLE [dbo].[course_sesion]  WITH CHECK ADD  CONSTRAINT [course_sesion_course] FOREIGN KEY([course_id])
REFERENCES [dbo].[course] ([id])
GO
ALTER TABLE [dbo].[course_sesion] CHECK CONSTRAINT [course_sesion_course]
GO
ALTER TABLE [dbo].[course_sesion]  WITH CHECK ADD  CONSTRAINT [course_sesion_specialization_sesion] FOREIGN KEY([specialization_sesion_id])
REFERENCES [dbo].[specialization_sesion] ([id])
GO
ALTER TABLE [dbo].[course_sesion] CHECK CONSTRAINT [course_sesion_specialization_sesion]
GO
ALTER TABLE [dbo].[enrolled_course]  WITH CHECK ADD  CONSTRAINT [enrolled_course_course_sesion] FOREIGN KEY([course_sesion_id])
REFERENCES [dbo].[course_sesion] ([id])
GO
ALTER TABLE [dbo].[enrolled_course] CHECK CONSTRAINT [enrolled_course_course_sesion]
GO
ALTER TABLE [dbo].[enrolled_course]  WITH CHECK ADD  CONSTRAINT [enrolled_course_status] FOREIGN KEY([status_id])
REFERENCES [dbo].[status] ([id])
GO
ALTER TABLE [dbo].[enrolled_course] CHECK CONSTRAINT [enrolled_course_status]
GO
ALTER TABLE [dbo].[enrolled_course]  WITH CHECK ADD  CONSTRAINT [enrolled_course_student] FOREIGN KEY([student_id])
REFERENCES [dbo].[student] ([id])
GO
ALTER TABLE [dbo].[enrolled_course] CHECK CONSTRAINT [enrolled_course_student]
GO
ALTER TABLE [dbo].[enrolled_specialization]  WITH CHECK ADD  CONSTRAINT [enrolled_specialization_specialization_sesion] FOREIGN KEY([specialization_sesion_id])
REFERENCES [dbo].[specialization_sesion] ([id])
GO
ALTER TABLE [dbo].[enrolled_specialization] CHECK CONSTRAINT [enrolled_specialization_specialization_sesion]
GO
ALTER TABLE [dbo].[enrolled_specialization]  WITH CHECK ADD  CONSTRAINT [enrolled_specialization_status] FOREIGN KEY([status_id])
REFERENCES [dbo].[status] ([id])
GO
ALTER TABLE [dbo].[enrolled_specialization] CHECK CONSTRAINT [enrolled_specialization_status]
GO
ALTER TABLE [dbo].[enrolled_specialization]  WITH CHECK ADD  CONSTRAINT [enrolled_specialization_student] FOREIGN KEY([student_id])
REFERENCES [dbo].[student] ([id])
GO
ALTER TABLE [dbo].[enrolled_specialization] CHECK CONSTRAINT [enrolled_specialization_student]
GO
ALTER TABLE [dbo].[lecturer]  WITH CHECK ADD  CONSTRAINT [lecturer_institution] FOREIGN KEY([institution_id])
REFERENCES [dbo].[institution] ([id])
GO
ALTER TABLE [dbo].[lecturer] CHECK CONSTRAINT [lecturer_institution]
GO
ALTER TABLE [dbo].[material]  WITH CHECK ADD  CONSTRAINT [material_material_type] FOREIGN KEY([material_type_id])
REFERENCES [dbo].[material_type] ([id])
GO
ALTER TABLE [dbo].[material] CHECK CONSTRAINT [material_material_type]
GO
ALTER TABLE [dbo].[material]  WITH CHECK ADD  CONSTRAINT [material_section_chapter] FOREIGN KEY([section_id])
REFERENCES [dbo].[section] ([id])
GO
ALTER TABLE [dbo].[material] CHECK CONSTRAINT [material_section_chapter]
GO
ALTER TABLE [dbo].[on_course]  WITH CHECK ADD  CONSTRAINT [on_course_course] FOREIGN KEY([course_id])
REFERENCES [dbo].[course] ([id])
GO
ALTER TABLE [dbo].[on_course] CHECK CONSTRAINT [on_course_course]
GO
ALTER TABLE [dbo].[on_course]  WITH CHECK ADD  CONSTRAINT [on_course_lecturer] FOREIGN KEY([lecturer_id])
REFERENCES [dbo].[lecturer] ([id])
GO
ALTER TABLE [dbo].[on_course] CHECK CONSTRAINT [on_course_lecturer]
GO
ALTER TABLE [dbo].[on_specialization]  WITH CHECK ADD  CONSTRAINT [on_specialization_lecturer] FOREIGN KEY([lecturer_id])
REFERENCES [dbo].[lecturer] ([id])
GO
ALTER TABLE [dbo].[on_specialization] CHECK CONSTRAINT [on_specialization_lecturer]
GO
ALTER TABLE [dbo].[on_specialization]  WITH CHECK ADD  CONSTRAINT [on_specialization_specialization] FOREIGN KEY([specialization_id])
REFERENCES [dbo].[specialization] ([id])
GO
ALTER TABLE [dbo].[on_specialization] CHECK CONSTRAINT [on_specialization_specialization]
GO
ALTER TABLE [dbo].[section]  WITH CHECK ADD  CONSTRAINT [section_chapter_course] FOREIGN KEY([course_id])
REFERENCES [dbo].[course] ([id])
GO
ALTER TABLE [dbo].[section] CHECK CONSTRAINT [section_chapter_course]
GO
ALTER TABLE [dbo].[specialization_create_by]  WITH CHECK ADD  CONSTRAINT [specialization_create_by_institution] FOREIGN KEY([institution_id])
REFERENCES [dbo].[institution] ([id])
GO
ALTER TABLE [dbo].[specialization_create_by] CHECK CONSTRAINT [specialization_create_by_institution]
GO
ALTER TABLE [dbo].[specialization_create_by]  WITH CHECK ADD  CONSTRAINT [specialization_create_by_specialization] FOREIGN KEY([specialization_id])
REFERENCES [dbo].[specialization] ([id])
GO
ALTER TABLE [dbo].[specialization_create_by] CHECK CONSTRAINT [specialization_create_by_specialization]
GO
ALTER TABLE [dbo].[specialization_sesion]  WITH CHECK ADD  CONSTRAINT [specialization_sesion_specialization] FOREIGN KEY([specialization_id])
REFERENCES [dbo].[specialization] ([id])
GO
ALTER TABLE [dbo].[specialization_sesion] CHECK CONSTRAINT [specialization_sesion_specialization]
GO
ALTER TABLE [dbo].[student_result]  WITH CHECK ADD  CONSTRAINT [student_result_enrolled_course] FOREIGN KEY([enrolled_course_id])
REFERENCES [dbo].[enrolled_course] ([id])
GO
ALTER TABLE [dbo].[student_result] CHECK CONSTRAINT [student_result_enrolled_course]
GO
ALTER TABLE [dbo].[student_result]  WITH CHECK ADD  CONSTRAINT [student_result_material] FOREIGN KEY([material_id])
REFERENCES [dbo].[material] ([id])
GO
ALTER TABLE [dbo].[student_result] CHECK CONSTRAINT [student_result_material]
GO
ALTER TABLE [dbo].[topic]  WITH CHECK ADD  CONSTRAINT [topic_course] FOREIGN KEY([course_id])
REFERENCES [dbo].[course] ([id])
GO
ALTER TABLE [dbo].[topic] CHECK CONSTRAINT [topic_course]
GO
USE [master]
GO
ALTER DATABASE [sourceWebSharing] SET  READ_WRITE 
GO
