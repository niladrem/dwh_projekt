USE projekt_source;

DROP TABLE IF EXISTS dbo.districts;
DROP TABLE IF EXISTS dbo.vendor;

CREATE TABLE districts (
	id int NOT NULL primary key,
	name varchar(31) NOT NULL,
	query varchar(200) NOT NULL,
	foundation_date date NULL,
	in_warsaw_date date NULL,
	area_total float NULL,
	population_total int NULL,
	population_dens float NULL,
	left_bank_part bit NOT NULL,
	district_office_street varchar(50) NULL,
	district_office_number varchar(30) NULL,
	district_office_postcode varchar(6) NULL,
	district_url varchar(50) NOT NULL
);

CREATE TABLE vendor (
	name varchar(100) NOT NULL,
	since date NOT NULL,
	province varchar(20),
	postcode varchar(6),
	city varchar(20),
	url varchar(200) NOT NULL,
	is_developer bit,
	address_street varchar(100),
	address_number varchar(30)
);


BULK INSERT districts
FROM 'D:\__DANE\studia\bd2\dwh_projekt\districts.csv'
WITH
(
    CODEPAGE = '65001',
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n',   --Use to shift the control to next row
    TABLOCK
);

BULK INSERT vendor
FROM 'D:\__DANE\studia\bd2\dwh_projekt\vendor2.csv'
WITH
(
    CODEPAGE = '65001',
    FIELDTERMINATOR = ';',  --CSV field delimiter
    ROWTERMINATOR = '\n',   --Use to shift the control to next row
    TABLOCK
);

