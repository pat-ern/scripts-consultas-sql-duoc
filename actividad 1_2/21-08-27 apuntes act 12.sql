-- EL WHERE

SELECT 
NUM_RUT, DVRUT_EMP, NOMBRE_EMP, APPATERNO_EMP, APMATERNO_EMP, SUELDO_EMP
FROM EMPLEADO
WHERE
SUELDO_EMP > 1500000
ORDER BY SUELDO_EMP DESC;

-- funciones upper y lower
-- WHERE es case sensitive

SELECT 
NUM_RUT, DVRUT_EMP, NOMBRE_EMP, APPATERNO_EMP, APMATERNO_EMP, SUELDO_EMP
FROM EMPLEADO
WHERE LOWER(NOMBRE_EMP) = LOWER('MARTA')
ORDER BY SUELDO_EMP DESC;

-- 

SELECT 
NUM_RUT, DVRUT_EMP, NOMBRE_EMP, APPATERNO_EMP, APMATERNO_EMP, SUELDO_EMP
FROM EMPLEADO
WHERE ID_ESCIVIL <>1;

-- BETWEEN

SELECT 
NUM_RUT, DVRUT_EMP, NOMBRE_EMP, APPATERNO_EMP, APMATERNO_EMP, SUELDO_EMP
FROM EMPLEADO
WHERE SUELDO_EMP BETWEEN 300000 AND 1000000
ORDER BY SUELDO_EMP;

-- EL 'IN': VALORES QUE ESTAN EN UNA LISTA

SELECT
NRO_PROPIEDAD, NRO_DORMITORIOS
FROM PROPIEDAD
WHERE NRO_DORMITORIOS = 1 OR NORO_DORMITORIOS = 2 OR NRO_DORMITORIOS = 3;

SELECT
NRO_PROPIEDAD, NRO_DORMITORIOS
FROM PROPIEDAD
WHERE NRO_DORMITORIOS IN (1,2,3);

--- UNA LETRA EN EL NOMBRE

SELECT
NUM_RUT, DVRUT_EMP, NOMBRE_EMP, APPATERNO_EMP, APMATERNO_EMP, SUELDO_EMP
FROM EMPLEADO
WHERE APPATERNO_EMP LIKE '__A%'

-- IS NULL

SELECT
NRO_PROPIEDAD, NRO_DORMITORIOS
FROM NRO_PROPIEDAD
WHERE VALOR_GASTI_COMUN IS NULL;

-- IS NOT NULL

SELECT
NRO_PROPIEDAD, NRO_DORMITORIOS
FROM NRO_PROPIEDAD
WHERE VALOR_GASTI_COMUN IS NOT NULL;