-- Adding foreign key start
DECLARE @Schema NVARCHAR(255) = 'dbo';
DECLARE @ContraintName NVARCHAR(255) = 'FK_State_Country';
DECLARE @TableNameWithOutSchema NVARCHAR(255) = 'State';
DECLARE @ColumnName NVARCHAR(255) = 'CountryId';

DECLARE @RefTableNameWithOutSchema NVARCHAR(255) = 'Country';
DECLARE @RefTableColumnName NVARCHAR(255) = 'Id';

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE name = @ContraintName) 
BEGIN
	DECLARE @SQL NVARCHAR(MAX)
	SET @SQL = 'ALTER TABLE [' + @Schema + '].[' + @TableNameWithOutSchema + '] WITH CHECK ADD CONSTRAINT [' + @ContraintName + '] FOREIGN KEY([' + @ColumnName + ']) 
	REFERENCES [' + @Schema + '].['+@RefTableNameWithOutSchema+'] (['+@RefTableColumnName+'])';
	EXEC(@SQL)
END
GO
-- Adding foreign key start

/***********************************************************************************************************/

-- Script Block Start for verifying Foreign key created - Unit Tests
DECLARE @Schema NVARCHAR(255) = 'dbo';
DECLARE @ContraintName NVARCHAR(255) = 'FK_State_Country';
DECLARE @TableNameWithOutSchema NVARCHAR(255) = 'State';
DECLARE @ColumnName NVARCHAR(255) = 'CountryId';

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE name = @ContraintName) 
BEGIN
	DECLARE @ErrorMessage NVARCHAR(MAX)
	SET @ErrorMessage = 'Foreign Key Not Exists: ' + @ContraintName + ' on Table: '+@TableNameWithOutSchema
	RAISERROR(@ErrorMessage, 16, 1);
	RETURN;
END
GO