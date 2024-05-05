/****** Object:  StoredProcedure [dbo].[UpdateDatabaseScriptStatus]    Script Date: 2/26/2024 1:40:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [dbo].[UpdateDatabaseScriptStatus]
    @FileName NVARCHAR(255),
	@Status varchar(100)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @ScriptNumber INT, @SQL NVARCHAR(MAX);
	SET @ScriptNumber = TRY_CAST(LEFT(@FileName, CHARINDEX('.', @FileName) - 1) AS INT);

    IF ISNULL(@ScriptNumber,'')=''
    BEGIN
		RAISERROR('Invalid file name format.', 16, 1);
        RETURN;
    END;

	IF (ISNULL(@Status,'')='') OR ((ISNULL(@Status,'')<>'' AND (@Status<>'STARTED' AND @Status<>'COMPLETED')))
    BEGIN
        RAISERROR('Status should be STARTED or COMPLETED', 16, 1);
        RETURN;
    END;

	IF @Status='STARTED'
	BEGIN
		 DECLARE @RowCount INT;
		 DECLARE @MaxRowCount INT;
		 SELECT @RowCount=COUNT(1) FROM ScriptExecutionLog WHERE ScriptName=@FileName
		 SELECT @MaxRowCount=MAX(ScriptFileNumber) FROM ScriptExecutionLog WHERE ExecutionStatus='COMPLETED'
		 --PRINT 'ROWCOUNT'
		 --PRINT @RowCount 
		 --PRINT 'MAX-'
		 --PRINT @MaxRowCount
		 --PRINT 'SCRIPT'
		 --PRINT @ScriptNumber
		IF (@RowCount > 0)
		BEGIN
			RAISERROR('Seems file already executed, Please recheck', 16, 1);
			RETURN;
		END
		ELSE IF(@MaxRowCount>@ScriptNumber)
		BEGIN
			RAISERROR('You messed it up, You should execute scripts in sequentially, Please verify ScriptExecutionLog table for details', 16, 1);
			RETURN;
		END
		ELSE
		BEGIN	
			INSERT INTO ScriptExecutionLog (ScriptFileNumber, ScriptName, ExecutionDateTime, ExecutionStatus)
			VALUES (@ScriptNumber ,@FileName, GETDATE(), @Status);
		END
	END

	IF @Status='COMPLETED'
	BEGIN
		 DECLARE @StartedRowCount INT;
		 DECLARE @AllRowCount INT;
		 SELECT @StartedRowCount=COUNT(1) FROM ScriptExecutionLog WHERE ScriptName=@FileName and ExecutionStatus='STARTED';
		 SELECT @AllRowCount=COUNT(1) FROM ScriptExecutionLog WHERE ScriptName=@FileName;
		IF(@StartedRowCount=1 and @AllRowCount=1)
		BEGIN
			UPDATE ScriptExecutionLog
			SET ExecutionStatus = 'COMPLETED',
			ExecutionDateTime = GETDATE()
			WHERE ScriptName = @FileName;
		END
		ELSE
		BEGIN
			RAISERROR('Script failed to execute, recheck if you miss STARTED step', 16, 1);
			RETURN;
		END
	END
END;


