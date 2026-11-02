-- SGTG - Roles con permisos de edición de datos (ejecutar como postgres)
-- Editar la lista 'miembros' (nombre y clave) antes de ejecutar; no subir las claves a GitHub
-- Las tablas *_auditoria quedan de solo lectura
-- Las tablas que se creen después con este mismo usuario reciben los permisos automáticamente
-- Conexión Supabase: Session pooler, usuario <rol>.<project-ref>

BEGIN;

DO $$
DECLARE
    miembros TEXT[][] := ARRAY[
        ['geraldine', 'CAMBIAR_CLAVE_1'],
        ['michell',   'CAMBIAR_CLAVE_2'],
        ['jose',      'CAMBIAR_CLAVE_3']
    ];
    i INTEGER;
    rol TEXT;
    clave TEXT;
BEGIN
    FOR i IN 1 .. array_length(miembros, 1) LOOP
        rol   := miembros[i][1];
        clave := miembros[i][2];

        IF clave LIKE 'CAMBIAR%' THEN
            RAISE EXCEPTION 'Cambia la clave de "%" antes de ejecutar este script', rol;
        END IF;

        IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = rol) THEN
            EXECUTE format('CREATE ROLE %I LOGIN PASSWORD %L', rol, clave);
        END IF;

        EXECUTE format('ALTER ROLE %I IN DATABASE %I SET search_path = academico, public', rol, current_database());
        EXECUTE format('ALTER ROLE %I IN DATABASE %I RESET role', rol, current_database());
        EXECUTE format('GRANT USAGE ON SCHEMA academico TO %I', rol);
        EXECUTE format('GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA academico TO %I', rol);
        EXECUTE format('ALTER DEFAULT PRIVILEGES IN SCHEMA academico GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO %I', rol);
    END LOOP;
END
$$;

DO $$
DECLARE
    t RECORD;
    r RECORD;
BEGIN
    FOR t IN SELECT tablename FROM pg_tables
             WHERE schemaname = 'academico' AND tablename LIKE '%\_auditoria' LOOP
        FOR r IN SELECT rolname FROM pg_roles WHERE rolname IN ('geraldine', 'michell', 'jose') LOOP
            EXECUTE format('REVOKE INSERT, UPDATE, DELETE, TRUNCATE ON academico.%I FROM %I', t.tablename, r.rolname);
        END LOOP;
    END LOOP;
END
$$;

COMMIT;
