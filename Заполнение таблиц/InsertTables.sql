CREATE VIEW dbo.vRand(V) AS SELECT RAND();
go

CREATE FUNCTION dbo.GenerateRandomString (@length INT)
RETURNS VARCHAR(MAX)
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


DECLARE @counter INT = 1;

WHILE @counter <= 100000
BEGIN
    INSERT INTO content (title_original, title_ru, studio, [description], tagline, release_date, age_rating, poster, trailer, [type], rating_imdb, rating_kinopoisk)
    VALUES (
        dbo.GenerateRandomString(50), -- title_original
        dbo.GenerateRandomString(50), -- title_ru
        dbo.GenerateRandomString(50), -- studio
        dbo.GenerateRandomString(500), -- [description]
        dbo.GenerateRandomString(50), -- tagline
        DATEADD(day, -CAST(RAND() * 365 * 30 AS INT), GETDATE()), -- release_date (последние 30 лет)
        CASE 
            WHEN RAND() < 0.2 THEN '0+'
            WHEN RAND() < 0.4 THEN '6+'
            WHEN RAND() < 0.6 THEN '12+'
            WHEN RAND() < 0.8 THEN '16+'
            ELSE '18+'
        END, -- age_rating
        dbo.GenerateRandomString(255), -- poster
        dbo.GenerateRandomString(255), -- trailer
        CASE 
            WHEN RAND() < 0.25 THEN 'Film'
            WHEN RAND() < 0.5 THEN 'Cartoon'
            WHEN RAND() < 0.75 THEN 'Series'
            ELSE 'Anime'
        END, -- [type]
        RAND() * 10, -- rating_imdb
        RAND() * 10 -- rating_kinopoisk
    );

    SET @counter = @counter + 1;
END;
go

CREATE PROCEDURE dbo.UpdateTitles
AS
BEGIN
    DECLARE @content_id INT;
    DECLARE @title_original VARCHAR(255);
    DECLARE @title_ru VARCHAR(255);
    
    DECLARE content_cursor CURSOR FOR
    SELECT content_id
    FROM content;
    
    OPEN content_cursor;
    
    FETCH NEXT FROM content_cursor INTO @content_id;
    
    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @title_original = 'Film' + CAST(@content_id AS VARCHAR(10));
        SET @title_ru = 'Фильм' + CAST(@content_id AS VARCHAR(10));
        
        UPDATE content
        SET title_original = @title_original,
            title_ru = @title_ru
        WHERE content_id = @content_id;
        
        FETCH NEXT FROM content_cursor INTO @content_id;
    END
    
    CLOSE content_cursor;
    DEALLOCATE content_cursor;
END;
go
EXEC dbo.UpdateTitles;
go

CREATE PROCEDURE dbo.FillPersonTable
AS
BEGIN
    DECLARE @actorCounter INT = 1;
    DECLARE @directorCounter INT = 1;
    DECLARE @totalActors INT = 5000;
    DECLARE @totalDirectors INT = 200;
    DECLARE @country_id INT;
    DECLARE @birthplace VARCHAR(255);
    WHILE @actorCounter <= @totalActors
    BEGIN
        SELECT TOP 1 @country_id = country_id FROM country ORDER BY NEWID();
        SELECT @birthplace = country_ru FROM country WHERE country_id = @country_id;
        
        INSERT INTO person (name_ru, name_original, date_of_birth, birthplace)
        VALUES (
            'Актёр' + CAST(@actorCounter AS VARCHAR(10)),
            'Actor' + CAST(@actorCounter AS VARCHAR(10)),
            DATEADD(year, -ROUND(RAND() * 70, -1), GETDATE()), 
            @birthplace
        );

        SET @actorCounter = @actorCounter + 1;
    END;
    
    WHILE @directorCounter <= @totalDirectors
    BEGIN
        SELECT TOP 1 @country_id = country_id FROM country ORDER BY NEWID();
        SELECT @birthplace = country_ru FROM country WHERE country_id = @country_id;
        
        INSERT INTO person (name_ru, name_original, date_of_birth, birthplace)
        VALUES (
            'Режиссёр' + CAST(@directorCounter AS VARCHAR(10)),
            'Director' + CAST(@directorCounter AS VARCHAR(10)),
            DATEADD(year, -ROUND(RAND() * 70, -1), GETDATE()), 
            @birthplace
        );

        SET @directorCounter = @directorCounter + 1;
    END;
END;
go
EXEC dbo.FillPersonTable;
go

CREATE PROCEDURE dbo.FillUserTable
AS
BEGIN
    DECLARE @counter INT = 1;
    DECLARE @totalUsers INT = 10000;
    
    WHILE @counter <= @totalUsers
    BEGIN
        DECLARE @username VARCHAR(255);
        DECLARE @email VARCHAR(255);
        DECLARE @password VARCHAR(255);
        DECLARE @role VARCHAR(255);
        
        SET @username = 'User' + CAST(@counter AS VARCHAR(10));
        SET @email = 'user' + CAST(@counter AS VARCHAR(10)) + '@example.com';
        SET @password = 'password' + CAST(@counter AS VARCHAR(10));
        
        IF @counter % 10 = 0
            SET @role = 'Administrator';
        ELSE IF @counter % 5 = 0
            SET @role = 'Moderator';
        ELSE
            SET @role = 'User';
        
        INSERT INTO [user] (username, email, [password], [role])
        VALUES (@username, @email, @password, @role);
        
        SET @counter = @counter + 1;
    END;
END;
go
EXEC dbo.FillUserTable;
go


CREATE OR ALTER PROCEDURE dbo.FillBookmarkTable
AS
BEGIN
    DECLARE @userId INT = 1;
    DECLARE @totalUsers INT = 1000;
    
    WHILE @userId <= @totalUsers
    BEGIN
        DECLARE @numBookmarks INT = ROUND(RAND() * 5, 0) + 2; 
        
        DECLARE @bookmarkCounter INT = 1;
        
        WHILE @bookmarkCounter <= @numBookmarks
        BEGIN
            DECLARE @contentId INT;
            DECLARE @existingContentIds TABLE (content_id INT);
            
            INSERT INTO @existingContentIds (content_id)
            SELECT TOP 1 content_id FROM content ORDER BY NEWID();
            
            SELECT @contentId = content_id FROM @existingContentIds;
            
            INSERT INTO bookmark (content_id, [user_id])
            VALUES (@contentId, @userId);
            
            SET @bookmarkCounter = @bookmarkCounter + 1;
        END;
        
        SET @userId = @userId + 1;
    END;
END;
go
EXEC dbo.FillBookmarkTable;
go


CREATE PROCEDURE dbo.FillCommentTable
AS
BEGIN
    DECLARE @totalUsers INT = 500;
    DECLARE @totalComments INT = 3000;
    DECLARE @userCounter INT = 1;
    DECLARE @commentCounter INT = 1;

    WHILE @commentCounter <= @totalComments
    BEGIN
        DECLARE @contentId INT;
        DECLARE @userId INT;

        SELECT TOP 1 @contentId = content_id FROM content ORDER BY NEWID();
        
        SELECT TOP 1 @userId = user_id FROM [user] ORDER BY NEWID();
        
        DECLARE @numComments INT = ROUND(RAND() * 3, 0) + 1;
        DECLARE @commentCounterInner INT = 1;

        WHILE @commentCounterInner <= @numComments
        BEGIN
            DECLARE @commentText VARCHAR(MAX);
            SET @commentText = 'Это случайный комментарий ' + CAST(@commentCounter AS VARCHAR(10));

            INSERT INTO comment (content_id, [user_id], [text])
            VALUES (@contentId, @userId, @commentText);
            
            SET @commentCounterInner = @commentCounterInner + 1;
            SET @commentCounter = @commentCounter + 1;
        END;

        SET @commentCounter = @commentCounter + 1;
    END;
END;
go
EXEC dbo.FillCommentTable;
go


CREATE OR ALTER PROCEDURE dbo.FillMovieVoiceoverTable
AS
BEGIN
    DECLARE @contentId INT;
    DECLARE content_cursor CURSOR FOR
    SELECT content_id FROM content;
    
    OPEN content_cursor;
    
    FETCH NEXT FROM content_cursor INTO @contentId;
    
    WHILE @@FETCH_STATUS = 0
    BEGIN
        DECLARE @numVoiceovers INT = ROUND(RAND() * 4, 0) + 1;
		DECLARE @voiceoverCounter INT = 1;
        WHILE @voiceoverCounter <= @numVoiceovers
        BEGIN
            DECLARE @voiceoverId INT;
            DECLARE @media VARCHAR(255);
            
            SELECT TOP 1 @voiceoverId = voiceover_id FROM voiceover ORDER BY NEWID();
            SET @media = dbo.GenerateRandomString(50);
            
            INSERT INTO movie_voiceover (voiceover_id, content_id, media)
            VALUES (@voiceoverId, @contentId, @media);

			SET @voiceoverCounter = @voiceoverCounter + 1;
        END;
        
        FETCH NEXT FROM content_cursor INTO @contentId;
    END;
    
    CLOSE content_cursor;
    DEALLOCATE content_cursor;
END;
go
EXEC dbo.FillMovieVoiceoverTable;
go


CREATE OR ALTER PROCEDURE dbo.FillContentCountryTable
AS
BEGIN
    DECLARE @contentId INT;
    
    DECLARE content_cursor CURSOR FOR
    SELECT content_id FROM content;
    
    OPEN content_cursor;
    
    FETCH NEXT FROM content_cursor INTO @contentId;
    
    WHILE @@FETCH_STATUS = 0
    BEGIN
        DECLARE @numCountries INT = ROUND(RAND() * 3, 0) + 1;
        
        DECLARE @countryCounter INT = 1;
        
        WHILE @countryCounter <= @numCountries
        BEGIN
            DECLARE @countryId INT;
            
            SELECT TOP 1 @countryId = country_id FROM country ORDER BY NEWID();
            
            INSERT INTO content_country (country_id, content_id)
            VALUES (@countryId, @contentId);
            
            SET @countryCounter = @countryCounter + 1;
        END;
        
        FETCH NEXT FROM content_cursor INTO @contentId;
    END;
    
    CLOSE content_cursor;
    DEALLOCATE content_cursor;
END;
go
EXEC dbo.FillContentCountryTable;
go


CREATE OR ALTER PROCEDURE dbo.FillContentGenreTable
AS
BEGIN
    DECLARE @contentId INT;
    
    DECLARE content_cursor CURSOR FOR
    SELECT content_id FROM content;
    
    OPEN content_cursor;
    
    FETCH NEXT FROM content_cursor INTO @contentId;
    
    WHILE @@FETCH_STATUS = 0
    BEGIN
        DECLARE @numGenres INT = ROUND(RAND() * 2, 0) + 3;
        
        DECLARE @genreCounter INT = 1;
        
        WHILE @genreCounter <= @numGenres
        BEGIN
            DECLARE @genreId INT;
            
            SELECT TOP 1 @genreId = genre_id 
            FROM genre 
            WHERE content_type = (SELECT [type] FROM content WHERE content_id = @contentId) 
            ORDER BY NEWID();
            
            INSERT INTO content_genre (genre_id, content_id)
            VALUES (@genreId, @contentId);
            
            SET @genreCounter = @genreCounter + 1;
        END;
        
        FETCH NEXT FROM content_cursor INTO @contentId;
    END;
    
    CLOSE content_cursor;
    DEALLOCATE content_cursor;
END;
go
EXEC dbo.FillContentGenreTable;
go

CREATE OR ALTER PROCEDURE dbo.FillContentCastTable
AS
BEGIN
    DECLARE @contentId INT;
    
    DECLARE content_cursor CURSOR FOR
    SELECT content_id FROM content;
    
    OPEN content_cursor;
    
    FETCH NEXT FROM content_cursor INTO @contentId;
    
    WHILE @@FETCH_STATUS = 0
    BEGIN
        DECLARE @personId INT;
        DECLARE @actorCounter INT = 1;
        
        WHILE @actorCounter <= 10
        BEGIN
            SELECT TOP 1 @personId = person_id FROM person WHERE name_ru like '%Актёр%' ORDER BY NEWID();
            
            INSERT INTO content_cast (person_id, content_id, [proffession])
            VALUES (@personId, @contentId, 'Актёр');
            
            SET @actorCounter = @actorCounter + 1;
        END;
        
        DECLARE @directorId INT;
        
        SELECT TOP 1 @directorId = person_id FROM person WHERE name_ru like '%Режиссёр%' ORDER BY NEWID();
        
        INSERT INTO content_cast (person_id, content_id, proffession)
        VALUES (@directorId, @contentId, 'Режиссёр');
        
        FETCH NEXT FROM content_cursor INTO @contentId;
    END;
    
    CLOSE content_cursor;
    DEALLOCATE content_cursor;
END;
go
EXEC dbo.FillContentCastTable;
go
