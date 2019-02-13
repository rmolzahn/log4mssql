USE [Log4MSSQLBuild]
GO
/****** Object:  StoredProcedure [loggerbasetests].[Test Assert We Can Get The Root Config XML]    Script Date: 02/13/2019 10:33:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [loggerbasetests].[Test Assert We Can Get The Root Config XML]
AS
BEGIN

	DECLARE @Config XML = '<log4mssql>
    <root>
        <level value="INFO" />
        <appender-ref ref="Appender1" />
		<appender-ref ref="Appender2" />
    </root>
</log4mssql>'

	SELECT RowID = 1, LevelValue = 'INFO', AppenderRef = 'Appender1'
	INTO #Expected
	UNION ALL
	SELECT RowID = 2, LevelValue = 'INFO', AppenderRef = 'Appender2'

	SELECT RowID, LevelValue, AppenderRef 
	INTO #Actual
	FROM LoggerBase.Config_Root_Get(@Config)

	EXEC tSQLt.AssertEqualsTable @Expected = '#Expected', @Actual = '#Actual'

END;
GO
