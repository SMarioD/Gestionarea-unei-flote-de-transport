-- Populare tabelul Routes
INSERT INTO Routes VALUES (route_seq_new.NEXTVAL, 'Bucuresti', 'Constanta', 225);
INSERT INTO Routes VALUES (route_seq_new.NEXTVAL, 'Cluj-Napoca', 'Oradea', 152);
INSERT INTO Routes VALUES (route_seq_new.NEXTVAL, 'Timisoara', 'Arad', 50);
INSERT INTO Routes VALUES (route_seq_new.NEXTVAL, 'Iasi', 'Suceava', 135);
INSERT INTO Routes VALUES (route_seq_new.NEXTVAL, 'Brasov', 'Sibiu', 142);

SELECT * FROM Routes;

-- Populare tabelul Departments cu relație 1:1 la Routes
INSERT INTO Departments (department_id, department_name, location, route_id)
VALUES (department_seq_new.NEXTVAL, 'Logistica', 'Bucuresti',
    (SELECT route_id FROM Routes WHERE start_location = 'Bucuresti' AND end_location = 'Constanta'));

INSERT INTO Departments (department_id, department_name, location, route_id)
VALUES (department_seq_new.NEXTVAL, 'Transporturi', 'Cluj-Napoca',
    (SELECT route_id FROM Routes WHERE start_location = 'Cluj-Napoca' AND end_location = 'Oradea'));

INSERT INTO Departments (department_id, department_name, location, route_id)
VALUES (department_seq_new.NEXTVAL, 'Intretinere', 'Timisoara',
    (SELECT route_id FROM Routes WHERE start_location = 'Timisoara' AND end_location = 'Arad'));

INSERT INTO Departments (department_id, department_name, location, route_id)
VALUES (department_seq_new.NEXTVAL, 'Planificare', 'Iasi',
    (SELECT route_id FROM Routes WHERE start_location = 'Iasi' AND end_location = 'Suceava'));

INSERT INTO Departments (department_id, department_name, location, route_id)
VALUES (department_seq_new.NEXTVAL, 'Contabilitate', 'Brasov',
    (SELECT route_id FROM Routes WHERE start_location = 'Brasov' AND end_location = 'Sibiu'));

SELECT * FROM Departments;

-- Populare tabelul Drivers
INSERT INTO Drivers (driver_id, name, license_number, status, actions, department_id)
VALUES (driver_seq_new.NEXTVAL, 'Ion Popescu', 'B12345678', 0, 0, 
    (SELECT department_id FROM Departments WHERE department_name = 'Logistica'));

INSERT INTO Drivers (driver_id, name, license_number, status, actions, department_id)
VALUES (driver_seq_new.NEXTVAL, 'Maria Ionescu', 'C87654321', 0, 0, 
    (SELECT department_id FROM Departments WHERE department_name = 'Transporturi'));

INSERT INTO Drivers (driver_id, name, license_number, status, actions, department_id)
VALUES (driver_seq_new.NEXTVAL, 'Vasile Dumitrescu', 'D12398745', 0, 0, 
    (SELECT department_id FROM Departments WHERE department_name = 'Intretinere'));

INSERT INTO Drivers (driver_id, name, license_number, status, actions, department_id)
VALUES (driver_seq_new.NEXTVAL, 'Elena Georgescu', 'E87612390', 0, 0, 
    (SELECT department_id FROM Departments WHERE department_name = 'Planificare'));

INSERT INTO Drivers (driver_id, name, license_number, status, actions, department_id)
VALUES (driver_seq_new.NEXTVAL, 'Cristian Marinescu', 'F90876543', 0, 0, 
    (SELECT department_id FROM Departments WHERE department_name = 'Contabilitate'));

SELECT * FROM Drivers;

-- Populare tabelul Vehicles cu locații și șoferi
INSERT INTO Vehicles (vehicle_id, make, model, year, vin, location, driver_id)
VALUES (vehicle_seq_new.NEXTVAL, 'Mercedes-Benz', 'Actros', 2020, 'WDB9301012L123456', 'București', 
    (SELECT driver_id FROM Drivers WHERE name = 'Ion Popescu'));

INSERT INTO Vehicles (vehicle_id, make, model, year, vin, location, driver_id)
VALUES (vehicle_seq_new.NEXTVAL, 'Volvo', 'FH16', 2019, 'YV2XSN0B8MA123456', 'Cluj-Napoca', 
    (SELECT driver_id FROM Drivers WHERE name = 'Maria Ionescu'));

INSERT INTO Vehicles (vehicle_id, make, model, year, vin, location, driver_id)
VALUES (vehicle_seq_new.NEXTVAL, 'Scania', 'R500', 2021, 'YS2R4X20005412345', 'Timișoara', 
    (SELECT driver_id FROM Drivers WHERE name = 'Vasile Dumitrescu'));

INSERT INTO Vehicles (vehicle_id, make, model, year, vin, location, driver_id)
VALUES (vehicle_seq_new.NEXTVAL, 'MAN', 'TGX', 2022, 'WMA05XZZ0DP123456', 'Brașov', 
    (SELECT driver_id FROM Drivers WHERE name = 'Cristian Marinescu'));

INSERT INTO Vehicles (vehicle_id, make, model, year, vin, location, driver_id)
VALUES (vehicle_seq_new.NEXTVAL, 'DAF', 'XF105', 2020, 'XLRTE47MS0E123456', 'Iași', 
    (SELECT driver_id FROM Drivers WHERE name = 'Elena Georgescu'));

SELECT * FROM Vehicles;

-- Populare tabelul Maintenance
INSERT INTO Maintenance VALUES (maintenance_seq_new.NEXTVAL, 
    (SELECT vehicle_id FROM Vehicles WHERE make = 'Mercedes-Benz' AND model = 'Actros'),
    TO_DATE('2023-05-10', 'YYYY-MM-DD'), 'Inlocuire ulei si filtre');

INSERT INTO Maintenance VALUES (maintenance_seq_new.NEXTVAL, 
    (SELECT vehicle_id FROM Vehicles WHERE make = 'Volvo' AND model = 'FH16'),
    TO_DATE('2023-06-12', 'YYYY-MM-DD'), 'Schimbare cauciucuri');

INSERT INTO Maintenance VALUES (maintenance_seq_new.NEXTVAL, 
    (SELECT vehicle_id FROM Vehicles WHERE make = 'Scania' AND model = 'R500'),
    TO_DATE('2023-07-15', 'YYYY-MM-DD'), 'Reparatie sistem de franare');

INSERT INTO Maintenance VALUES (maintenance_seq_new.NEXTVAL, 
    (SELECT vehicle_id FROM Vehicles WHERE make = 'MAN' AND model = 'TGX'),
    TO_DATE('2023-08-20', 'YYYY-MM-DD'), 'Verificare sistem electric');

INSERT INTO Maintenance VALUES (maintenance_seq_new.NEXTVAL, 
    (SELECT vehicle_id FROM Vehicles WHERE make = 'DAF' AND model = 'XF105'),
    TO_DATE('2023-09-25', 'YYYY-MM-DD'), 'Inlocuire baterie');

SELECT * FROM Maintenance;

-- Populare tabelul Payments
INSERT INTO Payments 
VALUES (payment_seq_new.NEXTVAL, 
    (SELECT driver_id FROM Drivers WHERE name = 'Ion Popescu'), 
    2500.00, TO_DATE('2023-10-01', 'YYYY-MM-DD'));

INSERT INTO Payments 
VALUES (payment_seq_new.NEXTVAL, 
    (SELECT driver_id FROM Drivers WHERE name = 'Maria Ionescu'), 
    2700.00, TO_DATE('2023-10-05', 'YYYY-MM-DD'));

INSERT INTO Payments 
VALUES (payment_seq_new.NEXTVAL, 
    (SELECT driver_id FROM Drivers WHERE name = 'Vasile Dumitrescu'), 
    2400.00, TO_DATE('2023-10-10', 'YYYY-MM-DD'));

INSERT INTO Payments 
VALUES (payment_seq_new.NEXTVAL, 
    (SELECT driver_id FROM Drivers WHERE name = 'Elena Georgescu'), 
    2600.00, TO_DATE('2023-10-15', 'YYYY-MM-DD'));

INSERT INTO Payments 
VALUES (payment_seq_new.NEXTVAL, 
    (SELECT driver_id FROM Drivers WHERE name = 'Cristian Marinescu'), 
    2550.00, TO_DATE('2023-10-20', 'YYYY-MM-DD'));

SELECT * FROM Payments;
