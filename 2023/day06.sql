SET WORK_MEM='10GB';
WITH RECURSIVE vals AS (VALUES('Time:        53     91     67     68  53916768
Distance:   250   1330   1081   1025  250133010811025
')),
input AS (
    SELECT regexp_split_to_array((regexp_split_to_array(val, ':'))[2], ' ') as val
          ,row_number() OVER () AS row_id
          
      FROM vals
          ,unnest(string_to_array(column1, '
')) as val
),
pre_races as (
    SELECT v.val::bigint
          ,row_id
          ,row_number() OVER (PARTITION BY row_id ORDER BY ord) AS ord
      FROM input
 LEFT JOIN LATERAL unnest(val) WITH ORDINALITY AS v(val, ord) ON TRUE
     WHERE v.val!=''
),
races as (
    SELECT t.val as timing
          ,d.val as distance
          ,t.ord
      FROM pre_races t
      LEFT JOIN pre_races d ON TRUE
      WHERE t.row_id=1
        AND d.row_id=2
        AND t.ord=d.ord
),
race1 as (
    SELECT 1 as time
          ,(r.timing-1)*1 as ran
          ,r.timing
          ,r.distance
          ,r.ord as race_id
      FROM races r

      UNION ALL

    SELECT r."time"+1
          ,(r."time"+1) * (r.timing - (r."time"+1) )
          ,r.timing
          ,r.distance
          ,race_id
     FROM race1 r
    WHERE r."time"+1 <= r.timing
),
race1_results AS (
    select race_id, count(*) as nbr from race1 where ran>=distance group by 1
),
ex1 AS (
    SELECT race_id
          ,nbr
      FROM race1_results
     WHERE race_id=1

UNION ALL

        SELECT e.race_id+1
          ,r.nbr*e.nbr
      FROM ex1 e
      JOIN race1_results r ON e.race_id+1=r.race_id
)
-- select max(nbr) from ex1
select * from race1_results
