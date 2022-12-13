WITH RECURSIVE vals AS(VALUES('Monkey 0:
  Starting items: 99, 63, 76, 93, 54, 73
  Operation: new = old * 11
  Test: divisible by 2
    If true: throw to monkey 7
    If false: throw to monkey 1

Monkey 1:
  Starting items: 91, 60, 97, 54
  Operation: new = old + 1
  Test: divisible by 17
    If true: throw to monkey 3
    If false: throw to monkey 2

Monkey 2:
  Starting items: 65
  Operation: new = old + 7
  Test: divisible by 7
    If true: throw to monkey 6
    If false: throw to monkey 5

Monkey 3:
  Starting items: 84, 55
  Operation: new = old + 3
  Test: divisible by 11
    If true: throw to monkey 2
    If false: throw to monkey 6

Monkey 4:
  Starting items: 86, 63, 79, 54, 83
  Operation: new = old * old
  Test: divisible by 19
    If true: throw to monkey 7
    If false: throw to monkey 0

Monkey 5:
  Starting items: 96, 67, 56, 95, 64, 69, 96
  Operation: new = old + 4
  Test: divisible by 5
    If true: throw to monkey 4
    If false: throw to monkey 0

Monkey 6:
  Starting items: 66, 94, 70, 93, 72, 67, 88, 51
  Operation: new = old * 5
  Test: divisible by 13
    If true: throw to monkey 4
    If false: throw to monkey 5

Monkey 7:
  Starting items: 59, 59, 74
  Operation: new = old + 8
  Test: divisible by 3
    If true: throw to monkey 1
    If false: throw to monkey 3')),
input AS (
    SELECT unnest(string_to_array(column1, '
')) as val
      FROM vals
),
parsing AS (
      SELECT (regexp_matches(val, 'Monkey (\d+):'))[1] as monkey
            ,string_to_array((regexp_matches(val, 'Starting items: (.*)'))[1], ', ') as items
            ,(regexp_matches(val, 'Operation: new = (.*)'))[1] as operation
            ,((regexp_matches(val, 'Test: divisible by (\d+)'))[1])::int as test
            ,((regexp_matches(val, 'If true: throw to monkey (\d+)'))[1])::int as true_cond
            ,((regexp_matches(val, 'If false: throw to monkey (\d+)'))[1])::int as false_cond
            ,row_number() over() as id
        FROM input
),
game_ AS (
      SELECT monkey
            ,lag(items, 1) over(order by id desc) as items
            ,lag(operation, 2) over(order by id desc) as operation
            ,lag(test, 3) over(order by id desc) as test
            ,lag(true_cond, 4) over(order by id desc) as true_cond
            ,lag(false_cond, 5) over(order by id desc) as false_cond
        FROM parsing
    ORDER BY monkey
),
monkeys AS (
      SELECT monkey::int as monkey
            ,CASE 
              WHEN operation='old * old' THEN 2
              WHEN substring(operation, 5, 1)='*' THEN 1
              ELSE 0
            END as operation
            ,CASE 
              WHEN operation='old * old' THEN 0
              ELSE (substring(operation, 7, 10))::int
            END as operator
            ,test::int as test
            ,true_cond
            ,false_cond
        FROM game_
       WHERE monkey IS NOT NULL
),
game AS (
      SELECT monkey::int as monkey
            ,item::int as item
            ,row_number() over(partition by monkey) as id
        FROM game_
        JOIN LATERAL unnest(items) as item ON TRUE
       WHERE monkey IS NOT NULL
    ORDER BY monkey
),
mm as (
      SELECT MAX(monkey) as mm
        FROM game
),
compute AS (
      SELECT monkey
            ,item
            ,id
            ,0 as t
            ,mm as tm
            ,0 as subturn
            ,0 as game
            ,-1 as ins
       FROM game, mm

UNION ALL
(
      WITH gaming AS (
      SELECT monkey
            ,item
            ,row_number() over(partition by monkey order by id) as id
            ,CASE WHEN tm>mm.mm THEN t+1 ELSE t END as t
            ,CASE WHEN tm>mm.mm THEN 0 ELSE tm+1 END as tm
            ,subturn
            ,CASE WHEN tm>=mm.mm THEN 0 ELSE game+1 END as game
        FROM compute, mm
       WHERE t<20 or t=20 and monkey>0
      )
      SELECT monkey
            ,item
            ,id
            ,t
            ,tm
            ,subturn
            ,game
            ,-1
        FROM gaming
       WHERE monkey!=tm
UNION ALL
      SELECT CASE 
               WHEN operation=2 THEN CASE WHEN mod((item*item)/3, test)=0 THEN true_cond ELSE false_cond END
               WHEN operation=1 THEN CASE WHEN mod((item*operator)/3, test)=0 THEN true_cond ELSE false_cond END
               ELSE CASE WHEN mod((item+operator)/3, test)=0 THEN true_cond ELSE false_cond END
             END as monkey
            ,CASE 
               WHEN operation=2 THEN (item*item)/3
               WHEN operation=1 THEN (item*operator)/3
               ELSE (item+operator)/3
             END as item
            ,g.monkey*100+id
            ,t
            ,tm
            ,t
            ,game
            ,g.monkey
        FROM gaming g 
        JOIN monkeys m ON g.monkey=m.monkey
       WHERE g.monkey=tm

)
),

counting AS (
      SELECT ins,
             count(*) as nbr
        FROM compute 
        WHERE ins>=0
    GROUP BY 1
    order by 2 desc
    limit 2
)
SELECT c1.nbr*c2.nbr FROM (SELECT nbr FROM counting ORDER BY 1 desc limit 1) c1, (SELECT nbr FROM counting ORDER BY 1 asc limit 1) c2
