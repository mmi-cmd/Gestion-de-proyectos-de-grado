-- SGTG - Tabla students_proposal (nivel 2: depende de student, proposal)

BEGIN;

CREATE TABLE academico.students_proposal (
    student_academy_program_id VARCHAR(3) NOT NULL,
    student_code               VARCHAR(7) NOT NULL,
    proposal_id_proposal       VARCHAR(5) NOT NULL,
    CONSTRAINT PK_STUDENTS_PROPOSAL PRIMARY KEY (student_academy_program_id, student_code, proposal_id_proposal),
    CONSTRAINT FK_STUDENT_STUDENTS_PROPOSAL FOREIGN KEY (student_academy_program_id, student_code)
    REFERENCES academico.student (academy_program_id, code)
    ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT FK_PROPOSAL_STUDENTS_PROPOSAL FOREIGN KEY (proposal_id_proposal)
    REFERENCES academico.proposal (id_proposal)
    ON DELETE RESTRICT ON UPDATE CASCADE
);

COMMIT;
