-- SGTG - Tabla proyect_plan (nivel 2: depende de proposal)

BEGIN;

CREATE TABLE academico.proyect_plan (
    id_plan              VARCHAR(5)    NOT NULL,
    formal_receipt_date  DATE          NOT NULL,
    document_file        VARCHAR(1000) NOT NULL,
    proposal_id_proposal VARCHAR(5)    NOT NULL,
    CONSTRAINT PK_PROYECT_PLAN PRIMARY KEY (id_plan),
    CONSTRAINT FK_PROPOSAL_PROYECT_PLAN FOREIGN KEY (proposal_id_proposal)
    REFERENCES academico.proposal (id_proposal)
    ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT UK_PROYECT_PLAN_PROPOSAL_ID_PROPOSAL UNIQUE (proposal_id_proposal)
);
COMMENT ON TABLE academico.proyect_plan IS 'Plan de proyecto; cada propuesta tiene como máximo un plan (1:1)';

COMMIT;
