begin;
WITH vals AS (VALUES('acc +22'),('acc +42'),('nop +456'),('jmp +5'),('acc +31'),('acc +49'),('acc +10'),('jmp +519'),('nop +390'),('jmp +418'),('nop +29'),('acc -4'),('jmp +156'),('jmp +85'),('acc +5'),('acc +26'),('jmp +497'),('acc -6'),('acc -18'),('acc +20'),('acc +4'),('jmp -8'),('jmp +372'),('jmp +371'),('jmp -1'),('jmp +1'),('nop +378'),('acc +18'),('jmp +388'),('jmp +1'),('acc +29'),('acc +37'),('jmp +1'),('jmp +425'),('acc +19'),('acc +13'),('jmp +477'),('acc +7'),('jmp +469'),('nop +495'),('nop +141'),('acc +22'),('jmp +517'),('jmp +125'),('nop +30'),('acc +37'),('acc +23'),('nop +238'),('jmp +110'),('jmp +411'),('acc +2'),('acc -19'),('acc -19'),('jmp +296'),('acc +0'),('acc +14'),('acc +20'),('jmp +75'),('nop +88'),('acc -16'),('acc +40'),('acc +27'),('jmp +131'),('acc +33'),('nop +252'),('acc +5'),('acc +0'),('jmp +101'),('nop +219'),('acc +50'),('acc +40'),('jmp +49'),('nop +74'),('jmp +327'),('acc +47'),('jmp +206'),('acc -15'),('jmp +449'),('acc -17'),('acc -13'),('acc +46'),('jmp +417'),('jmp +160'),('acc -7'),('acc -11'),('acc +16'),('acc +14'),('jmp -37'),('acc -12'),('acc +15'),('acc -14'),('nop +110'),('jmp +1'),('acc -4'),('nop +287'),('nop -82'),('jmp +30'),('jmp +490'),('acc +34'),('jmp +305'),('nop +90'),('jmp +1'),('nop -4'),('nop -95'),('jmp -46'),('acc +26'),('acc +13'),('acc +47'),('jmp +350'),('acc +11'),('jmp -102'),('acc -2'),('jmp +489'),('acc +28'),('acc +24'),('nop +486'),('jmp +485'),('nop +170'),('jmp +66'),('jmp +411'),('acc +30'),('acc +48'),('acc +48'),('jmp -6'),('acc +11'),('jmp -51'),('jmp +1'),('jmp -10'),('nop +411'),('acc -17'),('acc +32'),('jmp +9'),('jmp +398'),('nop +82'),('jmp +6'),('acc +45'),('acc +34'),('jmp -44'),('acc -13'),('jmp -122'),('acc +25'),('nop +286'),('acc +5'),('jmp +144'),('acc +0'),('jmp -122'),('acc -11'),('acc -6'),('jmp -123'),('acc +16'),('acc +1'),('jmp -58'),('nop +242'),('acc -11'),('jmp +257'),('nop +231'),('acc +46'),('jmp +301'),('acc -6'),('acc +20'),('acc -7'),('jmp +365'),('acc +32'),('acc +0'),('jmp -66'),('jmp +110'),('acc -18'),('jmp +118'),('acc +33'),('nop -125'),('acc +49'),('acc +36'),('jmp +188'),('acc +9'),('acc -11'),('jmp +100'),('acc +35'),('jmp +55'),('acc +38'),('acc -1'),('jmp +312'),('jmp +157'),('acc +17'),('jmp +177'),('nop -126'),('acc +30'),('acc -3'),('jmp +211'),('acc -3'),('jmp -164'),('jmp -112'),('acc +50'),('jmp +268'),('nop +290'),('acc -8'),('acc +35'),('jmp -44'),('acc -6'),('acc +11'),('nop +327'),('jmp +155'),('acc +10'),('acc +35'),('nop +233'),('jmp +330'),('acc +31'),('acc +8'),('jmp +124'),('acc -5'),('jmp +300'),('nop +171'),('nop +4'),('acc +19'),('acc +41'),('jmp -156'),('nop +179'),('acc +12'),('jmp +160'),('jmp -92'),('acc -11'),('acc -10'),('jmp +95'),('nop +94'),('acc -8'),('jmp -199'),('acc +16'),('acc +30'),('nop +73'),('acc +36'),('jmp -53'),('jmp +1'),('jmp -6'),('nop +369'),('acc +29'),('acc +47'),('jmp +32'),('acc +35'),('jmp -61'),('acc +41'),('jmp +352'),('acc -1'),('jmp +75'),('acc -10'),('acc +28'),('acc -15'),('jmp -187'),('acc +6'),('jmp +1'),('nop +112'),('jmp +273'),('nop +186'),('acc +11'),('acc +40'),('jmp +128'),('acc +17'),('acc +23'),('acc -8'),('nop +277'),('jmp +42'),('acc +11'),('nop -237'),('acc +36'),('acc +32'),('jmp +287'),('acc +16'),('acc -19'),('jmp +115'),('acc -6'),('acc +16'),('nop -2'),('acc +23'),('jmp -160'),('acc -10'),('acc -10'),('jmp +26'),('acc -7'),('jmp -95'),('nop -160'),('acc -2'),('acc +44'),('jmp -236'),('jmp -198'),('jmp +1'),('acc +1'),('jmp -9'),('jmp -95'),('jmp +273'),('acc -19'),('jmp -46'),('acc +12'),('acc +2'),('jmp -145'),('acc -14'),('acc +3'),('acc +3'),('jmp +250'),('acc +4'),('acc +40'),('jmp +1'),('jmp +17'),('acc +6'),('acc +47'),('jmp -77'),('nop -192'),('acc +11'),('jmp +296'),('acc -14'),('jmp +64'),('acc +35'),('jmp +134'),('acc -8'),('nop +228'),('acc +24'),('acc +15'),('jmp -64'),('jmp -241'),('acc +19'),('acc +22'),('acc +49'),('nop -193'),('jmp +219'),('acc -1'),('acc -11'),('nop +211'),('acc +0'),('jmp -106'),('nop +101'),('jmp -222'),('acc +20'),('acc +45'),('jmp +70'),('acc +19'),('acc +21'),('jmp -23'),('acc +8'),('nop +92'),('acc +47'),('jmp -144'),('acc +0'),('acc -1'),('jmp -81'),('acc +23'),('jmp -274'),('acc +14'),('acc +26'),('acc +9'),('jmp +79'),('acc +22'),('jmp -331'),('acc -10'),('jmp -311'),('acc +16'),('acc +30'),('acc -8'),('jmp +176'),('acc -19'),('acc +43'),('jmp -222'),('nop -116'),('jmp +18'),('acc +26'),('acc +23'),('acc +6'),('jmp -162'),('acc +34'),('jmp +95'),('acc +27'),('acc +40'),('acc +9'),('jmp -77'),('jmp +137'),('acc -13'),('acc +21'),('acc +17'),('acc -5'),('jmp +91'),('jmp -95'),('acc +18'),('acc -1'),('jmp +70'),('jmp -355'),('nop -166'),('acc -19'),('acc +16'),('jmp -146'),('jmp -135'),('jmp +57'),('acc +45'),('jmp -62'),('acc -14'),('jmp -382'),('nop -172'),('acc +45'),('jmp -77'),('acc +13'),('jmp +65'),('acc -4'),('jmp +112'),('jmp +107'),('jmp +26'),('jmp -326'),('acc +25'),('jmp +1'),('jmp +179'),('acc +33'),('acc +2'),('jmp -222'),('nop +36'),('acc +25'),('nop -244'),('jmp -376'),('jmp -203'),('acc +26'),('nop +109'),('acc +38'),('jmp +135'),('acc +7'),('acc +40'),('acc -18'),('jmp -113'),('nop -294'),('acc +0'),('acc +40'),('nop -265'),('jmp +81'),('jmp -99'),('jmp +32'),('acc -17'),('acc +25'),('acc -12'),('acc +26'),('jmp -125'),('acc -3'),('acc -7'),('acc +25'),('jmp -410'),('acc +47'),('acc +36'),('jmp +35'),('acc +2'),('acc +18'),('acc -3'),('jmp -38'),('acc +29'),('acc +49'),('jmp -299'),('acc -4'),('nop -422'),('jmp +50'),('acc +11'),('acc +2'),('acc +49'),('jmp -233'),('acc +12'),('acc +43'),('acc -19'),('acc +11'),('jmp -264'),('jmp +124'),('jmp -361'),('acc +35'),('jmp -118'),('acc +23'),('acc -16'),('acc -14'),('jmp -22'),('jmp -135'),('jmp -309'),('acc +6'),('jmp -44'),('acc -12'),('acc +0'),('jmp -23'),('acc +29'),('acc -8'),('acc +18'),('acc +35'),('jmp -111'),('acc +22'),('acc +23'),('acc +0'),('acc -8'),('jmp -55'),('acc +14'),('jmp +1'),('acc +44'),('acc +17'),('jmp -272'),('acc +39'),('nop +37'),('acc -19'),('jmp -323'),('acc +24'),('acc +28'),('acc +29'),('acc +37'),('jmp +110'),('jmp -386'),('nop -352'),('acc +23'),('acc +38'),('jmp -369'),('acc -5'),('acc -14'),('jmp +83'),('jmp +17'),('jmp -151'),('jmp -118'),('jmp -104'),('jmp -341'),('acc +32'),('acc +43'),('jmp -52'),('acc -4'),('acc +42'),('acc +5'),('jmp -116'),('acc +13'),('jmp +1'),('nop -361'),('acc +41'),('jmp -386'),('jmp -241'),('nop -449'),('acc +46'),('jmp -176'),('acc +6'),('jmp +60'),('jmp +1'),('jmp -3'),('jmp -62'),('acc -14'),('acc +17'),('jmp -340'),('acc +31'),('acc -13'),('acc +7'),('jmp -54'),('jmp -80'),('acc +14'),('acc +49'),('acc +34'),('jmp +24'),('acc +11'),('jmp -158'),('acc -13'),('jmp -261'),('acc +33'),('nop -171'),('jmp -106'),('acc +0'),('acc +9'),('acc +16'),('acc +34'),('jmp +18'),('acc -2'),('acc +47'),('acc +39'),('jmp -232'),('acc +23'),('nop -229'),('acc +30'),('acc +32'),('jmp -147'),('acc -8'),('jmp -460'),('jmp -498'),('nop -218'),('acc +31'),('acc +44'),('acc +30'),('jmp -105'),('acc +8'),('acc -19'),('acc +45'),('nop -49'),('jmp -140'),('nop -43'),('acc +42'),('jmp +1'),('acc -14'),('jmp -42'),('jmp -389'),('acc +39'),('acc +26'),('acc +38'),('jmp -77'),('acc +48'),('jmp -83'),('acc +5'),('jmp -81'),('nop -242'),('acc +35'),('acc +0'),('acc +19'),('jmp -430'),('acc +11'),('nop -226'),('acc +13'),('acc +23'),('jmp -575'),('acc +44'),('acc +50'),('nop -303'),('jmp -112'),('jmp -305'),('acc +23'),('acc -11'),('nop -376'),('acc +50'),('jmp +1')),
--WITH vals AS (VALUES('nop +0'),('acc +1'),('jmp +4'),('acc +3'),('jmp -3'),('acc -99'),('acc +1'),('jmp -4'),('acc +6')),
splitted_data AS (
    SELECT regexp_split_to_array(column1,' ') as datas,
           row_number() over() as inst_id,
           0 as executed,
           0 as output
      FROM vals
 )
 SELECT datas[1] as instruction,
        datas[2]::int4 as data,
        inst_id,
        executed,
        output
   INTO TEMPORARY TABLE console_tmp
   FROM splitted_data;

CREATE FUNCTION run_machine(instruction_revert int4) RETURNS int AS $$
DECLARE
pos int4 := 1;
result_pos int4;
pos_increment int4;
accumulator int4 :=0;
iter int4:=0;
tmp_data int4;
operation varchar;
prog_end int4;

BEGIN
DROP TABLE IF EXISTS console;
 CREATE TEMPORARY TABLE console AS (select * from console_tmp);
 operation := (SELECT instruction FROM console WHERE inst_id=instruction_revert);
 IF operation='jmp' THEN
     UPDATE console SET instruction='nop' WHERE inst_id=instruction_revert;
 ELSIF operation='nop' THEN
     UPDATE console SET instruction='jmp' WHERE inst_id=instruction_revert;
 END IF;

 prog_end := (SELECT max(inst_id) FROM CONSOLE);
 WHILE (select executed FROM console WHERE inst_id=pos)::int4=0 AND (pos<=prog_end)
   LOOP
       pos_increment:=1;
       result_pos:=0;
       iter := iter + 1;

       operation := (SELECT instruction FROM console WHERE inst_id=pos);
       tmp_data := (SELECT data FROM console WHERE inst_id=pos)::int4;

       IF operation='acc' THEN
           accumulator := accumulator + tmp_data;
       ELSIF operation='jmp' THEN
           pos_increment := tmp_data;
       END IF;

       UPDATE console SET executed=iter WHERE inst_id=pos;


       IF result_pos>0 THEN
           pos := result_pos;
       ELSE
           pos := pos + pos_increment;
       END IF;

   END LOOP;
   IF pos>prog_end THEN
    RETURN accumulator;
   ELSE
    RETURN NULL;
    END IF;
END;
$$ LANGUAGE plpgsql;


WITH machines AS (
SELECT run_machine(s) as r,
       s as inst
  FROM generate_series(1, (SELECT MAX(inst_id)::int4 FROM console_tmp)) s
)
SELECT r
  FROM machines
 WHERE r IS NOT NULL;

rollback;