* Elisa Rothenbuhler
* Feb 2011

version 10.0
clear
set more off
set mem 500m
cap log close
#delimit ;

log using $logdir/rwanda_an2_a01.log, replace;


*******************************
*** Section 1: Household Roster
*******************************;

use $cleandatadir/rwhrbf_a01_withstudyarms_withvarformeantests.dta, clear;
preserve;

local descvar_all "a1_hhsize a1_02_02 a1_11a a1_11b a1_12_01 a1_12_02 a1_12_03 a1_12_04 a1_12_05 a1_12_06 a1_12_07 a1_14_99 a1_15_99 a1_15_1 a1_14ag_1 a1_15ag_1 a1_14al_2 a1_14al_3 a1_14al_4 a1_14al_5 a1_15al_2 a1_15al_3 a1_15al_4 a1_15al_5 a1_16_01 a1_16_02 a1_16_03 a1_16_04 a1_16_05 a1_16_96 a1_17_01 a1_17_2 a1_20_01 a1_22_01";

local descvar_head "a1_02_02 a1_11a a1_12_01 a1_12_02 a1_12_03 a1_12_04 a1_12_05 a1_12_06 a1_12_07 a1_14_99 a1_15_99 a1_15_1 a1_14ag_1 a1_15ag_1 a1_14al_2 a1_14al_3 a1_14al_4 a1_14al_5 a1_15al_2 a1_15al_3 a1_15al_4 a1_15al_5 a1_16_01 a1_16_02 a1_16_03 a1_16_04 a1_16_05 a1_16_96 a1_17_01 a1_20_01 a1_22_01";

local descvar_spouse "a1_02_02 a1_11a a1_12_01 a1_12_02 a1_12_03 a1_12_04 a1_12_05 a1_12_06 a1_12_07 a1_14_99 a1_15_99 a1_15_1 a1_14ag_1 a1_15ag_1 a1_14al_2 a1_14al_3 a1_14al_4 a1_14al_5 a1_15al_2 a1_15al_3 a1_15al_4 a1_15al_5 a1_16_01 a1_16_02 a1_16_03 a1_16_04 a1_16_05 a1_16_96 a1_17_01 a1_20_01 a1_22_01";

local descvar_youngest "a1_02_02 a1_11a a1_11b a1_14_99 a1_15_99 a1_15_1 a1_14ag_1 a1_15ag_1 a1_14al_2 a1_14al_3 a1_14al_4 a1_14al_5 a1_15al_2 a1_15al_3 a1_15al_4 a1_15al_5 a1_16_01 a1_16_02 a1_16_03 a1_16_04 a1_16_05 a1_16_96 a1_17_01 a1_17_2 a1_20_01 a1_22_01";

local descvar_mother "a1_02_02 a1_11a a1_12_01 a1_12_02 a1_12_03 a1_12_04 a1_12_05 a1_12_06 a1_12_07 a1_14_99 a1_15_99 a1_15_1 a1_14ag_1 a1_15ag_1 a1_14al_2 a1_14al_3 a1_14al_4 a1_14al_5 a1_15al_2 a1_15al_3 a1_15al_4 a1_15al_5 a1_16_01 a1_16_02 a1_16_03 a1_16_04 a1_16_05 a1_16_96 a1_17_01 a1_20_01 a1_22_01";



***
***
*** 1- Means for all individuals, head of household, spouse of head of household, youngest child, mother of youngest child;

cap erase $tempresultdir/means_all.txt;
cap erase $tempresultdir/means_head.txt;
cap erase $tempresultdir/means_spouse.txt;
cap erase $tempresultdir/means_youngest.txt;
cap erase $tempresultdir/means_mother.txt;

svyset [pweight=hhpweight], psu(hrbf_id1);

foreach var of varlist `descvar_all' {;
	svy: reg `var';
	mat def `var'=e(N),el(e(b),1,1),(el(e(V),1,1))^(1/2);
	mat colnames `var'=Obs Mean Std_Dev;
	mat rownames `var'=`var';
	mat2txt, matrix(`var') saving($tempresultdir/means_all.txt) append;
	mat drop `var';
};

foreach var of varlist `descvar_head' {;	
	svy: reg `var' if a1_09_head==1;
	mat def `var'=e(N),el(e(b),1,1),(el(e(V),1,1))^(1/2);
	mat colnames `var'=Obs Mean Std_Dev;
	mat rownames `var'=`var';
	mat2txt, matrix(`var') saving($tempresultdir/means_head.txt) append;
	mat drop `var';
};

foreach var of varlist `descvar_spouse' {;	
	svy: reg `var' if a1_09_spouse==1;
	mat def `var'=e(N),el(e(b),1,1),(el(e(V),1,1))^(1/2);
	mat colnames `var'=Obs Mean Std_Dev;
	mat rownames `var'=`var';
	mat2txt, matrix(`var') saving($tempresultdir/means_spouse.txt) append;
	mat drop `var';
};

foreach var of varlist `descvar_youngest' {;		
	svy: reg `var' if a1_11a_young==1;
	mat def `var'=e(N),el(e(b),1,1),(el(e(V),1,1))^(1/2);
	mat colnames `var'=Obs Mean Std_Dev;
	mat rownames `var'=`var';
	mat2txt, matrix(`var') saving($tempresultdir/means_youngest.txt) append;
	mat drop `var';
};

foreach var of varlist `descvar_mother' {;		
	svy: reg `var' if a1_15_mother==1;
	mat def `var'=e(N),el(e(b),1,1),(el(e(V),1,1))^(1/2);
	mat colnames `var'=Obs Mean Std_Dev;
	mat rownames `var'=`var';
	mat2txt, matrix(`var') saving($tempresultdir/means_mother.txt) append;
	mat drop `var';
};
	


***
***
*** 2- F-tests for all individuals, head of household, spouse of head of household, youngest child, mother of youngest child;

cap erase $tempresultdir/Fpval_all.txt;
cap erase $tempresultdir/Fpval_head.txt;
cap erase $tempresultdir/Fpval_spouse.txt;
cap erase $tempresultdir/Fpval_youngest.txt;
cap erase $tempresultdir/Fpval_mother.txt;

foreach var of varlist `descvar_all' {;
	svy: reg `var' group_code_1 group_code_2 group_code_3;
	mat def `var'=Ftail(e(df_m),e(df_r),e(F));
	mat colnames `var'=Ftest_Pvalue;
	mat rownames `var'=`var';
	mat2txt, matrix(`var') saving($tempresultdir/Fpval_all.txt) append;
	mat drop `var';
};	

foreach var of varlist `descvar_head' {;	
	svy: reg `var' group_code_1 group_code_2 group_code_3 if a1_09_head==1;
	mat def `var'=Ftail(e(df_m),e(df_r),e(F));
	mat colnames `var'=Ftest_Pvalue;
	mat rownames `var'=`var';
	mat2txt, matrix(`var') saving($tempresultdir/Fpval_head.txt) append;
	mat drop `var';
};	

foreach var of varlist `descvar_spouse' {;		
	svy: reg `var' group_code_1 group_code_2 group_code_3 if a1_09_spouse==1;
	mat def `var'=Ftail(e(df_m),e(df_r),e(F));
	mat colnames `var'=Ftest_Pvalue;
	mat rownames `var'=`var';
	mat2txt, matrix(`var') saving($tempresultdir/Fpval_spouse.txt) append;
	mat drop `var';
};	

foreach var of varlist `descvar_youngest' {;		
	svy: reg `var' group_code_1 group_code_2 group_code_3 if a1_11a_young==1;
	mat def `var'=Ftail(e(df_m),e(df_r),e(F));
	mat colnames `var'=Ftest_Pvalue;
	mat rownames `var'=`var';
	mat2txt, matrix(`var') saving($tempresultdir/Fpval_youngest.txt) append;
	mat drop `var';
};	

foreach var of varlist `descvar_mother' {;		
	svy: reg `var' group_code_1 group_code_2 group_code_3 if a1_15_mother==1;
	mat def `var'=Ftail(e(df_m),e(df_r),e(F));
	mat colnames `var'=Ftest_Pvalue;
	mat rownames `var'=`var';
	mat2txt, matrix(`var') saving($tempresultdir/Fpval_mother.txt) append;
	mat drop `var';
};



***
***
*** 3- T-tests for all individuals, head of household, spouse of head of household, youngest child, mother of youngest child;


*** Treatment groups T1 versus C;

restore, preserve;
keep if group_code_1==1 | group_code_4==1;
svyiesummarystats `descvar_all', treatment(group_code_1) outputfile($tempresultdir/a01_all_t1_c) pweight(hhpweight) psuclusterunit(hrbf_id1) replace;

restore, preserve;
keep if (group_code_1==1 | group_code_4==1) & a1_09_head==1;
svyiesummarystats `descvar_head', treatment(group_code_1) outputfile($tempresultdir/a01_head_t1_c) pweight(hhpweight) psuclusterunit(hrbf_id1) replace;

restore, preserve;
keep if (group_code_1==1 | group_code_4==1) & a1_09_spouse==1;
svyiesummarystats `descvar_spouse', treatment(group_code_1) outputfile($tempresultdir/a01_spouse_t1_c) pweight(hhpweight) psuclusterunit(hrbf_id1) replace;

restore, preserve;
keep if (group_code_1==1 | group_code_4==1) & a1_11a_young==1;
svyiesummarystats `descvar_youngest', treatment(group_code_1) outputfile($tempresultdir/a01_youngest_t1_c) pweight(hhpweight) psuclusterunit(hrbf_id1) replace;

restore, preserve;
keep if (group_code_1==1 | group_code_4==1) & a1_15_mother==1;
svyiesummarystats `descvar_mother', treatment(group_code_1) outputfile($tempresultdir/a01_mother_t1_c) pweight(hhpweight) psuclusterunit(hrbf_id1) replace;

*** Treatment groups T2 versus C;

restore, preserve;
keep if group_code_2==1 | group_code_4==1;
svyiesummarystats `descvar_all', treatment(group_code_2) outputfile($tempresultdir/a01_all_t2_c) pweight(hhpweight) psuclusterunit(hrbf_id1) replace;

restore, preserve;
keep if (group_code_2==1 | group_code_4==1) & a1_09_head==1;
svyiesummarystats `descvar_head', treatment(group_code_2) outputfile($tempresultdir/a01_head_t2_c) pweight(hhpweight) psuclusterunit(hrbf_id1) replace;

restore, preserve;
keep if (group_code_2==1 | group_code_4==1) & a1_09_spouse==1;
svyiesummarystats `descvar_spouse', treatment(group_code_2) outputfile($tempresultdir/a01_spouse_t2_c) pweight(hhpweight) psuclusterunit(hrbf_id1) replace;

restore, preserve;
keep if (group_code_2==1 | group_code_4==1) & a1_11a_young==1;
svyiesummarystats `descvar_youngest', treatment(group_code_2) outputfile($tempresultdir/a01_youngest_t2_c) pweight(hhpweight) psuclusterunit(hrbf_id1) replace;

restore, preserve;
keep if (group_code_2==1 | group_code_4==1) & a1_15_mother==1;
svyiesummarystats `descvar_mother', treatment(group_code_2) outputfile($tempresultdir/a01_mother_t2_c) pweight(hhpweight) psuclusterunit(hrbf_id1) replace;

*** Treatment groups T3 versus C;

restore, preserve;
keep if group_code_3==1 | group_code_4==1;
svyiesummarystats `descvar_all', treatment(group_code_3) outputfile($tempresultdir/a01_all_t3_c) pweight(hhpweight) psuclusterunit(hrbf_id1) replace;

restore, preserve;
keep if (group_code_3==1 | group_code_4==1) & a1_09_head==1;
svyiesummarystats `descvar_head', treatment(group_code_3) outputfile($tempresultdir/a01_head_t3_c) pweight(hhpweight) psuclusterunit(hrbf_id1) replace;

restore, preserve;
keep if (group_code_3==1 | group_code_4==1) & a1_09_spouse==1;
svyiesummarystats `descvar_spouse', treatment(group_code_3) outputfile($tempresultdir/a01_spouse_t3_c) pweight(hhpweight) psuclusterunit(hrbf_id1) replace;

restore, preserve;
keep if (group_code_3==1 | group_code_4==1) & a1_11a_young==1;
svyiesummarystats `descvar_youngest', treatment(group_code_3) outputfile($tempresultdir/a01_youngest_t3_c) pweight(hhpweight) psuclusterunit(hrbf_id1) replace;

restore, preserve;
keep if (group_code_3==1 | group_code_4==1) & a1_15_mother==1;
svyiesummarystats `descvar_mother', treatment(group_code_3) outputfile($tempresultdir/a01_mother_t3_c) pweight(hhpweight) psuclusterunit(hrbf_id1) replace;

*** Treatment groups T1 versus T2;

restore, preserve;
keep if group_code_1==1 | group_code_2==1;
svyiesummarystats `descvar_all', treatment(group_code_1) outputfile($tempresultdir/a01_all_t1_t2) pweight(hhpweight) psuclusterunit(hrbf_id1) replace;

restore, preserve;
keep if (group_code_1==1 | group_code_2==1) & a1_09_head==1;
svyiesummarystats `descvar_head', treatment(group_code_1) outputfile($tempresultdir/a01_head_t1_t2) pweight(hhpweight) psuclusterunit(hrbf_id1) replace;

restore, preserve;
keep if (group_code_1==1 | group_code_2==1) & a1_09_spouse==1;
svyiesummarystats `descvar_spouse', treatment(group_code_1) outputfile($tempresultdir/a01_spouse_t1_t2) pweight(hhpweight) psuclusterunit(hrbf_id1) replace;

restore, preserve;
keep if (group_code_1==1 | group_code_2==1) & a1_11a_young==1;
svyiesummarystats `descvar_youngest', treatment(group_code_1) outputfile($tempresultdir/a01_youngest_t1_t2) pweight(hhpweight) psuclusterunit(hrbf_id1) replace;

restore, preserve;
keep if (group_code_1==1 | group_code_2==1) & a1_15_mother==1;
svyiesummarystats `descvar_mother', treatment(group_code_1) outputfile($tempresultdir/a01_mother_t1_t2) pweight(hhpweight) psuclusterunit(hrbf_id1) replace;

*** Treatment groups T1 versus T3;

restore, preserve;
keep if group_code_1==1 | group_code_3==1;
svyiesummarystats `descvar_all', treatment(group_code_1) outputfile($tempresultdir/a01_all_t1_t3) pweight(hhpweight) psuclusterunit(hrbf_id1) replace;

restore, preserve;
keep if (group_code_1==1 | group_code_3==1) & a1_09_head==1;
svyiesummarystats `descvar_head', treatment(group_code_1) outputfile($tempresultdir/a01_head_t1_t3) pweight(hhpweight) psuclusterunit(hrbf_id1) replace;

restore, preserve;
keep if (group_code_1==1 | group_code_3==1) & a1_09_spouse==1;
svyiesummarystats `descvar_spouse', treatment(group_code_1) outputfile($tempresultdir/a01_spouse_t1_t3) pweight(hhpweight) psuclusterunit(hrbf_id1) replace;

restore, preserve;
keep if (group_code_1==1 | group_code_3==1) & a1_11a_young==1;
svyiesummarystats `descvar_youngest', treatment(group_code_1) outputfile($tempresultdir/a01_youngest_t1_t3) pweight(hhpweight) psuclusterunit(hrbf_id1) replace;

restore, preserve;
keep if (group_code_1==1 | group_code_3==1) & a1_15_mother==1;
svyiesummarystats `descvar_mother', treatment(group_code_1) outputfile($tempresultdir/a01_mother_t1_t3) pweight(hhpweight) psuclusterunit(hrbf_id1) replace;

*** Treatment groups T2 versus T3;

restore, preserve;
keep if group_code_2==1 | group_code_3==1;
svyiesummarystats `descvar_all', treatment(group_code_2) outputfile($tempresultdir/a01_all_t2_t3) pweight(hhpweight) psuclusterunit(hrbf_id1) replace;

restore, preserve;
keep if (group_code_2==1 | group_code_3==1) & a1_09_head==1;
svyiesummarystats `descvar_head', treatment(group_code_2) outputfile($tempresultdir/a01_head_t2_t3) pweight(hhpweight) psuclusterunit(hrbf_id1) replace;

restore, preserve;
keep if (group_code_2==1 | group_code_3==1) & a1_09_spouse==1;
svyiesummarystats `descvar_spouse', treatment(group_code_2) outputfile($tempresultdir/a01_spouse_t2_t3) pweight(hhpweight) psuclusterunit(hrbf_id1) replace;

restore, preserve;
keep if (group_code_2==1 | group_code_3==1) & a1_11a_young==1;
svyiesummarystats `descvar_youngest', treatment(group_code_2) outputfile($tempresultdir/a01_youngest_t2_t3) pweight(hhpweight) psuclusterunit(hrbf_id1) replace;

restore, preserve;
keep if (group_code_2==1 | group_code_3==1) & a1_15_mother==1;
svyiesummarystats `descvar_mother', treatment(group_code_2) outputfile($tempresultdir/a01_mother_t2_t3) pweight(hhpweight) psuclusterunit(hrbf_id1) replace;


restore;
log close;

