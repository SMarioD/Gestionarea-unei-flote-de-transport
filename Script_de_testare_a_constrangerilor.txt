-- 1. Testare constrângere Primary Key pe tabelul Vehicles
-- Inserare vehicul cu ID unic
insert into Vehicles (vehicle_id, make, model, year, vin, location) 
values (vehicle_seq_new.nextval, 'Mercedes-Benz', 'Actros', 2020, 'WDB9301012L123456', 'București');

-- Inserare vehicul cu ID duplicat (trebuie să eșueze)
insert into Vehicles (vehicle_id, make, model, year, vin, location) 
values (1, 'Volvo', 'FH16', 2021, 'WDB9301012L123457', 'Cluj-Napoca');  -- ID duplicat

-- 2. Testare constrângere VIN unic
-- Inserare vehicul cu VIN unic
insert into Vehicles (vehicle_id, make, model, year, vin, location) 
values (vehicle_seq_new.nextval, 'Scania', 'R500', 2021, 'YS2R4X20005412345', 'Timișoara');

-- Inserare vehicul cu VIN duplicat (trebuie să eșueze)
insert into Vehicles (vehicle_id, make, model, year, vin, location) 
values (vehicle_seq_new.nextval, 'Ford', 'F-150', 2025, 'WDB9301012L123456', 'Brașov');  -- VIN duplicat

-- 3. Testare constrângere Primary Key pe tabelul Drivers
-- Inserare șofer cu ID unic
insert into Drivers (driver_id, name, license_number, status, actions) 
values (driver_seq_new.nextval, 'Ion Popescu', 'AB123456', 0, 0);

-- Inserare șofer cu ID duplicat (trebuie să eșueze)
insert into Drivers (driver_id, name, license_number, status, actions) 
values (1, 'Maria Ionescu', 'CD654321', 0, 0);  -- ID duplicat

-- 4. Testare constrângere Unique pe numărul de licență al șoferului
-- Inserare șofer cu număr de licență unic
insert into Drivers (driver_id, name, license_number, status, actions) 
values (driver_seq_new.nextval, 'Alexandru Vasile', 'EF789012', 0, 0);

-- Inserare șofer cu număr de licență duplicat (trebuie să eșueze)
insert into Drivers (driver_id, name, license_number, status, actions) 
values (driver_seq_new.nextval, 'Georgiana Mircea', 'AB123456', 0, 0);  -- Licență duplicată

-- 5. Testare constrângere Primary Key pe tabelul Routes
-- Inserare rută cu ID unic
insert into Routes (route_id, start_location, end_location, distance) 
values (route_seq_new.nextval, 'București', 'Cluj', 500);

-- Inserare rută cu ID duplicat (trebuie să eșueze)
insert into Routes (route_id, start_location, end_location, distance) 
values (1, 'Iași', 'Timișoara', 700);  -- ID duplicat

-- 6. Testare constrângere Check pe distanța rutei (trebuie să fie mai mare de 0)
-- Inserare rută validă
insert into Routes (route_id, start_location, end_location, distance) 
values (route_seq_new.nextval, 'București', 'Brașov', 150);

-- Inserare rută cu distanță invalidă (trebuie să eșueze)
insert into Routes (route_id, start_location, end_location, distance) 
values (route_seq_new.nextval, 'Cluj', 'Oradea', -50);  -- Distanță invalidă

-- 7. Testare constrângere Foreign Key pe tabelul Maintenance (referință la Vehicles)
-- Inserare întreținere validă
insert into Maintenance (maintenance_id, vehicle_id, maintenance_date, details) 
values (maintenance_seq_new.nextval, 1, to_date('2025-01-05', 'YYYY-MM-DD'), 'Schimb de ulei');

-- Inserare întreținere cu vehicul inexistent (trebuie să eșueze)
insert into Maintenance (maintenance_id, vehicle_id, maintenance_date, details) 
values (maintenance_seq_new.nextval, 9999, to_date('2025-01-06', 'YYYY-MM-DD'), 'Revizie tehnică');  -- Vehicul inexistent

-- 8. Testare constrângere Foreign Key pe tabelul Payments (referință la Drivers)
-- Inserare plată validă
insert into Payments (payment_id, driver_id, amount, payment_date) 
values (payment_seq_new.nextval, 1, 1500.00, to_date('2025-01-01', 'YYYY-MM-DD'));

-- Inserare plată cu șofer inexistent (trebuie să eșueze)
insert into Payments (payment_id, driver_id, amount, payment_date) 
values (payment_seq_new.nextval, 9999, 2000.00, to_date('2025-01-02', 'YYYY-MM-DD'));  -- Șofer inexistent

-- 9. Testare inserare departament
insert into Departments (department_id, department_name, location) 
values (department_seq_new.nextval, 'IT', 'București');

-- 10. Testare Primary Key pe Departamente (ID duplicat)
insert into Departments (department_id, department_name, location) 
values (1, 'HR', 'Cluj');  -- ID duplicat (trebuie să eșueze)

-- 11. Testare constrângere Foreign Key pe Departamente (referință la Routes)
-- Inserare departament valid
insert into Departments (department_id, department_name, location, route_id) 
values (department_seq_new.nextval, 'Transport', 'București', 
    (SELECT route_id FROM Routes WHERE start_location = 'București' AND end_location = 'Constanta'));

-- Inserare departament cu route_id inexistent (trebuie să eșueze)
insert into Departments (department_id, department_name, location, route_id) 
values (department_seq_new.nextval, 'Management', 'Cluj-Napoca', 9999);  -- Route_id inexistent
