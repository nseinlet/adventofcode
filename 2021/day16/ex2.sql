WITH RECURSIVE vals AS (VALUES('620D79802F60098803B10E20C3C1007A2EC4C84136F0600BCB8AD0066E200CC7D89D0C4401F87104E094FEA82B0726613C6B692400E14A305802D112239802125FB69FF0015095B9D4ADCEE5B6782005301762200628012E006B80162007B01060A0051801E200528014002A118016802003801E2006100460400C1A001AB3DED1A00063D0E25771189394253A6B2671908020394359B6799529E69600A6A6EB5C2D4C4D764F7F8263805531AA5FE8D3AE33BEC6AB148968D7BFEF2FBD204CA3980250A3C01591EF94E5FF6A2698027A0094599AA471F299EA4FBC9E47277149C35C88E4E3B30043B315B675B6B9FBCCEC0017991D690A5A412E011CA8BC08979FD665298B6445402F97089792D48CF589E00A56FFFDA3EF12CBD24FA200C9002190AE3AC293007A0A41784A600C42485F0E6089805D0CE517E3C493DC900180213D1C5F1988D6802D346F33C840A0804CB9FE1CE006E6000844528570A40010E86B09A32200107321A20164F66BAB5244929AD0FCBC65AF3B4893C9D7C46401A64BA4E00437232D6774D6DEA51CE4DA88041DF0042467DCD28B133BE73C733D8CD703EE005CADF7D15200F32C0129EC4E7EB4605D28A52F2C762BEA010C8B94239AAF3C5523CB271802F3CB12EAC0002FC6B8F2600ACBD15780337939531EAD32B5272A63D5A657880353B005A73744F97D3F4AE277A7DA8803C4989DDBA802459D82BCF7E5CC5ED6242013427A167FC00D500010F8F119A1A8803F0C62DC7D200CAA7E1BC40C7401794C766BB3C58A00845691ADEF875894400C0CFA7CD86CF8F98027600ACA12495BF6FFEF20691ADE96692013E27A3DE197802E00085C6E8F30600010882B18A25880352D6D5712AE97E194E4F71D279803000084C688A71F440188FB0FA2A8803D0AE31C1D200DE25F3AAC7F1BA35802B3BE6D9DF369802F1CB401393F2249F918800829A1B40088A54F25330B134950E0')),
-- WITH RECURSIVE vals AS (VALUES('C200B40A82'), ('04005AC33890'), ('880086C3E88112'), ('CE00C43D881120'), ('D8005AC2A8F0'), ('F600BC2D8F'), ('9C005AC2F8F0'), ('9C0141080250320F1802104A08')),
hex_to_bits AS (
    SELECT replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(REPLACE(column1, '0', '0000'), '1', '0001'), '2', '0010'), '3', '0011'), '4', '0100'), '5', '0101'), '6', '0110'), '7', '0111'), '8', '1000'), '9', '1001'), 'A', '1010'), 'B', '1011'), 'C', '1100'), 'D', '1101'), 'E', '1110'), 'F', '1111') as bindata,
           row_number() over() as id
      FROM vals
),
compute AS (
    -- easy start
    SELECT regexp_split_to_array(bindata,'') as bindata,
           0 as current_pos,
           0 as ver_sum,
           '' as ver_list,
           id,
           0 as depth,
           FALSE as computeit,
           array[''] as decypher,
           array_fill(0, array[10]) as reach_pos,
           array_fill(0, array[10]) as reach_sp,
           0 as turn
      FROM hex_to_bits

 UNION ALL
    -- packet can contain sub-packet, glory to the RECURSIVE loop
    (WITH RECURSIVE rough_pos AS (
    SELECT bindata,
           current_pos+6 as current_pos,
           ver_sum + ((bindata[current_pos+1])::int*4 + (bindata[current_pos+2])::int*2 + (bindata[current_pos+3])::int) as ver_sum,
           ver_list || ' ' || ((bindata[current_pos+1])::int*4 + (bindata[current_pos+2])::int*2 + (bindata[current_pos+3])::int) as ver_list,
           ((bindata[current_pos+4])::int*4 + (bindata[current_pos+5])::int*2 + (bindata[current_pos+6])::int) as type,
           id,
           depth,
           computeit,
           decypher,
           reach_pos,
           reach_sp,
           turn+1 as turn
      FROM compute
     WHERE depth>0 OR current_pos=0
      ),
      --parse literal values
      scompute_num AS (
          SELECT bindata,
                 current_pos+5 as current_pos,
                 CASE bindata[current_pos+1]
                   WHEN '1' THEN TRUE
                   ELSE FALSE
                 END as continue,
                 (SELECT sum((a.e::int)*2^(4-a.nr)) FROM unnest(bindata[current_pos+2:current_pos+5]) WITH ORDINALITY AS a(e,nr)) as val,
                 ver_sum,
                 ver_list,
                 type,
                 id,
                 depth,
                 decypher,
                 reach_pos,
                 reach_sp,
                 turn
            FROM rough_pos
           WHERE type=4 --literal value

       UNION ALL

          SELECT bindata,
                 current_pos+5,
                 CASE bindata[current_pos+1]
                   WHEN '1' THEN TRUE
                   ELSE FALSE
                 END as continue,
                 val*16+(SELECT sum((a.e::int)*2^(4-a.nr)) FROM unnest(bindata[current_pos+2:current_pos+5]) WITH ORDINALITY AS a(e,nr)),
                 ver_sum,
                 ver_list,
                 type,
                 id,
                 depth,
                 decypher,
                 reach_pos,
                 reach_sp,
                 turn
            FROM scompute_num
           WHERE continue
      ),
      --parse operators
      scompute_ope AS (
          SELECT bindata,
                 CASE bindata[current_pos+1] WHEN '0' THEN current_pos+1+15 ELSE current_pos+1+11 END AS current_pos,
                 ver_sum,
                 ver_list,
                 type,
                 id,
                 CASE bindata[current_pos+1] WHEN '0' THEN TRUE ELSE FALSE END as length_based,
                 CASE bindata[current_pos+1]
                     WHEN '0' THEN (SELECT sum((a.e::int)*2^(15-a.nr)) FROM unnest(bindata[current_pos+2:current_pos+1+15]) WITH ORDINALITY AS a(e,nr))
                     ELSE (SELECT sum((a.e::int)*2^(11-a.nr)) FROM unnest(bindata[current_pos+2:current_pos+1+11]) WITH ORDINALITY AS a(e,nr))
                 END::int as length_value,
                 depth+1 as depth,
                 decypher,
                 reach_pos,
                 reach_sp,
                 turn

            FROM rough_pos
           WHERE type!=4
      ),
      group_result AS(
         -- end parsing the sub packet, loop to the next one
         -- group results, literal and operators
         SELECT bindata,
                current_pos,
                ver_sum,
                ver_list,
                id,
                depth,
                CASE
                   WHEN reach_pos[depth]>0 AND reach_pos[depth]=current_pos THEN TRUE
                   WHEN reach_sp[depth]-1=0 THEN TRUE
                   ELSE FALSE
                END as computeit,
                val::text || decypher as DECYPHER,
                CASE WHEN reach_pos[depth]>0 AND current_pos<reach_pos[depth] THEN reach_pos ELSE reach_pos[1:depth-1] || 0 || reach_pos[depth+1:10] END AS reach_pos,
                reach_sp[1:depth-1] || reach_sp[depth]-1 || reach_sp[depth+1:10] as reach_sp,
                turn
           FROM scompute_num
          WHERE NOT continue
      UNION ALL
         SELECT bindata,
                current_pos,
                ver_sum,
                ver_list,
                id,
                depth,
                FALSE as computeit,
                ARRAY[ CASE type
                    WHEN 0 THEN '+'
                    WHEN 1 THEN '*'
                    WHEN 2 THEN 'min'
                    WHEN 3 THEN 'max'
                    WHEN 5 THEN '>'
                    WHEN 6 THEN '<'
                    WHEN 7 THEN '='
                END , ')'::text ] || decypher AS decypher,
                reach_pos[1:depth-1] || CASE length_based WHEN TRUE THEN current_pos+length_value ELSE 0 END || reach_pos[depth+1:10] as reach_pos,
                reach_sp[1:depth-1] || CASE length_based WHEN FALSE THEN length_value ELSE 0 END || reach_sp[depth+1:10] as reach_sp,
                turn
           FROM scompute_ope
       ),
       --now we shoudl trigger the compute flag
       recurse_eval AS (
           SELECT bindata,
                  current_pos,
                  ver_sum,
                  ver_list,
                  id,
                  depth,
                  computeit,
                  decypher,
                  reach_pos,
                  reach_sp,
                  turn
             FROM group_result

        UNION ALL

           SELECT bindata,
                  current_pos,
                  ver_sum,
                  ver_list,
                  id,
                  depth-1 as depth,
                  CASE
                     WHEN reach_pos[depth-1]>0 AND reach_pos[depth-1]=current_pos THEN TRUE
                     WHEN reach_sp[depth-1]-1=0 THEN TRUE
                     ELSE FALSE
                  END as computeit,
                  '('::text || decypher,
                  reach_pos,
                  reach_sp,
                  turn
             FROM recurse_eval
            WHERE computeit

       )
       select * from recurse_eval WHERE computeit=FALSE
     )
),
max_turn AS (
    SELECT max(turn) as t,
           id
      FROM compute
  GROUP BY id
),
-- loop in loop, what else ?
rpn AS (
    SELECT c.id,
           '('::text || decypher as decypher,
           0 as turn
      FROM compute c
      JOIN max_turn m ON c.id=m.id AND c.turn=m.t

UNION ALL
    (
    WITH arrpos AS (
    SELECT id,
           array_position(decypher, ')') as close_parenthesis,
           COALESCE((array_positions(decypher[1: array_position(decypher, ')')-1], '('))[array_length((array_positions(decypher[1: array_position(decypher, ')')-1], '(')), 1)], 1) as open_parenthesis,
           decypher[array_position(decypher, ')')-1] as ope,
           decypher,
           turn+1 as turn
      FROM rpn
     WHERE array_position(decypher, ')') IS NOT NULL
     -- AND turn<85
    ),
    eval_sub AS(
    SELECT id,
           open_parenthesis,
           close_parenthesis,
           --operatror
           -- beware order of inputs is reversed by parsing operation
           -- comparision can then looks weird
           CASE ope
              WHEN '<' THEN CASE WHEN (decypher[open_parenthesis+1])::numeric>(decypher[open_parenthesis+2])::numeric THEN '1'::text ELSE '0'::text END
              WHEN '>' THEN CASE WHEN (decypher[open_parenthesis+1])::numeric<(decypher[open_parenthesis+2])::numeric THEN '1'::text ELSE '0'::text END
              WHEN '=' THEN CASE WHEN (decypher[open_parenthesis+1])::numeric=(decypher[open_parenthesis+2])::numeric THEN '1'::text ELSE '0'::text END
              WHEN 'min' THEN (SELECT (min(a::numeric))::text FROM unnest(decypher[open_parenthesis+1:close_parenthesis-2]) as a(a))
              WHEN 'max' THEN (SELECT (min(a::numeric))::text FROM unnest(decypher[open_parenthesis+1:close_parenthesis-2]) as a(a))
              WHEN '+' THEN (SELECT (sum(a::numeric))::text FROM unnest(decypher[open_parenthesis+1:close_parenthesis-2]) as a(a))
              WHEN '*' THEN CASE WHEN open_parenthesis=close_parenthesis-3 THEN decypher[open_parenthesis+1] ELSE NULL::text END
           END as res,
           -- no aggregate for *, then, ... do it in a loop, we're used to.
           CASE WHEN ope='*' AND open_parenthesis<close_parenthesis-3 THEN array['('::text, ((decypher[open_parenthesis+1])::numeric*(decypher[open_parenthesis+2])::numeric)::text] || decypher[open_parenthesis+3:close_parenthesis] END as blk,
           decypher,
           turn
      FROM arrpos
    )
     SELECT id,
            decypher[1 : open_parenthesis-1] || CASE WHEN res IS NOT NULL THEN array[res::text] ELSE blk END || decypher[close_parenthesis+1 : array_length(decypher, 1)],
            turn
      FROM  eval_sub

    )
),
rpn_turn AS (
    SELECT id,
           max(turn) as turn
      FROM rpn
  GROUP BY id
)
SELECT decypher
  FROM rpn r
  order by turn desc
  LIMIT 1
