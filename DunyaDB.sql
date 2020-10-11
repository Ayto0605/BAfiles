-- NOT: Veritaban�n� �nce olu�turmay� unutmay�n!!!

USE [DunyaDB]
GO
/****** Object:  Table [dbo].[Kita]    Script Date: 11.10.2020 15:16:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Kita](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Adi] [varchar](200) NOT NULL,
 CONSTRAINT [PK_Kita] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KitaUlkeSehir]    Script Date: 11.10.2020 15:16:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KitaUlkeSehir](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[KitaId] [int] NOT NULL,
	[UlkeId] [int] NOT NULL,
	[SehirId] [int] NOT NULL,
 CONSTRAINT [PK_KitaUlkeSehir] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sehir]    Script Date: 11.10.2020 15:16:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sehir](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Adi] [varchar](150) NOT NULL,
 CONSTRAINT [PK_Sehir] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ulke]    Script Date: 11.10.2020 15:16:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ulke](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Adi] [varchar](300) NOT NULL,
	[Nufusu] [bigint] NULL,
	[Kisaltmasi] [varchar](20) NULL,
 CONSTRAINT [PK_Ulke] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[KitaUlkeSehir]  WITH CHECK ADD  CONSTRAINT [FK_KitaUlkeSehir_Kita] FOREIGN KEY([KitaId])
REFERENCES [dbo].[Kita] ([Id])
GO
ALTER TABLE [dbo].[KitaUlkeSehir] CHECK CONSTRAINT [FK_KitaUlkeSehir_Kita]
GO
ALTER TABLE [dbo].[KitaUlkeSehir]  WITH CHECK ADD  CONSTRAINT [FK_KitaUlkeSehir_Sehir] FOREIGN KEY([SehirId])
REFERENCES [dbo].[Sehir] ([Id])
GO
ALTER TABLE [dbo].[KitaUlkeSehir] CHECK CONSTRAINT [FK_KitaUlkeSehir_Sehir]
GO
ALTER TABLE [dbo].[KitaUlkeSehir]  WITH CHECK ADD  CONSTRAINT [FK_KitaUlkeSehir_Ulke] FOREIGN KEY([UlkeId])
REFERENCES [dbo].[Ulke] ([Id])
GO
ALTER TABLE [dbo].[KitaUlkeSehir] CHECK CONSTRAINT [FK_KitaUlkeSehir_Ulke]
GO

insert into Kita values ('Asya')
insert into Kita values ('Avrupa')
insert into Kita values ('Kuzey Amerika')

insert into Ulke (Adi, Nufusu, Kisaltmasi) values ('T�rkiye', 83000000, 'TR')
insert into Ulke (Adi, Nufusu, Kisaltmasi) values ('Amerika Birle�ik Devletleri', null, 'ABD')
insert into Ulke (Adi, Nufusu, Kisaltmasi) values ('Almanya', 80000000, 'DE')

insert into Sehir values ('Ankara')
insert into Sehir values ('�stanbul')
insert into Sehir values ('�zmir')
insert into Sehir values ('New York')
insert into Sehir values ('San Francisco')
insert into Sehir values ('Berlin')
insert into Sehir values ('Frankfurt')

insert into KitaUlkeSehir values (1, 1, 1)
insert into KitaUlkeSehir values (1, 1, 2)
insert into KitaUlkeSehir values (2, 1, 2)
insert into KitaUlkeSehir values (1, 1, 3)
insert into KitaUlkeSehir values (3, 2, 4)
insert into KitaUlkeSehir values (3, 2, 5)
insert into KitaUlkeSehir values (2, 3, 6)
insert into KitaUlkeSehir values (2, 3, 7)

-- T�m k�ta, �lke ve �ehirler
select k.Adi as KitaAdi, u.Adi as UlkeAdi, s.Adi as SehirAdi 
from Kita k inner join KitaUlkeSehir kus on k.Id = kus.KitaId
inner join Ulke u on u.Id = kus.UlkeId
inner join Sehir s on s.Id = kus.SehirId 

/* A�a��daki sorgularda KitaUlkeSehir tablosu ile join'den dolay� kay�tlar �oklayaca��ndan 
distinct kullanmak gereklidir! */

-- Avrupa k�tas�ndaki �lkeler
select distinct k.Adi as KitaAdi, u.Adi as UlkeAdi
from Kita k inner join KitaUlkeSehir kus on k.Id = kus.KitaId
inner join Ulke u on u.Id = kus.UlkeId
where k.Adi = 'Avrupa'

-- T�rkiye'deki �ehirler
select distinct u.Adi as UlkeAdi, s.Adi as SehirAdi
from Ulke u inner join KitaUlkeSehir kus on u.Id = kus.UlkeId
inner join Sehir s on kus.SehirId = s.Id
where u.Adi = 'T�rkiye'

/* K�talardaki �lke say�lar�: T�rkiye hem Asya hem de Avrupa'da oldu�undan 
iki k�ta i�in de say�lmas� normal */
select k.Adi as KitaAdi, COUNT(distinct kus.UlkeId) as UlkeSayisi from Kita k inner join KitaUlkeSehir kus
on k.Id = kus.KitaId
group by k.Adi

-- Avrupa k�tas�ndaki �lke say�s�
select k.Adi as KitaAdi, COUNT(distinct kus.UlkeId) as UlkeSayisi from Kita k inner join KitaUlkeSehir kus
on k.Id = kus.KitaId where k.Adi = 'Avrupa'
group by k.Adi

-- T�rkiye'deki �ehir say�s�
select distinct u.Adi as UlkeAdi, COUNT(distinct kus.SehirId) as SehirSayisi
from Ulke u inner join KitaUlkeSehir kus on u.Id = kus.UlkeId
where u.Adi = 'T�rkiye'
group by u.Adi

-- Avrupa k�tas�ndaki �ehir say�s�
select COUNT(distinct kus.SehirId) as AvrupaSehirSayisi from Kita k inner join KitaUlkeSehir kus 
on k.Id = kus.KitaId inner join Sehir s on kus.SehirId = s.Id
where k.Adi = 'Avrupa'

-- Avrupa k�tas�ndaki �ehirler
select s.Adi as SehirAdi from Kita k inner join KitaUlkeSehir kus 
on k.Id = kus.KitaId inner join Sehir s on kus.SehirId = s.Id
where k.Adi = 'Avrupa'

/* K�talardaki �ehir say�lar�: �stanbul hem Asya hem de Avrupa'da oldu�undan 
iki k�ta i�in de say�lmas� normal */
select k.Adi as KitaAdi, COUNT(distinct s.Adi) as SehirSayisi from Kita k inner join KitaUlkeSehir kus 
on k.Id = kus.KitaId
inner join Sehir s on kus.SehirId = s.Id
group by k.Adi

-- T�rkiye'nin Avrupa k�tas�ndaki �ehirleri
select k.Adi as KitaAdi, u.Adi as UlkeAdi, s.Adi as SehirAdi from Kita k inner join KitaUlkeSehir kus 
on k.Id = kus.KitaId
inner join Ulke u on u.Id = kus.UlkeId
inner join Sehir s on s.Id = kus.SehirId
where u.Adi = 'T�rkiye' and k.Adi = 'Avrupa'

-- T�rkiye'nin Asya k�tas�ndaki �ehirleri
select k.Adi as KitaAdi, u.Adi as UlkeAdi, s.Adi as SehirAdi from Kita k inner join KitaUlkeSehir kus 
on k.Id = kus.KitaId
inner join Ulke u on u.Id = kus.UlkeId
inner join Sehir s on s.Id = kus.SehirId
where u.Adi = 'T�rkiye' and k.Adi = 'Asya'

-- K�talara g�re �lkelerin n�fus toplamlar�
select k.Adi as KitaAdi, SUM(distinct u.Nufusu) as ToplamNufus from Kita k inner join KitaUlkeSehir kus
on k.Id = kus.KitaId inner join Ulke u on u.Id = kus.UlkeId
group by k.Adi
