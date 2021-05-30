USE projekt_target;

DROP TABLE IF EXISTS dbo.flatFacts;

CREATE TABLE flatFacts (
	flatId int IDENTITY(1, 1) PRIMARY KEY,
	districtId int NOT NULL foreign key references DistrictDimension(districtId),
	vendorId int NOT NULL foreign key references VendorDimension(vendorId),
	price money NOT NULL,
	pricePerMeter money NOT NULL,
	originalFlatId varchar(20) NOT NULL, --"Nr oferty w Otodom"
	area float NOT NULL,
	market varchar(10) NOT NULL,
	floatFloor int NOT NULL,
	roomsNumber int NOT NULL,
	buildingMaterial varchar(20) NOT NULL,
	constructionYear int NOT NULL foreign key references DateDimension(DateID), --wskazuje na styczen tego roku
	heating varchar(20) NOT NULL,
	condition varchar(20) NOT NULL, --do wykonczenia/do zamieszkania/do remontu itp.
	floorsNumber int NOT NULL,
	availableDate int NOT NULL foreign key references DateDimension(DateID),
	typeOfBuilding varchar(20) NOT NULL, --apartamentowiec/blok
	elevator varchar(3) NOT NULL, --yes/no
	snapshotDate int NOT NULL foreign key references DateDimension(DateID),
);