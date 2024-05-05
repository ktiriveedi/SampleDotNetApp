-- Script Block Start for adding new columns

-- 1. Adding Column
DECLARE @Schema NVARCHAR(255) = 'dbo'
DECLARE @TableNameWithOutSchema NVARCHAR(255) = 'Sample'
DECLARE @ColumnName NVARCHAR(255) = 'NewColumnName1'
DECLARE @DataType NVARCHAR(100) = 'INT'

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(@Schema+'.'+@TableNameWithOutSchema) AND type in (N'U'))
BEGIN
	-- Check if column not exists only create new column.
	IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = @TableNameWithOutSchema AND TABLE_SCHEMA=@Schema AND COLUMN_NAME = @ColumnName)
	BEGIN
		DECLARE @SQL NVARCHAR(MAX)
		SET @SQL = 'ALTER TABLE ' + @Schema+'.'+@TableNameWithOutSchema + ' ADD ' + @ColumnName + ' ' + @DataType
		EXEC(@SQL)
		PRINT 'Table: '+ @Schema+'.'+@TableNameWithOutSchema +', Column: ' + @ColumnName + ' added successfully.'
	END
END
GO

DECLARE @Schema NVARCHAR(255) = 'dbo'
DECLARE @TableNameWithOutSchema NVARCHAR(255) = 'Sample'
DECLARE @ColumnName NVARCHAR(255) = 'NewColumnName2'
DECLARE @DataType NVARCHAR(100) = 'INT'

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(@Schema+'.'+@TableNameWithOutSchema) AND type in (N'U'))
BEGIN
	-- Check if column not exists only create new column.
	IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = @TableNameWithOutSchema AND TABLE_SCHEMA=@Schema AND COLUMN_NAME = @ColumnName)
	BEGIN
		DECLARE @SQL NVARCHAR(MAX)
		SET @SQL = 'ALTER TABLE ' + @Schema+'.'+@TableNameWithOutSchema + ' ADD ' + @ColumnName + ' ' + @DataType
		EXEC(@SQL)
		PRINT 'Table: '+ @Schema+'.'+@TableNameWithOutSchema +', Column: ' + @ColumnName + ' added successfully.'
	END
END
GO
-- Script Block End for adding new columns

/***********************************************************************************************************/

-- Script Block Start for verifying columns created - Unit Tests
DECLARE @Schema NVARCHAR(255) = 'dbo'
DECLARE @TableNameWithOutSchema NVARCHAR(255) = 'Sample'
DECLARE @ColumnName NVARCHAR(255) = 'NewColumnName1'
DECLARE @DataType NVARCHAR(100) = 'INT'
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(@Schema+'.'+@TableNameWithOutSchema) AND type in (N'U'))
BEGIN
	-- Check if column not exists only create new column.
	IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = @TableNameWithOutSchema AND TABLE_SCHEMA=@Schema AND COLUMN_NAME = @ColumnName)
	BEGIN
		DECLARE @ErrorMessage NVARCHAR(MAX)
		SET @ErrorMessage = 'Column: ' + @ColumnName + ' Not Exists in Table: ' + @Schema+'.'+@TableNameWithOutSchema
		RAISERROR(@ErrorMessage, 16, 1);
		RETURN;
	END
END
GO

DECLARE @Schema NVARCHAR(255) = 'dbo'
DECLARE @TableNameWithOutSchema NVARCHAR(255) = 'Sample'
DECLARE @ColumnName NVARCHAR(255) = 'NewColumnName2'
DECLARE @DataType NVARCHAR(100) = 'INT'
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(@Schema+'.'+@TableNameWithOutSchema) AND type in (N'U'))
BEGIN
	-- Check if column not exists only create new column.
	IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = @TableNameWithOutSchema AND TABLE_SCHEMA=@Schema AND COLUMN_NAME = @ColumnName)
	BEGIN
		DECLARE @ErrorMessage NVARCHAR(MAX)
		SET @ErrorMessage = 'Column: ' + @ColumnName + ' Not Exists in Table: ' + @Schema+'.'+@TableNameWithOutSchema
		RAISERROR(@ErrorMessage, 16, 1);
		RETURN;
	END
END
GO

