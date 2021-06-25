-- FUNCTION: basegeo.distancia_menor(text)

-- DROP FUNCTION basegeo.distancia_menor(text);

CREATE OR REPLACE FUNCTION basegeo.distancia_menor(
	text)
    RETURNS real
    LANGUAGE 'sql'

    COST 100
    VOLATILE 
AS $BODY$SELECT raio_menor FROM basegeo.tbl_tipo_entorno WHERE codigo= $1;$BODY$;

ALTER FUNCTION basegeo.distancia_menor(text)
    OWNER TO postgres;