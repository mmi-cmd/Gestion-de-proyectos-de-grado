-- SGTG - Tabla evaluation_criterion (nivel 0: sin dependencias)

BEGIN;

CREATE TABLE academico.evaluation_criterion (
    ecn_id                 VARCHAR(5)    NOT NULL,
    descripcion            VARCHAR(2000) NOT NULL,
    responsible_juror_type VARCHAR(50)   NOT NULL,
    CONSTRAINT PK_EVALUATION_CRITERION PRIMARY KEY (ecn_id)
);

COMMIT;
