--WITH vals AS (VALUES('939'),('7,13,x,x,59,x,31,19')),
WITH vals AS (VALUES('1002632'),('23,x,x,x,x,x,x,x,x,x,x,x,x,41,x,x,x,x,x,x,x,x,x,829,x,x,x,x,x,x,x,x,x,x,x,x,13,17,x,x,x,x,x,x,x,x,x,x,x,x,x,x,29,x,677,x,x,x,x,x,37,x,x,x,x,x,x,x,x,x,x,x,x,19')),
"values" AS (
    SELECT column1,
           row_number() over() as id
      FROM vals
),
departure AS (
    SELECT column1::int as departure
      FROM "values"
     where id=1
),
bus AS (
    SELECT unnest(regexp_split_to_array(column1::varchar,',')) as id
      FROM "values"
     WHERE id=2
),
next_departures AS (
SELECT departure.departure-(departure.departure%bus.id::int)+bus.id::int as next_departure,
       bus.id::int,
       departure.departure
from bus,departure
WHERE id!='x'
)
  select (next_departure-departure)*id,
  next_departure,
  id
    FROM next_departures
ORDER BY next_departure ASC
   LIMIT 1
