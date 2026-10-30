-- SGTG - Tabla type_of_document (nivel 0: sin dependencias)

BEGIN;

CREATE TABLE academico.type_of_document (
    id          VARCHAR(3)  NOT NULL,
    description VARCHAR(30) NOT NULL,
    CONSTRAINT PK_TYPE_OF_DOCUMENT PRIMARY KEY (id),
    CONSTRAINT UK_TYPE_OF_DOCUMENT_DESCRIPTION UNIQUE (description)
);

COMMIT;
