--------------------------------------------------------
-- Archivo creado  - domingo-octubre-11-2026   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Sequence SEQ_ASIGNACION
--------------------------------------------------------

   CREATE SEQUENCE  "ADMIN_ENPH"."SEQ_ASIGNACION"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 102 NOCACHE  NOORDER  NOCYCLE
--------------------------------------------------------
--  DDL for Sequence SEQ_FORMA
--------------------------------------------------------

   CREATE SEQUENCE  "ADMIN_ENPH"."SEQ_FORMA"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 101 NOCACHE  NOORDER  NOCYCLE
--------------------------------------------------------
--  DDL for Sequence SEQ_LUGAR
--------------------------------------------------------

   CREATE SEQUENCE  "ADMIN_ENPH"."SEQ_LUGAR"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 101 NOCACHE  NOORDER  NOCYCLE
--------------------------------------------------------
--  DDL for Sequence SEQ_REGISTRO
--------------------------------------------------------

   CREATE SEQUENCE  "ADMIN_ENPH"."SEQ_REGISTRO"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 104 NOCACHE  NOORDER  NOCYCLE
--------------------------------------------------------
--  DDL for Sequence SEQ_ROL
--------------------------------------------------------

   CREATE SEQUENCE  "ADMIN_ENPH"."SEQ_ROL"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 100 NOCACHE  NOORDER  NOCYCLE
--------------------------------------------------------
--  DDL for Sequence SEQ_VISITA
--------------------------------------------------------

   CREATE SEQUENCE  "ADMIN_ENPH"."SEQ_VISITA"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 104 NOCACHE  NOORDER  NOCYCLE
--------------------------------------------------------
--  DDL for Table CATEGORIA_PRODUCTO
--------------------------------------------------------

  CREATE TABLE "ADMIN_ENPH"."CATEGORIA_PRODUCTO" 
   (	"ID_CATEGORIA" NUMBER(4,0) NOT NULL ENABLE, 
	"NOMBRE_CATEGORIA" VARCHAR2(60) NOT NULL ENABLE, 
	 CONSTRAINT "PK_CATEGORIA" PRIMARY KEY ("ID_CATEGORIA") ENABLE, 
	 CONSTRAINT "UK_CATEGORIA_NOMBRE" UNIQUE ("NOMBRE_CATEGORIA") ENABLE
   )
--------------------------------------------------------
--  DDL for Table HOGAR
--------------------------------------------------------

  CREATE TABLE "ADMIN_ENPH"."HOGAR" 
   (	"ID_HOGAR" NUMBER(6,0) NOT NULL ENABLE, 
	"DIR_BARRIO" VARCHAR2(60) NOT NULL ENABLE, 
	"DIR_NUMERO" VARCHAR2(30) NOT NULL ENABLE, 
	"MUNICIPIO" VARCHAR2(60) NOT NULL ENABLE, 
	"CIUDAD" VARCHAR2(60) NOT NULL ENABLE, 
	"ESTRATO" NUMBER(1,0) NOT NULL ENABLE, 
	"NOMBRE_JEFE" VARCHAR2(100) NOT NULL ENABLE, 
	"DOCUMENTO_JEFE" VARCHAR2(15) NOT NULL ENABLE, 
	"TELEFONO_CONTACTO" VARCHAR2(15), 
	"FECHA_INICIO" DATE, 
	"FECHA_FIN" DATE, 
	"ESTADO" VARCHAR2(15) DEFAULT 'PENDIENTE' NOT NULL ENABLE, 
	 CONSTRAINT "CK_HOGAR_ESTRATO" CHECK (estrato BETWEEN 1 AND 6) ENABLE, 
	 CONSTRAINT "CK_HOGAR_ESTADO" CHECK (estado IN ('PENDIENTE','ACTIVO','COMPLETO','VALIDADO','SUSPENDIDO')) ENABLE, 
	 CONSTRAINT "CK_HOGAR_FECHAS" CHECK (fecha_fin IS NULL OR fecha_fin >= fecha_inicio) ENABLE, 
	 CONSTRAINT "PK_HOGAR" PRIMARY KEY ("ID_HOGAR") ENABLE
   )
--------------------------------------------------------
--  DDL for Table PRODUCTO
--------------------------------------------------------

  CREATE TABLE "ADMIN_ENPH"."PRODUCTO" 
   (	"ID_PRODUCTO" NUMBER(8,0) NOT NULL ENABLE, 
	"ID_CATEGORIA" NUMBER(4,0) NOT NULL ENABLE, 
	"NOMBRE_PRODUCTO" VARCHAR2(100) NOT NULL ENABLE, 
	"UNIDAD_MEDIDA" VARCHAR2(20) NOT NULL ENABLE, 
	 CONSTRAINT "PK_PRODUCTO" PRIMARY KEY ("ID_PRODUCTO") ENABLE, 
	 CONSTRAINT "FK_PRODUCTO_CATEGORIA" FOREIGN KEY ("ID_CATEGORIA")
	  REFERENCES "ADMIN_ENPH"."CATEGORIA_PRODUCTO" ("ID_CATEGORIA") ENABLE
   )
--------------------------------------------------------
--  DDL for Table REVISION_CASO
--------------------------------------------------------

  CREATE TABLE "ADMIN_ENPH"."REVISION_CASO" 
   (	"ID_REVISION" NUMBER(8,0) NOT NULL ENABLE, 
	"ID_HOGAR" NUMBER(6,0) NOT NULL ENABLE, 
	"ID_SUPERVISOR" NUMBER(6,0) NOT NULL ENABLE, 
	"FECHA_REVISION" DATE DEFAULT SYSDATE NOT NULL ENABLE, 
	"RESULTADO" VARCHAR2(10) NOT NULL ENABLE, 
	"OBSERVACIONES" VARCHAR2(250), 
	 CONSTRAINT "CK_REV_RESULTADO" CHECK (resultado IN ('APROBADO','DEVUELTO')) ENABLE, 
	 CONSTRAINT "PK_REVISION" PRIMARY KEY ("ID_REVISION") ENABLE, 
	 CONSTRAINT "FK_REV_HOGAR" FOREIGN KEY ("ID_HOGAR")
	  REFERENCES "ADMIN_ENPH"."HOGAR" ("ID_HOGAR") ENABLE, 
	 CONSTRAINT "FK_REV_SUPERVISOR" FOREIGN KEY ("ID_SUPERVISOR")
	  REFERENCES "ADMIN_ENPH"."USUARIO" ("ID_USUARIO") ENABLE
   )
--------------------------------------------------------
--  DDL for Table USUARIO
--------------------------------------------------------

  CREATE TABLE "ADMIN_ENPH"."USUARIO" 
   (	"ID_USUARIO" NUMBER(6,0) NOT NULL ENABLE, 
	"ID_ROL" NUMBER(2,0) NOT NULL ENABLE, 
	"ID_SUPERVISOR" NUMBER(6,0), 
	"NOMBRE_COMPLETO" VARCHAR2(100) NOT NULL ENABLE, 
	"DOCUMENTO" VARCHAR2(15) NOT NULL ENABLE, 
	"TELEFONO" VARCHAR2(15), 
	"ZONA_ASIGNADA" VARCHAR2(60), 
	"NOMBRE_USUARIO" VARCHAR2(30) NOT NULL ENABLE, 
	"CONTRASENA_HASH" VARCHAR2(128) NOT NULL ENABLE, 
	"ESTADO" VARCHAR2(10) DEFAULT 'ACTIVO' NOT NULL ENABLE, 
	"FECHA_CREACION" DATE DEFAULT SYSDATE NOT NULL ENABLE, 
	 CONSTRAINT "CK_USUARIO_ESTADO" CHECK (estado IN ('ACTIVO','INACTIVO')) ENABLE, 
	 CONSTRAINT "PK_USUARIO" PRIMARY KEY ("ID_USUARIO") ENABLE, 
	 CONSTRAINT "UK_USUARIO_DOCUMENTO" UNIQUE ("DOCUMENTO") ENABLE, 
	 CONSTRAINT "UK_USUARIO_NOMBRE" UNIQUE ("NOMBRE_USUARIO") ENABLE, 
	 CONSTRAINT "FK_USUARIO_ROL" FOREIGN KEY ("ID_ROL")
	  REFERENCES "ADMIN_ENPH"."ROL" ("ID_ROL") ENABLE, 
	 CONSTRAINT "FK_USUARIO_SUPERVISOR" FOREIGN KEY ("ID_SUPERVISOR")
	  REFERENCES "ADMIN_ENPH"."USUARIO" ("ID_USUARIO") ENABLE
   )
REM INSERTING into ADMIN_ENPH.ASIGNACION_HOGAR
SET DEFINE OFF;
Insert into ADMIN_ENPH.ASIGNACION_HOGAR (ID_ASIGNACION,ID_HOGAR,ID_USUARIO,FECHA_ASIGNACION,ESTADO) values ('1','1','3',to_date('30/08/26','DD/MM/RR'),'ACTIVA');
Insert into ADMIN_ENPH.ASIGNACION_HOGAR (ID_ASIGNACION,ID_HOGAR,ID_USUARIO,FECHA_ASIGNACION,ESTADO) values ('2','2','3',to_date('30/08/26','DD/MM/RR'),'ACTIVA');
Insert into ADMIN_ENPH.ASIGNACION_HOGAR (ID_ASIGNACION,ID_HOGAR,ID_USUARIO,FECHA_ASIGNACION,ESTADO) values ('3','3','4',to_date('31/08/26','DD/MM/RR'),'ACTIVA');
REM INSERTING into ADMIN_ENPH.CATEGORIA_PRODUCTO
SET DEFINE OFF;
Insert into ADMIN_ENPH.CATEGORIA_PRODUCTO (ID_CATEGORIA,NOMBRE_CATEGORIA) values ('1','Alimentos preparados');
Insert into ADMIN_ENPH.CATEGORIA_PRODUCTO (ID_CATEGORIA,NOMBRE_CATEGORIA) values ('2','Alimentos sin preparar');
Insert into ADMIN_ENPH.CATEGORIA_PRODUCTO (ID_CATEGORIA,NOMBRE_CATEGORIA) values ('3','Bebidas');
Insert into ADMIN_ENPH.CATEGORIA_PRODUCTO (ID_CATEGORIA,NOMBRE_CATEGORIA) values ('4','ArtÃ­culos de alta frecuencia');
REM INSERTING into ADMIN_ENPH.FORMA_ADQUISICION
SET DEFINE OFF;
Insert into ADMIN_ENPH.FORMA_ADQUISICION (ID_FORMA,NOMBRE_FORMA,ES_COMPRA) values ('1','Compra','S');
Insert into ADMIN_ENPH.FORMA_ADQUISICION (ID_FORMA,NOMBRE_FORMA,ES_COMPRA) values ('2','Pago en especie','N');
Insert into ADMIN_ENPH.FORMA_ADQUISICION (ID_FORMA,NOMBRE_FORMA,ES_COMPRA) values ('3','Regalo','N');
Insert into ADMIN_ENPH.FORMA_ADQUISICION (ID_FORMA,NOMBRE_FORMA,ES_COMPRA) values ('4','Trueque','N');
Insert into ADMIN_ENPH.FORMA_ADQUISICION (ID_FORMA,NOMBRE_FORMA,ES_COMPRA) values ('5','ProducciÃ³n propia','N');
REM INSERTING into ADMIN_ENPH.HOGAR
SET DEFINE OFF;
Insert into ADMIN_ENPH.HOGAR (ID_HOGAR,DIR_BARRIO,DIR_NUMERO,MUNICIPIO,CIUDAD,ESTRATO,NOMBRE_JEFE,DOCUMENTO_JEFE,TELEFONO_CONTACTO,FECHA_INICIO,FECHA_FIN,ESTADO) values ('1','Cabecera','Cra 27 # 45-12','Bucaramanga','Bucaramanga','3','Laura Pineda','2000000001','3100000001',to_date('01/09/26','DD/MM/RR'),null,'ACTIVO');
Insert into ADMIN_ENPH.HOGAR (ID_HOGAR,DIR_BARRIO,DIR_NUMERO,MUNICIPIO,CIUDAD,ESTRATO,NOMBRE_JEFE,DOCUMENTO_JEFE,TELEFONO_CONTACTO,FECHA_INICIO,FECHA_FIN,ESTADO) values ('2','Girardot','Cll 30 # 20-05','Bucaramanga','Bucaramanga','2','Jorge Salcedo','2000000002',null,to_date('03/09/26','DD/MM/RR'),null,'ACTIVO');
Insert into ADMIN_ENPH.HOGAR (ID_HOGAR,DIR_BARRIO,DIR_NUMERO,MUNICIPIO,CIUDAD,ESTRATO,NOMBRE_JEFE,DOCUMENTO_JEFE,TELEFONO_CONTACTO,FECHA_INICIO,FECHA_FIN,ESTADO) values ('3','Provenza','Cra 33 # 52-40','Bucaramanga','Bucaramanga','4','Rosa Delgado','2000000003','3100000003',null,null,'PENDIENTE');
REM INSERTING into ADMIN_ENPH.LUGAR_COMPRA
SET DEFINE OFF;
Insert into ADMIN_ENPH.LUGAR_COMPRA (ID_LUGAR,NOMBRE_LUGAR,TIPO_ESTABLECIMIENTO) values ('1','Tienda de don JosÃ©','Tienda de barrio');
Insert into ADMIN_ENPH.LUGAR_COMPRA (ID_LUGAR,NOMBRE_LUGAR,TIPO_ESTABLECIMIENTO) values ('2','Supermercado Central','Supermercado');
Insert into ADMIN_ENPH.LUGAR_COMPRA (ID_LUGAR,NOMBRE_LUGAR,TIPO_ESTABLECIMIENTO) values ('3','Plaza de mercado','Plaza');
REM INSERTING into ADMIN_ENPH.PRODUCTO
SET DEFINE OFF;
Insert into ADMIN_ENPH.PRODUCTO (ID_PRODUCTO,ID_CATEGORIA,NOMBRE_PRODUCTO,UNIDAD_MEDIDA) values ('2','2','Huevos','Unidad');
Insert into ADMIN_ENPH.PRODUCTO (ID_PRODUCTO,ID_CATEGORIA,NOMBRE_PRODUCTO,UNIDAD_MEDIDA) values ('3','2','Pan','Unidad');
Insert into ADMIN_ENPH.PRODUCTO (ID_PRODUCTO,ID_CATEGORIA,NOMBRE_PRODUCTO,UNIDAD_MEDIDA) values ('4','1','Almuerzo corriente','Unidad');
Insert into ADMIN_ENPH.PRODUCTO (ID_PRODUCTO,ID_CATEGORIA,NOMBRE_PRODUCTO,UNIDAD_MEDIDA) values ('5','3','Gaseosa','Litro');
Insert into ADMIN_ENPH.PRODUCTO (ID_PRODUCTO,ID_CATEGORIA,NOMBRE_PRODUCTO,UNIDAD_MEDIDA) values ('6','4','JabÃ³n de barra','Unidad');
REM INSERTING into ADMIN_ENPH.REGISTRO_GASTO
SET DEFINE OFF;
Insert into ADMIN_ENPH.REGISTRO_GASTO (ID_REGISTRO,ID_VISITA,ID_PRODUCTO,ID_FORMA,ID_LUGAR,CANTIDAD,VALOR_PAGADO,VALOR_ESTIMADO,FECHA_REGISTRO,FECHA_CAPTURA) values ('2','1','5','1','2','1,5','6200',null,to_date('01/09/26','DD/MM/RR'),to_date('10/10/26','DD/MM/RR'));
Insert into ADMIN_ENPH.REGISTRO_GASTO (ID_REGISTRO,ID_VISITA,ID_PRODUCTO,ID_FORMA,ID_LUGAR,CANTIDAD,VALOR_PAGADO,VALOR_ESTIMADO,FECHA_REGISTRO,FECHA_CAPTURA) values ('3','2','2','3',null,'12','0','9000',to_date('02/09/26','DD/MM/RR'),to_date('10/10/26','DD/MM/RR'));
Insert into ADMIN_ENPH.REGISTRO_GASTO (ID_REGISTRO,ID_VISITA,ID_PRODUCTO,ID_FORMA,ID_LUGAR,CANTIDAD,VALOR_PAGADO,VALOR_ESTIMADO,FECHA_REGISTRO,FECHA_CAPTURA) values ('4','3','4','1','3','3','27000',null,to_date('03/09/26','DD/MM/RR'),to_date('10/10/26','DD/MM/RR'));
REM INSERTING into ADMIN_ENPH.REVISION_CASO
SET DEFINE OFF;
REM INSERTING into ADMIN_ENPH.ROL
SET DEFINE OFF;
Insert into ADMIN_ENPH.ROL (ID_ROL,NOMBRE_ROL) values ('1','ADMINISTRADOR');
Insert into ADMIN_ENPH.ROL (ID_ROL,NOMBRE_ROL) values ('2','SUPERVISOR');
Insert into ADMIN_ENPH.ROL (ID_ROL,NOMBRE_ROL) values ('3','ENCUESTADOR');
REM INSERTING into ADMIN_ENPH.USUARIO
SET DEFINE OFF;
Insert into ADMIN_ENPH.USUARIO (ID_USUARIO,ID_ROL,ID_SUPERVISOR,NOMBRE_COMPLETO,DOCUMENTO,TELEFONO,ZONA_ASIGNADA,NOMBRE_USUARIO,CONTRASENA_HASH,ESTADO,FECHA_CREACION) values ('1','1',null,'Admin Demo','1000000001','3000000001',null,'admin','8d90ed647b948fa80c3c9bbf5316c78f151723f52fb9d6101f818af8afff69ec','ACTIVO',to_date('10/10/26','DD/MM/RR'));
Insert into ADMIN_ENPH.USUARIO (ID_USUARIO,ID_ROL,ID_SUPERVISOR,NOMBRE_COMPLETO,DOCUMENTO,TELEFONO,ZONA_ASIGNADA,NOMBRE_USUARIO,CONTRASENA_HASH,ESTADO,FECHA_CREACION) values ('2','2',null,'Sandra Supervisora','1000000002','3000000002',null,'supervisor1','083991f79e01f800a92409e92d4725a3a5d4395043013a8601402a326bebcd69','ACTIVO',to_date('10/10/26','DD/MM/RR'));
Insert into ADMIN_ENPH.USUARIO (ID_USUARIO,ID_ROL,ID_SUPERVISOR,NOMBRE_COMPLETO,DOCUMENTO,TELEFONO,ZONA_ASIGNADA,NOMBRE_USUARIO,CONTRASENA_HASH,ESTADO,FECHA_CREACION) values ('3','3','2','Carlos Ruiz','1000000003','3000000003','Zona norte','encuestador1','79dd79a946d9bb1ed662cc4077f3c049f630467e7f23282da7d5a6aa2f9adf45','ACTIVO',to_date('10/10/26','DD/MM/RR'));
Insert into ADMIN_ENPH.USUARIO (ID_USUARIO,ID_ROL,ID_SUPERVISOR,NOMBRE_COMPLETO,DOCUMENTO,TELEFONO,ZONA_ASIGNADA,NOMBRE_USUARIO,CONTRASENA_HASH,ESTADO,FECHA_CREACION) values ('4','3','2','Marta GÃ³mez','1000000004','3000000004','Zona sur','encuestador2','a6b889fe707a65d002533dcd316145b0dcfb2d29ec0778922254300c49cffbde','ACTIVO',to_date('10/10/26','DD/MM/RR'));
REM INSERTING into ADMIN_ENPH.VISITA
SET DEFINE OFF;
Insert into ADMIN_ENPH.VISITA (ID_VISITA,ID_HOGAR,ID_USUARIO,FECHA_VISITA,DIA_OPERATIVO,OBSERVACIONES) values ('1','1','3',to_date('01/09/26','DD/MM/RR'),'1','Sin novedad');
Insert into ADMIN_ENPH.VISITA (ID_VISITA,ID_HOGAR,ID_USUARIO,FECHA_VISITA,DIA_OPERATIVO,OBSERVACIONES) values ('2','1','3',to_date('02/09/26','DD/MM/RR'),'2',null);
Insert into ADMIN_ENPH.VISITA (ID_VISITA,ID_HOGAR,ID_USUARIO,FECHA_VISITA,DIA_OPERATIVO,OBSERVACIONES) values ('3','2','3',to_date('03/09/26','DD/MM/RR'),'1','El hogar solicita visita en la tarde');
--------------------------------------------------------
--  DDL for Index IX_ASIGNACION_USER
--------------------------------------------------------

  CREATE INDEX "ADMIN_ENPH"."IX_ASIGNACION_USER" ON "ADMIN_ENPH"."ASIGNACION_HOGAR" ("ID_USUARIO")
--------------------------------------------------------
--  DDL for Index IX_VISITA_HOGAR
--------------------------------------------------------

  CREATE INDEX "ADMIN_ENPH"."IX_VISITA_HOGAR" ON "ADMIN_ENPH"."VISITA" ("ID_HOGAR")
--------------------------------------------------------
--  DDL for Index PK_CATEGORIA
--------------------------------------------------------

  CREATE UNIQUE INDEX "ADMIN_ENPH"."PK_CATEGORIA" ON "ADMIN_ENPH"."CATEGORIA_PRODUCTO" ("ID_CATEGORIA")
--------------------------------------------------------
--  DDL for Index PK_HOGAR
--------------------------------------------------------

  CREATE UNIQUE INDEX "ADMIN_ENPH"."PK_HOGAR" ON "ADMIN_ENPH"."HOGAR" ("ID_HOGAR")
--------------------------------------------------------
--  DDL for Index PK_PRODUCTO
--------------------------------------------------------

  CREATE UNIQUE INDEX "ADMIN_ENPH"."PK_PRODUCTO" ON "ADMIN_ENPH"."PRODUCTO" ("ID_PRODUCTO")
--------------------------------------------------------
--  DDL for Index PK_REVISION
--------------------------------------------------------

  CREATE UNIQUE INDEX "ADMIN_ENPH"."PK_REVISION" ON "ADMIN_ENPH"."REVISION_CASO" ("ID_REVISION")
--------------------------------------------------------
--  DDL for Index PK_USUARIO
--------------------------------------------------------

  CREATE UNIQUE INDEX "ADMIN_ENPH"."PK_USUARIO" ON "ADMIN_ENPH"."USUARIO" ("ID_USUARIO")
--------------------------------------------------------
--  DDL for Index UK_CATEGORIA_NOMBRE
--------------------------------------------------------

  CREATE UNIQUE INDEX "ADMIN_ENPH"."UK_CATEGORIA_NOMBRE" ON "ADMIN_ENPH"."CATEGORIA_PRODUCTO" ("NOMBRE_CATEGORIA")
--------------------------------------------------------
--  DDL for Index UK_ROL_NOMBRE
--------------------------------------------------------

  CREATE UNIQUE INDEX "ADMIN_ENPH"."UK_ROL_NOMBRE" ON "ADMIN_ENPH"."ROL" ("NOMBRE_ROL")
--------------------------------------------------------
--  DDL for Index UK_USUARIO_NOMBRE
--------------------------------------------------------

  CREATE UNIQUE INDEX "ADMIN_ENPH"."UK_USUARIO_NOMBRE" ON "ADMIN_ENPH"."USUARIO" ("NOMBRE_USUARIO")
--------------------------------------------------------
--  DDL for Index UX_ASIGNACION_ACTIVA
--------------------------------------------------------

  CREATE UNIQUE INDEX "ADMIN_ENPH"."UX_ASIGNACION_ACTIVA" ON "ADMIN_ENPH"."ASIGNACION_HOGAR" (CASE "ESTADO" WHEN 'ACTIVA' THEN "ID_HOGAR" END )
--------------------------------------------------------
--  DDL for Index PK_ASIGNACION
--------------------------------------------------------

  CREATE UNIQUE INDEX "ADMIN_ENPH"."PK_ASIGNACION" ON "ADMIN_ENPH"."ASIGNACION_HOGAR" ("ID_ASIGNACION")
--------------------------------------------------------
--  DDL for Index PK_CATEGORIA
--------------------------------------------------------

  CREATE UNIQUE INDEX "ADMIN_ENPH"."PK_CATEGORIA" ON "ADMIN_ENPH"."CATEGORIA_PRODUCTO" ("ID_CATEGORIA")
--------------------------------------------------------
--  DDL for Index PK_FORMA
--------------------------------------------------------

  CREATE UNIQUE INDEX "ADMIN_ENPH"."PK_FORMA" ON "ADMIN_ENPH"."FORMA_ADQUISICION" ("ID_FORMA")
--------------------------------------------------------
--  DDL for Index PK_HOGAR
--------------------------------------------------------

  CREATE UNIQUE INDEX "ADMIN_ENPH"."PK_HOGAR" ON "ADMIN_ENPH"."HOGAR" ("ID_HOGAR")
--------------------------------------------------------
--  DDL for Index PK_PRODUCTO
--------------------------------------------------------

  CREATE UNIQUE INDEX "ADMIN_ENPH"."PK_PRODUCTO" ON "ADMIN_ENPH"."PRODUCTO" ("ID_PRODUCTO")
--------------------------------------------------------
--  DDL for Index IX_REGISTRO_VISITA
--------------------------------------------------------

  CREATE INDEX "ADMIN_ENPH"."IX_REGISTRO_VISITA" ON "ADMIN_ENPH"."REGISTRO_GASTO" ("ID_VISITA")
--------------------------------------------------------
--  DDL for Index PK_ROL
--------------------------------------------------------

  CREATE UNIQUE INDEX "ADMIN_ENPH"."PK_ROL" ON "ADMIN_ENPH"."ROL" ("ID_ROL")
--------------------------------------------------------
--  DDL for Index PK_USUARIO
--------------------------------------------------------

  CREATE UNIQUE INDEX "ADMIN_ENPH"."PK_USUARIO" ON "ADMIN_ENPH"."USUARIO" ("ID_USUARIO")
--------------------------------------------------------
--  DDL for Index UK_USUARIO_NOMBRE
--------------------------------------------------------

  CREATE UNIQUE INDEX "ADMIN_ENPH"."UK_USUARIO_NOMBRE" ON "ADMIN_ENPH"."USUARIO" ("NOMBRE_USUARIO")
--------------------------------------------------------
--  DDL for Index UK_VISITA_HOGAR_DIA
--------------------------------------------------------

  CREATE UNIQUE INDEX "ADMIN_ENPH"."UK_VISITA_HOGAR_DIA" ON "ADMIN_ENPH"."VISITA" ("ID_HOGAR", "DIA_OPERATIVO")
--------------------------------------------------------
--  DDL for Trigger TRG_REGISTRO_GASTO_REGLAS
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "ADMIN_ENPH"."TRG_REGISTRO_GASTO_REGLAS" 
BEFORE INSERT OR UPDATE ON registro_gasto
FOR EACH ROW
DECLARE
  v_es_compra    forma_adquisicion.es_compra%TYPE;
  v_fecha_visita visita.fecha_visita%TYPE;
  v_inicio       hogar.fecha_inicio%TYPE;
BEGIN
  SELECT es_compra INTO v_es_compra
    FROM forma_adquisicion WHERE id_forma = :NEW.id_forma;

  IF v_es_compra = 'S' THEN
    IF :NEW.id_lugar IS NULL THEN
      RAISE_APPLICATION_ERROR(-20001, 'RV-07: una compra requiere lugar de compra.');
    END IF;
    IF :NEW.valor_pagado <= 0 THEN
      RAISE_APPLICATION_ERROR(-20002, 'RV-07: una compra requiere valor pagado mayor que cero.');
    END IF;
  ELSE
    IF :NEW.id_lugar IS NOT NULL THEN
      RAISE_APPLICATION_ERROR(-20003, 'RV-08: si no es compra, no se registra lugar de compra.');
    END IF;
    IF :NEW.valor_estimado IS NULL THEN
      RAISE_APPLICATION_ERROR(-20004, 'RV-08: si no es compra, el valor estimado es obligatorio.');
    END IF;
  END IF;

  SELECT v.fecha_visita, h.fecha_inicio INTO v_fecha_visita, v_inicio
    FROM visita v JOIN hogar h ON h.id_hogar = v.id_hogar
   WHERE v.id_visita = :NEW.id_visita;

  IF TRUNC(:NEW.fecha_registro) > TRUNC(v_fecha_visita)
     OR TRUNC(:NEW.fecha_registro) < TRUNC(v_inicio) THEN
    RAISE_APPLICATION_ERROR(-20005, 'RV-09: la fecha del gasto debe estar entre el inicio del perÃ­odo y la fecha de la visita.');
  END IF;
END;
ALTER TRIGGER "ADMIN_ENPH"."TRG_REGISTRO_GASTO_REGLAS" ENABLE
--------------------------------------------------------
--  DDL for Trigger TRG_REGISTRO_GASTO_REGLAS
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "ADMIN_ENPH"."TRG_REGISTRO_GASTO_REGLAS" 
BEFORE INSERT OR UPDATE ON registro_gasto
FOR EACH ROW
DECLARE
  v_es_compra    forma_adquisicion.es_compra%TYPE;
  v_fecha_visita visita.fecha_visita%TYPE;
  v_inicio       hogar.fecha_inicio%TYPE;
BEGIN
  SELECT es_compra INTO v_es_compra
    FROM forma_adquisicion WHERE id_forma = :NEW.id_forma;

  IF v_es_compra = 'S' THEN
    IF :NEW.id_lugar IS NULL THEN
      RAISE_APPLICATION_ERROR(-20001, 'RV-07: una compra requiere lugar de compra.');
    END IF;
    IF :NEW.valor_pagado <= 0 THEN
      RAISE_APPLICATION_ERROR(-20002, 'RV-07: una compra requiere valor pagado mayor que cero.');
    END IF;
  ELSE
    IF :NEW.id_lugar IS NOT NULL THEN
      RAISE_APPLICATION_ERROR(-20003, 'RV-08: si no es compra, no se registra lugar de compra.');
    END IF;
    IF :NEW.valor_estimado IS NULL THEN
      RAISE_APPLICATION_ERROR(-20004, 'RV-08: si no es compra, el valor estimado es obligatorio.');
    END IF;
  END IF;

  SELECT v.fecha_visita, h.fecha_inicio INTO v_fecha_visita, v_inicio
    FROM visita v JOIN hogar h ON h.id_hogar = v.id_hogar
   WHERE v.id_visita = :NEW.id_visita;

  IF TRUNC(:NEW.fecha_registro) > TRUNC(v_fecha_visita)
     OR TRUNC(:NEW.fecha_registro) < TRUNC(v_inicio) THEN
    RAISE_APPLICATION_ERROR(-20005, 'RV-09: la fecha del gasto debe estar entre el inicio del perÃ­odo y la fecha de la visita.');
  END IF;
END;
ALTER TRIGGER "ADMIN_ENPH"."TRG_REGISTRO_GASTO_REGLAS" ENABLE
--------------------------------------------------------
--  Constraints for Table ASIGNACION_HOGAR
--------------------------------------------------------

  ALTER TABLE "ADMIN_ENPH"."ASIGNACION_HOGAR" ADD CONSTRAINT "CK_ASIG_ESTADO" CHECK (estado IN ('ACTIVA','FINALIZADA')) ENABLE
 
  ALTER TABLE "ADMIN_ENPH"."ASIGNACION_HOGAR" ADD CONSTRAINT "PK_ASIGNACION" PRIMARY KEY ("ID_ASIGNACION") ENABLE
 
  ALTER TABLE "ADMIN_ENPH"."ASIGNACION_HOGAR" MODIFY ("ID_ASIGNACION" NOT NULL ENABLE)
 
  ALTER TABLE "ADMIN_ENPH"."ASIGNACION_HOGAR" MODIFY ("ID_HOGAR" NOT NULL ENABLE)
 
  ALTER TABLE "ADMIN_ENPH"."ASIGNACION_HOGAR" MODIFY ("ID_USUARIO" NOT NULL ENABLE)
 
  ALTER TABLE "ADMIN_ENPH"."ASIGNACION_HOGAR" MODIFY ("FECHA_ASIGNACION" NOT NULL ENABLE)
 
  ALTER TABLE "ADMIN_ENPH"."ASIGNACION_HOGAR" MODIFY ("ESTADO" NOT NULL ENABLE)
--------------------------------------------------------
--  Constraints for Table FORMA_ADQUISICION
--------------------------------------------------------

  ALTER TABLE "ADMIN_ENPH"."FORMA_ADQUISICION" ADD CONSTRAINT "CK_FORMA_COMPRA" CHECK (es_compra IN ('S','N')) ENABLE
 
  ALTER TABLE "ADMIN_ENPH"."FORMA_ADQUISICION" ADD CONSTRAINT "PK_FORMA" PRIMARY KEY ("ID_FORMA") ENABLE
 
  ALTER TABLE "ADMIN_ENPH"."FORMA_ADQUISICION" MODIFY ("ID_FORMA" NOT NULL ENABLE)
 
  ALTER TABLE "ADMIN_ENPH"."FORMA_ADQUISICION" MODIFY ("NOMBRE_FORMA" NOT NULL ENABLE)
 
  ALTER TABLE "ADMIN_ENPH"."FORMA_ADQUISICION" MODIFY ("ES_COMPRA" NOT NULL ENABLE)
 
  ALTER TABLE "ADMIN_ENPH"."FORMA_ADQUISICION" ADD CONSTRAINT "UK_FORMA_NOMBRE" UNIQUE ("NOMBRE_FORMA") ENABLE
--------------------------------------------------------
--  Constraints for Table LUGAR_COMPRA
--------------------------------------------------------

  ALTER TABLE "ADMIN_ENPH"."LUGAR_COMPRA" ADD CONSTRAINT "PK_LUGAR" PRIMARY KEY ("ID_LUGAR") ENABLE
 
  ALTER TABLE "ADMIN_ENPH"."LUGAR_COMPRA" MODIFY ("ID_LUGAR" NOT NULL ENABLE)
 
  ALTER TABLE "ADMIN_ENPH"."LUGAR_COMPRA" MODIFY ("NOMBRE_LUGAR" NOT NULL ENABLE)
--------------------------------------------------------
--  Constraints for Table REGISTRO_GASTO
--------------------------------------------------------

  ALTER TABLE "ADMIN_ENPH"."REGISTRO_GASTO" ADD CONSTRAINT "CK_REG_CANTIDAD" CHECK (cantidad > 0) ENABLE
 
  ALTER TABLE "ADMIN_ENPH"."REGISTRO_GASTO" ADD CONSTRAINT "CK_REG_VALOR_ESTIMADO" CHECK (valor_estimado IS NULL OR valor_estimado >= 0) ENABLE
 
  ALTER TABLE "ADMIN_ENPH"."REGISTRO_GASTO" ADD CONSTRAINT "CK_REG_VALOR_PAGADO" CHECK (valor_pagado >= 0) ENABLE
 
  ALTER TABLE "ADMIN_ENPH"."REGISTRO_GASTO" ADD CONSTRAINT "PK_REGISTRO" PRIMARY KEY ("ID_REGISTRO") ENABLE
 
  ALTER TABLE "ADMIN_ENPH"."REGISTRO_GASTO" MODIFY ("ID_REGISTRO" NOT NULL ENABLE)
 
  ALTER TABLE "ADMIN_ENPH"."REGISTRO_GASTO" MODIFY ("ID_VISITA" NOT NULL ENABLE)
 
  ALTER TABLE "ADMIN_ENPH"."REGISTRO_GASTO" MODIFY ("ID_PRODUCTO" NOT NULL ENABLE)
 
  ALTER TABLE "ADMIN_ENPH"."REGISTRO_GASTO" MODIFY ("ID_FORMA" NOT NULL ENABLE)
 
  ALTER TABLE "ADMIN_ENPH"."REGISTRO_GASTO" MODIFY ("CANTIDAD" NOT NULL ENABLE)
 
  ALTER TABLE "ADMIN_ENPH"."REGISTRO_GASTO" MODIFY ("VALOR_PAGADO" NOT NULL ENABLE)
 
  ALTER TABLE "ADMIN_ENPH"."REGISTRO_GASTO" MODIFY ("FECHA_REGISTRO" NOT NULL ENABLE)
 
  ALTER TABLE "ADMIN_ENPH"."REGISTRO_GASTO" MODIFY ("FECHA_CAPTURA" NOT NULL ENABLE)
--------------------------------------------------------
--  Constraints for Table ROL
--------------------------------------------------------

  ALTER TABLE "ADMIN_ENPH"."ROL" ADD CONSTRAINT "PK_ROL" PRIMARY KEY ("ID_ROL") ENABLE
 
  ALTER TABLE "ADMIN_ENPH"."ROL" MODIFY ("ID_ROL" NOT NULL ENABLE)
 
  ALTER TABLE "ADMIN_ENPH"."ROL" MODIFY ("NOMBRE_ROL" NOT NULL ENABLE)
 
  ALTER TABLE "ADMIN_ENPH"."ROL" ADD CONSTRAINT "UK_ROL_NOMBRE" UNIQUE ("NOMBRE_ROL") ENABLE
--------------------------------------------------------
--  Constraints for Table VISITA
--------------------------------------------------------

  ALTER TABLE "ADMIN_ENPH"."VISITA" ADD CONSTRAINT "CK_VISITA_DIA" CHECK (dia_operativo BETWEEN 1 AND 14) ENABLE
 
  ALTER TABLE "ADMIN_ENPH"."VISITA" ADD CONSTRAINT "PK_VISITA" PRIMARY KEY ("ID_VISITA") ENABLE
 
  ALTER TABLE "ADMIN_ENPH"."VISITA" MODIFY ("ID_VISITA" NOT NULL ENABLE)
 
  ALTER TABLE "ADMIN_ENPH"."VISITA" MODIFY ("ID_HOGAR" NOT NULL ENABLE)
 
  ALTER TABLE "ADMIN_ENPH"."VISITA" MODIFY ("ID_USUARIO" NOT NULL ENABLE)
 
  ALTER TABLE "ADMIN_ENPH"."VISITA" MODIFY ("FECHA_VISITA" NOT NULL ENABLE)
 
  ALTER TABLE "ADMIN_ENPH"."VISITA" MODIFY ("DIA_OPERATIVO" NOT NULL ENABLE)
 
  ALTER TABLE "ADMIN_ENPH"."VISITA" ADD CONSTRAINT "UK_VISITA_HOGAR_DIA" UNIQUE ("ID_HOGAR", "DIA_OPERATIVO") ENABLE
--------------------------------------------------------
--  Ref Constraints for Table PRODUCTO
--------------------------------------------------------

  ALTER TABLE "ADMIN_ENPH"."PRODUCTO" ADD CONSTRAINT "FK_PRODUCTO_CATEGORIA" FOREIGN KEY ("ID_CATEGORIA")
	  REFERENCES "ADMIN_ENPH"."CATEGORIA_PRODUCTO" ("ID_CATEGORIA") ENABLE
--------------------------------------------------------
--  Ref Constraints for Table REVISION_CASO
--------------------------------------------------------

  ALTER TABLE "ADMIN_ENPH"."REVISION_CASO" ADD CONSTRAINT "FK_REV_HOGAR" FOREIGN KEY ("ID_HOGAR")
	  REFERENCES "ADMIN_ENPH"."HOGAR" ("ID_HOGAR") ENABLE
 
  ALTER TABLE "ADMIN_ENPH"."REVISION_CASO" ADD CONSTRAINT "FK_REV_SUPERVISOR" FOREIGN KEY ("ID_SUPERVISOR")
	  REFERENCES "ADMIN_ENPH"."USUARIO" ("ID_USUARIO") ENABLE
--------------------------------------------------------
--  Ref Constraints for Table VISITA
--------------------------------------------------------

  ALTER TABLE "ADMIN_ENPH"."VISITA" ADD CONSTRAINT "FK_VISITA_HOGAR" FOREIGN KEY ("ID_HOGAR")
	  REFERENCES "ADMIN_ENPH"."HOGAR" ("ID_HOGAR") ENABLE
 
  ALTER TABLE "ADMIN_ENPH"."VISITA" ADD CONSTRAINT "FK_VISITA_USUARIO" FOREIGN KEY ("ID_USUARIO")
	  REFERENCES "ADMIN_ENPH"."USUARIO" ("ID_USUARIO") ENABLE
