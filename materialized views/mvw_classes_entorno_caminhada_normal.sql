-- View: basegeo.mvw_classes_entorno_caminhada_normal

-- DROP MATERIALIZED VIEW basegeo.mvw_classes_entorno_caminhada_normal;

CREATE MATERIALIZED VIEW basegeo.mvw_classes_entorno_caminhada_normal
TABLESPACE pg_default
AS
 SELECT buffer_entornos.sigla,
    buffer_entornos.entorno_geom,
    (st_summarystatsagg(st_clip(tbl_raster_classes_100x100.rast, buffer_entornos.entorno_geom, true), 1, false, 1::double precision)).sum AS classe_a,
    (st_summarystatsagg(st_clip(tbl_raster_classes_100x100.rast, buffer_entornos.entorno_geom, true), 2, false, 1::double precision)).sum AS classe_b,
    (st_summarystatsagg(st_clip(tbl_raster_classes_100x100.rast, buffer_entornos.entorno_geom, true), 3, false, 1::double precision)).sum AS classe_c,
    (st_summarystatsagg(st_clip(tbl_raster_classes_100x100.rast, buffer_entornos.entorno_geom, true), 4, false, 1::double precision)).sum AS classe_d,
    (st_summarystatsagg(st_clip(tbl_raster_classes_100x100.rast, buffer_entornos.entorno_geom, true), 5, false, 1::double precision)).sum AS classe_e
   FROM basegeo.tbl_raster_classes_100x100,
    ( SELECT tbl_estacoes.sigla,
            st_buffer(tbl_estacoes.the_geom, basegeo.distancia('MIN'::text)::double precision) AS entorno_geom
           FROM basegeo.tbl_estacoes) buffer_entornos
  WHERE st_intersects(buffer_entornos.entorno_geom, tbl_raster_classes_100x100.rast)
  GROUP BY buffer_entornos.sigla, buffer_entornos.entorno_geom
WITH DATA;

ALTER TABLE basegeo.mvw_classes_entorno_caminhada_normal
    OWNER TO postgres;