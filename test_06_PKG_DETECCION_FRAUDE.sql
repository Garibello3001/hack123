-- ==============================================================================
-- Archivo de prueba para: 06_PKG_DETECCION_FRAUDE
-- Objetivo: Validar la identificación de operaciones inusuales y bloqueos preventivos
-- ==============================================================================
DECLARE
    v_transaccion_id NUMBER := 555888;
    v_cuenta_origen VARCHAR2(20) := '1234567890';
    v_monto_tx NUMBER;
    v_ip_origen VARCHAR2(50) := '203.0.113.45'; -- IP externa sospechosa
    v_es_fraude VARCHAR2(1);
    v_nivel_riesgo VARCHAR2(20);
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- INICIO DE PRUEBA: DETECCIÓN DE FRAUDE ---');

    -- Caso 1: Transacción normal (Monto bajo)
    v_monto_tx := 150;
    DBMS_OUTPUT.PUT_LINE('Ejecutando Caso 1: Transacción habitual por monto de ' || v_monto_tx || '...');
    06_PKG_DETECCION_FRAUDE.ANALIZAR_TRANSACCION(
        p_tx_id => v_transaccion_id,
        p_cuenta => v_cuenta_origen,
        p_monto => v_monto_tx,
        p_ip => v_ip_origen,
        p_fraude => v_es_fraude,
        p_riesgo => v_nivel_riesgo
    );
    DBMS_OUTPUT.PUT_LINE('Resultado - Fraude: ' || v_es_fraude || ' | Nivel de Riesgo: ' || v_nivel_riesgo);

    -- Caso 2: Transacción sospechosa (Monto inusualmente alto)
    v_monto_tx := 250000;
    DBMS_OUTPUT.PUT_LINE('Ejecutando Caso 2: Transacción inusual por monto de ' || v_monto_tx || '...');
    06_PKG_DETECCION_FRAUDE.ANALIZAR_TRANSACCION(
        p_tx_id => v_transaccion_id + 1,
        p_cuenta => v_cuenta_origen,
        p_monto => v_monto_tx,
        p_ip => v_ip_origen,
        p_fraude => v_es_fraude,
        p_riesgo => v_nivel_riesgo
    );
    DBMS_OUTPUT.PUT_LINE('Resultado - Fraude: ' || v_es_fraude || ' | Nivel de Riesgo: ' || v_nivel_riesgo);

    IF v_es_fraude = 'S' THEN
        DBMS_OUTPUT.PUT_LINE('ACCIÓN AUTOMÁTICA: Bloqueando la transacción y notificando al cliente.');
        06_PKG_DETECCION_FRAUDE.BLOQUEAR_CUENTA(p_cuenta => v_cuenta_origen);
    END IF;

    DBMS_OUTPUT.PUT_LINE('--- FIN DE PRUEBA ---');
END;
/
