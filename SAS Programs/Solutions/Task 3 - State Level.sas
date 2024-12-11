*-------------------------------------------------------------------------------------------------------*
|		                                 	 SAS On-the-Job                      	       				|
|                   		COVID and Female Labor Supply - Task 3 - State Level             		    |
*-------------------------------------------------------------------------------------------------------*;
libname 	ipums "./HHS_CodingProblemSet/SAS Data";
options 	orientation=landscape mlogic symbolgen pageno=1 error=3;

title1 		h=2pct 		"SAS On-the-Job | COVID and Female Labor Supply";
title2 		h=1.75pct 	"Task 3 - State-Level Analysis";
footnote 	h=1.25pct 	"File = COVID and Female Labor Supply - Task 3 - State Level";


*-------------------------------------------------------------------------------------*
|			                       Load CPS Formats                        		  	  |
*-------------------------------------------------------------------------------------*;
proc format cntlin = ipums.CPS_f;
run;


*-------------------------------------------------------------------------------------*
|    	   						  Collapse Data 									  | 
|	                    	Produce US-Wide Estimates             	          		  |
*-------------------------------------------------------------------------------------*;

********************************************************  All US ;
proc sql;
	create 	table covid_labor_supply2 as 
	select	distinct State_FIP as statefip format statefip_f., 
			YearQuarter, 

/*******************************************************************  Labor Force Status | All  */
			sum( ( unemp=1 ) * WTFINL * (female=1) ) 						/ sum( ( in_LF=1 ) 						*  WTFINL * (female=1) )	as UE_Women				label="Unemployment Rate"	format percent9.1 		,
			sum( ( in_LF=1 ) * WTFINL * (female=1) ) 						/ sum(  				   				   WTFINL * (female=1) ) 	as LFP_Women			label="LFP Rate"			format percent9.1 		,


/*******************************************************************  Labor Force Status | By Education  */

			/*******************************************************  Unemployment */
			sum( ( educ_ltd=2 ) * ( unemp=1 ) * WTFINL * (female=1) ) 		/ sum( ( educ_ltd=2 ) * ( in_LF=1 ) 	* WTFINL * (female=1) ) 	as UE_Women_HS			label="EDUC <= HS" 		format percent9.1 		,
			sum( ( educ_ltd=3 ) * ( unemp=1 ) * WTFINL * (female=1) ) 		/ sum( ( educ_ltd=3 ) * ( in_LF=1 ) 	* WTFINL * (female=1) ) 	as UE_Women_SCollege	label="Some College"	format percent9.1 		,
			sum( ( educ_ltd=4 ) * ( unemp=1 ) * WTFINL * (female=1) ) 		/ sum( ( educ_ltd=4 ) * ( in_LF=1 ) 	* WTFINL * (female=1) ) 	as UE_Women_CollegeP	label="College +" 		format percent9.1 		,

			/*******************************************************  LFP */
			sum( ( educ_ltd=2 ) * ( in_LF=1 ) * WTFINL * (female=1) ) 		/ sum( ( educ_ltd=2 ) 					* WTFINL * (female=1) ) 	as LFP_Women_HS			label="EDUC <= HS" 		format percent9.1 		,
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

	from 	ipums.CPS_2015_2023_ltd
	group	by 1,2 
	order	by 1,2 ;
quit;


*-----------------------------------------------------------------------------------------*
|    	   				Transpose Data to Prepare for SGPANEL Plots						  | 
*-----------------------------------------------------------------------------------------*;
proc transpose data=covid_labor_supply2 out=tran1 (rename=(_label_=Group));
	by statefip yearquarter ;
run;


data 	ue 	(keep=statefip yearquarter group ue_rate)
		lfp (keep=statefip yearquarter group lfp_rate);
	set tran1 ;

	label 	group="Group" ;

	if 	index(_name_,"UE_")=1 then do;
		UE_Rate 		= col1 ;
		label 	UE_Rate = "Unemployment Rate" ;
		format 	UE_Rate percent9.1 ;
		output	ue ;
	end;

	else if index(_name_,"LFP_")=1 then do;
		LFP_Rate 		= col1 ;
		label 	LFP_Rate= "Labor Force Participation Rate" ;
		format 	LFP_Rate percent9.1 ;
		output	lfp ;
	end;
run;


**********************************************  Set up ODS Location to Save Data;
ods listing close;
ods pdf file="./HHS_CodingProblemSet/Output/SAS On-the-Job - COVID and Female Labor Supply - Part 2 - &sysdate..pdf";

ods graphics / height=1400 width=2000;

*-----------------------------------------------------------------------------------------*
|		    	   				Unemployment Rate Analysis				  				  | 
*-----------------------------------------------------------------------------------------*;

**********************************************  By Education Level;
title3 h=1.75pct "Unemployment Analysis | By Education Level";
proc sgpanel data=ue;
	where group in ("Unemployment Rate" "EDUC <= HS" "Some College" "College +");
	panelby statefip / columns=3 rows=3 novarname ROWHEADERPOS=right ;
	series y=UE_Rate  x=YearQuarter 		/ group=group lineattrs=(thickness=2 pattern=solid);
	keylegend / title="" position=bottom;
	colaxis fitpolicy=thin valuesformat=yyq9. ;
run;
quit;


**********************************************   By Child Status;
title3 h=1.75pct "Unemployment Analysis | By Child Status";
proc sgpanel data=ue;
	where group in ("Unemployment Rate" "No Children" "Young Children" "Older Children");
	panelby statefip / columns=3 rows=3 novarname ROWHEADERPOS=right ;
	series y=UE_Rate  x=YearQuarter 		/ group=group lineattrs=(thickness=2 pattern=solid);
	keylegend / title="" position=bottom;
	colaxis fitpolicy=thin valuesformat=yyq9. ;
run;
quit;


*-----------------------------------------------------------------------------------------*
|		    	   						LFP Rate Analysis				  				  | 
*-----------------------------------------------------------------------------------------*;
	  
**********************************************  By Education Level;
title3 h=1.75pct "Labor Force Participation Rate Analysis | By Education Level";
proc sgpanel data=lfp;
	where group in ("Labor Force Participation Rate Rate" "EDUC <= HS" "Some College" "College +");
	panelby statefip / columns=3 rows=3 novarname ROWHEADERPOS=right ;
	series y=lfp_Rate  x=YearQuarter 		/ group=group lineattrs=(thickness=2 pattern=solid);
	keylegend / title="" position=bottom;
	colaxis fitpolicy=thin valuesformat=yyq9. ;
run;
quit;


**********************************************   By Child Status;
title3 h=1.75pct "Labor Force Participation Rate Analysis | By Child Status";
proc sgpanel data=lfp;
	where group in ("Labor Force Participation Rate Rate" "No Children" "Young Children" "Older Children");
	panelby statefip / columns=3 rows=3 novarname ROWHEADERPOS=right ;
	series y=lfp_Rate  x=YearQuarter 		/ group=group lineattrs=(thickness=2 pattern=solid);
	keylegend / title="" position=bottom;
	colaxis fitpolicy=thin valuesformat=yyq9. ;
run;
quit;


ods pdf close;
ods listing;
