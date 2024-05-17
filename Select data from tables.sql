-- Получение данных таблиц
use [online-cinema];
-- Жанры
select * from genre;

-- Получение всех фильмов
select * from content;

-- Получение стран
select * from country;

-- Получение актёров и режиссёров
select * from person;

-- Получение озвучек
select * from voiceover order by voiceover_id asc;

-- Получение пользователей
select * from [user];

-- Получение закладок пользователей
select * from bookmark order by [user_id];

-- Получение комментареив пользователей
select * from comment;

-- Получение озвучек для фильмов
select * from movie_voiceover order by voiceover_id, content_id;

-- Получение стран производства фильма
SELECT *,
       COUNT(*) OVER (PARTITION BY content_id) AS count_of_rows
FROM content_country;

-- Получение жанров фильма
select * from content_genre join genre on content_genre.genre_id = genre.genre_id where content_id = 4;

SELECT content_id as [Id фильма], genre_ru as [Название жанра],
       COUNT(*) OVER (PARTITION BY content_id) AS [Количество жанров]
FROM content_genre
inner join genre on content_genre.genre_id = genre.genre_id

-- Получение каста фильма
select count(*) from content_cast
