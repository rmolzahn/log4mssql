CREATE PROCEDURE LoggerBase.Config_Root_Level_Set
(
	-- Add the parameters for the function here
	 @Configuration NVARCHAR(MAX),
	 @Level         NVARCHAR(10)
)

AS
DECLARE @Message NVARCHAR(255)
BEGIN

    IF (@Level = 'ALL') BEGIN
        UPDATE LoggerBase.Config_Saved
        SET ConfigXML.modify('replace value of (/log4mssql/root/level/@value)[1] with "ALL" ')
        where ConfigName = @Configuration
    END
    ELSE IF (@Level = 'DEBUG') BEGIN
        UPDATE LoggerBase.Config_Saved
        SET ConfigXML.modify('replace value of (/log4mssql/root/level/@value)[1] with "DEBUG" ')
        where ConfigName = @Configuration
    END
    ELSE IF (@Level = 'INFO') BEGIN
        UPDATE LoggerBase.Config_Saved
        SET ConfigXML.modify('replace value of (/log4mssql/root/level/@value)[1] with "INFO" ')
        where ConfigName = @Configuration
    END
    ELSE IF (@Level = 'WARN') BEGIN
        UPDATE LoggerBase.Config_Saved
        SET ConfigXML.modify('replace value of (/log4mssql/root/level/@value)[1] with "WARN" ')
        where ConfigName = @Configuration
    END
    ELSE IF (@Level = 'ERROR') BEGIN
        UPDATE LoggerBase.Config_Saved
        SET ConfigXML.modify('replace value of (/log4mssql/root/level/@value)[1] with "ERROR" ')
        where ConfigName = @Configuration
    END
    ELSE IF (@Level = 'FATAL') BEGIN
        UPDATE LoggerBase.Config_Saved
        SET ConfigXML.modify('replace value of (/log4mssql/root/level/@value)[1] with "FATAL" ')
        where ConfigName = @Configuration
    END
    ELSE
        SET @Message = 'Unknown Level specified '+@Level
        PRINT @Message
        RAISERROR(@Message, 10, 1)
    END