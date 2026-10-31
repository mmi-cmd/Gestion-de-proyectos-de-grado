-- SGTG - Tabla thesis_evaluation (nivel 4: depende de thesis)

BEGIN;

CREATE TABLE academico.thesis_evaluation (
    thesis_id_thesis VARCHAR(10)   NOT NULL,
    evaluation_date  DATE          NOT NULL,
    grade            NUMERIC(10,2) NOT NULL,
    result           VARCHAR(5)    NOT NULL,
    comments         VARCHAR(2000),
    CONSTRAINT PK_THESIS_EVALUATION PRIMARY KEY (thesis_id_thesis, evaluation_date),
    CONSTRAINT FK_THESIS_THESIS_EVALUATION FOREIGN KEY (thesis_id_thesis)
    REFERENCES academico.thesis (id_thesis)
    ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT CK_GRADE CHECK (grade BETWEEN 0 AND 5)
);

COMMIT;
