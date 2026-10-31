-- SGTG - Tabla de auditoría de thesis_evaluation
-- Se audita la calificación de la sustentación: define si el trabajo de grado se aprueba (nota >= 3.0)
-- Sin llaves foráneas: el historial se conserva aunque se borre el registro original

BEGIN;

CREATE TABLE academico.thesis_evaluation_auditoria (
    id_auditoria  INTEGER GENERATED ALWAYS AS IDENTITY,
    operacion     CHAR(1)      NOT NULL,
    usuario       VARCHAR(63)  NOT NULL DEFAULT session_user,
    fecha_hora    TIMESTAMPTZ  NOT NULL DEFAULT now(),
    thesis_id_thesis VARCHAR(10) NOT NULL,
    evaluation_date DATE NOT NULL,
    grade_anterior NUMERIC(10,2),
    grade_nuevo NUMERIC(10,2),
    result_anterior VARCHAR(5),
    result_nuevo VARCHAR(5),
    comments_anterior VARCHAR(2000),
    comments_nuevo VARCHAR(2000),
    CONSTRAINT PK_THESIS_EVALUATION_AUDITORIA PRIMARY KEY (id_auditoria),
    CONSTRAINT CK_THESIS_EVALUATION_AUDITORIA_OPERACION CHECK (operacion IN ('I', 'U', 'D'))
);

COMMIT;
