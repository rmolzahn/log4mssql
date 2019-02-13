USE [Log4MSSQLBuild]
GO
/****** Object:  StoredProcedure [loggerbasetests].[Test Assert Config_Appenders_FilteredByLevel Returns No Appenders When Request Level Is Below Appender Level]    Script Date: 02/13/2019 10:33:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [loggerbasetests].[Test Assert Config_Appenders_FilteredByLevel Returns No Appenders When Request Level Is Below Appender Level]
AS
BEGIN

	--Set the level to "INFO" and above.
	DECLARE @InfoConfig XML = '
	<log4mssql>
		<appender name="Saved-Default-Console" type="LoggerBase.Appender_ConsoleAppender">
			<layout type="LoggerBase.Layout_PatternLayout">
				<conversionPattern value="%timestamp %level %logger-%message"/>
			</layout>
		</appender>
		<root>
			<level value="INFO"/>
			<appender-ref ref="Saved-Default-Console"/>
		</root>
	</log4mssql>'

	DECLARE @RequestedLogLevelName VARCHAR(500) = 'DEBUG'

	CREATE TABLE #Result
	(
		 RowID INT
		,AppenderType VARCHAR(500)
		,AppenderConfig XML
	)

	IF OBJECT_ID('TempDB..#Expected') IS NOT NULL DROP TABLE #Expected
	SELECT 
	 RowID
	,AppenderType
	,CONVERT(VARCHAR(1000), AppenderConfig) AS AppenderConfig
	INTO #Expected
	FROM #Result

	--Request a debug output. The appender should not fire.
	INSERT INTO #Result
	EXEC LoggerBase.Config_Appenders_FilteredByLevel @Config = @InfoConfig, @RequestedLogLevelName = @RequestedLogLevelName, @Debug = 0

	SELECT 
	 RowID
	,AppenderType
	,CONVERT(VARCHAR(1000), AppenderConfig) AS AppenderConfig
	INTO #Actual
	FROM #Result

	select * from #Expected
	select * from #Actual

	EXEC tSQLt.AssertEqualsTable @Expected = '#Expected', @Actual = '#Actual'

	--IF OBJECT_ID('TempDB..#Expected') IS NOT NULL DROP TABLE #Expected

	--SELECT 1 AS RowID
	--,'LoggerBase.Appender_ConsoleAppender' AS AppenderType
	--,'<appender name="Saved-Default-Console" type="LoggerBase.Appender_ConsoleAppender">
	--		<layout type="LoggerBase.Layout_PatternLayout">
	--			<conversionPattern value="%timestamp %level %logger-%message"/>
	--		</layout>
	--	</appender>' AS AppenderConfig
	--INTO #Expected

	--SET @RequestedLogLevelName = 'INFO'

	--EXEC LoggerBase.Config_Appenders_FilteredByLevel @Config = @InfoConfig, @RequestedLogLevelName = @RequestedLogLevelName, @Debug = 0

	----EXEC tSQLt.AssertEquals @Expected = @Expected, @Actual = @Actual

END;



GO
