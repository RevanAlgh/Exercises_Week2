
---SELECT * FROM DistributionCompanies;

--- Stored Procedure to Add a New Movie

CREATE PROCEDURE AddMovie

--- Procedure Declaration
    @MovieTitle NVARCHAR(255),
    @ImdbRating FLOAT,
    @YearReleased INT,
    @Budget DECIMAL(18, 2),
    @BoxOffice DECIMAL(18, 2),
    @CompanyName NVARCHAR(255),
    @AuthorName NVARCHAR(255),
    @CountryName NVARCHAR(255),
    @Language NVARCHAR(255)
AS

BEGIN

--- Variable Declarations
    DECLARE @CountryID INT;
    DECLARE @CompanyID INT;
    DECLARE @AuthorID INT;
    DECLARE @MovieID INT;

--- Check if the country exists 
    IF NOT EXISTS (SELECT 1 FROM Country WHERE CountryName = @CountryName)
BEGIN
    INSERT INTO Country (CountryName) VALUES (@CountryName);
END
SELECT @CountryID = CountryId FROM Country WHERE CountryName = @CountryName;


--- Check if the company exists 
    IF NOT EXISTS (SELECT 1 FROM DistributionCompanies WHERE CompanyName = @CompanyName)
BEGIN
    INSERT INTO DistributionCompanies (CompanyName, CountryID) VALUES (@CompanyName, @CountryID);
END
SELECT @CompanyID = Id FROM DistributionCompanies WHERE CompanyName = @CompanyName;


--- Check if the author exists 
    IF NOT EXISTS (SELECT 1 FROM Authors WHERE AuthorName = @AuthorName)
BEGIN
    INSERT INTO Authors (AuthorName) VALUES (@AuthorName);
END
SELECT @AuthorID = Id FROM Authors WHERE AuthorName = @AuthorName;


--- Insert the new movie
    INSERT INTO Movies (MovieTitle, ImdbRating, YearReleased, Budget, BoxOffice, DistributionCompanyID, Language)
    VALUES (@MovieTitle, @ImdbRating, @YearReleased, @Budget, @BoxOffice, @CompanyID, @Language);

    SELECT @MovieID = SCOPE_IDENTITY();

--- Insert into AuthorMovie
    INSERT INTO AuthorMovie(MovieID, AuthorID) VALUES (@MovieID, @AuthorID);
END


--- Executing The AddMovie Stored Procedure ---

--- @AuthorName is already in the DB 

EXEC AddMovie
    @MovieTitle = N'Forgotten',
    @ImdbRating = 7.4,
    @YearReleased = 2017,
    @Budget = 400,
    @BoxOffice = 10,
    @CompanyName = N'Todd Huntington Productions',
    @AuthorName = N'Stephen King',
    @CountryName = N'South Korea',
    @Language = N'Korean';

--- @CompanyName and @CountryName is already in the DB 

EXEC AddMovie
    @MovieTitle = N'The Talented Mr. Ripley',
    @ImdbRating = 7.4,
    @YearReleased = 1999,
    @Budget = 500,
    @BoxOffice = 25.4,
    @CompanyName = N'Paramount Pictures',
    @AuthorName = N'Anthony Minghella',
    @CountryName = N'United States',
    @Language = N'English';

--- @CountryName is already in the DB 

EXEC AddMovie
    @MovieTitle = N'The Matrix',
    @ImdbRating = 8.7,
    @YearReleased = 1999,
    @Budget = 630,
    @BoxOffice = 25651,
    @CompanyName = N'Warner Bros',
    @AuthorName = N'Lana Wachowski',
    @CountryName = N'United States',
    @Language = N'English';

EXEC AddMovie
    @MovieTitle = N'Inception',
    @ImdbRating = 8.8,
    @YearReleased = 2010,
    @Budget = 160,
    @BoxOffice = 83680,
    @CompanyName = N'Warner Bros',
    @AuthorName = N'Christopher Nolan',
    @CountryName = N'United States',
    @Language = N'English';

EXEC MoviesList;

SELECT * FROM Movies;
SELECT * FROM DistributionCompanies;
SELECT * FROM Authors;
SELECT * FROM Country;

