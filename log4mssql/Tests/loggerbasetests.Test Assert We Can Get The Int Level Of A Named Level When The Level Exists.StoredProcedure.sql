USE [Log4MSSQLBuild]
GO
/****** Object:  StoredProcedure [loggerbasetests].[Test Assert We Can Get The Int Level Of A Named Level When The Level Exists]    Script Date: 02/13/2019 10:33:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [loggerbasetests].[Test Assert We Can Get The Int Level Of A Named Level When The Level Exists]
AS
BEGIN

	EXEC tSQLt.FakeTable @TableName = 'LoggerBase.Core_Level'
	INSERT INTO LoggerBase.Core_Level
	(LogLevelName, LogLevelValue)
	VALUES
	 ('VERBOSE', 1)
	,('DEBUG',   2)
	,('ERROR',   3)

	DECLARE @Expected INT = 2
	DECLARE @Actual INT

	SELECT @Actual = LoggerBase.Core_Level_ConvertNameToValue('DEBUG', 'MIN')

	EXEC tSQLt.AssertEquals @Expected = @Expected, @Actual = @Actual

	SELECT @Actual = LoggerBase.Core_Level_ConvertNameToValue('DEBUG', NULL)

	EXEC tSQLt.AssertEquals @Expected = @Expected, @Actual = @Actual

END;
GO
