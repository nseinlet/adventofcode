begin;

WITH vals AS (VALUES('13,0,10,12,1,5,8')),
starting_numbers AS (
    SELECT regexp_split_to_table(column1,',') as data
      FROM vals
)
SELECT data as num,
       row_number() over() as order
  INTO TEMPORARY TABLE starting_numbers
  FROM starting_numbers;

WITH RECURSIVE vals_array AS (
    SELECT jsonb_build_object(num::varchar , "order") as d,
           jsonb_build_object('-1' , 0) as d0,
           jsonb_build_object(num::varchar , 1) as occ,
           "order"::int as o
      FROM starting_numbers
     WHERE "order"=1

     UNION

    SELECT jsonb_build_object(num::varchar , "order") || v.d,
           jsonb_build_object('-1' , 0) as d0,
           jsonb_build_object(num::varchar , 1) || v.occ,
           n."order"::int
      FROM starting_numbers n
      JOIN vals_array v ON v.o+1=n."order"
)

SELECT * INTO TEMPORARY TABLE vals_array FROM vals_array order by o desc limit 1;


WITH RECURSIVE counting AS (
    SELECT d,
           d0,
           o,
           s.num::varchar as last_num
      FROM vals_array v
      JOIN starting_numbers s ON s."order"=o

     UNION ALL

    SELECT d || jsonb_build_object(CASE WHEN d0?last_num THEN (o-(d0->>last_num)::int)::varchar ELSE '0' END, o+1),
           d,
           o+1,
           CASE WHEN d0?last_num THEN (o-(d0->>last_num)::int)::varchar ELSE '0' END
      FROM counting
     WHERE o<2020

)
-- SELECT * FROM counting order by o desc limit 3;
SELECT last_num FROM counting order by o desc limit 1;

rollback;
