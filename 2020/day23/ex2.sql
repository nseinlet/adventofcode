WITH RECURSIVE starting_position AS(
    SELECT '389125467' as deck
),
an_array AS(
    select array(select generate_series(10,1000000)) as an_array
),
playing as (
    SELECT array [(substring(deck FROM 1 FOR 1))::int, (substring(deck FROM 2 FOR 1))::int, (substring(deck FROM 3 FOR 1))::int, (substring(deck FROM 4 FOR 1))::int, (substring(deck FROM 5 FOR 1))::int, (substring(deck FROM 6 FOR 1))::int, (substring(deck FROM 7 FOR 1))::int, (substring(deck FROM 8 FOR 1))::int, (substring(deck FROM 9 FOR 1))::int] || an_array deck,
           (substring(deck FROM 1 FOR 1))::int as current,
           0 as turn
      FROM starting_position, an_array

     UNION ALL

    (WITH pos_for_substringing AS (
        SELECT array_position(deck, current) computed_pos,
               deck,
               current,
               turn
          FROM playing
    ),
    substringing AS (
        SELECT deck[1 : computed_pos] || deck[computed_pos+4:] as subdeck,
               deck[computed_pos+1:computed_pos+3] as removed
          FROM pos_for_substringing
    ),
    whichtosearchfor AS (
        SELECT CASE
                 WHEN current-1>0 and not (current-1)=any(removed) then current-1
                 WHEN current-2>0 and not (current-2)=any(removed) then current-2
                 WHEN current-3>0 and not (current-3)=any(removed) then current-3
                 WHEN current-4>0 and not (current-4)=any(removed) then current-4
                 WHEN not 1000000=any(removed) then 1000000
                 WHEN not 999999=any(removed) then 999999
                 WHEN not 999998=any(removed) then 999998
                 WHEN not 999997=any(removed) then 999997
               END as num
        FROM substringing,pos_for_substringing
    ),
    set_removed_in_place AS (
        SELECT subdeck[1:array_position(subdeck, num)] || removed || subdeck[array_position(subdeck, num)+1:] as next_deck,
               subdeck[array_position(subdeck, num)] as next_current
          FROM whichtosearchfor,substringing
    )

     SELECT CASE
              WHEN array_position(next_deck, next_deck[array_position(next_deck, current)+1], 999990)>999990 THEN next_deck[999990:] || next_deck[1:999989]
              ELSE next_deck
            END,
            next_deck[array_position(next_deck, current)+1],
            turn+1
       FROM set_removed_in_place, pos_for_substringing
      WHERE turn<=1001
     )
)
SELECT CASE
         WHEN array_position(deck, 1, 999998)=999999 THEN deck[1000000]*deck[1]
         WHEN array_position(deck, 1, 999999)=1000000 THEN deck[1]*deck[2]
         ELSE deck[array_position(deck, 1)+1] * deck[array_position(deck, 1)+2]
       END as result
      FROM playing
  ORDER BY turn DESC
     LIMIT 1;
-- SELECT * FROM starting_position;
