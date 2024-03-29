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
          ,abs((match[1])::int-(match[3])::int)+abs((match[2])::int-(match[4])::int) AS dist
          ,id
      FROM input
          ,regexp_matches(val, 'Sensor at x=(-{0,1}\d+), y=(-{0,1}\d+): closest beacon is at x=(-{0,1}\d+), y=(-{0,1}\d+)') as match
),
lines AS (
    SELECT id
          ,-dist+abs(ys-2000000)+xs as c1
          ,dist-abs(ys-2000000)+xs as c2
      FROM sensors
)
select abs(max(greatest(c1,c2))-min(least(c1,c2)))
  from lines