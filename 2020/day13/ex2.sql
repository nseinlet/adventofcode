begin;
--WITH vals AS (VALUES('939'),('7,13,x,x,59,x,31,19')),
-- WITH vals AS (VALUES('939'),('17,x,13,19')),
-- WITH vals AS (VALUES('939'),('67,7,59,61')),
-- WITH vals AS (VALUES('939'),('1789,37,47,1889')),
WITH vals AS (VALUES('1002632'),('23,x,x,x,x,x,x,x,x,x,x,x,x,41,x,x,x,x,x,x,x,x,x,829,x,x,x,x,x,x,x,x,x,x,x,x,13,17,x,x,x,x,x,x,x,x,x,x,x,x,x,x,29,x,677,x,x,x,x,x,37,x,x,x,x,x,x,x,x,x,x,x,x,19')),
"values" AS (
    SELECT column1,
           row_number() over() as id
      FROM vals
),
all_bus AS (
    SELECT unnest(regexp_split_to_array(column1::varchar,',')) as id
      FROM "values"
     WHERE id=2
),
bus AS(
    SELECT id,
           (row_number() over())::int-1 as delay
      FROM all_bus
)
SELECT id::bigint,
       delay
      INTO TEMPORARY TABLE bus
  FROM bus
 WHERE id!='x';

WITH RECURSIVE prod AS (
    SELECT min(id) as prod,
           min(id) as last_id
      FROM bus

     UNION

     SELECT b.id*p.prod,
            b.id
       FROM prod p
       JOIN LATERAL (SELECT min(id) as id FROM bus bb WHERE bb.id>p.last_id) as b ON TRUE
)
SELECT MAX(prod) AS prod
  INTO TEMPORARY TABLE chinese_lemme_prod
  FROM prod;

WITH RECURSIVE euclidian_chinese_lemme AS (
    SELECT (bus.id::int-bus.delay) ai,
           bus.id n_i,
           chinese_lemme_prod.prod/bus.id as Mi,
           chinese_lemme_prod.prod/bus.id as a,
           bus.id as b,
           0::bigint as x0,
           1::bigint as x1
      FROM bus, chinese_lemme_prod

 UNION ALL

    SELECT ai,
           n_i,
           Mi,
           b,
           a%b,
           x1 - (a/b) * x0,
           x0
      FROM euclidian_chinese_lemme
     WHERE b > 0

),
chinese_lemme as (
    SELECT ai,
           Mi,
           CASE WHEN x1<0 THEN x1+n_i ELSE x1 END as yi
      FROM euclidian_chinese_lemme
     WHERE b = 0
),
chinese_sum AS (
    SELECT sum(ai*Mi*yi) as lemme
      FROM chinese_lemme
)
SELECT lemme%prod FROM chinese_sum,chinese_lemme_prod;

rollback;
