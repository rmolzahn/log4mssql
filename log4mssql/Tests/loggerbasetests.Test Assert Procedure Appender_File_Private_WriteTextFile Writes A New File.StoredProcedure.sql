USE [Log4MSSQLBuild]
GO
/****** Object:  StoredProcedure [loggerbasetests].[Test Assert Procedure Appender_File_Private_WriteTextFile Writes A New File]    Script Date: 02/13/2019 10:33:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [loggerbasetests].[Test Assert Procedure Appender_File_Private_WriteTextFile Writes A New File]
AS
BEGIN
	--SELECT [LoggerBase].[Appender_File_WriteTextFile]('Just a test message', 'C:\Temp\FileAppenderTest.txt', 0)
	DECLARE 	 
	 @text   NVARCHAR(4000) = N'Just a test message'
	,@path   NVARCHAR(4000) = N'C:\Temp\FileAppenderTest.txt'
	,@append BIT = 0
	,@exitCode INT 
	,@errorMessage NVARCHAR(4000) 

	EXEC LoggerBase.Appender_File_Private_WriteTextFile 
	@text = @text
	,@path = @path
	,@append = @append
	,@exitCode = @exitCode OUTPUT
	,@errorMessage = @errorMessage OUTPUT
END;
GO
