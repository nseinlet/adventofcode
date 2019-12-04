
WITH passwords AS(
    SELECT substring(s::varchar FROM 1 FOR 1)::int as n1,
           substring(s::varchar FROM 2 FOR 1)::int as n2,
           substring(s::varchar FROM 3 FOR 1)::int as n3,
           substring(s::varchar FROM 4 FOR 1)::int as n4,
           substring(s::varchar FROM 5 FOR 1)::int as n5,
           substring(s::varchar FROM 6 FOR 1)::int as n6
      FROM generate_series(273025, 767253) s
),
valid_passwords AS (
    SELECT *
    FROM passwords
      WHERE n1<=n2 AND n2<=n3 AND n3<=n4 AND n4<=n5 AND n5<=n6
    AND NOT (n1<n2 AND n2<n3 AND n3<n4 AND n4<n5 AND n5<n6)
)
SELECT count(*)
  FROM valid_passwords;
