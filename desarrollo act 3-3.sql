-- REQUERIMIENTO 1

--Borrar usuarios
DROP USER "MDY2131_P13_1" CASCADE;
DROP USER "MDY2131_P13_2" CASCADE;
DROP USER "MDY2131_P13_3" CASCADE;
DROP USER "MDY2131_P13_4" CASCADE;
DROP USER "MDY2131_P13_5" CASCADE;
DROP USER "MDY2131_P13_6" CASCADE;

--Borrar perfiles
DROP PROFILE PROFILE_1 CASCADE; 
DROP PROFILE PROFILE_2_3 CASCADE; 
DROP PROFILE profile_4_5_6 CASCADE; 

--Borrar ROLES
DROP ROLE ROL_2_3;
DROP ROLE ROL_5_6;

-- BORRAR SINONIMOS

DROP PUBLIC SYNONYM SYN_APORTE_A_SBIF;
DROP PUBLIC SYNONYM SYN_CLIENTE;
DROP PUBLIC SYNONYM SYN_COMUNA;
DROP PUBLIC SYNONYM SYN_CREDITO; 
DROP PUBLIC SYNONYM SYN_CREDITO_CLIENTE; 
DROP PUBLIC SYNONYM SYN_CUOTA_CREDITO_CLIENTE; 
DROP PUBLIC SYNONYM SYN_FORMA_PAGO;
DROP PUBLIC SYNONYM SYN_MOVIMIENTO; 
DROP PUBLIC SYNONYM SYN_PRODUCTO_INVERSION; 
DROP PUBLIC SYNONYM SYN_PRODUCTO_INVERSION_CLIENTE; 
DROP PUBLIC SYNONYM SYN_PROFESION_OFICIO; 
DROP PUBLIC SYNONYM SYN_PROVINCIA; 
DROP PUBLIC SYNONYM SYN_REGION; 
DROP PUBLIC SYNONYM SYN_SUCURSAL; 
DROP PUBLIC SYNONYM SYN_TIPO_CONTRATO; 
DROP PUBLIC SYNONYM SYN_TIPO_MOVIMIENTO; 

-- CREACION PROFILE_1
CREATE PROFILE PROFILE_1 LIMIT  
CONNECT_TIME UNLIMITED
FAILED_LOGIN_ATTEMPTS 10
PASSWORD_LIFE_TIME 120;

-- CREACION DEL USUARIO MDY2131_P13_1

-- USER SQL
CREATE USER "MDY2131_P13_1" IDENTIFIED BY "XgvQyg8beqMW64aXkgDiS"
DEFAULT TABLESPACE "DATA"
TEMPORARY TABLESPACE "TEMP"
PROFILE PROFILE_1;

-- QUOTAS
ALTER USER "MDY2131_P13_1" QUOTA UNLIMITED ON "DATA";

-- ROLES
GRANT "CONNECT" TO "MDY2131_P13_1";
GRANT "RESOURCE" TO "MDY2131_P13_1";

-- SYSTEM PRIVILEGES
GRANT CREATE ANY INDEX TO "MDY2131_P13_1";
GRANT CREATE SEQUENCE TO "MDY2131_P13_1";
GRANT CREATE PUBLIC SYNONYM TO "MDY2131_P13_1";

-- CREAR Y POBLAR TABLAS CON SCRIPT (EJECUTAR DESDE MDY2131_P13_1)

-- CREACION DE SINONIMOS DE TODAS LAS TABLAS (EJECUTAR DESDE ADMIN)

CREATE OR REPLACE PUBLIC SYNONYM SYN_CREDITO_CLIENTE FOR MDY2131_P13_1.CREDITO_CLIENTE;
CREATE OR REPLACE PUBLIC SYNONYM SYN_PRODUCTO_INVERSION_CLIENTE FOR MDY2131_P13_1.PRODUCTO_INVERSION_CLIENTE;
CREATE OR REPLACE PUBLIC SYNONYM SYN_CUOTA_CREDITO_CLIENTE FOR MDY2131_P13_1.CUOTA_CREDITO_CLIENTE;
CREATE OR REPLACE PUBLIC SYNONYM SYN_TIPO_MOVIMIENTO FOR MDY2131_P13_1.TIPO_MOVIMIENTO;
CREATE OR REPLACE PUBLIC SYNONYM SYN_SUCURSAL FOR MDY2131_P13_1.SUCURSAL;
CREATE OR REPLACE PUBLIC SYNONYM SYN_TIPO_CONTRATO FOR MDY2131_P13_1.TIPO_CONTRATO;
CREATE OR REPLACE PUBLIC SYNONYM SYN_CLIENTE FOR MDY2131_P13_1.CLIENTE;
CREATE OR REPLACE PUBLIC SYNONYM SYN_REGION FOR MDY2131_P13_1.REGION;
CREATE OR REPLACE PUBLIC SYNONYM SYN_PROVINCIA FOR MDY2131_P13_1.PROVINCIA;
CREATE OR REPLACE PUBLIC SYNONYM SYN_COMUNA FOR MDY2131_P13_1.COMUNA;
CREATE OR REPLACE PUBLIC SYNONYM SYN_APORTE_A_SBIF FOR MDY2131_P13_1.APORTE_A_SBIF;
CREATE OR REPLACE PUBLIC SYNONYM SYN_CREDITO FOR MDY2131_P13_1.CREDITO;
CREATE OR REPLACE PUBLIC SYNONYM SYN_FORMA_PAGO FOR MDY2131_P13_1.FORMA_PAGO;
CREATE OR REPLACE PUBLIC SYNONYM SYN_MOVIMIENTO FOR MDY2131_P13_1.MOVIMIENTO;
CREATE OR REPLACE PUBLIC SYNONYM SYN_PRODUCTO_INVERSION FOR MDY2131_P13_1.PRODUCTO_INVERSION;
CREATE OR REPLACE PUBLIC SYNONYM SYN_PROFESION_OFICIO FOR MDY2131_P13_1.PROFESION_OFICIO;

-- CREACION PROFILE 2_3

CREATE PROFILE PROFILE_2_3 LIMIT
CONNECT_TIME 240
IDLE_TIME 60
FAILED_LOGIN_ATTEMPTS 5
PASSWORD_LIFE_TIME 90
PASSWORD_LOCK_TIME 1

-- CREACION ROL 2_3

CREATE ROLE ROL_2_3;

GRANT CREATE SESSION TO ROL_2_3;
GRANT CREATE TRIGGER TO ROL_2_3 ;
GRANT CREATE MATERIALIZED VIEW TO ROL_2_3 ;
GRANT CREATE VIEW TO ROL_2_3;
GRANT CREATE PROCEDURE TO ROL_2_3;

-- CREACION DEL USUARIO MDY2131_P13_2

-- USER SQL
CREATE USER "MDY2131_P13_2" IDENTIFIED BY "SXUc8p3iCM6Z"  
DEFAULT TABLESPACE "DATA"
TEMPORARY TABLESPACE "TEMP"
PROFILE PROFILE_2_3;

-- QUOTAS
ALTER USER "MDY2131_P13_2" QUOTA UNLIMITED ON "DATA";

-- ROLES
GRANT ROL_2_3 TO "MDY2131_P13_2";
ALTER USER "MDY2131_P13_2" DEFAULT ROLE ROL_2_3;

-- PRIVILEGIOS DE OBJETOS
GRANT SELECT ON SYN_TIPO_MOVIMIENTO TO MDY2131_P13_2 WITH GRANT OPTION;
GRANT SELECT ON SYN_SUCURSAL TO MDY2131_P13_2 WITH GRANT OPTION;
GRANT SELECT ON SYN_TIPO_CONTRATO TO MDY2131_P13_2 WITH GRANT OPTION;
GRANT SELECT ON SYN_CLIENTE TO MDY2131_P13_2 WITH GRANT OPTION;
GRANT SELECT ON SYN_REGION TO MDY2131_P13_2 WITH GRANT OPTION;
GRANT SELECT ON SYN_PROVINCIA TO MDY2131_P13_2 WITH GRANT OPTION;
GRANT SELECT ON SYN_COMUNA TO MDY2131_P13_2 WITH GRANT OPTION;
GRANT SELECT ON SYN_APORTE_A_SBIF TO MDY2131_P13_2 WITH GRANT OPTION;
GRANT SELECT ON SYN_CREDITO TO MDY2131_P13_2 WITH GRANT OPTION;
GRANT SELECT ON SYN_FORMA_PAGO TO MDY2131_P13_2 WITH GRANT OPTION;
GRANT SELECT ON SYN_MOVIMIENTO TO MDY2131_P13_2 WITH GRANT OPTION;
GRANT SELECT ON SYN_PRODUCTO_INVERSION TO MDY2131_P13_2 WITH GRANT OPTION;
GRANT SELECT ON SYN_PROFESION_OFICIO TO MDY2131_P13_2 WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON SYN_CREDITO_CLIENTE TO MDY2131_P13_2 WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON SYN_PRODUCTO_INVERSION_CLIENTE TO MDY2131_P13_2 WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON SYN_CUOTA_CREDITO_CLIENTE TO MDY2131_P13_2 WITH GRANT OPTION;


-- CREACION DEL USUARIO MDY2131_P13_3

-- USER SQL
CREATE USER "MDY2131_P13_3" IDENTIFIED BY "G36jwc4Y797P"
DEFAULT TABLESPACE "DATA"
TEMPORARY TABLESPACE "TEMP"
PROFILE PROFILE_2_3;

-- QUOTAS
ALTER USER "MDY2131_P13_3" QUOTA UNLIMITED ON "DATA";

-- ROLES
GRANT "ROL_2_3" TO "MDY2131_P13_3";
ALTER USER "MDY2131_P13_3" DEFAULT ROLE "ROL_2_3";

-- PRIVILEGIOS DE OBJETOS
GRANT SELECT ON SYN_TIPO_MOVIMIENTO TO MDY2131_P13_3 WITH GRANT OPTION;
GRANT SELECT ON SYN_SUCURSAL TO MDY2131_P13_3 WITH GRANT OPTION;
GRANT SELECT ON SYN_TIPO_CONTRATO TO MDY2131_P13_3 WITH GRANT OPTION;
GRANT SELECT ON SYN_CLIENTE TO MDY2131_P13_3 WITH GRANT OPTION;
GRANT SELECT ON SYN_REGION TO MDY2131_P13_3 WITH GRANT OPTION;
GRANT SELECT ON SYN_PROVINCIA TO MDY2131_P13_3 WITH GRANT OPTION;
GRANT SELECT ON SYN_COMUNA TO MDY2131_P13_3 WITH GRANT OPTION;
GRANT SELECT ON SYN_APORTE_A_SBIF TO MDY2131_P13_3 WITH GRANT OPTION;
GRANT SELECT ON SYN_CREDITO TO MDY2131_P13_3 WITH GRANT OPTION;
GRANT SELECT ON SYN_FORMA_PAGO TO MDY2131_P13_3 WITH GRANT OPTION;
GRANT SELECT ON SYN_MOVIMIENTO TO MDY2131_P13_3 WITH GRANT OPTION;
GRANT SELECT ON SYN_PRODUCTO_INVERSION TO MDY2131_P13_3 WITH GRANT OPTION;
GRANT SELECT ON SYN_PROFESION_OFICIO TO MDY2131_P13_3 WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON SYN_CREDITO_CLIENTE TO MDY2131_P13_3 WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON SYN_PRODUCTO_INVERSION_CLIENTE TO MDY2131_P13_3 WITH GRANT OPTION;
GRANT SELECT, INSERT, UPDATE, DELETE ON SYN_CUOTA_CREDITO_CLIENTE TO MDY2131_P13_3 WITH GRANT OPTION;

-- CREACION PERFIL 4_5_6

CREATE PROFILE PROFILE_4_5_6 LIMIT 
CONNECT_TIME 120
IDLE_TIME 20
FAILED_LOGIN_ATTEMPTS 2
PASSWORD_LIFE_TIME 90
PASSWORD_LOCK_TIME 1
PASSWORD_GRACE_TIME 1;

-- CREACION DEL USUARIO MDY2131_P13_4

-- USER SQL
CREATE USER "MDY2131_P13_4" IDENTIFIED BY "tHPf6q766SyB"
DEFAULT TABLESPACE "DATA"
TEMPORARY TABLESPACE "TEMP"
PROFILE PROFILE_4_5_6;

-- QUOTAS
ALTER USER "MDY2131_P13_4" QUOTA 100M ON "DATA";

-- ROLES
GRANT CREATE SESSION TO "MDY2131_P13_4" ;

-- PRIVILEGIOS

GRANT SELECT ON SYN_TIPO_MOVIMIENTO TO MDY2131_P13_4;
GRANT SELECT ON SYN_SUCURSAL TO MDY2131_P13_4;
GRANT SELECT ON SYN_TIPO_CONTRATO TO MDY2131_P13_4;
GRANT SELECT ON SYN_CLIENTE TO MDY2131_P13_4;
GRANT SELECT ON SYN_REGION TO MDY2131_P13_4;
GRANT SELECT ON SYN_PROVINCIA TO MDY2131_P13_4;
GRANT SELECT ON SYN_COMUNA TO MDY2131_P13_4;

-- CREACION ROL_5_6

CREATE ROLE ROL_5_6;
GRANT CREATE SESSION TO ROL_5_6;

-- CREACION DEL USUARIO MDY2131_P13_5

-- USER SQL
CREATE USER "MDY2131_P13_5" IDENTIFIED BY "5LmS2hWoy6TR"
DEFAULT TABLESPACE "DATA"
TEMPORARY TABLESPACE "TEMP"
PROFILE PROFILE_4_5_6;

-- QUOTAS
ALTER USER "MDY2131_P13_5" QUOTA 100M ON "DATA";

-- ROLES
GRANT "ROL_5_6" TO "MDY2131_P13_5";
ALTER USER "MDY2131_P13_5" DEFAULT ROLE "ROL_5_6";

-- PRIVILEGIOS
GRANT SELECT ON SYN_CLIENTE TO MDY2131_P13_5;
GRANT SELECT ON SYN_REGION TO MDY2131_P13_5;
GRANT SELECT ON SYN_PROVINCIA TO MDY2131_P13_5;
GRANT SELECT ON SYN_COMUNA TO MDY2131_P13_5;

-- CREACION DEL USUARIO MDY2131_P13_6

-- USER SQL
CREATE USER "MDY2131_P13_6" IDENTIFIED BY "88vdUTK5WcHZ"
DEFAULT TABLESPACE "DATA"
TEMPORARY TABLESPACE "TEMP"
PROFILE PROFILE_4_5_6;

-- QUOTAS
ALTER USER "MDY2131_P13_6" QUOTA 100M ON "DATA";

-- ROLES
GRANT "ROL_5_6" TO "MDY2131_P13_6";
ALTER USER "MDY2131_P13_5" DEFAULT ROLE "ROL_5_6";

-- PRIVILEGIOS
GRANT SELECT ON SYN_CLIENTE TO MDY2131_P13_6;
GRANT SELECT ON SYN_REGION TO MDY2131_P13_6;
GRANT SELECT ON SYN_PROVINCIA TO MDY2131_P13_6;
GRANT SELECT ON SYN_COMUNA TO MDY2131_P13_6;

-- REQUERIMINETO 2

-- EJECUTAR DESDE USUARIO 2 (MDY2131_P13_2):

-- CREACION VISTA USUARIO 2

CREATE OR REPLACE VIEW V_TOTAL_CREDITOS_CLIENTE AS
SELECT c.numrun || '-' || c.dvrun "RUN CLIENTE",
       INITCAP(c.pnombre || ' ' || c.snombre || ' ' || c.appaterno || ' ' || c.appaterno) "NOMBRE CLIENTE",
       COUNT(cc.nro_cliente) "CREDITOS SOLICITADOS"
FROM SYN_CLIENTE c JOIN SYN_CREDITO_CLIENTE cc
ON cc.nro_cliente = c.nro_cliente
GROUP BY c.numrun, c.dvrun,c.pnombre,c.snombre,c.appaterno,c.appaterno
ORDER BY c.appaterno;

-- EJECUTAR DESDE USUARIO 3 (MDY2131_P13_3)

-- CREACION VISTA USUARIO 3

CREATE VIEW V_DATOS_CLIENTES AS
SELECT TO_CHAR(c.numrun,'09G999G999') || '-' || UPPER(c.dvrun) "RUN CLIENTE",
       INITCAP(c.pnombre || ' ' || c.snombre || ' ' || c.appaterno || ' ' || c.apmaterno) "NOMBRE CLIENTE",
       c.direccion || ',' || co.nombre_comuna "Dirección Cliente"
FROM syn_cliente c JOIN syn_region r
ON c.cod_region=r.cod_region
JOIN syn_provincia p
ON c.cod_region=p.cod_region AND c.cod_provincia=p.cod_provincia
JOIN syn_comuna co
ON c.cod_region=co.cod_region AND c.cod_provincia=co.cod_provincia AND c.cod_comuna=co.cod_comuna
ORDER BY c.appaterno;

-- EJECUTAR DESDE EL USUARIO 2 (MDY2131_P13_2)
GRANT SELECT ON V_TOTAL_CREDITOS_CLIENTE TO MDY2131_P13_4;

-- EJECUTAR DESDE EL USUARIO 3 (MDY2131_P13_3)
GRANT SELECT ON V_DATOS_CLIENTES TO MDY2131_P13_5;
GRANT SELECT ON V_DATOS_CLIENTES TO MDY2131_P13_6;

-- CONSULTAS DE INFORMES

-- EJECUTAR DESDE EL USUARIO 4 (MDY2131_P13_4)
SELECT * FROM MDY2131_P13_2.V_TOTAL_CREDITOS_CLIENTE;

-- EJECUTAR DESDE EL USUARIO 5 (MDY2131_P13_5) Y 6 (MDY2131_P13_6)
SELECT * FROM MDY2131_P13_3.V_DATOS_CLIENTES;


/*

1) Según la información del Requerimiento N°2 ¿Cuál es el problema que se debe resolver?

       Se requiere que los usuarios genericos 4, 5, y 6 puedan acceder a las vistas creadas por los usuarios 2 y 3, 
       en donde se encuentra información sobre los datos de los clientes y sus creditos solicitados. 
       Especificamente el usuario 4 debe consultar el informe (vista) generado por el usuario 2, 
       y los usuarios 5 y 6 deben consultar el informe (vista) generado por el usuario 3.
       

2) ¿Qué alternativas se solución propone Ud. para resolver el problema planteado? Cada integrante del equipo debe proponer a lo menos 1 alternativa.

       Alternativa 01 (Patricio Villarroel):
       Realizar la creacion de usuarios lo mas apegado a los requerimientos del problema planteado
       Recurrir al principio del minimo privilegio y proteger las tablas originales
       Crear perfiles y roles antes de crear los usuarios
       Crear usuarios y asignarles los roles y perfiles ya creados, ademas de privilegios extras

       Alternativa 02 (Noemi Gonzalez):
       Una alternativa podría ser otórgales a los usuarios 4, 5 y 6 los privilegios necesarios 
       para visualizar cualquier vista creada por los usuarios 2 y 3.

       Alternativa 03 (Wladimir Urzua):
       No crear y/o eliminar el usuario MDY2131_P13_6 ya que es idéntico en privilegios de sistema y de objetos al usuario MDY2131_P13_5, 
       por lo que como resultado solo el usuario MDY2131_P13_5 tendría la responsabilidad de ejecutar los informes del usuario MDY2131_P13_3 
       y de consultar las tablas que se le permitan del usuario MDY2131_P13_1(CLIENTE, REGION, PROVINCIA, COMUNA).

3) De cada alternativa de solución propuesta, indique sus riegos y ventajas.  

       Alternativa 01:
       Las ventajas de la alternativa 1 es que se cuidarian los datos de ser accedidos o visualizados directamente sobre las tablas
       Cada usuario tendria los privilegios precisos, y por otro lado la cantidad de sentencias en la gestion seria menor.
       Los riesgos tienen que ver con una cierta rigidez en la gestion, asi que por cada sentencia creada por los usuarios desarrolladores
       Se deberian otorgar nuevos privilegios a los usuarios de consultas de informes

       Alternativa 02:
       Los riesgo de la alternativa 2 es que al tener mas acceso de lo necesario, se podría provocar fuga de información relevante y comprometer la integridad de la base de datos.
       Las ventajas son que cualquiera de los usuarios 4, 5 y 6 podría visualizar las vistas creadas por los desarrolladores del sistema informático bancario cuando lo requiera.

       Alternativa 03:
       Las ventajas se resumen en una menor redundancia de código, 
       menor costo en capital humano para la administración de la base de datos
       y disminución en el pool de conexiones de base de datos.
       Los riesgos tienen relacion con una mayor exposición a filtración de información delicada 
       debido a tener solo 1 usuario, ya que se accedería a todo en vez de a solo el esquema del MDY2131_P13_5 y no al del MDY2131_P13_6

4) Fundamente la(s) razón(es) de la alternativa de solución que el equipo escogió y detalle en lenguaje natural los pasos para construirla

       Como equipo escogimos la alternativa 01 ya que al estar mas apegada al requerimiento nos desafiaba a hacer las cosas como en una situacion real

       Pasos para desarrollar la alternativa:

       Primero se deben crear perfiles y roles de acuerdo a las caracteristicas y privilegios necesarios para cada usuario y/o grupo de usuarios
       No utilizar roles connect o resource inmediatamente, excepto en el usuario 1 para que trabaje con sus tablas
       Se deben crear el usuario 1 y crear y poblar tablas con el sql ya disponible
       Para proteger los nombres de las tablas en la ejecucion de sentencias se deben crear sinonimos publicos de todas las tablas del usuario 1
       Se deben crear los 5 otros usuarios para asignarles los roles y perfiles ya creados segun corresponda
       Si un conjunto de privilegios solo se aplica a 1 usuario, entonces se aplicaran directamente y no contenidos en un rol
       Revisar si algunos requerimientos se pueden aplicar sobre rol y no usuario (como el que incluye WITH GRANT OPTION)
       Crear vistas ya dispuestas en los archivos sql con usuarios 2 y 3
       Otorgarle el privilegio de objeto al usuario 4 para realizar consultas sobre la vista creada por el usuario 2
       Otorgarle el privilegio de objeto los usuarios 5 y 6 para realizar consultas sobre la vista creada por el usuario 3
       La consulta ejecutada por el usuario 4 debera ocurrir sobre la vista creada por el usuarios 2
       Las consultas ejecutadas por los usuarios usuarios 5 y 6 deberan ocurrir sobre la vista creada por el usuarios 3


*/