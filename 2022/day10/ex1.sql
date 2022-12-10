WITH RECURSIVE vals AS(VALUES('addx 1
addx 5
addx -1
addx 20
addx -14
addx -1
addx 5
addx 13
addx -12
addx 3
addx 3
addx 3
addx 1
addx 4
noop
noop
addx 1
noop
noop
addx 4
noop
addx -35
addx 11
addx -1
addx -7
addx 5
addx 2
addx 3
addx -2
addx 2
addx 5
addx 5
noop
noop
addx -2
addx 2
noop
addx 3
addx 2
addx 7
noop
noop
addx 3
addx -2
addx -36
noop
addx 25
addx -22
addx 7
noop
addx -2
noop
noop
noop
addx 5
addx 5
addx 4
noop
addx -2
addx 5
addx -4
addx 5
addx 4
noop
addx -29
addx 32
addx -23
addx -12
noop
addx 7
noop
addx -2
addx 4
addx 3
addx 20
addx 3
addx -20
addx 5
addx 16
addx -15
addx 6
noop
noop
noop
addx 5
noop
addx 5
noop
noop
noop
addx -37
addx 2
addx -2
addx 7
noop
addx -2
addx 5
addx 2
addx 3
addx -2
addx 2
addx 5
addx 2
addx -6
addx -15
addx 24
addx 2
noop
addx 3
addx -8
addx 15
addx -14
addx 15
addx -38
noop
noop
addx 21
addx -14
addx 1
addx 5
noop
addx -2
addx 7
addx -1
addx 5
noop
addx 2
addx 3
addx 3
addx -2
addx 4
addx 2
addx -17
addx 20
noop
noop
noop
noop')),
input AS (
    SELECT unnest(string_to_array(column1, '
')) as val
      FROM vals
),
turns AS (
    SELECT (string_to_array(val,' '))[1] as op
          ,((string_to_array(val,' '))[2])::int as x
          ,case (string_to_array(val,' '))[1] WHEN 'noop'then 1 else 2 end as cycle
          ,row_number() OVER () as turn_id
      FROM input
),
cycles AS (
      select op
            ,x
            ,sum(cycle) OVER (ORDER BY turn_id) as cycle
            ,turn_id
        FROM turns
),
checkpoints AS (
SELECT 1+sum(x) as v,20 as t FROM cycles WHERE cycle<20
UNION ALL
SELECT 1+sum(x) as v,60 as t FROM cycles WHERE cycle<60
UNION ALL
SELECT 1+sum(x) as v,100 as t FROM cycles WHERE cycle<100
UNION ALL
SELECT 1+sum(x) as v,140 as t FROM cycles WHERE cycle<140
UNION ALL
SELECT 1+sum(x) as v,180 as t FROM cycles WHERE cycle<180
UNION ALL
SELECT 1+sum(x) as v,220 as t FROM cycles WHERE cycle<220
)
SELECT sum(v*t) FROM checkpoints