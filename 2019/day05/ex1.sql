begin work;
WITH machines as(VALUES('3,225,1,225,6,6,1100,1,238,225,104,0,1102,67,92,225,1101,14,84,225,1002,217,69,224,101,-5175,224,224,4,224,102,8,223,223,101,2,224,224,1,224,223,223,1,214,95,224,101,-127,224,224,4,224,102,8,223,223,101,3,224,224,1,223,224,223,1101,8,41,225,2,17,91,224,1001,224,-518,224,4,224,1002,223,8,223,101,2,224,224,1,223,224,223,1101,37,27,225,1101,61,11,225,101,44,66,224,101,-85,224,224,4,224,1002,223,8,223,101,6,224,224,1,224,223,223,1102,7,32,224,101,-224,224,224,4,224,102,8,223,223,1001,224,6,224,1,224,223,223,1001,14,82,224,101,-174,224,224,4,224,102,8,223,223,101,7,224,224,1,223,224,223,102,65,210,224,101,-5525,224,224,4,224,102,8,223,223,101,3,224,224,1,224,223,223,1101,81,9,224,101,-90,224,224,4,224,102,8,223,223,1001,224,3,224,1,224,223,223,1101,71,85,225,1102,61,66,225,1102,75,53,225,4,223,99,0,0,0,677,0,0,0,0,0,0,0,0,0,0,0,1105,0,99999,1105,227,247,1105,1,99999,1005,227,99999,1005,0,256,1105,1,99999,1106,227,99999,1106,0,265,1105,1,99999,1006,0,99999,1006,227,274,1105,1,99999,1105,1,280,1105,1,99999,1,225,225,225,1101,294,0,0,105,1,0,1105,1,99999,1106,0,300,1105,1,99999,1,225,225,225,1101,314,0,0,106,0,0,1105,1,99999,8,226,226,224,102,2,223,223,1005,224,329,1001,223,1,223,1108,677,677,224,1002,223,2,223,1006,224,344,101,1,223,223,1007,226,677,224,102,2,223,223,1005,224,359,101,1,223,223,1007,677,677,224,1002,223,2,223,1006,224,374,101,1,223,223,1108,677,226,224,1002,223,2,223,1005,224,389,1001,223,1,223,108,226,677,224,102,2,223,223,1006,224,404,101,1,223,223,1108,226,677,224,102,2,223,223,1005,224,419,101,1,223,223,1008,677,677,224,102,2,223,223,1005,224,434,101,1,223,223,7,677,226,224,1002,223,2,223,1005,224,449,101,1,223,223,1008,226,226,224,102,2,223,223,1005,224,464,1001,223,1,223,107,226,677,224,1002,223,2,223,1006,224,479,1001,223,1,223,107,677,677,224,102,2,223,223,1005,224,494,1001,223,1,223,1008,226,677,224,102,2,223,223,1006,224,509,1001,223,1,223,1107,677,226,224,102,2,223,223,1005,224,524,101,1,223,223,1007,226,226,224,1002,223,2,223,1006,224,539,1001,223,1,223,107,226,226,224,102,2,223,223,1006,224,554,101,1,223,223,108,677,677,224,1002,223,2,223,1006,224,569,1001,223,1,223,7,226,677,224,102,2,223,223,1006,224,584,1001,223,1,223,8,677,226,224,102,2,223,223,1005,224,599,101,1,223,223,1107,677,677,224,1002,223,2,223,1005,224,614,101,1,223,223,8,226,677,224,102,2,223,223,1005,224,629,1001,223,1,223,7,226,226,224,1002,223,2,223,1006,224,644,1001,223,1,223,108,226,226,224,1002,223,2,223,1006,224,659,101,1,223,223,1107,226,677,224,1002,223,2,223,1006,224,674,101,1,223,223,4,223,99,226')),
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
SELECT data::int4,
       machine,
       op_id
  INTO TEMPORARY TABLE machine_1202
  FROM machine_operation;

ALTER TABLE machine_1202 ADD COLUMN output int4[];

CREATE FUNCTION run_machine(machine_id int, input int) RETURNS int AS $$
DECLARE
pos int4 := 0;
operation int4;
num1_pos int4;
num2_pos int4;
num1 int4;
num2 int4;
result_pos int4;
data_to_set int4;
pos_increment int4;
output_arr int4[];
immediatemode_1 boolean;
immediatemode_2 boolean;
data_to_parse varchar;

BEGIN
  WHILE (select data FROM machine_1202 WHERE op_id=pos AND machine=machine_id)::int4!=99
    LOOP
        immediatemode_1 := FALSE;
        immediatemode_2 := FALSE;

        operation := (SELECT data FROM machine_1202 WHERE op_id=pos AND machine=machine_id)::int4;
        IF operation>4 THEN
            data_to_parse := ('00000' || operation::varchar || ';');
            operation := substring(data_to_parse, length(data_to_parse)-2, 2)::int4;
            immediatemode_1 := substring(data_to_parse, length(data_to_parse)-3, 1)::boolean;
            immediatemode_2 := substring(data_to_parse, length(data_to_parse)-4, 1)::boolean;
        END IF;

        num1_pos := (SELECT data FROM machine_1202 WHERE op_id=pos+1 AND machine=machine_id)::int4;
        IF immediatemode_1 THEN
            num1 := num1_pos;
        ELSE
            num1 := (SELECT data FROM machine_1202 WHERE op_id=num1_pos AND machine=machine_id)::int4;
        END IF;

        num2_pos := (SELECT data FROM machine_1202 WHERE op_id=pos+2 AND machine=machine_id)::int4;
        IF immediatemode_2 THEN
            num2 := num2_pos;
        ELSE
            num2 := (SELECT data FROM machine_1202 WHERE op_id=num2_pos AND machine=machine_id)::int4;
        END IF;

        IF operation=1 OR operation=2 THEN
            result_pos := (SELECT data FROM machine_1202 WHERE op_id=pos+3 AND machine=machine_id)::int4;
        ELSE
            result_pos := (SELECT data FROM machine_1202 WHERE op_id=pos+1 AND machine=machine_id)::int4;
        END IF;

        IF operation=1 THEN
            data_to_set := num1+num2;
            pos_increment := 4;
        ELSIF operation=2 THEN
            data_to_set := num1*num2;
            pos_increment := 4;
        ELSIF operation=3 THEN
            pos_increment := 2;
            data_to_set := input;
        ELSIF operation=4 THEN
            pos_increment := 2;
            output_arr := array_append(output_arr, num1);
        END IF;

        UPDATE machine_1202
           SET data=data_to_set
         WHERE machine=machine_id
           AND op_id=result_pos;

        pos := pos + pos_increment;
    END LOOP;
    UPDATE machine_1202 SET output=output_arr WHERE op_id=0 AND machine=machine_id;
    RETURN (select data FROM machine_1202 WHERE op_id=0 AND machine=machine_id);
END;
$$ LANGUAGE plpgsql;

SELECT run_machine(1,1);
SELECT output FROM machine_1202 WHERE op_id=0;

rollback work;
