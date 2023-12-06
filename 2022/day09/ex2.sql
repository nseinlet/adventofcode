WITH RECURSIVE vals AS(VALUES('R 5
U 8
L 8
D 3
R 17
D 10
L 25
U 20')),
input AS (
    SELECT unnest(string_to_array(column1, '
')) as val
      FROM vals
),
turns AS (
    SELECT (string_to_array(val,' '))[1] as dir
          ,((string_to_array(val,' '))[2])::int as l
          ,row_number() OVER () as turn_id
      FROM input
),
compute AS (
    SELECT 0 as hx
          ,0 as hy
          ,array[0, 0, 0, 0, 0, 0, 0, 0, 0] as tx
          ,array[0, 0, 0, 0, 0, 0, 0, 0, 0] as ty
          ,array[0, 0, 0, 0, 0, 0, 0, 0, 0] as tsx
          ,array[0, 0, 0, 0, 0, 0, 0, 0, 0] as tsy
          ,0 as turn

UNION ALL
  (
      WITH RECUSRSIVE preliminary AS (
        SELECT CASE WHEN dir='R' THEN hx+l
                    WHEN dir='L' THEN hx-l
                    ELSE hx
               END as hx
              ,CASE WHEN dir='U' THEN hy+l
                    WHEN dir='D' THEN hy-l
                    ELSE hy
               END as hy
              ,CASE WHEN dir='R' THEN greatest(hx+l-1, tx[1]) -- behind head, or stay in place
                    WHEN dir='L' THEN least(hx-l+1, tx[1])    -- especially stay in place when in the 8 
                    WHEN dir='U' AND abs(hy+l-ty[1])>1 THEN hx
                    WHEN dir='D' AND abs(hy-l-ty[1])>1 THEN hx
                    ELSE tx[1]
               END || tx[2:]
              ,CASE WHEN dir='R' AND abs(hx+l-tx[1])>1 THEN hy
                    WHEN dir='L' AND abs(hx-l-tx[1])>1 THEN hy
                    WHEN dir='U' THEN greatest(hy+l-1, ty[1])
                    WHEN dir='D' THEN least(hy-l+1, ty[1])
                    ELSE ty[1]
               END || ty[2:]
              ,CASE WHEN dir='R' AND abs(hx+l-tx[1])>1 THEN tx[1]+1
                    WHEN dir='L' AND abs(hx-l-tx[1])>1 THEN tx[1]-1
                    WHEN dir='U' AND abs(hy+l-ty[1])>1 THEN hx
                    WHEN dir='D' AND abs(hy-l-ty[1])>1 THEN hx
                    ELSE tx[1]
               END || tsx[2:]
              ,CASE WHEN dir='R' AND abs(hx+l-tx[1])>1 THEN hy
                    WHEN dir='L' AND abs(hx-l-tx[1])>1 THEN hy
                    WHEN dir='U' AND abs(hy+l-ty[1])>1 THEN ty[1]+1
                    WHEN dir='D' AND abs(hy-l-ty[1])>1 THEN ty[1]-1
                    ELSE ty[1]
               END  || tsy[2:]
              ,turn+1 as turn
              ,1 as subturn
          FROM compute
          JOIN turns on turns.turn_id=compute.turn+1
      ),
      subcompute AS (
            SELECT hx
                  ,hy

                  ,turn
                  ,subturn + 1
              FROM preliminary p
              JOIN generate_series(2, 9) g ON p.subturn+1=g
      )
  )
)
-- SELECT count(*) FROM (
-- SELECT tsx as x, g as y from compute, generate_series(least(tsy, ty), greatest(tsy, ty)) g WHERE tx=tsx 
-- UNION
-- SELECT g, tsy from compute, generate_series(least(tsx, tx), greatest(tsx, tx)) g WHERE ty=tsy
-- ) as c 
select * from compute