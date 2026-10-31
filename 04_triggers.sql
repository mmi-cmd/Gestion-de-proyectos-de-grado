-- SGTG - Trigger de auditoría de thesis_evaluation

BEGIN;

CREATE TRIGGER trg_auditar_thesis_evaluation
AFTER INSERT OR UPDATE OR DELETE ON academico.thesis_evaluation
FOR EACH ROW EXECUTE FUNCTION academico.fn_auditar_thesis_evaluation();

COMMIT;
