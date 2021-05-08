USE projekt_target;

DROP TABLE IF EXISTS dbo.DistrictDimension;
DROP TABLE IF EXISTS dbo.VendorDimension;
DROP TABLE IF EXISTS dbo.AddressDimension;

CREATE TABLE AddressDimension (
	addressId int IDENTITY(1, 1) PRIMARY KEY,
	apartmentNumber varchar(30) NOT NULL,
	street varchar(50) NOT NULL,
	province varchar(30) NOT NULL,
	postcode varchar(6),
	city varchar(20)
);

CREATE TABLE VendorDimension (
	vendorId int IDENTITY(1,1) PRIMARY KEY,
	name varchar(100) NOT NULL,
	type varchar(10) NOT NULL, --biuro/deweloper
	url varchar(200) NOT NULL,
	addressId int NOT NULL foreign key references AddressDimension(addressId), --tylko to moze sie ewentualnie zmienic
	since int NOT NULL foreign key references DateDimension(DateID), --jednak postanowilam zostawic, bo w sumie moga byc statystyki, czy nowe biura wystawiaja wiecej ogloszen itp.
	validFrom int NOT NULL foreign key references DateDimension(DateID),
	validTo int NOT NULL foreign key references DateDimension(DateID)
);


CREATE TABLE DistrictDimension (
	districtId int IDENTITY(1, 1) PRIMARY KEY,
	originalDistrictId int NOT NULL,
	name varchar(31) NOT NULL,
	in_warsaw_date int NOT NULL foreign key references DateDimension(DateID),
	area_total varchar(10) NOT NULL, --[0,16) mala, [16, 30) srednia, [30,) duza, unknown 
	-- population_total int NULL, --proponuje to jednak usunac, sama populacja w oderwaniu od powierzchni absolutnie nic nie mowi, gestosc powinna wystarczyc
	population_dens varchar(1) NOT NULL, -- [0,1300) mala, [1300, 6000) srednia, [6000,) duza, unknown 
	citypart varchar(20) NOT NULL, --lewo/prawobrzezna
	district_office_address int NOT NULL foreign key references AddressDimension(addressId),
	validFrom int NOT NULL foreign key references DateDimension(DateID),
	validTo int NOT NULL foreign key references DateDimension(DateID)
);