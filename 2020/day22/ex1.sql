-- WITH RECURSIVE vals AS (VALUES('Player 1:'),('9'),('2'),('6'),('3'),('1'),(''),('Player 2:'),('5'),('8'),('4'),('7'),('10')),
WITH RECURSIVE vals AS (VALUES('Player 1:'),('28'),('13'),('25'),('16'),('38'),('3'),('14'),('6'),('29'),('2'),('47'),('20'),('35'),('43'),('30'),('39'),('21'),('42'),('50'),('48'),('23'),('11'),('34'),('24'),('41'),('Player 2:'),('27'),('37'),('9'),('10'),('17'),('31'),('19'),('33'),('40'),('12'),('32'),('1'),('18'),('36'),('49'),('46'),('26'),('4'),('45'),('8'),('15'),('5'),('44'),('22'),('7')),
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
           0 as turn
      FROM game

 UNION ALL

    SELECT CASE
             WHEN deck1[1]::int>deck2[1]::int THEN deck1[2:2147483647]||deck1[1]||deck2[1]
             ELSE deck1[2:2147483647]
           END,
           CASE
             WHEN deck2[1]::int>deck1[1]::int THEN deck2[2:2147483647]||deck2[1]||deck1[1]
             ELSE deck2[2:2147483647]
           END,
           turn+1
      FROM playing
     WHERE array_length(deck1, 1)>0
       AND array_length(deck2, 1)>0
),
winner AS (
    SELECT CASE WHEN array_length(deck1, 1)>0 THEN deck1 ELSE deck2 END AS deck
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
SELECT score FROM scoring where turn=0;
