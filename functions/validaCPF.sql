-- FUNCTION: basegeo.valida_cpf(bigint)

-- DROP FUNCTION basegeo.valida_cpf(bigint);

CREATE OR REPLACE FUNCTION basegeo.valida_cpf(
	cod_cpf bigint)
    RETURNS boolean
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
AS $BODY$
    DECLARE
        valido boolean := false;
        cpf text;
        cont integer;
        b integer;
         
    BEGIN
        b:=0;
        cont:=11;
        IF(cod_cpf = 11111111111 OR
           cod_cpf = 22222222222 OR
           cod_cpf = 33333333333 OR
           cod_cpf = 44444444444 OR
           cod_cpf = 55555555555 OR
            cod_cpf = 66666666666 OR
           cod_cpf = 77777777777 OR
           cod_cpf = 88888888888 OR
           cod_cpf = 99999999999) THEN
            RETURN valido;
        END IF;
        cpf := CAST(cod_cpf AS TEXT);
         WHILE (length(cpf) < 11) LOOP
                cpf := '0'||cpf;
        END LOOP;

        FOR i IN 1..9 LOOP
            cont := cont - 1;
            b := b + (CAST(substr(cpf,i,1) AS INT) * cont);
         END LOOP;

        IF((b % 11) < 2) THEN
            IF(((b % 11) < 2) AND CAST(substr(cpf,10,1) AS INT) <> 0) THEN        
                RETURN valido;
            ELSE
                valido :=true;
                 RETURN valido;
            END IF;
        ELSE
            IF((11-(b % 11)) <> CAST(substr(cpf,10,1) AS INT)) THEN
                RETURN valido;
            ELSE
                valido:=true;
                 RETURN valido;
            END IF;
        END IF;

        b:=0;
        cont:=11;
        FOR i IN 1..10 LOOP            
            b := b + (CAST(substr(cpf,i,1) AS INT) * cont);
             cont := cont - 1;
        END LOOP;

        IF((b % 11) < 2) THEN
            IF(((b % 11) < 2) AND CAST(substr(cpf,11,1) AS INT) <> 0) THEN        
                RETURN valido;
             ELSE
                valido :=true;
                RETURN valido;
            END IF;
        ELSE
            IF((11-(b % 11)) <> CAST(substr(cpf,11,1) AS INT)) THEN
                RETURN valido;
             ELSE
                valido:=true;
                RETURN valido;
            END IF;
        END IF;
    END
$BODY$;

ALTER FUNCTION basegeo.valida_cpf(bigint)
    OWNER TO postgres;