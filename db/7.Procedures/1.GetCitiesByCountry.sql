CREATE OR ALTER PROCEDURE GetCitiesByCountry
    @CountryName VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT CountryName, StateName
    FROM Country as C
	inner join [State] S
	on C.Id = S.CountryId
	and C.CountryName= @CountryName
END