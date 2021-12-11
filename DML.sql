/*DML COMMANDS*/


USE Covid_19
GO

--INSERTING DATA INTO ZONES TABLE USING PROCEDURE

EXEC spInsertZone 'Z1', 'GREEN'
EXEC spInsertZone 'Z2', 'YELLOW'
EXEC spInsertZone 'Z3', 'RED'
EXEC spInsertZone 'Z4', 'BLUE'
GO
SELECT * FROM Zones
GO

--UPDATE data from "Zone " table
EXEC spUpdateZone @ZoneID = 'Z4' , @ZoneName = 'WHITE'
GO 
SELECT * FROM Zones
GO
--DELETE data from "Zones" Table
EXEC spDeleteZone 'Z4'
GO
SELECT * FROM Zones
GO

--INSERTING DATA INTO AREAS TABLE

--RED ZONES
Exec spInsertAreas 'A1','Mirpur','Z1'
Exec spInsertAreas 'A2','Mohammadpur','Z1'
Exec spInsertAreas 'A3','Uttara','Z1'
-- YELLOW ZONES		
Exec spInsertAreas 'A4','Gulshan','Z2'
Exec spInsertAreas 'A5','Dhanmondi','Z2'
Exec spInsertAreas 'A6','Motijheel','Z2'
-- GREEN ZONES
Exec spInsertAreas 'A7','Sutrapur','Z3'
Exec spInsertAreas 'A8','Nobabgonj','Z3'
Exec spInsertAreas 'A9','Keranigonj','Z3'
Exec spInsertAreas 'A10','Narayangonj','Z3'
GO

--CHECKING DATA 
SELECT * FROM Areas
GO

--Updating data of "Area" Table usnign stored procedure
EXEC spUpdateAreas @AreaID = 'A10', @AreaName = 'Khilkhet', @CurrentZone = 'Z3'
GO
SELECT * FROM Areas
GO

--Updating data of "Area" Table usnign stored procedure
Exec spDeleteArea 'A10'
GO
SELECT * FROM Areas
GO

-- Inserting data into table DailyRecords


--INSERT data into the DailyRecords table
--DATE : 2021-07-01


EXEC spInsertDailyRecords '2021-07-01','A1',123,23,63
EXEC spInsertDailyRecords '2021-07-01','A2',65,20,25
EXEC spInsertDailyRecords '2021-07-01','A3',88,26,36
EXEC spInsertDailyRecords '2021-07-01','A4',50,12,14
EXEC spInsertDailyRecords '2021-07-01','A5',55,10,17
EXEC spinsertDailyRecords '2021-07-01','A6',53,12,33
EXEC spinsertDailyRecords '2021-07-01','A7',15,2,6
EXEC spinsertDailyRecords '2021-07-01','A8',19,5,3
EXEC spinsertDailyRecords '2021-07-01','A9',20,0,9
--DATE: 2021-07-02
EXEC spinsertDailyRecords'2021-07-02','A1',115,56,35
EXEC spinsertDailyRecords'2021-07-02','A2',60,15,35
EXEC spinsertDailyRecords'2021-07-02','A3',90,36,16
EXEC spinsertDailyRecords'2021-07-02','A4',70,22,24
EXEC spinsertDailyRecords'2021-07-02','A5',58,15,27
EXEC spinsertDailyRecords'2021-07-02','A6',56,18,32
EXEC spinsertDailyRecords'2021-07-02','A7',17,4,5
EXEC spinsertDailyRecords'2021-07-02','A8',21,7,2
EXEC spinsertDailyRecords '2021-07-02','A9',19,3,11
--DATE : 2021-07-03
EXEC spinsertDailyRecords '2021-07-03','A1',109,30,101
EXEC spinsertDailyRecords '2021-07-03','A2',99,31,21
EXEC spinsertDailyRecords '2021-07-03','A3',81,23,41
EXEC spinsertDailyRecords '2021-07-03','A4',59,23,21
EXEC spinsertDailyRecords '2021-07-03','A5',39,33,19
EXEC spinsertDailyRecords '2021-07-03','A6',46,23,25
EXEC spinsertDailyRecords '2021-07-03','A7',18,5,20
EXEC spinsertDailyRecords '2021-07-03','A8',20,10,12
EXEC spinsertDailyRecords '2021-07-03','A9',16,9,18
GO


DECLARE @CurrentDate DATE
		SET @CurrentDate = GETDATE()
EXEC spInsertDailyRecords @AreaId ='A1', @Date =@CurrentDate,
						  @NewCases= 123, @DeathCases = 23, @Cures = 33
GO
SELECT * FROM DailyRecords
GO

-- deletign data from DailyRecords

Exec spDeleteFromDailyRecords 'A1', '2021-07-05'
GO
-- CHECKING DATA 
SELECT * FROM DailyRecords
GO


--Checking the  procedure to get cases records of an area in a date range
EXEC spCaseRecord 'Mirpur','2021-07-01','2021-07-03'
GO
EXEC spCaseRecord 'Mohammadpur','2021-07-01','2021-07-03'
GO
EXEC spCaseRecord 'Gulshan','2021-07-01','2021-07-03'
GO
EXEC spCaseRecord 'Nobabgonj','2021-07-01','2021-07-03'
GO






