-- Table Creation
DECLARE @TableNameWithSchema NVARCHAR(255) = '[dbo].[Country]';

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(@TableNameWithSchema) AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[Country](
		[Id] [tinyint] IDENTITY(1,1) NOT NULL,
		[Name] VARCHAR(1000) NOT NULL,
		[CreatedDate] [datetime] NULL,
		[CreatedBy] VARCHAR(100) NULL,
		[ModifiedDate] [datetime] NULL,
		[ModifiedBy] VARCHAR(100) NULL,
		[IsActive] [bit] NULL
	PRIMARY KEY CLUSTERED 
	(
		[Id] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
	) ON [PRIMARY]

END

-- Unit Test block for table creation.
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(@TableNameWithSchema) AND type in (N'U'))
BEGIN	
	DECLARE @ErrorMessage NVARCHAR(MAX)
	SET @ErrorMessage = 'Table: ' + @TableNameWithSchema +' is not exists, Please verify in alter scripts for intentionally deleted script or An Error'
	RAISERROR(@ErrorMessage, 16, 1);
	RETURN;
END