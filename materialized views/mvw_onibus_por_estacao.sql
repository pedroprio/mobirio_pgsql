-- View: basegeo.mvw_onibus_por_estacao

-- DROP MATERIALIZED VIEW basegeo.mvw_onibus_por_estacao;

CREATE MATERIALIZED VIEW basegeo.mvw_onibus_por_estacao
TABLESPACE pg_default
AS
 SELECT a.fid AS linha_fid,
    b.sigla AS estacao_sobreposta,
    b.ramal_principal,
    b.km AS km_estacao
   FROM basegeo.tbl_linhas_onibus a,
    basegeo.tbl_estacoes b
  WHERE st_intersects(a.the_geom, st_buffer(b.the_geom, basegeo.distancia('TOD'::text)::double precision)) AND b.status_ativo = 1 AND b.operador::text = 'SUPERVIA'::text
  ORDER BY a.fid, b.ramal_principal, b.km
WITH DATA;

ALTER TABLE basegeo.mvw_onibus_por_estacao
    OWNER TO postgres;