# SGTG - Scripts de la base de datos

Esquema `academico`. 


| Archivo | Contenido |
|---|---|
| `00_esquema.sql` | Esquema |
| `01_tablas/01` a `06` | Nivel 0, sin dependencias: type_of_document, academy_program, line_of_research, evaluation_criterion, support_teacher, jury |
| `01_tablas/07` a `08` | Nivel 1: student, proposal |
| `01_tablas/09` a `12` | Nivel 2: students_proposal, proposal_role, proposal_evaluation, proyect_plan |
| `01_tablas/13` a `15` | Nivel 3: proyect_plan_evaluation, jury_assignment, thesis |
| `01_tablas/16` a `17` | Nivel 4: proyect_plan_evaluation_detail, thesis_evaluation |
| `02_tablas_auditoria.sql` | Tabla de auditoría de thesis_evaluation |
| `03_funciones.sql` | Función de auditoría |
| `04_triggers.sql` | Trigger de auditoría |
| `05_roles_permisos.sql` | Roles con permisos de edición de datos |
| `05b_roles_administradores.sql` | Roles administradores (alternativa a 05) |
| `06_datos_prueba.sql` | Datos de ejemplo |
| `99_reiniciar_esquema.sql` | Borra el esquema (comentado) |
| `instalar_todo.sql` | 00 a 04 en una transacción |

## Auditoría

Solo se audita `thesis_evaluation`: guarda usuario, fecha y hora, operación (I/U/D) y los valores anterior y nuevo de grade, result y comments. Es la tabla con la decisión final del proceso (la nota de sustentación define si el trabajo se aprueba) y responde a los requisitos 13 y 17 del documento. 
