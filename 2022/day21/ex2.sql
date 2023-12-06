WITH RECURSIVE vals AS(VALUES('root: pppw + sjmn
dbpl: 5
cczh: sllz + lgvd
zczc: 2
ptdq: humn - dvpt
dvpt: 3
lfqf: 4
humn: 5
ljgn: 2
sjmn: drzm * dbpl
sllz: 4
pppw: cczh / lfqf
lgvd: ljgn * ptdq
drzm: hmdt - zczc
hmdt: 32')),
input AS (
    SELECT unnest(string_to_array(column1, '
')) as val
      FROM vals
),
compute as (
    SELECT split_part(v[1], ':', 1) as "name"
          ,CASE WHEN array_length(v, 1) = 2 THEN v[2]::numeric ELSE NULL END as val
          ,CASE WHEN array_length(v, 1) > 2 THEN v[2] ELSE NULL END as p1
          ,NULL::numeric as p1_val
          ,CASE WHEN array_length(v, 1) > 2 THEN v[4] ELSE NULL END as p2
          ,NULL::numeric as p2_val
          ,CASE WHEN array_length(v, 1) > 2 THEN v[3] ELSE NULL END as op
          ,0 as turn
      FROM input
          ,string_to_array(val, ' ') as v

UNION ALL (
    WITH prev_turn AS (
        SELECT *
          FROM compute
    )
    SELECT p."name"
            ,CASE 
                WHEN p.val IS NOT NULL THEN p.val
                WHEN p.op = '+' AND p.p1_val IS NOT NULL AND p.p1_val IS NOT NULL THEN p.p1_val + p.p2_val
                WHEN p.op = '*' AND p.p1_val IS NOT NULL AND p.p1_val IS NOT NULL THEN p.p1_val * p.p2_val
                WHEN p.op = '/' AND p.p1_val IS NOT NULL AND p.p1_val IS NOT NULL THEN p.p1_val / p.p2_val
                WHEN p.op = '-' AND p.p1_val IS NOT NULL AND p.p1_val IS NOT NULL THEN p.p1_val - p.p2_val
                ELSE NULL
            END as val
            ,CASE WHEN pt1.val IS NOT NULL THEN NULL else p.p1 END as p1
            ,coalesce(p.p1_val, pt1.val)
            ,CASE WHEN pt2.val IS NOT NULL THEN NULL else p.p2 END as p2
            ,coalesce(p.p2_val, pt2.val)
            ,p.op
            ,p.turn + 1
        FROM prev_turn p
   LEFT JOIN prev_turn pt1 ON pt1."name" = p.p1
   LEFT JOIN prev_turn pt2 ON pt2."name" = p.p2
       WHERE EXISTS (SELECT 1 FROM prev_turn WHERE "name"= 'root' AND val IS NULL)
))
SELECT val::int8 FROM compute where "name" = 'root' order by turn desc limit 1;