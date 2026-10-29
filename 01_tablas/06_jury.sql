-- SGTG - Tabla jury (nivel 0: sin dependencias)

BEGIN;

CREATE TABLE academico.jury (
    code       VARCHAR(5)   NOT NULL,
    document   VARCHAR(15)  NOT NULL,
    name1      VARCHAR(50)  NOT NULL,
    name2      VARCHAR(50),
    last_name1 VARCHAR(50)  NOT NULL,
    last_name2 VARCHAR(50),
    email      VARCHAR(200) NOT NULL,
    CONSTRAINT PK_JURY PRIMARY KEY (code),
    CONSTRAINT UK_JURY_DOCUMENT UNIQUE (document),
    CONSTRAINT UK_JURY_EMAIL UNIQUE (email),
    CONSTRAINT CK_EMAIL CHECK (email LIKE '%_@_%')
);

COMMIT;
