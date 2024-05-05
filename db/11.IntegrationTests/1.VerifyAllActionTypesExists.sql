-- Verify is all MST_ActionType exists for production.
DECLARE @searchString NVARCHAR(MAX) = 
'Add Location,'+
'Transfer,'+
'Relocation,'+
'Notice,'+
'Renewal,'+
'Change of Location,'+
'DBA Change,'+
'Activation,'+
'Flat Late Fees,'+
'In-Activation,'+
'Reinstatement Fees,'+
'Update Employment,'+
'Entity Name Change,'+
'CE Reporting,'+
'Label Generation,'+
'Breach Of Peace,'+
'Product Registration,'+
'Merger,'+
'Temporary Event Notification (TEN),'+
'Change of Class,'+
'Change Of Expiration,'+
'Change of Entity,'+
'Dispositions,'+
'Forfeitures,'+
'Excise Tax,'+
'Demand Funds,'+
'Civil Penalty,';

DECLARE @AllValuesExist BIT = 1;

DECLARE @searchValues TABLE (Value NVARCHAR(MAX));
INSERT INTO @searchValues
SELECT value
FROM SplitString(@searchString, ',');

DECLARE @Value NVARCHAR(MAX);

DECLARE search_cursor CURSOR FOR 
    SELECT Value FROM @searchValues;

OPEN search_cursor;

FETCH NEXT FROM search_cursor INTO @Value;

WHILE @@FETCH_STATUS = 0
BEGIN
    
    IF NOT EXISTS (
        SELECT 1 FROM MST_ActionType
        WHERE CHARINDEX(@Value, ActionName) > 0
    )
    BEGIN
        SET @AllValuesExist = 0;
        BREAK;
    END

    FETCH NEXT FROM search_cursor INTO @Value;
END

CLOSE search_cursor;
DEALLOCATE search_cursor;

IF @AllValuesExist = 1
BEGIN
    PRINT 'Test is success.';
END
ELSE
BEGIN
    DECLARE @ErrorMessage NVARCHAR(MAX)
	SET @ErrorMessage = 'There is an issue. Not all values exist in the Data column.'
	RAISERROR(@ErrorMessage, 16, 1);
	RETURN;
END
