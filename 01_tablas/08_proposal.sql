-- SGTG - Tabla proposal (nivel 1: depende de line_of_research)

BEGIN;

CREATE TABLE academico.proposal (
    id_proposal         VARCHAR(5)    NOT NULL,
    line_of_research_id VARCHAR(3)    NOT NULL,
    title               VARCHAR(1000) NOT NULL,
    abstract            VARCHAR(2000) NOT NULL,
    submission_date     DATE          NOT NULL,
    keywords            VARCHAR(200)  NOT NULL,
    document_file       VARCHAR(300)  NOT NULL,
    CONSTRAINT PK_PROPOSAL PRIMARY KEY (id_proposal),
    CONSTRAINT FK_LINE_OF_RESEARCH_PROPOSAL FOREIGN KEY (line_of_research_id)
    REFERENCES academico.line_of_research (id)
    ON DELETE RESTRICT ON UPDATE CASCADE
);

COMMIT;
