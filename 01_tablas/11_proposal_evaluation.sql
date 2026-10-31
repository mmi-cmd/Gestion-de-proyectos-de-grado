-- SGTG - Tabla proposal_evaluation (nivel 2: depende de proposal)

BEGIN;

CREATE TABLE academico.proposal_evaluation (
    proposal_id_proposal VARCHAR(5) NOT NULL,
    evaluation_date      DATE       NOT NULL,
    criterio1            VARCHAR(2) NOT NULL,
    criterio2            VARCHAR(2) NOT NULL,
    criterio3            VARCHAR(2) NOT NULL,
    criterio4            VARCHAR(2) NOT NULL,
    criterio5            VARCHAR(2) NOT NULL,
    criterio6            VARCHAR(2) NOT NULL,
    approved             CHAR(1)    NOT NULL,
    final_judgment       VARCHAR(5) NOT NULL,
    CONSTRAINT PK_PROPOSAL_EVALUATION PRIMARY KEY (evaluation_date, proposal_id_proposal),
    CONSTRAINT FK_PROPOSAL_PROPOSAL_EVALUATION FOREIGN KEY (proposal_id_proposal)
    REFERENCES academico.proposal (id_proposal)
    ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT CK_APPROVED CHECK (approved IN ('S', 'N')),
    CONSTRAINT CK_FINAL_JUDGMENT CHECK (final_judgment IN ('A', 'AC', 'AP', 'NA'))
);

COMMIT;
