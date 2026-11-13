-- ==============================================================================
-- Archivo de prueba para: 04_PKG_INTERESES_MORA
-- Objetivo: Validar el cálculo de días de retraso y aplicación de penalidades
-- ==============================================================================
DECLARE
    v_prestamo_id NUMBER := 3010;
    v_fecha_vencimiento DATE := SYSDATE - 15; -- 15 días de retraso
    v_tasa_mora_diaria NUMBER := 0.001; -- 0.1% diario
    v_saldo_vencido NUMBER := 1000;
    v_mora_calculada NUMBER;
    v_codigo_respuesta NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- INICIO DE PRUEBA: INTERESES POR MORA ---');

    -- Caso 1: Cálculo de monto por mora de 15 días
    DBMS_OUTPUT.PUT_LINE('Ejecutando Caso 1: Calcular mora para saldo vencido de 1000...');
    v_mora_calculada := 04_PKG_INTERESES_MORA.CALCULAR_MONTO_MORA(
        p_saldo => v_saldo_vencido,
        p_fecha_vence => v_fecha_vencimiento,
        p_tasa_diaria => v_tasa_mora_diaria
    );
    DBMS_OUTPUT.PUT_LINE('Monto calculado de mora: ' || v_mora_calculada);

    -- Caso 2: Aplicar la mora a la cuenta del cliente
    DBMS_OUTPUT.PUT_LINE('Ejecutando Caso 2: Aplicar cargo por mora a la cuenta...');
    04_PKG_INTERESES_MORA.APLICAR_CARGO_MORA(
        p_prestamo_id => v_prestamo_id,
        p_monto_mora => v_mora_calculada,
        p_cod_res => v_codigo_respuesta
    );
    
    IF v_codigo_respuesta = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Cargo por mora aplicado exitosamente.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Error al aplicar cargo por mora.');
    END IF;

    DBMS_OUTPUT.PUT_LINE('--- FIN DE PRUEBA ---');
END;
/
