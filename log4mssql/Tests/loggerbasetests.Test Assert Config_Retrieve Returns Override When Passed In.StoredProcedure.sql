USE [Log4MSSQLBuild]
GO
/****** Object:  StoredProcedure [loggerbasetests].[Test Assert Config_Retrieve Returns Override When Passed In]    Script Date: 02/13/2019 10:33:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [loggerbasetests].[Test Assert Config_Retrieve Returns Override When Passed In]
AS
BEGIN

	
	DECLARE @ExpectedConfig VARCHAR(1000) = '<log4mssql>OVERRIDE</log4mssql>'

	DECLARE @Config XML

	EXEC LoggerBase.Config_Retrieve @Override = @ExpectedConfig, @Config = @Config OUTPUT

	DECLARE @Actual VARCHAR(1000) = CONVERT(VARCHAR(1000), @Config)

	EXEC tSQLt.AssertEquals @Expected = @ExpectedConfig, @Actual = @Actual

END;
GO
