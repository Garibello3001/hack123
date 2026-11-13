-- ==============================================================================
-- Archivo de prueba para: 05_PKG_CONCILIACION_BANCARIA
-- Objetivo: Validar el cuadre entre los registros internos y el extracto bancario
-- ==============================================================================
DECLARE
    v_fecha_proceso DATE := TRUNC(SYSDATE - 1);
    v_cuenta_contable VARCHAR2(20) := 'C-99887766';
    v_total_registros NUMBER;
    v_registros_cuadrados NUMBER;
    v_discrepancias NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- INICIO DE PRUEBA: CONCILIACIÓN BANCARIA ---');

    -- Caso 1: Proceso batch de conciliación diaria
    DBMS_OUTPUT.PUT_LINE('Ejecutando Caso 1: Conciliación para la fecha ' || TO_CHAR(v_fecha_proceso, 'YYYY-MM-DD') || '...');
    
    05_PKG_CONCILIACION_BANCARIA.PROCESAR_EXTRACTO(
        p_cuenta => v_cuenta_contable,
        p_fecha => v_fecha_proceso,
        p_total_reg => v_total_registros,
        p_reg_ok => v_registros_cuadrados,
        p_reg_error => v_discrepancias
    );

    DBMS_OUTPUT.PUT_LINE('Total de Movimientos Procesados: ' || v_total_registros);
    DBMS_OUTPUT.PUT_LINE('Movimientos Cuadrados: ' || v_registros_cuadrados);
    DBMS_OUTPUT.PUT_LINE('Discrepancias Encontradas: ' || v_discrepancias);

    -- Caso 2: Manejo de discrepancias
    IF v_discrepancias > 0 THEN
        DBMS_OUTPUT.PUT_LINE('ALERTA: Se encontraron ' || v_discrepancias || ' transacciones no conciliadas. Requiere revisión manual.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('ÉXITO: Conciliación perfecta sin discrepancias.');
    END IF;

    DBMS_OUTPUT.PUT_LINE('--- FIN DE PRUEBA ---');
END;
/
