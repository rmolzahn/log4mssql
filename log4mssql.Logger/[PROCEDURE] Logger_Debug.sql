PRINT 'PROCEDURE Logger.Debug CREATED 07/07/2017'
GO

IF OBJECT_ID('Logger.Debug') IS NOT NULL
BEGIN
    PRINT '   DROP PROCEDURE Logger.Debug'
    DROP PROCEDURE Logger.Debug
END
GO

PRINT '   CREATE PROCEDURE Logger.Debug'
GO

/*********************************************************************************************

    PROCEDURE Logger.Debug

    Date:           07/07/2017
    Author:         Jerome Pion
    Description:    Log a DEBUG level message.

    --TEST
	EXEC Logger.Debug 'A test debug message', 'Test Logger'
	EXEC Logger.Debug @Message = 'A test debug message', @LoggerName = 'Test Logger', @Debug = 1

	EXEC LoggerBase.Session_Level_Set 'DEBUG', @Debug = 1
	SELECT LoggerBase.Session_ContextID_Get()
	SELECT LoggerBase.Session_Level_Get()
	
	EXEC Logger.Debug 'A test debug message', 'Test Logger'
	EXEC Logger.Debug @Message = 'A test debug message', @LoggerName = 'Test Logger', @Debug = 1

**********************************************************************************************/

CREATE PROCEDURE Logger.Debug
(
	  @Message               VARCHAR(MAX)
	, @LoggerName            VARCHAR(500)
	, @Config                XML          = NULL
	, @StoredConfigName      VARCHAR(500) = NULL
	, @Debug                 BIT          = 0
)

AS

    SET NOCOUNT ON

	EXEC LoggerBase.Logger_Base 
	  @Message               = @Message
	, @LoggerName            = @LoggerName
	, @RequestedLogLevelName = 'DEBUG'
	, @Config                = @Config
	, @StoredConfigName      = @StoredConfigName
	, @Debug                 = @Debug

GO

IF @@ERROR = 0
BEGIN
    PRINT '   PROCEDURE Logger.Debug CREATED SUCCESSFULLY'
END
ELSE
BEGIN
    PRINT '   CREATE PROCEDURE Logger.Debug FAILED!'
END
GO
