WITH RECURSIVE vals AS (VALUES('BVBNBVPOKVFHBVCSHCFO'),(''),('SO -> V'),('PB -> P'),('HV -> N'),('VF -> O'),('KS -> F'),('BB -> C'),('SH -> H'),('SB -> C'),('FS -> F'),('PV -> F'),('BC -> K'),('SF -> S'),('NO -> O'),('SK -> C'),('PO -> N'),('VK -> F'),('FC -> C'),('VV -> S'),('SV -> S'),('HH -> K'),('FH -> K'),('HN -> O'),('NP -> F'),('PK -> N'),('VO -> K'),('NC -> C'),('KP -> B'),('CS -> C'),('KO -> F'),('BK -> N'),('OO -> N'),('CF -> H'),('KN -> C'),('BV -> S'),('OK -> O'),('CN -> F'),('OP -> O'),('VP -> N'),('OC -> P'),('NH -> C'),('VN -> S'),('VC -> B'),('NF -> H'),('FO -> H'),('CC -> B'),('KB -> N'),('CP -> N'),('HK -> N'),('FB -> H'),('BH -> V'),('BN -> N'),('KC -> F'),('CV -> K'),('SP -> V'),('VS -> P'),('KF -> S'),('CH -> V'),('NS -> N'),('HS -> O'),('CK -> K'),('NB -> O'),('OF -> K'),('VB -> N'),('PS -> B'),('KH -> P'),('BS -> C'),('VH -> C'),('KK -> F'),('FN -> F'),('BP -> B'),('HF -> O'),('HB -> V'),('OV -> H'),('NV -> N'),('HO -> S'),('OS -> H'),('SS -> K'),('BO -> V'),('OB -> K'),('HP -> P'),('CO -> B'),('PP -> K'),('HC -> N'),('BF -> S'),('NK -> S'),('ON -> P'),('PH -> C'),('FV -> H'),('CB -> H'),('PC -> K'),('FF -> P'),('PN -> P'),('NN -> O'),('PF -> F'),('SC -> C'),('FK -> K'),('SN -> K'),('KV -> P'),('FP -> B'),('OH -> F')),
changes AS (
    SELECT (regexp_split_to_array(column1, ' -> '))[1] as origin,
           (regexp_split_to_array((regexp_split_to_array(column1, ' -> '))[1], ''))[1] || (regexp_split_to_array(column1, ' -> '))[2] as dest,
           row_number() over() as id
      FROM vals
     WHERE column1 like '%->%'
     UNION ALL
    SELECT (regexp_split_to_array(column1, ' -> '))[1] as origin,
           (regexp_split_to_array(column1, ' -> '))[2] || (regexp_split_to_array((regexp_split_to_array(column1, ' -> '))[1], ''))[2] as dest,
           row_number() over() as id
      FROM vals
     WHERE column1 like '%->%'
),
start_str AS (
SELECT a.elem as e,
       a.nr as nr
  FROM vals v
  LEFT JOIN LATERAL unnest(regexp_split_to_array(v.column1, '')) WITH ORDINALITY AS a(elem, nr) ON TRUE
  WHERE v.column1!=''
    AND NOT v.column1 ilike '%->%'
),
compute AS (
    SELECT e || COALESCE(LAG(e, 1) OVER(order by nr DESC), ' ') as e,
           1::numeric as nbr,
           0 as turn
      FROM start_str

UNION ALL

  ( WITH tmp AS (
  SELECT COALESCE(c.dest ,rc.e) as e,
         nbr,
         turn+1 as turn
    FROM compute rc
    LEFT JOIN changes c ON rc.e=c.origin
    WHERE turn<40
  )
  SELECT e,
         sum(nbr),
         turn
    FROM tmp
    GROUP BY 1,3
  )
),
max_turn AS (
    select max(turn) turn
    FROM compute
),
chars_count as (
    SELECT sum(nbr) as nbr,
           (regexp_split_to_array(e, ''))[1]
      FROM compute
      JOIN max_turn USING (turn)
  GROUP BY 2
  ORDER BY 1 DESC
)
SELECT c2.nbr-c1.nbr
  FROM (SELECT nbr FROM chars_count ORDER BY nbr LIMIT 1) c1,
       (SELECT nbr FROM chars_count ORDER BY nbr DESC LIMIT 1) c2
