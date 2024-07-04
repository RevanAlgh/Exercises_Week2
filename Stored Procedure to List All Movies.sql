--- Stored Procedure to List All Movies

CREATE PROCEDURE MoviesList
AS
BEGIN
    SELECT M.MovieTitle, M.ImdbRating, M.YearReleased, M.Budget, M.BoxOffice, M.Language, DC.CompanyName, C.CountryName, A.AuthorName
    FROM Movies M
    JOIN DistributionCompanies DC ON M.DistributionCompanyID = DC.Id
    JOIN Country C ON DC.CountryID = C.CountryID
    JOIN AuthorMovie MA ON M.Id = MA.MovieID
    JOIN Authors A ON MA.AuthorID = A.Id
	ORDER BY M.MovieTitle;
END

EXEC MoviesList;

SELECT * FROM Authors;
SELECT * FROM Country;

SELECT M.MovieTitle, M.ImdbRating, M.YearReleased, M.Budget, M.BoxOffice, M.Language, DC.CompanyName, C.CountryName, STRING_AGG(A.AuthorName, ', ') AS Authors
    FROM Movies M
    JOIN DistributionCompanies DC ON M.DistributionCompanyID = DC.Id
    JOIN Country C ON DC.CountryID = C.CountryID
    LEFT JOIN AuthorMovie MA ON M.Id = MA.MovieID
    LEFT JOIN Authors A ON MA.AuthorID = A.Id
	GROUP BY M.MovieTitle, M.ImdbRating, M.YearReleased, M.Budget, M.BoxOffice, M.Language, DC.CompanyName, C.CountryName
	ORDER BY M.MovieTitle;

