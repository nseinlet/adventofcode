WITH RECURSIVE starting_position AS(
    SELECT '784235916' as deck
),
playing as (
    SELECT array [(substring(deck FROM 1 FOR 1))::int, (substring(deck FROM 2 FOR 1))::int, (substring(deck FROM 3 FOR 1))::int, (substring(deck FROM 4 FOR 1))::int, (substring(deck FROM 5 FOR 1))::int, (substring(deck FROM 6 FOR 1))::int, (substring(deck FROM 7 FOR 1))::int, (substring(deck FROM 8 FOR 1))::int, (substring(deck FROM 9 FOR 1))::int] as deck,
           (substring(deck FROM 1 FOR 1))::int as current,
           0 as turn
      FROM starting_position

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
               deck[computed_pos+1:computed_pos+3] as removed,
               deck,
               current,
               turn
          FROM pos_for_substringing
    ),
    othercupposition AS (
        SELECT COALESCE(array_position(subdeck, current-1), array_position(subdeck, current-2), array_position(subdeck, current-3), array_position(subdeck, current-4), array_position(subdeck, 9), array_position(subdeck, 8), array_position(subdeck, 7), array_position(subdeck, 6)) as pos_dest,
               subdeck,
               removed,
               deck,
               current,
               turn
          FROM substringing
    ),
    set_removed_in_place AS (
        SELECT subdeck[1:pos_dest] || removed || subdeck[pos_dest+1:] as next_deck,
               subdeck[pos_dest] as next_current,
               turn+1 as next_turn,
               current
          FROM othercupposition
    ),
    next_decks AS (
        SELECT next_deck,
               next_deck[array_position(next_deck, current)+1] as new_current,
               next_turn
          FROM set_removed_in_place
    )

     SELECT CASE
              WHEN array_position(next_deck, new_current, 5)>5 THEN next_deck[5:] || next_deck[1:4]
              ELSE next_deck
            END,
            new_current,
            next_turn
       FROM next_decks
      WHERE next_turn<=100
     )
)
SELECT array_to_string(deck[array_position(deck, 1)+1:]||deck[1:array_position(deck, 1)-1],'') FROM playing order by turn DESC limit 1;
-- SELECT * FROM starting_position;
