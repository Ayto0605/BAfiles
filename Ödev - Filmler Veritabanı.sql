USE [BaFilmlerDb]
GO
/****** Object:  Table [dbo].[Film]    Script Date: 21.09.2020 15:04:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Film](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Adi] [varchar](500) NOT NULL,
	[YapimYili] [char](4) NOT NULL,
	[Gisesi] [money] NULL,
 CONSTRAINT [PK_Film] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Yonetmen]    Script Date: 21.09.2020 15:04:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Yonetmen](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Adi] [varchar](50) NOT NULL,
	[Soyadi] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Yonetmen] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tur]    Script Date: 21.09.2020 15:04:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tur](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Adi] [varchar](100) NOT NULL,
 CONSTRAINT [PK_Tur] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Oyuncu]    Script Date: 21.09.2020 15:04:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Oyuncu](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Adi] [varchar](50) NOT NULL,
	[Soyadi] [varchar](50) NOT NULL,
	[DogumTarihi] [date] NULL,
 CONSTRAINT [PK_Oyuncu] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Karakter]    Script Date: 21.09.2020 15:04:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Karakter](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AdiSoyadi] [varchar](100) NOT NULL,
 CONSTRAINT [PK_Karakter] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FilmTur]    Script Date: 21.09.2020 15:04:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FilmTur](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FilmId] [int] NOT NULL,
	[TurId] [int] NOT NULL,
 CONSTRAINT [PK_FilmTur] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FilmYonetmen]    Script Date: 21.09.2020 15:04:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FilmYonetmen](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FilmId] [int] NOT NULL,
	[YonetmenId] [int] NOT NULL,
 CONSTRAINT [PK_FilmYonetmen] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FilmOyuncuKarakter]    Script Date: 21.09.2020 15:04:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FilmOyuncuKarakter](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FilmId] [int] NOT NULL,
	[OyuncuId] [int] NOT NULL,
	[KarakterId] [int] NOT NULL,
 CONSTRAINT [PK_FilmOyuncuKarakter] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vFilmler]    Script Date: 21.09.2020 15:04:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vFilmler]
as
select f.Id, f.Adi as Film, f.YapimYili, f.Gisesi, y.Adi + ' ' + y.Soyadi as Yonetmen, 
o.Adi + ' ' + o.Soyadi as Oyuncu, o.DogumTarihi,
k.AdiSoyadi as Karakter, t.Adi as Tur from Film f
inner join FilmYonetmen fy
on f.Id = fy.FilmId
inner join Yonetmen y
on fy.YonetmenId = y.Id
inner join FilmOyuncuKarakter fok
on fok.FilmId = f.Id
inner join Oyuncu o
on fok.OyuncuId = o.Id
inner join Karakter k
on fok.KarakterId = k.Id
inner join FilmTur ft
on ft.FilmId = f.Id
inner join Tur t
on ft.TurId = t.Id
GO
SET IDENTITY_INSERT [dbo].[Film] ON 

INSERT [dbo].[Film] ([Id], [Adi], [YapimYili], [Gisesi]) VALUES (1, N'GORA', N'2000', 3890000.0000)
INSERT [dbo].[Film] ([Id], [Adi], [YapimYili], [Gisesi]) VALUES (2, N'Titanic', N'1997', 100960500.0000)
INSERT [dbo].[Film] ([Id], [Adi], [YapimYili], [Gisesi]) VALUES (3, N'The Fast & Furious', N'2001', 50690875.5000)
SET IDENTITY_INSERT [dbo].[Film] OFF
GO
SET IDENTITY_INSERT [dbo].[FilmOyuncuKarakter] ON 

INSERT [dbo].[FilmOyuncuKarakter] ([Id], [FilmId], [OyuncuId], [KarakterId]) VALUES (1, 1, 1, 1)
INSERT [dbo].[FilmOyuncuKarakter] ([Id], [FilmId], [OyuncuId], [KarakterId]) VALUES (2, 1, 1, 2)
INSERT [dbo].[FilmOyuncuKarakter] ([Id], [FilmId], [OyuncuId], [KarakterId]) VALUES (3, 1, 2, 3)
INSERT [dbo].[FilmOyuncuKarakter] ([Id], [FilmId], [OyuncuId], [KarakterId]) VALUES (4, 2, 3, 4)
INSERT [dbo].[FilmOyuncuKarakter] ([Id], [FilmId], [OyuncuId], [KarakterId]) VALUES (5, 2, 4, 5)
INSERT [dbo].[FilmOyuncuKarakter] ([Id], [FilmId], [OyuncuId], [KarakterId]) VALUES (6, 3, 5, 6)
INSERT [dbo].[FilmOyuncuKarakter] ([Id], [FilmId], [OyuncuId], [KarakterId]) VALUES (7, 3, 6, 7)
SET IDENTITY_INSERT [dbo].[FilmOyuncuKarakter] OFF
GO
SET IDENTITY_INSERT [dbo].[FilmTur] ON 

INSERT [dbo].[FilmTur] ([Id], [FilmId], [TurId]) VALUES (1, 1, 1)
INSERT [dbo].[FilmTur] ([Id], [FilmId], [TurId]) VALUES (2, 1, 2)
INSERT [dbo].[FilmTur] ([Id], [FilmId], [TurId]) VALUES (3, 2, 3)
INSERT [dbo].[FilmTur] ([Id], [FilmId], [TurId]) VALUES (4, 2, 4)
INSERT [dbo].[FilmTur] ([Id], [FilmId], [TurId]) VALUES (5, 3, 5)
SET IDENTITY_INSERT [dbo].[FilmTur] OFF
GO
SET IDENTITY_INSERT [dbo].[FilmYonetmen] ON 

INSERT [dbo].[FilmYonetmen] ([Id], [FilmId], [YonetmenId]) VALUES (1, 1, 1)
INSERT [dbo].[FilmYonetmen] ([Id], [FilmId], [YonetmenId]) VALUES (2, 2, 2)
INSERT [dbo].[FilmYonetmen] ([Id], [FilmId], [YonetmenId]) VALUES (3, 3, 3)
SET IDENTITY_INSERT [dbo].[FilmYonetmen] OFF
GO
SET IDENTITY_INSERT [dbo].[Karakter] ON 

INSERT [dbo].[Karakter] ([Id], [AdiSoyadi]) VALUES (1, N'Arif')
INSERT [dbo].[Karakter] ([Id], [AdiSoyadi]) VALUES (2, N'Komutan Logar')
INSERT [dbo].[Karakter] ([Id], [AdiSoyadi]) VALUES (3, N'Ceku')
INSERT [dbo].[Karakter] ([Id], [AdiSoyadi]) VALUES (4, N'Jack Dawson')
INSERT [dbo].[Karakter] ([Id], [AdiSoyadi]) VALUES (5, N'Rose DeWitt Bukater/Dawson')
INSERT [dbo].[Karakter] ([Id], [AdiSoyadi]) VALUES (6, N'Brian O''Conner')
INSERT [dbo].[Karakter] ([Id], [AdiSoyadi]) VALUES (7, N'Dominic Toretto')
SET IDENTITY_INSERT [dbo].[Karakter] OFF
GO
SET IDENTITY_INSERT [dbo].[Oyuncu] ON 

INSERT [dbo].[Oyuncu] ([Id], [Adi], [Soyadi], [DogumTarihi]) VALUES (1, N'Cem', N'Yılmaz', NULL)
INSERT [dbo].[Oyuncu] ([Id], [Adi], [Soyadi], [DogumTarihi]) VALUES (2, N'Özge', N'Özberk', NULL)
INSERT [dbo].[Oyuncu] ([Id], [Adi], [Soyadi], [DogumTarihi]) VALUES (3, N'Leonardo', N'DiCaprio', NULL)
INSERT [dbo].[Oyuncu] ([Id], [Adi], [Soyadi], [DogumTarihi]) VALUES (4, N'Kate', N'Winslet', NULL)
INSERT [dbo].[Oyuncu] ([Id], [Adi], [Soyadi], [DogumTarihi]) VALUES (5, N'Paul', N'Walker', CAST(N'1973-09-12' AS Date))
INSERT [dbo].[Oyuncu] ([Id], [Adi], [Soyadi], [DogumTarihi]) VALUES (6, N'Vin', N'Diesel', NULL)
SET IDENTITY_INSERT [dbo].[Oyuncu] OFF
GO
SET IDENTITY_INSERT [dbo].[Tur] ON 

INSERT [dbo].[Tur] ([Id], [Adi]) VALUES (1, N'Bilim Kurgu')
INSERT [dbo].[Tur] ([Id], [Adi]) VALUES (2, N'Komedi')
INSERT [dbo].[Tur] ([Id], [Adi]) VALUES (3, N'Dram')
INSERT [dbo].[Tur] ([Id], [Adi]) VALUES (4, N'Tarih')
INSERT [dbo].[Tur] ([Id], [Adi]) VALUES (5, N'Aksiyon')
SET IDENTITY_INSERT [dbo].[Tur] OFF
GO
SET IDENTITY_INSERT [dbo].[Yonetmen] ON 

INSERT [dbo].[Yonetmen] ([Id], [Adi], [Soyadi]) VALUES (1, N'Ömer Faruk', N'Sorak')
INSERT [dbo].[Yonetmen] ([Id], [Adi], [Soyadi]) VALUES (2, N'James', N'Cameron')
INSERT [dbo].[Yonetmen] ([Id], [Adi], [Soyadi]) VALUES (3, N'Rob', N'Cohen')
SET IDENTITY_INSERT [dbo].[Yonetmen] OFF
GO
ALTER TABLE [dbo].[FilmOyuncuKarakter]  WITH CHECK ADD  CONSTRAINT [FK_FilmOyuncuKarakter_Film] FOREIGN KEY([FilmId])
REFERENCES [dbo].[Film] ([Id])
GO
ALTER TABLE [dbo].[FilmOyuncuKarakter] CHECK CONSTRAINT [FK_FilmOyuncuKarakter_Film]
GO
ALTER TABLE [dbo].[FilmOyuncuKarakter]  WITH CHECK ADD  CONSTRAINT [FK_FilmOyuncuKarakter_Karakter] FOREIGN KEY([KarakterId])
REFERENCES [dbo].[Karakter] ([Id])
GO
ALTER TABLE [dbo].[FilmOyuncuKarakter] CHECK CONSTRAINT [FK_FilmOyuncuKarakter_Karakter]
GO
ALTER TABLE [dbo].[FilmOyuncuKarakter]  WITH CHECK ADD  CONSTRAINT [FK_FilmOyuncuKarakter_Oyuncu] FOREIGN KEY([OyuncuId])
REFERENCES [dbo].[Oyuncu] ([Id])
GO
ALTER TABLE [dbo].[FilmOyuncuKarakter] CHECK CONSTRAINT [FK_FilmOyuncuKarakter_Oyuncu]
GO
ALTER TABLE [dbo].[FilmTur]  WITH CHECK ADD  CONSTRAINT [FK_FilmTur_Film] FOREIGN KEY([FilmId])
REFERENCES [dbo].[Film] ([Id])
GO
ALTER TABLE [dbo].[FilmTur] CHECK CONSTRAINT [FK_FilmTur_Film]
GO
ALTER TABLE [dbo].[FilmTur]  WITH CHECK ADD  CONSTRAINT [FK_FilmTur_Tur] FOREIGN KEY([TurId])
REFERENCES [dbo].[Tur] ([Id])
GO
ALTER TABLE [dbo].[FilmTur] CHECK CONSTRAINT [FK_FilmTur_Tur]
GO
ALTER TABLE [dbo].[FilmYonetmen]  WITH CHECK ADD  CONSTRAINT [FK_FilmYonetmen_Film] FOREIGN KEY([FilmId])
REFERENCES [dbo].[Film] ([Id])
GO
ALTER TABLE [dbo].[FilmYonetmen] CHECK CONSTRAINT [FK_FilmYonetmen_Film]
GO
ALTER TABLE [dbo].[FilmYonetmen]  WITH CHECK ADD  CONSTRAINT [FK_FilmYonetmen_Yonetmen] FOREIGN KEY([YonetmenId])
REFERENCES [dbo].[Yonetmen] ([Id])
GO
ALTER TABLE [dbo].[FilmYonetmen] CHECK CONSTRAINT [FK_FilmYonetmen_Yonetmen]
GO
