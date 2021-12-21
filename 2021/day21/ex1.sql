-- WITH RECURSIVE vals AS (VALUES('Player 1 starting position: 4'),('Player 2 starting position: 8')),
WITH RECURSIVE vals AS (VALUES('Player 1 starting position: 7'),('Player 2 starting position: 8')),
spos AS (
    SELECT ((regexp_split_to_array(column1, ': '))[2])::int as pos,
           row_number() over() as player
      FROM vals
),
game AS (
    SELECT pl1.pos as p1,
           pl2.pos as p2,
           0 as s1,
           0 as s2,
           0 as turn,
           0 as dice
      FROM spos as pl1,
           spos as pl2
     WHERE pl1.player=1
       AND pl2.player=2

 UNION ALL

    SELECT mod(p1+dice+1+dice+2+dice+3, 10),
           mod(p2+dice+4+dice+5+dice+6, 10),
           s1 + CASE WHEN mod(p1+dice+1+dice+2+dice+3, 10)=0 THEN 10 ELSE mod(p1+dice+1+dice+2+dice+3, 10) END,
           s2 + CASE WHEN mod(p2+dice+4+dice+5+dice+6, 10)=0 THEN 10 ELSE mod(p2+dice+4+dice+5+dice+6, 10) END,
           turn+1,
           CASE WHEN (dice+6)>100 THEN dice+6-100 ELSE dice+6 END
      FROM game
     WHERE s1<1000
       AND s2<1000
       -- AND turn<3
),
looser AS (
    SELECT CASE WHEN s1>=1000 THEN LAG(s2,1) OVER (ORDER BY turn) ELSE s1 END as score,
           CASE WHEN s1>=1000 THEN ((turn-1)*6)+3 ELSE turn*6 END as t
      FROM game
      ORDER BY turn DESC
      LIMIT 1
 )
 SELECT t*score FROM looser
