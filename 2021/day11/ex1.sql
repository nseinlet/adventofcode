WITH RECURSIVE vals AS (VALUES('2682551651'),('3223134263'),('5848471412'),('7438334862'),('8731321573'),('6415233574'),('5564726843'),('6683456445'),('8582346112'),('4617588236')),
input AS (
    SELECT regexp_split_to_table(column1, '') as data,
           row_number() over() as row
      FROM vals
),
compute AS (
    SELECT data::bigint,
           row,
           row_number() over(PARTITION BY row) as col,
           0 as turn,
           0::bigint as flashes
      FROM input

UNION ALL

    ( WITH RECURSIVE compute_flash AS (
        --check who flash and propagate to neighbors
        -- start by increasing the values by 1
        SELECT data+1 as data,
               row,
               col,
               turn+1 as turn,
               0 as turn2,
               flashes,
               FALSE as turn_flashes
          FROM compute

         UNION ALL
         --check who reach flashing level
         --we cannot use twice the recursive term in SELECT
         --then put it in mem
         (WITH tmp AS (
           SELECT data,
                  row,
                  col,
                  turn,
                  turn2+1 as turn2,
                  flashes,
                  CASE WHEN data>9 THEN TRUE ELSE turn_flashes END as turn_flash
             FROM compute_flash cf
          )
          -- use tmp stored data and use it twice in the same select
          -- check who flashes
          SELECT CASE
                   WHEN data>9 THEN 0
                   WHEN turn_flash THEN 0
                   -- add light from adjacents
                   ELSE data+i2.f
                 END as data,
                 row,
                 col,
                 turn,
                 turn2,
                 flashes,
                 turn_flash
            FROM tmp
    JOIN LATERAL (SELECT count(*) as f
                    FROM tmp t2
                   WHERE t2.col>=tmp.col-1 AND t2.col<=tmp.col+1
                     AND t2.row>=tmp.row-1 AND t2.row<=tmp.row+1
                     AND (t2.row!=tmp.row OR tmp.col!=t2.col)
                     AND data>9
                 ) as i2 ON TRUE
          WHERE EXISTS (SELECT 1 FROM tmp WHERE data>9)
                OR turn2<=1
       )
      )

      SELECT data,
             row,
             col,
             turn,
             compute_flash.flashes+coalesce(if.flashes,0)
        FROM compute_flash
LEFT JOIN LATERAL (SELECT turn2 as t2,count(*) as flashes FROM compute_flash WHERE turn_flashes GROUP BY 1 ORDER BY 1 DESC limit 1) as if ON TRUE
          WHERE turn<=100
          ORDER BY turn2 DESC,
                   row,
                   col
          FETCH FIRST 100 ROW ONLY
    )
)
SELECT flashes FROM compute WHERE turn=100 FETCH FIRST ROW ONLY
