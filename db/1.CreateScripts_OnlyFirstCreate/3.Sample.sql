-- Table Creation
DECLARE @TableNameWithSchema NVARCHAR(255) = '[dbo].[Sample]';

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(@TableNameWithSchema) AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[Sample](
		[Id] [tinyint] IDENTITY(1,1) NOT NULL,
		[SampleColumn] [varchar](50) NULL,
		[CreatedDate] [datetime] NULL,
		[CreatedBy] [int] NULL,
		[ModifiedDate] [datetime] NULL,
		[ModifiedBy] [int] NULL,
		[IsActive] [bit] NULL
	PRIMARY KEY CLUSTERED 
	(
		[Id] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
	) ON [PRIMARY]

END

/***********************************************************************************************************/

-- Unit Test block for table creation.
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(@TableNameWithSchema) AND type in (N'U'))
BEGIN	
	DECLARE @ErrorMessage NVARCHAR(MAX)
	SET @ErrorMessage = 'Table: ' + @TableNameWithSchema +' is not exists, Please verify in alter scripts for intentionally deleted script or An Error'
	RAISERROR(@ErrorMessage, 16, 1);
	RETURN;
END