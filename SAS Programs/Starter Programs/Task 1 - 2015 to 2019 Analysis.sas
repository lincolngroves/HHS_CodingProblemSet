*-------------------------------------------------------------------------------------------------------*
|		                                 	 SAS On-the-Job                      	       				|
|                         COVID and Female Labor Supply - Task 1 - 2015 to 2019 Analysis                |
*-------------------------------------------------------------------------------------------------------*;
%let 		path = /workspaces/myfolder;
libname 	ipums "&path./HHS_CodingProblemSet/SAS Data";
options 	orientation=landscape mlogic symbolgen pageno=1 error=3;

title1 		h=2pct 		"SAS On-the-Job | COVID and Female Labor Supply";
title2 		h=1.75pct 	"Task 1 - 2015 to 2019 Analysis";
footnote 	h=1.25pct 	"File = COVID and Female Labor Supply - Task 1 - 2015 to 2019 Analysis";


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
	create 	table covid_labor_supply0 as 
	select	distinct 
			YearQuarter , 

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


	from 	ipums.cps_2015_2019_ltd
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


*-------------------------------------------------------------------------------------*
|		 	   				Unemployment Rate Analysis							  	  |	 
*-------------------------------------------------------------------------------------*;

***********************************************  Format axis for current range ;
axis2 	order=(0 to .20 by .02) offset=(0,0) label=none minor=(n=1);


**********************************************  Unemployment - By Race and Ethnicity;
title3 h=1.75pct "Unemployment Analysis | By Race and Ethnicity";
proc gplot data=covid_labor_supply0;
   plot ( UE_Women 	) 														* YearQuarter 
   		( UE_BlackWomen UE_HispanicWomen UE_WhiteWomen UE_OtherWomen ) 		* YearQuarter 
		 /	overlay
			legend=legend1
	        vaxis=axis2
	        vref=0 to .20 by .05
	        lvref=2;
run;
quit;


**********************************************  Unemployment - By Education;
title3 h=1.75pct "Unemployment Analysis | By Education Level";
proc gplot data=covid_labor_supply0;
   plot ( UE_Women 	) 														* YearQuarter 
   		( UE_Women_LTHS UE_Women_HS UE_Women_SCollege UE_Women_CollegeP ) 	* YearQuarter 
		 /	overlay
			legend=legend1
	        vaxis=axis2
	        vref=0 to .20 by .05
	        lvref=2;
run;
quit;


**********************************************  Unemployment - By Child Status;
title3 h=1.75pct "Unemployment Analysis | By Child Status";
proc gplot data=covid_labor_supply0;
   plot ( UE_Women 	) 														* YearQuarter 
   		( UE_Women_NoKids UE_Women_OlderKids UE_Women_YoungKids ) 			* YearQuarter 
		 /	overlay
			legend=legend1
	        vaxis=axis2
	        vref=0 to .20 by .05
	        lvref=2;
run;
quit;


*-------------------------------------------------------------------------------------*
|		 	    			Labor Force Participation Analysis						  | 
*-------------------------------------------------------------------------------------*;

***********************************************  Format axis for current range ;
axis2 	order=(.60 to 1 by .05) offset=(0,0) label=none minor=(n=1);


**********************************************  Labor Force Participation - By Race and Ethnicity;
title3 h=1.75pct "Labor Force Participation Analysis | By Race and Ethnicity";
proc gplot data=covid_labor_supply0;
   plot ( LFP_Women 	) 														* YearQuarter 
   		( LFP_BlackWomen LFP_HispanicWomen LFP_WhiteWomen LFP_OtherWomen ) 		* YearQuarter 
		 /	overlay
			legend=legend1
	        vaxis=axis2
	        vref=.60 to 1 by .05
	        lvref=2;
run;
quit;


**********************************************  Labor Force Participation - By Education;
title3 h=1.75pct "Labor Force Participation Analysis | By Education Level";
proc gplot data=covid_labor_supply0;
   plot ( LFP_Women 	) 														* YearQuarter 
   		( LFP_Women_LTHS LFP_Women_HS LFP_Women_SCollege LFP_Women_CollegeP ) 	* YearQuarter 
		 /	overlay
			legend=legend1
	        vaxis=axis2
	        vref=.60 to 1 by .05
	        lvref=2;
run;
quit;


**********************************************  Labor Force Participation - By Child Status;
title3 h=1.75pct "Labor Force Participation Analysis | By Child Status";
proc gplot data=covid_labor_supply0;
   plot ( LFP_Women 	) 														* YearQuarter 
   		( LFP_Women_NoKids LFP_Women_OlderKids LFP_Women_YoungKids ) 			* YearQuarter 
		 /	overlay
			legend=legend1
	        vaxis=axis2
	        vref=.60 to 1 by .05
	        lvref=2;
run;
quit;


*-------------------------------------------------------------------------------------*
|		 	   					Part 3:	Producing Backup Tables						  | 
*-------------------------------------------------------------------------------------*;
title3 h=1.75pct "Backup Tables - Unemployment Rates";
proc print data=covid_labor_supply0 noobs label;
	var YearQuarter ue_: ;
run;

title3 h=1.75pct "Backup Tables - Labor Force Participation Rates";
proc print data=covid_labor_supply0 noobs label;
	var YearQuarter lfp_: ;
run;
