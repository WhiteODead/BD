CREATE ROLE Administrator;
CREATE ROLE [User];
CREATE ROLE UnauthorizedUser;

GRANT SELECT, INSERT, UPDATE, DELETE ON content TO Administrator;
GRANT SELECT, INSERT, UPDATE, DELETE ON bookmark TO Administrator;
GRANT SELECT, INSERT, UPDATE, DELETE ON comment TO Administrator;
GRANT SELECT, INSERT, UPDATE, DELETE ON content TO Administrator;
GRANT SELECT, INSERT, UPDATE, DELETE ON content_cast TO Administrator;
GRANT SELECT, INSERT, UPDATE, DELETE ON content_country TO Administrator;
GRANT SELECT, INSERT, UPDATE, DELETE ON content_genre TO Administrator;
GRANT SELECT, INSERT, UPDATE, DELETE ON genre TO Administrator;
GRANT SELECT, INSERT, UPDATE, DELETE ON country TO Administrator;
GRANT SELECT, INSERT, UPDATE, DELETE ON movie_voiceover TO Administrator;
GRANT SELECT, INSERT, UPDATE, DELETE ON person TO Administrator;
GRANT SELECT, INSERT, UPDATE, DELETE ON series_episode TO Administrator;
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.[user] TO Administrator;
GRANT SELECT, INSERT, UPDATE, DELETE ON voiceover TO Administrator;
GRANT SELECT ON dbo.GetOrderedContent TO Administrator;
GRANT SELECT ON dbo.GetContentByGenre TO Administrator;
GRANT SELECT ON dbo.GetContentByYear TO Administrator;
GRANT SELECT ON dbo.GetContentByGenreAndYear TO Administrator;
GRANT SELECT ON dbo.GetContentActors TO Administrator;
GRANT SELECT ON dbo.GetContentDirector TO Administrator;
GRANT SELECT ON dbo.GetContentComments TO Administrator;

GRANT EXECUTE ON dbo.DeleteContent TO Administrator;
GRANT EXECUTE ON dbo.AddContent TO Administrator;
GRANT EXECUTE ON dbo.UpdateContent TO Administrator;

GRANT EXECUTE ON dbo.DeleteGenre TO Administrator;
GRANT EXECUTE ON dbo.AddGenre TO Administrator;
GRANT EXECUTE ON dbo.UpdateGenre TO Administrator;

GRANT EXECUTE ON dbo.DeleteCountry TO Administrator;
GRANT EXECUTE ON dbo.AddCountry TO Administrator;
GRANT EXECUTE ON dbo.UpdateCountry TO Administrator;

GRANT EXECUTE ON dbo.DeletePerson TO Administrator;
GRANT EXECUTE ON dbo.AddPerson TO Administrator;
GRANT EXECUTE ON dbo.UpdatePerson TO Administrator;

GRANT EXECUTE ON dbo.DeleteVoiceover TO Administrator;
GRANT EXECUTE ON dbo.AddVoiceover TO Administrator;
GRANT EXECUTE ON dbo.UpdateVoiceover TO Administrator;

GRANT EXECUTE ON dbo.DeleteUser TO Administrator;
GRANT EXECUTE ON dbo.AddUser TO Administrator;
GRANT EXECUTE ON dbo.UpdateUser TO Administrator;

GRANT EXECUTE ON dbo.DeleteBookmark TO Administrator;
GRANT EXECUTE ON dbo.AddBookmark TO Administrator;
GRANT EXECUTE ON dbo.UpdateBookmark TO Administrator;

GRANT EXECUTE ON dbo.DeleteComment TO Administrator;
GRANT EXECUTE ON dbo.AddComment TO Administrator;
GRANT EXECUTE ON dbo.UpdateComment TO Administrator;

GRANT EXECUTE ON dbo.DeleteMovieVoiceover TO Administrator;
GRANT EXECUTE ON dbo.AddMovieVoiceover TO Administrator;
GRANT EXECUTE ON dbo.UpdateMovieVoiceover TO Administrator;


DENY SELECT ON content TO [User];
DENY SELECT ON content TO [User];
DENY SELECT ON content TO [User];
DENY SELECT ON bookmark TO [User];
DENY SELECT ON comment TO [User];
DENY SELECT ON content TO [User];
DENY SELECT  ON content_cast TO [User];
DENY SELECT  ON content_country TO [User];
DENY SELECT  ON content_genre TO [User];
DENY SELECT  ON genre TO [User];
DENY SELECT  ON country TO [User];
DENY SELECT  ON movie_voiceover TO [User];
DENY SELECT  ON person TO [User];
DENY SELECT  ON series_episode TO [User];
DENY SELECT ON dbo.[user] TO [User];
DENY SELECT  ON voiceover TO [User];



DENY SELECT ON content TO UnauthorizedUser;
DENY SELECT ON content TO UnauthorizedUser;
DENY SELECT ON bookmark TO UnauthorizedUser;
DENY SELECT ON comment TO UnauthorizedUser;
DENY SELECT ON content TO UnauthorizedUser;
DENY SELECT  ON content_cast TO UnauthorizedUser;
DENY SELECT  ON content_country TO UnauthorizedUser;
DENY SELECT  ON content_genre TO UnauthorizedUser;
DENY SELECT  ON genre TO UnauthorizedUser;
DENY SELECT  ON country TO UnauthorizedUser;
DENY SELECT  ON movie_voiceover TO UnauthorizedUser;
DENY SELECT  ON person TO UnauthorizedUser;
DENY SELECT  ON series_episode TO UnauthorizedUser;
DENY SELECT ON dbo.[user] TO UnauthorizedUser;
DENY SELECT  ON voiceover TO UnauthorizedUser;


CREATE LOGIN AdminUser WITH PASSWORD = 'AdminPassword';
CREATE USER AdminUser FOR LOGIN AdminUser;
ALTER ROLE Administrator ADD MEMBER AdminUser;

CREATE LOGIN RegularUser WITH PASSWORD = 'UserPassword';
CREATE USER RegularUser FOR LOGIN RegularUser;
ALTER ROLE [User] ADD MEMBER RegularUser;

CREATE LOGIN UnauthorizedUserA WITH PASSWORD = 'GuestPassword';
CREATE USER UnauthorizedUserA FOR LOGIN UnauthorizedUserA;
ALTER ROLE UnauthorizedUser ADD MEMBER UnauthorizedUseA;