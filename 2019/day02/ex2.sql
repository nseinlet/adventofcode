begin work;
WITH machines as(VALUES('1,0,0,3,1,1,2,3,1,3,4,3,1,5,0,3,2,9,1,19,1,19,5,23,1,23,5,27,2,27,10,31,1,31,9,35,1,35,5,39,1,6,39,43,2,9,43,47,1,5,47,51,2,6,51,55,1,5,55,59,2,10,59,63,1,63,6,67,2,67,6,71,2,10,71,75,1,6,75,79,2,79,9,83,1,83,5,87,1,87,9,91,1,91,9,95,1,10,95,99,1,99,13,103,2,6,103,107,1,107,5,111,1,6,111,115,1,9,115,119,1,119,9,123,2,123,10,127,1,6,127,131,2,131,13,135,1,13,135,139,1,9,139,143,1,9,143,147,1,147,13,151,1,151,9,155,1,155,13,159,1,6,159,163,1,13,163,167,1,2,167,171,1,171,13,0,99,2,0,14,0')),
machine as (
    SELECT regexp_split_to_table(column1, ',') as data,
           op1*100+op2 as machine,
           op1,
           op2
      FROM machines, generate_series(0,99) as op1,generate_series(0,99) as op2
),
machine_operation as (
    SELECT data,
           machine,
           (row_number() over(PARTITION BY machine))-1 as op_id,
           op1,
           op2
      FROM machine
)
SELECT CASE
         WHEN op_id=1 THEN op1
         WHEN op_id=2 THEN op2
         ELSE data::int
       END as data,
       machine,
       op_id,
       op1,
       op2
  INTO TEMPORARY TABLE machine_1202
  FROM machine_operation;
CREATE UNIQUE INDEX idx_unique_op ON machine_1202(machine,op_id);

CREATE FUNCTION run_machine(machine_id int) RETURNS int AS $$
DECLARE
pos int4 := 0;
operation int4;
num1_pos int4;
num2_pos int4;
num1 int4;
num2 int4;
result_pos int4;

BEGIN
  WHILE (select data FROM machine_1202 WHERE op_id=pos AND machine=machine_id)::int!=99
    LOOP
        operation := (SELECT data FROM machine_1202 WHERE op_id=pos AND machine=machine_id)::int;
        num1_pos := (SELECT data FROM machine_1202 WHERE op_id=pos+1 AND machine=machine_id)::int;
        num2_pos := (SELECT data FROM machine_1202 WHERE op_id=pos+2 AND machine=machine_id)::int;
        num1 := (SELECT data FROM machine_1202 WHERE op_id=num1_pos AND machine=machine_id)::int;
        num2 := (SELECT data FROM machine_1202 WHERE op_id=num2_pos AND machine=machine_id)::int;
        result_pos := (SELECT data FROM machine_1202 WHERE op_id=pos+3 AND machine=machine_id)::int;

        DELETE FROM machine_1202 WHERE machine=machine_id AND op_id=result_pos;
        INSERT INTO machine_1202 (data,machine,op_id) VALUES (CASE WHEN operation=1 THEN num1+num2 WHEN operation=2 THEN num1*num2 END, machine_id, result_pos);

        pos := pos + 4;
    END LOOP;
    RETURN (select data FROM machine_1202 WHERE op_id=0 AND machine=machine_id);
END;
$$ LANGUAGE plpgsql;

WITH machines AS (
    SELECT DISTINCT machine, op1, op2
      FROM machine_1202
      WHERE op1 IS NOT NULL and op2 IS NOT NULL
)
SELECT run_machine(rm.machine) as result, rm.op1, rm.op2
  INTO TEMPORARY TABLE results
  FROM machines rm;
SELECT op1*100+op2 from results where result=19690720;
rollback work;
