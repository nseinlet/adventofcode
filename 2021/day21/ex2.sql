-- WITH RECURSIVE vals AS (VALUES('Player 1 starting position: 4'),('Player 2 starting position: 8')),
WITH RECURSIVE vals AS (VALUES('Player 1 starting position: 7'),('Player 2 starting position: 8')),
spos AS (
    SELECT ((regexp_split_to_array(column1, ': '))[2])::int as pos,
           row_number() over() as player
      FROM vals
),
dice_roll AS (
    SELECT x+y+z as dice,
           spos as start_position,
           CASE WHEN (spos+x+y+z)>10 THEN spos+x+y+z-10 ELSE spos+x+y+z END as end_position
      FROM generate_series(1, 3) as x,
           generate_series(1, 3) as y,
           generate_series(1, 3) as z,
           generate_series(1, 10) as spos
),
grouped_dice AS (
    SELECT count(*)::numeric as nbr,
           dice,
           start_position,
           end_position
      FROM dice_roll
  GROUP BY 2,3,4
  order by 2,3,4
),
compute AS (
    SELECT pl1.pos as p1,
           pl2.pos as p2,
           0 as s1,
           0 as s2,
           1::numeric as nbr
      FROM spos as pl1,
           spos as pl2
     WHERE pl1.player=1
       AND pl2.player=2

UNION ALL (
    WITH score AS (
        SELECT p1,
               p2,
               s1,
               s2,
               nbr
          FROM compute
         WHERE s1<21
           AND s2<21
     ),
     tmp_score AS (
         SELECT p1,
                p2,
                s1,
                s2,
                sum(nbr)::numeric as nbr
           FROM score
       GROUP BY 1,2,3,4
      ),
     play1 AS (
        SELECT d.end_position as p1,
               s.p2,
               s.s1+d.end_position as s1,
               s.s2,
               s.nbr*d.nbr as nbr
          FROM tmp_score s
          JOIN grouped_dice d ON s.p1=d.start_position
     ),
     play2 AS (
         SELECT p1,
                d.end_position as p2,
                s1,
                s.s2+d.end_position as s2,
                s.nbr*d.nbr as nbr
           FROM play1 s
           JOIN grouped_dice d ON s.p2=d.start_position
          WHERE s.s1<21
     )
     SELECT p1,
            p2,
            s1,
            s2,
            nbr
       FROM play1
      WHERE s1>=21
  UNION ALL
     SELECT p1,
            p2,
            s1,
            s2,
            nbr
       FROM play2

)-- end union all compute
)
SELECT max(win) FROM (
    SELECT sum(nbr) as win FROM compute where s1>=21
    UNION ALL
    SELECT sum(nbr) as win FROM compute where s2>=21
) as e
