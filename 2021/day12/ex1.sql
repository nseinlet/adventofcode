WITH RECURSIVE vals AS (VALUES('hl-WP'),('vl-fo'),('vl-WW'),('WP-start'),('vl-QW'),('fo-wy'),('WW-dz'),('dz-hl'),('fo-end'),('VH-fo'),('ps-vl'),('FN-dz'),('WP-ps'),('ps-start'),('WW-hl'),('end-QW'),('start-vl'),('WP-fo'),('end-FN'),('hl-QW'),('WP-dz'),('QW-fo'),('QW-dz'),('ps-dz')),
half_ways AS (
    SELECT column1 as p,
           (regexp_split_to_array(column1, '-'))[1] as sp, --start point
           CASE
             WHEN (regexp_split_to_array(column1, '-'))[1]=UPPER((regexp_split_to_array(column1, '-'))[1]) THEN TRUE
             ELSE FALSE
           END as spb,
           (regexp_split_to_array(column1, '-'))[2] as ep, -- end point
           CASE
             WHEN (regexp_split_to_array(column1, '-'))[2]=UPPER((regexp_split_to_array(column1, '-'))[2]) THEN TRUE
             ELSE FALSE
           END as epb
      FROM vals
),
ways AS (
    SELECT sp,
           spb,
           ep,
           epb
      FROM half_ways
     UNION
    SELECT ep,
           epb,
           sp,
           spb
      FROM half_ways
     WHERE sp!='start' AND ep!='end'
),
compute_ways AS (
    SELECT sp || ',' || ep as awp,
           CASE
             WHEN ep=LOWER(ep) THEN ARRAY['start', ep]
             ELSE ARRAY['start']
           END as wp,
           ep as last_ep
      FROM ways
     WHERE sp='start'

UNION ALL

    SELECT cw.awp || ',' || w.ep,
           CASE w.epb
              WHEN TRUE THEN cw.wp
              ELSE cw.wp || w.ep
           END,
           w.ep
      FROM compute_ways cw
      JOIN ways w ON w.sp=cw.last_ep
     WHERE w.epb=TRUE
        OR array_position(cw.wp, w.ep) IS NULL
)
SELECT count(*)
FROM compute_ways cw
WHERE last_ep='end'
