-- CASO 1

SELECT 
NUMRUN_CLI||'-'||DVRUN_CLI AS "RUN CLIENTE",
PNOMBRE_CLI||' '||SNOMBRE_CLI||' '||APPATERNO_CLI||' '||APMATERNO_CLI AS "NOMBRE CLIENTE",
DIRECCION,
NVL(TO_CHAR(FONO_FIJO_CLI), 'NO POSEE TELEFONO FIJO') AS "TELEFONO FIJO",
NVL(TO_CHAR(CELULAR_CLI), 'NO POSEE CELULAR')  AS "CELULAR",
ID_COMUNA AS "COMUNA"
FROM CLIENTE
ORDER BY &ORDEN1ASC ASC, &ORDEN2DESC DESC;

-- CASO 2

SELECT
'El empleado '||PNOMBRE_EMP||' '||APPATERNO_EMP||' '||APMATERNO_EMP||
' estuvo de cumpleaños el '||TO_CHAR(FECHA_NAC, 'DD')||' de '||TO_CHAR(FECHA_NAC,'Month'))||
'.Cumplió '||ROUND(MONTHS_BETWEEN(SYSDATE, FECHA_NAC)/12)||' años.'
AS "LISTADO DE CUMPLEAÑOS"
FROM EMPLEADO;

-- CASO 2 OPC B

SELECT
'El empleado '||PNOMBRE_EMP||' '||APPATERNO_EMP||' '||APMATERNO_EMP||
' estuvo de cumpleaños el '||TO_CHAR(FECHA_NAC, 'DD "de" Mon.')||
' Cumplió '||ROUND(MONTHS_BETWEEN(SYSDATE, FECHA_NAC)/12)||' años.'
AS "LISTADO DE CUMPLEAÑOS"
FROM EMPLEADO
WHERE TO_CHAR(FECHA_NAC, 'MM') = TO_CHAR(ADD_MONTHS(SYSDATE, -1), 'MM');

-- CASO 3

SELECT

CASE ID_TIPO_CAMION
	WHEN 'A' THEN 'Tradicional 6 Toneladas'
	WHEN 'B' THEN 'Frigorífico'
	WHEN 'C' THEN 'Camión 3/4'
	WHEN 'D' THEN 'Trailer'
	WHEN 'E' THEN 'Tolva'
END "TIPO CAMION",

NRO_PATENTE "NRO PATENTE", 
ANIO "AÑO", 
TO_CHAR(NVL(VALOR_ARRIENDO_DIA, 0), 'L999G999G999') "VALOR ARRIENDO DIA", 
TO_CHAR(NVL(VALOR_GARANTIA_DIA, 0), 'L999G999G999') "VALOR GARANTIA DIA",
TO_CHAR(NVL(VALOR_ARRIENDO_DIA, 0)+NVL(VALOR_GARANTIA_DIA, 0), 'L999G999G999') "VALOR TOTAL DIA"

FROM CAMION

ORDER BY 
	"TIPO CAMION", 
	"VALOR ARRIENDO DIA" DESC, 
	"VALOR GARANTIA DIA", 
	"NRO PATENTE";

-- CASO 4

SELECT
TO_CHAR(SYSDATE, 'MM/YYYY') AS "FECHA PROCESO",
TO_CHAR(NUMRUN_EMP, '09G999G999')||'-'||DVRUN_EMP AS "RUN EMPLEADO",
PNOMBRE_EMP||' '||SNOMBRE_EMP||' '||APPATERNO_EMP||' '||APMATERNO_EMP AS "NOMBRE EMPLEADO",
TO_CHAR(SUELDO_BASE, 'L999G999G999') AS "SUELDO BASE",

TO_CHAR((&UTILIDADES*(CASE
	WHEN SUELDO_BASE BETWEEN 320000 AND 450000 THEN 0.5
	WHEN SUELDO_BASE BETWEEN 450001 AND 600000 THEN 0.35
	WHEN SUELDO_BASE BETWEEN 600001 AND 900000 THEN 0.25
    WHEN SUELDO_BASE BETWEEN 900001 AND 1800000 THEN 0.15
    WHEN SUELDO_BASE > 1800000 THEN 0.1
END))/100, 'L999G999G999') AS "BONIFICACION POR UTILIDADES"

FROM EMPLEADO
ORDER BY APPATERNO_EMP ASC;

UNDEFINE UTILIDADES

-- CASO 5

SELECT
NUMRUN_EMP||'-'||DVRUN_EMP AS "RUN EMPLEADO",
PNOMBRE_EMP||' '||SNOMBRE_EMP||' '||APPATERNO_EMP||' '||APMATERNO_EMP AS "NOMBRE EMPLADO",
ROUND(MONTHS_BETWEEN(SYSDATE, FECHA_CONTRATO)/12) AS "AÑOS CONTRATADO",
TO_CHAR(SUELDO_BASE, 'L999G999G999') AS "SUELDO BASE",
TO_CHAR(ROUND(SUELDO_BASE * ROUND(MONTHS_BETWEEN(SYSDATE, FECHA_CONTRATO)/12)/100), 'L999G999G999') AS "VALOR MOVILIZACIÓN",

TO_CHAR(ROUND(SUELDO_BASE*((CASE 
    WHEN SUELDO_BASE >= 450000 THEN SUBSTR(TO_CHAR(SUELDO_BASE), 0, 1)
    WHEN SUELDO_BASE < 450000 THEN SUBSTR(TO_CHAR(SUELDO_BASE), 0, 2)
END)/100)), 'L999G999G999') AS "BONIF. EXTRA MOVILIZACION",

TO_CHAR(ROUND(SUELDO_BASE * ROUND(MONTHS_BETWEEN(SYSDATE, FECHA_CONTRATO)/12)/100) +
ROUND(SUELDO_BASE*((CASE 
    WHEN SUELDO_BASE >= 450000 THEN SUBSTR(TO_CHAR(SUELDO_BASE), 0, 1)
    WHEN SUELDO_BASE < 450000 THEN SUBSTR(TO_CHAR(SUELDO_BASE), 0, 2)
END)/100)),'L999G999G999') AS "VALOR MOVILIZACION TOTAL"

FROM EMPLEADO
WHERE ID_COMUNA IN(117, 118, 120, 122)
ORDER BY APPATERNO_EMP ASC;

-- CASO 6

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