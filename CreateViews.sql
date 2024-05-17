--Представления
use [online-cinema]
-- Создание временной таблицы для генерации случайных значений
CREATE TABLE #temp (
    title_original VARCHAR(255),
    title_ru VARCHAR(255),
    studio VARCHAR(255),
    [description] VARCHAR(MAX),
    tagline VARCHAR(255),
    release_date DATE,
    age_rating VARCHAR(255),
    poster VARCHAR(255),
    trailer VARCHAR(255),
    [type] VARCHAR(255),
    rating_imdb DECIMAL(10,2),
    rating_kinopoisk DECIMAL(10,2)
);

-- Заполнение временной таблицы случайными данными
INSERT INTO #temp
VALUES 
    ('The Matrix', 'Матрица', 'Warner Bros.', 'Sci-fi movie', 'Reality is a thing of the past.', '1999-03-31', '18+', 'matrix_poster.jpg', 'matrix_trailer.mp4', 'Film', 8.7, 8.8),
    ('Inception', 'Начало', 'Warner Bros.', 'Sci-fi thriller', 'Your mind is the scene of the crime.', '2010-07-16', '16+', 'inception_poster.jpg', 'inception_trailer.mp4', 'Film', 8.80, 8.7),
    ('Frozen', 'Холодное сердце', 'Disney', 'Animated film', 'Experience the magic.', '2013-11-27', '0+', 'frozen_poster.jpg', 'frozen_trailer.mp4', 'Cartoon', 7.4, 7.6)
    -- Добавьте еще случайные данные сюда...
;

-- Добавление данных из временной таблицы в основную таблицу
INSERT INTO content (title_original, title_ru, studio, [description], tagline, release_date, age_rating, poster, trailer, [type], rating_imdb, rating_kinopoisk)
SELECT title_original, title_ru, studio, [description], tagline, release_date, age_rating, poster, trailer, [type], rating_imdb, rating_kinopoisk
FROM #temp;

-- Удаление временной таблицы
DROP TABLE #temp;

--добавление жанров
INSERT INTO genre (title_ru, title_en, content_type)
VALUES
    ('Боевик', 'Action', 'Film'),
    ('Комедия', 'Comedy', 'Film'),
    ('Драма', 'Drama', 'Film'),
    ('Фэнтези', 'Fantasy', 'Film'),
    ('Ужасы', 'Horror', 'Film'),
    ('Научная фантастика', 'Science Fiction', 'Film'),
    ('Триллер', 'Thriller', 'Film'),
    ('Мелодрама', 'Romance', 'Film'),
    ('Приключения', 'Adventure', 'Film'),
    ('Мультфильм', 'Animation', 'Film');

-- Добавление жанров для мультфильмов
INSERT INTO genre (title_ru, title_en, content_type)
VALUES
    ('Детский', 'Children', 'Cartoon'),
    ('Семейный', 'Family', 'Cartoon'),
    ('Фэнтези', 'Fantasy', 'Cartoon'),
    ('Приключения', 'Adventure', 'Cartoon'),
    ('Комедия', 'Comedy', 'Cartoon'),
    ('Драма', 'Drama', 'Cartoon'),
    ('Мюзикл', 'Musical', 'Cartoon'),
    ('Экшн', 'Action', 'Cartoon'),
    ('Научная фантастика', 'Science Fiction', 'Cartoon'),
    ('Мистика', 'Mystery', 'Cartoon');

-- Добавление жанров для сериалов
INSERT INTO genre (title_ru, title_en, content_type)
VALUES
    ('Драма', 'Drama', 'Series'),
    ('Комедия', 'Comedy', 'Series'),
    ('Криминал', 'Crime', 'Series'),
    ('Триллер', 'Thriller', 'Series'),
    ('Фэнтези', 'Fantasy', 'Series'),
    ('Ужасы', 'Horror', 'Series'),
    ('Научная фантастика', 'Science Fiction', 'Series'),
    ('Приключения', 'Adventure', 'Series'),
    ('Мелодрама', 'Romance', 'Series'),
    ('Документальный', 'Documentary', 'Series');

-- Добавление жанров для аниме
INSERT INTO genre (title_ru, title_en, content_type)
VALUES
    ('Боевик', 'Action', 'Anime'),
    ('Комедия', 'Comedy', 'Anime'),
    ('Драма', 'Drama', 'Anime'),
    ('Фэнтези', 'Fantasy', 'Anime'),
    ('Ужасы', 'Horror', 'Anime'),
    ('Научная фантастика', 'Science Fiction', 'Anime'),
    ('Романтика', 'Romance', 'Anime'),
    ('Приключения', 'Adventure', 'Anime'),
    ('Исторический', 'Historical', 'Anime'),
    ('Мистика', 'Mystery', 'Anime');