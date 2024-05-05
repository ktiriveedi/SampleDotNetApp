CREATE OR ALTER FUNCTION fn_StateExists
(
    @StateName NVARCHAR(100)
)
RETURNS BIT
AS
BEGIN
    DECLARE @Exists BIT = 0;

    IF EXISTS (SELECT 1 FROM [dbo].[State] WHERE [StateName] = @StateName)
        SET @Exists = 1;

    RETURN @Exists;
END;