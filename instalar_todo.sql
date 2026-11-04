

BEGIN;

-- SGTG - Esquema

CREATE SCHEMA IF NOT EXISTS academico;

-- SGTG - Tabla type_of_document (nivel 0: sin dependencias)

CREATE TABLE academico.type_of_document (
    id          VARCHAR(3)  NOT NULL,
    description VARCHAR(30) NOT NULL,
    CONSTRAINT PK_TYPE_OF_DOCUMENT PRIMARY KEY (id),
    CONSTRAINT UK_TYPE_OF_DOCUMENT_DESCRIPTION UNIQUE (description)
);

-- SGTG - Tabla academy_program (nivel 0: sin dependencias)

CREATE TABLE academico.academy_program (
    id               VARCHAR(3)  NOT NULL,
    name             VARCHAR(50) NOT NULL,
    faculty          VARCHAR(50) NOT NULL,
    required_credits INTEGER     NOT NULL,
    CONSTRAINT PK_ACADEMY_PROGRAM PRIMARY KEY (id),
    CONSTRAINT UK_ACADEMY_PROGRAM_NAME UNIQUE (name),
    CONSTRAINT CK_REQUIRED_CREDITS CHECK (required_credits > 0)
);

-- SGTG - Tabla line_of_research (nivel 0: sin dependencias)

CREATE TABLE academico.line_of_research (
    id          VARCHAR(3)  NOT NULL,
    description VARCHAR(80) NOT NULL,
    CONSTRAINT PK_LINE_OF_RESEARCH PRIMARY KEY (id),
    CONSTRAINT UK_LINE_OF_RESEARCH_DESCRIPTION UNIQUE (description)
);

-- SGTG - Tabla evaluation_criterion (nivel 0: sin dependencias)

CREATE TABLE academico.evaluation_criterion (
    ecn_id                 VARCHAR(5)    NOT NULL,
    descripcion            VARCHAR(2000) NOT NULL,
    responsible_juror_type VARCHAR(50)   NOT NULL,
    CONSTRAINT PK_EVALUATION_CRITERION PRIMARY KEY (ecn_id)
);

-- SGTG - Tabla support_teacher (nivel 0: sin dependencias)

CREATE TABLE academico.support_teacher (
    code           VARCHAR(5)   NOT NULL,
    document       VARCHAR(15)  NOT NULL,
    name1          VARCHAR(50)  NOT NULL,
    name2          VARCHAR(50),
    last_name1     VARCHAR(50)  NOT NULL,
    last_name2     VARCHAR(50),
    email          VARCHAR(100) NOT NULL,
    phone          VARCHAR(10)  NOT NULL,
    knowledge_area VARCHAR(50)  NOT NULL,
    CONSTRAINT PK_SUPPORT_TEACHER PRIMARY KEY (code),
    CONSTRAINT UK_SUPPORT_TEACHER_DOCUMENT UNIQUE (document),
    CONSTRAINT UK_SUPPORT_TEACHER_EMAIL UNIQUE (email),
    CONSTRAINT CK_EMAIL CHECK (email LIKE '%_@_%'),
    CONSTRAINT CK_PHONE CHECK (phone ~ '^[0-9]{10}$')
);

-- SGTG - Tabla jury (nivel 0: sin dependencias)

CREATE TABLE academico.jury (
    code       VARCHAR(5)   NOT NULL,
    document   VARCHAR(15)  NOT NULL,
    name1      VARCHAR(50)  NOT NULL,
    name2      VARCHAR(50),
    last_name1 VARCHAR(50)  NOT NULL,
    last_name2 VARCHAR(50),
    email      VARCHAR(200) NOT NULL,
    CONSTRAINT PK_JURY PRIMARY KEY (code),
    CONSTRAINT UK_JURY_DOCUMENT UNIQUE (document),
    CONSTRAINT UK_JURY_EMAIL UNIQUE (email),
    CONSTRAINT CK_EMAIL CHECK (email LIKE '%_@_%')
);

-- SGTG - Tabla student (nivel 1: depende de academy_program, type_of_document)

CREATE TABLE academico.student (
    academy_program_id  VARCHAR(3)   NOT NULL,
    code                VARCHAR(7)   NOT NULL,
    document            VARCHAR(15)  NOT NULL,
    first_name          VARCHAR(50)  NOT NULL,
    second_name         VARCHAR(50),
    last_name1          VARCHAR(50)  NOT NULL,
    last_name2          VARCHAR(50),
    email               VARCHAR(100) NOT NULL,
    cell_phone          VARCHAR(10)  NOT NULL,
    approved_credits    INTEGER      NOT NULL,
    type_of_document_id VARCHAR(3)   NOT NULL,
    CONSTRAINT PK_STUDENT PRIMARY KEY (academy_program_id, code),
    CONSTRAINT FK_ACADEMY_PROGRAM_STUDENT FOREIGN KEY (academy_program_id)
    REFERENCES academico.academy_program (id)
    ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT FK_TYPE_OF_DOCUMENT_STUDENT FOREIGN KEY (type_of_document_id)
    REFERENCES academico.type_of_document (id)
    ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT UK_STUDENT_DOCUMENT UNIQUE (type_of_document_id, document),
    CONSTRAINT UK_STUDENT_EMAIL UNIQUE (email),
    CONSTRAINT CK_APPROVED_CREDITS CHECK (approved_credits >= 0),
    CONSTRAINT CK_EMAIL CHECK (email LIKE '%_@_%'),
    CONSTRAINT CK_CELL_PHONE CHECK (cell_phone ~ '^[0-9]{10}$')
);

-- SGTG - Tabla proposal (nivel 1: depende de line_of_research)

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

-- SGTG - Tabla students_proposal (nivel 2: depende de student, proposal)

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

-- SGTG - Tabla proposal_role (nivel 2: depende de support_teacher, proposal)

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

-- SGTG - Tabla proposal_evaluation (nivel 2: depende de proposal)

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

-- SGTG - Tabla proyect_plan (nivel 2: depende de proposal)

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

-- SGTG - Tabla proyect_plan_evaluation (nivel 3: depende de proyect_plan)

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

-- SGTG - Tabla jury_assignment (nivel 3: depende de jury, proyect_plan)

CREATE TABLE academico.jury_assignment (
    jury_code            VARCHAR(5)  NOT NULL,
    type                 VARCHAR(50) NOT NULL,
    proyect_plan_id_plan VARCHAR(5)  NOT NULL,
    assigment_date       DATE        NOT NULL,
    status               CHAR(1)     NOT NULL,
    CONSTRAINT PK_JURY_ASSIGNMENT PRIMARY KEY (jury_code, type, proyect_plan_id_plan),
    CONSTRAINT FK_JURY_JURY_ASSIGNMENT FOREIGN KEY (jury_code)
    REFERENCES academico.jury (code)
    ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT FK_PROYECT_PLAN_JURY_ASSIGNMENT FOREIGN KEY (proyect_plan_id_plan)
    REFERENCES academico.proyect_plan (id_plan)
    ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT CK_STATUS CHECK (status IN ('A', 'I')),
    CONSTRAINT CK_JURY_TYPE CHECK (type IN ('Metodológico', 'Científico'))
);

-- Un solo jurado activo de cada tipo por plan
CREATE UNIQUE INDEX UX_JURY_ASSIGNMENT_ACTIVE_TYPE
    ON academico.jury_assignment (proyect_plan_id_plan, type) WHERE status = 'A';

-- SGTG - Tabla thesis (nivel 3: depende de proyect_plan)

CREATE TABLE academico.thesis (
    id_thesis            VARCHAR(10)   NOT NULL,
    registration_date    DATE          NOT NULL,
    defense_date         DATE          NOT NULL,
    document_file        VARCHAR(2000) NOT NULL,
    proyect_plan_id_plan VARCHAR(5)    NOT NULL,
    CONSTRAINT PK_THESIS PRIMARY KEY (id_thesis),
    CONSTRAINT FK_PROYECT_PLAN_THESIS FOREIGN KEY (proyect_plan_id_plan)
    REFERENCES academico.proyect_plan (id_plan)
    ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT UK_THESIS_PROYECT_PLAN_ID_PLAN UNIQUE (proyect_plan_id_plan),
    CONSTRAINT CK_DEFENSE_DATE CHECK (defense_date >= registration_date)
);
COMMENT ON TABLE academico.thesis IS 'Tesis; cada plan de proyecto tiene como máximo una tesis (1:1)';

-- SGTG - Tabla proyect_plan_evaluation_detail (nivel 4: depende de proyect_plan_evaluation, evaluation_criterion)

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

-- SGTG - Tabla thesis_evaluation (nivel 4: depende de thesis)

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

-- SGTG - Tabla de auditoría de thesis_evaluation
-- Se audita la calificación de la sustentación: define si el trabajo de grado se aprueba (nota >= 3.0)
-- Sin llaves foráneas: el historial se conserva aunque se borre el registro original

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

-- SGTG - Función de auditoría de thesis_evaluation
-- SECURITY DEFINER: permite escribir la auditoría sin dar permisos directos sobre ella

CREATE OR REPLACE FUNCTION academico.fn_auditar_thesis_evaluation()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = academico, pg_temp
AS $$
BEGIN
    IF (TG_OP = 'INSERT') THEN
        INSERT INTO academico.thesis_evaluation_auditoria (operacion, thesis_id_thesis, evaluation_date, grade_nuevo, result_nuevo, comments_nuevo)
        VALUES ('I', NEW.thesis_id_thesis, NEW.evaluation_date, NEW.grade, NEW.result, NEW.comments);

    ELSIF (TG_OP = 'UPDATE') THEN
        IF ROW(OLD.grade, OLD.result, OLD.comments) IS DISTINCT FROM ROW(NEW.grade, NEW.result, NEW.comments) THEN
            INSERT INTO academico.thesis_evaluation_auditoria (operacion, thesis_id_thesis, evaluation_date, grade_anterior, grade_nuevo, result_anterior, result_nuevo, comments_anterior, comments_nuevo)
            VALUES ('U', NEW.thesis_id_thesis, NEW.evaluation_date, OLD.grade, NEW.grade, OLD.result, NEW.result, OLD.comments, NEW.comments);
        END IF;

    ELSIF (TG_OP = 'DELETE') THEN
        INSERT INTO academico.thesis_evaluation_auditoria (operacion, thesis_id_thesis, evaluation_date, grade_anterior, result_anterior, comments_anterior)
        VALUES ('D', OLD.thesis_id_thesis, OLD.evaluation_date, OLD.grade, OLD.result, OLD.comments);
    END IF;
    RETURN NULL;
END;
$$;

-- SGTG - Trigger de auditoría de thesis_evaluation

CREATE TRIGGER trg_auditar_thesis_evaluation
AFTER INSERT OR UPDATE OR DELETE ON academico.thesis_evaluation
FOR EACH ROW EXECUTE FUNCTION academico.fn_auditar_thesis_evaluation();

COMMIT;
