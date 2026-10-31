-- SGTG - Tabla proposal_role (nivel 2: depende de support_teacher, proposal)

BEGIN;

CREATE TABLE academico.proposal_role (
    support_teacher_code VARCHAR(5)  NOT NULL,
    proposal_id_proposal VARCHAR(5)  NOT NULL,
    assignment_date      DATE        NOT NULL,
    role                 VARCHAR(50) NOT NULL,
    status               CHAR(1)     NOT NULL,
    CONSTRAINT PK_PROPOSAL_ROLE PRIMARY KEY (support_teacher_code, proposal_id_proposal),
    CONSTRAINT FK_SUPPORT_TEACHER_PROPOSAL_ROLE FOREIGN KEY (support_teacher_code)
    REFERENCES academico.support_teacher (code)
    ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT FK_PROPOSAL_PROPOSAL_ROLE FOREIGN KEY (proposal_id_proposal)
    REFERENCES academico.proposal (id_proposal)
    ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT CK_STATUS CHECK (status IN ('A', 'I'))
);

COMMIT;
