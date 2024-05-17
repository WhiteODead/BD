CREATE TABLE content (
    content_id INT IDENTITY(1,1),
    title_original VARCHAR(255),
    title_ru VARCHAR(255),
    studio VARCHAR(255),
    [description] VARCHAR(MAX) NOT NULL,
    tagline VARCHAR(255),
    release_date DATE,
    age_rating VARCHAR(255) NOT NULL,
    poster VARCHAR(255) NOT NULL,
    trailer VARCHAR(255) NOT NULL,
    [type] VARCHAR(255) NOT NULL CHECK ([type] in ('Film', 'Cartoon', 'Series', 'Anime')),
    rating_imdb DECIMAL(10,2),
    rating_kinopoisk DECIMAL(10,2),
	CONSTRAINT content_pk PRIMARY KEY(content_id),
	CONSTRAINT content_age_rating_check CHECK (age_rating in ('0+', '6+', '12+', '16+', '18+')),
	CONSTRAINT content_type_check CHECK ([type] in ('Film', 'Cartoon', 'Series', 'Anime'))
);
CREATE TABLE voiceover (
    voiceover_id INT IDENTITY(1,1),
    voiceover VARCHAR(255) NOT NULL,

	CONSTRAINT voiceover_pk PRIMARY KEY(voiceover_id),
	CONSTRAINT voiceover_unique UNIQUE (voiceover)
);
CREATE TABLE series_episode (
    episode_id INT IDENTITY(1,1),
	content_id INT NOT NULL,
	voiceover_id INT NOT NULL,
    season_number INT NOT NULL,
    series_number INT NOT NULL,
    ep_name_orig VARCHAR(255),
    ep_name_ru VARCHAR(255),
    release_date DATE,
    media VARCHAR(255),

	CONSTRAINT series_episode_pk PRIMARY KEY(episode_id),
	CONSTRAINT series_episode_content_fk FOREIGN KEY (content_id) REFERENCES content (content_id),
	CONSTRAINT series_episode_voiceover_fk FOREIGN KEY (voiceover_id) REFERENCES voiceover (voiceover_id),
	CONSTRAINT series_episode_unqiue_combination UNIQUE (content_id, voiceover_id, season_number, series_number)
);
CREATE TABLE person (
    person_id INT IDENTITY(1,1),
    name_ru VARCHAR(255) NOT NULL,
    name_original VARCHAR(255) NOT NULL,
    date_of_birth DATE,
    birthplace VARCHAR(255),

	CONSTRAINT person_fk PRIMARY KEY(person_id),
);
CREATE TABLE genre (
	genre_id INT IDENTITY(1,1),
    genre_ru VARCHAR(255) NOT NULL,
    genre_en VARCHAR(255) NOT NULL,
    content_type VARCHAR(255) NOT NULL,
    [description] VARCHAR(255),

	CONSTRAINT genre_pk PRIMARY KEY(genre_id),
	CONSTRAINT genre_check_content_type CHECK (content_type in ('Film', 'Cartoon', 'Series', 'Anime')),
	CONSTRAINT genre_unique_index_ru UNIQUE (genre_ru, content_type),
	CONSTRAINT genre_unique_index_en UNIQUE (genre_en, content_type)
);

CREATE TABLE country (
	country_id INT IDENTITY(1,1),
    country_ru VARCHAR(255) NOT NULL,
    country_en VARCHAR(255) NOT NULL,

	CONSTRAINT country_pk PRIMARY KEY(country_id),
	CONSTRAINT country_ru_unique UNIQUE (country_ru),
	CONSTRAINT country_en_unique UNIQUE (country_en)
);
CREATE TABLE [user] (
    [user_id] INT IDENTITY(1,1),
    username VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    [password] VARCHAR(255) NOT NULL,
    [role] VARCHAR(255) NOT NULL,

	CONSTRAINT user_pk PRIMARY KEY([user_id]),
	CONSTRAINT user_username_unique UNIQUE (username),
	CONSTRAINT user_email_unique UNIQUE (email)
);

CREATE TABLE content_cast (
	cast_id INT IDENTITY(1, 1),
	person_id INT NOT NULL,
    content_id INT NOT NULL,
    proffession VARCHAR(255) NOT NULL,

	CONSTRAINT content_cast_pk PRIMARY KEY (cast_id),
	CONSTRAINT content_cast_person_fk FOREIGN KEY (person_id) REFERENCES person(person_id),
	CONSTRAINT content_cast_content_fk FOREIGN KEY (content_id) REFERENCES content(content_id),
	CONSTRAINT content_cast_proffession_check CHECK (proffession in ('Àêò¸ð', 'Ðåæèññ¸ð'))
);
CREATE TABLE content_genre (
	genre_id INT,
    content_id INT,

	CONSTRAINT content_genre_pk PRIMARY KEY(genre_id, content_id),
	CONSTRAINT content_genre_genre_fk FOREIGN KEY (genre_id) REFERENCES genre(genre_id),
	CONSTRAINT content_genre_content_fk FOREIGN KEY (content_id) REFERENCES content(content_id),
);
CREATE TABLE content_country (
	country_id INT,
    content_id INT,

	CONSTRAINT content_country_pk PRIMARY KEY(country_id, content_id),
	CONSTRAINT content_country_country_fk FOREIGN KEY (country_id) REFERENCES country(country_id),
	CONSTRAINT content_country_content_fk FOREIGN KEY (content_id) REFERENCES content(content_id),
);
CREATE TABLE movie_voiceover (
	voiceover_id INT,
    content_id INT,
	media VARCHAR(255) NOT NULL,

	CONSTRAINT movie_voiceover_pk PRIMARY KEY(voiceover_id, content_id),
	CONSTRAINT movie_voiceover_voiceover_fk FOREIGN KEY (voiceover_id) REFERENCES voiceover(voiceover_id),
	CONSTRAINT movie_voiceover_content_fk FOREIGN KEY (content_id) REFERENCES content(content_id),
	CONSTRAINT movie_voiceover_media_unique UNIQUE (media)
);
CREATE TABLE comment (
	comment_id INT IDENTITY(1,1),
    content_id INT NOT NULL,
	[user_id] INT NOT NULL,
	[text] VARCHAR(MAX) NOT NULL,
	date_of_publication DATETIME NOT NULL CONSTRAINT comment_date_default DEFAULT GETDATE(),

	CONSTRAINT comment_pk PRIMARY KEY(comment_id),
	CONSTRAINT comment_content_fk FOREIGN KEY (content_id) REFERENCES content(content_id),
	CONSTRAINT comment_user_fk FOREIGN KEY ([user_id]) REFERENCES [user]([user_id]),
);
CREATE TABLE bookmark (
	bookmark_id INT IDENTITY(1, 1),
    content_id INT NOT NULL,
	[user_id] INT NOT NULL,

	CONSTRAINT bookmark_pk PRIMARY KEY(bookmark_id),
	CONSTRAINT bookmark_unique_index UNIQUE (content_id, [user_id])
);
--DROP TABLE bookmark;
--DROP TABLE content_cast;
--DROP TABLE content_genre;
--DROP TABLE content_country;
--DROP TABLE series_episode;
--DROP TABLE movie_voiceover;
--DROP TABLE voiceover;
--DROP TABLE comment;

--DROP TABLE [user];
--DROP TABLE person;
--DROP TABLE genre;
--DROP TABLE country;
--DROP TABLE content;







