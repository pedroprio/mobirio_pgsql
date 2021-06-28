-- View: basegeo.mvw_onibus_concorrencia_trem

-- DROP MATERIALIZED VIEW basegeo.mvw_onibus_concorrencia_trem;

CREATE MATERIALIZED VIEW basegeo.mvw_onibus_concorrencia_trem
TABLESPACE pg_default
AS
 SELECT tbl_linhas_onibus.fid,
    tbl_linhas_onibus.the_geom,
    tbl_linhas_onibus.numero,
    tbl_linhas_onibus.vista,
    tbl_linhas_onibus.sentido,
    tbl_linhas_onibus.municipio,
    st_length(tbl_linhas_onibus.the_geom) / 1000::double precision AS extensao_km,
    st_length(st_intersection(tbl_linhas_onibus.the_geom, st_buffer(( SELECT st_union(tbl_rede_transportes.the_geom) AS st_union
           FROM basegeo.tbl_rede_transportes
          WHERE tbl_rede_transportes.sistema::text = 'SuperVia'::text AND tbl_rede_transportes.status_ati = 1), basegeo.distancia('TOD'::text)::double precision))) / st_length(tbl_linhas_onibus.the_geom) AS sobreposicao_trem
   FROM basegeo.tbl_linhas_onibus
WITH DATA;

ALTER TABLE basegeo.mvw_onibus_concorrencia_trem
    OWNER TO postgres;