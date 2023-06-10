CREATE DATABASE students;
USE students;
CREATE TABLE Details (Name VARCHAR(255), Roll VARCHAR(12) PRIMARY KEY, Hostel VARCHAR(10), Room VARCHAR(4), Mess VARCHAR(1), MessPref VARCHAR(3), Month VARCHAR(12), Year VARCHAR(4), Dept VARCHAR(5));
load data infile "/var/lib/mysql-files/StudentDetails.txt" into table Details FIELDS TERMINATED BY ' ' LINES TERMINATED BY '\n';
create table uandp(Username CHAR(20),Pass CHAR(9));
LOAD DATA INFILE '/var/lib/mysql-files/StudentDetails.txt' INTO TABLE uandp FIELDS TERMINATED BY ' ' LINES TERMINATED BY '\n' (@c1,@c2,@c3,@c4,@c5,@c6,@c7,@c8,@c9) set Username=@c1,Pass=@c2;
insert into uandp values('GarnetA','GarnetA1'),('GarnetB','GarnetB2'),('Agate','Agate3'),('Opal','Opal4'),('HAD','HAD5');