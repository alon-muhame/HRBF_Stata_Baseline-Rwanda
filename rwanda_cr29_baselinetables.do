* Elisa Rothenbuhler - Nov 10

* This do-file:
* uses the 2 datasets created in rwanda_cr28_meantestvarlist.do:
	* $resultdir/rwhrbf_hhlevelvariables.dta
	* $resultdir/rwhrbf_indlevelvariables.dta
* creates Stata .dta datasets of the results from the analysis of baseline household data based on .txt files obtained.
* merges the 2 datasets created in rwanda_cr28_meantestvarlist.do with the results from the analysis of baseline household data. The goal is to obtain standardized tables assessing the balance of the sample at baseline, for household-level variables and individual-level variables (including general-level variables, spouse-level variables, mother-level variables, youngest-level variables).


version 10.0
clear
set more off
set mem 500m
cap log close

#delimit ;

log using $logdir/rwanda_cr29_baselinetables.log, replace;


*******************************************************
*** Save all .txt output files into .dta Stata datasets
*******************************************************;

foreach el in means_all means_head means_spouse means_mother means_youngest {;
	insheet using $tempresultdir/`el'.txt, names;
	cap drop v5;
	drop if v1=="";
	ren v1 Variable;
	ren obs Obs;
	ren mean Mean;
	ren std_dev SD;
	save $tempresultdir/`el'.dta, replace;
	clear;
};

foreach el in Fpval_all Fpval_head Fpval_spouse Fpval_mother Fpval_youngest {;
	insheet using $tempresultdir/`el'.txt, names;
	cap drop v3 v4 v5;
	drop if v1=="";
	ren v1 Variable;
	ren ftest_pvalue Pval_Ftest;
	save $tempresultdir/`el'.dta, replace;
	clear;
};

foreach el in a00_section5_all_t1_c a00_section5_all_t2_c a00_section5_all_t3_c a00_section5_all_t1_t2 a00_section5_all_t1_t3 a00_section5_all_t2_t3
a00_section6_all_t1_c a00_section6_all_t2_c a00_section6_all_t3_c a00_section6_all_t1_t2 a00_section6_all_t1_t3 a00_section6_all_t2_t3
a00_section7_all_t1_c a00_section7_all_t2_c a00_section7_all_t3_c a00_section7_all_t1_t2 a00_section7_all_t1_t3 a00_section7_all_t2_t3
a00_section8_all_t1_c a00_section8_all_t2_c a00_section8_all_t3_c a00_section8_all_t1_t2 a00_section8_all_t1_t3 a00_section8_all_t2_t3
a01_all_t1_c a01_all_t2_c a01_all_t3_c a01_all_t1_t2 a01_all_t1_t3 a01_all_t2_t3 
a01_head_t1_c a01_head_t2_c a01_head_t3_c a01_head_t1_t2 a01_head_t1_t3 a01_head_t2_t3 a01_spouse_t1_c a01_spouse_t2_c a01_spouse_t3_c a01_spouse_t1_t2 a01_spouse_t1_t3 a01_spouse_t2_t3 a01_youngest_t1_c a01_youngest_t2_c a01_youngest_t3_c a01_youngest_t1_t2 a01_youngest_t1_t3 a01_youngest_t2_t3 a01_mother_t1_c a01_mother_t2_c a01_mother_t3_c a01_mother_t1_t2 a01_mother_t1_t3 a01_mother_t2_t3
a02_all_t1_c a02_all_t2_c a02_all_t3_c a02_all_t1_t2 a02_all_t1_t3 a02_all_t2_t3 
a02_head_t1_c a02_head_t2_c a02_head_t3_c a02_head_t1_t2 a02_head_t1_t3 a02_head_t2_t3 a02_spouse_t1_c a02_spouse_t2_c a02_spouse_t3_c a02_spouse_t1_t2 a02_spouse_t1_t3 a02_spouse_t2_t3 a02_mother_t1_c a02_mother_t2_c a02_mother_t3_c a02_mother_t1_t2 a02_mother_t1_t3 a02_mother_t2_t3
a03_all_t1_c a03_all_t2_c a03_all_t3_c a03_all_t1_t2 a03_all_t1_t3 a03_all_t2_t3 
a03_head_t1_c a03_head_t2_c a03_head_t3_c a03_head_t1_t2 a03_head_t1_t3 a03_head_t2_t3 a03_spouse_t1_c a03_spouse_t2_c a03_spouse_t3_c a03_spouse_t1_t2 a03_spouse_t1_t3 a03_spouse_t2_t3 a03_mother_t1_c a03_mother_t2_c a03_mother_t3_c a03_mother_t1_t2 a03_mother_t1_t3 a03_mother_t2_t3
a04_b08_all_t1_c a04_b08_all_t2_c a04_b08_all_t3_c a04_b08_all_t1_t2 a04_b08_all_t1_t3 a04_b08_all_t2_t3 
a04_b08_head_t1_c a04_b08_head_t2_c a04_b08_head_t3_c a04_b08_head_t1_t2 a04_b08_head_t1_t3 a04_b08_head_t2_t3 a04_b08_spouse_t1_c a04_b08_spouse_t2_c a04_b08_spouse_t3_c a04_b08_spouse_t1_t2 a04_b08_spouse_t1_t3 a04_b08_spouse_t2_t3 a04_b08_mother_t1_c a04_b08_mother_t2_c a04_b08_mother_t3_c a04_b08_mother_t1_t2 a04_b08_mother_t1_t3 a04_b08_mother_t2_t3
a05_all_t1_c a05_all_t2_c a05_all_t3_c a05_all_t1_t2 a05_all_t1_t3 a05_all_t2_t3
a06_all_t1_c a06_all_t2_c a06_all_t3_c a06_all_t1_t2 a06_all_t1_t3 a06_all_t2_t3
a07_all_t1_c a07_all_t2_c a07_all_t3_c a07_all_t1_t2 a07_all_t1_t3 a07_all_t2_t3
a08_all_t1_c a08_all_t2_c a08_all_t3_c a08_all_t1_t2 a08_all_t1_t3 a08_all_t2_t3
b01_all_t1_c b01_all_t2_c b01_all_t3_c b01_all_t1_t2 b01_all_t1_t3 b01_all_t2_t3 
b01_mother_t1_c b01_mother_t2_c b01_mother_t3_c b01_mother_t1_t2 b01_mother_t1_t3 b01_mother_t2_t3
b02_all_t1_c b02_all_t2_c b02_all_t3_c b02_all_t1_t2 b02_all_t1_t3 b02_all_t2_t3 
b02_mother_t1_c b02_mother_t2_c b02_mother_t3_c b02_mother_t1_t2 b02_mother_t1_t3 b02_mother_t2_t3
b03_all_t1_c b03_all_t2_c b03_all_t3_c b03_all_t1_t2 b03_all_t1_t3 b03_all_t2_t3 
b03_mother_t1_c b03_mother_t2_c b03_mother_t3_c b03_mother_t1_t2 b03_mother_t1_t3 b03_mother_t2_t3
b04_all_t1_c b04_all_t2_c b04_all_t3_c b04_all_t1_t2 b04_all_t1_t3 b04_all_t2_t3 
b04_mother_t1_c b04_mother_t2_c b04_mother_t3_c b04_mother_t1_t2 b04_mother_t1_t3 b04_mother_t2_t3
b03_b04_all_t1_c b03_b04_all_t2_c b03_b04_all_t3_c b03_b04_all_t1_t2 b03_b04_all_t1_t3 b03_b04_all_t2_t3 
b03_b04_mother_t1_c b03_b04_mother_t2_c b03_b04_mother_t3_c b03_b04_mother_t1_t2 b03_b04_mother_t1_t3 b03_b04_mother_t2_t3
b05_all_t1_c b05_all_t2_c b05_all_t3_c b05_all_t1_t2 b05_all_t1_t3 b05_all_t2_t3 
b05_mother_t1_c b05_mother_t2_c b05_mother_t3_c b05_mother_t1_t2 b05_mother_t1_t3 b05_mother_t2_t3
b06_all_t1_c b06_all_t2_c b06_all_t3_c b06_all_t1_t2 b06_all_t1_t3 b06_all_t2_t3 
b06_mother_t1_c b06_mother_t2_c b06_mother_t3_c b06_mother_t1_t2 b06_mother_t1_t3 b06_mother_t2_t3
b07_all_t1_c b07_all_t2_c b07_all_t3_c b07_all_t1_t2 b07_all_t1_t3 b07_all_t2_t3 
b07_mother_t1_c b07_mother_t2_c b07_mother_t3_c b07_mother_t1_t2 b07_mother_t1_t3 b07_mother_t2_t3
b09_all_t1_c b09_all_t2_c b09_all_t3_c b09_all_t1_t2 b09_all_t1_t3 b09_all_t2_t3 
b09_mother_t1_c b09_mother_t2_c b09_mother_t3_c b09_mother_t1_t2 b09_mother_t1_t3 b09_mother_t2_t3
c01_all_t1_c c01_all_t2_c c01_all_t3_c c01_all_t1_t2 c01_all_t1_t3 c01_all_t2_t3
c02_all_t1_c c02_all_t2_c c02_all_t3_c c02_all_t1_t2 c02_all_t1_t3 c02_all_t2_t3
c03_all_t1_c c03_all_t2_c c03_all_t3_c c03_all_t1_t2 c03_all_t1_t3 c03_all_t2_t3
c04_all_t1_c c04_all_t2_c c04_all_t3_c c04_all_t1_t2 c04_all_t1_t3 c04_all_t2_t3
c05_all_t1_c c05_all_t2_c c05_all_t3_c c05_all_t1_t2 c05_all_t1_t3 c05_all_t2_t3
{;
	
	insheet using $tempresultdir/`el'.txt, names clear;
	drop line;
	ren variablename Variable;
	if strmatch("`el'","*_t1_c")==1 {;
		ren meantreatment Mean_T1;
		ren errortreatment SD_T1;
		ren nobstreatment Obs_T1;
		ren meancontrol Mean_C;
		ren errorcontrol SD_C;
		ren nobscontrol Obs_C;
		ren difference Diff_T1_C;
		ren tstat Tstat_T1_C;
		ren nobstotal Obs_total_T1_C;
		ren significance Pval_T1_C;
		ren stars stars_T1_C;
	};
	if strmatch("`el'","*_t2_c")==1 {;
		ren meantreatment Mean_T2;
		ren errortreatment SD_T2;
		ren nobstreatment Obs_T2;
		ren meancontrol Mean_C;
		ren errorcontrol SD_C;
		ren nobscontrol Obs_C;
		ren difference Diff_T2_C;
		ren tstat Tstat_T2_C;
		ren nobstotal Obs_total_T2_C;
		ren significance Pval_T2_C;
		ren stars stars_T2_C;
		drop Mean_C SD_C Obs_C;
	};
	if strmatch("`el'","*_t3_c")==1 {;
		ren meantreatment Mean_T3;
		ren errortreatment SD_T3;
		ren nobstreatment Obs_T3;
		ren meancontrol Mean_C;
		ren errorcontrol SD_C;
		ren nobscontrol Obs_C;
		ren difference Diff_T3_C;
		ren tstat Tstat_T3_C;
		ren nobstotal Obs_total_T3_C;
		ren significance Pval_T3_C;
		ren stars stars_T3_C;
		drop Mean_C SD_C Obs_C;
	};
	if strmatch("`el'","*_t1_t2")==1 {;
		ren meantreatment Mean_T1;
		ren errortreatment SD_T1;
		ren nobstreatment Obs_T1;
		ren meancontrol Mean_T2;
		ren errorcontrol SD_T2;
		ren nobscontrol Obs_T2;
		ren difference Diff_T1_T2;
		ren tstat Tstat_T1_T2;
		ren nobstotal Obs_total_T1_T2;
		ren significance Pval_T1_T2;
		ren stars stars_T1_T2;
		drop Mean_T1 SD_T1 Obs_T1;
		drop Mean_T2 SD_T2 Obs_T2;
	};
	if strmatch("`el'","*_t1_t3")==1 {;
		ren meantreatment Mean_T1;
		ren errortreatment SD_T1;
		ren nobstreatment Obs_T1;
		ren meancontrol Mean_T3;
		ren errorcontrol SD_T3;
		ren nobscontrol Obs_T3;
		ren difference Diff_T1_T3;
		ren tstat Tstat_T1_T3;
		ren nobstotal Obs_total_T1_T3;
		ren significance Pval_T1_T3;
		ren stars stars_T1_T3;
		drop Mean_T1 SD_T1 Obs_T1;
		drop Mean_T3 SD_T3 Obs_T3;
	};
	if strmatch("`el'","*_t2_t3")==1 {;
		ren meantreatment Mean_T2;
		ren errortreatment SD_T2;
		ren nobstreatment Obs_T2;
		ren meancontrol Mean_T3;
		ren errorcontrol SD_T3;
		ren nobscontrol Obs_T3;
		ren difference Diff_T2_T3;
		ren tstat Tstat_T2_T3;
		ren nobstotal Obs_total_T2_T3;
		ren significance Pval_T2_T3;
		ren stars stars_T2_T3;
		drop Mean_T2 SD_T2 Obs_T2;
		drop Mean_T3 SD_T3 Obs_T3;
	};
save $tempresultdir/`el'_essential.dta, replace;
};
	

*********************************************************************
*** Generate sequence of numbers for future reordering of the dataset
*** Start formatting
*********************************************************************;

use $resultdir/rwhrbf_hhlevelvariables.dta, clear;
cap drop nr;
cap drop Dataset;
cap drop Section;
egen nr=fill(1 2 3);
gen str11 Dataset="";
format Dataset %-11s;
gen str30 Section="";
format Section %-30s;
replace Dataset="a00" if Variable=="a5_03_1";
replace Dataset="a05/a00/a06" if Variable=="a6_02_100";
replace Dataset="a07" if Variable=="a7_01_100";
replace Dataset="a00" if Variable=="a7_03_1";
replace Dataset="a00/a08" if Variable=="a9_01_1";
replace Section="5- Housing" if Variable=="a5_03_1";
replace Section="6- Household assets" if Variable=="a6_02_100";
replace Section="7a- Transfers and other Income" if Variable=="a7_01_100";
replace Section="7b- Subjective Life Valuation" if Variable=="a7_03_1";
replace Section="9- Mortality" if Variable=="a9_01_1";
order Dataset Section;
save $resultdir/rwhrbf_hhlevelvariables.dta, replace;

use $resultdir/rwhrbf_indlevelvariables.dta, clear;
cap drop nr;
cap drop Dataset;
cap drop Section;
egen nr=fill(1 2 3);
gen str7 Dataset="";
format Dataset %-7s;
gen str47 Section="";
format Section %-47s;
replace Dataset="a01" if Variable=="a1_hhsize";
replace Dataset="a01" if Variable=="a1_02_02";
replace Dataset="a02" if Variable=="a2_03_1";
replace Dataset="a03" if Variable=="a3_01_106";
replace Dataset="a04/b08" if Variable=="a4_healthscore";
replace Dataset="b01" if Variable=="b10_00_1";
replace Dataset="b02" if Variable=="b11_01a_1";
replace Dataset="b03" if Variable=="b12_12_1";
replace Dataset="b04" if Variable=="b13_001_1";
replace Dataset="b03/b04" if Variable=="b12_12_200";
replace Dataset="b05" if Variable=="b13_022n_1";
replace Dataset="b06" if Variable=="b13_035_2";
replace Dataset="b07" if Variable=="b13_096_1";
replace Dataset="b09" if Variable=="b13_118_1";
replace Dataset="c01" if Variable=="c14_31a_100";
replace Dataset="c02" if Variable=="c15_05h_100";
replace Dataset="c03" if Variable=="c15_06_1";
replace Dataset="c04" if Variable=="c16_13_100";
replace Dataset="c05" if Variable=="c16_16_1";
replace Section="1- Household roster" if Variable=="a1_hhsize";
replace Section="1- Household roster" if Variable=="a1_02_02";
replace Section="2- Education" if Variable=="a2_03_1";
replace Section="3- Labor" if Variable=="a3_01_106";
replace Section="4- Health knowledge/13.4 Health knowledge" if Variable=="a4_healthscore";
replace Section="10-1- Health status and Utilization" if Variable=="b10_00_1";
replace Section="11- Mental Health" if Variable=="b11_01a_1";
replace Section="12- Reproductive health" if Variable=="b12_12_1";
replace Section="13.1- Pregnancy History" if Variable=="b13_001_1";
replace Section="12- Reproductive health/13.1- Pregnancy History" if Variable=="b12_12_200";
replace Section="13.2- Birth History" if Variable=="b13_022n_1";
replace Section="13.3- Antenatal and Postnatal Care" if Variable=="b13_035_2";
replace Section="13.4- Patient Satisfaction & Knowledge" if Variable=="b13_096_1";
replace Section="13.5- Height and Weight" if Variable=="b13_118_1";
replace Section="14.1- Health Status and Utilization" if Variable=="c14_31a_100";
replace Section="15- Vaccination" if Variable=="c15_05h_100";
replace Section="15- Immunization" if Variable=="c15_06_1";
replace Section="16.1- Height and Weight" if Variable=="c16_13_100";
replace Section="16.2- Anemia Tests" if Variable=="c16_16_1";
order Dataset Section;
save $resultdir/rwhrbf_indlevelvariables.dta, replace;



*********************************************************************
*** Build Baseline sample balance table for household-level variables
*********************************************************************;

use $resultdir/rwhrbf_hhlevelvariables.dta, clear;
sort Variable;
local i=0;
foreach el in $tempresultdir/means_all.dta $tempresultdir/Fpval_all.dta $tempresultdir/a00_section5_all_t1_c_essential $tempresultdir/a00_section5_all_t2_c_essential $tempresultdir/a00_section5_all_t3_c_essential $tempresultdir/a00_section5_all_t1_t2_essential $tempresultdir/a00_section5_all_t1_t3_essential $tempresultdir/a00_section5_all_t2_t3_essential
$tempresultdir/a05_all_t1_c_essential $tempresultdir/a05_all_t2_c_essential $tempresultdir/a05_all_t3_c_essential $tempresultdir/a05_all_t1_t2_essential $tempresultdir/a05_all_t1_t3_essential $tempresultdir/a05_all_t2_t3_essential
$tempresultdir/a00_section6_all_t1_c_essential $tempresultdir/a00_section6_all_t2_c_essential $tempresultdir/a00_section6_all_t3_c_essential $tempresultdir/a00_section6_all_t1_t2_essential $tempresultdir/a00_section6_all_t1_t3_essential $tempresultdir/a00_section6_all_t2_t3_essential
$tempresultdir/a06_all_t1_c_essential $tempresultdir/a06_all_t2_c_essential $tempresultdir/a06_all_t3_c_essential $tempresultdir/a06_all_t1_t2_essential $tempresultdir/a06_all_t1_t3_essential $tempresultdir/a06_all_t2_t3_essential
$tempresultdir/a07_all_t1_c_essential $tempresultdir/a07_all_t2_c_essential $tempresultdir/a07_all_t3_c_essential $tempresultdir/a07_all_t1_t2_essential $tempresultdir/a07_all_t1_t3_essential $tempresultdir/a07_all_t2_t3_essential
$tempresultdir/a00_section7_all_t1_c_essential $tempresultdir/a00_section7_all_t2_c_essential $tempresultdir/a00_section7_all_t3_c_essential $tempresultdir/a00_section7_all_t1_t2_essential $tempresultdir/a00_section7_all_t1_t3_essential $tempresultdir/a00_section7_all_t2_t3_essential
$tempresultdir/a00_section8_all_t1_c_essential $tempresultdir/a00_section8_all_t2_c_essential $tempresultdir/a00_section8_all_t3_c_essential $tempresultdir/a00_section8_all_t1_t2_essential $tempresultdir/a00_section8_all_t1_t3_essential $tempresultdir/a00_section8_all_t2_t3_essential
$tempresultdir/a08_all_t1_c_essential $tempresultdir/a08_all_t2_c_essential $tempresultdir/a08_all_t3_c_essential $tempresultdir/a08_all_t1_t2_essential $tempresultdir/a08_all_t1_t3_essential $tempresultdir/a08_all_t2_t3_essential {;
	local i=`i'+1;
	merge Variable using `el', unique sort nokeep _merge(_merge`i') update;
	save $tempdatadir/rwhrbf_hhlevelvariables_merge`i'.dta, replace;
	local ntot=`i';
};
tab1 _merge*;
drop _merge*;
cap drop v3;

forvalues v=1(1)`ntot' {;
	cap erase $tempdatadir/rwhrbf_hhlevelvariables_merge`v'.dta;
};

foreach var of varlist Obs Mean SD {;
	assert `var'!="";
};

foreach var of varlist Obs Mean SD Pval_Ftest {;
	destring `var', replace;
};

gen stars_Ftest="";
replace stars_Ftest="*" if Pval_Ftest<0.1;
replace stars_Ftest="**" if Pval_Ftest<0.05;
replace stars_Ftest="***" if Pval_Ftest<0.01;

order nr Dataset Section Variable Variable_label Mean SD Obs Pval_Ftest stars_Ftest stars_T1_C stars_T2_C stars_T3_C stars_T1_T2 stars_T1_T3 stars_T2_T3 Mean_T1 Obs_T1 Mean_T2 Obs_T2 Mean_T3 Obs_T3 Mean_C Obs_C Pval_T1_C Pval_T2_C Pval_T3_C Pval_T1_T2 Pval_T1_T3 Pval_T2_T3 SD_T1 SD_T2 SD_T3 SD_C Diff_T1_C Diff_T2_C Diff_T3_C Diff_T1_T2 Diff_T1_T3 Diff_T2_T3 Tstat_T1_C Tstat_T2_C Tstat_T3_C Tstat_T1_T2 Tstat_T1_T3 Tstat_T2_T3 Obs_total_T1_C Obs_total_T2_C Obs_total_T3_C Obs_total_T1_T2 Obs_total_T1_T3 Obs_total_T2_T3; 
keep nr Dataset Section Variable Variable_label Mean SD Obs Pval_Ftest stars_Ftest stars_T1_C stars_T2_C stars_T3_C stars_T1_T2 stars_T1_T3 stars_T2_T3 Mean_T1 Obs_T1 Mean_T2 Obs_T2 Mean_T3 Obs_T3 Mean_C Obs_C Pval_T1_C Pval_T2_C Pval_T3_C Pval_T1_T2 Pval_T1_T3 Pval_T2_T3 SD_T1 SD_T2 SD_T3 SD_C Diff_T1_C Diff_T2_C Diff_T3_C Diff_T1_T2 Diff_T1_T3 Diff_T2_T3 Tstat_T1_C Tstat_T2_C Tstat_T3_C Tstat_T1_T2 Tstat_T1_T3 Tstat_T2_T3 Obs_total_T1_C Obs_total_T2_C Obs_total_T3_C Obs_total_T1_T2 Obs_total_T1_T3 Obs_total_T2_T3; 

foreach var of varlist Obs Obs_T1 Obs_T2 Obs_T3 Obs_C Obs_total_T1_C Obs_total_T2_C Obs_total_T3_C Obs_total_T1_T2 Obs_total_T1_T3 Obs_total_T2_T3 {;
	format `var' %6.0f;
};
foreach var of varlist Mean SD Pval_Ftest Mean_T1 SD_T1 Mean_T2 SD_T2 Mean_T3 SD_T3 Mean_C SD_C Pval_T1_C Pval_T2_C Pval_T3_C Pval_T1_T2 Pval_T1_T3 Pval_T2_T3 Diff_T1_C Diff_T2_C Diff_T3_C Diff_T1_T2 Diff_T1_T3 Diff_T2_T3 {;
	format `var' %20.3f;
};
foreach var of varlist Tstat_T1_C Tstat_T2_C Tstat_T3_C Tstat_T1_T2 Tstat_T1_T3 Tstat_T2_T3 {;
	format `var' %7.2f;
};
foreach var of varlist Variable Variable_label {;
	format `var' %-32s;
};

sort nr;
drop nr;

save $resultdir/rwhrbf_hhlevel_baseline_balance_table_detailed.dta, replace;
outsheet using $resultdir/rwhrbf_hhlevel_baseline_balance_table_detailed.txt, replace;
erase $resultdir/rwhrbf_hhlevel_baseline_balance_table_detailed.dta;

drop Diff_T1_C Diff_T2_C Diff_T3_C Diff_T1_T2 Diff_T1_T3 Diff_T2_T3 Tstat_T1_C Tstat_T2_C Tstat_T3_C Tstat_T1_T2 Tstat_T1_T3 Tstat_T2_T3 Obs_total_T1_C Obs_total_T2_C Obs_total_T3_C Obs_total_T1_T2 Obs_total_T1_T3 Obs_total_T2_T3; 

save $tempresultdir/rwhrbf_hhlevel_baseline_balance_table.dta, replace;
outsheet using $resultdir/rwhrbf_hhlevel_baseline_balance_table.txt, replace;

* Note: add a1_hhsize to Household table (remove from individual "all" table);


**********************************************************************
*** Build baseline sample balance table for individual-level variables
*** All individuals concerned by given section (suffix "all")
**********************************************************************;

use $resultdir/rwhrbf_indlevelvariables.dta, clear;
sort Variable;
local i=0;
foreach el in $tempresultdir/means_all.dta $tempresultdir/Fpval_all.dta $tempresultdir/a01_all_t1_c_essential $tempresultdir/a01_all_t2_c_essential $tempresultdir/a01_all_t3_c_essential $tempresultdir/a01_all_t1_t2_essential $tempresultdir/a01_all_t1_t3_essential $tempresultdir/a01_all_t2_t3_essential $tempresultdir/a02_all_t1_c_essential $tempresultdir/a02_all_t2_c_essential $tempresultdir/a02_all_t3_c_essential $tempresultdir/a02_all_t1_t2_essential $tempresultdir/a02_all_t1_t3_essential $tempresultdir/a02_all_t2_t3_essential $tempresultdir/a03_all_t1_c_essential $tempresultdir/a03_all_t2_c_essential $tempresultdir/a03_all_t3_c_essential $tempresultdir/a03_all_t1_t2_essential $tempresultdir/a03_all_t1_t3_essential $tempresultdir/a03_all_t2_t3_essential $tempresultdir/a04_b08_all_t1_c_essential $tempresultdir/a04_b08_all_t2_c_essential $tempresultdir/a04_b08_all_t3_c_essential $tempresultdir/a04_b08_all_t1_t2_essential $tempresultdir/a04_b08_all_t1_t3_essential $tempresultdir/a04_b08_all_t2_t3_essential $tempresultdir/b01_all_t1_c_essential $tempresultdir/b01_all_t2_c_essential $tempresultdir/b01_all_t3_c_essential $tempresultdir/b01_all_t1_t2_essential $tempresultdir/b01_all_t1_t3_essential $tempresultdir/b01_all_t2_t3_essential $tempresultdir/b02_all_t1_c_essential $tempresultdir/b02_all_t2_c_essential $tempresultdir/b02_all_t3_c_essential $tempresultdir/b02_all_t1_t2_essential $tempresultdir/b02_all_t1_t3_essential $tempresultdir/b02_all_t2_t3_essential $tempresultdir/b03_all_t1_c_essential $tempresultdir/b03_all_t2_c_essential $tempresultdir/b03_all_t3_c_essential $tempresultdir/b03_all_t1_t2_essential $tempresultdir/b03_all_t1_t3_essential $tempresultdir/b03_all_t2_t3_essential $tempresultdir/b04_all_t1_c_essential $tempresultdir/b04_all_t2_c_essential $tempresultdir/b04_all_t3_c_essential $tempresultdir/b04_all_t1_t2_essential $tempresultdir/b04_all_t1_t3_essential $tempresultdir/b04_all_t2_t3_essential $tempresultdir/b03_b04_all_t1_c_essential $tempresultdir/b03_b04_all_t2_c_essential $tempresultdir/b03_b04_all_t3_c_essential $tempresultdir/b03_b04_all_t1_t2_essential $tempresultdir/b03_b04_all_t1_t3_essential $tempresultdir/b03_b04_all_t2_t3_essential $tempresultdir/b05_all_t1_c_essential $tempresultdir/b05_all_t2_c_essential $tempresultdir/b05_all_t3_c_essential $tempresultdir/b05_all_t1_t2_essential $tempresultdir/b05_all_t1_t3_essential $tempresultdir/b05_all_t2_t3_essential $tempresultdir/b06_all_t1_c_essential $tempresultdir/b06_all_t2_c_essential $tempresultdir/b06_all_t3_c_essential $tempresultdir/b06_all_t1_t2_essential $tempresultdir/b06_all_t1_t3_essential $tempresultdir/b06_all_t2_t3_essential $tempresultdir/b07_all_t1_c_essential $tempresultdir/b07_all_t2_c_essential $tempresultdir/b07_all_t3_c_essential $tempresultdir/b07_all_t1_t2_essential $tempresultdir/b07_all_t1_t3_essential $tempresultdir/b07_all_t2_t3_essential $tempresultdir/b09_all_t1_c_essential $tempresultdir/b09_all_t2_c_essential $tempresultdir/b09_all_t3_c_essential $tempresultdir/b09_all_t1_t2_essential $tempresultdir/b09_all_t1_t3_essential $tempresultdir/b09_all_t2_t3_essential $tempresultdir/c01_all_t1_c_essential $tempresultdir/c01_all_t2_c_essential $tempresultdir/c01_all_t3_c_essential $tempresultdir/c01_all_t1_t2_essential $tempresultdir/c01_all_t1_t3_essential $tempresultdir/c01_all_t2_t3_essential 
$tempresultdir/c02_all_t1_c_essential $tempresultdir/c02_all_t2_c_essential $tempresultdir/c02_all_t3_c_essential $tempresultdir/c02_all_t1_t2_essential $tempresultdir/c02_all_t1_t3_essential $tempresultdir/c02_all_t2_t3_essential
$tempresultdir/c03_all_t1_c_essential $tempresultdir/c03_all_t2_c_essential $tempresultdir/c03_all_t3_c_essential $tempresultdir/c03_all_t1_t2_essential $tempresultdir/c03_all_t1_t3_essential $tempresultdir/c03_all_t2_t3_essential
$tempresultdir/c04_all_t1_c_essential $tempresultdir/c04_all_t2_c_essential $tempresultdir/c04_all_t3_c_essential $tempresultdir/c04_all_t1_t2_essential $tempresultdir/c04_all_t1_t3_essential $tempresultdir/c04_all_t2_t3_essential
$tempresultdir/c05_all_t1_c_essential $tempresultdir/c05_all_t2_c_essential $tempresultdir/c05_all_t3_c_essential $tempresultdir/c05_all_t1_t2_essential $tempresultdir/c05_all_t1_t3_essential $tempresultdir/c05_all_t2_t3_essential {;
	local i=`i'+1;
	merge Variable using `el', unique sort nokeep _merge(_merge`i') update;
	save $tempdatadir/rwhrbf_indlevelvariables_all_merge`i'.dta, replace;
	local ntot=`i';
};
tab1 _merge*;
drop _merge*;
cap drop v3;

forvalues v=1(1)`ntot' {;
	cap erase $tempdatadir/rwhrbf_indlevelvariables_all_merge`v'.dta;
};

foreach var of varlist Obs Mean SD {;
	assert `var'!="";
};

foreach var of varlist Obs Mean SD Pval_Ftest {;
	destring `var', replace;
};

gen stars_Ftest="";
replace stars_Ftest="*" if Pval_Ftest<0.1;
replace stars_Ftest="**" if Pval_Ftest<0.05;
replace stars_Ftest="***" if Pval_Ftest<0.01;

order nr Dataset Section Variable Variable_label Mean SD Obs Pval_Ftest stars_Ftest stars_T1_C stars_T2_C stars_T3_C stars_T1_T2 stars_T1_T3 stars_T2_T3 Mean_T1 Obs_T1 Mean_T2 Obs_T2 Mean_T3 Obs_T3 Mean_C Obs_C Pval_T1_C Pval_T2_C Pval_T3_C Pval_T1_T2 Pval_T1_T3 Pval_T2_T3 SD_T1 SD_T2 SD_T3 SD_C Diff_T1_C Diff_T2_C Diff_T3_C Diff_T1_T2 Diff_T1_T3 Diff_T2_T3 Tstat_T1_C Tstat_T2_C Tstat_T3_C Tstat_T1_T2 Tstat_T1_T3 Tstat_T2_T3 Obs_total_T1_C Obs_total_T2_C Obs_total_T3_C Obs_total_T1_T2 Obs_total_T1_T3 Obs_total_T2_T3; 
keep nr Dataset Section Variable Variable_label Mean SD Obs Pval_Ftest stars_Ftest stars_T1_C stars_T2_C stars_T3_C stars_T1_T2 stars_T1_T3 stars_T2_T3 Mean_T1 Obs_T1 Mean_T2 Obs_T2 Mean_T3 Obs_T3 Mean_C Obs_C Pval_T1_C Pval_T2_C Pval_T3_C Pval_T1_T2 Pval_T1_T3 Pval_T2_T3 SD_T1 SD_T2 SD_T3 SD_C Diff_T1_C Diff_T2_C Diff_T3_C Diff_T1_T2 Diff_T1_T3 Diff_T2_T3 Tstat_T1_C Tstat_T2_C Tstat_T3_C Tstat_T1_T2 Tstat_T1_T3 Tstat_T2_T3 Obs_total_T1_C Obs_total_T2_C Obs_total_T3_C Obs_total_T1_T2 Obs_total_T1_T3 Obs_total_T2_T3;

foreach var of varlist Obs Obs_T1 Obs_T2 Obs_T3 Obs_C Obs_total_T1_C Obs_total_T2_C Obs_total_T3_C Obs_total_T1_T2 Obs_total_T1_T3 Obs_total_T2_T3 {;
	format `var' %6.0f;
};
foreach var of varlist Mean SD Pval_Ftest Mean_T1 SD_T1 Mean_T2 SD_T2 Mean_T3 SD_T3 Mean_C SD_C Pval_T1_C Pval_T2_C Pval_T3_C Pval_T1_T2 Pval_T1_T3 Pval_T2_T3 Diff_T1_C Diff_T2_C Diff_T3_C Diff_T1_T2 Diff_T1_T3 Diff_T2_T3 {;
	format `var' %20.3f;
};
foreach var of varlist Tstat_T1_C Tstat_T2_C Tstat_T3_C Tstat_T1_T2 Tstat_T1_T3 Tstat_T2_T3 {;
	format `var' %7.2f;
};
foreach var of varlist Variable Variable_label {;
	format `var' %-32s;
};

sort nr;
drop nr;

save $resultdir/rwhrbf_indlevel_baseline_balance_table_all_detailed.dta, replace;
outsheet using $resultdir/rwhrbf_indlevel_baseline_balance_table_all_detailed.txt, replace;
erase $resultdir/rwhrbf_indlevel_baseline_balance_table_all_detailed.dta;

drop Diff_T1_C Diff_T2_C Diff_T3_C Diff_T1_T2 Diff_T1_T3 Diff_T2_T3 Tstat_T1_C Tstat_T2_C Tstat_T3_C Tstat_T1_T2 Tstat_T1_T3 Tstat_T2_T3 Obs_total_T1_C Obs_total_T2_C Obs_total_T3_C Obs_total_T1_T2 Obs_total_T1_T3 Obs_total_T2_T3; 

save $tempresultdir/rwhrbf_indlevel_baseline_balance_table_all.dta, replace;
outsheet using $resultdir/rwhrbf_indlevel_baseline_balance_table_all.txt, replace;


**********************************************************************
*** Build baseline sample balance table for individual-level variables
*** Heads of household only (suffix "head")
**********************************************************************;

use $resultdir/rwhrbf_indlevelvariables.dta, clear;
sort Variable;
local i=0;
foreach el in $tempresultdir/means_head.dta $tempresultdir/Fpval_head.dta $tempresultdir/a01_head_t1_c_essential $tempresultdir/a01_head_t2_c_essential $tempresultdir/a01_head_t3_c_essential $tempresultdir/a01_head_t1_t2_essential $tempresultdir/a01_head_t1_t3_essential $tempresultdir/a01_head_t2_t3_essential $tempresultdir/a02_head_t1_c_essential $tempresultdir/a02_head_t2_c_essential $tempresultdir/a02_head_t3_c_essential $tempresultdir/a02_head_t1_t2_essential $tempresultdir/a02_head_t1_t3_essential $tempresultdir/a02_head_t2_t3_essential $tempresultdir/a03_head_t1_c_essential $tempresultdir/a03_head_t2_c_essential $tempresultdir/a03_head_t3_c_essential $tempresultdir/a03_head_t1_t2_essential $tempresultdir/a03_head_t1_t3_essential $tempresultdir/a03_head_t2_t3_essential $tempresultdir/a04_b08_head_t1_c_essential $tempresultdir/a04_b08_head_t2_c_essential $tempresultdir/a04_b08_head_t3_c_essential $tempresultdir/a04_b08_head_t1_t2_essential $tempresultdir/a04_b08_head_t1_t3_essential $tempresultdir/a04_b08_head_t2_t3_essential {;
	local i=`i'+1;
	merge Variable using `el', unique sort nokeep _merge(_merge`i') update;
	save $tempdatadir/rwhrbf_indlevelvariables_head_merge`i'.dta, replace;
	local ntot=`i';
};
tab1 _merge*;
drop _merge*;
cap drop v3;

forvalues v=1(1)`ntot' {;
	cap erase $tempdatadir/rwhrbf_indlevelvariables_head_merge`v'.dta;
};

drop if Obs=="" & Mean=="" & SD==""; 	
* Drops variables from master variable roster which were not used for the head of household;

foreach var of varlist Obs Mean SD Pval_Ftest {;
	destring `var', replace;
};

gen stars_Ftest="";
replace stars_Ftest="*" if Pval_Ftest<0.1;
replace stars_Ftest="**" if Pval_Ftest<0.05;
replace stars_Ftest="***" if Pval_Ftest<0.01;

order nr Dataset Section Variable Variable_label Mean SD Obs Pval_Ftest stars_Ftest stars_T1_C stars_T2_C stars_T3_C stars_T1_T2 stars_T1_T3 stars_T2_T3 Mean_T1 Obs_T1 Mean_T2 Obs_T2 Mean_T3 Obs_T3 Mean_C Obs_C Pval_T1_C Pval_T2_C Pval_T3_C Pval_T1_T2 Pval_T1_T3 Pval_T2_T3 SD_T1 SD_T2 SD_T3 SD_C Diff_T1_C Diff_T2_C Diff_T3_C Diff_T1_T2 Diff_T1_T3 Diff_T2_T3 Tstat_T1_C Tstat_T2_C Tstat_T3_C Tstat_T1_T2 Tstat_T1_T3 Tstat_T2_T3 Obs_total_T1_C Obs_total_T2_C Obs_total_T3_C Obs_total_T1_T2 Obs_total_T1_T3 Obs_total_T2_T3; 
keep nr Dataset Section Variable Variable_label Mean SD Obs Pval_Ftest stars_Ftest stars_T1_C stars_T2_C stars_T3_C stars_T1_T2 stars_T1_T3 stars_T2_T3 Mean_T1 Obs_T1 Mean_T2 Obs_T2 Mean_T3 Obs_T3 Mean_C Obs_C Pval_T1_C Pval_T2_C Pval_T3_C Pval_T1_T2 Pval_T1_T3 Pval_T2_T3 SD_T1 SD_T2 SD_T3 SD_C Diff_T1_C Diff_T2_C Diff_T3_C Diff_T1_T2 Diff_T1_T3 Diff_T2_T3 Tstat_T1_C Tstat_T2_C Tstat_T3_C Tstat_T1_T2 Tstat_T1_T3 Tstat_T2_T3 Obs_total_T1_C Obs_total_T2_C Obs_total_T3_C Obs_total_T1_T2 Obs_total_T1_T3 Obs_total_T2_T3;

foreach var of varlist Obs Obs_T1 Obs_T2 Obs_T3 Obs_C Obs_total_T1_C Obs_total_T2_C Obs_total_T3_C Obs_total_T1_T2 Obs_total_T1_T3 Obs_total_T2_T3 {;
	format `var' %6.0f;
};
foreach var of varlist Mean SD Pval_Ftest Mean_T1 SD_T1 Mean_T2 SD_T2 Mean_T3 SD_T3 Mean_C SD_C Pval_T1_C Pval_T2_C Pval_T3_C Pval_T1_T2 Pval_T1_T3 Pval_T2_T3 Diff_T1_C Diff_T2_C Diff_T3_C Diff_T1_T2 Diff_T1_T3 Diff_T2_T3 {;
	format `var' %20.3f;
};
foreach var of varlist Tstat_T1_C Tstat_T2_C Tstat_T3_C Tstat_T1_T2 Tstat_T1_T3 Tstat_T2_T3 {;
	format `var' %7.2f;
};
foreach var of varlist Variable Variable_label {;
	format `var' %-32s;
};

sort nr;
drop nr;

save $resultdir/rwhrbf_indlevel_baseline_balance_table_head_detailed.dta, replace;
outsheet using $resultdir/rwhrbf_indlevel_baseline_balance_table_head_detailed.txt, replace;
erase $resultdir/rwhrbf_indlevel_baseline_balance_table_head_detailed.dta;

drop Diff_T1_C Diff_T2_C Diff_T3_C Diff_T1_T2 Diff_T1_T3 Diff_T2_T3 Tstat_T1_C Tstat_T2_C Tstat_T3_C Tstat_T1_T2 Tstat_T1_T3 Tstat_T2_T3 Obs_total_T1_C Obs_total_T2_C Obs_total_T3_C Obs_total_T1_T2 Obs_total_T1_T3 Obs_total_T2_T3; 

save $tempresultdir/rwhrbf_indlevel_baseline_balance_table_head.dta, replace;
outsheet using $resultdir/rwhrbf_indlevel_baseline_balance_table_head.txt, replace;


**********************************************************************
*** Build baseline sample balance table for individual-level variables
*** Spouse only (suffix "spouse")
**********************************************************************;

use $resultdir/rwhrbf_indlevelvariables.dta, clear;
sort Variable;
local i=0;
foreach el in $tempresultdir/means_spouse.dta $tempresultdir/Fpval_spouse.dta $tempresultdir/a01_spouse_t1_c_essential $tempresultdir/a01_spouse_t2_c_essential $tempresultdir/a01_spouse_t3_c_essential $tempresultdir/a01_spouse_t1_t2_essential $tempresultdir/a01_spouse_t1_t3_essential $tempresultdir/a01_spouse_t2_t3_essential $tempresultdir/a02_spouse_t1_c_essential $tempresultdir/a02_spouse_t2_c_essential $tempresultdir/a02_spouse_t3_c_essential $tempresultdir/a02_spouse_t1_t2_essential $tempresultdir/a02_spouse_t1_t3_essential $tempresultdir/a02_spouse_t2_t3_essential $tempresultdir/a03_spouse_t1_c_essential $tempresultdir/a03_spouse_t2_c_essential $tempresultdir/a03_spouse_t3_c_essential $tempresultdir/a03_spouse_t1_t2_essential $tempresultdir/a03_spouse_t1_t3_essential $tempresultdir/a03_spouse_t2_t3_essential $tempresultdir/a04_b08_spouse_t1_c_essential $tempresultdir/a04_b08_spouse_t2_c_essential $tempresultdir/a04_b08_spouse_t3_c_essential $tempresultdir/a04_b08_spouse_t1_t2_essential $tempresultdir/a04_b08_spouse_t1_t3_essential $tempresultdir/a04_b08_spouse_t2_t3_essential {;
	local i=`i'+1;
	merge Variable using `el', unique sort nokeep _merge(_merge`i') update;
	save $tempdatadir/rwhrbf_indlevelvariables_spouse_merge`i'.dta, replace;
	local ntot=`i';
};
tab1 _merge*;
drop _merge*;
cap drop v3;

forvalues v=1(1)`ntot' {;
	cap erase $tempdatadir/rwhrbf_indlevelvariables_spouse_merge`v'.dta;
};

drop if Obs=="" & Mean=="" & SD==""; 	
* Drops variables from master variable roster which were not used for the spouse of the head of household;

foreach var of varlist Obs Mean SD Pval_Ftest {;
	destring `var', replace;
};

gen stars_Ftest="";
replace stars_Ftest="*" if Pval_Ftest<0.1;
replace stars_Ftest="**" if Pval_Ftest<0.05;
replace stars_Ftest="***" if Pval_Ftest<0.01;

order nr Dataset Section Variable Variable_label Mean SD Obs Pval_Ftest stars_Ftest stars_T1_C stars_T2_C stars_T3_C stars_T1_T2 stars_T1_T3 stars_T2_T3 Mean_T1 Obs_T1 Mean_T2 Obs_T2 Mean_T3 Obs_T3 Mean_C Obs_C Pval_T1_C Pval_T2_C Pval_T3_C Pval_T1_T2 Pval_T1_T3 Pval_T2_T3 SD_T1 SD_T2 SD_T3 SD_C Diff_T1_C Diff_T2_C Diff_T3_C Diff_T1_T2 Diff_T1_T3 Diff_T2_T3 Tstat_T1_C Tstat_T2_C Tstat_T3_C Tstat_T1_T2 Tstat_T1_T3 Tstat_T2_T3 Obs_total_T1_C Obs_total_T2_C Obs_total_T3_C Obs_total_T1_T2 Obs_total_T1_T3 Obs_total_T2_T3; 
keep nr Dataset Section Variable Variable_label Mean SD Obs Pval_Ftest stars_Ftest stars_T1_C stars_T2_C stars_T3_C stars_T1_T2 stars_T1_T3 stars_T2_T3 Mean_T1 Obs_T1 Mean_T2 Obs_T2 Mean_T3 Obs_T3 Mean_C Obs_C Pval_T1_C Pval_T2_C Pval_T3_C Pval_T1_T2 Pval_T1_T3 Pval_T2_T3 SD_T1 SD_T2 SD_T3 SD_C Diff_T1_C Diff_T2_C Diff_T3_C Diff_T1_T2 Diff_T1_T3 Diff_T2_T3 Tstat_T1_C Tstat_T2_C Tstat_T3_C Tstat_T1_T2 Tstat_T1_T3 Tstat_T2_T3 Obs_total_T1_C Obs_total_T2_C Obs_total_T3_C Obs_total_T1_T2 Obs_total_T1_T3 Obs_total_T2_T3;

foreach var of varlist Obs Obs_T1 Obs_T2 Obs_T3 Obs_C Obs_total_T1_C Obs_total_T2_C Obs_total_T3_C Obs_total_T1_T2 Obs_total_T1_T3 Obs_total_T2_T3 {;
	format `var' %6.0f;
};
foreach var of varlist Mean SD Pval_Ftest Mean_T1 SD_T1 Mean_T2 SD_T2 Mean_T3 SD_T3 Mean_C SD_C Pval_T1_C Pval_T2_C Pval_T3_C Pval_T1_T2 Pval_T1_T3 Pval_T2_T3 Diff_T1_C Diff_T2_C Diff_T3_C Diff_T1_T2 Diff_T1_T3 Diff_T2_T3 {;
	format `var' %20.3f;
};
foreach var of varlist Tstat_T1_C Tstat_T2_C Tstat_T3_C Tstat_T1_T2 Tstat_T1_T3 Tstat_T2_T3 {;
	format `var' %7.2f;
};
foreach var of varlist Variable Variable_label {;
	format `var' %-32s;
};

sort nr;
drop nr;

save $resultdir/rwhrbf_indlevel_baseline_balance_table_spouse_detailed.dta, replace;
outsheet using $resultdir/rwhrbf_indlevel_baseline_balance_table_spouse_detailed.txt, replace;
erase $resultdir/rwhrbf_indlevel_baseline_balance_table_spouse_detailed.dta;

drop Diff_T1_C Diff_T2_C Diff_T3_C Diff_T1_T2 Diff_T1_T3 Diff_T2_T3 Tstat_T1_C Tstat_T2_C Tstat_T3_C Tstat_T1_T2 Tstat_T1_T3 Tstat_T2_T3 Obs_total_T1_C Obs_total_T2_C Obs_total_T3_C Obs_total_T1_T2 Obs_total_T1_T3 Obs_total_T2_T3; 

save $tempresultdir/rwhrbf_indlevel_baseline_balance_table_spouse.dta, replace;
outsheet using $resultdir/rwhrbf_indlevel_baseline_balance_table_spouse.txt, replace;


**********************************************************************
*** Build baseline sample balance table for individual-level variables
*** Mother of youngest child in household only (suffix "mother")
**********************************************************************;

use $resultdir/rwhrbf_indlevelvariables.dta, clear;
sort Variable;
local i=0;
foreach el in $tempresultdir/means_mother.dta $tempresultdir/Fpval_mother.dta $tempresultdir/a01_mother_t1_c_essential $tempresultdir/a01_mother_t2_c_essential $tempresultdir/a01_mother_t3_c_essential $tempresultdir/a01_mother_t1_t2_essential $tempresultdir/a01_mother_t1_t3_essential $tempresultdir/a01_mother_t2_t3_essential $tempresultdir/a02_mother_t1_c_essential $tempresultdir/a02_mother_t2_c_essential $tempresultdir/a02_mother_t3_c_essential $tempresultdir/a02_mother_t1_t2_essential $tempresultdir/a02_mother_t1_t3_essential $tempresultdir/a02_mother_t2_t3_essential $tempresultdir/a03_mother_t1_c_essential $tempresultdir/a03_mother_t2_c_essential $tempresultdir/a03_mother_t3_c_essential $tempresultdir/a03_mother_t1_t2_essential $tempresultdir/a03_mother_t1_t3_essential $tempresultdir/a03_mother_t2_t3_essential $tempresultdir/a04_b08_mother_t1_c_essential $tempresultdir/a04_b08_mother_t2_c_essential $tempresultdir/a04_b08_mother_t3_c_essential $tempresultdir/a04_b08_mother_t1_t2_essential $tempresultdir/a04_b08_mother_t1_t3_essential $tempresultdir/a04_b08_mother_t2_t3_essential $tempresultdir/b01_mother_t1_c_essential $tempresultdir/b01_mother_t2_c_essential $tempresultdir/b01_mother_t3_c_essential $tempresultdir/b01_mother_t1_t2_essential $tempresultdir/b01_mother_t1_t3_essential $tempresultdir/b01_mother_t2_t3_essential $tempresultdir/b02_mother_t1_c_essential $tempresultdir/b02_mother_t2_c_essential $tempresultdir/b02_mother_t3_c_essential $tempresultdir/b02_mother_t1_t2_essential $tempresultdir/b02_mother_t1_t3_essential $tempresultdir/b02_mother_t2_t3_essential $tempresultdir/b03_mother_t1_c_essential $tempresultdir/b03_mother_t2_c_essential $tempresultdir/b03_mother_t3_c_essential $tempresultdir/b03_mother_t1_t2_essential $tempresultdir/b03_mother_t1_t3_essential $tempresultdir/b03_mother_t2_t3_essential $tempresultdir/b04_mother_t1_c_essential $tempresultdir/b04_mother_t2_c_essential $tempresultdir/b04_mother_t3_c_essential $tempresultdir/b04_mother_t1_t2_essential $tempresultdir/b04_mother_t1_t3_essential $tempresultdir/b04_mother_t2_t3_essential $tempresultdir/b03_b04_mother_t1_c_essential $tempresultdir/b03_b04_mother_t2_c_essential $tempresultdir/b03_b04_mother_t3_c_essential $tempresultdir/b03_b04_mother_t1_t2_essential $tempresultdir/b03_b04_mother_t1_t3_essential $tempresultdir/b03_b04_mother_t2_t3_essential $tempresultdir/b05_mother_t1_c_essential $tempresultdir/b05_mother_t2_c_essential $tempresultdir/b05_mother_t3_c_essential $tempresultdir/b05_mother_t1_t2_essential $tempresultdir/b05_mother_t1_t3_essential $tempresultdir/b05_mother_t2_t3_essential $tempresultdir/b06_mother_t1_c_essential $tempresultdir/b06_mother_t2_c_essential $tempresultdir/b06_mother_t3_c_essential $tempresultdir/b06_mother_t1_t2_essential $tempresultdir/b06_mother_t1_t3_essential $tempresultdir/b06_mother_t2_t3_essential $tempresultdir/b07_mother_t1_c_essential $tempresultdir/b07_mother_t2_c_essential $tempresultdir/b07_mother_t3_c_essential $tempresultdir/b07_mother_t1_t2_essential $tempresultdir/b07_mother_t1_t3_essential $tempresultdir/b07_mother_t2_t3_essential $tempresultdir/b09_mother_t1_c_essential $tempresultdir/b09_mother_t2_c_essential $tempresultdir/b09_mother_t3_c_essential $tempresultdir/b09_mother_t1_t2_essential $tempresultdir/b09_mother_t1_t3_essential $tempresultdir/b09_mother_t2_t3_essential {;
	local i=`i'+1;
	merge Variable using `el', unique sort nokeep _merge(_merge`i') update;
	save $tempdatadir/rwhrbf_indlevelvariables_youngest_merge`i'.dta, replace;
	local ntot=`i';
};
tab1 _merge*;
drop _merge*;
cap drop v3;

forvalues v=1(1)`ntot' {;
	cap erase $tempdatadir/rwhrbf_indlevelvariables_youngest_merge`v'.dta;
};

drop if Obs=="" & Mean=="" & SD==""; 	
* Drops variables from master variable roster which were not used for the mother of the youngest child in the household;

foreach var of varlist Obs Mean SD Pval_Ftest {;
	destring `var', replace;
};

gen stars_Ftest="";
replace stars_Ftest="*" if Pval_Ftest<0.1;
replace stars_Ftest="**" if Pval_Ftest<0.05;
replace stars_Ftest="***" if Pval_Ftest<0.01;

order nr Dataset Section Variable Variable_label Mean SD Obs Pval_Ftest stars_Ftest stars_T1_C stars_T2_C stars_T3_C stars_T1_T2 stars_T1_T3 stars_T2_T3 Mean_T1 Obs_T1 Mean_T2 Obs_T2 Mean_T3 Obs_T3 Mean_C Obs_C Pval_T1_C Pval_T2_C Pval_T3_C Pval_T1_T2 Pval_T1_T3 Pval_T2_T3 SD_T1 SD_T2 SD_T3 SD_C Diff_T1_C Diff_T2_C Diff_T3_C Diff_T1_T2 Diff_T1_T3 Diff_T2_T3 Tstat_T1_C Tstat_T2_C Tstat_T3_C Tstat_T1_T2 Tstat_T1_T3 Tstat_T2_T3 Obs_total_T1_C Obs_total_T2_C Obs_total_T3_C Obs_total_T1_T2 Obs_total_T1_T3 Obs_total_T2_T3; 
keep nr Dataset Section Variable Variable_label Mean SD Obs Pval_Ftest stars_Ftest stars_T1_C stars_T2_C stars_T3_C stars_T1_T2 stars_T1_T3 stars_T2_T3 Mean_T1 Obs_T1 Mean_T2 Obs_T2 Mean_T3 Obs_T3 Mean_C Obs_C Pval_T1_C Pval_T2_C Pval_T3_C Pval_T1_T2 Pval_T1_T3 Pval_T2_T3 SD_T1 SD_T2 SD_T3 SD_C Diff_T1_C Diff_T2_C Diff_T3_C Diff_T1_T2 Diff_T1_T3 Diff_T2_T3 Tstat_T1_C Tstat_T2_C Tstat_T3_C Tstat_T1_T2 Tstat_T1_T3 Tstat_T2_T3 Obs_total_T1_C Obs_total_T2_C Obs_total_T3_C Obs_total_T1_T2 Obs_total_T1_T3 Obs_total_T2_T3;

foreach var of varlist Obs Obs_T1 Obs_T2 Obs_T3 Obs_C Obs_total_T1_C Obs_total_T2_C Obs_total_T3_C Obs_total_T1_T2 Obs_total_T1_T3 Obs_total_T2_T3 {;
	format `var' %6.0f;
};
foreach var of varlist Mean SD Pval_Ftest Mean_T1 SD_T1 Mean_T2 SD_T2 Mean_T3 SD_T3 Mean_C SD_C Pval_T1_C Pval_T2_C Pval_T3_C Pval_T1_T2 Pval_T1_T3 Pval_T2_T3 Diff_T1_C Diff_T2_C Diff_T3_C Diff_T1_T2 Diff_T1_T3 Diff_T2_T3 {;
	format `var' %20.3f;
};
foreach var of varlist Tstat_T1_C Tstat_T2_C Tstat_T3_C Tstat_T1_T2 Tstat_T1_T3 Tstat_T2_T3 {;
	format `var' %7.2f;
};
foreach var of varlist Variable Variable_label {;
	format `var' %-32s;
};

sort nr;
drop nr;

save $resultdir/rwhrbf_indlevel_baseline_balance_table_mother_detailed.dta, replace;
outsheet using $resultdir/rwhrbf_indlevel_baseline_balance_table_mother_detailed.txt, replace;
erase $resultdir/rwhrbf_indlevel_baseline_balance_table_mother_detailed.dta;

drop Diff_T1_C Diff_T2_C Diff_T3_C Diff_T1_T2 Diff_T1_T3 Diff_T2_T3 Tstat_T1_C Tstat_T2_C Tstat_T3_C Tstat_T1_T2 Tstat_T1_T3 Tstat_T2_T3 Obs_total_T1_C Obs_total_T2_C Obs_total_T3_C Obs_total_T1_T2 Obs_total_T1_T3 Obs_total_T2_T3; 

save $tempresultdir/rwhrbf_indlevel_baseline_balance_table_mother.dta, replace;
outsheet using $resultdir/rwhrbf_indlevel_baseline_balance_table_mother.txt, replace;


**********************************************************************
*** Build baseline sample balance table for individual-level variables
*** Youngest child in household only (suffix "youngest")
**********************************************************************;

use $resultdir/rwhrbf_indlevelvariables.dta, clear;
sort Variable;
local i=0;
foreach el in $tempresultdir/means_youngest.dta $tempresultdir/Fpval_youngest.dta $tempresultdir/a01_youngest_t1_c_essential $tempresultdir/a01_youngest_t2_c_essential $tempresultdir/a01_youngest_t3_c_essential $tempresultdir/a01_youngest_t1_t2_essential $tempresultdir/a01_youngest_t1_t3_essential $tempresultdir/a01_youngest_t2_t3_essential {;
	local i=`i'+1;
	merge Variable using `el', unique sort nokeep _merge(_merge`i') update;
	save $tempdatadir/rwhrbf_indlevelvariables_mother_merge`i'.dta, replace;
	local ntot=`i';
};
tab1 _merge*;
drop _merge*;
cap drop v3;

forvalues v=1(1)`ntot' {;
	cap erase $tempdatadir/rwhrbf_indlevelvariables_mother_merge`v'.dta;
};

drop if Obs=="" & Mean=="" & SD==""; 	
* Drops variables from master variable roster which were not used for the youngest child in the household;

foreach var of varlist Obs Mean SD Pval_Ftest {;
	destring `var', replace;
};

gen stars_Ftest="";
replace stars_Ftest="*" if Pval_Ftest<0.1;
replace stars_Ftest="**" if Pval_Ftest<0.05;
replace stars_Ftest="***" if Pval_Ftest<0.01;

order nr Dataset Section Variable Variable_label Mean SD Obs Pval_Ftest stars_Ftest stars_T1_C stars_T2_C stars_T3_C stars_T1_T2 stars_T1_T3 stars_T2_T3 Mean_T1 Obs_T1 Mean_T2 Obs_T2 Mean_T3 Obs_T3 Mean_C Obs_C Pval_T1_C Pval_T2_C Pval_T3_C Pval_T1_T2 Pval_T1_T3 Pval_T2_T3 SD_T1 SD_T2 SD_T3 SD_C Diff_T1_C Diff_T2_C Diff_T3_C Diff_T1_T2 Diff_T1_T3 Diff_T2_T3 Tstat_T1_C Tstat_T2_C Tstat_T3_C Tstat_T1_T2 Tstat_T1_T3 Tstat_T2_T3 Obs_total_T1_C Obs_total_T2_C Obs_total_T3_C Obs_total_T1_T2 Obs_total_T1_T3 Obs_total_T2_T3; 
keep nr Dataset Section Variable Variable_label Mean SD Obs Pval_Ftest stars_Ftest stars_T1_C stars_T2_C stars_T3_C stars_T1_T2 stars_T1_T3 stars_T2_T3 Mean_T1 Obs_T1 Mean_T2 Obs_T2 Mean_T3 Obs_T3 Mean_C Obs_C Pval_T1_C Pval_T2_C Pval_T3_C Pval_T1_T2 Pval_T1_T3 Pval_T2_T3 SD_T1 SD_T2 SD_T3 SD_C Diff_T1_C Diff_T2_C Diff_T3_C Diff_T1_T2 Diff_T1_T3 Diff_T2_T3 Tstat_T1_C Tstat_T2_C Tstat_T3_C Tstat_T1_T2 Tstat_T1_T3 Tstat_T2_T3 Obs_total_T1_C Obs_total_T2_C Obs_total_T3_C Obs_total_T1_T2 Obs_total_T1_T3 Obs_total_T2_T3;

foreach var of varlist Obs Obs_T1 Obs_T2 Obs_T3 Obs_C Obs_total_T1_C Obs_total_T2_C Obs_total_T3_C Obs_total_T1_T2 Obs_total_T1_T3 Obs_total_T2_T3 {;
	format `var' %6.0f;
};
foreach var of varlist Mean SD Pval_Ftest Mean_T1 SD_T1 Mean_T2 SD_T2 Mean_T3 SD_T3 Mean_C SD_C Pval_T1_C Pval_T2_C Pval_T3_C Pval_T1_T2 Pval_T1_T3 Pval_T2_T3 Diff_T1_C Diff_T2_C Diff_T3_C Diff_T1_T2 Diff_T1_T3 Diff_T2_T3 {;
	format `var' %20.3f;
};
foreach var of varlist Tstat_T1_C Tstat_T2_C Tstat_T3_C Tstat_T1_T2 Tstat_T1_T3 Tstat_T2_T3 {;
	format `var' %7.2f;
};
foreach var of varlist Variable Variable_label {;
	format `var' %-32s;
};

sort nr;
drop nr;

save $resultdir/rwhrbf_indlevel_baseline_balance_table_youngest_detailed.dta, replace;
outsheet using $resultdir/rwhrbf_indlevel_baseline_balance_table_youngest_detailed.txt, replace;
erase $resultdir/rwhrbf_indlevel_baseline_balance_table_youngest_detailed.dta;

drop Diff_T1_C Diff_T2_C Diff_T3_C Diff_T1_T2 Diff_T1_T3 Diff_T2_T3 Tstat_T1_C Tstat_T2_C Tstat_T3_C Tstat_T1_T2 Tstat_T1_T3 Tstat_T2_T3 Obs_total_T1_C Obs_total_T2_C Obs_total_T3_C Obs_total_T1_T2 Obs_total_T1_T3 Obs_total_T2_T3; 

save $tempresultdir/rwhrbf_indlevel_baseline_balance_table_youngest.dta, replace;
outsheet using $resultdir/rwhrbf_indlevel_baseline_balance_table_youngest.txt, replace;


log close;






