-- Atribuirea salariului pentru soferii care au facut macar 3 curse intr-o luna

SET SERVEROUTPUT ON;

DECLARE
    v_driver_id INT;
    v_actions INT;
    v_payment_date DATE;
    v_new_payment_date DATE;
    v_payment_amount DECIMAL(10, 2);
BEGIN
    -- Cursor pentru a selecta șoferii care au actions >= 3 și care au o plată înregistrată
    FOR driver_record IN (
        SELECT D.driver_id, D.actions, MAX(P.payment_date) AS last_payment_date
        FROM Drivers D
        LEFT JOIN Payments P ON D.driver_id = P.driver_id
        WHERE D.actions >= 3
        GROUP BY D.driver_id, D.actions
        HAVING MAX(P.payment_date) IS NULL OR MAX(P.payment_date) + INTERVAL '1' MONTH <= SYSDATE
    ) LOOP
        -- Obținem ID-ul șoferului și numărul de acțiuni
        v_driver_id := driver_record.driver_id;
        v_actions := driver_record.actions;
        v_payment_date := driver_record.last_payment_date;

        -- Calculăm data pentru plata următoare (adăugăm o lună la ultima plată)
        v_new_payment_date := ADD_MONTHS(NVL(v_payment_date, SYSDATE), 1);  -- Dacă nu există plată anterioară, folosim data curentă

        -- Obținem suma ultimei plăți efectuate pentru acest șofer
        SELECT amount INTO v_payment_amount
        FROM Payments
        WHERE driver_id = v_driver_id
        ORDER BY payment_date DESC
        FETCH FIRST 1 ROWS ONLY;

        -- Dacă nu există o plată anterioară, setăm o valoare implicită
        IF v_payment_amount IS NULL THEN
            v_payment_amount := 2500.00; -- Suma standard în cazul în care nu există plăți anterioare
        END IF;

        -- Inserăm o nouă plată
        INSERT INTO Payments (payment_id, driver_id, amount, payment_date)
        VALUES (payment_seq_new.NEXTVAL, v_driver_id, v_payment_amount, v_new_payment_date);

        DBMS_OUTPUT.PUT_LINE('Platirea pentru Soferul ID ' || v_driver_id || ' a fost adaugata pe data: ' || TO_CHAR(v_new_payment_date, 'YYYY-MM-DD') || ' cu suma: ' || v_payment_amount);
    END LOOP;

    COMMIT;
END;
