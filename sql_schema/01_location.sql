CREATE DATABASE IF NOT EXISTS ImmuniTrackDB;
USE ImmuniTrackDB;

CREATE TABLE LOCATION (
    CITY VARCHAR(50),
    PINCODE INT PRIMARY KEY,
    STATE VARCHAR(50)
);


INSERT INTO LOCATION VALUES ('Junagadh',362001,'Gujarat');
INSERT INTO LOCATION VALUES ('Ahmedabad',380001,'Gujarat');
INSERT INTO LOCATION VALUES ('Lucknow',226001,'UP');
INSERT INTO LOCATION VALUES ('Warangal',506002,'Telangana');
INSERT INTO LOCATION VALUES ('Rajkot',360001,'Gujarat');
INSERT INTO LOCATION VALUES ('Kota',324006,'Rajasthan');
INSERT INTO LOCATION VALUES ('Jaipur',302003,'Rajasthan');
INSERT INTO LOCATION VALUES ('Delhi',110001,'Delhi');
INSERT INTO LOCATION VALUES ('NewMumbai',410206,'Maharashtra');
INSERT INTO LOCATION VALUES ('Hyderabad',500005,'Telangana');
INSERT INTO LOCATION VALUES ('Bangalore',560002,'Karnataka');
INSERT INTO LOCATION VALUES ('Chennai',600002,'Tamil Nadu');
INSERT INTO LOCATION VALUES ('Jammu',180005,'JandK');
INSERT INTO LOCATION VALUES ('Patna',800001,'Bihar');
INSERT INTO LOCATION VALUES ('Goa',403110,'Goa');
INSERT INTO LOCATION VALUES ('Rourkela',769001,'Odisha');
INSERT INTO LOCATION VALUES ('Ranchi',834002,'Jharkhand');
INSERT INTO LOCATION VALUES ('Shimla',171003,'Himachal Pradesh');
INSERT INTO LOCATION VALUES ('Jamshedpur',831001,'Jharkhand');
INSERT INTO LOCATION VALUES ('Agra',282003,'UP');
INSERT INTO LOCATION VALUES ('Bhopal',462001,'MP');
