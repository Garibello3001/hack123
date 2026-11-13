-- ==============================================================================
-- Archivo de prueba para: 03_PKG_EVALUACION_CREDITO
-- Objetivo: Validar las reglas de aprobación y rechazo según score e ingresos
-- ==============================================================================
DECLARE
    v_cliente_id NUMBER := 2005;
    v_ingresos_mensuales NUMBER := 4500;
    v_egresos_mensuales NUMBER := 1200;
    v_score_crediticio NUMBER;
    v_monto_solicitado NUMBER := 15000;
    v_estado_solicitud VARCHAR2(20);
    v_observacion VARCHAR2(200);
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- INICIO DE PRUEBA: EVALUACIÓN DE CRÉDITO ---');

    -- Caso 1: Cliente con score alto y buena capacidad de pago
    v_score_crediticio := 750;
    DBMS_OUTPUT.PUT_LINE('Ejecutando Caso 1: Cliente Ideal (Score 750)...');
    03_PKG_EVALUACION_CREDITO.EVALUAR_SOLICITUD(
        p_cliente_id => v_cliente_id,
        p_ingresos => v_ingresos_mensuales,
        p_egresos => v_egresos_mensuales,
        p_score => v_score_crediticio,
        p_monto => v_monto_solicitado,
        p_estado => v_estado_solicitud,
        p_obs => v_observacion
    );
    DBMS_OUTPUT.PUT_LINE('Estado (Esperado APROBADO): ' || v_estado_solicitud || ' - ' || v_observacion);

    -- Caso 2: Cliente con score bajo (Rechazo automático)
    v_score_crediticio := 450;
    DBMS_OUTPUT.PUT_LINE('Ejecutando Caso 2: Cliente de Alto Riesgo (Score 450)...');
    03_PKG_EVALUACION_CREDITO.EVALUAR_SOLICITUD(
        p_cliente_id => v_cliente_id,
        p_ingresos => v_ingresos_mensuales,
        p_egresos => v_egresos_mensuales,
        p_score => v_score_crediticio,
        p_monto => v_monto_solicitado,
        p_estado => v_estado_solicitud,
        p_obs => v_observacion
    );
    DBMS_OUTPUT.PUT_LINE('Estado (Esperado RECHAZADO): ' || v_estado_solicitud || ' - ' || v_observacion);

    DBMS_OUTPUT.PUT_LINE('--- FIN DE PRUEBA ---');
END;
/
