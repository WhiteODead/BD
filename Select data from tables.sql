-- ��������� ������ ������
use [online-cinema];
-- �����
select * from genre;

-- ��������� ���� �������
select * from content;

-- ��������� �����
select * from country;

-- ��������� ������ � ���������
select * from person;

-- ��������� �������
select * from voiceover order by voiceover_id asc;

-- ��������� �������������
select * from [user];

-- ��������� �������� �������������
select * from bookmark order by [user_id];

-- ��������� ������������ �������������
select * from comment;

-- ��������� ������� ��� �������
select * from movie_voiceover order by voiceover_id, content_id;

-- ��������� ����� ������������ ������
SELECT *,
       COUNT(*) OVER (PARTITION BY content_id) AS count_of_rows
FROM content_country;

-- ��������� ������ ������
select * from content_genre join genre on content_genre.genre_id = genre.genre_id where content_id = 4;

SELECT content_id as [Id ������], genre_ru as [�������� �����],
       COUNT(*) OVER (PARTITION BY content_id) AS [���������� ������]
FROM content_genre
inner join genre on content_genre.genre_id = genre.genre_id

-- ��������� ����� ������
select count(*) from content_cast
