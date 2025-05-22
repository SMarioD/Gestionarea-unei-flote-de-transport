-- Script pentru actualizarea locației vehiculului și schimbarea statusului șoferului

-- Pasul 1: Găsirea unei locații din Departments care nu există în tabela Vehicles
WITH MissingDepartmentLocations AS (
    SELECT location
    FROM Departments
    WHERE location NOT IN (SELECT location FROM Vehicles)
    FETCH FIRST 1 ROWS ONLY -- Luăm o singură locație disponibilă
)
-- Pasul 2: Actualizarea locației vehiculului
UPDATE Vehicles
SET location = (SELECT location FROM MissingDepartmentLocations)
WHERE vehicle_id = 1
  AND location NOT IN (SELECT location FROM Departments);

-- Pasul 3: Schimbarea statusului șoferului asociat vehiculului
UPDATE Drivers
SET status = 0
WHERE driver_id = (SELECT driver_id FROM Vehicles WHERE vehicle_id = 1);

-- Verificarea rezultatului
SELECT * FROM Vehicles WHERE vehicle_id = 1;
SELECT * FROM Drivers WHERE driver_id = (SELECT driver_id FROM Vehicles WHERE vehicle_id = 1);
