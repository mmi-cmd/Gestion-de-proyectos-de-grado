-- SGTG - Todos los integrantes como administradores (alternativa a 05; ejecutar como postgres)
-- Editar la lista 'miembros' (nombre y clave) antes de ejecutar; no subir las claves a GitHub
-- sgtg_admin es el dueño del esquema; cada integrante es miembro y actúa como sgtg_admin al conectarse
-- Si algo no deja modificar: SET ROLE sgtg_admin;
-- Conexión Supabase: Session pooler, usuario <rol>.<project-ref>

BEGIN;

DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'sgtg_admin') THEN
        CREATE ROLE sgtg_admin NOLOGIN;
    END IF;
END
$$;

GRANT sgtg_admin TO CURRENT_USER;

ALTER SCHEMA academico OWNER TO sgtg_admin;

DO $$
DECLARE
    o RECORD;
BEGIN
    FOR o IN SELECT tablename AS nombre FROM pg_tables WHERE schemaname = 'academico' LOOP
        EXECUTE format('ALTER TABLE academico.%I OWNER TO sgtg_admin', o.nombre);
    END LOOP;

    FOR o IN SELECT p.oid::regprocedure::text AS firma
             FROM pg_proc p JOIN pg_namespace n ON n.oid = p.pronamespace
             WHERE n.nspname = 'academico' LOOP
        EXECUTE format('ALTER FUNCTION %s OWNER TO sgtg_admin', o.firma);
    END LOOP;
END
$$;

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

        IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = rol) THEN
            IF clave LIKE 'CAMBIAR%' THEN
                RAISE EXCEPTION 'Cambia la clave de "%" antes de ejecutar este script', rol;
            END IF;
            EXECUTE format('CREATE ROLE %I LOGIN PASSWORD %L', rol, clave);
        END IF;

        EXECUTE format('GRANT sgtg_admin TO %I', rol);
        EXECUTE format('ALTER ROLE %I IN DATABASE %I SET search_path = academico, public', rol, current_database());
        EXECUTE format('ALTER ROLE %I IN DATABASE %I SET role = sgtg_admin', rol, current_database());
    END LOOP;
END
$$;

COMMIT;
