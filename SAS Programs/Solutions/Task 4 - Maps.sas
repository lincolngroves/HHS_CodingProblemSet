*-------------------------------------------------------------------------------------------------------*
|		                                 	 SAS On-the-Job                      	       				|
|                   	 	COVID and Female Labor Supply - Task 4 - Maps             				    |
*-------------------------------------------------------------------------------------------------------*;
libname 	ipums "./HHS_CodingProblemSet/SAS Data";
options 	orientation=landscape mlogic symbolgen pageno=1 error=3;

title1 		h=2pct 		"SAS On-the-Job | COVID and Female Labor Supply";
title2 		h=2.25pct 	"Task 4 - Geographic Mapping";
footnote 	h=1.25pct 	"File = COVID and Female Labor Supply - Task 4 - Maps";


*-------------------------------------------------------------------------------------*
|			                       Load CPS Formats                        		  	  |
*-------------------------------------------------------------------------------------*;
proc format cntlin = ipums.CPS_f;
run;


*-------------------------------------------------------------------------------------*
|    	   					Prepare Data for Maps									  | 
*-------------------------------------------------------------------------------------*;

*******************************************  Format LFP ranges to make graphs prettier  ;
proc format;
	value range_fmt
	1="<55%"
	2="55-60%"
	3="60-65%"
	4="65-70%"
	5="70-75%"
	6="75-80%"
	7="80-85"
	8=">=85%"
	;
run;


*******************************************  Create New Variables ;
data lfp1;
	set lfp;
	state = STATEFIP ;			/* Need a variable named "state" for proc gmap */ 


*******************************************  New Date Variables to Help with Map Titles ;
	year2=.; 
	year2=put(yearquarter,year4.);

	month2=put(yearquarter,monname3.);

	format day2 z2.;
	day2=.; day2=put(yearquarter,day.);

*******************************************  Format LFP ranges to make graphs prettier  ;
	format LFP_Range range_fmt.;

	lfp_range=.;

		 if lfp_rate<.55 	then lfp_range=1;
	else if lfp_rate<.60 	then lfp_range=2;
	else if lfp_rate<.65 	then lfp_range=3;
	else if lfp_rate<.70 	then lfp_range=4;
	else if lfp_rate<.75 	then lfp_range=5;
	else if lfp_rate<.80 	then lfp_range=6;
	else if lfp_rate<.85 	then lfp_range=7;
	else if lfp_rate>=.85 	then lfp_range=8;
run;


*******************************************  Sort Data Proc GMAP ;
proc sort;
	by yearquarter state ;
run;



*-------------------------------------------------------------------------------------*
|    	   					Prepare Global Options for Maps 						  | 
*-------------------------------------------------------------------------------------*;

********************************************* Creates the gif animation ;
options dev=sasprtc printerpath=gif animduration=1.5 animloop=1 
 animoverlay=no animate=start center nobyline;

********************************************* Format GIF ;
goptions gunit=pct border device=gif
	 ctitle=gray33 ctext=gray33 
	 ftitle='albany amt' ftext='albany amt'
	 htitle=3.7 htext=2.3;

********************************************* Format Legend ;
legend1  label=(position=top h=1.5 j=c "Labor Force" j=c "Participation Rate")
		 value=(h=1.5 justify=center)
		 position=(bottom right) across=2 
		 shape=bar(.15in,.15in) offset=(0,8);

********************************************* Color scheme ;
pattern1 v=s c=cxd73027;
pattern2 v=s c=cxf46d43;
pattern3 v=s c=cxfdae61;
pattern4 v=s c=cxfee08b;
pattern5 v=s c=cxd9ef8b;
pattern6 v=s c=cxa6d96a;
pattern7 v=s c=cx66bd63;
pattern8 v=s c=cx1a9850;

********************************************* Specify Location for the Maps ;
filename odsout "./HHS_CodingProblemSet/Output";



*-------------------------------------------------------------------------------------*
| 				   	   			Single Map | All Women		  						  | 
*-------------------------------------------------------------------------------------*;


********************************************* Prepare ODS Output ;
ods listing close;
	ods html path=odsout body="lfp_rate_all.html" 
	 (title="US Labor Force Participation Map") 
	 style=htmlblue;


********************************************* Map Time ;
proc gmap map=mapsgfk.us data=lfp1;
	where Group = "LFP Rate" ;
	by yearquarter ;
	id state;
	choro lfp_range / midpoints= 1 2 3 4 5 6 7 8
	coutline=gray99
	legend=legend1 
	des='' name="lfp_rate_all" ;

	title3 "LFP Rate, All | Quarter = #byval(yearquarter)" ;
run;

quit;

ods html close;
ods listing;


*-------------------------------------------------------------------------------------*
| 				   	   				Macro Time!				  						  | 
*-------------------------------------------------------------------------------------*;

%macro loopy(name1,group1,title1);
	********************************************* Prepare ODS Output ;
	ods listing close;
		ods html path=odsout body="&name1..html" 
		 (title="US Labor Force Participation Map") 
		 style=htmlblue;


	********************************************* Map Time ;
	proc gmap map=mapsgfk.us data=lfp1;
		where Group = &group1 ;
		by yearquarter ;
		id state;
		choro lfp_range / midpoints= 1 2 3 4 5 6 7 8
		coutline=gray99
		legend=legend1 
		des='' name="&name1" ;	/*  Note, there will be a number of GIF files create - use the most recent version */

		title3 "LFP Rate, &title1 | Quarter = #byval(yearquarter)" ;
	run;

	quit;

	ods html close;
	ods listing;
%mend;

%loopy(lfp_rate_ltHS,		"EDUC <= HS",		Education <= High School);
%loopy(lfp_rate_SCol,		"Some College",		Education is Some College);
%loopy(lfp_rate_College,	"College +",		Education is College +);

%loopy(lfp_rate_nKid,		"No Children",		No Children);
%loopy(lfp_rate_oKid,		"Older Children",	Older Children);
%loopy(lfp_rate_yKid,		"Young Children",	Children < 5);
