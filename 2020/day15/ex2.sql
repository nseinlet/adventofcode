begin;

CREATE FUNCTION run_machine(vals varchar,turns int) RETURNS int AS $$
DECLARE
  last_num int;
  d int[];
  d0 int[];
  turn int;
  start_val int;


BEGIN
  FOR start_val, turn IN SELECT v,row_number() over() FROM (SELECT regexp_split_to_table(vals ,',')::int v) as tmp
  LOOP
    d[start_val] := turn;
    last_num := start_val;
  END LOOP;

  WHILE turn<turns
  LOOP
    turn := turn+1;

    IF turn%10000=0 THEN
      RAISE NOTICE '%', turn;
    END IF;

    IF d0[last_num]>0 THEN
      last_num = turn-1-d0[last_num];
    ELSE
      last_num := 0;
    END IF;

    d0 := d;
    d[last_num] := turn;

  END LOOP;

  RETURN last_num;
 END;
$$ LANGUAGE plpgsql;

SELECT * FROM run_machine('13,0,10,12,1,5,8', 30000000);

rollback;
