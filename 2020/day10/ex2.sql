begin;
WITH vals AS (VALUES('178'),('135'),('78'),('181'),('137'),('16'),('74'),('11'),('142'),('109'),('148'),('108'),('151'),('184'),('121'),('58'),('110'),('52'),('169'),('128'),('2'),('119'),('38'),('136'),('25'),('26'),('73'),('157'),('153'),('7'),('19'),('160'),('4'),('80'),('10'),('51'),('1'),('131'),('55'),('86'),('87'),('21'),('46'),('88'),('173'),('71'),('64'),('114'),('120'),('167'),('172'),('145'),('130'),('33'),('20'),('190'),('35'),('79'),('162'),('122'),('98'),('177'),('179'),('68'),('48'),('118'),('125'),('192'),('174'),('99'),('152'),('3'),('89'),('105'),('180'),('191'),('61'),('13'),('90'),('129'),('47'),('138'),('67'),('115'),('44'),('59'),('60'),('95'),('93'),('166'),('154'),('101'),('34'),('113'),('139'),('77'),('94'),('161'),('187'),('45'),('22'),('12'),('163'),('41'),('27'),('132'),('30'),('143'),('168'),('144'),('83'),('100'),('102'),('72')),
--WITH vals AS (VALUES('28'),('33'),('18'),('42'),('31'),('14'),('46'),('20'),('48'),('47'),('24'),('23'),('49'),('45'),('19'),('38'),('39'),('11'),('1'),('32'),('25'),('35'),('8'),('17'),('7'),('9'),('4'),('2'),('34'),('10'),('3')),
--WITH vals AS(VALUES('16'),('10'),('15'),('5'),('1'),('11'),('7'),('19'),('6'),('12'),('4')),
outputs AS (
    SELECT column1::int as output
      FROM vals

     UNION

    SELECT 0

     UNION

    SELECT max(column1::int4)+3
      FROM vals
),
diff_outputs AS (
    SELECT output,
           output-LAG(output,1) OVER (order by output) as diff,
           row_number() over() as id
    FROM outputs
ORDER BY 1
),
diff_groups AS (
      SELECT o.output,
             o.diff,
             o.id,
             COALESCE(l.group_id,-1) as group_id
        FROM diff_outputs o
JOIN LATERAL (SELECT min(o2.id) as group_id FROM diff_outputs o2 WHERE o2.diff=3 and o2.id>o.id) as l ON TRUE
),
permutation_groups AS (
    SELECT group_id,
           count(*) as size
      FROM diff_groups
     WHERE diff=1
  GROUP BY 1
)
SELECT CASE
         WHEN size=1 THEN 1
         WHEN size=2 THEN 2
         WHEN size=3 THEN 4
         WHEN size=4 THEN 7
       END as combination, -- The hell to define this conversion of possible combination of adapters from the length of the number of adapters
       row_number() over() as id
INTO TEMPORARY TABLE combinations
FROM permutation_groups;

WITH RECURSIVE mults as(
    SELECT combination::bigint,
           id
      FROM combinations
     WHERE id=1

    UNION

    SELECT (c.combination*m.combination)::bigint,
           c.id
      FROM combinations c
      JOIN mults m ON m.id+1=c.id
)

select max(combination) FROM mults;

rollback;
