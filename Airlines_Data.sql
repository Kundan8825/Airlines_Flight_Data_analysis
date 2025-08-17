DROP TABLE IF EXISTS airlines_data;
CREATE TABLE airlines_data (
    index_id INT PRIMARY KEY,
    airline VARCHAR(50),
    flight VARCHAR(20),
    source_city VARCHAR(50),
    departure_time VARCHAR(30),
    stops VARCHAR(20),
    arrival_time VARCHAR(30),
    destination_city VARCHAR(50),
    class_type VARCHAR(20),
    duration DECIMAL(4,2),
    days_left INT,
    price INT
);

SELECT * FROM airlines_data;

SELECT COUNT(*) AS total FROM airlines_data;

SELECT DISTINCT airline FROM airlines_data;

SELECT DISTINCT flight FROM airlines_data;
