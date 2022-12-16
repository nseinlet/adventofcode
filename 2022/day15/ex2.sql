WITH RECURSIVE vals AS(VALUES('Sensor at x=2483411, y=3902983: closest beacon is at x=2289579, y=3633785
Sensor at x=3429446, y=303715: closest beacon is at x=2876111, y=-261280
Sensor at x=666423, y=3063763: closest beacon is at x=2264411, y=2779977
Sensor at x=3021606, y=145606: closest beacon is at x=2876111, y=-261280
Sensor at x=2707326, y=2596893: closest beacon is at x=2264411, y=2779977
Sensor at x=3103704, y=1560342: closest beacon is at x=2551409, y=2000000
Sensor at x=3497040, y=3018067: closest beacon is at x=3565168, y=2949938
Sensor at x=1708530, y=855013: closest beacon is at x=2551409, y=2000000
Sensor at x=3107437, y=3263465: closest beacon is at x=3404814, y=3120160
Sensor at x=2155249, y=2476196: closest beacon is at x=2264411, y=2779977
Sensor at x=3447897, y=3070850: closest beacon is at x=3404814, y=3120160
Sensor at x=2643048, y=3390796: closest beacon is at x=2289579, y=3633785
Sensor at x=3533132, y=3679388: closest beacon is at x=3404814, y=3120160
Sensor at x=3683790, y=3017900: closest beacon is at x=3565168, y=2949938
Sensor at x=1943208, y=3830506: closest beacon is at x=2289579, y=3633785
Sensor at x=3940100, y=3979653: closest beacon is at x=2846628, y=4143786
Sensor at x=3789719, y=1225738: closest beacon is at x=4072555, y=1179859
Sensor at x=3939775, y=578381: closest beacon is at x=4072555, y=1179859
Sensor at x=3880152, y=3327397: closest beacon is at x=3404814, y=3120160
Sensor at x=3280639, y=2446475: closest beacon is at x=3565168, y=2949938
Sensor at x=2348869, y=2240374: closest beacon is at x=2551409, y=2000000
Sensor at x=3727441, y=2797456: closest beacon is at x=3565168, y=2949938
Sensor at x=3973153, y=2034945: closest beacon is at x=4072555, y=1179859
Sensor at x=38670, y=785556: closest beacon is at x=311084, y=-402911
Sensor at x=3181909, y=2862960: closest beacon is at x=3565168, y=2949938
Sensor at x=3099490, y=3946226: closest beacon is at x=2846628, y=4143786')),
input AS (
    SELECT val,
          row_number() OVER () AS id
      FROM vals
          ,unnest(string_to_array(column1, '
')) as val
),
sensors AS (
    SELECT (match[1])::int AS xs
          ,(match[2])::int AS ys
          ,(match[3])::int AS xb
          ,(match[4])::int AS yb
          ,abs((match[1])::int-(match[3])::int)+abs((match[2])::int-(match[4])::int)+1 AS dist
          ,id
      FROM input
          ,regexp_matches(val, 'Sensor at x=(-{0,1}\d+), y=(-{0,1}\d+): closest beacon is at x=(-{0,1}\d+), y=(-{0,1}\d+)') as match
),
borders AS (
    SELECT id
          ,xs
          ,ys
          ,dist
          ,xs-dist as x1
          ,xs+dist as x2
          ,ys-dist as y2
          ,ys+dist as y1
      FROM sensors
),
--         xs,y1
--          /^\
--     b1  /   \  b2
--        /     \
-- x1,ys | xs,ys | x2,ys
--        \     /
--     b4  \   /  b3
--          \_/
--         xs,y2
--
-- b1 : y=x-x1+ys
-- b2 : y=-x+x2+ys
-- b1xb2: x-x1+ys=-x+x2+ys
--        x = (b2.x2+b2.ys+b1.x1-b1.ys) / 2
--        y = (b2.x2+b2.ys+b1.x1-b1.ys) / 2 -b1.x1+b1.ys
-- b3 : y=x-xs+y2
-- b2xb3: -x+x2+ys=x-xs+y2
--        x = (b3.xs-b3.y2+b2.x2+b2.ys) / 2
--        y = (b3.xs-b3.y2+b2.x2+b2.ys) / 2+b3.xs+b3.y2
-- b4 : y=-x+x1+ys
-- b1xb4: x-x1+ys=-x+x1+ys
--        x = (b4.x1+b4.ys+b1.x1-b1.ys) / 2
--        y = (b4.x1+b4.ys+b1.x1-b1.ys) / 2 -b1.x1+b1.ys
-- b3xb4: x-xs+y2=-x+x1+ys
--        x = (b4.x1+b4.ys+b3.xs-b3.y2) / 2
--        y = (b4.x1+b4.ys+b3.xs-b3.y2) / 2 -b3.xs+b3.y2
crossing AS ( --b1xb2
    SELECT (b2.x2+b2.ys+b1.x1-b1.ys) / 2 as x
          ,(b2.x2+b2.ys+b1.x1-b1.ys) / 2 -b1.x1+b1.ys as y
      FROM borders b1
      LEFT JOIN borders b2 ON b1.id!=b2.id
UNION --b2xb3
    SELECT (b3.xs-b3.y2+b2.x2+b2.ys) / 2
          ,(b3.xs-b3.y2+b2.x2+b2.ys) / 2 +b3.xs+b3.y2
      FROM borders b2
      LEFT JOIN borders b3 ON b2.id!=b3.id
UNION --b1xb4
    SELECT (b4.x1+b4.ys+b1.x1-b1.ys) / 2
          ,(b4.x1+b4.ys+b1.x1-b1.ys) / 2 -b1.x1+b1.ys
      FROM borders b1
      LEFT JOIN borders b4 ON b1.id!=b4.id
UNION --b3xb4
    SELECT (b4.x1+b4.ys+b3.xs-b3.y2) / 2
          ,(b4.x1+b4.ys+b3.xs-b3.y2) / 2 -b3.xs+b3.y2
      FROM borders b3
      LEFT JOIN borders b4 ON b3.id!=b4.id
)
select x::numeric*4000000+y::numeric
  from crossing c
  WHERE NOT EXISTS (
    SELECT 1
      FROM sensors s
      WHERE (abs(xs-c.x)+abs(ys-c.y))<dist
  )
and x>0 and x<4000000 and y>0 and y<4000000

