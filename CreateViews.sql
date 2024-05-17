--�������������
use [online-cinema]
-- �������� ��������� ������� ��� ��������� ��������� ��������
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

-- ���������� ��������� ������� ���������� �������
INSERT INTO #temp
VALUES 
    ('The Matrix', '�������', 'Warner Bros.', 'Sci-fi movie', 'Reality is a thing of the past.', '1999-03-31', '18+', 'matrix_poster.jpg', 'matrix_trailer.mp4', 'Film', 8.7, 8.8),
    ('Inception', '������', 'Warner Bros.', 'Sci-fi thriller', 'Your mind is the scene of the crime.', '2010-07-16', '16+', 'inception_poster.jpg', 'inception_trailer.mp4', 'Film', 8.80, 8.7),
    ('Frozen', '�������� ������', 'Disney', 'Animated film', 'Experience the magic.', '2013-11-27', '0+', 'frozen_poster.jpg', 'frozen_trailer.mp4', 'Cartoon', 7.4, 7.6)
    -- �������� ��� ��������� ������ ����...
;

-- ���������� ������ �� ��������� ������� � �������� �������
INSERT INTO content (title_original, title_ru, studio, [description], tagline, release_date, age_rating, poster, trailer, [type], rating_imdb, rating_kinopoisk)
SELECT title_original, title_ru, studio, [description], tagline, release_date, age_rating, poster, trailer, [type], rating_imdb, rating_kinopoisk
FROM #temp;

-- �������� ��������� �������
DROP TABLE #temp;

--���������� ������
INSERT INTO genre (title_ru, title_en, content_type)
VALUES
    ('������', 'Action', 'Film'),
    ('�������', 'Comedy', 'Film'),
    ('�����', 'Drama', 'Film'),
    ('�������', 'Fantasy', 'Film'),
    ('�����', 'Horror', 'Film'),
    ('������� ����������', 'Science Fiction', 'Film'),
    ('�������', 'Thriller', 'Film'),
    ('���������', 'Romance', 'Film'),
    ('�����������', 'Adventure', 'Film'),
    ('����������', 'Animation', 'Film');

-- ���������� ������ ��� ������������
INSERT INTO genre (title_ru, title_en, content_type)
VALUES
    ('�������', 'Children', 'Cartoon'),
    ('��������', 'Family', 'Cartoon'),
    ('�������', 'Fantasy', 'Cartoon'),
    ('�����������', 'Adventure', 'Cartoon'),
    ('�������', 'Comedy', 'Cartoon'),
    ('�����', 'Drama', 'Cartoon'),
    ('������', 'Musical', 'Cartoon'),
    ('����', 'Action', 'Cartoon'),
    ('������� ����������', 'Science Fiction', 'Cartoon'),
    ('�������', 'Mystery', 'Cartoon');

-- ���������� ������ ��� ��������
INSERT INTO genre (title_ru, title_en, content_type)
VALUES
    ('�����', 'Drama', 'Series'),
    ('�������', 'Comedy', 'Series'),
    ('��������', 'Crime', 'Series'),
    ('�������', 'Thriller', 'Series'),
    ('�������', 'Fantasy', 'Series'),
    ('�����', 'Horror', 'Series'),
    ('������� ����������', 'Science Fiction', 'Series'),
    ('�����������', 'Adventure', 'Series'),
    ('���������', 'Romance', 'Series'),
    ('��������������', 'Documentary', 'Series');

-- ���������� ������ ��� �����
INSERT INTO genre (title_ru, title_en, content_type)
VALUES
    ('������', 'Action', 'Anime'),
    ('�������', 'Comedy', 'Anime'),
    ('�����', 'Drama', 'Anime'),
    ('�������', 'Fantasy', 'Anime'),
    ('�����', 'Horror', 'Anime'),
    ('������� ����������', 'Science Fiction', 'Anime'),
    ('���������', 'Romance', 'Anime'),
    ('�����������', 'Adventure', 'Anime'),
    ('������������', 'Historical', 'Anime'),
    ('�������', 'Mystery', 'Anime');