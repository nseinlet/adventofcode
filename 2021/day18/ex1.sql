WITH RECURSIVE vals AS (VALUES('[[[[4,3],4],4],[7,[[8,4],9]]]'), ('[1,1]')),
nums AS (
    SELECT column1 as num,
           row_number() over() as id
      FROM vals
),
add AS (
    SELECT num,
           id
      FROM nums
     WHERE id=1

UNION ALL
    -- multiple reductions to perform for each item we add to the first one
    -- a loop in a loop
    (
    WITH RECURSIVE add_num AS (
        SELECT '[' || a.num || ',' || n.num || ']' as num,
               regexp_split_to_array('[' || a.num || ',' || n.num || ']', '') as tab,
               array_positions(regexp_split_to_array('[' || a.num || ',' || n.num || ']', ''), ',') as com_pos,
               array_positions(regexp_split_to_array('[' || a.num || ',' || n.num || ']', ''), '[') as open_pos,
               array_positions(regexp_split_to_array('[' || a.num || ',' || n.num || ']', ''), ']') as close_pos,
               n.id
          FROM add a
          JOIN nums n ON a.id+1=n.id
    ),
    --If any pair is nested inside four pairs, the leftmost such pair explodes.
    explode_pos AS (
        SELECT a.num,
               a.id,
               n.pos
          FROM add_num a
          JOIN LATERAL (SELECT ar.pos,ar.sequence FROM unnest(bindata[current_pos+2:current_pos+5]) WITH ORDINALITY AS ar(pos,sequence)) as n ON TRUE
          JOIN LATERAL (SELECT count(*) as nbr FROM unnest(open_pos) as e WHERE e::int<n.pos) as op
          JOIN LATERAL (SELECT count(*) as nbr FROM unnest(close_pos) as e WHERE e::int<n.pos) as cl
         WHERE op.nbr-cl.nbr>4
         ORDER BY n.pos
         FETCH FIRST ROW ONLY
    ),
    pos_with_neigbors AS (
        SELECT num,
               id,
               pos,

          FROM explode_pos
    )


    )--end union all for "add"
)
SELECT * FROM add
