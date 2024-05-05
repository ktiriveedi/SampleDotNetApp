IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'TEST')
EXEC sys.sp_executesql N'CREATE SCHEMA [TEST]'
GO