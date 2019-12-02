begin work;
WITH machines as(VALUES('1,0,0,3,1,1,2,3,1,3,4,3,1,5,0,3,2,9,1,19,1,19,5,23,1,23,5,27,2,27,10,31,1,31,9,35,1,35,5,39,1,6,39,43,2,9,43,47,1,5,47,51,2,6,51,55,1,5,55,59,2,10,59,63,1,63,6,67,2,67,6,71,2,10,71,75,1,6,75,79,2,79,9,83,1,83,5,87,1,87,9,91,1,91,9,95,1,10,95,99,1,99,13,103,2,6,103,107,1,107,5,111,1,6,111,115,1,9,115,119,1,119,9,123,2,123,10,127,1,6,127,131,2,131,13,135,1,13,135,139,1,9,139,143,1,9,143,147,1,147,13,151,1,151,9,155,1,155,13,159,1,6,159,163,1,13,163,167,1,2,167,171,1,171,13,0,99,2,0,14,0')),
machine as (
    SELECT regexp_split_to_table(column1, ',') as data,
           row_number() over() as machine
      FROM machines
),
machine_operation as (
    SELECT data,
           machine,
           (row_number() over())-1 as op_id
      FROM machine
)
SELECT CASE
         WHEN op_id=1 THEN 12
         WHEN op_id=2 THEN 2
         ELSE data::int
       END as data,
       machine,
       op_id
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

        UPDATE machine_1202
           SET data=CASE
                      WHEN operation=1 THEN num1+num2
                      WHEN operation=2 THEN num1*num2
                    END
         WHERE machine=machine_id
           AND op_id=result_pos;

        pos := pos + 4;
    END LOOP;
    RETURN (select data FROM machine_1202 WHERE op_id=0 AND machine=machine_id);
END;
$$ LANGUAGE plpgsql;

SELECT run_machine(1);

rollback work;
