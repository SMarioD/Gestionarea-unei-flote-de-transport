-- Crearea tabelului pentru departamente
CREATE TABLE Departments (
    department_id INT NOT NULL,
    department_name VARCHAR2(100) NOT NULL,
    location VARCHAR2(100) NOT NULL,
    route_id INT NOT NULL, -- Legătura cu tabela Routes
    CONSTRAINT Departments_pk PRIMARY KEY (department_id),
    CONSTRAINT route_id_unique UNIQUE (route_id)
);

-- Crearea tabelului pentru șoferi
CREATE TABLE Drivers (
    driver_id INT NOT NULL,
    name VARCHAR2(100) NOT NULL,
    license_number VARCHAR2(50) NOT NULL,
    status NUMBER(1) DEFAULT 0,  -- Câmpul status pentru a urmări starea șoferului (0 = liber, 1 = ocupat)
    actions INT DEFAULT 0,       -- Câmpul pentru numărul de acțiuni efectuate de șofer
    department_id INT,          -- Legătura cu tabela Departments
    CONSTRAINT Drivers_pk PRIMARY KEY (driver_id),
    CONSTRAINT license_number_uk UNIQUE (license_number),
    CONSTRAINT Drivers_Department_FK FOREIGN KEY (department_id) REFERENCES Departments(department_id) ON DELETE SET NULL -- Relația cu Departments
);

-- Crearea tabelului pentru vehicule
CREATE TABLE Vehicles (
    vehicle_id INT NOT NULL,
    make VARCHAR2(50) NOT NULL,
    model VARCHAR2(50) NOT NULL,
    year INT,
    vin VARCHAR2(50) NOT NULL,
    location VARCHAR2(100) NOT NULL,  -- Câmpul pentru locația vehiculului
    driver_id INT, -- Legătura cu tabela Drivers
    CONSTRAINT Vehicles_pk PRIMARY KEY (vehicle_id),
    CONSTRAINT vin_uk UNIQUE (vin),
    CONSTRAINT Vehicles_Driver_FK FOREIGN KEY (driver_id) REFERENCES Drivers(driver_id) ON DELETE SET NULL -- Relația cu Drivers
);

-- Crearea tabelului pentru rute
CREATE TABLE Routes (
    route_id INT NOT NULL,
    start_location VARCHAR2(100) NOT NULL,
    end_location VARCHAR2(100) NOT NULL,
    distance INT NOT NULL,
    CONSTRAINT Routes_pk PRIMARY KEY (route_id),
    CONSTRAINT distance_ck CHECK (distance > 0)  -- Adăugăm constrângerea pentru distanța pozitivă
);

-- Adăugarea relației 1:1 între Departments și Routes
ALTER TABLE Departments 
ADD CONSTRAINT Departments_Route_FK FOREIGN KEY (route_id) REFERENCES Routes(route_id) ON DELETE CASCADE;

-- Crearea tabelului pentru întreținere
CREATE TABLE Maintenance (
    maintenance_id INT NOT NULL,
    vehicle_id INT NOT NULL,
    maintenance_date DATE NOT NULL,
    details CLOB NOT NULL,
    CONSTRAINT Maintenance_pk PRIMARY KEY (maintenance_id),
    CONSTRAINT Maintenance_vehicle_fk FOREIGN KEY (vehicle_id) REFERENCES Vehicles(vehicle_id) ON DELETE CASCADE  -- Legătura cu Vehicles
);

-- Crearea tabelului pentru plăți șoferi
CREATE TABLE Payments (
    payment_id INT NOT NULL,
    driver_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    payment_date DATE NOT NULL,
    CONSTRAINT Payments_pk PRIMARY KEY (payment_id),
    CONSTRAINT Payments_driver_fk FOREIGN KEY (driver_id) REFERENCES Drivers(driver_id) ON DELETE CASCADE  -- Legătura cu Drivers
);

-- Crearea secvențelor pentru ID-uri
CREATE SEQUENCE vehicle_seq_new START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE driver_seq_new START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE route_seq_new START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE maintenance_seq_new START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE department_seq_new START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE payment_seq_new START WITH 1 INCREMENT BY 1;
