-- Script Block Start for rename 
DECLARE @Schema NVARCHAR(255) = 'dbo'
DECLARE @TableNameWithOutSchema NVARCHAR(255) = 'Country'
DECLARE @OldColumnName NVARCHAR(255) = 'Name';
DECLARE @NewColumnName NVARCHAR(255) = 'CountryName'

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(@Schema+'.'+@TableNameWithOutSchema) AND type in (N'U'))
BEGIN
	-- Check if column not exists then only rename column.
	IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = @TableNameWithOutSchema AND TABLE_SCHEMA=@Schema AND COLUMN_NAME = @OldColumnName)
	BEGIN
		DECLARE @SQL NVARCHAR(MAX)
		SET @SQL = 'EXECUTE sp_rename N''' + @TableNameWithOutSchema+'.' + @OldColumnName + ''', N''' + @NewColumnName + ''', ''COLUMN''' 
		PRINT(@SQL)
		EXEC(@SQL)
		PRINT 'Table: '+ @Schema+'.'+@TableNameWithOutSchema +', Old Column: ' + @OldColumnName + ', Renamed To: '+@NewColumnName+' successfully.'
	END
END
GO

-- Script Block Start for rename

/***********************************************************************************************************/

-- Script Block Start for verifying columns renamed - Unit Tests
DECLARE @Schema NVARCHAR(255) = 'dbo'
DECLARE @TableNameWithOutSchema NVARCHAR(255) = 'Country'
DECLARE @NewColumnName NVARCHAR(255) = 'CountryName'
DECLARE @DataType NVARCHAR(100) = 'INT'
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(@Schema+'.'+@TableNameWithOutSchema) AND type in (N'U'))
BEGIN
	-- Check if column not exists throw error.
	IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = @TableNameWithOutSchema AND TABLE_SCHEMA=@Schema AND COLUMN_NAME = @NewColumnName)
	BEGIN
		DECLARE @ErrorMessage NVARCHAR(MAX)
		SET @ErrorMessage = 'Column: ' + @NewColumnName + ' Not Exists in Table: ' + @Schema+'.'+@TableNameWithOutSchema
		RAISERROR(@ErrorMessage, 16, 1);
		RETURN;
	END
END
GO
-- Script Block End for verifying columns renamed - Unit Tests