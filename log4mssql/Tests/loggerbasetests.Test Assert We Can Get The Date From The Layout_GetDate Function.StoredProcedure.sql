USE [Log4MSSQLBuild]
GO
/****** Object:  StoredProcedure [loggerbasetests].[Test Assert We Can Get The Date From The Layout_GetDate Function]    Script Date: 02/13/2019 10:33:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [loggerbasetests].[Test Assert We Can Get The Date From The Layout_GetDate Function]
AS
BEGIN

	DECLARE @Expected DATE = CAST(GETDATE() AS DATE)
	DECLARE @Actual   DATE = LoggerBase.Layout_GetDate()

	EXEC tSQLt.AssertEquals @Expected = @Expected, @Actual = @Actual

END;
GO
