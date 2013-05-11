
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, and Azure
-- --------------------------------------------------
-- Date Created: 12/10/2012 11:35:08
-- Generated from EDMX file: F:\50cms2014\App_Code\Models\ModSQL.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------


-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[ModelStoreContainer].[L_Classs]', 'U') IS NOT NULL
    DROP TABLE [ModelStoreContainer].[L_Classs];
GO
IF OBJECT_ID(N'[ModelStoreContainer].[L_Feedback]', 'U') IS NOT NULL
    DROP TABLE [ModelStoreContainer].[L_Feedback];
GO
IF OBJECT_ID(N'[ModelStoreContainer].[L_Form]', 'U') IS NOT NULL
    DROP TABLE [ModelStoreContainer].[L_Form];
GO
IF OBJECT_ID(N'[ModelStoreContainer].[L_Log]', 'U') IS NOT NULL
    DROP TABLE [ModelStoreContainer].[L_Log];
GO
IF OBJECT_ID(N'[ModelStoreContainer].[L_Newss]', 'U') IS NOT NULL
    DROP TABLE [ModelStoreContainer].[L_Newss];
GO
IF OBJECT_ID(N'[ModelStoreContainer].[L_RForm]', 'U') IS NOT NULL
    DROP TABLE [ModelStoreContainer].[L_RForm];
GO
IF OBJECT_ID(N'[ModelStoreContainer].[L_Tags]', 'U') IS NOT NULL
    DROP TABLE [ModelStoreContainer].[L_Tags];
GO
IF OBJECT_ID(N'[ModelStoreContainer].[Manages]', 'U') IS NOT NULL
    DROP TABLE [ModelStoreContainer].[Manages];
GO
IF OBJECT_ID(N'[ModelStoreContainer].[WdBM]', 'U') IS NOT NULL
    DROP TABLE [ModelStoreContainer].[WdBM];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'L_Classs'
CREATE TABLE [dbo].[L_Classs] (
    [CID] integer  NOT NULL,
    [CNmae] nvarchar(50)  NULL,
    [CpareID] integer  NULL,
    [CKeyWord] nvarchar(255)  NULL,
    [CUrl] nvarchar(200)  NULL,
    [CTag] nvarchar(2000)  NULL,
    [CTag2] nvarchar(2000)  NULL,
    [CTag3] nvarchar(2000)  NULL,
    [CType] int  NULL,
    [CSubSkin] nvarchar(50)  NULL,
    [CSkin] nvarchar(50)  NULL
);
GO

-- Creating table 'L_Feedback'
CREATE TABLE [dbo].[L_Feedback] (
    [FID] integer  NOT NULL,
    [NID] integer  NULL,
    [FName] nvarchar(100)  NULL,
    [FTel] nvarchar(100)  NULL,
    [FQQ] nvarchar(100)  NULL,
    [FMail] nvarchar(100)  NULL,
    [FTitle] nvarchar(250)  NULL,
    [FContent] nvarchar(4000)  NULL,
    [FTime] nvarchar(50)  NULL,
    [FReContent] nvarchar(4000)  NULL,
    [FReTime] nvarchar(50)  NULL,
    [FLock] nvarchar(10)  NULL
);
GO

-- Creating table 'L_Form'
CREATE TABLE [dbo].[L_Form] (
    [FID] integer  NOT NULL,
    [FNmae] nvarchar(100)  NULL,
    [FStat] integer  NULL,
    [Fother] nvarchar(500)  NULL,
    [F1] nvarchar(500)  NULL,
    [FMust] integer  NULL,
    [FTime] nvarchar(50)  NULL,
    [F1C] nvarchar(500)  NULL
);
GO

-- Creating table 'L_Log'
CREATE TABLE [dbo].[L_Log] (
    [LID] integer  NOT NULL,
    [L_TiTLE] nvarchar(250)  NULL,
    [L_IP] nvarchar(20)  NULL,
    [L_Time] nvarchar(20)  NULL,
    [L_Act] nvarchar(200)  NULL,
    [L_UID] nvarchar(10)  NULL
);
GO

-- Creating table 'L_Newss'
CREATE TABLE [dbo].[L_Newss] (
    [NID] integer  NOT NULL,
    [ClassId] int  NULL,
    [Title] nvarchar(250)  NULL,
    [Author] nvarchar(100)  NULL,
    [From] nvarchar(100)  NULL,
    [Tag] nvarchar(200)  NULL,
    [ZhaiYao] nvarchar(500)  NULL,
    [Img] nvarchar(250)  NULL,
    [Content] nvarchar(5000)  NULL,
    [Click] nvarchar(50)  NULL,
    [Url] nvarchar(250)  NULL,
    [Time] datetime  NULL,
    [IsTop] blob  NULL,
    [IsHot] blob  NULL,
    [IsSlide] blob  NULL,
    [IsLock] blob  NULL,
    [IsRed] blob  NULL
);
GO

-- Creating table 'L_RForm'
CREATE TABLE [dbo].[L_RForm] (
    [FrID] integer  NOT NULL,
    [FrName] nvarchar(100)  NULL,
    [Fr1] nvarchar(500)  NULL,
    [Fr2] nvarchar(2000)  NULL,
    [FrTime] datetime  NULL,
    [FrRepaly] nvarchar(1000)  NULL,
    [FrReOk] integer  NULL,
    [FrReTime] datetime  NULL,
    [Fr1c] nvarchar(500)  NULL,
    [Fr2c] nvarchar(500)  NULL,
    [FID] integer  NULL
);
GO

-- Creating table 'L_Tags'
CREATE TABLE [dbo].[L_Tags] (
    [TID] integer  NOT NULL,
    [TName] nvarchar(50)  NULL,
    [TContent] nvarchar(5000)  NULL,
    [TNotice] nvarchar(200)  NULL
);
GO

-- Creating table 'Manages'
CREATE TABLE [dbo].[Manages] (
    [MID] integer  NOT NULL,
    [MName] nvarchar(50)  NULL,
    [MPWD] nvarchar(30)  NULL,
    [MRole] nvarchar(10)  NULL,
    [MPower] nvarchar(500)  NULL
);
GO

-- Creating table 'WdBM'
CREATE TABLE [dbo].[WdBM] (
    [BID] integer  NOT NULL,
    [Bname] nvarchar(2147483647)  NULL,
    [Btel] nvarchar(2147483647)  NULL,
    [Biden] nvarchar(2147483647)  NULL,
    [Bcom] nvarchar(2147483647)  NULL,
    [Bmail] nvarchar(2147483647)  NULL,
    [Bname2] nvarchar(2147483647)  NULL,
    [Btel2] nvarchar(2147483647)  NULL,
    [Biden2] nvarchar(2147483647)  NULL,
    [Bcom2] nvarchar(2147483647)  NULL,
    [Bmail2] nvarchar(2147483647)  NULL,
    [Bimg] nvarchar(2147483647)  NULL,
    [Bimg2] nvarchar(2147483647)  NULL,
    [Btime] nvarchar(2147483647)  NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [CID] in table 'L_Classs'
ALTER TABLE [dbo].[L_Classs]
ADD CONSTRAINT [PK_L_Classs]
    PRIMARY KEY CLUSTERED ([CID] ASC);
GO

-- Creating primary key on [FID] in table 'L_Feedback'
ALTER TABLE [dbo].[L_Feedback]
ADD CONSTRAINT [PK_L_Feedback]
    PRIMARY KEY CLUSTERED ([FID] ASC);
GO

-- Creating primary key on [FID] in table 'L_Form'
ALTER TABLE [dbo].[L_Form]
ADD CONSTRAINT [PK_L_Form]
    PRIMARY KEY CLUSTERED ([FID] ASC);
GO

-- Creating primary key on [LID] in table 'L_Log'
ALTER TABLE [dbo].[L_Log]
ADD CONSTRAINT [PK_L_Log]
    PRIMARY KEY CLUSTERED ([LID] ASC);
GO

-- Creating primary key on [NID] in table 'L_Newss'
ALTER TABLE [dbo].[L_Newss]
ADD CONSTRAINT [PK_L_Newss]
    PRIMARY KEY CLUSTERED ([NID] ASC);
GO

-- Creating primary key on [FrID] in table 'L_RForm'
ALTER TABLE [dbo].[L_RForm]
ADD CONSTRAINT [PK_L_RForm]
    PRIMARY KEY CLUSTERED ([FrID] ASC);
GO

-- Creating primary key on [TID] in table 'L_Tags'
ALTER TABLE [dbo].[L_Tags]
ADD CONSTRAINT [PK_L_Tags]
    PRIMARY KEY CLUSTERED ([TID] ASC);
GO

-- Creating primary key on [MID] in table 'Manages'
ALTER TABLE [dbo].[Manages]
ADD CONSTRAINT [PK_Manages]
    PRIMARY KEY CLUSTERED ([MID] ASC);
GO

-- Creating primary key on [BID] in table 'WdBM'
ALTER TABLE [dbo].[WdBM]
ADD CONSTRAINT [PK_WdBM]
    PRIMARY KEY CLUSTERED ([BID] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------