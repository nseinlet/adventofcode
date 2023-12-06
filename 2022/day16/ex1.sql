WITH RECURSIVE vals AS(VALUES('Valve AA has flow rate=0; tunnels lead to valves DD, II, BB
Valve BB has flow rate=13; tunnels lead to valves CC, AA
Valve CC has flow rate=2; tunnels lead to valves DD, BB
Valve DD has flow rate=20; tunnels lead to valves CC, AA, EE
Valve EE has flow rate=3; tunnels lead to valves FF, DD
Valve FF has flow rate=0; tunnels lead to valves EE, GG
Valve GG has flow rate=0; tunnels lead to valves FF, HH
Valve HH has flow rate=22; tunnel leads to valve GG
Valve II has flow rate=0; tunnels lead to valves AA, JJ
Valve JJ has flow rate=21; tunnel leads to valve II')),
input AS (
    SELECT unnest(string_to_array(column1, '
')) as val
      FROM vals
),
valves AS (
    SELECT matches[1] as valve
         , (matches[2])::int as flow
         , regexp_split_to_array(matches[3], ', ') as leads_to
      FROM input
          ,regexp_matches(val, 'Valve ([A-Z]{2}) has flow rate=(\d+); tunnels lead to valves ([A-Z]{2}(, [A-Z]{2})*)') as matches
),
ways AS (
    SELECT valve
          ,array[valve] || unnest(leads_to) as way
          ,1 as l
      FROM valves
UNION ALL
    SELECT w.valve
          ,way || lt
          ,l+1
      FROM ways w
      JOIN valves v ON v.valve=any(w.way)
          ,unnest(leads_to) as lt
     WHERE l<8
       AND not lt=any(way)
),
compute AS (
      SELECT valve
            ,array[0] as total_flows
            ,array[]::text[] as opened
            ,array[valve] as visited
            ,array[1] as visited_h
            ,array[valve] as moves
            ,0 as t
        FROM valves
        WHERE valve='AA'
UNION ALL
(
  WITH prev AS (
      SELECT c.valve
            ,c.total_flows
            ,c.opened
            ,c.visited
            ,c.visited_h
            ,moves
            ,c.t+1 as t
            ,v.flow
            ,v.leads_to
        FROM compute c
        JOIN valves v ON v.valve=c.valve
       WHERE c.t<20
      --    AND (array_length(c.total_flows,1)<5 OR (array_length(c.total_flows,1)>=5 AND (c.total_flows[1]>c.total_flows[5] OR c.visited_h[1]>c.visited_h[5])))
         
  )
  SELECT valve
        ,p.total_flows[1]+p.flow*(30-t) || p.total_flows
        ,p.opened || p.valve as opened
        ,p.visited
        ,p.visited_h[1] || visited_h
        ,valve || p.moves
        ,p.t
    FROM prev p
   WHERE not valve=any(p.opened)
UNION ALL
  SELECT w.valve[2]
        ,p.total_flows[1] || p.total_flows
        ,p.opened
        ,CASE WHEN w.valve[2]=any(visited) THEN visited ELSE visited || w.valve[2] END
        ,CASE WHEN w.valve[2]=any(visited) THEN p.visited_h[1] ELSE p.visited_h[1]+1 END || p.visited_h
        ,w.valve[2] || p.moves
        ,p.t
    FROM prev p
    JOIN LATERAL (SELECT way as valve
                        ,sum(v.flow*(30-t-i)) as maxiflow 
                    FROM ways w 
                        ,unnest(w.way) WITH ORDINALITY AS w2(v, i)
                    JOIN valves v ON v.valve=w2.v
                   WHERE w.valve=p.valve
                     AND way[2]!=p.moves[1]
                     AND not w2.v=any(p.opened)
                group by 1
                order by 2 desc 
                   limit 2
                 ) as w on true
   WHERE NOT EXISTS (SELECT 1 FROM prev c WHERE array_length(c.total_flows,1)>10 AND c.total_flows[10]>p.total_flows[1])
      
))
-- select max(total_flows[1]) from compute
select t,count(*),max(total_flows[1]),max(moves) from compute group by 1 order by 1
-- select * from ways