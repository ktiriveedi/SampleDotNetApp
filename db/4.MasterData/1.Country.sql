-- Master Data For Country
DECLARE @CountryName NVARCHAR(100) = 'USA';
DECLARE @User NVARCHAR(100) = 'Admin';

-- Type1: Check and insert.
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE CountryName = @CountryName)
BEGIN
    INSERT INTO [dbo].[Country] ([CountryName], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive])
    VALUES (@CountryName, GETDATE(), @User, GETDATE(), @User, 1);
END
GO

-- Type2: Check and insert. ( Based on chandra suggestion )
DECLARE @CountryName NVARCHAR(100) = 'INDIA';
DECLARE @IdentityToInsert [tinyint] = 2;
DECLARE @User NVARCHAR(100) = 'Admin';
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE CountryName = @CountryName)
BEGIN
    SET IDENTITY_INSERT [dbo].[Country] ON
	INSERT INTO [dbo].[Country] ([ID],[CountryName], [CreatedDate], [CreatedBy], [ModifiedDate], [ModifiedBy], [IsActive]) 
	VALUES (@IdentityToInsert, @CountryName, GETDATE(), @User, GETDATE(), @User, 1)
	SET IDENTITY_INSERT [dbo].[Country] OFF
END
GO

/***********************************************************************************************************/

-- Master Data Verification Scripts -- Is USA Exists
-- Type1: Check and insert.
DECLARE @CountryName NVARCHAR(100) = 'USA';
IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE CountryName = @CountryName)
BEGIN    
	DECLARE @ErrorMessage NVARCHAR(MAX)
	SET @ErrorMessage = 'Master Data Error: Table: [dbo].[Country], Data Not Exists for [CountryName]: '+@CountryName
	RAISERROR(@ErrorMessage, 16, 1);
	RETURN;
END
GO

-- Type2: Check and insert. ( Based on chandra suggestion - Governance )
DECLARE @CountryName NVARCHAR(100) = 'INDIA';
DECLARE @IdentityToInsert [tinyint] = 2;

IF NOT EXISTS (SELECT 1 FROM [dbo].[Country] WHERE CountryName = @CountryName AND [Id]=@IdentityToInsert)
BEGIN    
	DECLARE @ErrorMessage NVARCHAR(MAX)
	SET @ErrorMessage = 'Master Data Error: Table: [dbo].[Country], Data Not Exists OR Does not match for [CountryName]: '+@CountryName
	RAISERROR(@ErrorMessage, 16, 1);
	RETURN;
END
GO