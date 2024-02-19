create table Students (
    id SERIAL PRIMARY KEY,
    first_name varchar(50),
    last_name varchar(50),
    age integer,
    gender varchar(20),
    score float,
    email varchar(50),
    phone varchar(15),
    date_of_birth date 
);
insert into Students (first_name,last_name,age,gender,score,email,phone,date_of_birth) VALUES 
('Alisher','Oripov',21,'male',88.2,'alisheroripov@gmail.com','+998900101010','2003-01-12'),
('Sarvar','Nurullayev',20,'male',80.1,'sarvarnurullayev@gmail.com','+998909991009','2004-07-12'),
('Bobur','Ozodov',19,'male',58.9,'@boburozodov@gmail.com','+998991547890','2003-05-23'),
('Aziza','Alisherova',20,'male',50.4,'aziza0712@gmail.com','+998910910101','2004-07-12'),
('Sevara','Nurullayeva',17,'male',77.6,'sevara0514@gmail.com','+998973101489','2004-05-14');

UPDATE Students 
SET score = score - 5.7 
Where score <(SELECT AVG(score) FROM Students); 


DELETE FROM Students Where score < 60;