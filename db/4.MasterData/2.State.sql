-- Master Data For State -- Type:1 Insertion.
DECLARE @StateNameToCheck NVARCHAR(100) = 'TX';
DECLARE @CountryName NVARCHAR(100) = 'USA';
DECLARE @User NVARCHAR(100) = 'Admin';

IF EXISTS (SELECT 1 FROM [dbo].[Country] WHERE CountryName = @CountryName)
BEGIN
	IF NOT EXISTS (SELECT 1 FROM [dbo].[State] WHERE [StateName] = @StateNameToCheck)
	BEGIN
		Declare @CountryId [tinyint];
		SELECT @CountryId = Id from [dbo].[Country] WHERE CountryName = @CountryName;
		INSERT INTO [dbo].[State] ([StateName], [CountryId] , [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive])
		VALUES (@StateNameToCheck, @CountryId, GETDATE(), @User, GETDATE(), @User, 1);
	END    
END
GO

DECLARE @StateNameToCheck NVARCHAR(100) = 'TN';
DECLARE @CountryName NVARCHAR(100) = 'USA';
DECLARE @User NVARCHAR(100) = 'Admin';

IF EXISTS (SELECT 1 FROM [dbo].[Country] WHERE CountryName = @CountryName)
BEGIN
	IF NOT EXISTS (SELECT 1 FROM [dbo].[State] WHERE [StateName] = @StateNameToCheck)
	BEGIN
		Declare @CountryId [tinyint];
		SELECT @CountryId = Id from [dbo].[Country] WHERE CountryName = @CountryName;
		INSERT INTO [dbo].[State] ([StateName], [CountryId] , [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive])
		VALUES (@StateNameToCheck, @CountryId, GETDATE(), @User, GETDATE(), @User, 1);
	END    
END
GO

-- Master Data For State -- Type:2 Insertion.
DECLARE @StateNameToCheck NVARCHAR(100) = 'TG';
DECLARE @StateId [tinyint] = 100;
DECLARE @CountryName NVARCHAR(100) = 'INDIA';
DECLARE @CountryId [tinyint] = 2;
DECLARE @User NVARCHAR(100) = 'Admin';

IF EXISTS (SELECT 1 FROM [dbo].[Country] WHERE CountryName = @CountryName AND Id=@CountryId)
BEGIN
	IF NOT EXISTS (SELECT 1 FROM [dbo].[State] WHERE [StateName] = @StateNameToCheck AND Id=@StateId)
	BEGIN
		SET IDENTITY_INSERT [dbo].[State] ON
		INSERT INTO [dbo].[State] ([ID],[StateName], [CountryId] , [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive])
		VALUES (@StateId, @StateNameToCheck, @CountryId, GETDATE(), @User, GETDATE(), @User, 1);
		SET IDENTITY_INSERT [dbo].[State] OFF
	END    
END
GO

/***********************************************************************************************************/

-- Master Data Verification Scripts -- Is TX Exists
DECLARE @StateNameToCheck NVARCHAR(100) = 'TX';

IF NOT EXISTS (SELECT 1 FROM [dbo].[State] WHERE [StateName] = @StateNameToCheck)
BEGIN    
	DECLARE @ErrorMessage NVARCHAR(MAX)
	SET @ErrorMessage = 'Master Data Error: Table: [dbo].[State], Data Not Exists for [StateName]: '+@StateNameToCheck
	RAISERROR(@ErrorMessage, 16, 1);
	RETURN;
END
GO

-- Master Data Verification Scripts Type: 2 -- Is TG Exists
DECLARE @StateNameToCheck NVARCHAR(100) = 'TG';
DECLARE @StateId [tinyint] = 100;
DECLARE @CountryId [tinyint] = 2;

IF NOT EXISTS (SELECT 1 FROM [dbo].[State] WHERE [StateName] = @StateNameToCheck AND Id=@StateId AND CountryId=@CountryId)
	BEGIN  
	DECLARE @ErrorMessage NVARCHAR(MAX)
	SET @ErrorMessage = 'Master Data Error: Table: [dbo].[State], Data Not Exists for [StateName]: '+@StateNameToCheck
	RAISERROR(@ErrorMessage, 16, 1);
	RETURN;
END
GO