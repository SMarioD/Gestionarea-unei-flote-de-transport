--Declararea unui sofer indisponibil daca masina lui este in zi de mentenanta
DECLARE
    v_current_date DATE := TRUNC(SYSDATE);  -- Data curentă fără ora
    v_vehicle_id INT;                        -- ID-ul vehiculului
    v_driver_id INT;                         -- ID-ul șoferului
BEGIN
    -- Pasul 2: Verificăm dacă există o întreținere pentru data curentă (fără ora)
    SELECT vehicle_id INTO v_vehicle_id
    FROM Maintenance
    WHERE TRUNC(maintenance_date) = v_current_date  -- Comparăm doar data
    AND ROWNUM = 1;  -- Asigurăm că este doar un vehicul pentru această dată

    -- Pasul 3: Dacă există, aflăm șoferul asociat vehiculului
    SELECT driver_id INTO v_driver_id
    FROM Vehicles
    WHERE vehicle_id = v_vehicle_id;

    -- Pasul 4: Actualizăm statusul șoferului la "indisponibil" (1)
    UPDATE Drivers
    SET status = 1 -- 1 înseamnă că șoferul este indisponibil
    WHERE driver_id = v_driver_id;

    -- Pasul 5: Confirmarea actualizării
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Șoferul ' || v_driver_id || ' a fost marcat ca indisponibil.');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Nu există întreținere programată pentru data curentă.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('A apărut o eroare: ' || SQLERRM);
END;
