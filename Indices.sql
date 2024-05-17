CREATE INDEX IDX_content_type ON content(type);
CREATE INDEX IDX_content_release_date ON content(release_date);
CREATE INDEX IDX_content_rating_imdb ON content(rating_imdb);
CREATE INDEX IDX_content_rating_kinopoisk ON content(rating_kinopoisk);

CREATE INDEX IDX_genre_id ON genre(genre_id);

CREATE INDEX IDX_country_id ON country(country_id);

CREATE INDEX IDX_person_id ON person(person_id);
CREATE INDEX IDX_person_name_ru ON person(name_ru);
CREATE INDEX IDX_person_name_original ON person(name_original);

CREATE INDEX IDX_user_id ON [user](user_id);
CREATE INDEX IDX_user_username ON [user](username);

CREATE INDEX IDX_bookmark_content_user ON bookmark(content_id, [user_id]);

CREATE INDEX IDX_comment_content_user ON comment(content_id, [user_id]);

CREATE INDEX IDX_movie_voiceover_content ON movie_voiceover(voiceover_id, content_id);

CREATE INDEX IDX_content_country_content_country ON content_country(country_id, content_id);

CREATE INDEX IDX_content_genre_content_genre ON content_genre(genre_id, content_id);

CREATE INDEX IDX_content_cast_person_content ON content_cast(person_id, content_id);
