USE [Log4MSSQLBuild]
GO
/****** Object:  StoredProcedure [loggerbasetests].[Test Assert Layout_FormatMessage Calls Passed-In Type]    Script Date: 02/13/2019 10:33:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [loggerbasetests].[Test Assert Layout_FormatMessage Calls Passed-In Type]
AS
BEGIN

	EXEC tSQLt.SpyProcedure @ProcedureName = N'LoggerBase.Layout_PatternLayout',   -- nvarchar(max)
	                        @CommandToExecute = N'SET @FormattedMessage = ''Test Layout Type Called''' -- nvarchar(max)

	DECLARE @FormattedMessage VARCHAR(4000);
	EXEC LoggerBase.Layout_FormatMessage @LayoutTypeName = 'LoggerBase.Layout_PatternLayout',                      -- sysname
	                                     @LoggerName = 'TEST',                            -- varchar(500)
	                                     @LogLevelName = 'INFO',                          -- varchar(500)
	                                     @Message = 'Just a test',                               -- varchar(max)
	                                     @LayoutConfig = NULL,                        -- xml
	                                     @Debug = 0,                               -- bit
	                                     @FormattedMessage = @FormattedMessage OUTPUT -- varchar(max)
	
	EXEC tSQLt.AssertEquals @Expected = 'Test Layout Type Called', -- sql_variant
	                        @Actual = @FormattedMessage   -- sql_variant
	                        
	
	

END;
GO
