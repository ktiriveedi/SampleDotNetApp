Declare @FileName VARCHAR(250)='1. Update_Important_Data_OneTime_In_CountryTable.sql'
BEGIN TRANSACTION;

EXEC UpdateDatabaseScriptStatus @FileName,'STARTED'

UPDATE [dbo].[Country] SET [ModifiedBy] = 'DATA UPDATED WITH ONE TIME SCRIPT3' 

EXEC UpdateDatabaseScriptStatus @FileName,'COMPLETED'

IF @@ERROR <> 0
BEGIN
    ROLLBACK TRANSACTION;
    PRINT 'Transaction rolled back, Due to come error';
END
ELSE
BEGIN
    COMMIT TRANSACTION;
    PRINT 'One Time Script executed successfully.';
END
GO



