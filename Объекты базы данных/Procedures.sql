-- Content
CREATE OR ALTER PROCEDURE dbo.DeleteContent
    @contentId INT
AS
BEGIN
    DELETE FROM content WHERE content_id = @contentId;
END;
go

CREATE OR ALTER PROCEDURE dbo.AddContent
    @title_original VARCHAR(255),
    @title_ru VARCHAR(255),
    @studio VARCHAR(255),
    @description VARCHAR(MAX),
    @tagline VARCHAR(255),
    @release_date DATE,
    @age_rating VARCHAR(255),
    @poster VARCHAR(255),
    @trailer VARCHAR(255),
    @type VARCHAR(255),
    @rating_imdb DECIMAL(10,2),
    @rating_kinopoisk DECIMAL(10,2)
AS
BEGIN
    INSERT INTO content (title_original, title_ru, studio, [description], tagline, release_date, age_rating, poster, trailer, [type], rating_imdb, rating_kinopoisk)
    VALUES (@title_original, @title_ru, @studio, @description, @tagline, @release_date, @age_rating, @poster, @trailer, @type, @rating_imdb, @rating_kinopoisk);
END;
go
CREATE OR ALTER PROCEDURE dbo.UpdateContent
    @contentId INT,
    @title_original VARCHAR(255),
    @title_ru VARCHAR(255),
    @studio VARCHAR(255),
    @description VARCHAR(MAX),
    @tagline VARCHAR(255),
    @release_date DATE,
    @age_rating VARCHAR(255),
    @poster VARCHAR(255),
    @trailer VARCHAR(255),
    @type VARCHAR(255),
    @rating_imdb DECIMAL(10,2),
    @rating_kinopoisk DECIMAL(10,2)
AS
BEGIN
    UPDATE content
    SET title_original = @title_original,
        title_ru = @title_ru,
        studio = @studio,
        [description] = @description,
        tagline = @tagline,
        release_date = @release_date,
        age_rating = @age_rating,
        poster = @poster,
        trailer = @trailer,
        [type] = @type,
        rating_imdb = @rating_imdb,
        rating_kinopoisk = @rating_kinopoisk
    WHERE content_id = @contentId;
END;
go

-- Genre
CREATE PROCEDURE dbo.DeleteGenre
    @genreId INT
AS
BEGIN
    DELETE FROM genre WHERE genre_id = @genreId;
END;
go

CREATE PROCEDURE dbo.AddGenre
    @genreRu VARCHAR(255),
    @genreEn VARCHAR(255),
    @contentType VARCHAR(255),
    @description VARCHAR(255)
AS
BEGIN
    INSERT INTO genre (genre_ru, genre_en, content_type, [description])
    VALUES (@genreRu, @genreEn, @contentType, @description);
END;
go

CREATE PROCEDURE dbo.UpdateGenre
    @genreId INT,
    @genreRu VARCHAR(255),
    @genreEn VARCHAR(255),
    @contentType VARCHAR(255),
    @description VARCHAR(255)
AS
BEGIN
    UPDATE genre
    SET genre_ru = @genreRu,
        genre_en = @genreEn,
        content_type = @contentType,
        [description] = @description
    WHERE genre_id = @genreId;
END;
go

--Country
CREATE PROCEDURE dbo.DeleteCountry
    @countryId INT
AS
BEGIN
    DELETE FROM country WHERE country_id = @countryId;
END;
go

CREATE PROCEDURE dbo.AddCountry
    @countryRu VARCHAR(255),
    @countryEn VARCHAR(255)
AS
BEGIN
    INSERT INTO country (country_ru, country_en)
    VALUES (@countryRu, @countryEn);
END;
go

CREATE PROCEDURE dbo.UpdateCountry
    @countryId INT,
    @countryRu VARCHAR(255),
    @countryEn VARCHAR(255)
AS
BEGIN
    UPDATE country
    SET country_ru = @countryRu,
        country_en = @countryEn
    WHERE country_id = @countryId;
END;
go

-- Person
CREATE PROCEDURE dbo.DeletePerson
    @personId INT
AS
BEGIN
    DELETE FROM person WHERE person_id = @personId;
END;
go

CREATE PROCEDURE dbo.AddPerson
    @nameRu VARCHAR(255),
    @nameOriginal VARCHAR(255),
    @dateOfBirth DATE,
    @birthplace VARCHAR(255)
AS
BEGIN
    INSERT INTO person (name_ru, name_original, date_of_birth, birthplace)
    VALUES (@nameRu, @nameOriginal, @dateOfBirth, @birthplace);
END;
go

CREATE PROCEDURE dbo.UpdatePerson
    @personId INT,
    @nameRu VARCHAR(255),
    @nameOriginal VARCHAR(255),
    @dateOfBirth DATE,
    @birthplace VARCHAR(255)
AS
BEGIN
    UPDATE person
    SET name_ru = @nameRu,
        name_original = @nameOriginal,
        date_of_birth = @dateOfBirth,
        birthplace = @birthplace
    WHERE person_id = @personId;
END;
go

-- Voiceover

CREATE PROCEDURE dbo.DeleteVoiceover
    @voiceoverId INT
AS
BEGIN
    DELETE FROM voiceover WHERE voiceover_id = @voiceoverId;
END;
go

CREATE PROCEDURE dbo.AddVoiceover
    @voiceover VARCHAR(255)
AS
BEGIN
    INSERT INTO voiceover (voiceover)
    VALUES (@voiceover);
END;
go

CREATE PROCEDURE dbo.UpdateVoiceover
    @voiceoverId INT,
    @voiceover VARCHAR(255)
AS
BEGIN
    UPDATE voiceover
    SET voiceover = @voiceover
    WHERE voiceover_id = @voiceoverId;
END;
go

-- User
CREATE PROCEDURE dbo.DeleteUser
    @userId INT
AS
BEGIN
    DELETE FROM [user] WHERE [user_id] = @userId;
END;
go

CREATE PROCEDURE dbo.AddUser
    @username VARCHAR(255),
    @email VARCHAR(255),
    @password VARCHAR(255),
    @role VARCHAR(255)
AS
BEGIN
    INSERT INTO [user] (username, email, [password], [role])
    VALUES (@username, @email, @password, @role);
END;
go

CREATE PROCEDURE dbo.UpdateUser
    @userId INT,
    @username VARCHAR(255),
    @email VARCHAR(255),
    @password VARCHAR(255),
    @role VARCHAR(255)
AS
BEGIN
    UPDATE [user]
    SET username = @username,
        email = @email,
        [password] = @password,
        [role] = @role
    WHERE [user_id] = @userId;
END;
go

--bookmark

CREATE PROCEDURE dbo.DeleteBookmark
    @bookmarkId INT
AS
BEGIN
    DELETE FROM bookmark WHERE bookmark_id = @bookmarkId;
END;
go

CREATE PROCEDURE dbo.AddBookmark
    @contentId INT,
    @userId INT
AS
BEGIN
    INSERT INTO bookmark (content_id, [user_id])
    VALUES (@contentId, @userId);
END;
go

CREATE PROCEDURE dbo.UpdateBookmark
    @bookmarkId INT,
    @contentId INT,
    @userId INT
AS
BEGIN
    UPDATE bookmark
    SET content_id = @contentId,
        [user_id] = @userId
    WHERE bookmark_id = @bookmarkId;
END;
go

-- Comment

CREATE PROCEDURE dbo.DeleteComment
    @commentId INT
AS
BEGIN
    DELETE FROM comment WHERE comment_id = @commentId;
END;
go

CREATE PROCEDURE dbo.AddComment
    @contentId INT,
    @userId INT,
    @text VARCHAR(MAX),
    @dateOfPublication DATETIME
AS
BEGIN
    INSERT INTO comment (content_id, [user_id], [text], date_of_publication)
    VALUES (@contentId, @userId, @text, @dateOfPublication);
END;
go

CREATE PROCEDURE dbo.UpdateComment
    @commentId INT,
    @contentId INT,
    @userId INT,
    @text VARCHAR(MAX),
    @dateOfPublication DATETIME
AS
BEGIN
    UPDATE comment
    SET content_id = @contentId,
        [user_id] = @userId,
        [text] = @text,
        date_of_publication = @dateOfPublication
    WHERE comment_id = @commentId;
END;
go

--movie_voice_over
CREATE PROCEDURE dbo.DeleteMovieVoiceover
    @voiceoverId INT,
    @contentId INT
AS
BEGIN
    DELETE FROM movie_voiceover WHERE voiceover_id = @voiceoverId AND content_id = @contentId;
END;
go

CREATE PROCEDURE dbo.AddMovieVoiceover
    @voiceoverId INT,
    @contentId INT,
    @media VARCHAR(255)
AS
BEGIN
    INSERT INTO movie_voiceover (voiceover_id, content_id, media)
    VALUES (@voiceoverId, @contentId, @media);
END;
go

CREATE PROCEDURE dbo.UpdateMovieVoiceover
    @voiceoverId INT,
    @contentId INT,
    @media VARCHAR(255)
AS
BEGIN
    UPDATE movie_voiceover
    SET media = @media
    WHERE voiceover_id = @voiceoverId AND content_id = @contentId;
END;
go

-- content_country

CREATE PROCEDURE dbo.DeleteContentCountry
    @countryId INT,
    @contentId INT
AS
BEGIN
    DELETE FROM content_country WHERE country_id = @countryId AND content_id = @contentId;
END;
go

CREATE PROCEDURE dbo.AddContentCountry
    @countryId INT,
    @contentId INT
AS
BEGIN
    INSERT INTO content_country (country_id, content_id)
    VALUES (@countryId, @contentId);
END;
go

-- content_genre

CREATE PROCEDURE dbo.DeleteContentGenre
    @genreId INT,
    @contentId INT
AS
BEGIN
    DELETE FROM content_genre WHERE genre_id = @genreId AND content_id = @contentId;
END;
go

CREATE PROCEDURE dbo.AddContentGenre
    @genreId INT,
    @contentId INT
AS
BEGIN
    INSERT INTO content_genre (genre_id, content_id)
    VALUES (@genreId, @contentId);
END;
go

--content_cast

CREATE PROCEDURE dbo.DeleteContentCast
    @castId INT
AS
BEGIN
    DELETE FROM content_cast WHERE cast_id = @castId;
END;
go

CREATE PROCEDURE dbo.AddContentCast
    @personId INT,
    @contentId INT,
    @profession VARCHAR(255)
AS
BEGIN
    INSERT INTO content_cast (person_id, content_id, proffession)
    VALUES (@personId, @contentId, @profession);
END;
go

CREATE PROCEDURE dbo.UpdateContentCast
    @castId INT,
    @personId INT,
    @contentId INT,
    @profession VARCHAR(255)
AS
BEGIN
    UPDATE content_cast
    SET person_id = @personId,
        content_id = @contentId,
        proffession = @profession
    WHERE cast_id = @castId;
END;
go

CREATE OR ALTER PROCEDURE SendMessageToEmail
    @recipients NVARCHAR(MAX),
    @subject NVARCHAR(255),
    @body NVARCHAR(MAX)
AS
BEGIN
    EXEC msdb.dbo.sp_send_dbmail
        @profile_name = 'Профиль 1',
        @recipients = @recipients,
        @subject = @subject,
        @body = @body;
END;
go