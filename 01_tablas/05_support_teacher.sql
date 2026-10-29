-- SGTG - Tabla support_teacher (nivel 0: sin dependencias)

BEGIN;

CREATE TABLE academico.support_teacher (
    code           VARCHAR(5)   NOT NULL,
    document       VARCHAR(15)  NOT NULL,
    name1          VARCHAR(50)  NOT NULL,
    name2          VARCHAR(50),
    last_name1     VARCHAR(50)  NOT NULL,
    last_name2     VARCHAR(50),
    email          VARCHAR(100) NOT NULL,
    phone          VARCHAR(10)  NOT NULL,
    knowledge_area VARCHAR(50)  NOT NULL,
    CONSTRAINT PK_SUPPORT_TEACHER PRIMARY KEY (code),
    CONSTRAINT UK_SUPPORT_TEACHER_DOCUMENT UNIQUE (document),
    CONSTRAINT UK_SUPPORT_TEACHER_EMAIL UNIQUE (email),
    CONSTRAINT CK_EMAIL CHECK (email LIKE '%_@_%'),
    CONSTRAINT CK_PHONE CHECK (phone ~ '^[0-9]{10}$')
);

COMMIT;
