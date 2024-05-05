-- Script Block Start for index creation
DECLARE @Schema NVARCHAR(255) = 'dbo'
DECLARE @TableNameWithOutSchema NVARCHAR(255) = 'State'
DECLARE @ColumnName NVARCHAR(255) = 'CountryId';
DECLARE @IndexName NVARCHAR(255) = 'IX_State_CountryId';

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(@Schema+'.'+@TableNameWithOutSchema) AND type in (N'U'))
BEGIN
	-- Check if column exists
	IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = @TableNameWithOutSchema AND TABLE_SCHEMA=@Schema AND COLUMN_NAME = @ColumnName)
	BEGIN
		IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = @IndexName AND object_id = OBJECT_ID(@TableNameWithOutSchema))
		BEGIN
			CREATE NONCLUSTERED INDEX IX_State_CountryId
			ON [dbo].[State] (CountryId);
		END
	END
END
GO
-- Script Block end for index creation 
/***********************************************************************************************************/

-- Unit Test for Index verification.
DECLARE @Schema NVARCHAR(255) = 'dbo'
DECLARE @TableNameWithOutSchema NVARCHAR(255) = 'State'
DECLARE @ColumnName NVARCHAR(255) = 'CountryId';
DECLARE @IndexName NVARCHAR(255) = 'IX_State_CountryId';

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(@TableNameWithOutSchema) AND type in (N'U'))
BEGIN
	-- Check if column exists
	IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = @TableNameWithOutSchema AND TABLE_SCHEMA=@Schema AND COLUMN_NAME = @ColumnName)
	BEGIN
		IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = @IndexName AND object_id = OBJECT_ID(@TableNameWithOutSchema))
		BEGIN
			DECLARE @ErrorMessage NVARCHAR(MAX)
			SET @ErrorMessage = 'Index: ' + @IndexName + ' Not Exists in Table: ' + @TableNameWithOutSchema
			RAISERROR(@ErrorMessage, 16, 1);
			RETURN;
		END
	END
END
GO