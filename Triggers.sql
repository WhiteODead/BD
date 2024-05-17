CREATE TRIGGER CheckBookmarkCount
ON bookmark
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @userId INT;
    SELECT @userId = [user_id] FROM inserted;

    IF (SELECT COUNT(*) FROM bookmark WHERE [user_id] = @userId) > 100
    BEGIN
        Print('У одного пользователя не может быть больше 100 закладок');
        ROLLBACK TRANSACTION;
    END
END;
go

CREATE TRIGGER CheckReleaseDate
ON content
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted WHERE release_date > GETDATE())
    BEGIN
        Print('Дата выхода не может быть позже текущей даты');
        ROLLBACK TRANSACTION;
    END;
END;
go

CREATE TRIGGER DeleteUserBookmarks
ON [user]
AFTER DELETE
AS
BEGIN
    DELETE FROM bookmark WHERE [user_id] IN (SELECT user_id FROM deleted);
END;
go

CREATE TRIGGER CheckMovieVoiceoverCount
ON movie_voiceover
AFTER INSERT, UPDATE
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM content c LEFT JOIN movie_voiceover mv ON c.content_id = mv.content_id WHERE mv.content_id IS NULL)
    BEGIN 
        Print('Каждый фильм должен иметь хотя бы 1 озвучку');
        ROLLBACK TRANSACTION;
    END;
END;
go

CREATE TRIGGER CheckCommentLength
ON comment
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted WHERE LEN([text]) > 255)
    BEGIN
        Print('Максимальная длинна комментария 255 символов');
        ROLLBACK TRANSACTION;
    END;
END;
go