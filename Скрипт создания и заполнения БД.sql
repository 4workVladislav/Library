USE master
IF EXISTS (SELECT * FROM SYS.DATABASES WHERE  NAME='Library')
     DROP DATABASE Library
CREATE DATABASE Library
IF OBJECT_ID('Authors','u') IS NOT NULL DROP TABLE dbo.Authors
IF OBJECT_ID('Books','u') IS NOT NULL DROP TABLE dbo.Books
IF OBJECT_ID('Publisher','u') IS NOT NULL DROP TABLE dbo.Publisher
IF OBJECT_ID('Readers','u') IS NOT NULL DROP TABLE dbo.Readers
IF OBJECT_ID('Extradition','u') IS NOT NULL DROP TABLE dbo.Extradition

GO
USE Library
CREATE TABLE [dbo].[Authors](
	[ID_Author] [int] NOT NULL,
	[Au_Surname] [varchar](30) NULL,
	[Au_Name] [varchar](12) NULL,
	[Au_Patronymic] [varchar](15) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_Author] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

CREATE TABLE [dbo].[Books](
	[ID_Publication] [int] NOT NULL,
	[Name_Publication] [varchar](100) NULL,
	[ID_Author] [int] NULL,
	[�ategory] [varchar](20) NULL,
	[ID_Publisher] [int] NULL,
	[Date_Release] [date] NULL,
	[Circulation] [int] NULL,
	[ISBN] [varchar](50) NULL,
	[UDC] [varchar](15) NULL,
	[Location] [varchar](20) NULL,
	[Date_Delivery] [date] NULL,
	[Quantity] [int] NULL,
 CONSTRAINT [PK__Books__D4F61A3B57637471] PRIMARY KEY CLUSTERED 
(
	[ID_Publication] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

CREATE TABLE [dbo].[Publisher](
	[ID_Publisher] [int] NOT NULL,
	[Name_Publisher] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_Publisher] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

CREATE TABLE [dbo].[Readers](
	[Reader_Login] [varchar](50) NOT NULL,
	[Surname] [varchar](30) NULL,
	[Name] [varchar](12) NULL,
	[Patronymic] [varchar](15) NULL,
	[Reader_Password] [nchar](20) NULL,
	[ID_Reader] [int] NULL,
	[Admin] [bit] NULL, 
PRIMARY KEY CLUSTERED 
(
	[Reader_Login] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

CREATE TABLE [dbo].[Extradition](
	[ID_Extradition] [int] IDENTITY(60001, 1) NOT NULL,
	[Reader_Login] [varchar](50) NULL,
	[ID_Publication] [int] NULL,
	[Date_Issue] [date] NULL,
	[Date_Delivery] [date] NULL,
	[Date_Return] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_Extradition] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[Books]  WITH CHECK ADD  CONSTRAINT [FK_Books_Authors] FOREIGN KEY([ID_Author])
REFERENCES [dbo].[Authors] ([ID_Author])

ALTER TABLE [dbo].[Books] CHECK CONSTRAINT [FK_Books_Authors]

ALTER TABLE [dbo].[Books]  WITH CHECK ADD  CONSTRAINT [FK_Books_Publisher] FOREIGN KEY([ID_Publisher])
REFERENCES [dbo].[Publisher] ([ID_Publisher])

ALTER TABLE [dbo].[Books] CHECK CONSTRAINT [FK_Books_Publisher]

ALTER TABLE [dbo].[Extradition]  WITH CHECK ADD  CONSTRAINT [FK_Extradition_Books] FOREIGN KEY([ID_Publication])
REFERENCES [dbo].[Books] ([ID_Publication])

ALTER TABLE [dbo].[Extradition] CHECK CONSTRAINT [FK_Extradition_Books]

ALTER TABLE [dbo].[Extradition]  WITH CHECK ADD  CONSTRAINT [FK_Extradition_Readers] FOREIGN KEY([Reader_Login])
REFERENCES [dbo].[Readers] ([Reader_Login])

ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Extradition] CHECK CONSTRAINT [FK_Extradition_Readers]
GO
ALTER TABLE [dbo].[Authors]  WITH CHECK ADD CHECK  (([ID_Author]>(0)))
GO
ALTER TABLE [dbo].[Books]  WITH CHECK ADD  CONSTRAINT [CK__Books__ID_Public__276EDEB3] CHECK  (([ID_Publication]>(0)))
GO
ALTER TABLE [dbo].[Books] CHECK CONSTRAINT [CK__Books__ID_Public__276EDEB3]
GO
ALTER TABLE [dbo].[Extradition]  WITH CHECK ADD CHECK  (([ID_Extradition]>(0)))
GO
ALTER TABLE [dbo].[Publisher]  WITH CHECK ADD CHECK  (([ID_Publisher]>(0)))
GO
USE [master]
GO
ALTER DATABASE [Library] SET  READ_WRITE 
GO

USE [master]

ALTER DATABASE [Library] SET  READ_WRITE 

USE Library
INSERT INTO dbo.Authors VALUES(10001, '�������', '���', '����������');   
INSERT INTO dbo.Authors VALUES(10002, '����', '���������', '����');
INSERT INTO dbo.Authors VALUES(10003, '������', '����', '');
INSERT INTO dbo.Authors VALUES(10004, '����', '����', '');
INSERT INTO dbo.Authors VALUES(10005, '����', '�����', '�����');
INSERT INTO dbo.Authors VALUES(10006, '���������', '������', '������');
INSERT INTO dbo.Authors VALUES(10007, '�����', '����', '������');
INSERT INTO dbo.Authors VALUES(10008, '������', '������', '����');
INSERT INTO dbo.Authors VALUES(10009, '������', '�����', '�������');
INSERT INTO dbo.Authors VALUES(10010, '����', '����', '');
INSERT INTO dbo.Authors VALUES(10011, '�����', '����', '������');

INSERT INTO dbo.Readers VALUES('ivanov01', '������', '����', '��������',  'pass1', 20001, '');
INSERT INTO dbo.Readers VALUES('petrov02', '������', '����', '��������',  'pass2', 20002,'True');
INSERT INTO dbo.Readers VALUES('sidorov03', '�������', '�����', '���������',  'pass3', 20003, '');
INSERT INTO dbo.Readers VALUES('smirnov04', '�������', '�����', '���������', 'pass4', 20004, '');
INSERT INTO dbo.Readers VALUES('kuznetsov05', '��������', '������', '����������',  'pass5', 20005, '');
INSERT INTO dbo.Readers VALUES('popov06', '�����', '���', '�������', 'pass6', 20006, '');
INSERT INTO dbo.Readers VALUES('kuzmin07', '�������', '������', '���������',  'pass7', 20007, '');
INSERT INTO dbo.Readers VALUES('smirnov08', '�������', '�����', '���������',  'pass8', 20008, '');
INSERT INTO dbo.Readers VALUES('kruglov09', '�������', '�����', '���������',  'pass9', 20009, '');
INSERT INTO dbo.Readers VALUES('sokolov10', '�������', '�����', '���������',  'pass10', 20010, '');

INSERT INTO dbo.Publisher VALUES(30001, 'ABC Publishing');
INSERT INTO dbo.Publisher VALUES(30002, 'XYZ Publications');
INSERT INTO dbo.Publisher VALUES(30003, 'Top Books');
INSERT INTO dbo.Publisher VALUES(30004, 'Book Haven');
INSERT INTO dbo.Publisher VALUES(30005, 'Literary World');
INSERT INTO dbo.Publisher VALUES(30006, 'Page Turner Press');
INSERT INTO dbo.Publisher VALUES(30007, 'Great Reads');
INSERT INTO dbo.Publisher VALUES(30008, 'Novel Nook');
INSERT INTO dbo.Publisher VALUES(30009, 'Classic Creations');
INSERT INTO dbo.Publisher VALUES(30010, 'Timeless Tales');
INSERT INTO dbo.Publisher VALUES(30011, 'Masterpiece Books');
INSERT INTO dbo.Publisher VALUES(30012, 'Epic Editions');
INSERT INTO dbo.Publisher VALUES(30013, 'Saga Publishers');
INSERT INTO dbo.Publisher VALUES(30014, 'Heritage Press');
INSERT INTO dbo.Publisher VALUES(30015, 'Inkwell Publications');
INSERT INTO dbo.Publisher VALUES(30016, 'Quill & Scroll');

INSERT INTO dbo.Books VALUES(40001, '����� � ���', 10001, '�����', 30008, '1869-01-20', 200000,
'978-5-4335-0275-8', '821.161.1', '�.5, �. 2, �. 1', '1872-12-01', '');
INSERT INTO dbo.Books VALUES(40002, '���� �����-������', 10002, '�����', 30007, '1844-08-28', 120000, '978-5-04-112699-5', '821.486.2',
'�.7 �.2 �.3', '1855-03-15', '');
INSERT INTO dbo.Books VALUES(40003, '��� ���������', 10002, '�����', 30002, '1844-01-14', 80000, '978-5-907076-09-9', '826.437.0',
'�.9 �.2 �.4', '1847-05-12', '');
INSERT INTO dbo.Books VALUES(40004, '������� ����', 10004, '�����', 30012, '1996-08-06', 150000, '978-5-17-097313-2', '82',
'�.5 �.15 �.25', '1998-11-30', '');
INSERT INTO dbo.Books VALUES(40005, '���������� �������', 10010, '�����', 30014, '1928-12-22', 150000, '978-5-17-097313-2', '82',
'�.5 �.15 �.25', '1930-05-02', '');
INSERT INTO dbo.Books VALUES(40006, '������������ � ���������', 10010, '�����', 30002, '1866-01-14', 10000, '978-5-17-513012-4', '82',
'�.6 �.16 �.23', '1867-02-03', '');
INSERT INTO dbo.Books VALUES(40007, '���������� ���', 10011, '�����', 30005, '1954-09-17', 1500, '978-5-17-094665-4', '82',
'�.20 �.1 �.25', '1956-11-10', '');
INSERT INTO dbo.Books VALUES(40008, '���� �����', 10008, '�����', 30006, '2001-09-17', 10000, '978-5-17-094665-4', '82',
'�.22 �.2 �.1', '2003-06-11', '');
INSERT INTO dbo.Books VALUES(40009, '��� ��������', 10006, '�����', 30004, '1936-02-17', 15000, '978-5-17-094665-4', '82',
'�.15 �.3 �.3', '1938-05-22', '');
INSERT INTO dbo.Books VALUES(40010, '�������� ������', 10005, '�����', 30003, '1936-06-30', 100000, '978-5-17-094665-4', '82',
'�.21 �.2 �.12', '1938-09-14', '');

GO
