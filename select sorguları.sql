select * from film
select adi, yapimyili, gisesi from Film
select adi as [Ad�], yapimyili as [Yap�m Y�l�], gisesi as Gi�esi from [Film]
select adi as [Ad�], yapimyili as [Yap�m Y�l�], gisesi as Gi�esi from [Film] as Movie
select * from oyuncu
select '�a��l Alsa�' as �sim
select 1 as [1. Say�], 7 as [2. Say�], 1 + 7 as Toplam
select adi + ' ' + soyadi as �sim, dogumtarihi from Oyuncu
select '�a��l' + ';' + 'Alsa�'
select adi + ' ' + soyadi as �sim, CONVERT(varchar(10), dogumtarihi, 104) as dogumtarihi from Oyuncu

select GETDATE()

select CONVERT(varchar(19), GETDATE(), 113)
