WITH RECURSIVE vals AS (VALUES('seeds: 4239267129 20461805 2775736218 52390530 3109225152 741325372 1633502651 46906638 967445712 47092469 2354891449 237152885 2169258488 111184803 2614747853 123738802 620098496 291114156 2072253071 28111202

seed-to-soil map:
803774611 641364296 1132421037
248421506 1797371961 494535345
1936195648 2752993203 133687519
2069883167 2294485405 458507798
2804145277 283074539 358289757
3162435034 2886680722 1132532262
2528390965 4019212984 275754312
766543479 248421506 34653033
742956851 1773785333 23586628
801196512 2291907306 2578099

soil-to-fertilizer map:
2497067833 718912393 1047592994
3544660827 4222700866 72266430
770426288 3365742958 209338740
3698421476 2775964622 508284117
1441878450 1818019282 725791090
417593992 265113557 15217985
979765028 3760587444 462113422
2167669540 2543810372 143892547
3616927257 3284248739 81494219
4206705593 2687702919 88261703
2380194851 3575081698 116872982
0 280331542 15942291
718912393 1766505387 51513895
152480435 0 265113557
2311562087 3691954680 68632764
15942291 296273833 136538144

fertilizer-to-water map:
0 402310798 253353164
778924681 2773042028 194127973
2853824225 2967170001 585461563
3827117536 3909653920 385313376
4259877071 3552631564 35090225
973052654 3635167948 222704323
253353164 0 389964349
2230088185 778924681 571954391
1195756977 1490392659 342200935
2802042576 3857872271 51781649
643317513 389964349 12346449
4212430912 3587721789 47446159
3439285788 2385210280 387831748
1677471499 1832593594 552616686
1537957912 1350879072 139513587

water-to-light map:
1548505089 767179152 4433418
3833169479 2956286720 133538400
2966709060 3309731935 102304094
1552938507 844050660 203612289
4257043426 3089825120 37923870
2862957901 3567999512 28008008
127112704 319767838 4466599
840317941 174506417 34039792
2890965909 3596007520 40520529
15787022 2007458428 111325682
2398090681 21771313 152735104
1094590916 1294380254 4387553
517844904 840169267 3881393
2556445662 1535118242 8735340
1266005567 2376897884 172496096
874357733 1314885059 220233183
3696946976 2820064217 136222503
2271345339 208546209 111221629
703336145 477538609 136981796
389299157 1710880680 59057725
4183266377 2766992510 22982117
521726297 324234437 53105792
1438501663 1881931289 110003426
131579303 1298767807 16117252
2102535156 614520405 152658747
0 2549393980 15787022
1098978469 1543853582 167027098
3966707879 2789974627 30089590
2255193903 0 16151436
1756550796 377340229 100198380
574832089 2360386712 16511172
2382566968 1991934715 15523713
3069013154 3636528049 627933822
2766992510 3178543922 79332992
2931486438 3274509313 35222622
3996797469 4264461871 30505425
2846325502 3257876914 16632399
2033978459 771612570 68556697
4206248494 3127748990 50794932
2550825785 16151436 5619877
591343261 1769938405 111992884
448356882 1047662949 69488022
4027302894 3412036029 155963483
147696555 2118784110 241602602
1856749176 1117150971 177229283

light-to-temperature map:
2549521624 1806050718 400234502
1279003707 1469066403 336984315
2063720323 2518736018 367281175
4240496851 236622733 54470445
3737038415 1201359870 20798035
1170741345 1222157905 108262362
1925074187 1330420267 138646136
3757836450 291093178 323945285
3424587617 2206285220 312450798
236622733 2886017193 934118612
4138496410 1042644754 102000441
4081781735 1144645195 56714675
2431001498 615038463 118520126
1615988022 733558589 309086165
2949756126 3820135805 474831491

temperature-to-humidity map:
725888341 86282489 843183510
3782717746 1630698708 99613080
2529768467 2786969418 347392693
2195908552 2059541517 89214959
3062107482 2168182310 90554707
1730470902 3134362111 465437650
2964061476 2688923412 98046006
2285123511 2358509211 13167510
2877161160 3875960109 61807956
0 929465999 639605852
3484769060 2148756476 19425834
2298291021 1730311788 170053852
639605852 0 86282489
3504194894 2371676721 119346975
4275382932 3599799761 19584364
2468344873 2491023696 61423594
3623541869 1900365640 159175877
4138906810 2552447290 136476122
3918976473 3656029772 219930337
2938969116 4269874936 25092360
3882330826 3619384125 36645647
3152662189 3937768065 332106871
1630698708 2258737017 99772194

humidity-to-location map:
1426868383 2786540732 64165562
1639911414 2027746720 730664673
857589555 0 114197007
2370576087 1887556908 140189812
3396523523 1265337150 488817864
1491033945 2850706294 148877469
3885341387 2999583763 409625909
0 114197007 857589555
1293466489 1754155014 133401894
2510765899 3409209672 885757624
1265337150 2758411393 28129339
')),
input AS (
    SELECT val
          ,row_number() OVER () AS row_id
          
      FROM vals
          ,unnest(string_to_array(column1, '
')) as val
),
seeds AS (
    SELECT seed::bigint
          ,row_number() OVER () AS seed_id
      FROM input
LEFT JOIN LATERAL regexp_split_to_table((string_to_array(val,': '))[2], ' ') AS seed ON TRUE
     WHERE row_id = 1
),
seed_ranges AS (
    SELECT s.seed as seed_min
          ,s.seed+s2.seed-1 as seed_max
          ,s.seed_id
      FROM seeds s
      JOIN seeds s2 ON s.seed_id = s2.seed_id - 1
     WHERE mod(s.seed_id, 2) = 1
),
map_ids_no_end AS (
    SELECT (string_to_array(val,' map:'))[1] AS map
          ,row_id as map_id
      FROM input
     WHERE val like '% map:'
),
map_ids AS (
    SELECT map
          ,map_id+1 as map_id
          ,COALESCE(
            (LAG(map_id) OVER (ORDER BY map_id desc))-2
           ,max_in.r
           ) AS map_id_end
      FROM map_ids_no_end
      JOIN (SELECT max(row_id) as r FROM input) AS max_in ON TRUE
),
mapping AS (
    SELECT (regexp_split_to_array(i.val, ' '))[2]::bigint AS origin_begin
          ,(regexp_split_to_array(i.val, ' '))[2]::bigint + (regexp_split_to_array(i.val, ' '))[3]::bigint - 1 AS origin_end
          ,(regexp_split_to_array(i.val, ' '))[1]::bigint AS target_begin
          ,(regexp_split_to_array(i.val, ' '))[1]::bigint + (regexp_split_to_array(i.val, ' '))[3]::bigint - 1 AS target_end
          ,row_id
          ,m.map
      FROM input i
      JOIN map_ids m ON i.row_id BETWEEN m.map_id AND m.map_id_end
      WHERE val not like '%:%'
        AND trim(val, ' ') not like ''
),
seeding_connexions AS (
    SELECT distinct greatest(o.origin_begin,sr.seed_min) as seed
      FROM mapping h
      JOIN mapping t ON t.target_begin <= h.origin_end AND t.target_end >= h.origin_begin AND t.map = 'temperature-to-humidity'
      JOIN mapping l ON l.target_begin <= t.origin_begin+least(t.target_end,h.origin_end)-t.target_begin AND l.target_end >= t.origin_begin+greatest(t.target_begin,h.origin_begin)-t.target_begin AND l.map = 'light-to-temperature'
      JOIN mapping w ON w.target_begin <= l.origin_begin+least(l.target_end,t.origin_end)-l.target_begin AND w.target_end >= l.origin_begin+greatest(l.target_begin,t.origin_begin)-l.target_begin AND w.map = 'water-to-light'
      JOIN mapping f ON f.target_begin <= w.origin_begin+least(w.target_end,l.origin_end)-w.target_begin AND f.target_end >= w.origin_begin+greatest(w.target_begin,l.origin_begin)-w.target_begin AND f.map = 'fertilizer-to-water'
      JOIN mapping s ON s.target_begin <= f.origin_begin+least(f.target_end,w.origin_end)-f.target_begin AND s.target_end >= f.origin_begin+greatest(f.target_begin,w.origin_begin)-f.target_begin AND s.map = 'soil-to-fertilizer'
      JOIN mapping o ON o.target_begin <= s.origin_begin+least(s.target_end,f.origin_end)-s.target_begin AND o.target_end >= s.origin_begin+greatest(s.target_begin,f.origin_begin)-s.target_begin AND o.map = 'seed-to-soil'
      JOIN seed_ranges sr ON sr.seed_min<=o.origin_end AND sr.seed_max>=o.origin_begin
     WHERE h.map = 'humidity-to-location'
       AND h.target_begin = 0
),
reverse_range AS(
    SELECT origin_begin as ob
          ,array['temperature-to-humidity', 'light-to-temperature', 'water-to-light', 'fertilizer-to-water', 'soil-to-fertilizer', 'seed-to-soil'] as mappings
    FROM mapping
   WHERE map = 'humidity-to-location'

   UNION ALL

    (WITH srr AS (
    SELECT CASE 
                WHEN m.origin_begin IS NULL THEN r.ob 
                ELSE m.origin_begin+r.ob-m.target_begin
           END as ob
          ,mappings[2:] as mappings
          ,mappings[1] as current_mapping
      FROM reverse_range r
      JOIN mapping m ON m.map = r.mappings[1] AND m.target_begin <= r.ob AND m.target_end >= r.ob
      WHERE array_length(mappings,1) > 0
    ),
    curent_origins AS (
        SELECT origin_begin as ob
            ,origin_end+1 as ob_end
              ,m.mappings
          FROM mapping 
     LEFT JOIN LATERAL (SELECT mappings, current_mapping FROM srr LIMIT 1) AS m ON TRUE
         WHERE map = m.current_mapping
    )
    SELECT ob
          ,mappings
      FROM srr
    UNION ALL
    SELECT ob
          ,mappings
      FROM curent_origins
    UNION ALL
    SELECT ob_end
          ,mappings
      FROM curent_origins
    )
),
all_seeds AS (
    SELECT ob as seed
      FROM reverse_range
    WHERE EXISTS (SELECT 1 FROM seed_ranges WHERE seed_min <= ob AND seed_max > ob)
),
seeding_soil AS (
   SELECT s.seed
         ,COALESCE(soil.target_begin + (s.seed - soil.origin_begin), s.seed) as soil_id
     FROM all_seeds s
LEFT JOIN mapping soil ON s.seed BETWEEN soil.origin_begin AND soil.origin_end AND soil.map = 'seed-to-soil'
),
seeding_fertilizer AS (
   SELECT s.seed
         ,s.soil_id
         ,COALESCE(fertilizer.target_begin + (s.soil_id - fertilizer.origin_begin), s.soil_id) as fertilizer_id
     FROM seeding_soil s
LEFT JOIN mapping fertilizer ON s.soil_id BETWEEN fertilizer.origin_begin AND fertilizer.origin_end AND fertilizer.map = 'soil-to-fertilizer'
),
seeding_water AS (
   SELECT s.seed
         ,s.soil_id
         ,s.fertilizer_id
         ,COALESCE(water.target_begin + (s.fertilizer_id - water.origin_begin), s.fertilizer_id) as water_id
     FROM seeding_fertilizer s
LEFT JOIN mapping water ON s.fertilizer_id BETWEEN water.origin_begin AND water.origin_end AND water.map = 'fertilizer-to-water'
),
seeding_light AS (
   SELECT s.seed
         ,s.soil_id
         ,s.fertilizer_id
         ,s.water_id
         ,COALESCE(light.target_begin + (s.water_id - light.origin_begin), s.water_id) as light_id
     FROM seeding_water s
LEFT JOIN mapping light ON s.water_id BETWEEN light.origin_begin AND light.origin_end AND light.map = 'water-to-light'
),
seeding_temperature AS (
   SELECT s.seed
         ,s.soil_id
         ,s.fertilizer_id
         ,s.water_id
         ,s.light_id
         ,COALESCE(temperature.target_begin + (s.light_id - temperature.origin_begin), s.light_id) as temperature_id
     FROM seeding_light s
LEFT JOIN mapping temperature ON s.light_id BETWEEN temperature.origin_begin AND temperature.origin_end AND temperature.map = 'light-to-temperature'
),
seeding_humidity AS (
   SELECT s.seed
         ,s.soil_id
         ,s.fertilizer_id
         ,s.water_id
         ,s.light_id
         ,s.temperature_id
         ,COALESCE(humidity.target_begin + (s.temperature_id - humidity.origin_begin), s.temperature_id) as humidity_id
     FROM seeding_temperature s
LEFT JOIN mapping humidity ON s.temperature_id BETWEEN humidity.origin_begin AND humidity.origin_end AND humidity.map = 'temperature-to-humidity'
),
seeding AS (
   SELECT s.seed
         ,s.soil_id
         ,s.fertilizer_id
         ,s.water_id
         ,s.light_id
         ,s.temperature_id
         ,s.humidity_id
         ,COALESCE(location.target_begin + (s.humidity_id - location.origin_begin), s.humidity_id) as location_id
     FROM seeding_humidity s
LEFT JOIN mapping location ON s.humidity_id BETWEEN location.origin_begin AND location.origin_end AND location.map = 'humidity-to-location'
),
ex2 AS (
    select min(location_id) as res1 from seeding
)


select * from ex2;