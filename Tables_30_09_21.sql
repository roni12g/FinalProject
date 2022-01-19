use travelsystem
go

create table TblAdminUser(
userName varchar(20) primary key,
pass varchar(20) not null
)

create table TblStationTranslateHeb(
stationName nvarchar(50) primary key,
stationHeb nvarchar(50) not null,
)

select max(t.cardNumber) from TblCard as t

create table TblCity(
city varchar(30) primary key
)

create table TblColor(
color varchar(30) primary key
)

create table TblCard(
cardNumber int  IDENTITY(10000,1) PRIMARY KEY,
moneyAmount float not null ,
cardDate date not null
)

create table TblNotification(
id int  IDENTITY(10000,1) PRIMARY KEY,
details varchar(200) not null ,
notifyDate date not null,
	 bit not null
)

 create table TblSystemUser(
 id varchar(9) primary key,
 firstName varchar(30) not null,
 lastName varchar(30) not null,
 email varchar(45) not null,
 birthDate date not null,
 pass varchar(20) not null,
 phone varchar(10) not null,
 )

 create table TblAddress(
  city varchar(30) not null,
  zipCode varchar(5) not null,
  street varchar(30) not null,
  bulidingNumber int not null,
  departmentNumber int not null,
  constraint pk1 primary key (city,zipCode,street,bulidingNumber,departmentNumber),
  constraint fk1 foreign key (city) references TblCity (city) 
  on delete cascade on update cascade
 )

 create table TblCustomer(
 id varchar(9) primary key,
 covid19Val bit not null,
 joinDate date not null,
 cardNumber int not null,
 city varchar(30) not null,
 zipCode varchar(5) not null,
 loadCust float not null,
  street varchar(30) not null,
  bulidingNumber int not null,
  departmentNumber int not null,

 constraint fk2 foreign key (id) references TblSystemUser (id) 
 on delete cascade on update cascade,
 constraint fk3 foreign key (cardNumber) references TblCard (cardNumber) 
 on delete cascade on update cascade
 )

 create table TblLine(
 color varchar(30) primary key,
 stationsSum int not null,
 constraint fk5 foreign key (color) references TblColor (color) 
 on delete cascade on update cascade
 )

 create table TblManager (
 id varchar(9) primary key,
 startWorkingDate date not null,
 constraint fk6 foreign key (id) references TblSystemUser (id) 
 on delete cascade on update cascade
 )

 create table TblCsr (
 id varchar(9) primary key,
 startWorkingDate date not null,
 constraint fk36 foreign key (id) references TblSystemUser (id) 
 on delete cascade on update cascade
 )

  create table TblPotentialUser (
  potentialNumber int  IDENTITY(100,1) PRIMARY KEY,
  dateToday date not null
  )

  create table TblReport(
    reportNumber int  IDENTITY(100,1) PRIMARY KEY,
	reportDate date not null
  )

  create table TblStation (
  stationName varchar(30) primary key,
  stationNumber int not null,
  isJunction bit not null,
  city varchar(30) not null,
  primaryLine varchar(30) not null,
  secondaryLine varchar(30) ,
  constraint fk7 foreign key (city) references TblCity (city) 
  on delete cascade on update cascade,
  constraint fk8 foreign key (primaryLine) references TblLine (color) 
  on delete cascade on update cascade,
  constraint fk9 foreign key (secondaryLine) references TblLine (color) 
  )

  create table TblRoute(
  routeNumber int IDENTITY(100,1) PRIMARY KEY,
  routeDate date not null,
  startHour int not null,
  endHour int not null,
  startMinute float not null,
  endMinute float not null,
  sourceStationName varchar(30) not null,
  destStationName varchar(30) not null,
  trainNumber int not null,
  constraint fk10 foreign key (sourceStationName) references TblStation (stationName), 
  constraint fk11 foreign key (destStationName) references TblStation (stationName),
  constraint fk22 foreign key (trainNumber) references TblTrain (trainNumber) 

  )

  create table TblTrain(
  trainNumber int primary key,
  maxSeats int not null
  )

  create table TblStopsIn(
  stopsInId  int  IDENTITY(1,1) PRIMARY KEY,
  trainNumber int not null,
  stationName varchar(30) not null,
  stopDate date not null,
  stopHour int not null,
  stopMinute float not null,
  passengersInTrain int not null,
  startStation varchar(30) not null,
  endStation varchar(30) not null,
  loadParameter float not null,
  covid19InOut int not null,
  direction int not null,
  constraint fk12 foreign key (trainNumber) references TblTrain(trainNumber) 
  on delete cascade on update cascade,
  constraint fk13 foreign key (stationName) references TblStation (stationName) 
  on delete cascade on update cascade,
  constraint fk25 foreign key (startStation) references TblStation (stationName) ,
  constraint fk26 foreign key (endStation) references TblStation (stationName)
  )
  
  create table TblCustomerExitEnter(
  custEnterExitId int IDENTITY(1,1) PRIMARY KEY,
  id varchar(9) not null,
  stopsInId int not null,
  exitEnterDate date not null,
  exitEnterHour int not null,
  exitEnterMinute float not null,
  exitEnter bit not null,
  statStation varchar(30) not null,
  endStation varchar(30) not null,
  trainNumber int not null,
  loadParameter float not null,
  covid19InOut int not null,
  direction int not null,
  fromCity varchar(30) not null,
  toCity varchar(30) not null,
  stationName varchar(30) not null,
  constraint fk14 foreign key (id) references TblCustomer(id),
  constraint fk15 foreign key (stopsInId) references TblStopsIn (stopsInId),
  constraint fk33 foreign key (statStation) references TblStation (stationName),
  constraint fk34 foreign key (endStation) references TblStation (stationName),
  constraint fk35 foreign key (stationName) references TblStation (stationName)
  )

  create table TblCustSearch(
    id varchar(9) not null,
	custDate date not null,
    custHour int not null,
    custMinute float not null,
	sourceStationName varchar(30) not null,
	destStationName varchar(30) not null,
	constraint pk2 primary key (id,custDate,custHour,custMinute),
	constraint fk17 foreign key (id) references TblCustomer (id)
	on delete cascade on update cascade,
	constraint fk30 foreign key (sourceStationName) references TblStation (stationName),
	constraint fk31 foreign key (destStationName) references TblStation (stationName),
	sourceStationNameCity varchar(30) not null,
	destinationStationNameCity varchar(30) not null,
	covid19Val bit not null,
    loadCust float not null,
  )

  create table TblPotentialUserSearch(
	potentialNumber int not null,

    custDate date not null,
    custHour int not null,
    custMinute float not null,
	sourceStationName varchar(30) not null,
	destStationName varchar(30) not null,
	constraint fk40 foreign key (sourceStationName) references TblStation (stationName),
	constraint fk41 foreign key (destStationName) references TblStation (stationName),
	constraint fk18 foreign key (potentialNumber) references TblPotentialUser (potentialNumber)
    on delete cascade on update cascade,
	constraint pk3 primary key (potentialNumber,custDate,custHour,custMinute)

  )	

    create table TblReportsByManager(
	reportNumber int not null,
    id varchar(9) not null,
    constraint pk4 primary key (reportNumber, id),
	constraint fk20 foreign key (reportNumber) references TblReport (reportNumber)
	on delete cascade on update cascade,
	constraint fk21 foreign key (id) references TblManager (id)
	on delete cascade on update cascade,
	reportType varchar(30) not null
	)