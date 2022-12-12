WITH RECURSIVE vals AS(VALUES('abccccaaaaaaacccaaaaaaaccccccccccccccccccccccccccccccccccaaaa
abcccccaaaaaacccaaaaaaaaaaccccccccccccccccccccccccccccccaaaaa
abccaaaaaaaaccaaaaaaaaaaaaaccccccccccccccccccccccccccccaaaaaa
abccaaaaaaaaaaaaaaaaaaaaaaacccccccccaaaccccacccccccccccaaacaa
abaccaaaaaaaaaaaaaaaaaacacacccccccccaaacccaaaccccccccccccccaa
abaccccaaaaaaaaaaaaaaaacccccccccccccaaaaaaaaaccccccccccccccaa
abaccccaacccccccccaaaaaacccccccccccccaaaaaaaacccccccccccccccc
abcccccaaaacccccccaaaaaaccccccccijjjjjjaaaaaccccccaaccaaccccc
abccccccaaaaacccccaaaacccccccciiijjjjjjjjjkkkkkkccaaaaaaccccc
abcccccaaaaacccccccccccccccccciiiirrrjjjjjkkkkkkkkaaaaaaccccc
abcccccaaaaaccccccccccccccccciiiirrrrrrjjjkkkkkkkkkaaaaaccccc
abaaccacaaaaacccccccccccccccciiiqrrrrrrrrrrssssskkkkaaaaacccc
abaaaaacaaccccccccccccccccccciiiqqrtuurrrrrsssssskklaaaaacccc
abaaaaacccccccccccaaccccccccciiqqqttuuuurrssusssslllaaccccccc
abaaaaaccccccccaaaaccccccccciiiqqqttuuuuuuuuuuusslllaaccccccc
abaaaaaacccccccaaaaaaccccccciiiqqqttxxxuuuuuuuusslllccccccccc
abaaaaaaccccaaccaaaaacccccchhiiqqtttxxxxuyyyyvvsslllccccccccc
abaaacacccccaacaaaaaccccccchhhqqqqttxxxxxyyyyvvsslllccccccccc
abaaacccccccaaaaaaaacccccchhhqqqqtttxxxxxyyyvvssqlllccccccccc
abacccccaaaaaaaaaaccaaacchhhpqqqtttxxxxxyyyyvvqqqlllccccccccc
SbaaacaaaaaaaaaaaacaaaaahhhhppttttxxEzzzzyyvvvqqqqlllcccccccc
abaaaaaaacaaaaaacccaaaaahhhppptttxxxxxyyyyyyyvvqqqlllcccccccc
abaaaaaaccaaaaaaaccaaaaahhhppptttxxxxywyyyyyyvvvqqqmmcccccccc
abaaaaaaacaaaaaaacccaaaahhhpppsssxxwwwyyyyyyvvvvqqqmmmccccccc
abaaaaaaaaaaaaaaacccaacahhhpppssssssswyyywwvvvvvqqqmmmccccccc
abaaaaaaaacacaaaacccccccgggppppsssssswwywwwwvvvqqqqmmmccccccc
abcaaacaaaccccaaaccccccccgggppppppssswwwwwrrrrrqqqmmmmccccccc
abcaaacccccccccccccccccccgggggpppoosswwwwwrrrrrqqmmmmddcccccc
abccaacccccccccccccccccccccgggggoooosswwwrrrnnnmmmmmddddccccc
abccccccccccccccccccccccccccgggggooossrrrrrnnnnnmmmddddaccccc
abaccccaacccccccccccccccccccccgggfoossrrrrnnnnndddddddaaacccc
abaccaaaaaaccccccccccccccccccccgffooorrrrnnnneeddddddaaaacccc
abaccaaaaaacccccccccccccccccccccfffooooonnnneeeddddaaaacccccc
abacccaaaaaccccccccaaccaaaccccccffffoooonnneeeeccaaaaaacccccc
abcccaaaaacccccccccaaccaaaaccccccffffoooneeeeeaccccccaacccccc
abaccaaaaaccccccccaaaacaaaaccccccafffffeeeeeaaacccccccccccccc
abacccccccccccccccaaaacaaacccccccccffffeeeecccccccccccccccaac
abaaaacccccccaaaaaaaaaaaaaacccccccccfffeeeccccccccccccccccaaa
abaaaacccccccaaaaaaaaaaaaaaccccccccccccaacccccccccccccccccaaa
abaacccccccccaaaaaaaaaaaaaaccccccccccccaacccccccccccccccaaaaa
abaaaccccccccccaaaaaaaaccccccccccccccccccccccccccccccccaaaaaa')),
input AS (
    SELECT val,
          row_number() OVER () AS row_id
      FROM vals
          ,unnest(string_to_array(column1, '
')) as val
),
map AS (
  SELECT substring(val, g, 1) as v
        ,CASE 
          WHEN substring(val, g, 1) = 'S' THEN 1
          WHEN substring(val, g, 1) = 'E' THEN 26
          ELSE ascii(substring(val, g, 1)) - 96
        END as elevation
        ,row_id
        ,g as col_id
    FROM input, generate_series(1, length(val)) as g
),
ways as (
  SELECT s.row_id as s_row_id
        ,s.col_id as s_col_id
        ,e.row_id as e_row_id
        ,e.col_id as e_col_id
    FROM map s
    JOIN map e ON (
                    (s.row_id = e.row_id AND abs(s.col_id - e.col_id) = 1)
                 OR (s.col_id = e.col_id AND abs(s.row_id - e.row_id) = 1)
                  )
                  AND e.elevation-s.elevation<=1
),
finish AS (
  SELECT row_id as fr
        ,col_id as fc
    FROM map
   WHERE v='E'
),
compute AS (
  SELECT array[row_id*100+col_id] as pt
        ,row_id
        ,col_id
    FROM map
   WHERE v='S'

   UNION ALL
   (WITH RECURSIVE cp(pt, row_id, col_id) AS (
  SELECT pt || array[e_row_id*100+e_col_id]
        ,e_row_id
        ,e_col_id
        ,row_number() over() as id
    FROM compute
    JOIN ways ON ways.s_row_id = compute.row_id AND ways.s_col_id = compute.col_id
    WHERE NOT e_row_id*100+e_col_id = ANY(pt)
   )
    SELECT pt
          ,row_id
          ,col_id
      FROM cp
      WHERE NOT EXISTS (
                        SELECT 1
                          FROM cp c2, finish
                         WHERE (c2.row_id = cp.row_id AND c2.col_id = cp.col_id and c2.id<cp.id)
                            OR (cp.row_id*100+cp.col_id = ANY(c2.pt) AND cp.row_id*100+cp.col_id!=c2.row_id*100+c2.col_id)
                            OR (c2.row_id = fr AND c2.col_id = fc and c2.id<cp.id)
                      )
   )
)

select array_length(pt, 1)-1 from compute JOIN finish ON row_id=finish.fr and col_id=finish.fc order by array_length(pt, 1) asc
