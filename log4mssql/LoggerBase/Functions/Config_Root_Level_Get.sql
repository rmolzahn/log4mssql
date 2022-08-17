CREATE FUNCTION LoggerBase.Config_Root_Level_Get
(
	-- Add the parameters for the function here
	 @Configuration NVARCHAR(MAX)
)
RETURNS NVARCHAR(10)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result NVARCHAR(10)

	SELECT @Result = ConfigXML.value('(/log4mssql/root/level/@value)[1]', 'nvarchar(10)')
        FROM LoggerBase.Config_Saved
        WHERE ConfigName = @Configuration
	RETURN @Result

END