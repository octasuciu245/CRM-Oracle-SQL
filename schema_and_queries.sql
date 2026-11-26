-- Sequence for primary key generation
CREATE SEQUENCE SECVENTA_CRM
START WITH 1
INCREMENT BY 1
NOCYCLE NOCACHE;

-- 1. DEPARTAMENT
CREATE TABLE DEPARTAMENT (
    id_departament NUMBER(10, 0) PRIMARY KEY,
    nume_departament VARCHAR2(50) NOT NULL UNIQUE
);

INSERT INTO DEPARTAMENT (id_departament, nume_departament) VALUES (SECVENTA_CRM.NEXTVAL, 'IT');
INSERT INTO DEPARTAMENT (id_departament, nume_departament) VALUES (SECVENTA_CRM.NEXTVAL, 'HR');
INSERT INTO DEPARTAMENT (id_departament, nume_departament) VALUES (SECVENTA_CRM.NEXTVAL, 'Vanzari');
INSERT INTO DEPARTAMENT (id_departament, nume_departament) VALUES (SECVENTA_CRM.NEXTVAL, 'Marketing');
INSERT INTO DEPARTAMENT (id_departament, nume_departament) VALUES (SECVENTA_CRM.NEXTVAL, 'Suport');

-- 2. ARTICOL 
CREATE TABLE ARTICOL (
    id_articol NUMBER(10, 0) PRIMARY KEY,
    nume_articol VARCHAR2(100) NOT NULL
);

INSERT INTO ARTICOL (id_articol, nume_articol) VALUES (SECVENTA_CRM.NEXTVAL, 'Laptop');
INSERT INTO ARTICOL (id_articol, nume_articol) VALUES (SECVENTA_CRM.NEXTVAL, 'Monitor');
INSERT INTO ARTICOL (id_articol, nume_articol) VALUES (SECVENTA_CRM.NEXTVAL, 'Tastatura');
INSERT INTO ARTICOL (id_articol, nume_articol) VALUES (SECVENTA_CRM.NEXTVAL, 'Mouse');
INSERT INTO ARTICOL (id_articol, nume_articol) VALUES (SECVENTA_CRM.NEXTVAL, 'Imprimanta');
INSERT INTO ARTICOL (id_articol, nume_articol) VALUES (SECVENTA_CRM.NEXTVAL, 'Instalare');
INSERT INTO ARTICOL (id_articol, nume_articol) VALUES (SECVENTA_CRM.NEXTVAL, 'Reparatie');

-- 3. PRODUS 
CREATE TABLE PRODUS (
    id_articol NUMBER(10, 0) PRIMARY KEY,
    stoc NUMBER(10, 0) DEFAULT 0 CHECK (stoc >= 0),
    CONSTRAINT fk_produs_articol FOREIGN KEY (id_articol) REFERENCES ARTICOL(id_articol) ON DELETE CASCADE
);

INSERT INTO PRODUS (id_articol, stoc) VALUES (6, 50);
INSERT INTO PRODUS (id_articol, stoc) VALUES (7, 30);
INSERT INTO PRODUS (id_articol, stoc) VALUES (8, 100);
INSERT INTO PRODUS (id_articol, stoc) VALUES (9, 150);
INSERT INTO PRODUS (id_articol, stoc) VALUES (10, 20);

-- 4. SERVICIU 
CREATE TABLE SERVICIU (
    id_articol NUMBER(10, 0) PRIMARY KEY,
    tarif_orar NUMBER(10, 2) CHECK (tarif_orar > 0),
    CONSTRAINT fk_serviciu_articol FOREIGN KEY (id_articol) REFERENCES ARTICOL(id_articol) ON DELETE CASCADE
);

INSERT INTO SERVICIU (id_articol, tarif_orar) VALUES (11, 150.00);
INSERT INTO SERVICIU (id_articol, tarif_orar) VALUES (12, 200.00);

-- 5. AGENT_VANZARI
CREATE TABLE AGENT_VANZARI (
    id_agent NUMBER(10, 0) PRIMARY KEY,
    id_departament NUMBER(10, 0) NOT NULL,
    nume_agent VARCHAR2(50) NOT NULL,
    email_agent VARCHAR2(50) NOT NULL UNIQUE,
    CONSTRAINT fk_agent_dept FOREIGN KEY (id_departament) REFERENCES DEPARTAMENT(id_departament)
);

INSERT INTO AGENT_VANZARI (id_agent, id_departament, nume_agent, email_agent) VALUES (SECVENTA_CRM.NEXTVAL, 1, 'Ana', 'ana@firma.ro');
INSERT INTO AGENT_VANZARI (id_agent, id_departament, nume_agent, email_agent) VALUES (SECVENTA_CRM.NEXTVAL, 2, 'Dan', 'dan@firma.ro');
INSERT INTO AGENT_VANZARI (id_agent, id_departament, nume_agent, email_agent) VALUES (SECVENTA_CRM.NEXTVAL, 3, 'Ion', 'ion@firma.ro');
INSERT INTO AGENT_VANZARI (id_agent, id_departament, nume_agent, email_agent) VALUES (SECVENTA_CRM.NEXTVAL, 4, 'Mia', 'mia@firma.ro');
INSERT INTO AGENT_VANZARI (id_agent, id_departament, nume_agent, email_agent) VALUES (SECVENTA_CRM.NEXTVAL, 5, 'Ema', 'ema@firma.ro');

-- 6. CLIENT
CREATE TABLE CLIENT (
    id_client NUMBER(10, 0) PRIMARY KEY,
    id_agent NUMBER(10, 0) NOT NULL,
    nume_client VARCHAR2(50) NOT NULL UNIQUE,
    telefon VARCHAR2(15),
    CONSTRAINT fk_client_agent FOREIGN KEY (id_agent) REFERENCES AGENT_VANZARI(id_agent)
);

INSERT INTO CLIENT (id_client, id_agent, nume_client, telefon) VALUES (SECVENTA_CRM.NEXTVAL, 13, 'Alfa SRL', '0711222333');
INSERT INTO CLIENT (id_client, id_agent, nume_client, telefon) VALUES (SECVENTA_CRM.NEXTVAL, 14, 'Beta SRL', '0722333444');
INSERT INTO CLIENT (id_client, id_agent, nume_client, telefon) VALUES (SECVENTA_CRM.NEXTVAL, 15, 'Gama SRL', '0733444555');
INSERT INTO CLIENT (id_client, id_agent, nume_client, telefon) VALUES (SECVENTA_CRM.NEXTVAL, 16, 'Delta SRL', '0744555666');
INSERT INTO CLIENT (id_client, id_agent, nume_client, telefon) VALUES (SECVENTA_CRM.NEXTVAL, 17, 'Eco SRL', '0755666777');

-- 7. SARCINA
CREATE TABLE SARCINA (
    id_sarcina NUMBER(10, 0) PRIMARY KEY,
    id_client NUMBER(10, 0) NOT NULL,
    descriere VARCHAR2(4000) NOT NULL,
    status_sarcina VARCHAR2(20) CHECK (status_sarcina IN ('In asteptare', 'Finalizata')),
    CONSTRAINT fk_sarcina_client FOREIGN KEY (id_client) REFERENCES CLIENT(id_client)
);

INSERT INTO SARCINA (id_sarcina, id_client, descriere, status_sarcina) VALUES (SECVENTA_CRM.NEXTVAL, 18, 'Trimitere oferta', 'Finalizata');
INSERT INTO SARCINA (id_sarcina, id_client, descriere, status_sarcina) VALUES (SECVENTA_CRM.NEXTVAL, 19, 'Stabilire necesar', 'In asteptare');
INSERT INTO SARCINA (id_sarcina, id_client, descriere, status_sarcina) VALUES (SECVENTA_CRM.NEXTVAL, 20, 'Prezentare servicii', 'Finalizata');
INSERT INTO SARCINA (id_sarcina, id_client, descriere, status_sarcina) VALUES (SECVENTA_CRM.NEXTVAL, 21, 'Negociere contract', 'In asteptare');
INSERT INTO SARCINA (id_sarcina, id_client, descriere, status_sarcina) VALUES (SECVENTA_CRM.NEXTVAL, 22, 'Semnare acord confidentialitate', 'Finalizata');

-- 8. OPORTUNITATE
CREATE TABLE OPORTUNITATE (
    id_oportunitate NUMBER(10, 0) PRIMARY KEY,
    id_client NUMBER(10, 0) NOT NULL,
    status_oportunitate VARCHAR2(20) CHECK (status_oportunitate IN ('Deschisa', 'Castigata', 'Pierduta')),
    CONSTRAINT fk_oportunitate_client FOREIGN KEY (id_client) REFERENCES CLIENT(id_client)
);

INSERT INTO OPORTUNITATE (id_oportunitate, id_client, status_oportunitate) VALUES (SECVENTA_CRM.NEXTVAL, 18, 'Castigata');
INSERT INTO OPORTUNITATE (id_oportunitate, id_client, status_oportunitate) VALUES (SECVENTA_CRM.NEXTVAL, 19, 'Deschisa');
INSERT INTO OPORTUNITATE (id_oportunitate, id_client, status_oportunitate) VALUES (SECVENTA_CRM.NEXTVAL, 20, 'Pierduta');
INSERT INTO OPORTUNITATE (id_oportunitate, id_client, status_oportunitate) VALUES (SECVENTA_CRM.NEXTVAL, 21, 'Castigata');
INSERT INTO OPORTUNITATE (id_oportunitate, id_client, status_oportunitate) VALUES (SECVENTA_CRM.NEXTVAL, 22, 'Castigata');

-- 9. JURNAL_CLIENT 
CREATE TABLE JURNAL_CLIENT (
    id_client NUMBER(10, 0) PRIMARY KEY,
    text_notita VARCHAR2(4000) NOT NULL,
    CONSTRAINT fk_jurnal_client FOREIGN KEY (id_client) REFERENCES CLIENT(id_client) ON DELETE CASCADE
);

INSERT INTO JURNAL_CLIENT (id_client, text_notita) VALUES (18, 'Client principal, a cerut oferte lunare.');
INSERT INTO JURNAL_CLIENT (id_client, text_notita) VALUES (19, 'Interesat de pachete de mentenanta.');
INSERT INTO JURNAL_CLIENT (id_client, text_notita) VALUES (20, 'Atentie: buget limitat trimestrul acesta.');
INSERT INTO JURNAL_CLIENT (id_client, text_notita) VALUES (21, 'Preferinte pentru produse premium.');
INSERT INTO JURNAL_CLIENT (id_client, text_notita) VALUES (22, 'Negocierile au durat mai mult decat estimat.');

-- 10. CONTRACT 
CREATE TABLE CONTRACT (
    id_oportunitate NUMBER(10, 0) PRIMARY KEY,
    data_semnare DATE NOT NULL,
    CONSTRAINT fk_contract_oportunitate FOREIGN KEY (id_oportunitate) REFERENCES OPORTUNITATE(id_oportunitate)
);

INSERT INTO CONTRACT (id_oportunitate, data_semnare) VALUES (28, TO_DATE('2026-05-10', 'YYYY-MM-DD'));
INSERT INTO CONTRACT (id_oportunitate, data_semnare) VALUES (30, TO_DATE('2026-05-12', 'YYYY-MM-DD'));
INSERT INTO CONTRACT (id_oportunitate, data_semnare) VALUES (32, TO_DATE('2026-05-15', 'YYYY-MM-DD'));

-- 11. OPORTUNITATE_ARTICOL (associative table M:N)
CREATE TABLE OPORTUNITATE_ARTICOL (
    id_oportunitate NUMBER(10, 0),
    id_articol NUMBER(10, 0),
    cantitate NUMBER(10, 0) CHECK (cantitate > 0),
    CONSTRAINT pk_oportunitate_articol PRIMARY KEY (id_oportunitate, id_articol),
    CONSTRAINT fk_oa_oportunitate FOREIGN KEY (id_oportunitate) REFERENCES OPORTUNITATE(id_oportunitate) ON DELETE CASCADE,
    CONSTRAINT fk_oa_articol FOREIGN KEY (id_articol) REFERENCES ARTICOL(id_articol) ON DELETE CASCADE
);

INSERT INTO OPORTUNITATE_ARTICOL (id_oportunitate, id_articol, cantitate) VALUES (28, 6, 5);
INSERT INTO OPORTUNITATE_ARTICOL (id_oportunitate, id_articol, cantitate) VALUES (28, 9, 5);
INSERT INTO OPORTUNITATE_ARTICOL (id_oportunitate, id_articol, cantitate) VALUES (28, 11, 5);
INSERT INTO OPORTUNITATE_ARTICOL (id_oportunitate, id_articol, cantitate) VALUES (29, 7, 10);
INSERT INTO OPORTUNITATE_ARTICOL (id_oportunitate, id_articol, cantitate) VALUES (29, 8, 10);
INSERT INTO OPORTUNITATE_ARTICOL (id_oportunitate, id_articol, cantitate) VALUES (30, 12, 2);
INSERT INTO OPORTUNITATE_ARTICOL (id_oportunitate, id_articol, cantitate) VALUES (30, 10, 1);
INSERT INTO OPORTUNITATE_ARTICOL (id_oportunitate, id_articol, cantitate) VALUES (31, 6, 2);
INSERT INTO OPORTUNITATE_ARTICOL (id_oportunitate, id_articol, cantitate) VALUES (31, 11, 2);
INSERT INTO OPORTUNITATE_ARTICOL (id_oportunitate, id_articol, cantitate) VALUES (32, 10, 3);
INSERT INTO OPORTUNITATE_ARTICOL (id_oportunitate, id_articol, cantitate) VALUES (32, 7, 3);

-- Complex Queries:
-- Correlated subquery across 3+ joined tables
SELECT a.id_agent
FROM AGENT_VANZARI a
WHERE EXISTS (
    SELECT 1
    FROM CLIENT c
    JOIN OPORTUNITATE o ON c.id_client = o.id_client
    JOIN CONTRACT ct ON o.id_oportunitate = ct.id_oportunitate
    WHERE c.id_agent = a.id_agent
);

-- Uncorrelated subquery (inline view) in FROM
SELECT cl.nume_client, statistica.total_oportunitati
FROM CLIENT cl
JOIN (
    SELECT id_client, COUNT(id_oportunitate) AS total_oportunitati
    FROM OPORTUNITATE
    GROUP BY id_client
) statistica ON cl.id_client = statistica.id_client;

-- Grouping, aggregate functions, and HAVING with subquery
SELECT id_oportunitate, SUM(cantitate) AS total_produse
FROM OPORTUNITATE_ARTICOL
GROUP BY id_oportunitate
HAVING SUM(cantitate) > (
    SELECT AVG(cantitate)
    FROM OPORTUNITATE_ARTICOL
);

-- Ordering, NVL, DECODE, string functions, date functions, and CASE
SELECT
    UPPER(o.status_oportunitate) AS Status_Mare,
    SUBSTR(o.status_oportunitate, 1, 3) AS Status_Scurt,
    SYSDATE AS Data_Azi,
    LAST_DAY(ct.data_semnare) AS Ultima_Zi_Luna,
    CASE
        WHEN ct.data_semnare > TO_DATE('2026-05-13', 'YYYY-MM-DD') THEN 'Contract Recent'
        ELSE 'Contract Vechi'
    END AS Categorie_Contract,
    NVL(TO_CHAR(ct.data_semnare), 'Fara Data') AS Data_Verificata,
    DECODE(o.status_oportunitate, 'Castigata', 'Aprobata', 'Neaprobata') AS Status_Formal
FROM OPORTUNITATE o
LEFT JOIN CONTRACT ct ON o.id_oportunitate = ct.id_oportunitate
ORDER BY ct.data_semnare ASC;

-- f) CTE (WITH clause)
WITH CantitateOportunitate AS (
    SELECT o.id_oportunitate, SUM(oa.cantitate) AS cantitate_totala
    FROM OPORTUNITATE o
    JOIN OPORTUNITATE_ARTICOL oa ON o.id_oportunitate = oa.id_oportunitate
    WHERE o.status_oportunitate != 'Pierduta'
    GROUP BY o.id_oportunitate
)
SELECT id_oportunitate, cantitate_totala
FROM CantitateOportunitate
WHERE cantitate_totala > 5;

-- Outer join across 4 tables
SELECT
    a.id_agent,
    c.nume_client,
    o.id_oportunitate,
    ct.data_semnare
FROM AGENT_VANZARI a
LEFT JOIN CLIENT c ON a.id_agent = c.id_agent
LEFT JOIN OPORTUNITATE o ON c.id_client = o.id_client
LEFT JOIN CONTRACT ct ON o.id_oportunitate = ct.id_oportunitate;

-- Relational division
SELECT c.nume_client
FROM CLIENT c
JOIN OPORTUNITATE o ON c.id_client = o.id_client
JOIN OPORTUNITATE_ARTICOL oa ON o.id_oportunitate = oa.id_oportunitate
GROUP BY c.id_client, c.nume_client
HAVING COUNT(DISTINCT oa.id_articol) = (SELECT COUNT(*) FROM ARTICOL);

-- Top-N analysis
SELECT id_oportunitate, id_articol, cantitate
FROM OPORTUNITATE_ARTICOL
ORDER BY cantitate DESC
FETCH FIRST 3 ROWS ONLY;

-- DML operations with subqueries
DELETE FROM OPORTUNITATE
WHERE id_oportunitate NOT IN (
    SELECT DISTINCT id_oportunitate
    FROM OPORTUNITATE_ARTICOL
);

DELETE FROM CONTRACT
WHERE id_oportunitate IN (
    SELECT id_oportunitate
    FROM OPORTUNITATE
    WHERE status_oportunitate = 'Pierduta'
);

UPDATE OPORTUNITATE_ARTICOL
SET cantitate = cantitate + 1
WHERE id_oportunitate IN (
    SELECT id_oportunitate
    FROM OPORTUNITATE
    WHERE status_oportunitate = 'Castigata'
);

COMMIT;

-- Complex View & DML examples
CREATE OR REPLACE VIEW V_Oportunitati_Clienti AS
SELECT
    o.id_oportunitate,
    o.status_oportunitate,
    c.id_client,
    c.nume_client
FROM OPORTUNITATE o
JOIN CLIENT c ON o.id_client = c.id_client;

-- Allowed DML on view
UPDATE V_Oportunitati_Clienti
SET status_oportunitate = 'Castigata'
WHERE id_oportunitate = 28;
