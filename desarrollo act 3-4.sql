
-- CREACION DE USUARIO MDY2131_P14_2
CREATE USER MDY2131_P14_2 IDENTIFIED BY "dw2V46RsnuD6"
DEFAULT TABLESPACE "DATA"
TEMPORARY TABLESPACE "TEMP";

-- QUOTAS
ALTER USER "MDY2131_P14_2" QUOTA 102400K ON "DATA";

-- ROLES
GRANT "CONNECT" TO MDY2131_P14_1;
GRANT "RESOURCE" TO MDY2131_P14_1;
ALTER USER "MDY2131_P14_2" DEFAULT ROLE "CONNECT","RESOURCE";

-- SYSTEM PRIVILEGES
GRANT CREATE VIEW TO MDY2131_P14_2;

-- OBJECT PRIVILEGES (DESDE MDY2131_P14_1)
GRANT SELECT ON APORTE_A_SBIF TO MDY2131_P14_2;
GRANT SELECT ON CLIENTE TO MDY2131_P14_2;
GRANT SELECT ON COMUNA TO MDY2131_P14_2;
GRANT SELECT ON CREDITO TO MDY2131_P14_2;
GRANT SELECT ON CREDITO_CLIENTE TO MDY2131_P14_2;
GRANT SELECT ON CUOTA_CREDITO_CLIENTE TO MDY2131_P14_2;
GRANT SELECT ON FORMA_PAGO TO MDY2131_P14_2;
GRANT SELECT ON MOVIMIENTO TO MDY2131_P14_2;
GRANT SELECT ON PRODUCTO_INVERSION TO MDY2131_P14_2;
GRANT SELECT ON PRODUCTO_INVERSION_CLIENTE TO MDY2131_P14_2;
GRANT SELECT ON PROFESION_OFICIO TO MDY2131_P14_2;
GRANT SELECT ON PROVINCIA TO MDY2131_P14_2;
GRANT SELECT ON REGION TO MDY2131_P14_2;
GRANT SELECT ON SUCURSAL TO MDY2131_P14_2;
GRANT SELECT ON TIPO_CONTRATO TO MDY2131_P14_2;
GRANT SELECT ON TIPO_MOVIMIENTO TO MDY2131_P14_2;

GRANT INDEX on MDY2131_P14_1.APORTE_A_SBIF to MDY2131_P14_2; --
GRANT INDEX on MDY2131_P14_1.CLIENTE to MDY2131_P14_2; --
GRANT INDEX on MDY2131_P14_1.COMUNA to MDY2131_P14_2; 
GRANT INDEX on MDY2131_P14_1.CREDITO to MDY2131_P14_2; 
GRANT INDEX on MDY2131_P14_1.CREDITO_CLIENTE to MDY2131_P14_2; 
GRANT INDEX on MDY2131_P14_1.CUOTA_CREDITO_CLIENTE to MDY2131_P14_2; 
GRANT INDEX on MDY2131_P14_1.FORMA_PAGO to MDY2131_P14_2; 
GRANT INDEX on MDY2131_P14_1.MOVIMIENTO to MDY2131_P14_2; 
GRANT INDEX on MDY2131_P14_1.PRODUCTO_INVERSION to MDY2131_P14_2; 
GRANT INDEX on MDY2131_P14_1.PRODUCTO_INVERSION_CLIENTE to MDY2131_P14_2; 
GRANT INDEX on MDY2131_P14_1.PROFESION_OFICIO to MDY2131_P14_2; 
GRANT INDEX on MDY2131_P14_1.PROVINCIA to MDY2131_P14_2; 
GRANT INDEX on MDY2131_P14_1.REGION to MDY2131_P14_2; 
GRANT INDEX on MDY2131_P14_1.SUCURSAL to MDY2131_P14_2; 
GRANT INDEX on MDY2131_P14_1.TIPO_CONTRATO to MDY2131_P14_2; 
GRANT INDEX on MDY2131_P14_1.TIPO_MOVIMIENTO to MDY2131_P14_2; 


-- VISTA/CONSULTA PUNTO 4

CREATE OR REPLACE VIEW V_CLIENTES_CREDIT_MAYOR_PROM AS
SELECT TO_CHAR(crc.fecha_otorga_cred,'MMYYYY') "MES TRANSACCIÓN",
       c.nombre_credito "TIPO CREDITO",
       SUM(crc.monto_credito) "MONTO SOLICITADO CREDITO",
       SUM(CASE WHEN crc.monto_credito BETWEEN 100000 AND 1000000 THEN ROUND(crc.monto_credito*0.01)
            WHEN crc.monto_credito BETWEEN 1000001 AND 2000000 THEN ROUND(crc.monto_credito*0.02)
            WHEN crc.monto_credito BETWEEN 2000001 AND 4000000 THEN ROUND(crc.monto_credito*0.03)
            WHEN crc.monto_credito BETWEEN 4000001 AND 6000000 THEN ROUND(crc.monto_credito*0.04)
       ELSE ROUND(crc.monto_credito*0.07) END) "APORTE A LA SBIF"
FROM MDY2131_P14_1.credito_cliente crc JOIN MDY2131_P14_1.credito c
ON crc.cod_credito=c.cod_credito
AND crc.monto_credito > (SELECT ROUND(AVG(monto_credito))
                          FROM MDY2131_P14_1.credito_cliente)
GROUP BY TO_CHAR(crc.fecha_otorga_cred,'MMYYYY'), c.nombre_credito
ORDER BY TO_CHAR(crc.fecha_otorga_cred,'MMYYYY'), c.nombre_credito;

-- CREACION INDICE

CREATE INDEX IDX_CREDITO_CLIENTE ON MDY2131_P14_1.CREDITO_CLIENTE(MONTO_CREDITO);

-- CONSULTA PUNTO 5

SELECT TO_CHAR(c.numrun,'09G999G999') || '-' || UPPER(c.dvrun) "RUN CLIENTE",
       INITCAP(c.pnombre || ' ' || c.snombre || ' ' || c.appaterno || ' ' || c.apmaterno) "NOMBRE CLIENTE",
       pi.nombre_prod_inv "PRODUCTO DE INVERSION",
       pic.monto_total_ahorrado "MONTO TOTAL AHORRADO"
FROM MDY2131_P14_1.cliente c JOIN MDY2131_P14_1.producto_inversion_cliente pic
ON c.nro_cliente = pic.nro_cliente
JOIN MDY2131_P14_1.producto_inversion pi
ON pic.cod_prod_inv=pi.cod_prod_inv
AND EXTRACT(YEAR FROM pic.fecha_solic_prod)=EXTRACT(YEAR FROM SYSDATE)
AND c.cod_tipo_contrato = 1
ORDER BY c.appaterno;

-- CREACION INDICE

CREATE INDEX IDX_PROD_INV_CLI_ANUAL ON MDY2131_P14_1.PRODUCTO_INVERSION_CLIENTE(EXTRACT(YEAR FROM FECHA_SOLIC_PROD));

CREATE INDEX IDX_PROD_CLI_DEPEN2 ON MDY2131_P14_1.CLIENTE(NRO_CLIENTE, COD_TIPO_CONTRATO);