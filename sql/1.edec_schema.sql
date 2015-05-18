  -- tables
-- Table: caracteristica
DROP TABLE caracteristica cascade constraints;
CREATE TABLE caracteristica (
    id integer  NOT NULL,
    name varchar2(300)  NOT NULL,
    categorie_caracteristici_id integer  NOT NULL,
    CONSTRAINT caracteristica_pk PRIMARY KEY (id)
) ;




-- Table: caracteristici_produse
DROP TABLE caracteristici_produse cascade constraints;
CREATE TABLE caracteristici_produse (
    id integer  NOT NULL,
    produs_id integer  NOT NULL,
    caracteristica_id integer  NOT NULL,
    misc varchar2(100)  NULL,
    CONSTRAINT caracteristici_produse_pk PRIMARY KEY (id)
) ;

DROP INDEX caracteristici_produse_idx_1;
CREATE UNIQUE INDEX caracteristici_produse_idx_1 
on caracteristici_produse 
(produs_id ASC,caracteristica_id ASC)
;




-- Table: categorie_caracteristici
DROP TABLE categorie_caracteristici cascade constraints;
CREATE TABLE categorie_caracteristici (
    id integer  NOT NULL,
    nume varchar2(100)  NOT NULL,
    CONSTRAINT categorie_caracteristici_pk PRIMARY KEY (id)
) ;




-- Table: media
DROP TABLE media cascade constraints;
CREATE TABLE media (
    id integer  NOT NULL,
    url varchar2(200)  NOT NULL,
    file_json varchar2(1000)  NOT NULL,
    CONSTRAINT media_pk PRIMARY KEY (id)
) ;




-- Table: produs
DROP TABLE produs cascade constraints;
CREATE TABLE produs (
    id integer  NOT NULL,
    name varchar2(300)  NOT NULL,
    image integer  NOT NULL,
    CONSTRAINT produs_pk PRIMARY KEY (id)
) ;




-- Table: user_hates
DROP TABLE user_hates cascade constraints;
CREATE TABLE user_hates (
    id integer  NOT NULL,
    user_id integer  NOT NULL,
    caracteristica_id integer  NOT NULL,
    CONSTRAINT user_hates_pk PRIMARY KEY (id)
) ;


DROP INDEX user_hates_idx_1;
CREATE INDEX user_hates_idx_1 
on user_hates 
(user_id ASC,caracteristica_id ASC)
;




-- Table: user_loves
DROP TABLE user_loves cascade constraints;
CREATE TABLE user_loves (
    Id integer  NOT NULL,
    user_id integer  NOT NULL,
    caracteristica_id integer  NOT NULL,
    CONSTRAINT user_loves_pk PRIMARY KEY (Id)
) ;

DROP INDEX user_loves_idx_1;
CREATE INDEX user_loves_idx_1 
on user_loves 
(user_id ASC,caracteristica_id ASC)
;




-- Table: users
DROP TABLE users cascade constraints;
CREATE TABLE users (
    id integer  NOT NULL,
    username varchar2(300)  NOT NULL,
    pass varchar2(500)  NOT NULL,
    email varchar2(200)  NOT NULL,
    avatar integer  NOT NULL,
    tip integer  NOT NULL, 
    data_nasterii date  NOT NULL,
    sex varchar2(1)  NOT NULL,
    CONSTRAINT check_1 CHECK (sex IN ('M','F')),
    CONSTRAINT users_pk PRIMARY KEY (id),
    CONSTRAINT unique_email UNIQUE (email)
) ;




-- foreign keys
-- Reference:  caract_categorie_caract (table: caracteristica)

--ALTER TABLE caracteristica DROP CONSTRAINT caract_categorie_caract; 
ALTER TABLE caracteristica ADD CONSTRAINT caract_categorie_caract 
    FOREIGN KEY (categorie_caracteristici_id)
    REFERENCES categorie_caracteristici (id)
    ;

-- Reference:  caract_produse_caract (table: caracteristici_produse)

--ALTER TABLE caracteristici_produse DROP CONSTRAINT caract_produse_caract; 
ALTER TABLE caracteristici_produse ADD CONSTRAINT caract_produse_caract 
    FOREIGN KEY (caracteristica_id)
    REFERENCES caracteristica (id)
    ;

-- Reference:  caract_produse_produs (table: caracteristici_produse)

--ALTER TABLE caracteristici_produse DROP CONSTRAINT caract_produse_produs; 
ALTER TABLE caracteristici_produse ADD CONSTRAINT caract_produse_produs 
    FOREIGN KEY (produs_id)
    REFERENCES produs (id)
    ;

-- Reference:  produse_media (table: produs)

--ALTER TABLE produs DROP CONSTRAINT produse_media;
ALTER TABLE produs ADD CONSTRAINT produse_media 
    FOREIGN KEY (image)
    REFERENCES media (id)
    ;

-- Reference:  user_hates_caracteristica (table: user_hates)

--ALTER TABLE user_hates DROP CONSTRAINT user_hates_caracteristica;
ALTER TABLE user_hates ADD CONSTRAINT user_hates_caracteristica 
    FOREIGN KEY (caracteristica_id)
    REFERENCES caracteristica (id)
    ;

-- Reference:  user_hates_user (table: user_hates)

--ALTER TABLE user_hates DROP CONSTRAINT user_hates_user;
ALTER TABLE user_hates ADD CONSTRAINT user_hates_user 
    FOREIGN KEY (user_id)
    REFERENCES users (id)
    ;

-- Reference:  user_loves_caracteristica (table: user_loves)

--ALTER TABLE user_loves DROP CONSTRAINT user_loves_caracteristica;
ALTER TABLE user_loves ADD CONSTRAINT user_loves_caracteristica 
    FOREIGN KEY (caracteristica_id)
    REFERENCES caracteristica (id)
    ;

-- Reference:  user_loves_user (table: user_loves)

--ALTER TABLE user_loves DROP CONSTRAINT user_loves_user;
ALTER TABLE user_loves ADD CONSTRAINT user_loves_user 
    FOREIGN KEY (user_id)
    REFERENCES users (id)
    ;

-- Reference:  user_media (table: users)

--ALTER TABLE users DROP CONSTRAINT user_media;
ALTER TABLE users ADD CONSTRAINT user_media 
    FOREIGN KEY (avatar)
    REFERENCES media (id)
    ;



--TRIGGERS--
-- CATEGORIE CARACTERISTI--
DECLARE
 last_index NUMBER;
BEGIN
  SELECT MAX(ID)+ 1 INTO last_index FROM CATEGORIE_CARACTERISTICI;
  IF last_index > 0 THEN
    BEGIN
      EXECUTE IMMEDIATE 'DROP SEQUENCE CATEG_CARACT_SEQ';
      EXCEPTION WHEN OTHERS THEN
        NULL;
    END;
  EXECUTE IMMEDIATE 'CREATE SEQUENCE CATEG_CARACT_SEQ INCREMENT BY 1 START WITH ' || last_index || ' CACHE 50 NOMAXVALUE NOCYCLE';
  END IF;
END;
/

CREATE OR REPLACE TRIGGER AI_CATEG_CARACT
BEFORE INSERT ON CATEGORIE_CARACTERISTICI
FOR EACH ROW

BEGIN 
    IF :new.id IS NULL THEN --in case we have an id when we insert (eg when importing from csv) we do not use the trigger
    Select  CATEG_CARACT_SEQ.NEXTVAL
    INTO    :new.id
    FROM    dual;
    END IF;
END;
/

--USERS--

DECLARE
 last_index NUMBER;
BEGIN
  SELECT MAX(ID)+ 1 INTO last_index FROM USERS;
  IF last_index > 0 THEN
    BEGIN
      EXECUTE IMMEDIATE 'DROP SEQUENCE USERS_SEQ';
      EXCEPTION WHEN OTHERS THEN
        NULL;
    END;
  EXECUTE IMMEDIATE 'CREATE SEQUENCE USERS_SEQ INCREMENT BY 1 START WITH ' || last_index || ' CACHE 50 NOMAXVALUE NOCYCLE';
  END IF;
END;
/

CREATE OR REPLACE TRIGGER AI_USERS
BEFORE INSERT ON USERS
FOR EACH ROW

BEGIN 
    IF :new.id IS NULL THEN --in case we have an id when we insert (eg when importing from csv) we do not use the trigger
    Select  USERS_SEQ.NEXTVAL
    INTO    :new.id
    FROM    dual;
    END IF;
END;
/

--MEDIA--
DECLARE
 last_index NUMBER;
BEGIN
  SELECT MAX(ID)+ 1 INTO last_index FROM MEDIA;
  IF last_index > 0 THEN
    BEGIN
      EXECUTE IMMEDIATE 'DROP SEQUENCE MEDIA_SEQ';
      EXCEPTION WHEN OTHERS THEN
        NULL;
    END;
  EXECUTE IMMEDIATE 'CREATE SEQUENCE MEDIA_SEQ INCREMENT BY 1 START WITH ' || last_index || ' CACHE 50 NOMAXVALUE NOCYCLE';
  END IF;
END;
/

CREATE OR REPLACE TRIGGER AI_MEDIA
BEFORE INSERT ON MEDIA
FOR EACH ROW

BEGIN 
    IF :new.id IS NULL THEN --in case we have an id when we insert (eg when importing from csv) we do not use the trigger
    Select  MEDIA_SEQ.NEXTVAL
    INTO    :new.id
    FROM    dual;
    END IF;
END;
/

--USERS HATES--
DECLARE
 last_index NUMBER;
BEGIN
  SELECT MAX(ID)+ 1 INTO last_index FROM USER_HATES;
  IF last_index > 0 THEN
    BEGIN
      EXECUTE IMMEDIATE 'DROP SEQUENCE USER_HATES_SEQ';
      EXCEPTION WHEN OTHERS THEN
        NULL;
    END;
  EXECUTE IMMEDIATE 'CREATE SEQUENCE USER_HATES_SEQ INCREMENT BY 1 START WITH ' || last_index || ' CACHE 50 NOMAXVALUE NOCYCLE';
  END IF;
END;
/

CREATE OR REPLACE TRIGGER AI_USER_HATES
BEFORE INSERT ON USER_HATES
FOR EACH ROW

BEGIN 
    IF :new.id IS NULL THEN --in case we have an id when we insert (eg when importing from csv) we do not use the trigger
    Select  USER_HATES_SEQ.NEXTVAL
    INTO    :new.id
    FROM    dual;
    END IF;
END;
/
--USER LOVES--
DECLARE
 last_index NUMBER;
BEGIN
  SELECT MAX(ID)+ 1 INTO last_index FROM USER_LOVES;
  IF last_index > 0 THEN
    BEGIN
      EXECUTE IMMEDIATE 'DROP SEQUENCE USER_LOVES_SEQ';
      EXCEPTION WHEN OTHERS THEN
        NULL;
    END;
  EXECUTE IMMEDIATE 'CREATE SEQUENCE USER_LOVES_SEQ INCREMENT BY 1 START WITH ' || last_index || ' CACHE 50 NOMAXVALUE NOCYCLE';
  END IF;
END;
/

CREATE OR REPLACE TRIGGER AI_USER_LOVES
BEFORE INSERT ON USER_LOVES
FOR EACH ROW

BEGIN 
    IF :new.id IS NULL THEN --in case we have an id when we insert (eg when importing from csv) we do not use the trigger
    Select  USER_LOVES_SEQ.NEXTVAL
    INTO    :new.id
    FROM    dual;
    END IF;
END;
/
--PRODUS--
DECLARE
 last_index NUMBER;
BEGIN
  SELECT MAX(ID)+ 1 INTO last_index FROM PRODUS;
  IF last_index > 0 THEN
    BEGIN
      EXECUTE IMMEDIATE 'DROP SEQUENCE PRODUS_SEQ';
      EXCEPTION WHEN OTHERS THEN
        NULL;
    END;
  EXECUTE IMMEDIATE 'CREATE SEQUENCE PRODUS_SEQ INCREMENT BY 1 START WITH ' || last_index || ' CACHE 50 NOMAXVALUE NOCYCLE';
  END IF;
END;
/

CREATE OR REPLACE TRIGGER AI_PRODUS
BEFORE INSERT ON PRODUS
FOR EACH ROW
BEGIN
    IF :new.id IS NULL THEN --in case we have an id when we insert (eg when importing from csv) we do not use the trigger
      Select  PRODUS_SEQ.NEXTVAL
      INTO    :new.id
      FROM    dual;
   END IF;
END;
/
--CARACTERISTICA--
DECLARE
 last_index NUMBER;
BEGIN
  SELECT MAX(ID)+ 1 INTO last_index FROM CARACTERISTICA;
  IF last_index > 0 THEN
    BEGIN
      EXECUTE IMMEDIATE 'DROP SEQUENCE CARACTERISTICA_SEQ';
      EXCEPTION WHEN OTHERS THEN
        NULL;
    END;
  EXECUTE IMMEDIATE 'CREATE SEQUENCE CARACTERISTICA_SEQ INCREMENT BY 1 START WITH ' || last_index || ' CACHE 50 NOMAXVALUE NOCYCLE';
  END IF;
END;
/

CREATE OR REPLACE TRIGGER AI_CARACTERISTICA
BEFORE INSERT ON CARACTERISTICA
FOR EACH ROW

BEGIN 
    IF :new.id IS NULL THEN --in case we have an id when we insert (eg when importing from csv) we do not use the trigger
    Select  CARACTERISTICA_SEQ.NEXTVAL
    INTO    :new.id
    FROM    dual;
    END IF;
END;
/
--CARACTERISTICI PRODUSE--
DECLARE
 last_index NUMBER;
BEGIN
  SELECT MAX(ID)+ 1 INTO last_index FROM CARACTERISTICI_PRODUSE;
  IF last_index > 0 THEN
    BEGIN
      EXECUTE IMMEDIATE 'DROP SEQUENCE CARACT_PROD_SEQ';
      EXCEPTION WHEN OTHERS THEN
        NULL;
    END;
  EXECUTE IMMEDIATE 'CREATE SEQUENCE CARACT_PROD_SEQ INCREMENT BY 1 START WITH ' || last_index || ' CACHE 50 NOMAXVALUE NOCYCLE';
  END IF;
END;
/

CREATE OR REPLACE TRIGGER AI_CARACT_PROD
BEFORE INSERT ON CARACTERISTICI_PRODUSE
FOR EACH ROW

BEGIN 
    IF :new.id IS NULL THEN --in case we have an id when we insert (eg when importing from csv) we do not use the trigger
    Select  CARACT_PROD_SEQ.NEXTVAL 
    INTO    :new.id
    FROM    dual;
    END IF;
END;
/

