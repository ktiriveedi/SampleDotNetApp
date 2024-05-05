-- Create View if Not Exist
Declare @ViewName VARCHAR(250)= 'StateWithCountry'
Declare @ViewSource VARCHAR(250)= '
	SELECT 
			S.Id AS StateId,
			S.StateName,
			C.Id AS CountryId,
			C.CountryName
		FROM 
			[dbo].[State] AS S
		JOIN 
			[dbo].[Country] AS C ON S.CountryId = C.Id;'

IF NOT EXISTS (SELECT * FROM sys.views WHERE name = @ViewName)
BEGIN
    EXEC('CREATE VIEW StateWithCountry AS' +@ViewSource);
END
ELSE
BEGIN
    EXEC('ALTER VIEW StateWithCountry AS' +@ViewSource);;
END
GO

/***********************************************************************************************************/
Declare @ViewName VARCHAR(250)= 'StateWithCountry'
IF NOT EXISTS (SELECT * FROM sys.views WHERE name = @ViewName)
BEGIN
	DECLARE @ErrorMessage NVARCHAR(MAX)
	SET @ErrorMessage = 'View : '+@ViewName + ' Does not exists, Please verify.'
	RAISERROR(@ErrorMessage, 16, 1);
	RETURN;
END