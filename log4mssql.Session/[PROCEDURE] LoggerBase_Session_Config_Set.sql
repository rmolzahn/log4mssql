PRINT 'PROCEDURE LoggerBase.Session_Config_Set CREATED 07/12/2017'
GO

IF OBJECT_ID('LoggerBase.Session_Config_Set') IS NOT NULL
BEGIN
    PRINT '   DROP PROCEDURE LoggerBase.Session_Config_Set'
    DROP PROCEDURE LoggerBase.Session_Config_Set
END
GO

PRINT '   CREATE PROCEDURE LoggerBase.Session_Config_Set'
GO

/*********************************************************************************************

    PROCEDURE LoggerBase.Session_Config_Set

    Date:           07/12/2017
    Author:         Jerome Pion
    Description:    Returns the lowest-level config given the current state. 
					The order of preference is:
					*Passed in config XML
					*Saved config name
					*Session config
					*Saved default config
					*Hard-coded config

    --TEST

**********************************************************************************************/

CREATE PROCEDURE LoggerBase.Session_Config_Set
(
	 @Override XML = NULL
    ,@Config XML OUTPUT
	,@Debug  BIT = 0
)

AS

    SET NOCOUNT ON

	IF EXISTS (SELECT * FROM LoggerBase.Config_SessionContext
		WHERE SessionContextID = LoggerBase.Session_ContextID_Get()
	)
	BEGIN
		UPDATE LoggerBase.Config_SessionContext
		SET Config = @Config
		WHERE SessionContextID = LoggerBase.Session_ContextID_Get()
	END
	ELSE
	BEGIN
		DECLARE @SessionID UNIQUEIDENTIFIER = NEWID()
		INSERT INTO LoggerBase.Config_SessionContext
		(SessionContextID, Config, OverrideLogLevelName, ExpirationDatetimeUTC)
		VALUES (@SessionID, @Config, NULL, DATEADD(DAY, 1, GETUTCDATE()))
		
		EXEC LoggerBase.Session_Config_Set @SessionID

	END

GO

IF @@ERROR = 0
BEGIN
    PRINT '   PROCEDURE LoggerBase.Session_Config_Set CREATED SUCCESSFULLY'
END
ELSE
BEGIN
    PRINT '   CREATE PROCEDURE LoggerBase.Session_Config_Set FAILED!'
END
GO
