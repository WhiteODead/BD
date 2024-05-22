CREATE FUNCTION GetPersonInfo (@length INT)
RETURNS TABLE
AS
BEGIN
    DECLARE @chars VARCHAR(255) = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    DECLARE @result VARCHAR(MAX) = '';
    DECLARE @i INT = 1;

    WHILE @i <= @length
    BEGIN
        SET @result = @result + SUBSTRING(@chars, CAST((select V from dbo.vRand) * LEN(@chars) + 1 AS INT), 1);
        SET @i = @i + 1;
    END

    RETURN @result;
END;
go

CREATE OR ALTER FUNCTION dbo.GetOrderedContent
(
	@type VARCHAR(MAX)
)
RETURNS TABLE
AS
RETURN
(
	SELECT content.content_id [Идентификатор фильма], 
			title_ru as [Название фильма], 
			YEAR(release_date) as [Год выпуска], 
			(select top 1 country_ru from content_country join country on content_country.country_id = country.country_id where content_country.content_id = content.content_id) as [Страна производства],
			(select top 1 genre_ru from content_genre join genre on content_genre.genre_id = genre.genre_id where content_genre.content_id = content.content_id) as [Жанр фильма],
			rating_imdb,
			row_number() over (ORDER BY content.rating_imdb desc) as [Место в рейтинге]
	FROM content
	where [type] = @type
);
go
select * from GetOrderedContent('Anime')
go


CREATE OR ALTER FUNCTION dbo.GetContentByGenre
(
    @genreId INT,
	@type VARCHAR(MAX)
)
RETURNS TABLE
AS
RETURN
(
	SELECT content.content_id [Идентификатор фильма], 
			title_ru as [Название фильма], 
			YEAR(release_date) as [Год выпуска], 
			(select top 1 country_ru from content_country join country on content_country.country_id = country.country_id where content_country.content_id = content.content_id) as [Страна производства],
			(select top 1 genre_ru from content_genre join genre on content_genre.genre_id = genre.genre_id where content_genre.content_id = content.content_id) as [Жанр фильма],
			rating_imdb,
			row_number() over (ORDER BY content.rating_imdb desc) as [Место в рейтинге]
	FROM content join content_genre on content.content_id = content_genre.content_id
	where [type] = @type and genre_id = @genreId
);
go
select * from GetContentByGenre(100, 'Film')
go


CREATE OR ALTER FUNCTION dbo.GetContentByYear
(
    @year INT,
	@type VARCHAR(MAX)
)
RETURNS TABLE
AS
RETURN
(
	SELECT content.content_id [Идентификатор фильма], 
			title_ru as [Название фильма], 
			YEAR(release_date) as [Год выпуска], 
			(select top 1 country_ru from content_country join country on content_country.country_id = country.country_id where content_country.content_id = content.content_id) as [Страна производства],
			(select top 1 genre_ru from content_genre join genre on content_genre.genre_id = genre.genre_id where content_genre.content_id = content.content_id) as [Жанр фильма],
			rating_imdb,
			row_number() over (ORDER BY content.rating_imdb desc) as [Место в рейтинге]
	FROM content
	where [type] = @type and YEAR(content.release_date) = @year
);
go
select * from GetContentByYear(2024, 'Film')
go

CREATE OR ALTER FUNCTION dbo.GetContentByGenreAndYear
(
    @year INT,
	@genreId INT,
	@type VARCHAR(MAX)
)
RETURNS TABLE
AS
RETURN
(
	SELECT content.content_id [Идентификатор фильма], 
			title_ru as [Название фильма], 
			YEAR(release_date) as [Год выпуска], 
			(select top 1 country_ru from content_country join country on content_country.country_id = country.country_id where content_country.content_id = content.content_id) as [Страна производства],
			(select top 1 genre_ru from content_genre join genre on content_genre.genre_id = genre.genre_id where content_genre.content_id = content.content_id) as [Жанр фильма],
			rating_imdb,
			row_number() over (ORDER BY content.rating_imdb desc) as [Место в рейтинге]
	FROM content join content_genre on content.content_id = content_genre.content_id
	where [type] = @type and YEAR(content.release_date) = @year and genre_id = @genreId
);
go
select * from GetContentByGenreAndYear(2000, 100, 'Film')
go

CREATE OR ALTER FUNCTION dbo.GetContentActors
(
	@contentId INT
)
RETURNS TABLE
AS
RETURN
(
	SELECT name_ru
	FROM person join content_cast on person.person_id = content_cast.person_id
	where content_id = @contentId and name_ru like 'Актёр%'
);
go
select * from GetContentActors(1)
go

CREATE OR ALTER FUNCTION dbo.GetContentDirector
(
	@contentId INT
)
RETURNS TABLE
AS
RETURN
(
	SELECT name_ru
	FROM person join content_cast on person.person_id = content_cast.person_id
	where content_id = @contentId and name_ru like 'Режиссёр%'
);
go
select * from GetContentDirector(1)
go

CREATE OR ALTER FUNCTION dbo.GetContentComments
(
	@contentId INT
)
RETURNS TABLE
AS
RETURN
(
	SELECT *
	FROM comment
	where content_id = @contentId
);
go
select * from GetContentComments(16081)
go

