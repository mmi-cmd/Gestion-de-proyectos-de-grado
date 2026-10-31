-- SGTG - Tabla proyect_plan_evaluation_detail (nivel 4: depende de proyect_plan_evaluation, evaluation_criterion)

BEGIN;

CREATE TABLE academico.proyect_plan_evaluation_detail (
    evaluation_criterion_ecn_id VARCHAR(5)    NOT NULL,
    ppe_evaluation_date         DATE          NOT NULL,
    ppe_id_plan                 VARCHAR(5)    NOT NULL,
    value                       VARCHAR(2000) NOT NULL,
    comment                     VARCHAR(2000),
    CONSTRAINT PK_PROYECT_PLAN_EVALUATION_DETAIL PRIMARY KEY (evaluation_criterion_ecn_id, ppe_evaluation_date, ppe_id_plan),
    CONSTRAINT FK_PROYECT_PLAN_EVALUATION_PROYECT_PLAN_EVALUATION_DETAIL FOREIGN KEY (ppe_evaluation_date, ppe_id_plan)
    REFERENCES academico.proyect_plan_evaluation (evaluation_date, proyect_plan_id_plan)
    ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT FK_EVALUATION_CRITERION_PROYECT_PLAN_EVALUATION_DETAIL FOREIGN KEY (evaluation_criterion_ecn_id)
    REFERENCES academico.evaluation_criterion (ecn_id)
    ON DELETE RESTRICT ON UPDATE CASCADE
);

COMMIT;
