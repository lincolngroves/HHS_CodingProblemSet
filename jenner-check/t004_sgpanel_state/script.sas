*-------------------------------------------------------------------------------------------------------*
|                                       SAS On-the-Job                                                  |
|        COVID and Female Labor Supply - State Panels with PROC SGPANEL (Task 3)                        |
*-------------------------------------------------------------------------------------------------------*;
* Adapted from "Task 3 - State Level.sas". After reshaping the state-by-quarter rates to long form,  *;
* the original draws a PROC SGPANEL lattice with one cell per state and a series per education group. *;
* CPS microdata are an inline weighted-cell sample for two states across two quarters.                *;

title1 "SAS On-the-Job | COVID and Female Labor Supply";
title2 "State-Level Unemployment Panels | Women";

*-------------------------------------------------------------------------------------*
|                     CPS weighted cells by state (inline sample)                      |
*-------------------------------------------------------------------------------------*;
data cps;
    input State_FIP YearQuarter :yyq6. EDUC_LTD Child_Status Unemp in_LF WTFINL;
    Female = 1;
    format YearQuarter yyq6.;
    datalines;
6 2019Q4 1 0 0 0 326487
6 2019Q4 1 0 0 1 348289
6 2019Q4 1 0 1 1 27354
6 2019Q4 1 1 0 0 765149
6 2019Q4 1 1 0 1 897175
6 2019Q4 1 1 1 1 86659
6 2019Q4 1 2 0 0 206174
6 2019Q4 1 2 0 1 159396
6 2019Q4 1 2 1 1 19467
6 2019Q4 2 0 0 0 521256
6 2019Q4 2 0 0 1 1350359
6 2019Q4 2 0 1 1 73675
6 2019Q4 2 1 0 0 726194
6 2019Q4 2 1 0 1 1379480
6 2019Q4 2 1 1 1 97637
6 2019Q4 2 2 0 0 414384
6 2019Q4 2 2 0 1 433281
6 2019Q4 2 2 1 1 12797
6 2019Q4 3 0 0 0 490342
6 2019Q4 3 0 0 1 1932867
6 2019Q4 3 0 1 1 92884
6 2019Q4 3 1 0 0 453911
6 2019Q4 3 1 0 1 1773109
6 2019Q4 3 1 1 1 64828
6 2019Q4 3 2 0 0 334719
6 2019Q4 3 2 0 1 716507
6 2019Q4 3 2 1 1 21032
6 2019Q4 4 0 0 0 649416
6 2019Q4 4 0 0 1 4458272
6 2019Q4 4 0 1 1 144856
6 2019Q4 4 1 0 0 678829
6 2019Q4 4 1 0 1 2494622
6 2019Q4 4 1 1 1 22429
6 2019Q4 4 2 0 0 519937
6 2019Q4 4 2 0 1 1258817
6 2019Q4 4 2 1 1 23744
6 2020Q2 1 0 0 0 353101
6 2020Q2 1 0 0 1 174880
6 2020Q2 1 0 1 1 90529
6 2020Q2 1 1 0 0 793662
6 2020Q2 1 1 0 1 494615
6 2020Q2 1 1 1 1 179735
6 2020Q2 1 2 0 0 252328
6 2020Q2 1 2 0 1 93799
6 2020Q2 1 2 1 1 40150
6 2020Q2 2 0 0 0 718853
6 2020Q2 2 0 0 1 752394
6 2020Q2 2 0 1 1 206102
6 2020Q2 2 1 0 0 785327
6 2020Q2 2 1 0 1 1022904
6 2020Q2 2 1 1 1 232684
6 2020Q2 2 2 0 0 502374
6 2020Q2 2 2 0 1 361848
6 2020Q2 2 2 1 1 136323
6 2020Q2 3 0 0 0 671188
6 2020Q2 3 0 0 1 1589383
6 2020Q2 3 0 1 1 366423
6 2020Q2 3 1 0 0 714345
6 2020Q2 3 1 0 1 1512467
6 2020Q2 3 1 1 1 246884
6 2020Q2 3 2 0 0 397704
6 2020Q2 3 2 0 1 456058
6 2020Q2 3 2 1 1 131567
6 2020Q2 4 0 0 0 899638
6 2020Q2 4 0 0 1 3986128
6 2020Q2 4 0 1 1 552843
6 2020Q2 4 1 0 0 849624
6 2020Q2 4 1 0 1 2283598
6 2020Q2 4 1 1 1 287620
6 2020Q2 4 2 0 0 530735
6 2020Q2 4 2 0 1 1371623
6 2020Q2 4 2 1 1 98950
36 2019Q4 1 0 0 0 103957
36 2019Q4 1 0 0 1 141945
36 2019Q4 1 1 0 0 139050
36 2019Q4 1 1 0 1 255503
36 2019Q4 1 1 1 1 15792
36 2019Q4 1 2 0 0 89123
36 2019Q4 1 2 0 1 58185
36 2019Q4 2 0 0 0 279849
36 2019Q4 2 0 0 1 615702
36 2019Q4 2 0 1 1 13803
36 2019Q4 2 1 0 0 420232
36 2019Q4 2 1 0 1 864634
36 2019Q4 2 1 1 1 12619
36 2019Q4 2 2 0 0 260390
36 2019Q4 2 2 0 1 222223
36 2019Q4 2 2 1 1 35769
36 2019Q4 3 0 0 0 136739
36 2019Q4 3 0 0 1 641029
36 2019Q4 3 0 1 1 16187
36 2019Q4 3 1 0 0 179624
36 2019Q4 3 1 0 1 821353
36 2019Q4 3 1 1 1 35579
36 2019Q4 3 2 0 0 257561
36 2019Q4 3 2 0 1 297481
36 2019Q4 4 0 0 0 366978
36 2019Q4 4 0 0 1 2281032
36 2019Q4 4 0 1 1 55459
36 2019Q4 4 1 0 0 241519
36 2019Q4 4 1 0 1 1464344
36 2019Q4 4 1 1 1 26901
36 2019Q4 4 2 0 0 265869
36 2019Q4 4 2 0 1 839344
36 2019Q4 4 2 1 1 31326
36 2020Q2 1 0 0 0 27860
36 2020Q2 1 0 0 1 63894
36 2020Q2 1 0 1 1 9366
36 2020Q2 1 1 0 0 232756
36 2020Q2 1 1 0 1 147380
36 2020Q2 1 1 1 1 99315
36 2020Q2 1 2 0 0 79307
36 2020Q2 1 2 0 1 49280
36 2020Q2 1 2 1 1 32363
36 2020Q2 2 0 0 0 430280
36 2020Q2 2 0 0 1 467678
36 2020Q2 2 0 1 1 127063
36 2020Q2 2 1 0 0 413165
36 2020Q2 2 1 0 1 544465
36 2020Q2 2 1 1 1 188572
36 2020Q2 2 2 0 0 239256
36 2020Q2 2 2 0 1 125833
36 2020Q2 2 2 1 1 9092
36 2020Q2 3 0 0 0 150155
36 2020Q2 3 0 0 1 593424
36 2020Q2 3 0 1 1 122343
36 2020Q2 3 1 0 0 269426
36 2020Q2 3 1 0 1 621925
36 2020Q2 3 1 1 1 122424
36 2020Q2 3 2 0 0 98996
36 2020Q2 3 2 0 1 215191
36 2020Q2 3 2 1 1 28696
36 2020Q2 4 0 0 0 444146
36 2020Q2 4 0 0 1 2396288
36 2020Q2 4 0 1 1 301093
36 2020Q2 4 1 0 0 394901
36 2020Q2 4 1 0 1 1311100
36 2020Q2 4 1 1 1 92471
36 2020Q2 4 2 0 0 316480
36 2020Q2 4 2 0 1 570274
36 2020Q2 4 2 1 1 15809
;
run;

*-------------------------------------------------------------------------------------*
|        Collapse to state-by-quarter rates, overall and by education level            |
*-------------------------------------------------------------------------------------*;
proc sql;
    create table covid_labor_supply2 as
    select  distinct State_FIP as statefip, YearQuarter,
            sum( case when Unemp=1 and Female=1 then WTFINL else 0 end )
              / sum( case when in_LF=1 and Female=1 then WTFINL else 0 end )
                as UE_Women          label="Unemployment Rate" format=percent9.1 ,
            sum( case when EDUC_LTD=2 and Unemp=1 and Female=1 then WTFINL else 0 end )
              / sum( case when EDUC_LTD=2 and in_LF=1 and Female=1 then WTFINL else 0 end )
                as UE_Women_HS        label="EDUC <= HS"        format=percent9.1 ,
            sum( case when EDUC_LTD=3 and Unemp=1 and Female=1 then WTFINL else 0 end )
              / sum( case when EDUC_LTD=3 and in_LF=1 and Female=1 then WTFINL else 0 end )
                as UE_Women_SCollege  label="Some College"      format=percent9.1 ,
            sum( case when EDUC_LTD=4 and Unemp=1 and Female=1 then WTFINL else 0 end )
              / sum( case when EDUC_LTD=4 and in_LF=1 and Female=1 then WTFINL else 0 end )
                as UE_Women_CollegeP  label="College +"         format=percent9.1
    from    cps
    group   by State_FIP, YearQuarter
    order   by State_FIP, YearQuarter;
quit;

*-----------------------------------------------------------------------------------------*
|              Transpose to long form, then keep the unemployment rows                     |
*-----------------------------------------------------------------------------------------*;
proc transpose data=covid_labor_supply2 out=tran1 (rename=(_label_=Group));
    by statefip YearQuarter;
run;

data ue (keep=statefip YearQuarter Group UE_Rate);
    set tran1;
    label Group="Group";
    if index(upcase(_name_),"UE_")=1 then do;
        UE_Rate = col1;
        format UE_Rate percent9.1;
        output ue;
    end;
run;

*-----------------------------------------------------------------------------------------*
|              Paneled series: one cell per state, a line per education group              |
*-----------------------------------------------------------------------------------------*;
title3 "Unemployment Analysis | By Education Level";
proc sgpanel data=ue;
    panelby statefip / columns=2 rows=1 novarname;
    series y=UE_Rate x=YearQuarter / group=Group lineattrs=(thickness=2 pattern=solid);
    keylegend / title="" position=bottom;
    colaxis fitpolicy=thin valuesformat=yyq9.;
run;
