/*DDL COMANDS*/

/**CREATING A DATABASE ABOUT Covid_19 STATISTICS*/
IF db_id ('Covid_19') IS NULL
CREATE DATABASE Covid_19
GO

USE Covid_19
GO

-- CREATING A TABLE "ZONES"

CREATE TABLE Zones
(
	Zoneid NVARCHAR(5) primary key,
	ZoneName NVARCHAR (10) NOT NULL
)
GO

-- CREATIGN A TABLE "AREAS"

CREATE TABLE Areas
(
	AreaId NVARCHAR (5) PRIMARY KEY,
	AreaName NVARCHAR (20) NOT NULL,
	CurrentZone NVARCHAR(5) REFERENCES Zones(Zoneid) DEFAULT 'Z3'
)
GO
-- CREATIGN A TABLE "DailyRecords"

CREATE TABLE DailyRecords
(
	[Date] DATE DEFAULT GETDATE() NOT NULL,
	AreaID NVARCHAR (5) REFERENCES Areas(AreaId) NOT NULL,
	NewCases INT,
	DeathCases INT,
	Cured INT,
	PRIMARY KEY ([Date] , AreaId)
)
GO
-- CREATIGN A TABLE "ZONE"

CREATE TABLE ZoneTracks
(
	ZoneTrackID NVARCHAR (5) PRIMARY KEY,
	AreaID NVARCHAR(5) REFERENCES Areas(AreaID),
	ZoneId NVARCHAR (5) REFERENCES Zones(Zoneid),
	LastUpdateDate DATE
)
GO

-- creating a INSERT procedure to insert data into "Zones" Table

CREATE PROC spInsertZone 
@ZoneID NVARCHAR(10),
@ZoneName NVARCHAR(20)
AS

BEGIN TRY 

INSERT INTO Zones(Zoneid,ZoneName)
VALUES (@ZoneID,@ZoneName)
END TRY

BEGIN CATCH
DECLARE @msg  NVARCHAR (1000)
	SELECT @msg = ERROR_MESSAGE()
	;
	THROW 50001, @msg, 1
END CATCH
GO

-- creating a UPDATE procedure for "Zones" Table
CREATE PROC spUpdateZone 
@ZoneID NVARCHAR(10),
@ZoneName NVARCHAR(20)

AS
BEGIN TRY
	UPDATE Zones
	SET  ZoneName = ISNULL(@ZoneName,ZoneName)
	WHERE Zoneid = @ZoneID
END TRY
BEGIN CATCH
	DECLARE @msg  NVARCHAR(1000)
	SELECT @msg=ERROR_MESSAGE()
	;
	THROW 50001, @msg, 1
END CATCH
GO
-- creating a DELETE procedure to insert data into "Zones" Table

CREATE PROC spDeleteZone
@ZoneId NVARCHAR(10)
AS
BEGIN TRY
	DELETE Zones WHERE Zoneid=@ZoneId
END TRY
BEGIN CATCH
	DECLARE @msg  NVARCHAR(1000)
	SELECT @msg=ERROR_MESSAGE()
	;
	THROW 50001, @msg, 1
END CATCH
GO


												--//--

-- creating a INSERT procedure to insert data into "Areas" Table

CREATE PROC spInsertAreas
@AreaID NVARCHAR(10),
@AreaName NVARCHAR(20),
@CurrentZone NVARCHAR(10)
AS

BEGIN TRY 

INSERT INTO Areas(AreaId,AreaName,CurrentZone)
VALUES (@AreaID,@AreaName,@CurrentZone)
END TRY

BEGIN CATCH
DECLARE @msg  NVARCHAR (1000)
	SELECT @msg = ERROR_MESSAGE()
	;
	THROW 50001, @msg, 1
END CATCH
GO

-- creating a UPDATE procedure to update  data from "Area" Table
CREATE PROC spUpdateAreas
@AreaID NVARCHAR(10),
@AreaName NVARCHAR(20),
@CurrentZone NVARCHAR(10)

AS
BEGIN TRY
	UPDATE Areas
	SET  AreaName = ISNULL(@AreaName,AreaName), CurrentZone = ISNULL(@CurrentZone, CurrentZone)
	WHERE AreaId = @AreaID
END TRY
BEGIN CATCH
	DECLARE @msg  NVARCHAR(1000)
	SELECT @msg=ERROR_MESSAGE()
	;
	THROW 50001, @msg, 1
END CATCH
GO
-- creating a DELETE procedure to delete from "Area" Table

CREATE PROC spDeleteArea
@AreaId NVARCHAR(10)
AS
BEGIN TRY
	DELETE Areas WHERE AreaId=@AreaId
END TRY
BEGIN CATCH
	DECLARE @msg  NVARCHAR(1000)
	SELECT @msg=ERROR_MESSAGE()
	;
	THROW 50001, @msg, 1
END CATCH
GO

SELECT * FROM DailyRecords
GO								--//--
-- creating a INSERT procedure to insert data into "Daily Records" table
CREATE PROC spInsertDailyRecords 
@Date DATE,
@AreaID NVARCHAR(10),
@NewCases INT,
@DeathCases INT,
@Cures INT

AS
BEGIN TRY

		INSERT INTO DailyRecords ([Date],AreaID,NewCases,DeathCases,Cured) VALUES
		(@Date,@AreaID, @NewCases,@DeathCases,@Cures)
END TRY

BEGIN CATCH
	RAISERROR('Inserted already', 11, 1)
END CATCH
GO

--creating a update procedure of "DailyRecords"

CREATE PROC spUpdateDailyRecords
@Date DATE,
@AreaID NVARCHAR(10),
@NewCases INT,
@DeathCases INT,
@Cured INT

AS
	UPDATE DailyRecords
	SET  Date = ISNULL(@Date,Date),NewCases = ISNULL(@NewCases,NewCases),
	     DeathCases= ISNULL(@DeathCases,DeathCases),Cured = ISNULL(@Cured,Cured)
	WHERE AreaId = @AreaID
GO



--CREATE A DELETE PROCEDURE for "DailyRecords" Table

CREATE PROC spDeleteFromDailyRecords
@AreaID NVARCHAR (10),
@Date DATE
AS
BEGIN TRY
	 DELETE FROM DailyRecords
	 WHERE AreaID = @AreaID AND Date = @Date
	 --Date = @Date
END TRY

BEGIN CATCH
	RAISERROR('Data can not be Deleted', 11, 1)
END CATCH
GO
-----Creating a procedure to get cases records of an area/zone in a date range

CREATE PROC spCaseRecord 
@Area NVARCHAR(20),
@StartDate DATE,
@EndDate DATE
AS
SELECT DR.AreaID ,[Date], AreaName, NewCases, DeathCases, Cured 
FROM DailyRecords DR
INNER JOIN Areas AR ON DR.AreaID = AR.AreaId
WHERE AreaName = @Area AND  Date BETWEEN @StartDate AND @EndDate
GO

										--/**/--

--USE master
--GO
--DROP  DATABASE Covid_19
--GO