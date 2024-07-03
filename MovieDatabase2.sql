----------------------------------------------------------------------------------

--- Create a new table named Authors . 
--- insert into it some random names and make a many to many relation between authors and movies 

Create Table Authors (
Id INT PRIMARY KEY IDENTITY NOT NULL,
AuthorName VARCHAR(255) NOT NULL);


INSERT INTO Authors (AuthorName) 
VALUES ('Stephen King'),('J.K. Rowling'),
  ('George R.R. Martin'),('Harper Lee'),
  ('Agatha Christie'),('William Shakespeare'),
  ('F. Scott Fitzgerald'),('Jane Austen'),
  ('Ernest Hemingway'),('Margaret Atwood');

  SELECT * FROM Authors;

  CREATE TABLE AuthorMovie (
  AuthorId INT FOREIGN KEY REFERENCES Authors(Id) NOT NULL,
  MovieId INT FOREIGN KEY REFERENCES Movies(Id) NOT NULL,
  PRIMARY KEY (AuthorId, MovieId)
);

  SELECT * FROM AuthorMovie;


INSERT INTO AuthorMovie (MovieId, AuthorId)
VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 1),
    (5, 4),
    (6, 5),
    (7, 5),
    (8, 2),
    (9, 3),
    (10, 4);

--- show movies and authors names ---

SELECT M.MovieTitle, A.AuthorName
From Movies M
JOIN AuthorMovie AM ON M.Id=AM.MovieId
JOIN Authors A ON AM.AuthorId = A.Id;

--- make some movies with more than one author ---

SELECT * FROM AuthorMovie;

INSERT INTO AuthorMovie (MovieId, AuthorId)
VALUES
    (1, 2), 
    (2, 3), 
    (3, 4), 
    (4, 5),  
    (5, 5);  

SELECT M.MovieTitle, A.AuthorName
From Movies M
JOIN AuthorMovie AM ON M.Id=AM.MovieId
JOIN Authors A ON AM.AuthorId = A.Id
ORDER BY M.MovieTitle, A.AuthorName;


--- show the movies and author count ---

SELECT M.MovieTitle, COUNT(AM.AuthorId) As AuthorCount
From Movies M
JOIN AuthorMovie AM ON M.Id=AM.MovieId
GROUP BY M.MovieTitle
ORDER BY M.MovieTitle;

--- show movies and authors names as comma separated ( author 1, author 2, ...) ---

SELECT M.MovieTitle, STRING_AGG(A.AuthorName, ', ') AS Authors
From Movies M
JOIN AuthorMovie AM ON M.Id=AM.MovieId
JOIN Authors A ON AM.AuthorId = A.Id
GROUP BY M.MovieTitle
ORDER BY M.MovieTitle;

--- show authors and count of movies they had participated. ---

SELECT A.AuthorName, COUNT(AM.MovieId) As MovieCount
From Authors A
JOIN AuthorMovie AM ON A.Id=AM.AuthorId
GROUP BY A.AuthorName
ORDER BY A.AuthorName;

--- create a new table named country, and make a one-to-many relationship between country and company tables. --- 

CREATE TABLE Country (
  CountryId INT PRIMARY KEY IDENTITY NOT NULL,
  CountryName VARCHAR(50) NOT NULL);

ALTER TABLE DistributionCompanies
ADD CountryId INT FOREIGN KEY REFERENCES Country(CountryID);

--- show movies and their country name ---

INSERT INTO Country (CountryName)
VALUES 
    ('United States'),
    ('United Kingdom'),
    ('Canada'),
    ('Germany'),
    ('France');

SELECT * FROM Country;

SELECT * FROM DistributionCompanies;

UPDATE DistributionCompanies
SET CountryId = 1
WHERE Id = 1;  

UPDATE DistributionCompanies
SET CountryId = 2
WHERE Id = 2;  

UPDATE DistributionCompanies
SET CountryId = 3
WHERE Id = 3;  

UPDATE DistributionCompanies
SET CountryId = 4
WHERE Id = 4; 

UPDATE DistributionCompanies
SET CountryId = 5
WHERE Id = 5; 

SELECT * FROM Movies;

SELECT M.MovieTitle, C.CountryName
From Movies M
JOIN DistributionCompanies DC ON DC.CountryId = M.DistributionCompanyID
JOIN Country C ON C.CountryId = DC.Id
ORDER BY M.MovieTitle;