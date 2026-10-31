-- SGTG - Tabla proyect_plan_evaluation (nivel 3: depende de proyect_plan)

BEGIN;

CREATE TABLE academico.proyect_plan_evaluation (
    proyect_plan_id_plan VARCHAR(5) NOT NULL,
    evaluation_date      DATE       NOT NULL,
    final_concept        VARCHAR(5) NOT NULL,
    CONSTRAINT PK_PROYECT_PLAN_EVALUATION PRIMARY KEY (evaluation_date, proyect_plan_id_plan),
    CONSTRAINT FK_PROYECT_PLAN_PROYECT_PLAN_EVALUATION FOREIGN KEY (proyect_plan_id_plan)
    REFERENCES academico.proyect_plan (id_plan)
    ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT CK_FINAL_CONCEPT CHECK (final_concept IN ('A', 'AC', 'AP', 'NA'))
);

COMMIT;
