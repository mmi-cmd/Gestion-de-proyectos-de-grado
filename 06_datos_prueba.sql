-- SGTG - Datos de prueba (opcional)

BEGIN;

INSERT INTO academico.type_of_document VALUES ('CC', 'Cédula de ciudadanía'), ('TI', 'Tarjeta de identidad');
INSERT INTO academico.academy_program  VALUES ('ISI', 'Ingeniería de Sistemas', 'Ingenierías', 160);
INSERT INTO academico.line_of_research VALUES ('L01', 'Ingeniería de software'), ('L02', 'Bases de datos');
INSERT INTO academico.evaluation_criterion VALUES ('C01', 'Pertinencia del tema', 'Metodológico'),
                                                  ('C02', 'Rigor científico',    'Científico');

INSERT INTO academico.support_teacher VALUES ('D0001', '1090000001', 'Ana', NULL, 'Rojas', NULL, 'ana@ufpso.edu.co', '3001112233', 'Bases de datos');
INSERT INTO academico.jury VALUES ('J0001', '1090000002', 'Luis', NULL, 'Pérez',  NULL, 'luis@ufpso.edu.co'),
                                  ('J0002', '1090000003', 'Marta', NULL, 'Gómez', NULL, 'marta@ufpso.edu.co');

INSERT INTO academico.student VALUES
 ('ISI', '0192390', '1090000010', 'Geraldine', NULL, 'García', 'Torrado', 'geraldine@ufpso.edu.co', '3001234567', 140, 'CC'),
 ('ISI', '0192354', '1090000011', 'Michell',   NULL, 'Pérez',  'Gómez',   'michell@ufpso.edu.co',   '3001234568', 135, 'CC');

INSERT INTO academico.proposal VALUES ('P0001', 'L02', 'Sistema de gestión de trabajos de grado', 'Resumen de prueba', CURRENT_DATE, 'bases de datos, grado', 'propuesta_p0001.pdf');
INSERT INTO academico.students_proposal VALUES ('ISI', '0192390', 'P0001'), ('ISI', '0192354', 'P0001');
INSERT INTO academico.proposal_role VALUES ('D0001', 'P0001', CURRENT_DATE, 'Director', 'A');
INSERT INTO academico.proposal_evaluation VALUES ('P0001', CURRENT_DATE, 'A', 'A', 'A', 'A', 'A', 'A', 'S', 'A');

INSERT INTO academico.proyect_plan VALUES ('PL001', CURRENT_DATE, 'plan_pl001.pdf', 'P0001');
INSERT INTO academico.jury_assignment VALUES ('J0001', 'Metodológico', 'PL001', CURRENT_DATE, 'A'),
                                             ('J0002', 'Científico',   'PL001', CURRENT_DATE, 'A');
INSERT INTO academico.proyect_plan_evaluation VALUES ('PL001', CURRENT_DATE, 'A');
INSERT INTO academico.proyect_plan_evaluation_detail VALUES ('C01', CURRENT_DATE, 'PL001', 'Cumple', NULL),
                                                            ('C02', CURRENT_DATE, 'PL001', 'Cumple', 'Sin observaciones');

INSERT INTO academico.thesis VALUES ('T000000001', CURRENT_DATE, CURRENT_DATE + 30, 'tesis_t1.pdf', 'PL001');
INSERT INTO academico.thesis_evaluation VALUES ('T000000001', CURRENT_DATE + 30, 4.50, 'A', 'Buen trabajo');

COMMIT;

-- Para borrar los datos de prueba:
-- BEGIN;
-- DELETE FROM academico.thesis_evaluation;
-- DELETE FROM academico.thesis;
-- DELETE FROM academico.proyect_plan_evaluation_detail;
-- DELETE FROM academico.proyect_plan_evaluation;
-- DELETE FROM academico.jury_assignment;
-- DELETE FROM academico.proyect_plan;
-- DELETE FROM academico.proposal_evaluation;
-- DELETE FROM academico.proposal_role;
-- DELETE FROM academico.students_proposal;
-- DELETE FROM academico.proposal;
-- DELETE FROM academico.student;
-- DELETE FROM academico.jury;
-- DELETE FROM academico.support_teacher;
-- DELETE FROM academico.evaluation_criterion;
-- DELETE FROM academico.line_of_research;
-- DELETE FROM academico.academy_program;
-- DELETE FROM academico.type_of_document;
-- COMMIT;
