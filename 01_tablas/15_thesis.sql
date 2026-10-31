-- SGTG - Tabla thesis (nivel 3: depende de proyect_plan)

BEGIN;

CREATE TABLE academico.thesis (
    id_thesis            VARCHAR(10)   NOT NULL,
    registration_date    DATE          NOT NULL,
    defense_date         DATE          NOT NULL,
    document_file        VARCHAR(2000) NOT NULL,
    proyect_plan_id_plan VARCHAR(5)    NOT NULL,
    CONSTRAINT PK_THESIS PRIMARY KEY (id_thesis),
    CONSTRAINT FK_PROYECT_PLAN_THESIS FOREIGN KEY (proyect_plan_id_plan)
    REFERENCES academico.proyect_plan (id_plan)
    ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT UK_THESIS_PROYECT_PLAN_ID_PLAN UNIQUE (proyect_plan_id_plan),
    CONSTRAINT CK_DEFENSE_DATE CHECK (defense_date >= registration_date)
);
COMMENT ON TABLE academico.thesis IS 'Tesis; cada plan de proyecto tiene como máximo una tesis (1:1)';

COMMIT;
