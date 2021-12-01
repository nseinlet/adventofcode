-- WITH RECURSIVE vals AS(VALUES('5764801'),('17807724')),
WITH RECURSIVE vals AS(VALUES('19241437'),('17346587')),
pk AS (
    SELECT column1::bigint as key,
           row_number() over() as id
      FROM vals
),
get_lp AS (
    SELECT 1 as num,
           7 as subject_number,
           0 as turn,
           key,
           id
      FROM pk
     WHERE id=1

     UNION ALL

     SELECT (num*subject_number)%20201227,
            subject_number,
            turn+1,
            key,
            id
       FROM get_lp
       WHERE num!=key
),
lp AS (
    select id,
           max(turn) as lp
      from get_lp
  group by 1
),
handshake AS (
    SELECT lp.id,
           lp.lp,
           pk.key as other_pk,
           1::bigint as num
      FROM lp
      JOIN pk ON lp.id!=pk.id

     UNION ALL

    SELECT id,
           lp-1,
           other_pk,
           (num*other_pk)%20201227
      FROM handshake
      WHERE lp>0
)
SELECT num FROM handshake WHERE lp=0 and id=1;
