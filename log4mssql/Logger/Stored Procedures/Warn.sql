﻿IF OBJECT_ID('Logger.Warn') IS NOT NULL
SET NOEXEC ON
GO

CREATE PROCEDURE Logger.Warn
AS
	PRINT 'Stub only'
GO

SET NOEXEC OFF
GO
/*********************************************************************************************

    PROCEDURE Logger.Warn

    Date:           11/28/2017
    Author:         Jerome Pion
    Description:    Log a WARN level message.

    --TEST
	DECLARE @Config XML = '
	<log4mssql>
  <appender name="Test-Console" type="LoggerBase.Appender_ConsoleAppender">
    <layout type="LoggerBase.Layout_PatternLayout">
      <conversionPattern value="%timestamp %level %server %dbname %thread %logger-%message" />
    </layout>
  </appender>
  <root>
    <level value="DEBUG" />
    <appender-ref ref="Test-Console" />
  </root>
</log4mssql>
	'
	DECLARE @LogConfiguration LogConfiguration
	SET @LogConfiguration = Logger.Configuration_Set(@LogConfiguration, 'ConfigurationXml', CONVERT(NVARCHAR(MAX), @Config))
	EXEC Logger.Warn @Message = 'A test INFO message', @LogConfiguration = @LogConfiguration

**********************************************************************************************/

ALTER PROCEDURE Logger.Warn
(
	  @Message               VARCHAR(MAX)
	, @LoggerName            VARCHAR(500) = NULL
	, @Config                XML          = NULL
	, @StoredConfigName      VARCHAR(500) = NULL
	, @LogConfiguration      LogConfiguration = NULL
	, @Debug                 BIT          = 0
)

AS

    SET NOCOUNT ON

	BEGIN TRY
		DECLARE @TokenValues VARCHAR(MAX) = CONCAT(@@SERVERNAME, '|', DB_NAME(), '|', @@SPID)

		EXEC LoggerBase.Logger_Base 
		  @Message               = @Message
		, @LoggerName            = @LoggerName
		, @RequestedLogLevelName = 'WARN'
		, @Config                = @Config
		, @StoredConfigName      = @StoredConfigName
		, @LogConfiguration      = @LogConfiguration
		, @TokenValues           = @TokenValues
		, @Debug                 = @DEBUG
	END TRY
	BEGIN CATCH
		DECLARE @ErrorMessage VARCHAR(8000) = CONCAT('[',OBJECT_SCHEMA_NAME(@@PROCID),'].[',OBJECT_NAME(@@PROCID),'] An error occurred in the logging framework: ', ERROR_MESSAGE(), ' (', ERROR_NUMBER(), ')')
		PRINT @ErrorMessage
	END CATCH

