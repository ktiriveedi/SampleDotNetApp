CREATE OR ALTER FUNCTION dbo.SplitString
(
    @String NVARCHAR(MAX),
    @Delimiter NVARCHAR(10)
)
RETURNS @Result TABLE (Value NVARCHAR(MAX))
AS
BEGIN
    DECLARE @StartPosition INT,
            @EndPosition INT

    SET @StartPosition = 1
    SET @EndPosition = CHARINDEX(@Delimiter, @String)

    WHILE @EndPosition > 0
    BEGIN
        INSERT INTO @Result (Value)
        VALUES (SUBSTRING(@String, @StartPosition, @EndPosition - @StartPosition))

        SET @StartPosition = @EndPosition + LEN(@Delimiter)
        SET @EndPosition = CHARINDEX(@Delimiter, @String, @StartPosition)
    END

    IF @StartPosition <= LEN(@String)
    BEGIN
        INSERT INTO @Result (Value)
        VALUES (SUBSTRING(@String, @StartPosition, LEN(@String) - @StartPosition + 1))
    END

    RETURN
END
