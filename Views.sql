use [online-cinema]
go

CREATE OR ALTER VIEW get_films AS
SELECT content.content_id [Идентификатор фильма], 
		title_ru as [Название фильма], 
		YEAR(release_date) as [Год выпуска], 
		(select top 1 country_ru from content_country join country on content_country.country_id = country.country_id where content_country.content_id = content.content_id) as [Страна производства],
		(select top 1 genre_ru from content_genre join genre on content_genre.genre_id = genre.genre_id where content_genre.content_id = content.content_id) as [Жанр фильма],
		rating_imdb
FROM content
where [type] = 'Film';
go

CREATE OR ALTER VIEW get_new_films AS
SELECT content.content_id [Идентификатор фильма], 
		title_ru as [Название фильма], 
		YEAR(release_date) as [Год выпуска], 
		(select top 1 country_ru from content_country join country on content_country.country_id = country.country_id where content_country.content_id = content.content_id) as [Страна производства],
		(select top 1 genre_ru from content_genre join genre on content_genre.genre_id = genre.genre_id where content_genre.content_id = content.content_id) as [Жанр фильма],
		rating_imdb
FROM content
where release_date > DATEADD(MONTH, -6, GETDATE()) and [type] = 'Film';
go

-- все сериалы
CREATE OR ALTER VIEW get_series AS
SELECT content.content_id [Идентификатор фильма], 
		title_ru as [Название фильма], 
		YEAR(release_date) as [Год выпуска], 
		(select top 1 country_ru from content_country join country on content_country.country_id = country.country_id where content_country.content_id = content.content_id) as [Страна производства],
		(select top 1 genre_ru from content_genre join genre on content_genre.genre_id = genre.genre_id where content_genre.content_id = content.content_id) as [Жанр фильма],
		rating_imdb
FROM content
where [type] = 'Series';
go

-- сериалы за последние пол года
CREATE OR ALTER VIEW get_new_series AS
SELECT content.content_id [Идентификатор фильма], 
		title_ru as [Название фильма], 
		YEAR(release_date) as [Год выпуска], 
		(select top 1 country_ru from content_country join country on content_country.country_id = country.country_id where content_country.content_id = content.content_id) as [Страна производства],
		(select top 1 genre_ru from content_genre join genre on content_genre.genre_id = genre.genre_id where content_genre.content_id = content.content_id) as [Жанр фильма],
		rating_imdb
FROM content
where release_date > DATEADD(MONTH, -6, GETDATE()) and [type] = 'Series';
go

-- все аниме
CREATE OR ALTER VIEW get_anime AS
SELECT content.content_id [Идентификатор фильма], 
		title_ru as [Название фильма], 
		YEAR(release_date) as [Год выпуска], 
		(select top 1 country_ru from content_country join country on content_country.country_id = country.country_id where content_country.content_id = content.content_id) as [Страна производства],
		(select top 1 genre_ru from content_genre join genre on content_genre.genre_id = genre.genre_id where content_genre.content_id = content.content_id) as [Жанр фильма],
		rating_imdb
FROM content
where [type] = 'Anime';
go

-- аниме за последние пол года
CREATE OR ALTER VIEW get_new_anime AS
SELECT content.content_id [Идентификатор фильма], 
		title_ru as [Название фильма], 
		YEAR(release_date) as [Год выпуска], 
		(select top 1 country_ru from content_country join country on content_country.country_id = country.country_id where content_country.content_id = content.content_id) as [Страна производства],
		(select top 1 genre_ru from content_genre join genre on content_genre.genre_id = genre.genre_id where content_genre.content_id = content.content_id) as [Жанр фильма],
		rating_imdb
FROM content
where release_date > DATEADD(MONTH, -6, GETDATE()) and [type] = 'Anime';
go

-- все мультфильмы
CREATE OR ALTER VIEW get_cartoons AS
SELECT content.content_id [Идентификатор фильма], 
		title_ru as [Название фильма], 
		YEAR(release_date) as [Год выпуска], 
		(select top 1 country_ru from content_country join country on content_country.country_id = country.country_id where content_country.content_id = content.content_id) as [Страна производства],
		(select top 1 genre_ru from content_genre join genre on content_genre.genre_id = genre.genre_id where content_genre.content_id = content.content_id) as [Жанр фильма],
		rating_imdb
FROM content
where [type] = 'Cartoon';
go

-- мультфильмы за последние пол года
CREATE OR ALTER VIEW get_new_cartoons AS
SELECT content.content_id [Идентификатор фильма], 
		title_ru as [Название фильма], 
		YEAR(release_date) as [Год выпуска], 
		(select top 1 country_ru from content_country join country on content_country.country_id = country.country_id where content_country.content_id = content.content_id) as [Страна производства],
		(select top 1 genre_ru from content_genre join genre on content_genre.genre_id = genre.genre_id where content_genre.content_id = content.content_id) as [Жанр фильма],
		rating_imdb
FROM content
where release_date > DATEADD(MONTH, -6, GETDATE()) and [type] = 'Cartoon';
go
