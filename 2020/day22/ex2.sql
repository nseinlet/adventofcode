-- WITH RECURSIVE vals AS (VALUES('Player 1:'),('43'),('19'),('Player 2:'),('2'),('29'),('14')),
WITH RECURSIVE vals AS (VALUES('Player 1:'),('9'),('2'),('6'),('3'),('1'),(''),('Player 2:'),('5'),('8'),('4'),('7'),('10')),
-- WITH RECURSIVE vals AS (VALUES('Player 1:'),('28'),('13'),('25'),('16'),('38'),('3'),('14'),('6'),('29'),('2'),('47'),('20'),('35'),('43'),('30'),('39'),('21'),('42'),('50'),('48'),('23'),('11'),('34'),('24'),('41'),('Player 2:'),('27'),('37'),('9'),('10'),('17'),('31'),('19'),('33'),('40'),('12'),('32'),('1'),('18'),('36'),('49'),('46'),('26'),('4'),('45'),('8'),('15'),('5'),('44'),('22'),('7')),

cards AS (
    SELECT column1 as card,
           row_number() over() as id
      FROM vals
),
cards_per_player AS (
    SELECT c.card,
           pl.player,
           c.id
      FROM cards c
      JOIN LATERAL (SELECT MAX(id) as player FROM cards p WHERE p.id<c.id AND card ilike 'Play%') pl ON TRUE
     WHERE card!=''
       AND card not like 'Pla%'
),
decks AS (
    SELECT array_agg(card) as deck,
           CASE WHEN player='1' THEN 1 ELSE 2 END as player
      FROM (SELECT * FROM cards_per_player ORDER BY player, id) c
  GROUP BY 2
),
game AS (
    SELECT p1.deck AS deck1,
           p2.deck AS deck2
      FROM decks p1
CROSS JOIN decks p2
     WHERE p1.player=1
       AND p2.player=2
),
playing AS (
    SELECT deck1,
           deck2,
           0 as turn,
           0 as subgamingturn,
           FALSE as p1win,
           array[''] as p1_decks,
           array[''] as p2_decks
      FROM game

 UNION ALL

    (WITH RECURSIVE subgaming AS (
        SELECT deck1[2:2147483647] as subdeck1,
               deck2[2:2147483647] as subdeck2,
               deck1[1] as card1,
               deck2[1] as card2,
               deck1,
               deck2,
               turn,
               0 as subturn,
               CASE WHEN array_position(p1_decks, ('-' || array_to_string(deck1, '/') || '-' ))>0 OR array_position(p2_decks, ('-' || array_to_string(deck2, '/') || '-' ))>0 THEN TRUE ELSE p1win END,
               p1_decks,
               p2_decks
          FROM playing
         WHERE array_length(deck1, 1)>0
           AND array_length(deck2, 1)>0

         UNION ALL

        SELECT CASE
                 WHEN subdeck1[1]::int>subdeck2[1]::int THEN subdeck1[2:2147483647]||subdeck1[1]||subdeck2[1]
                 ELSE subdeck1[2:2147483647]
               END,
               CASE
                 WHEN subdeck2[1]::int>subdeck1[1]::int THEN subdeck2[2:2147483647]||subdeck2[1]||subdeck1[1]
                 ELSE subdeck2[2:2147483647]
               END,
               card1,
               card2,
               deck1,
               deck2,
               turn,
               subturn+1,
               p1win,
               p1_decks,
               p2_decks
          FROM subgaming
         WHERE array_length(subdeck1, 1)>0
           AND array_length(subdeck2, 1)>0
           AND (subturn>0 OR (subturn=0 AND card1::int<=array_length(subdeck1,1) AND card2::int<=array_length(subdeck2,1)))
           AND NOT p1win
    ),
    maxturn as (
        SELECT max(subturn) as mst
          FROM subgaming
    )
    SELECT CASE
             WHEN (subturn=0 AND card1::int>card2::int) OR (subturn>0 AND array_length(subdeck1, 1)>0) THEN deck1[2:2147483647]||card1||card2
             ELSE deck1[2:2147483647]
           END,
           CASE
             WHEN p1win then null
             WHEN (subturn=0 AND card2::int>card1::int) OR (subturn>0 AND array_length(subdeck2, 1)>0) THEN deck2[2:2147483647]||card2||card1
             ELSE deck2[2:2147483647]
           END,
           turn+1,
           subturn,
           p1win,
           p1_decks || ('-' || array_to_string(deck1, '/') || '-' ),
           p2_decks || ('-' || array_to_string(deck2, '/') || '-' )
      FROM subgaming
      JOIN maxturn on maxturn.mst=subgaming.subturn
     -- WHERE p1win=FALSE
    )
),
winner AS (
    SELECT CASE WHEN array_length(deck1, 1)>0 or p1win THEN deck1 ELSE deck2 END AS deck
      FROM playing
  ORDER BY turn DESC
     LIMIT 1
),
scoring AS (
    SELECT 0 as score,
           deck,
           array_length(deck, 1) as turn
      FROM winner

     UNION ALL

     SELECT score + (deck[1]::int*turn),
            deck[2:2147483647],
            turn-1
       FROM scoring
      WHERE turn>0

)
-- SELECT * FROM playing ORDER BY turn DESC LIMIT 1
SELECT deck1,deck2,turn,subgamingturn,p1win  FROM playing order by turn;
-- SELECT score FROM scoring where turn=0;

-- 30293 too low
