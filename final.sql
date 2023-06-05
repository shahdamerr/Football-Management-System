
go

CREATE PROCEDURE createAllTables
	AS
	BEGIN
	CREATE TABLE SystemUser(
		username VARCHAR(20) PRIMARY KEY,
		password VARCHAR(20)
		)

	CREATE TABLE SportsAssociationManager(
		username VARCHAR(20),
		name VARCHAR(20),
		ID INT PRIMARY KEY IDENTITY,
		FOREIGN KEY (username) REFERENCES SystemUser 
		ON UPDATE NO ACTION 
		ON DELETE NO ACTION 
		)

	CREATE TABLE SystemAdmin(
		username VARCHAR(20),
		name VARCHAR(20),
		ID INT PRIMARY KEY IDENTITY,
		FOREIGN KEY (username) REFERENCES SystemUser
		ON UPDATE NO ACTION  
		ON DELETE NO ACTION 
		)

	CREATE TABLE Fan(
		username VARCHAR(20),
		national_ID VARCHAR(20) PRIMARY KEY,
		name VARCHAR(20),
		birth_date DATETIME,
		address VARCHAR(20),
		phone_no INT,
		status BIT NOT NULL DEFAULT 1,
		FOREIGN KEY (username) REFERENCES SystemUser
		ON UPDATE CASCADE 
		ON DELETE CASCADE
		)

	CREATE TABLE Stadium(
		ID INT PRIMARY KEY IDENTITY,
		name VARCHAR(20),
		location VARCHAR(20),
		capacity INT,
		status BIT NOT NULL DEFAULT 1
		)

	CREATE TABLE Club(
		club_ID INT PRIMARY KEY IDENTITY,
		name VARCHAR(20),
		location VARCHAR(20)
		)

	CREATE TABLE StadiumManager(
		username VARCHAR(20),
		name VARCHAR(20),
		ID INT PRIMARY KEY IDENTITY,
		stadium_ID INT,
		FOREIGN KEY (username) REFERENCES SystemUser
		ON UPDATE NO ACTION  
		ON DELETE NO ACTION ,
		FOREIGN KEY (Stadium_ID) REFERENCES Stadium 
		ON UPDATE CASCADE  
		ON DELETE CASCADE 
		)

	CREATE TABLE ClubRepresentative(
		username VARCHAR(20),
		name VARCHAR(20),
		ID INT PRIMARY KEY IDENTITY,
		club_ID INT,
		FOREIGN KEY (username) REFERENCES SystemUser
		ON UPDATE NO ACTION  
		ON DELETE NO ACTION ,
		FOREIGN KEY (club_ID) REFERENCES Club 
		ON UPDATE CASCADE 
		ON DELETE CASCADE
		)

	CREATE TABLE Match(
		match_ID INT PRIMARY KEY IDENTITY,
		start_time DATETIME,
		end_time DATETIME,
		host_club_ID INT,
		guest_club_ID INT,
		stadium_ID INT, 
		FOREIGN KEY (host_club_ID) REFERENCES Club 
		ON UPDATE NO ACTION   
		ON DELETE NO ACTION , 
		FOREIGN KEY (guest_club_ID) REFERENCES Club 
		ON UPDATE NO ACTION   
		ON DELETE NO ACTION,
		FOREIGN KEY (Stadium_ID) REFERENCES Stadium 
		ON UPDATE NO ACTION  
		ON DELETE NO ACTION
		)

	CREATE TABLE HostRequest(
		ID INT PRIMARY KEY IDENTITY,
		representative_ID INT,
		manager_ID INT,
		match_ID INT,
		status VARCHAR(20) NOT NULL DEFAULT 'UNHANDLED', 
		CHECK (status IN ('UNHANDLED', 'ACCEPTED', 'REJECTED')),
		FOREIGN KEY (representative_ID) REFERENCES ClubRepresentative
		ON UPDATE CASCADE 
		ON DELETE SET NULL,
		FOREIGN KEY (manager_ID) REFERENCES StadiumManager 
		ON UPDATE CASCADE 
		ON DELETE SET NULL,
		FOREIGN KEY (match_ID) REFERENCES Match 
		ON UPDATE CASCADE 
		ON DELETE SET NULL
		)

	CREATE TABLE Ticket (
		ID INT PRIMARY KEY IDENTITY,
		status BIT NOT NULL DEFAULT 1, 
		match_ID INT, 
		FOREIGN KEY (match_ID) REFERENCES Match 
		ON UPDATE NO ACTION   
		ON DELETE NO ACTION 
		)

	CREATE TABLE Ticket_Buying_Transaction(
		fan_national_ID VARCHAR(20),
		ticket_ID INT ,
		FOREIGN KEY (fan_national_ID) REFERENCES Fan 
		ON UPDATE CASCADE 
		ON DELETE CASCADE,
		FOREIGN KEY (ticket_ID) REFERENCES Ticket 
		ON UPDATE CASCADE 
		ON DELETE CASCADE
		)

	END

GO

CREATE PROCEDURE dropAllTables
 AS
 BEGIN
 DROP TABLE Ticket_Buying_Transaction
 DROP TABLE Ticket
 DROP TABLE HostRequest
 DROP TABLE Match
 DROP TABLE ClubRepresentative
 DROP TABLE Club
 DROP TABLE StadiumManager
 DROP TABLE Stadium
 DROP TABLE Fan 
 DROP TABLE SystemAdmin
 DROP TABLE SportsAssociationManager
 DROP TABLE SystemUser
 END


GO

CREATE PROCEDURE clearAllTables
 AS
 BEGIN
 DELETE FROM Ticket_Buying_Transaction

 DELETE FROM Ticket
 DBCC CHECKIDENT (Ticket, RESEED, 0);

 DELETE FROM HostRequest
 DBCC CHECKIDENT (HostRequest, RESEED, 0);

 DELETE FROM Match
 DBCC CHECKIDENT (Match, RESEED, 0);

 DELETE FROM ClubRepresentative
 DBCC CHECKIDENT (ClubRepresentative, RESEED, 0);

 DELETE FROM Club
 DBCC CHECKIDENT (Club, RESEED, 0);

 DELETE FROM StadiumManager
 DBCC CHECKIDENT (StadiumManager, RESEED, 0);

 DELETE FROM Stadium
 DBCC CHECKIDENT (Stadium, RESEED, 0);

 DELETE FROM Fan 

 DELETE FROM SystemAdmin
 DBCC CHECKIDENT (SystemAdmin, RESEED, 0);

 DELETE FROM SportsAssociationManager
 DBCC CHECKIDENT (SportsAssociationManager, RESEED, 0);

 DELETE FROM SystemUser

 END


GO

 CREATE VIEW allAssocManagers AS
    SELECT am.username, u.password, am.name
    FROM SportsAssociationManager am INNER JOIN SystemUser u ON (am.username=u.username)

GO

 CREATE VIEW allClubRepresentatives AS
    SELECT cr.username, u.password, cr.name AS Club_Rep_Name, c.name AS Club_Name
    FROM ClubRepresentative cr INNER JOIN SystemUser u ON (cr.username=u.username) 
    INNER JOIN Club c ON (cr.club_ID=c.club_ID)

GO

 CREATE VIEW allStadiumManagers AS
    SELECT sm.username, u.password, sm.name AS Stad_manager_Name, s.name AS Stad_Name
    FROM StadiumManager sm INNER JOIN SystemUser u ON (sm.username=u.username) 
    INNER JOIN Stadium s ON (sm.stadium_ID=s.ID)

GO 

 CREATE VIEW allFans AS
    SELECT f.username, u.password, f.name, f.national_ID, f.birth_date, f.status
    from Fan f inner join SystemUser u on (f.username=u.username)

GO

 CREATE VIEW allMatches AS
    SELECT host.name AS Host, guest.name AS Guest, m.start_time
    FROM Match m 
    INNER JOIN Club host on (m.host_club_ID=host.club_ID) 
    INNER JOIN Club guest on (m.guest_club_ID=guest.club_ID)

GO

 CREATE VIEW  allTickets AS
    SELECT host.name AS Host, guest.name AS Guest, s.name AS Stadium, m.start_time
    FROM Match m INNER JOIN Club host ON (m.host_club_ID=host.club_ID)
    INNER JOIN Club guest ON (m.guest_club_ID=guest.club_ID)
    INNER JOIN Stadium s ON (s.ID = m.stadium_ID)
    WHERE m.match_ID IN(SELECT DISTINCT t.match_ID FROM Ticket t)

GO

 CREATE VIEW allCLubs AS
    SELECT c.name, c.location
    FROM Club c

GO

 CREATE VIEW allStadiums AS
    SELECT s.name, s.location, s.capacity, s.status
    FROM Stadium s

GO

 CREATE VIEW allRequests AS
    SELECT cr.username AS Club_Rep_Username, sm.username AS Stad_Manager_Username, h.status
    FROM HostRequest h
    INNER JOIN ClubRepresentative cr on (h.representative_ID = cr.ID)
    INNER JOIN StadiumManager sm on (h.manager_ID = sm.ID)

GO

 CREATE PROC addAssociationManager @name VARCHAR(20), @username VARCHAR(20), @pass VARCHAR(20),
@flag int output
 AS
 BEGIN
 SET @flag=1
    IF(NOT EXISTS(SELECT username FROM SystemUser WHERE username=@username))
    BEGIN
        INSERT INTO SystemUser(
            username, 
            password) 
        VALUES(
            @username,
            @pass)

        INSERT INTO SportsAssociationManager(
            username, 
            name) 
        VALUES(
            @username, 
            @name)
    END
    ELSE
    BEGIN
    set @flag = 0
    End

 END



GO

CREATE PROC addNewMatch @hostClub VARCHAR(20), @guestClub VARCHAR(20), @startTime DATETIME, @endTime DATETIME,
@flag int output
 AS
 BEGIN
    set @flag=1
    
    DECLARE @hostID INT

    DECLARE @guestID INT

    SELECT @hostID = c.club_ID
    FROM Club c
    WHERE c.name = @hostClub

    SELECT @guestID = c.club_ID
    FROM Club c
    WHERE c.name = @guestClub


    IF(NOT EXISTS(SELECT host_club_ID,guest_club_ID FROM Match where host_club_ID=@hostID AND guest_club_ID=@guestID AND start_time=@startTime AND end_time=@endTime ) )
    BEGIN
   
    INSERT INTO Match(
        start_time, 
        end_time, 
        host_club_ID, 
        guest_club_ID) 
    VALUES(
        @startTime, 
        @endTime,
        @hostID,
        @guestID)

 END
 ELSE 
 BEGIN
 SET @flag=0
 END
 END
 go

 
CREATE VIEW clubsWithNoMatches 
    AS 
        SELECT c.name
        FROM Club c
        WHERE NOT EXISTS (SELECT m.host_club_ID
        FROM Match m
        WHERE c.club_ID=m.host_club_ID) AND NOT EXISTS (SELECT m1.guest_club_ID
        FROM Match m1
        WHERE c.club_ID=m1.guest_club_ID)



GO

CREATE PROC deleteMatch @hostClub VARCHAR(20), @guestClub VARCHAR(20),@flag int output
 AS
 BEGIN
    DECLARE @hostID INT
    SET @flag=1

    SELECT @hostID = c.club_ID
    FROM Club c
    WHERE c.name = @hostClub
    

    IF( EXISTS(SELECT host_club_ID FROM Match where host_club_ID=@hostID))
    BEGIN

    DECLARE @guestID INT

    SELECT @guestID = c.club_ID
    FROM Club c
    WHERE c.name = @guestClub

    DECLARE @matchID INT
    SELECT @matchID =match_ID
    FROM Match WHERE 
    host_club_ID = @hostID  AND  
    guest_club_ID = @guestID 

    DELETE FROM Ticket
    WHERE match_ID=@matchID

    DELETE FROM Match WHERE 
    host_club_ID = @hostID  AND  
    guest_club_ID = @guestID 

 END
 ELSE 
 BEGIN 
 SET @flag=0
 END
 END

 
 


GO

CREATE PROC deleteMatchesOnStadium @name VARCHAR(20)
 AS
 BEGIN

    DECLARE @stadiumID INT

    SELECT @stadiumID = s.ID
    FROM Stadium s
    WHERE s.name = @name

    DECLARE @matchID INT
    SELECT @matchID =match_ID
    FROM Match WHERE 
    stadium_ID = @stadiumID AND start_time>CURRENT_TIMESTAMP

    DELETE FROM Ticket
    WHERE match_ID=@matchID

    DELETE FROM Match WHERE 
    stadium_ID = @stadiumID AND start_time>CURRENT_TIMESTAMP

 END

GO

CREATE PROC addClub @name VARCHAR(20), @location VARCHAR(20),@flag int output
 AS
 BEGIN
    set @flag=1
    IF(NOT EXISTS(SELECT name FROM Club where name=@name))
    BEGIN
        INSERT INTO Club(
            name, 
            location) 
        VALUES(
            @name,
            @location)
    END
    ELSE
	  BEGIN
	  SET @flag = 0
	  END
 END

GO



CREATE PROC addTicket @hostClub VARCHAR(20), @guestClub VARCHAR(20), @startTime DATETIME
 AS
 BEGIN

 DECLARE @hostID INT

    SELECT @hostID = c.club_ID
    FROM Club c
    WHERE c.name = @hostClub

 DECLARE @guestID INT

    SELECT @guestID = c.club_ID
    FROM Club c
    WHERE c.name = @guestClub

 DECLARE @matchID INT

    SELECT @matchID = m.match_ID
    FROM Match m
    WHERE m.start_time = @startTime AND
    m.host_club_ID = @hostID AND m.guest_club_ID = @guestID 


 INSERT INTO Ticket(
        status, 
        match_ID) 
    VALUES(
        1,
        @matchID)

 END

GO

CREATE PROCEDURE deleteClub @clubname VARCHAR(20),@flag int output
    AS
    BEGIN

    SET @flag=1

    IF(NOT EXISTS(SELECT name FROM Club where name=@clubname))
    BEGIN
    SET
        @flag=0
        return
        END
    ELSE
    BEGIN
        DECLARE @clubID INT
        SELECT @clubID = c.club_ID
        FROM Club c
        WHERE c.name = @clubname

        DECLARE @clubRepUser VARCHAR(20)
        SELECT @clubRepUser=r.username
        FROM ClubRepresentative r
        WHERE r.club_ID=@clubID

        DECLARE @matchID INT
        SELECT @matchID = match_ID
        FROM Match WHERE 
        host_club_ID IN (SELECT c.club_ID
                        FROM Club c
                        WHERE c.name=@clubname)
                        OR 
        guest_club_ID IN (SELECT c.club_ID
                        FROM Club c
                        WHERE c.name=@clubname)

        DELETE FROM Ticket
        WHERE match_ID=@matchID

        DELETE FROM Match WHERE 
        host_club_ID IN (SELECT c.club_ID
                        FROM Club c
                        WHERE c.name=@clubname)
                        OR 
        guest_club_ID IN (SELECT c.club_ID
                        FROM Club c
                        WHERE c.name=@clubname)

        DELETE FROM Club WHERE 
        name=@clubname

        DELETE FROM SystemUser WHERE
        username=@clubRepUser
        END
        
    END
    
GO
 
CREATE PROCEDURE addStadium @StadiumName VARCHAR(20), @Location VARCHAR(20), @capacity INT,@flag int output
 AS
 BEGIN 
    set @flag=1
    IF(NOT EXISTS(SELECT name FROM Stadium where name=@StadiumName))
    BEGIN
	INSERT INTO Stadium(
	name,
	location,
	capacity)
	Values(
	@StadiumName,
	@Location,
	@capacity)
 END
 ELSE
 BEGIN
 set @flag=0
 END
 END

 


GO

CREATE PROCEDURE deleteStadium @StadiumName VARCHAR(20),@flag int output
    AS
    BEGIN
    SET @flag=1

    IF(NOT EXISTS(SELECT name FROM Stadium where name=@StadiumName))
    BEGIN
    SET
        @flag=0
        return
        END
    ELSE
    BEGIN
        DECLARE @stadiumID INT 

	    SELECT @stadiumID = s.ID 
	    FROM Stadium s 
	    WHERE s.name=@StadiumName

        DECLARE @stadUser VARCHAR(20)
        SELECT @stadUser=s.username
        FROM StadiumManager s
        WHERE s.stadium_ID=@stadiumID

        DECLARE @matchID INT 

	    SELECT @matchID = m.match_ID
	    FROM Match m 
	    WHERE m.stadium_ID=@stadiumID

        UPDATE Match
        SET stadium_ID=NULL
        WHERE match_ID=@matchID

        DELETE FROM Ticket
        WHERE match_ID=@MatchID

        DELETE FROM Stadium WHERE 
        name=@StadiumName

        DELETE FROM SystemUser WHERE
        username=@stadUser
    END
    END
    
GO 

CREATE PROCEDURE blockFan @fan_id VARCHAR(20),@flag int output,@status int output
    AS 
    BEGIN 
    SET @flag=1
    if (not exists (select national_ID from Fan where national_ID=@fan_id))
    BEGIN
        set @flag=0
    END
    ELSE if ( exists (select national_ID from Fan where national_ID=@fan_id AND status=1))
        begin
        UPDATE Fan
        SET STATUS=0
        WHERE national_ID=@fan_id
        set @flag=1
        end
    else
        begin
        set @status=0
        end


    END
    
GO 

CREATE PROCEDURE unblockFan @fan_id VARCHAR(20)
    AS 
    BEGIN 
        UPDATE Fan
        SET STATUS=1
        WHERE national_ID=@fan_id

    END

GO

CREATE PROCEDURE addRepresentative @Rep_name VARCHAR(20), @club_name VARCHAR(20), @username VARCHAR(20), @password VARCHAR(20),
@flag int output, @flag1 int output
    AS
    BEGIN
    SET @flag = 1
	set @flag1 = 1
        IF(NOT EXISTS(SELECT username FROM SystemUser WHERE username=@username))
            BEGIN
			if (exists (select name from Club where name=@club_name))
			
			BEGIN
            INSERT INTO SystemUser(
            username,
            password)
            VALUES(
            @username,
            @password)

            DECLARE @clubID INT 
            SELECT @clubID=c.club_ID
            FROM Club c
            WHERE c.name=@club_name

            INSERT INTO ClubRepresentative(
            username,
            name,
            club_ID)
            VALUES(
            @username,
            @Rep_name,
            @clubID)
        END
		Else
		begin
		set @flag1=0
		end
		end
        ELSE
        BEGIN
        SET @flag=0
        end

    END
    
GO


CREATE FUNCTION viewAvailableStadiumsOn (@dateTime DATETIME)
    RETURNS TABLE 
    AS
    RETURN 
    (SELECT s.name,s.location,s.capacity
    FROM Stadium s
    WHERE s.status=1 AND NOT EXISTS (SELECT m1.stadium_ID
                                    FROM Match m1
                                    WHERE m1.stadium_ID=s.ID AND @dateTime BETWEEN m1.start_time AND m1.end_time)
                                    )  

GO


CREATE PROCEDURE addHostRequest @clubName VARCHAR(20), @stadiumName VARCHAR(20), @dateTime datetime
    AS
    BEGIN
        DECLARE @clubID INT
            SELECT @clubID=c.club_ID
            FROM Club c
            WHERE c.name=@clubname

        DECLARE @repID int
            SELECT  @repID=r.ID
            FROM ClubRepresentative r
            WHERE r.club_ID=@clubID

        DECLARE @matchID int
            SELECT @matchID=m.match_ID
            FROM Match m
            WHERE m.start_time=@dateTime AND m.host_club_ID=@clubID 

        DECLARE @stadiumID int
            SELECT @stadiumID=s.ID
            FROM Stadium s
            WHERE s.name=@stadiumName

        DECLARE @managerID int
            SELECT @managerID= m.ID
            FROM StadiumManager m
            WHERE m.stadium_ID=@stadiumID


        INSERT INTO HostRequest(
        representative_ID,
        manager_ID,
        match_ID)
        VALUES(
        @repID,
        @managerID,
        @matchID)

    END

GO

CREATE FUNCTION GetIDClub(@clubname VARCHAR(20))    
    RETURNS INT
    AS
    BEGIN
        DECLARE @ID INT
        SELECT @ID=c.club_ID
        FROM Club c
        WHERE c.name=@clubname
    RETURN @ID
    END

GO

CREATE FUNCTION allUnassignedMatches(@clubname VARCHAR(20))
    RETURNS TABLE 
    AS
    RETURN
    (
    SELECT  guest.name, m.start_time  --name of guest club
    FROM Match m LEFT OUTER JOIN HostRequest r on (m.match_ID=r.match_ID)
                INNER JOIN  Club host on (m.host_club_ID=host.club_ID)
                INNER JOIN  Club guest on (m.guest_club_ID=guest.club_ID)
    WHERE (r.status= 'UNHANDLED' OR m.stadium_ID IS NULL) AND m.host_club_ID=dbo.GetIDClub(@clubname) )

GO

CREATE PROCEDURE addStadiumManager @name VARCHAR(20), @stadium_name VARCHAR(20), @username VARCHAR(20), @password VARCHAR(20)
, @flag int output , @flag1 int output
    AS
    BEGIN
    set @flag = 1
	set @flag1 = 1
        IF(NOT EXISTS(SELECT username FROM SystemUser WHERE username=@username))
		BEGIN

		IF (EXISTS(SELECT name from Stadium WHERE name=@stadium_name))		
        BEGIN
        DECLARE @sid INT
        SELECT @sid = s.ID
        FROM Stadium s
        WHERE s.name=@stadium_name

        INSERT INTO SystemUser (username, password) 
        VALUES (@username, @password)

        INSERT INTO StadiumManager (username, name, stadium_ID)
        VALUES (@username, @name, @sid)
      END

	  ELSE
	  BEGIN
	  SET @flag1 = 0
	  END

	  END

      ELSE 
      BEGIN
      set @flag=0
      end

    END

    
GO

CREATE FUNCTION GetIDStadiumManager(@managerUsername VARCHAR(20))
    RETURNS INT
    AS
    BEGIN
        DECLARE @ID int
        SELECT @ID=m.ID
        FROM StadiumManager m
        WHERE m.username=@managerUsername
    RETURN @ID
    END

GO


CREATE FUNCTION allPendingRequests (@stadiumManagerUsername VARCHAR(20))
    RETURNS TABLE
    AS
    RETURN(
    SELECT rep.name AS Club_Rep, guest.name AS Guest_Club, m.start_time
    FROM Match m INNER JOIN HostRequest r on (m.match_ID=r.match_ID)
            INNER JOIN ClubRepresentative rep on (r.representative_ID=rep.id)
            INNER JOIN Club guest on (m.guest_club_ID=guest.club_ID)
    WHERE r.status='UNHANDLED' AND r.manager_ID=dbo.GetIDStadiumManager(@stadiumManagerUsername))
GO

CREATE FUNCTION getClubName (@ID INT)
    RETURNS VARCHAR(20)
    AS
    BEGIN
    DECLARE @name VARCHAR(20)
    SELECT @name=c.name
    FROM Club c
    WHERE c.club_ID = @ID

    RETURN @name
    END

GO


CREATE PROCEDURE acceptRequest @username VARCHAR(20), @host VARCHAR(20), @guest VARCHAR(20), @start DATETIME
    AS
    BEGIN

    DECLARE @mid INT
    DECLARE @stadiumID INT

    Select @mid = m.ID, @stadiumID = m.stadium_ID
    FROM StadiumManager m
    WHERE m.username=@username

    DECLARE @matchid INT
    SELECT @matchid = m1.match_ID
    FROM Match m1
    WHERE m1.start_time = @start 
    AND dbo.getClubName(m1.host_club_ID) = @host
    AND dbo.getClubName(m1.guest_club_ID) = @guest

    UPDATE HostRequest
    SET status = 'ACCEPTED'
    WHERE manager_ID = @mid And match_ID = @matchid

    UPDATE Match 
    SET stadium_ID = @stadiumID 
    WHERE match_ID = @matchid

    --adding tickets 
    DECLARE @capacity INT

    SELECT @capacity=s.capacity
    FROM Stadium s
    WHERE s.ID=@stadiumID

    DECLARE @i INT 
    SET @i=1

    WHILE (@i<=@capacity)
    BEGIN
        EXECUTE addTicket @host, @guest, @start
        SET @i=@i+1

    END
    END
GO 

CREATE PROCEDURE rejectRequest @username VARCHAR(20), @host VARCHAR(20), @guest VARCHAR(20), @start DATETIME
    AS
    BEGIN

    DECLARE @mid int
    SELECT @mid = m.ID
    FROM StadiumManager m
    WHERE m.username=@username

    DECLARE @matchid int
    SELECT @matchid = m.match_ID
    FROM Match m
    WHERE m.start_time = @start 
    AND dbo.getClubName(m.host_club_ID) = @host
    AND dbo.getClubName(m.guest_club_ID) = @guest

    UPDATE HostRequest
    SET status = 'REJECTED'
    WHERE manager_ID = @mid And match_ID = @matchid

    END

GO

CREATE PROCEDURE addFan (@name VARCHAR(20), @username VARCHAR(20), @password VARCHAR(20), @national_ID VARCHAR(20), @birthdate DATETIME, @address VARCHAR(20), @phone INT,
    @flag int output, @flag1 int output)

    AS
    BEGIN
    SET @flag=1
	SET @flag1=1
        IF(NOT EXISTS(SELECT username FROM SystemUser WHERE username=@username))
        BEGIN
		if (not exists (select national_ID from Fan where national_ID=@national_ID))
			
			BEGIN
        INSERT INTO SystemUser (username, password) 
        VALUES (@username, @password)

        INSERT INTO Fan (username, national_ID, name, birth_date, address, phone_no)
        VALUES (@username, @national_ID, @name, @birthdate, @address, @phone)
        END
		Else
		begin
		set @flag1=0
		end
		end
        ELSE
        BEGIN
        SET @flag=0
        end

    END
GO 

CREATE FUNCTION upcomingMatchesOfCLub (@name VARCHAR(20))
    RETURNS TABLE
    AS 
    RETURN
    (
    Select host.name AS Host, guest.name AS Guest, m.start_time, s.name AS Stadium
    FROM Match m INNER JOIN Club host on (host.club_ID = m.host_club_ID)
                INNER JOIN Club guest on (guest.club_ID = m.guest_club_ID)
                INNER JOIN Stadium s on (s.ID = m.stadium_ID)
    WHERE (host.name = @name or guest.name=@name) AND m.start_time>CURRENT_TIMESTAMP)

GO 

CREATE FUNCTION availableMatchesToAttend (@date DATETIME)
    RETURNS TABLE 
    AS
    RETURN 
    (
    SELECT host.name AS Host, guest.name AS Guest, s.name AS Stadium, s.location AS Location, m.start_time
    FROM Match m INNER JOIN Club guest ON (m.guest_club_ID=guest.club_ID)
                INNER JOIN Club host ON (m.host_club_ID=host.club_ID)
                INNER JOIN Stadium s ON (m.stadium_ID=s.ID)
    WHERE m.start_time>= @date AND m.match_ID IN (SELECT DISTINCT t.match_ID
                                                FROM Ticket t
                                                WHERE t.status=1
                                                ))

GO

CREATE PROCEDURE purchaseTicket @FanNationalID VARCHAR(20), @HostingClubName VARCHAR(20), @GuestClubName VARCHAR(20), @StartTime datetime
    AS
    BEGIN

    DECLARE @status bit
    SELECT @status = status
    FROM Fan
    where national_ID = @FanNationalID

    IF (@status=1)
        BEGIN

        DECLARE @HostID INT
        DECLARE @GuestID INT 
        DECLARE @MatchID INT
        DECLARE @TicketID INT

        SELECT @HostID = club_ID
        FROM Club 
        WHERE name = @HostingClubName 

        SELECT @GuestID = club_ID
        FROM Club 
        WHERE name = @GuestClubName 

        SELECT @MatchID = match_ID
        FROM Match 
        WHERE start_time = @StartTime AND host_club_ID = @HostID AND guest_club_ID = @GuestID

        SELECT @TicketID = t.ID
        FROM Ticket t
        WHERE t.match_ID = @MatchID AND t.status = 1

        IF(@TicketID IS NOT NULL)
            BEGIN
            INSERT INTO Ticket_Buying_Transaction (fan_national_ID, ticket_ID) VALUES (@FanNationalID, @TicketID) 

            UPDATE Ticket 
            SET status = 0 
            WHERE ID = @TicketID
            END
        END
    END 
GO

CREATE PROCEDURE updateMatchHost @HostingClubName VARCHAR(20), @GuestClubName VARCHAR(20), @StartTime datetime

    AS
    BEGIN
    DECLARE @HostID INT
    DECLARE @GuestID INT
    DECLARE @MatchID INT


    SELECT @HostID = c.club_ID
    FROM Club c
    WHERE c.name = @HostingClubName

    SELECT @GuestID = c.club_ID
    FROM Club c
    WHERE c.name = @GuestClubName

    SELECT @MatchID = m.match_ID
    FROM Match m 
    WHERE m.host_club_ID = @HostID AND m.guest_club_ID = @GuestID AND m.start_time = @StartTime

    UPDATE Match 
    SET host_club_ID = @GuestID
    WHERE match_ID = @MatchID

    UPDATE Match 
    SET guest_club_ID = @HostID 
    WHERE match_ID = @MatchID

    UPDATE Match 
    SET stadium_ID = NULL 
    WHERE match_ID = @MatchID

    DELETE FROM Ticket
    WHERE match_ID=@MatchID

    END
GO

CREATE VIEW matchesPerTeam AS
    SELECT c.name, COUNT(*) AS No_Of_Matches
    FROM Club c INNER JOIN Match m ON (m.host_club_ID=c.club_ID OR m.guest_club_ID=c.club_ID)
    WHERE m.end_time<CURRENT_TIMESTAMP
    GROUP BY c.name

GO

CREATE VIEW clubsNeverMatched AS
    SELECT c1.name AS First_Club, c2.name AS Sec_Club
    FROM Club c1, Club c2
    WHERE c1.club_ID!=c2.club_ID AND c1.club_ID<c2.club_ID AND c2.club_ID NOT IN (SELECT m.host_club_ID
                                                        FROM Match m
                                                        WHERE m.guest_club_ID=c1.club_ID AND m.end_time<CURRENT_TIMESTAMP) 
                                 AND c2.club_ID NOT IN (SELECT m.guest_club_ID
                                                        FROM Match m
                                                        WHERE m.host_club_ID=c1.club_ID AND m.end_time<CURRENT_TIMESTAMP) 

GO

CREATE FUNCTION clubsNeverPlayed (@clubName VARCHAR(20))
    RETURNS @T TABLE(Never_Played_With VARCHAR(20))
    AS
    BEGIN
    DECLARE @clubID INT
    SET @clubID = (SELECT c.club_ID FROM Club c WHERE c.name=@clubName)

    INSERT INTO @T(Never_Played_With)( SELECT c1.name
                                        FROM Club c1
                                        WHERE c1.club_ID IN (
                                        (SELECT c2.club_ID
                                        FROM Club c2
                                        EXCEPT
                                        SELECT m.host_club_ID
                                        FROM Match m
                                        WHERE m.host_club_ID!=@clubID AND m.guest_club_ID=@clubID)
                                        EXCEPT
                                        SELECT m.guest_club_ID
                                        FROM Match m
                                        WHERE m.guest_club_ID!=@clubID AND m.host_club_ID=@clubID
                                        ) AND c1.club_ID!=@clubID
                                    )
    RETURN
    END


GO

CREATE FUNCTION matchWithHighestAttendance ()
    RETURNS TABLE
    AS
    RETURN
    (SELECT TOP 1 WITH TIES host.name AS Host, guest.name AS Guest
    FROM Match m1 INNER JOIN Club guest ON (m1.guest_club_ID=guest.club_ID)
    INNER JOIN Club host ON (m1.host_club_ID=host.club_ID) INNER JOIN Ticket tick ON (m1.match_ID=tick.match_ID)
    WHERE tick.status=0
    GROUP BY guest.name, host.name
    ORDER BY COUNT(*) DESC)



GO

CREATE FUNCTION matchesRankedByAttendance ()
    RETURNS TABLE
    AS
    RETURN
    (SELECT host.name AS Host, guest.name AS Guest
    FROM Match m1 INNER JOIN Club guest ON (m1.guest_club_ID=guest.club_ID)
    INNER JOIN Club host ON (m1.host_club_ID=host.club_ID) INNER JOIN Ticket tick ON (m1.match_ID=tick.match_ID)
    WHERE tick.status=0
    GROUP BY m1.match_ID, host.name, guest.name
    ORDER BY COUNT(*) DESC OFFSET 0 ROW)
    
    
GO

CREATE FUNCTION requestsFromClub (@stadiumName VARCHAR(20), @hostClub VARCHAR(20))
    RETURNS @T TABLE(Host VARCHAR(20), Guest VARCHAR(20))
    AS
    BEGIN
    DECLARE @getRepID INT
    SET @getRepID = (SELECT cr.ID 
    FROM Club c INNER JOIN ClubRepresentative cr ON (c.club_ID=cr.club_ID)
    WHERE c.name=@hostClub)

    DECLARE @stadID INT
    SET @stadID = (SELECT s.ID FROM Stadium s WHERE s.name=@stadiumName)

    INSERT INTO @T(Host, Guest) (SELECT host.name AS Host, guest.name AS Guest
    FROM HostRequest hr INNER JOIN Match m ON (hr.match_ID=m.match_ID)
        INNER JOIN Club host ON (m.host_club_ID=host.club_ID) INNER JOIN Club guest ON (m.guest_club_ID=guest.club_ID)
        INNER JOIN StadiumManager s ON(s.ID=hr.manager_ID)
        WHERE hr.representative_ID=@getRepID AND s.stadium_ID=@stadID)
    RETURN
    END

GO 

CREATE PROCEDURE AllSystemUser @username VARCHAR(20),@password VARCHAR(20),@flag int output
AS 
BEGIN 


if (exists(
Select s.username,s.password
from SystemUser s
where s.username=@username AND s.password=@password))
BEGIN 
set @flag=1
END

else 
BEGIN 
set @flag=0
END
return
end


GO
create procedure checkTable @username varchar(20), @password varchar(20), @t int output
as
begin
SET @t = 0

IF(NOT EXISTS(SELECT username FROM SystemUser WHERE username=@username))
begin
set @t=1
end

ELSE IF (EXISTS(SELECT username from SystemUser Where username=@username AND password<>@password))
begin
set @t=2
end

else if (EXISTS (SELECT c.username from ClubRepresentative c inner join SystemUser u on (c.username=u.username)
WHERE c.username=@username AND u.password = @password))
begin
set @t=3
end	

else if (EXISTS (SELECT f.username from Fan f inner join SystemUser u on (f.username=u.username)
WHERE f.username=@username AND u.password = @password))
begin
set @t=4
end

else if (EXISTS (SELECT s.username from SportsAssociationManager s inner join SystemUser u on (s.username=u.username)
WHERE s.username=@username AND u.password = @password))
begin
set @t=5
end	

else if (EXISTS (SELECT s.username from StadiumManager s inner join SystemUser u on (s.username=u.username)
WHERE s.username=@username AND u.password = @password))
begin
set @t=6
end	

else if (EXISTS (SELECT s.username from SystemAdmin s inner join SystemUser u on (s.username=u.username)
WHERE s.username=@username AND u.password = @password))
begin
set @t=7
end	


end
go

CREATE FUNCTION allavailableMatchesToAttend (@date datetime)
    RETURNS TABLE 
    AS
    RETURN 
    (
    SELECT host.name AS Host, guest.name AS Guest, m.end_time AS End_Time, m.start_time AS Start_Time
    FROM Match m INNER JOIN Club guest ON (m.guest_club_ID=guest.club_ID)
                INNER JOIN Club host ON (m.host_club_ID=host.club_ID)
              
    WHERE m.start_time>= CURRENT_TIMESTAMP )

   GO
   
   CREATE FUNCTION allPreviousMatches (@date datetime)
    RETURNS TABLE 
    AS
    RETURN 
    (
    SELECT host.name AS Host, guest.name AS Guest, m.end_time AS End_Time, m.start_time AS Start_Time
    FROM Match m INNER JOIN Club guest ON (m.guest_club_ID=guest.club_ID)
                INNER JOIN Club host ON (m.host_club_ID=host.club_ID)
              
    WHERE m.start_time< CURRENT_TIMESTAMP )

    go

    create procedure getClub @user varchar(20),
@name varchar(20) output 
as
begin
select @name = c.name 
from club c inner join ClubRepresentative r on (c.club_ID = r.club_ID) 
Where r.username=@user;
end

go

create procedure getClubInfo @user varchar(20),
@ID int output,
@loc varchar (20) output
as
begin
select @ID = c.club_ID 
from Club c inner join ClubRepresentative r on (c.club_ID = r.club_ID)
Where r.username=@user;
select @loc = c.location
from Club c inner join ClubRepresentative r on (c.club_ID = r.club_ID)
Where r.username=@user;
end

go

CREATE procedure getFanID @user varchar(20), @ID varchar(20) output
AS
BEGIN
SET @ID = (SELECT national_ID from Fan WHERE username=@user)
END
 
 go

 create procedure getStadium @user varchar(20),
@name varchar(20) output 
as
begin
select @name = s.name 
from Stadium s inner join StadiumManager m on (s.ID = m.stadium_ID) 
Where m.username=@user;
end

go

create procedure getStadiumInfo @user varchar(20),
@ID int output,
@loc varchar (20) output,
@capacity int output,
@status bit output
as
begin

select @ID = s.ID 
from Stadium s inner join StadiumManager m on (s.ID = m.stadium_ID)
Where m.username=@user;

select @loc = s.location
from Stadium s inner join StadiumManager m on (s.ID = m.stadium_ID)
Where m.username=@user;

select @capacity = s.capacity
from Stadium s inner join StadiumManager m on (s.ID = m.stadium_ID)
Where m.username=@user;

select @status = s.status
from Stadium s inner join StadiumManager m on (s.ID = m.stadium_ID)
Where m.username=@user;

end

go

CREATE procedure sendRequest @clubname varchar(20), @smname varchar(20), @matchID int
AS
BEGIN

Declare @sname varchar(20)
select @sname = s.name
from Stadium s inner join StadiumManager m on (s.ID = m.stadium_ID)
where m.username = @smname

Declare @time datetime
select @time = m.start_time
from Match m 
where m.match_ID = @matchID

exec addHostRequest @clubname, @sname, @time

END

go

CREATE FUNCTION allReqs (@stadiumManagerUsername VARCHAR(20))
    RETURNS TABLE
    AS
    RETURN(
    SELECT rep.name AS Club_Rep, host.name AS Host_Club, guest.name AS Guest_Club, m.start_time, m.end_time, r.status
    FROM Match m INNER JOIN HostRequest r on (m.match_ID=r.match_ID)
            INNER JOIN ClubRepresentative rep on (r.representative_ID=rep.id)
            INNER JOIN Club guest on (m.guest_club_ID=guest.club_ID)
            INNER JOIN Club host on (m.host_club_ID=host.club_ID)
    WHERE r.manager_ID=dbo.GetIDStadiumManager(@stadiumManagerUsername))

    go

    CREATE PROCEDURE dropAllProceduresFunctionsViews
 AS
 BEGIN
 DROP PROCEDURE dropAllTables
 DROP PROCEDURE createAllTables
 DROP PROCEDURE clearAllTables
 DROP VIEW allAssocManagers
 DROP VIEW allClubRepresentatives
 DROP VIEW allStadiumManagers
 DROP VIEW allFans
 DROP VIEW allMatches
 DROP VIEW allTickets
 DROP VIEW allClubs
 DROP VIEW allStadiums
 DROP VIEW allRequests
 DROP PROCEDURE addAssociationManager
 DROP PROCEDURE addNewMatch
 DROP VIEW clubsWithNoMatches
 DROP PROCEDURE deleteMatch
 DROP PROCEDURE deleteMatchesOnStadium
 DROP PROCEDURE addClub
 DROP PROCEDURE addTicket
 DROP PROCEDURE deleteClub
 DROP PROCEDURE addStadium
 DROP PROCEDURE deleteStadium
 DROP PROCEDURE blockFan
 DROP PROCEDURE unblockFan
 DROP PROCEDURE addRepresentative
 DROP FUNCTION viewAvailableStadiumsOn
 DROP PROCEDURE addHostRequest
 DROP FUNCTION allUnassignedMatches
 DROP PROCEDURE addStadiumManager
 DROP FUNCTION allPendingRequests
 DROP PROCEDURE acceptRequest
 DROP PROCEDURE rejectRequest
 DROP PROCEDURE addFan
 DROP FUNCTION upcomingMatchesOfClub
 DROP FUNCTION availableMatchesToAttend
 DROP PROCEDURE purchaseTicket
 DROP PROCEDURE updateMatchHost
 DROP PROCEDURE deleteMatchesOnStadium
 DROP VIEW  matchesPerTeam
 DROP VIEW clubsNeverMatched
 DROP FUNCTION clubsNeverPlayed
 DROP FUNCTION matchWithHighestAttendance
 DROP FUNCTION matchesRankedByAttendance
 DROP FUNCTION requestsFromClub
 DROP FUNCTION getClubName
 DROP FUNCTION GetIDClub
 DROP FUNCTION GetIDStadiumManager

 END



--ALTER DATABASE database1 SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
--ALTER DATABASE database1 MODIFY NAME = milestone3

--ALTER DATABASE milestone3

--SET MULTI_USER WITH ROLLBACK IMMEDIATE
