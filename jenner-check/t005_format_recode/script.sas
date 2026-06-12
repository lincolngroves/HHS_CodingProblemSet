*-------------------------------------------------------------------------------------------------------*
|                                       SAS On-the-Job                                                  |
|        COVID and Female Labor Supply - LFP Banding for Choropleths (Task 4 prep)                      |
*-------------------------------------------------------------------------------------------------------*;
* Adapted from "Task 4 - Maps.sas". Before drawing its state choropleths, the original recodes the    *;
* continuous LFP rate into eight banded levels with a custom PROC FORMAT, derives helper date          *;
* variables with PUT(), and sorts for mapping. That data-preparation pass is reproduced here on an     *;
* inline state-by-quarter LFP sample drawn from the CPS data.                                          *;

title1 "SAS On-the-Job | COVID and Female Labor Supply";
title2 "LFP Rate Banding by State and Quarter | Women";

*-------------------------------------------------------------------------------------*
|                       State-by-quarter LFP rates (inline sample)                     |
*-------------------------------------------------------------------------------------*;
data lfp;
    input statefip YearQuarter :yyq6. lfp_rate;
    format YearQuarter yyq6.;
    datalines;
6 2019Q4 0.7461
6 2020Q2 0.6906
6 2021Q1 0.7148
6 2023Q1 0.7563
12 2019Q4 0.7795
12 2020Q2 0.7214
12 2021Q1 0.7487
12 2023Q1 0.7646
36 2019Q4 0.7614
36 2020Q2 0.7272
36 2021Q1 0.7628
36 2023Q1 0.7883
48 2019Q4 0.7546
48 2020Q2 0.7112
48 2021Q1 0.7258
48 2023Q1 0.7621
;
run;

*-------------------------------------------------------------------------------------*
|              Format LFP ranges to make the maps prettier (Task 4)                    |
*-------------------------------------------------------------------------------------*;
proc format;
    value range_fmt
        1="<55%"
        2="55-60%"
        3="60-65%"
        4="65-70%"
        5="70-75%"
        6="75-80%"
        7="80-85%"
        8=">=85%"
    ;
run;

*-------------------------------------------------------------------------------------*
|              Create mapping variables and band the LFP rate                          |
*-------------------------------------------------------------------------------------*;
data lfp1;
    set lfp;
    state = statefip;            /* a variable named "state" for the choropleth */

    year2  = put(YearQuarter, year4.);

    format lfp_range range_fmt.;
         if lfp_rate<.55  then lfp_range=1;
    else if lfp_rate<.60  then lfp_range=2;
    else if lfp_rate<.65  then lfp_range=3;
    else if lfp_rate<.70  then lfp_range=4;
    else if lfp_rate<.75  then lfp_range=5;
    else if lfp_rate<.80  then lfp_range=6;
    else if lfp_rate<.85  then lfp_range=7;
    else if lfp_rate>=.85 then lfp_range=8;
run;

*-------------------------------------------------------------------------------------*
|              Sort for mapping (Task 4 sorts by quarter then state)                   |
*-------------------------------------------------------------------------------------*;
proc sort data=lfp1;
    by YearQuarter state;
run;

*-------------------------------------------------------------------------------------*
|              Banded LFP table and a tally of states per band                         |
*-------------------------------------------------------------------------------------*;
title3 "Banded LFP Rate by State and Quarter";
proc print data=lfp1 noobs label;
    var state year2 YearQuarter lfp_rate lfp_range;
    label state="State FIP" year2="Year" lfp_rate="LFP Rate" lfp_range="LFP Band";
    format lfp_rate percent9.1 lfp_range range_fmt.;
run;

title3 "States per LFP Band, by Quarter";
proc freq data=lfp1;
    tables YearQuarter * lfp_range / nocol norow nopercent;
    format lfp_range range_fmt.;
run;
