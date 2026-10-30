-- SGTG - Tabla academy_program (nivel 0: sin dependencias)

BEGIN;

CREATE TABLE academico.academy_program (
    id               VARCHAR(3)  NOT NULL,
    name             VARCHAR(50) NOT NULL,
    faculty          VARCHAR(50) NOT NULL,
    required_credits INTEGER     NOT NULL,
    CONSTRAINT PK_ACADEMY_PROGRAM PRIMARY KEY (id),
    CONSTRAINT UK_ACADEMY_PROGRAM_NAME UNIQUE (name),
    CONSTRAINT CK_REQUIRED_CREDITS CHECK (required_credits > 0)
);

COMMIT;
