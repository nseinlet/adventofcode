WITH vals AS (VALUES('target area: x=88..125, y=-157..-103')),
target as (
    SELECT ((regexp_split_to_array((regexp_split_to_array((regexp_split_to_array(column1, ','))[1], 'x='))[2], '\.\.'))[1])::int AS xmin,
           ((regexp_split_to_array((regexp_split_to_array((regexp_split_to_array(column1, ','))[1], 'x='))[2], '\.\.'))[2])::int AS xmax,
           ((regexp_split_to_array((regexp_split_to_array((regexp_split_to_array(column1, ','))[2], 'y='))[2], '\.\.'))[2])::int AS ymin,
           ((regexp_split_to_array((regexp_split_to_array((regexp_split_to_array(column1, ','))[2], 'y='))[2], '\.\.'))[1])::int AS ymax
      FROM vals
),
comp_y AS (
    SELECT max(gy.gy) as y
      FROM generate_series(0,200) as gy,
           generate_series(0,20) as f, --fire
           target t
     WHERE (((gy.gy+f.f)*((gy.gy+f.f)-1)/2) - (gy.gy*(gy.gy-1)/2)) *-1 <= t.ymin
       AND (((gy.gy+f.f)*((gy.gy+f.f)-1)/2) - (gy.gy*(gy.gy-1)/2)) *-1 >= t.ymax

)
SELECT y*(y-1)/2 FROM comp_y
