-- SGTG - Tabla student (nivel 1: depende de academy_program, type_of_document)

BEGIN;

CREATE TABLE academico.student (
    academy_program_id  VARCHAR(3)   NOT NULL,
    code                VARCHAR(7)   NOT NULL,
    document            VARCHAR(15)  NOT NULL,
    first_name          VARCHAR(50)  NOT NULL,
    second_name         VARCHAR(50),
    last_name1          VARCHAR(50)  NOT NULL,
    last_name2          VARCHAR(50),
    email               VARCHAR(100) NOT NULL,
    cell_phone          VARCHAR(10)  NOT NULL,
    approved_credits    INTEGER      NOT NULL,
    type_of_document_id VARCHAR(3)   NOT NULL,
    CONSTRAINT PK_STUDENT PRIMARY KEY (academy_program_id, code),
    CONSTRAINT FK_ACADEMY_PROGRAM_STUDENT FOREIGN KEY (academy_program_id)
    REFERENCES academico.academy_program (id)
    ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT FK_TYPE_OF_DOCUMENT_STUDENT FOREIGN KEY (type_of_document_id)
    REFERENCES academico.type_of_document (id)
    ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT UK_STUDENT_DOCUMENT UNIQUE (type_of_document_id, document),
    CONSTRAINT UK_STUDENT_EMAIL UNIQUE (email),
    CONSTRAINT CK_APPROVED_CREDITS CHECK (approved_credits >= 0),
    CONSTRAINT CK_EMAIL CHECK (email LIKE '%_@_%'),
    CONSTRAINT CK_CELL_PHONE CHECK (cell_phone ~ '^[0-9]{10}$')
);

COMMIT;
