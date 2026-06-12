*-------------------------------------------------------------------------------------------------------*
|                                       SAS On-the-Job                                                  |
|              COVID and Female Labor Supply - Weighted US-Wide Estimates (PROC SQL)                    |
*-------------------------------------------------------------------------------------------------------*;
* Adapted from "Task 2a - 2015 to 2023 Analysis.sas". The CPS microdata that the original   *;
* reads from the IPUMS library are represented here as a small inline sample collapsed to    *;
* weighted cells for two quarters: 2019Q4 (pre-pandemic) and 2020Q2 (the COVID-19 shock).    *;
* WTFINL holds the IPUMS final person weights, summed within each demographic cell.          *;

title1 "SAS On-the-Job | COVID and Female Labor Supply";
title2 "Weighted US-Wide Estimates | Women";

*-------------------------------------------------------------------------------------*
|                          CPS weighted cells (inline sample)                          |
*-------------------------------------------------------------------------------------*;
data cps;
    input YearQuarter :yyq6. Race_Ethnic EDUC_LTD Child_Status Unemp in_LF WTFINL;
    Female = 1;
    format YearQuarter yyq6.;
    datalines;
2019Q4 1 1 0 0 0 319698
2019Q4 1 1 0 0 1 313978
2019Q4 1 1 0 1 1 3737
2019Q4 1 1 1 0 0 283920
2019Q4 1 1 1 0 1 479671
2019Q4 1 1 1 1 1 81881
2019Q4 1 1 2 0 0 120351
2019Q4 1 1 2 0 1 137931
2019Q4 1 1 2 1 1 22976
2019Q4 1 2 0 0 0 961344
2019Q4 1 2 0 0 1 2113693
2019Q4 1 2 0 1 1 140609
2019Q4 1 2 1 0 0 773040
2019Q4 1 2 1 0 1 2042498
2019Q4 1 2 1 1 1 187533
2019Q4 1 2 2 0 0 418010
2019Q4 1 2 2 0 1 929960
2019Q4 1 2 2 1 1 65355
2019Q4 1 3 0 0 0 544684
2019Q4 1 3 0 0 1 2279920
2019Q4 1 3 0 1 1 103782
2019Q4 1 3 1 0 0 504746
2019Q4 1 3 1 0 1 2776333
2019Q4 1 3 1 1 1 117051
2019Q4 1 3 2 0 0 366861
2019Q4 1 3 2 0 1 1254871
2019Q4 1 3 2 1 1 39833
2019Q4 1 4 0 0 0 403027
2019Q4 1 4 0 0 1 3450214
2019Q4 1 4 0 1 1 103188
2019Q4 1 4 1 0 0 284476
2019Q4 1 4 1 0 1 2925795
2019Q4 1 4 1 1 1 73099
2019Q4 1 4 2 0 0 230270
2019Q4 1 4 2 0 1 1121586
2019Q4 1 4 2 1 1 27904
2019Q4 2 1 0 0 0 552901
2019Q4 2 1 0 0 1 835941
2019Q4 2 1 0 1 1 45504
2019Q4 2 1 1 0 0 2076357
2019Q4 2 1 1 0 1 2713140
2019Q4 2 1 1 1 1 140430
2019Q4 2 1 2 0 0 875778
2019Q4 2 1 2 0 1 629941
2019Q4 2 1 2 1 1 58173
2019Q4 2 2 0 0 0 936666
2019Q4 2 2 0 0 1 2124953
2019Q4 2 2 0 1 1 114299
2019Q4 2 2 1 0 0 1553254
2019Q4 2 2 1 0 1 3756170
2019Q4 2 2 1 1 1 172835
2019Q4 2 2 2 0 0 1062733
2019Q4 2 2 2 0 1 1301803
2019Q4 2 2 2 1 1 58176
2019Q4 2 3 0 0 0 549028
2019Q4 2 3 0 0 1 2466145
2019Q4 2 3 0 1 1 92137
2019Q4 2 3 1 0 0 928503
2019Q4 2 3 1 0 1 2892319
2019Q4 2 3 1 1 1 133976
2019Q4 2 3 2 0 0 654917
2019Q4 2 3 2 0 1 1347869
2019Q4 2 3 2 1 1 25468
2019Q4 2 4 0 0 0 515649
2019Q4 2 4 0 0 1 3312675
2019Q4 2 4 0 1 1 115779
2019Q4 2 4 1 0 0 572829
2019Q4 2 4 1 0 1 2872341
2019Q4 2 4 1 1 1 41659
2019Q4 2 4 2 0 0 429065
2019Q4 2 4 2 0 1 1162016
2019Q4 2 4 2 1 1 25380
2019Q4 3 1 0 0 0 771771
2019Q4 3 1 0 0 1 651312
2019Q4 3 1 0 1 1 45639
2019Q4 3 1 1 0 0 671717
2019Q4 3 1 1 0 1 824585
2019Q4 3 1 1 1 1 57448
2019Q4 3 1 2 0 0 434351
2019Q4 3 1 2 0 1 214238
2019Q4 3 1 2 1 1 27906
2019Q4 3 2 0 0 0 2677548
2019Q4 3 2 0 0 1 6171349
2019Q4 3 2 0 1 1 237404
2019Q4 3 2 1 0 0 2592718
2019Q4 3 2 1 0 1 6602540
2019Q4 3 2 1 1 1 197106
2019Q4 3 2 2 0 0 1334049
2019Q4 3 2 2 0 1 1844364
2019Q4 3 2 2 1 1 107852
2019Q4 3 3 0 0 0 2156001
2019Q4 3 3 0 0 1 9572369
2019Q4 3 3 0 1 1 241133
2019Q4 3 3 1 0 0 2631857
2019Q4 3 3 1 0 1 9843220
2019Q4 3 3 1 1 1 259965
2019Q4 3 3 2 0 0 1586678
2019Q4 3 3 2 0 1 3398759
2019Q4 3 3 2 1 1 106569
2019Q4 3 4 0 0 0 2461941
2019Q4 3 4 0 0 1 21446476
2019Q4 3 4 0 1 1 340489
2019Q4 3 4 1 0 0 2441765
2019Q4 3 4 1 0 1 16881098
2019Q4 3 4 1 1 1 234884
2019Q4 3 4 2 0 0 1955228
2019Q4 3 4 2 0 1 7905189
2019Q4 3 4 2 1 1 102589
2019Q4 4 1 0 0 0 244096
2019Q4 4 1 0 0 1 178459
2019Q4 4 1 0 1 1 9864
2019Q4 4 1 1 0 0 202563
2019Q4 4 1 1 0 1 262454
2019Q4 4 1 1 1 1 9101
2019Q4 4 1 2 0 0 119861
2019Q4 4 1 2 0 1 87503
2019Q4 4 1 2 1 1 1225
2019Q4 4 2 0 0 0 373223
2019Q4 4 2 0 0 1 733168
2019Q4 4 2 0 1 1 64646
2019Q4 4 2 1 0 0 402054
2019Q4 4 2 1 0 1 1075565
2019Q4 4 2 1 1 1 41202
2019Q4 4 2 2 0 0 241087
2019Q4 4 2 2 0 1 348628
2019Q4 4 2 2 1 1 25174
2019Q4 4 3 0 0 0 375600
2019Q4 4 3 0 0 1 1256855
2019Q4 4 3 0 1 1 57596
2019Q4 4 3 1 0 0 425159
2019Q4 4 3 1 0 1 1280983
2019Q4 4 3 1 1 1 35331
2019Q4 4 3 2 0 0 253316
2019Q4 4 3 2 0 1 422596
2019Q4 4 3 2 1 1 26473
2019Q4 4 4 0 0 0 914252
2019Q4 4 4 0 0 1 4070308
2019Q4 4 4 0 1 1 95035
2019Q4 4 4 1 0 0 892182
2019Q4 4 4 1 0 1 2918573
2019Q4 4 4 1 1 1 78556
2019Q4 4 4 2 0 0 908220
2019Q4 4 4 2 0 1 1414928
2019Q4 4 4 2 1 1 15651
2020Q2 1 1 0 0 0 302348
2020Q2 1 1 0 0 1 223354
2020Q2 1 1 0 1 1 63189
2020Q2 1 1 1 0 0 255205
2020Q2 1 1 1 0 1 306302
2020Q2 1 1 1 1 1 109494
2020Q2 1 1 2 0 0 64599
2020Q2 1 1 2 0 1 180170
2020Q2 1 1 2 1 1 43249
2020Q2 1 2 0 0 0 1362596
2020Q2 1 2 0 0 1 1459896
2020Q2 1 2 0 1 1 388145
2020Q2 1 2 1 0 0 921358
2020Q2 1 2 1 0 1 1662388
2020Q2 1 2 1 1 1 332906
2020Q2 1 2 2 0 0 427828
2020Q2 1 2 2 0 1 585942
2020Q2 1 2 2 1 1 166620
2020Q2 1 3 0 0 0 838985
2020Q2 1 3 0 0 1 1993833
2020Q2 1 3 0 1 1 420871
2020Q2 1 3 1 0 0 668573
2020Q2 1 3 1 0 1 2380193
2020Q2 1 3 1 1 1 416765
2020Q2 1 3 2 0 0 322347
2020Q2 1 3 2 0 1 717606
2020Q2 1 3 2 1 1 219027
2020Q2 1 4 0 0 0 596846
2020Q2 1 4 0 0 1 3652538
2020Q2 1 4 0 1 1 328384
2020Q2 1 4 1 0 0 393348
2020Q2 1 4 1 0 1 2634547
2020Q2 1 4 1 1 1 142592
2020Q2 1 4 2 0 0 232797
2020Q2 1 4 2 0 1 1015285
2020Q2 1 4 2 1 1 128673
2020Q2 2 1 0 0 0 653360
2020Q2 2 1 0 0 1 472997
2020Q2 2 1 0 1 1 210344
2020Q2 2 1 1 0 0 2353253
2020Q2 2 1 1 0 1 1840303
2020Q2 2 1 1 1 1 608192
2020Q2 2 1 2 0 0 1004256
2020Q2 2 1 2 0 1 433749
2020Q2 2 1 2 1 1 107797
2020Q2 2 2 0 0 0 1053430
2020Q2 2 2 0 0 1 1666004
2020Q2 2 2 0 1 1 420989
2020Q2 2 2 1 0 0 1914921
2020Q2 2 2 1 0 1 2599580
2020Q2 2 2 1 1 1 585093
2020Q2 2 2 2 0 0 1064327
2020Q2 2 2 2 0 1 850026
2020Q2 2 2 2 1 1 262383
2020Q2 2 3 0 0 0 717190
2020Q2 2 3 0 0 1 2240989
2020Q2 2 3 0 1 1 375278
2020Q2 2 3 1 0 0 963401
2020Q2 2 3 1 0 1 2882028
2020Q2 2 3 1 1 1 459478
2020Q2 2 3 2 0 0 736354
2020Q2 2 3 2 0 1 898908
2020Q2 2 3 2 1 1 233573
2020Q2 2 4 0 0 0 792989
2020Q2 2 4 0 0 1 3136181
2020Q2 2 4 0 1 1 400426
2020Q2 2 4 1 0 0 715603
2020Q2 2 4 1 0 1 2508535
2020Q2 2 4 1 1 1 316262
2020Q2 2 4 2 0 0 518886
2020Q2 2 4 2 0 1 1121489
2020Q2 2 4 2 1 1 61247
2020Q2 3 1 0 0 0 813751
2020Q2 3 1 0 0 1 412052
2020Q2 3 1 0 1 1 65152
2020Q2 3 1 1 0 0 688131
2020Q2 3 1 1 0 1 552242
2020Q2 3 1 1 1 1 116824
2020Q2 3 1 2 0 0 346507
2020Q2 3 1 2 0 1 171683
2020Q2 3 1 2 1 1 77322
2020Q2 3 2 0 0 0 3289581
2020Q2 3 2 0 0 1 4934826
2020Q2 3 2 0 1 1 949150
2020Q2 3 2 1 0 0 2461150
2020Q2 3 2 1 0 1 5269366
2020Q2 3 2 1 1 1 810118
2020Q2 3 2 2 0 0 1471697
2020Q2 3 2 2 0 1 1408380
2020Q2 3 2 2 1 1 311665
2020Q2 3 3 0 0 0 2252721
2020Q2 3 3 0 0 1 7974626
2020Q2 3 3 0 1 1 1224657
2020Q2 3 3 1 0 0 2993341
2020Q2 3 3 1 0 1 8226165
2020Q2 3 3 1 1 1 1079519
2020Q2 3 3 2 0 0 1691565
2020Q2 3 3 2 0 1 2755503
2020Q2 3 3 2 1 1 435784
2020Q2 3 4 0 0 0 3050085
2020Q2 3 4 0 0 1 19936265
2020Q2 3 4 0 1 1 1795433
2020Q2 3 4 1 0 0 3274581
2020Q2 3 4 1 0 1 16107547
2020Q2 3 4 1 1 1 1050717
2020Q2 3 4 2 0 0 2509858
2020Q2 3 4 2 0 1 7568186
2020Q2 3 4 2 1 1 462172
2020Q2 4 1 0 0 0 57749
2020Q2 4 1 0 0 1 70404
2020Q2 4 1 0 1 1 26962
2020Q2 4 1 1 0 0 255419
2020Q2 4 1 1 0 1 167139
2020Q2 4 1 1 1 1 125378
2020Q2 4 1 2 0 0 100758
2020Q2 4 1 2 0 1 64843
2020Q2 4 1 2 1 1 40555
2020Q2 4 2 0 0 0 344512
2020Q2 4 2 0 0 1 499722
2020Q2 4 2 0 1 1 182825
2020Q2 4 2 1 0 0 520697
2020Q2 4 2 1 0 1 746895
2020Q2 4 2 1 1 1 183467
2020Q2 4 2 2 0 0 252001
2020Q2 4 2 2 0 1 140465
2020Q2 4 2 2 1 1 44297
2020Q2 4 3 0 0 0 310078
2020Q2 4 3 0 0 1 882053
2020Q2 4 3 0 1 1 207609
2020Q2 4 3 1 0 0 427676
2020Q2 4 3 1 0 1 923583
2020Q2 4 3 1 1 1 171160
2020Q2 4 3 2 0 0 236741
2020Q2 4 3 2 0 1 309397
2020Q2 4 3 2 1 1 78793
2020Q2 4 4 0 0 0 956331
2020Q2 4 4 0 0 1 4042422
2020Q2 4 4 0 1 1 359552
2020Q2 4 4 1 0 0 1224135
2020Q2 4 4 1 0 1 2899080
2020Q2 4 4 1 1 1 292017
2020Q2 4 4 2 0 0 853700
2020Q2 4 4 2 0 1 1612294
2020Q2 4 4 2 1 1 163437
;
run;

*-------------------------------------------------------------------------------------*
|                     Produce US-Wide Estimates | Weighted Rates                       |
*-------------------------------------------------------------------------------------*;
proc sql;
    create table covid_labor_supply as
    select  distinct
            YearQuarter,

/* Labor Force Status | All */
            sum( case when Unemp=1 and Female=1 then WTFINL else 0 end )
              / sum( case when in_LF=1 and Female=1 then WTFINL else 0 end )
                as UE_Women            label="Unemployment Rate"  format=percent9.1 ,
            sum( case when in_LF=1 and Female=1 then WTFINL else 0 end )
              / sum( case when Female=1 then WTFINL else 0 end )
                as LFP_Women           label="LFP Rate"           format=percent9.1 ,

/* Unemployment | By Race and Ethnicity */
            sum( case when Race_Ethnic=1 and Unemp=1 and Female=1 then WTFINL else 0 end )
              / sum( case when Race_Ethnic=1 and in_LF=1 and Female=1 then WTFINL else 0 end )
                as UE_BlackWomen       label="Black Women"        format=percent9.1 ,
            sum( case when Race_Ethnic=2 and Unemp=1 and Female=1 then WTFINL else 0 end )
              / sum( case when Race_Ethnic=2 and in_LF=1 and Female=1 then WTFINL else 0 end )
                as UE_HispanicWomen    label="Hispanic Women"     format=percent9.1 ,
            sum( case when Race_Ethnic=3 and Unemp=1 and Female=1 then WTFINL else 0 end )
              / sum( case when Race_Ethnic=3 and in_LF=1 and Female=1 then WTFINL else 0 end )
                as UE_WhiteWomen       label="White Women"        format=percent9.1 ,
            sum( case when Race_Ethnic=4 and Unemp=1 and Female=1 then WTFINL else 0 end )
              / sum( case when Race_Ethnic=4 and in_LF=1 and Female=1 then WTFINL else 0 end )
                as UE_OtherWomen       label="All Other Women"    format=percent9.1 ,

/* Unemployment | By Education */
            sum( case when EDUC_LTD=1 and Unemp=1 and Female=1 then WTFINL else 0 end )
              / sum( case when EDUC_LTD=1 and in_LF=1 and Female=1 then WTFINL else 0 end )
                as UE_Women_LTHS       label="EDUC < HS"          format=percent9.1 ,
            sum( case when EDUC_LTD=2 and Unemp=1 and Female=1 then WTFINL else 0 end )
              / sum( case when EDUC_LTD=2 and in_LF=1 and Female=1 then WTFINL else 0 end )
                as UE_Women_HS         label="EDUC = HS"          format=percent9.1 ,
            sum( case when EDUC_LTD=3 and Unemp=1 and Female=1 then WTFINL else 0 end )
              / sum( case when EDUC_LTD=3 and in_LF=1 and Female=1 then WTFINL else 0 end )
                as UE_Women_SCollege   label="Some College"       format=percent9.1 ,
            sum( case when EDUC_LTD=4 and Unemp=1 and Female=1 then WTFINL else 0 end )
              / sum( case when EDUC_LTD=4 and in_LF=1 and Female=1 then WTFINL else 0 end )
                as UE_Women_CollegeP   label="College +"          format=percent9.1 ,

/* Unemployment | By Child Status */
            sum( case when Child_Status=0 and Unemp=1 and Female=1 then WTFINL else 0 end )
              / sum( case when Child_Status=0 and in_LF=1 and Female=1 then WTFINL else 0 end )
                as UE_Women_NoKids     label="No Children"        format=percent9.1 ,
            sum( case when Child_Status=1 and Unemp=1 and Female=1 then WTFINL else 0 end )
              / sum( case when Child_Status=1 and in_LF=1 and Female=1 then WTFINL else 0 end )
                as UE_Women_OlderKids  label="Older Children"     format=percent9.1 ,
            sum( case when Child_Status=2 and Unemp=1 and Female=1 then WTFINL else 0 end )
              / sum( case when Child_Status=2 and in_LF=1 and Female=1 then WTFINL else 0 end )
                as UE_Women_YoungKids  label="Young Children"     format=percent9.1
    from    cps
    group   by YearQuarter
    order   by YearQuarter;
quit;

*-------------------------------------------------------------------------------------*
|                       Backup Tables - Rates by Quarter                               |
*-------------------------------------------------------------------------------------*;
title3 "Unemployment Rates | Overall and by Group";
proc print data=covid_labor_supply noobs label;
    var YearQuarter UE_Women UE_BlackWomen UE_HispanicWomen UE_WhiteWomen UE_OtherWomen
        UE_Women_LTHS UE_Women_HS UE_Women_SCollege UE_Women_CollegeP
        UE_Women_NoKids UE_Women_OlderKids UE_Women_YoungKids;
run;

title3 "Labor Force Participation | Overall";
proc print data=covid_labor_supply noobs label;
    var YearQuarter LFP_Women;
run;
