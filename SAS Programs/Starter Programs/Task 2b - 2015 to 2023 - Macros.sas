*-------------------------------------------------------------------------------------------------------*
|		                                 	 SAS On-the-Job                      	       				|
|                 COVID and Female Labor Supply - Task 2b - 2015 to 2023 Analysis - Macros    		    |
*-------------------------------------------------------------------------------------------------------*;
libname 	ipums "./HHS_CodingProblemSet/SAS Data";
options 	orientation=landscape mlogic symbolgen pageno=1 error=3;

title1 		h=2pct 		"SAS On-the-Job | COVID and Female Labor Supply";
title2 		h=1.75pct 	"Task 2b - 2015 to 2023 Analysis - Add Macros";
footnote 	h=1.25pct 	"File = COVID and Female Labor Supply - Task 2b - 2015 to 2023 Analysis - Macros";


*-------------------------------------------------------------------------------------*
|			                       Load CPS Formats                        		  	  |
*-------------------------------------------------------------------------------------*;
proc format cntlin = ipums.CPS_f;
run;


*-------------------------------------------------------------------------------------*
|	                    Part 1:	Produce US-Wide Estimates             	              |
*-------------------------------------------------------------------------------------*;
********************************************************  All US ;
proc sql;
	create 	table covid_labor_supply1 as 
	select	distinct 
			YearQuarter, 

/*******************************************************************  Labor Force Status | All  */
			sum( ( unemp=1 ) * WTFINL * (female=1) ) 						/ sum( ( in_LF=1 ) 						*  WTFINL * (female=1) )	as UE_Women				label="Unemployment Rate"	format percent9.1 		,
			sum( ( in_LF=1 ) * WTFINL * (female=1) ) 						/ sum(  				   				   WTFINL * (female=1) ) 	as LFP_Women			label="LFP Rate"			format percent9.1 		,


/*******************************************************************  Labor Force Status | By Race  */

			/*******************************************************  Unemployment */
			sum( ( race_ethnic=1 ) * ( unemp=1 ) * WTFINL * (female=1) ) 	/ sum( ( race_ethnic=1 ) * ( in_LF=1 ) 	* WTFINL * (female=1) ) 	as UE_BlackWomen		label="Black Women" 	format percent9.1 		,
			sum( ( race_ethnic=2 ) * ( unemp=1 ) * WTFINL * (female=1) ) 	/ sum( ( race_ethnic=2 ) * ( in_LF=1 ) 	* WTFINL * (female=1) ) 	as UE_HispanicWomen		label="Hispanic Women" 	format percent9.1 		,
			sum( ( race_ethnic=3 ) * ( unemp=1 ) * WTFINL * (female=1) ) 	/ sum( ( race_ethnic=3 ) * ( in_LF=1 ) 	* WTFINL * (female=1) ) 	as UE_WhiteWomen		label="White Women" 	format percent9.1 		,
			sum( ( race_ethnic=4 ) * ( unemp=1 ) * WTFINL * (female=1) ) 	/ sum( ( race_ethnic=4 ) * ( in_LF=1 ) 	* WTFINL * (female=1) ) 	as UE_OtherWomen		label="All Other Women" format percent9.1 		,

			/*******************************************************  LFP */
			sum( ( race_ethnic=1 ) * ( in_LF=1 ) * WTFINL * (female=1) ) 	/ sum( ( race_ethnic=1 ) 				* WTFINL * (female=1) )		as LFP_BlackWomen		label="Black Women" 	format percent9.1 		,
			sum( ( race_ethnic=2 ) * ( in_LF=1 ) * WTFINL * (female=1) ) 	/ sum( ( race_ethnic=2 ) 				* WTFINL * (female=1) ) 	as LFP_HispanicWomen	label="Hispanic Women" 	format percent9.1 		,
			sum( ( race_ethnic=3 ) * ( in_LF=1 ) * WTFINL * (female=1) ) 	/ sum( ( race_ethnic=3 ) 				* WTFINL * (female=1) ) 	as LFP_WhiteWomen		label="White Women" 	format percent9.1 		,
			sum( ( race_ethnic=4 ) * ( in_LF=1 ) * WTFINL * (female=1) ) 	/ sum( ( race_ethnic=4 ) 				* WTFINL * (female=1) )		as LFP_OtherWomen		label="All Other Women" format percent9.1 		,


/*******************************************************************  Labor Force Status | By Education  */

			/*******************************************************  Unemployment */
			sum( ( educ_ltd=1 ) * ( unemp=1 ) * WTFINL * (female=1) ) 		/ sum( ( educ_ltd=1 ) * ( in_LF=1 ) 	* WTFINL * (female=1) )	 	as UE_Women_LTHS		label="EDUC < HS" 		format percent9.1 		,
			sum( ( educ_ltd=2 ) * ( unemp=1 ) * WTFINL * (female=1) ) 		/ sum( ( educ_ltd=2 ) * ( in_LF=1 ) 	* WTFINL * (female=1) ) 	as UE_Women_HS			label="EDUC = HS" 		format percent9.1 		,
			sum( ( educ_ltd=3 ) * ( unemp=1 ) * WTFINL * (female=1) ) 		/ sum( ( educ_ltd=3 ) * ( in_LF=1 ) 	* WTFINL * (female=1) ) 	as UE_Women_SCollege	label="Some College"	format percent9.1 		,
			sum( ( educ_ltd=4 ) * ( unemp=1 ) * WTFINL * (female=1) ) 		/ sum( ( educ_ltd=4 ) * ( in_LF=1 ) 	* WTFINL * (female=1) ) 	as UE_Women_CollegeP	label="College +" 		format percent9.1 		,

			/*******************************************************  LFP */
			sum( ( educ_ltd=1 ) * ( in_LF=1 ) * WTFINL * (female=1) ) 		/ sum( ( educ_ltd=1 ) 				 	* WTFINL * (female=1) ) 	as LFP_Women_LTHS		label="EDUC < HS" 		format percent9.1 		,
			sum( ( educ_ltd=2 ) * ( in_LF=1 ) * WTFINL * (female=1) ) 		/ sum( ( educ_ltd=2 ) 					* WTFINL * (female=1) ) 	as LFP_Women_HS			label="EDUC = HS" 		format percent9.1 		,
			sum( ( educ_ltd=3 ) * ( in_LF=1 ) * WTFINL * (female=1) ) 		/ sum( ( educ_ltd=3 ) 					* WTFINL * (female=1) ) 	as LFP_Women_SCollege	label="Some College" 	format percent9.1 		,
			sum( ( educ_ltd=4 ) * ( in_LF=1 ) * WTFINL * (female=1) ) 		/ sum( ( educ_ltd=4 ) 					* WTFINL * (female=1) ) 	as LFP_Women_CollegeP	label="College +" 		format percent9.1 		,


/*******************************************************************  Labor Force Status | By Child Status  */

			/*******************************************************  Unemployment */
			sum( ( child_status=0 ) * ( unemp=1 ) * WTFINL * (female=1) ) 	/ sum( ( child_status=0 ) * ( in_LF=1 ) * WTFINL * (female=1) )	 	as UE_Women_NoKids		label="No Children" 	format percent9.1 		,
			sum( ( child_status=1 ) * ( unemp=1 ) * WTFINL * (female=1) ) 	/ sum( ( child_status=1 ) * ( in_LF=1 ) * WTFINL * (female=1) ) 	as UE_Women_OlderKids	label="Older Children" 	format percent9.1 		,
			sum( ( child_status=2 ) * ( unemp=1 ) * WTFINL * (female=1) ) 	/ sum( ( child_status=2 ) * ( in_LF=1 ) * WTFINL * (female=1) ) 	as UE_Women_YoungKids	label="Young Children"	format percent9.1 		,

			/*******************************************************  LFP */
			sum( ( child_status=0 ) * ( in_LF=1 ) * WTFINL * (female=1) ) 	/ sum( ( child_status=0 ) 				* WTFINL * (female=1) ) 	as LFP_Women_NoKids		label="No Children" 	format percent9.1 		,
			sum( ( child_status=1 ) * ( in_LF=1 ) * WTFINL * (female=1) ) 	/ sum( ( child_status=1 ) 				* WTFINL * (female=1) ) 	as LFP_Women_OlderKids	label="Older Children" 	format percent9.1 		,
			sum( ( child_status=2 ) * ( in_LF=1 ) * WTFINL * (female=1) ) 	/ sum( ( child_status=2 ) 				* WTFINL * (female=1) ) 	as LFP_Women_YoungKids	label="Young Children"	format percent9.1 		


	from 	ipums.CPS_2015_2023_LTD
	group	by 1 
	order	by 1 ;
quit;



*-------------------------------------------------------------------------------------*
| 	   					Part 2: Producing Some Summary Graphs						  | 
|		    					 Adjust Graph Settings								  |
*-------------------------------------------------------------------------------------*;

**********************************************  Assign colors and symbols to plot lines;
symbol1 interpol=join line=1 	color=bl 	;
symbol2 interpol=join line=2	color=b 	;
symbol3 interpol=join line=3	color=br 	;
symbol4 interpol=join line=4	color=g 	;
symbol5 interpol=join line=5	color=p 	;

**********************************************  Format Axis;
legend1 position=(top center inside)label=none mode=share frame;


**********************************************  Set up ODS Location to Save Data;
ods listing close;
ods pdf file="./HHS_CodingProblemSet/Output/SAS On-the-Job - COVID and Female Labor Supply - Part 1 - &sysdate..pdf";

*-------------------------------------------------------------------------------------*
|			 						  Macro Loops									  |
*-------------------------------------------------------------------------------------*;

************************************  Define Variable List to Simplify Coding ;
%macro hilfe(from,to,by,var1,varlist2,title);

	***********************************************  Format axis for current range ;
	axis2 	order=(&from to &to by &by ) offset=(0,0) label=none minor=(n=1);


	**********************************************  Overlay Plot ;
	title3 h=1.75pct &title;
	proc gplot data=covid_labor_supply1;
	   plot ( &var1 	)	* YearQuarter 
	   		( &varlist2 ) 	* YearQuarter 
			 /	overlay
				legend=legend1
		        vaxis=axis2
		        vref=&from to &to by .05
		        lvref=2;
	run;
	quit;

%mend;


**************************************************  Unemployment ;
%hilfe(0,.20,.02,UE_Women,UE_BlackWomen UE_HispanicWomen UE_WhiteWomen UE_OtherWomen,			"Unemployment Analysis | By Race and Ethnicity");
%hilfe(0,.20,.02,UE_Women,UE_Women_LTHS UE_Women_HS UE_Women_SCollege UE_Women_CollegeP,		"Unemployment Analysis | By Education Level");
%hilfe(0,.20,.02,UE_Women,UE_Women_NoKids UE_Women_OlderKids UE_Women_YoungKids,				"Unemployment Analysis | By Child Status");


**************************************************  Labor Force Participation ;
%hilfe(0.6,1,.05,LFP_Women,LFP_BlackWomen LFP_HispanicWomen LFP_WhiteWomen LFP_OtherWomen,		"Labor Force Participation Analysis | By Race and Ethnicity");
%hilfe(___,_,___,_________,______________________________________________________________,		"Labor Force Participation Analysis | By Education Level");
%hilfe(___,_,___,_________,______________________________________________________________,		"Labor Force Participation Analysis | By Child Status");


*-------------------------------------------------------------------------------------*
|		 	   					Part 3:	Backup Tables							  	  | 
*-------------------------------------------------------------------------------------*;

%macro backup(var,title);
	title3 h=1.75pct &title;
	proc print data=covid_labor_supply1 noobs label;
		var YearQuarter ue_: ;
	run;
%mend;

%backup(ue_:,"Backup Tables - Unemployment Rates");
%backup(lfp_:,"Backup Tables - Labor Force Participation Rates";);


ods pdf close;
ods listing;
