USE movie_db;
# 1. Show the Quentin Tarantino films which have more than 500000 votes and produced before 2000.
SELECT title, votes, year 
FROM movies
WHERE votes > 500000 
  AND year < 2000 
  AND movie_id IN (
      SELECT movie_id 
      FROM movie_directors 
      JOIN directors ON movie_directors.director_id = directors.director_id 
      WHERE director_name LIKE 'Quentin%'
  );
# 2. Show the films that Tom Hanks has act and have won more than 3 Oscars.
SELECT title , oscars 
FROM movies m
join movie_stars ms ON m.movie_id = ms.movie_id
join stars s ON ms.star_id = s.star_id
WHERE s.star_name = "Tom Hanks" and m.oscars > 3
# 3. Show the history films produced in USA and whose duration is between 100-200 minutes.
SELECT m.title, m.duration
FROM movies m
JOIN genres g ON m.movie_id = g.movie_id
JOIN producer_countries pc ON m.movie_id = pc.movie_id
JOIN countries c ON c.country_id = pc.country_id
WHERE g.genre_name = 'History' 
  AND c.country_name = 'USA'
  AND m.duration BETWEEN 100 AND 200;
# 4.Compute the average budget of the films directed by Peter Jackson.
SELECT AVG(m.budget) AS avg_budget
FROM movies m
JOIN movie_directors md ON m.movie_id = md.movie_id
JOIN directors d ON d.director_id = md.director_id
WHERE d.director_name = 'Peter Jackson';
# 5.Show the Francis Ford Coppola film that has the maximum budget.
SELECT m.title, m.budget 
FROM movies m
JOIN movie_directors md ON m.movie_id = md.movie_id 
JOIN directors d ON d.director_id = md.director_id 
WHERE d.director_name = 'Francis Ford Coppola' 
ORDER BY m.budget DESC
LIMIT 1;
# 6.Show the film that has the most vote and has been produced in USA.
SELECT m.title, m.votes
FROM movies m 
JOIN producer_countries pc ON m.movie_id = pc.movie_id
JOIN countries c ON pc.country_id = c.country_id
WHERE c.country_name = 'USA'
ORDER BY m.votes DESC
LIMIT 1;
# 7. List all stars who have acted in more than 1 films
SELECT s.star_name,count(ms.movie_İd) as film_count
from stars s 
join movie_stars ms on s.star_id = ms.star_id 
group by s.star_Name 
having film_count > 1;

