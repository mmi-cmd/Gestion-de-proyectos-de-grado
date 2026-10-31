-- SGTG - Tabla jury_assignment (nivel 3: depende de jury, proyect_plan)

BEGIN;

CREATE TABLE academico.jury_assignment (
    jury_code            VARCHAR(5)  NOT NULL,
    type                 VARCHAR(50) NOT NULL,
    proyect_plan_id_plan VARCHAR(5)  NOT NULL,
    assigment_date       DATE        NOT NULL,
    status               CHAR(1)     NOT NULL,
    CONSTRAINT PK_JURY_ASSIGNMENT PRIMARY KEY (jury_code, type, proyect_plan_id_plan),
    CONSTRAINT FK_JURY_JURY_ASSIGNMENT FOREIGN KEY (jury_code)
    REFERENCES academico.jury (code)
    ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT FK_PROYECT_PLAN_JURY_ASSIGNMENT FOREIGN KEY (proyect_plan_id_plan)
    REFERENCES academico.proyect_plan (id_plan)
    ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT CK_STATUS CHECK (status IN ('A', 'I')),
    CONSTRAINT CK_JURY_TYPE CHECK (type IN ('Metodológico', 'Científico'))
);

-- Un solo jurado activo de cada tipo por plan
CREATE UNIQUE INDEX UX_JURY_ASSIGNMENT_ACTIVE_TYPE
    ON academico.jury_assignment (proyect_plan_id_plan, type) WHERE status = 'A';

COMMIT;
