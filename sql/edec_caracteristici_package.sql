SET SERVEROUTPUT ON;

--seteaza directorul ?
CREATE OR REPLACE DIRECTORY USER_DIR AS 'C:\wamp\EDeC\sql\csv'; 
GRANT READ ON DIRECTORY USER_DIR TO PUBLIC;

--pachet tabele caracteristici
CREATE OR REPLACE PACKAGE edec_caracteristici_package IS

PROCEDURE populateCaracteristici ;

PROCEDURE insertCacacteristica(c_name caracteristica.name%TYPE,c_cat caracteristica.categorie_caracteristici_id%TYPE);

END edec_caracteristici_package;
/

CREATE OR REPLACE PACKAGE BODY edec_caracteristici_package IS

--forward declaration
--populeaza tabela categorie_caracteristici 
PROCEDURE populateCategories;
--insereaza un rand in tabela categorie_caracteristici
PROCEDURE insertCategory(category_name IN categorie_caracteristici.nume%TYPE);

--populeaza tabela caracteristica cu caracteristici legate de organizatii
PROCEDURE populateOrganisations;
--insereaza un rand cu date despre o organizatie in tabela caracteristica
PROCEDURE insertOrganisation(organisation_name IN caracteristica.name%TYPE);

--populeaza tabela caracteristica cu caracteristici legate de substante alimentare
PROCEDURE populateSubst_alim;
--insereaza un rand cu date despre o substanta alimentara in tabela caracteristica
PROCEDURE insertSubst_alim(alim_name IN caracteristica.name%TYPE);

--populeaza tabela caracteristica cu caracteristici legate de substante nealimentare
PROCEDURE populateSubst_nealim;
--insereaza un rand cu date despre o sustanta nealimentara in tabela caracteristica
PROCEDURE insertSubst_nealim(nealim_name IN caracteristica.name%TYPE);

--populeaza tabela caracteristica cu caracteristici legate de orase
PROCEDURE populateCities;
--insereaza un rand cu date despre un oras in tabela caracteristica
PROCEDURE insertCity(city_name IN caracteristica.name%TYPE);

PROCEDURE populateCaracteristici IS
BEGIN

  populateCategories;
  populateOrganisations;
  populateSubst_alim;
  populateSubst_nealim;
  populateCities;

END populateCaracteristici;

PROCEDURE populateCategories IS
BEGIN

   insertCategory('ORGANIZATII');
   insertCategory('SUBSTANTE ALIMENTARE');
   insertCategory('SUBSTANTE NEALIMENTARE');
   insertCategory('ORASE');
   
 END populateCategories;

PROCEDURE insertCategory(category_name IN categorie_caracteristici.nume%TYPE) AS
BEGIN

  INSERT INTO categorie_caracteristici(NUME) VALUES (category_name);
  
END insertCategory;

PROCEDURE populateOrganisations AS

  org_name caracteristica.name%TYPE;
  input_file UTL_FILE.FILE_TYPE;
  it NUMBER:=1;
  ok NUMBER(1):=0;
  
BEGIN

  input_file := UTL_FILE.FOPEN('USER_DIR','organizations_csv.txt','R'); 
  
  LOOP
    BEGIN
    
      UTL_FILE.GET_LINE(input_file,org_name); 
      insertOrganisation(org_name);
      it:=it+1;
      
    EXCEPTION WHEN No_Data_Found THEN EXIT; 
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('CSV file \\EDeC\sql\csv\organizations_csv.txt at  line '||it);
      ok:=1;
      
    END;
  END LOOP;
  
  IF ok=0 
   THEN COMMIT;
   END IF;
   
END populateOrganisations;

PROCEDURE insertOrganisation(organisation_name IN caracteristica.name%TYPE) AS
BEGIN

 INSERT INTO caracteristica(NAME,CATEGORIE_CARACTERISTICI_ID) VALUES (organisation_name,1);
 
END insertOrganisation;

PROCEDURE populateSubst_alim AS

  alim_name caracteristica.name%TYPE;
  input_file UTL_FILE.FILE_TYPE; 
  it NUMBER:=1;
  ok NUMBER(1):=0;
  
BEGIN

  input_file := UTL_FILE.FOPEN('USER_DIR','subst_alim_csv.txt','R'); 
  
  LOOP
    BEGIN
    
      UTL_FILE.GET_LINE(input_file,alim_name); 
      insertSubst_alim(alim_name);
      it:=it+1;
      
    EXCEPTION
    WHEN No_Data_Found THEN EXIT; 
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('CSV file \\EDeC\sql\csv\subst_alim_csv.txt at  line '||it);
      ok:=1;
    END;
    
  END LOOP;
  IF ok=0 
   THEN COMMIT;
   END IF;
   
END populateSubst_alim;

PROCEDURE insertSubst_alim(alim_name IN caracteristica.name%TYPE) AS

BEGIN

  INSERT INTO caracteristica(NAME,CATEGORIE_CARACTERISTICI_ID) VALUES (alim_name,2);
  
END insertSubst_alim;

PROCEDURE populateSubst_nealim AS

  nealim_name caracteristica.name%TYPE;
  input_file UTL_FILE.FILE_TYPE;
  it NUMBER:=1;
  ok NUMBER(1):=0;
  
BEGIN

  input_file := UTL_FILE.FOPEN('USER_DIR','chemicals_csv.txt','R'); 
  
  LOOP
    BEGIN
    
      UTL_FILE.GET_LINE(input_file,nealim_name); 
      insertSubst_nealim(nealim_name);
      it:=it+1;
      
    EXCEPTION WHEN No_Data_Found THEN EXIT; 
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('CSV file \\EDeC\sql\csv\chemicals_csv.txt at  line '||it);
      ok:=1;
      
    END;
  END LOOP;
  
  IF ok=0 
   THEN COMMIT;
   END IF;
   
END populateSubst_nealim;

PROCEDURE insertSubst_nealim(nealim_name IN caracteristica.name%TYPE) AS
BEGIN

  INSERT INTO caracteristica(NAME,CATEGORIE_CARACTERISTICI_ID) VALUES (nealim_name,3);
  
END insertSubst_nealim;

PROCEDURE populateCities AS

  city_name caracteristica.name%TYPE;
  input_file UTL_FILE.FILE_TYPE; 
  it NUMBER:=1;
  ok NUMBER(1):=0;
  
BEGIN

  input_file := UTL_FILE.FOPEN('USER_DIR','cities_csv.txt','R'); 
  
  LOOP
    BEGIN
      UTL_FILE.GET_LINE(input_file,city_name); 
      insertCity(city_name);
      it:=it+1;
      
    EXCEPTION WHEN No_Data_Found THEN EXIT;
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('CSV file \\EDeC\sql\csv\chemicals_csv.txt at  line '||it);
      ok:=1;
    END;
  END LOOP;
  
  IF ok=0 
   THEN COMMIT;
   END IF;
   
END populateCities;

PROCEDURE insertCity(city_name IN caracteristica.name%TYPE)AS
BEGIN

  INSERT INTO caracteristica(NAME,CATEGORIE_CARACTERISTICI_ID) VALUES (city_name,4);
  
END insertCity;

PROCEDURE insertCacacteristica(c_name caracteristica.name%TYPE,c_cat caracteristica.categorie_caracteristici_id%TYPE)
IS
  BEGIN
  
    INSERT INTO caracteristica(NAME,CATEGORIE_CARACTERISTICI_ID) VALUES (c_name,c_cat);

END insertCacacteristica;

END edec_caracteristici_package;
/
