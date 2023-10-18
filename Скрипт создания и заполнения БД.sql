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
	[Сategory] [varchar](20) NULL,
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
INSERT INTO dbo.Authors VALUES(10001, 'Толстой', 'Лев', 'Николаевич');   
INSERT INTO dbo.Authors VALUES(10002, 'Дюма', 'Александр', 'Дюма');
INSERT INTO dbo.Authors VALUES(10003, 'Кристо', 'Анри', '');
INSERT INTO dbo.Authors VALUES(10004, 'Грин', 'Грэм', '');
INSERT INTO dbo.Authors VALUES(10005, 'Дойл', 'Артур', 'Конан');
INSERT INTO dbo.Authors VALUES(10006, 'Хемингуэй', 'Эрнест', 'Миллер');
INSERT INTO dbo.Authors VALUES(10007, 'Фаулз', 'Джон', 'Роберт');
INSERT INTO dbo.Authors VALUES(10008, 'Оруэлл', 'Джордж', 'Эрик');
INSERT INTO dbo.Authors VALUES(10009, 'Хаксли', 'Олдос', 'Леонард');
INSERT INTO dbo.Authors VALUES(10010, 'Твен', 'Марк', '');
INSERT INTO dbo.Authors VALUES(10011, 'Гримм', 'Якоб', 'Людвиг');

INSERT INTO dbo.Readers VALUES('ivanov01', 'Иванов', 'Иван', 'Иванович',  'pass1', 20001, '');
INSERT INTO dbo.Readers VALUES('petrov02', 'Петров', 'Петр', 'Петрович',  'pass2', 20002,'True');
INSERT INTO dbo.Readers VALUES('sidorov03', 'Сидоров', 'Сидор', 'Сидорович',  'pass3', 20003, '');
INSERT INTO dbo.Readers VALUES('smirnov04', 'Смирнов', 'Смирн', 'Смирнович', 'pass4', 20004, '');
INSERT INTO dbo.Readers VALUES('kuznetsov05', 'Кузнецов', 'Кузнец', 'Кузнецович',  'pass5', 20005, '');
INSERT INTO dbo.Readers VALUES('popov06', 'Попов', 'Поп', 'Попович', 'pass6', 20006, '');
INSERT INTO dbo.Readers VALUES('kuzmin07', 'Кузьмин', 'Кузьма', 'Кузьминич',  'pass7', 20007, '');
INSERT INTO dbo.Readers VALUES('smirnov08', 'Смирнов', 'Смирн', 'Смирнович',  'pass8', 20008, '');
INSERT INTO dbo.Readers VALUES('kruglov09', 'Круглов', 'Кругл', 'Круглович',  'pass9', 20009, '');
INSERT INTO dbo.Readers VALUES('sokolov10', 'Соколов', 'Сокол', 'Соколович',  'pass10', 20010, '');

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

INSERT INTO dbo.Books VALUES(40001, 'Война и мир', 10001, 'Роман', 30008, '1869-01-20', 200000,
'978-5-4335-0275-8', '821.161.1', 'с.5, р. 2, п. 1', '1872-12-01', '');
INSERT INTO dbo.Books VALUES(40002, 'Граф Монте-Кристо', 10002, 'Роман', 30007, '1844-08-28', 120000, '978-5-04-112699-5', '821.486.2',
'с.7 р.2 п.3', '1855-03-15', '');
INSERT INTO dbo.Books VALUES(40003, 'Три мушкетера', 10002, 'Роман', 30002, '1844-01-14', 80000, '978-5-907076-09-9', '826.437.0',
'с.9 р.2 п.4', '1847-05-12', '');
INSERT INTO dbo.Books VALUES(40004, 'Зеленая миля', 10004, 'Роман', 30012, '1996-08-06', 150000, '978-5-17-097313-2', '82',
'с.5 р.15 п.25', '1998-11-30', '');
INSERT INTO dbo.Books VALUES(40005, 'Двенадцать стульев', 10010, 'Роман', 30014, '1928-12-22', 150000, '978-5-17-097313-2', '82',
'с.5 р.15 п.25', '1930-05-02', '');
INSERT INTO dbo.Books VALUES(40006, 'Преступление и наказание', 10010, 'Роман', 30002, '1866-01-14', 10000, '978-5-17-513012-4', '82',
'с.6 р.16 п.23', '1867-02-03', '');
INSERT INTO dbo.Books VALUES(40007, 'Повелитель мух', 10011, 'Роман', 30005, '1954-09-17', 1500, '978-5-17-094665-4', '82',
'с.20 р.1 п.25', '1956-11-10', '');
INSERT INTO dbo.Books VALUES(40008, 'Тень ветра', 10008, 'Роман', 30006, '2001-09-17', 10000, '978-5-17-094665-4', '82',
'с.22 р.2 п.1', '2003-06-11', '');
INSERT INTO dbo.Books VALUES(40009, 'Три товарища', 10006, 'Роман', 30004, '1936-02-17', 15000, '978-5-17-094665-4', '82',
'с.15 р.3 п.3', '1938-05-22', '');
INSERT INTO dbo.Books VALUES(40010, 'Унесённые ветром', 10005, 'Роман', 30003, '1936-06-30', 100000, '978-5-17-094665-4', '82',
'с.21 р.2 п.12', '1938-09-14', '');

GO
