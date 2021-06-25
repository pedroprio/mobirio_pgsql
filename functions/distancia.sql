-- FUNCTION: basegeo.distancia(text)

-- DROP FUNCTION basegeo.distancia(text);

CREATE OR REPLACE FUNCTION basegeo.distancia(
	text)
    RETURNS real
    LANGUAGE 'sql'

    COST 100
    VOLATILE 
AS $BODY$SELECT raio_maior FROM basegeo.tbl_tipo_entorno WHERE codigo= $1;$BODY$;

ALTER FUNCTION basegeo.distancia(text)
    OWNER TO postgres;
