-- WITH RECURSIVE vals AS (VALUES('target area: x=20..30, y=-10..-5')),
WITH RECURSIVE vals AS (VALUES('target area: x=88..125, y=-157..-103')),
target as (
    SELECT ((regexp_split_to_array((regexp_split_to_array((regexp_split_to_array(column1, ','))[1], 'x='))[2], '\.\.'))[1])::int AS xmin,
           ((regexp_split_to_array((regexp_split_to_array((regexp_split_to_array(column1, ','))[1], 'x='))[2], '\.\.'))[2])::int AS xmax,
           ((regexp_split_to_array((regexp_split_to_array((regexp_split_to_array(column1, ','))[2], 'y='))[2], '\.\.'))[2])::int AS ymin,
           ((regexp_split_to_array((regexp_split_to_array((regexp_split_to_array(column1, ','))[2], 'y='))[2], '\.\.'))[1])::int AS ymax
      FROM vals
),
comp as (
    SELECT t.xmin,
           t.xmax,
           t.ymin,
           t.ymax,
           gx.gx as startx,
           gy.gy as starty,
           CASE WHEN gx>0 THEN gx-1 WHEN gx<0 THEN gx+1 ELSE gx END AS gx,
           gy.gy-1 as gy,
           gx AS posx,
           gy as posy,
           CASE WHEN gx>=xmin AND gx<=xmax AND gy<=ymin AND gy>=ymax THEN TRUE ELSE FALSE END AS hit,
           1 as turn
      FROM target t,
           generate_series(0,200) as gx,
           generate_series(-200,200) as gy

UNION ALL

   SELECT xmin,
          xmax,
          ymin,
          ymax,
          startx,
          starty,
          CASE WHEN gx>0 THEN gx-1 WHEN gx<0 THEN gx+1 ELSE gx END,
          gy-1,
          posx+gx,
          posy+gy,
          CASE WHEN posx>=xmin AND posx<=xmax AND posy<=ymin AND posy>=ymax THEN TRUE ELSE FALSE END AS hit,
          turn+1
     FROM comp
    WHERE hit=FALSE
      AND abs(posx)<=abs(xmax)
      AND posy>=ymax
),
res AS (
    SELECT DISTINCT startx,
                    starty
      from comp
     where hit=TRUE
)
SELECT count(*) from res
