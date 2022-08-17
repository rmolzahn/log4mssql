CREATE PROCEDURE LoggerBase.Session_Level_Set(@newlevel nvarchar(10))
AS

BEGIN
    EXEC [sys].[sp_set_session_context] @key = N'LOGLEVEL'
                                       ,@value = @newlevel;
END
go
