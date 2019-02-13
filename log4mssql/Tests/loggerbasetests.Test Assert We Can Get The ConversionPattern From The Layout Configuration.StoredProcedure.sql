USE [Log4MSSQLBuild]
GO
/****** Object:  StoredProcedure [loggerbasetests].[Test Assert We Can Get The ConversionPattern From The Layout Configuration]    Script Date: 02/13/2019 10:33:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [loggerbasetests].[Test Assert We Can Get The ConversionPattern From The Layout Configuration]
AS
BEGIN

	DECLARE @Config XML = '<layout type="LoggerBase.Layout_PatternLayout">
	<conversionPattern value="ConversionPatternToReturn"/>
	</layout>'

	DECLARE @Expected VARCHAR(1000) = 'ConversionPatternToReturn'
	DECLARE @Actual   VARCHAR(1000) = (SELECT LoggerBase.Layout_GetConversionPatternFromConfig(@Config))

	EXEC tSQLt.AssertEquals @Expected = @Expected, @Actual = @Actual

END;
GO
