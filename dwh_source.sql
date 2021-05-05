USE projekt_source;

drop table if exists dbo.districts;

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
	district_office_address varchar(50) NULL,
	district_url varchar(50) NOT NULL
);


BULK INSERT districts
FROM 'D:\__DANE\studia\bd2\dwh_projekt\districts.csv'
WITH
(
	CODEPAGE = '65001',
    FIELDTERMINATOR = ',',  --CSV field delimiter
    ROWTERMINATOR = '\n',   --Use to shift the control to next row
    TABLOCK
)