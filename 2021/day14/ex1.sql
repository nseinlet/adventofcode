WITH RECURSIVE vals AS (VALUES('BVBNBVPOKVFHBVCSHCFO'),(''),('SO -> V'),('PB -> P'),('HV -> N'),('VF -> O'),('KS -> F'),('BB -> C'),('SH -> H'),('SB -> C'),('FS -> F'),('PV -> F'),('BC -> K'),('SF -> S'),('NO -> O'),('SK -> C'),('PO -> N'),('VK -> F'),('FC -> C'),('VV -> S'),('SV -> S'),('HH -> K'),('FH -> K'),('HN -> O'),('NP -> F'),('PK -> N'),('VO -> K'),('NC -> C'),('KP -> B'),('CS -> C'),('KO -> F'),('BK -> N'),('OO -> N'),('CF -> H'),('KN -> C'),('BV -> S'),('OK -> O'),('CN -> F'),('OP -> O'),('VP -> N'),('OC -> P'),('NH -> C'),('VN -> S'),('VC -> B'),('NF -> H'),('FO -> H'),('CC -> B'),('KB -> N'),('CP -> N'),('HK -> N'),('FB -> H'),('BH -> V'),('BN -> N'),('KC -> F'),('CV -> K'),('SP -> V'),('VS -> P'),('KF -> S'),('CH -> V'),('NS -> N'),('HS -> O'),('CK -> K'),('NB -> O'),('OF -> K'),('VB -> N'),('PS -> B'),('KH -> P'),('BS -> C'),('VH -> C'),('KK -> F'),('FN -> F'),('BP -> B'),('HF -> O'),('HB -> V'),('OV -> H'),('NV -> N'),('HO -> S'),('OS -> H'),('SS -> K'),('BO -> V'),('OB -> K'),('HP -> P'),('CO -> B'),('PP -> K'),('HC -> N'),('BF -> S'),('NK -> S'),('ON -> P'),('PH -> C'),('FV -> H'),('CB -> H'),('PC -> K'),('FF -> P'),('PN -> P'),('NN -> O'),('PF -> F'),('SC -> C'),('FK -> K'),('SN -> K'),('KV -> P'),('FP -> B'),('OH -> F')),
changes AS (
    SELECT (regexp_split_to_array((regexp_split_to_array(column1, ' -> '))[1], ''))[1] as e1,
           (regexp_split_to_array((regexp_split_to_array(column1, ' -> '))[1], ''))[2] as e2,
           (regexp_split_to_array(column1, ' -> '))[2] as add,
           row_number() over() as id
      FROM vals
     WHERE column1 like '%->%'
),
compute AS (
    SELECT column1 as e,
           0 as turn
      FROM vals
     WHERE column1!=''
       AND NOT column1 ilike '%->%'

UNION ALL (
     WITH rc AS (
         SELECT a.elem as e,
                a.nr as nr,
                1 as snr,
                turn+1 as turn
           FROM compute c
           LEFT JOIN LATERAL unnest(regexp_split_to_array(c.e, '')) WITH ORDINALITY AS a(elem, nr) ON TRUE
          WHERE turn<10
      ),
      rcl AS (
          SELECT e,
                 nr,
                 snr,
                 turn
            FROM rc

        UNION ALL

          SELECT c.add,
                 rc1.nr,
                 2 as snr,
                 rc1.turn
            FROM changes c
            JOIN rc rc1 ON rc1.e=c.e1
            JOIN rc rc2 ON rc2.e=c.e2 AND rc2.nr-1=rc1.nr

      ),
      rcc AS (
          SELECT e,
                 nr,
                 snr,
                 turn
            FROM rcl
            ORDER BY nr, snr
      )
      SELECT ARRAY_TO_STRING(array_agg(e), ''),
             turn
      FROM rcc
      GROUP BY turn


    )
),
all_chars as (
    SELECT unnest(regexp_split_to_array(e, '')) ch,
        turn
      FROM compute
      WHERE turn=10
),
chars_count as (
    SELECT count(*) as nbr,
           ch,
           turn
      FROM all_chars
  GROUP BY 2,3
)
SELECT c2.nbr-c1.nbr
  FROM (SELECT nbr FROM chars_count ORDER BY nbr LIMIT 1) c1,
       (SELECT nbr FROM chars_count ORDER BY nbr DESC LIMIT 1) c2
