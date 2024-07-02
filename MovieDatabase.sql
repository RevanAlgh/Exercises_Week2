Create Database WeekTwo;

Create Table DistributionCompanies  (
Id INT PRIMARY KEY IDENTITY NOT NULL,
CompanyName VARCHAR(50) NOT NULL);


CREATE TABLE Movies (
  Id INT PRIMARY KEY IDENTITY NOT NULL,
  MovieTitle VARCHAR(255) NOT NULL,
  ImdbRating DECIMAL(2, 1) CHECK (ImdbRating BETWEEN 0.0 AND 10.0),
  YearReleased INT,
  Budget DECIMAL(10, 2), 
  BoxOffice DECIMAL(10, 2),
  DistributionCompanyID INT,
  Language VARCHAR(50),
  FOREIGN KEY (DistributionCompanyID) REFERENCES DistributionCompanies(Id)
);

INSERT INTO DistributionCompanies (CompanyName) 
VALUES ('Columbia Pictures'),('Paramount Pictures'),
  ('Warner Bros. Pictures'),('United Artists'),
  ('Universal Pictures'),('New Line Cinema'),
  ('Miramax Films'),('Produzioni Europee Associate'),
  ('Buena Vista'), ('StudioCanal');

  SELECT * FROM DistributionCompanies;

INSERT INTO Movies (MovieTitle, ImdbRating, YearReleased, Budget, BoxOffice, DistributionCompanyID, Language)
VALUES
  ('The Shawshank Redemption', 9.2, 1994, 25, 73.3, 1, 'English'),
  ('The Godfather', 9.2, 1972, 7.2, 291, 2, 'English'),
  ('The Dark Knight', 9.0, 2008, 185, 1006.00, 3, 'English'),
  ('The Godfather Part II', 9.0, 1974, 13, 93, 2, 'English, Sicilian'),
  ('12 Angry Men', 8.9, 1957, 0.34, 2, 4, 'English'),
  ('Schindler`s List', 8.9, 1993, 22, 322.2, 5, 'English, German, Yiddish'),
  ('The Lord of the Rings: The Return of the King', 8.9, 2003, 94, 1146.00, 6, 'English'),
  ('Pulp Fiction', 8.8, 1994, 8.5, 213.9, 7, 'English'),
  ('The Lord of the Rings: The Fellowship of the Ring', 8.8, 2001, 93, 898.2, 6, 'English'),
  ('The Good, the Bad and the Ugly', 8.8, 1966, 1.2, 38.9, 8, 'English, Italian, Spanish');

SELECT * From Movies;

--- EX.1: Select the columns movie_title, imdb_rating, and year_released from the table movies. ---
--- Show movies that have the word ‘Godfather’ in the title. ---

SELECT MovieTitle, ImdbRating, YearReleased 
FROM Movies 
WHERE MovieTitle LIKE '%Godfather%';


--- Exercise 2: Select the top 3 from the columns movie_title, imdb_rating, and year_released from the table movies.
--- Show movies released before 2001. Sort the output by the year released in ascending order. ---

SELECT TOP 3 MovieTitle, ImdbRating, YearReleased 
FROM Movies 
WHERE YearReleased < 2001 
ORDER BY YearReleased ASC;


--- Exercise 3: Show the count of movies by year released and language. 
--- Sort results by the release date in ascending order.

SELECT YearReleased, Language, COUNT(*)
From Movies
Group By YearReleased, Language
Order BY YearReleased ASC;


--- Exercise 4: Show the languages spoken and the average movie budget by language category.
--- Show only the languages with an average budget above $50 million.

SELECT Language, AVG(Budget) AS Average
From Movies 
Group By Language
HAVING Avg(Budget) > 50
ORDER BY Average DESC ;


---Exercise 5: Show movie titles from the table movies, each with the name of its distribution company.

SELECT M.MovieTitle, DC.CompanyName
FROM Movies M
JOIN DistributionCompanies DC ON M.DistributionCompanyID= DC.Id;


--- Exercise 6: Show the movie titles and the count of spoken languages

SELECT * From Movies;

SELECT 
    MovieTitle, 
    LEN(Language) - LEN(REPLACE(Language, ',', '')) + 1 AS LanguageCount
FROM 
    Movies;

