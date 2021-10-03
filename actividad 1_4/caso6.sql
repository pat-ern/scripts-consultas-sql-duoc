SELECT
-- AÑO TRIBUTARIO
EXTRACT(YEAR FROM SYSDATE)-1 ANNO_TRIBUTARIO,
-- RUN
TO_CHAR(numrun_emp, 'FM99G999G999')||'-'||dvrun_emp RUN_EMPLEADO,
-- NOMBRE
pnombre_emp||' '||snombre_emp||' '||appaterno_emp||' '||apmaterno_emp NOMBRE_EMPLADO,


-- MESE TRABAJADOS DEL AÑO TRIBUTARIO (ANTERIOR)

TRUNC(CASE
	WHEN TRUNC(MONTHS_BETWEEN(SYSDATE, fecha_contrato)) <= 12 
		THEN MONTHS_BETWEEN(SYSDATE, fecha_contrato)-EXTRACT(MONTH FROM fecha_contrato) -- MESES TRABAJADOS MENOS EL MES QUE FUE CONTRATADO
	ELSE 12
END, 1) AS MESES, -- DEVUELVE UN VALOR INFERIOR A 12, O 12

-- AÑOS TRABAJADOS AL AÑO ANTERIOR (-1)

TRUNC(MONTHS_BETWEEN(SYSDATE, fecha_contrato)/12)-1 AS ANNOS_TRABAJADOS,

-- SUELDO BASE

sueldo_base,

-- SUELDO ANUAL 2020 (SEGUN LOS MESES QUE TRABAJÓ)

sueldo_base*TRUNC(CASE
	WHEN TRUNC(MONTHS_BETWEEN(SYSDATE, fecha_contrato)) <= 12 
		THEN MONTHS_BETWEEN(SYSDATE, fecha_contrato)-EXTRACT(MONTH FROM fecha_contrato)
	ELSE 12
END, 1) AS SUELDO_BASE_ANUAL,

-- BONO: SUELDO BASE ANUAL 2020 x PORCENTAJE SEGUN AÑOS TRAB

TRUNC((sueldo_base*TRUNC(CASE
	WHEN TRUNC(MONTHS_BETWEEN(SYSDATE, fecha_contrato)) <= 12 
		THEN MONTHS_BETWEEN(SYSDATE, fecha_contrato)-EXTRACT(MONTH FROM fecha_contrato)
	ELSE 12
END, 1))*(TRUNC(MONTHS_BETWEEN(SYSDATE, fecha_contrato)/12)-1)/100) AS BONO_POR_ANNO,

-- MOVILIZACION 12% DEL SUELDO BASE ANUAL

TRUNC((sueldo_base*TRUNC(CASE
	WHEN TRUNC(MONTHS_BETWEEN(SYSDATE, fecha_contrato)) <= 12 
		THEN MONTHS_BETWEEN(SYSDATE, fecha_contrato)-EXTRACT(MONTH FROM fecha_contrato)
	ELSE 12
END, 1))*0.12) AS MOVILIZACION,

-- COLACION %20 DEL SUELDO BASE ANUAL

TRUNC((sueldo_base*TRUNC(CASE
	WHEN TRUNC(MONTHS_BETWEEN(SYSDATE, fecha_contrato)) <= 12 
		THEN MONTHS_BETWEEN(SYSDATE, fecha_contrato)-EXTRACT(MONTH FROM fecha_contrato)
	ELSE 12
END, 1))*0.2) AS COLACION,

-- SUELDO BRUTO: SUELDO BASE + BONO X AÑOS TRAB + MOVIL + COLAC
(sueldo_base*TRUNC(CASE -- SUELDO BASE ANUAL
	WHEN TRUNC(MONTHS_BETWEEN(SYSDATE, fecha_contrato)) <= 12 
		THEN MONTHS_BETWEEN(SYSDATE, fecha_contrato)-EXTRACT(MONTH FROM fecha_contrato)
	ELSE 12
END, 1)) + 

(TRUNC((sueldo_base*TRUNC(CASE -- + BONO X AÑOS TRAB
	WHEN TRUNC(MONTHS_BETWEEN(SYSDATE, fecha_contrato)) <= 12 
		THEN MONTHS_BETWEEN(SYSDATE, fecha_contrato)-EXTRACT(MONTH FROM fecha_contrato)
	ELSE 12
END, 1))*(TRUNC(MONTHS_BETWEEN(SYSDATE, fecha_contrato)/12)-1)/100)) +
 
(TRUNC((sueldo_base*TRUNC(CASE -- + MOVILIZACION
	WHEN TRUNC(MONTHS_BETWEEN(SYSDATE, fecha_contrato)) <= 12 
		THEN MONTHS_BETWEEN(SYSDATE, fecha_contrato)-EXTRACT(MONTH FROM fecha_contrato)
	ELSE 12
END, 1))*0.12)) + 

(TRUNC((sueldo_base*TRUNC(CASE -- + COLACION
	WHEN TRUNC(MONTHS_BETWEEN(SYSDATE, fecha_contrato)) <= 12 
		THEN MONTHS_BETWEEN(SYSDATE, fecha_contrato)-EXTRACT(MONTH FROM fecha_contrato)
	ELSE 12
END, 1))*0.2)) AS SUELDO_BRUTO_ANUAL,

-- RENTA IMPONIBLE:
(sueldo_base*TRUNC(CASE -- SUELDO BASE ANUAL
	WHEN TRUNC(MONTHS_BETWEEN(SYSDATE, fecha_contrato)) <= 12 
		THEN MONTHS_BETWEEN(SYSDATE, fecha_contrato)-EXTRACT(MONTH FROM fecha_contrato)
	ELSE 12
END, 1)) + 
(TRUNC((sueldo_base*TRUNC(CASE -- BONO X AÑOS TRAB
	WHEN TRUNC(MONTHS_BETWEEN(SYSDATE, fecha_contrato)) <= 12 
		THEN MONTHS_BETWEEN(SYSDATE, fecha_contrato)-EXTRACT(MONTH FROM fecha_contrato)
	ELSE 12
END, 1))*(TRUNC(MONTHS_BETWEEN(SYSDATE, fecha_contrato)/12)-1)/100)) AS RENTA_IMPONIBLE

FROM EMPLEADO

ORDER BY NUMRUN_EMP;