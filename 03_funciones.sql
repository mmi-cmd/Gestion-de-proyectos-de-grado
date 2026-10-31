-- SGTG - Función de auditoría de thesis_evaluation
-- SECURITY DEFINER: permite escribir la auditoría sin dar permisos directos sobre ella

BEGIN;

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

COMMIT;
