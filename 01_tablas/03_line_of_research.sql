-- SGTG - Tabla line_of_research (nivel 0: sin dependencias)

BEGIN;

CREATE TABLE academico.line_of_research (
    id          VARCHAR(3)  NOT NULL,
    description VARCHAR(80) NOT NULL,
    CONSTRAINT PK_LINE_OF_RESEARCH PRIMARY KEY (id),
    CONSTRAINT UK_LINE_OF_RESEARCH_DESCRIPTION UNIQUE (description)
);

COMMIT;
