use [online-cinema]
go

CREATE OR ALTER VIEW get_films AS
SELECT content.content_id [������������� ������], 
		title_ru as [�������� ������], 
		YEAR(release_date) as [��� �������], 
		(select top 1 country_ru from content_country join country on content_country.country_id = country.country_id where content_country.content_id = content.content_id) as [������ ������������],
		(select top 1 genre_ru from content_genre join genre on content_genre.genre_id = genre.genre_id where content_genre.content_id = content.content_id) as [���� ������],
		rating_imdb
FROM content
where [type] = 'Film';
go

CREATE OR ALTER VIEW get_new_films AS
SELECT content.content_id [������������� ������], 
		title_ru as [�������� ������], 
		YEAR(release_date) as [��� �������], 
		(select top 1 country_ru from content_country join country on content_country.country_id = country.country_id where content_country.content_id = content.content_id) as [������ ������������],
		(select top 1 genre_ru from content_genre join genre on content_genre.genre_id = genre.genre_id where content_genre.content_id = content.content_id) as [���� ������],
		rating_imdb
FROM content
where release_date > DATEADD(MONTH, -6, GETDATE()) and [type] = 'Film';
go

-- ��� �������
CREATE OR ALTER VIEW get_series AS
SELECT content.content_id [������������� ������], 
		title_ru as [�������� ������], 
		YEAR(release_date) as [��� �������], 
		(select top 1 country_ru from content_country join country on content_country.country_id = country.country_id where content_country.content_id = content.content_id) as [������ ������������],
		(select top 1 genre_ru from content_genre join genre on content_genre.genre_id = genre.genre_id where content_genre.content_id = content.content_id) as [���� ������],
		rating_imdb
FROM content
where [type] = 'Series';
go

-- ������� �� ��������� ��� ����
CREATE OR ALTER VIEW get_new_series AS
SELECT content.content_id [������������� ������], 
		title_ru as [�������� ������], 
		YEAR(release_date) as [��� �������], 
		(select top 1 country_ru from content_country join country on content_country.country_id = country.country_id where content_country.content_id = content.content_id) as [������ ������������],
		(select top 1 genre_ru from content_genre join genre on content_genre.genre_id = genre.genre_id where content_genre.content_id = content.content_id) as [���� ������],
		rating_imdb
FROM content
where release_date > DATEADD(MONTH, -6, GETDATE()) and [type] = 'Series';
go

-- ��� �����
CREATE OR ALTER VIEW get_anime AS
SELECT content.content_id [������������� ������], 
		title_ru as [�������� ������], 
		YEAR(release_date) as [��� �������], 
		(select top 1 country_ru from content_country join country on content_country.country_id = country.country_id where content_country.content_id = content.content_id) as [������ ������������],
		(select top 1 genre_ru from content_genre join genre on content_genre.genre_id = genre.genre_id where content_genre.content_id = content.content_id) as [���� ������],
		rating_imdb
FROM content
where [type] = 'Anime';
go

-- ����� �� ��������� ��� ����
CREATE OR ALTER VIEW get_new_anime AS
SELECT content.content_id [������������� ������], 
		title_ru as [�������� ������], 
		YEAR(release_date) as [��� �������], 
		(select top 1 country_ru from content_country join country on content_country.country_id = country.country_id where content_country.content_id = content.content_id) as [������ ������������],
		(select top 1 genre_ru from content_genre join genre on content_genre.genre_id = genre.genre_id where content_genre.content_id = content.content_id) as [���� ������],
		rating_imdb
FROM content
where release_date > DATEADD(MONTH, -6, GETDATE()) and [type] = 'Anime';
go

-- ��� �����������
CREATE OR ALTER VIEW get_cartoons AS
SELECT content.content_id [������������� ������], 
		title_ru as [�������� ������], 
		YEAR(release_date) as [��� �������], 
		(select top 1 country_ru from content_country join country on content_country.country_id = country.country_id where content_country.content_id = content.content_id) as [������ ������������],
		(select top 1 genre_ru from content_genre join genre on content_genre.genre_id = genre.genre_id where content_genre.content_id = content.content_id) as [���� ������],
		rating_imdb
FROM content
where [type] = 'Cartoon';
go

-- ����������� �� ��������� ��� ����
CREATE OR ALTER VIEW get_new_cartoons AS
SELECT content.content_id [������������� ������], 
		title_ru as [�������� ������], 
		YEAR(release_date) as [��� �������], 
		(select top 1 country_ru from content_country join country on content_country.country_id = country.country_id where content_country.content_id = content.content_id) as [������ ������������],
		(select top 1 genre_ru from content_genre join genre on content_genre.genre_id = genre.genre_id where content_genre.content_id = content.content_id) as [���� ������],
		rating_imdb
FROM content
where release_date > DATEADD(MONTH, -6, GETDATE()) and [type] = 'Cartoon';
go
