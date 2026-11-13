-- ==============================================================================
-- Archivo de prueba para: 02_PKG_AMORTIZACION_CREDITO
-- Objetivo: Validar la generación de la tabla de amortización y pagos anticipados
-- ==============================================================================
DECLARE
    v_credito_id NUMBER := 1001;
    v_monto NUMBER := 50000;
    v_tasa_interes NUMBER := 0.015; -- 1.5% mensual
    v_plazo_meses NUMBER := 12;
    v_codigo_respuesta NUMBER;
    v_mensaje_respuesta VARCHAR2(255);
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- INICIO DE PRUEBA: AMORTIZACIÓN DE CRÉDITO ---');
    
    -- Caso 1: Generación de tabla de amortización estándar
    DBMS_OUTPUT.PUT_LINE('Ejecutando Caso 1: Generar tabla para préstamo nuevo...');
    02_PKG_AMORTIZACION_CREDITO.GENERAR_TABLA(
        p_credito_id => v_credito_id,
        p_monto => v_monto,
        p_tasa => v_tasa_interes,
        p_plazo => v_plazo_meses,
        p_cod_res => v_codigo_respuesta,
        p_msj_res => v_mensaje_respuesta
    );
    DBMS_OUTPUT.PUT_LINE('Resultado Caso 1: ' || v_mensaje_respuesta);

    -- Caso 2: Recálculo por abono a capital (Pago anticipado)
    DBMS_OUTPUT.PUT_LINE('Ejecutando Caso 2: Abono a capital de 5000...');
    02_PKG_AMORTIZACION_CREDITO.RECALCULAR_SALDO(
        p_credito_id => v_credito_id,
        p_monto_abono => 5000,
        p_cod_res => v_codigo_respuesta,
        p_msj_res => v_mensaje_respuesta
    );
    DBMS_OUTPUT.PUT_LINE('Resultado Caso 2: ' || v_mensaje_respuesta);
    
    DBMS_OUTPUT.PUT_LINE('--- FIN DE PRUEBA ---');
END;
/
