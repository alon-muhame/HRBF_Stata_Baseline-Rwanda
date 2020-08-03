* Elisa Rothenbuhler
* Feb 2011

version 10.0
clear
set more off
set mem 500m
cap log close
#delimit ;

log using $logdir/rwanda_an1000_programs.log, replace;

****
* This do-file defines programs which:
*1- Calculate means for the whole sample in a given section and for subcategories of individuals (all, head of household, spouse, youngest child, mother of youngest child)
*2- Run F-tests of difference in means across 4 treatment groups
*3- Run T-tests of difference in means between each of the 4 treatment groups (resulting in 6 T-tests for each variable)
****;




*********************************************************************************
* Note on what each `1', `2', `3', etc. macros should be defined as when the calculate_means, run_f_tests and run_t_tests programs are run;

* `1': variables to be included in calculations for whole sample: local macro descvar_all;
* `2': variables to be included in calculations for head of household: local macro descvar_head;
* `3': variables to be included in calculations for spouse: local macro descvar_spouse;
* `4': variables to be included in calculations for youngest child in household: local macro descvar_youngest;
* `5': variables to be included in calculations for mother of youngest child in household: local macro descvar_mother;
* `6': dataset number (e.g. a01 or c06) corresponding to dataset currently in use: local macro used_dataset_nr - only in run_t_test program;




*********************************************************************************
* Define program calculate_means
********************************************************************************;

cap program drop calculate_means;
program calculate_means;
	
	*** Calculate means for all individuals, head of household, spouse of head of household, youngest child, mother of youngest child;
	
	foreach var of varlist `1' {;
		svy: reg `var';
		mat def `var'=e(N),el(e(b),1,1),(el(e(V),1,1))^(1/2);
		mat colnames `var'=Obs Mean SD;
		mat rownames `var'=`var';
		mat2txt, matrix(`var') saving($tempresultdir/means_all.txt) append;
		mat drop `var';
	};
	
	if "`2'"!="NONE" {;
		foreach var of varlist `2' {;	
			svy: reg `var' if a1_09_head==1;
			mat def `var'=e(N),el(e(b),1,1),(el(e(V),1,1))^(1/2);
			mat colnames `var'=Obs Mean SD;
			mat rownames `var'=`var';
			mat2txt, matrix(`var') saving($tempresultdir/means_head.txt) append;
			mat drop `var';
		};
	};
	
	if "`3'"!="NONE" {;
		foreach var of varlist `3' {;	
			svy: reg `var' if a1_09_spouse==1;
			mat def `var'=e(N),el(e(b),1,1),(el(e(V),1,1))^(1/2);
			mat colnames `var'=Obs Mean SD;
			mat rownames `var'=`var';
			mat2txt, matrix(`var') saving($tempresultdir/means_spouse.txt) append;
			mat drop `var';
		};
	};
	
	if "`4'"!="NONE" {;
		foreach var of varlist `4' {;		
			svy: reg `var' if a1_11a_young==1;
			mat def `var'=e(N),el(e(b),1,1),(el(e(V),1,1))^(1/2);
			mat colnames `var'=Obs Mean SD;
			mat rownames `var'=`var';
			mat2txt, matrix(`var') saving($tempresultdir/means_youngest.txt) append;
			mat drop `var';
		};
	};
	
	if "`5'"!="NONE" {;	
		di "NONE NONE NONE";
		foreach var of varlist `5' {;		
			svy: reg `var' if a1_15_mother==1;
			mat def `var'=e(N),el(e(b),1,1),(el(e(V),1,1))^(1/2);
			mat colnames `var'=Obs Mean SD;
			mat rownames `var'=`var';
			mat2txt, matrix(`var') saving($tempresultdir/means_mother.txt) append;
			mat drop `var';
		};
	};
end;	
	
	
	
*********************************************************************************
* Define program run_f_tests
********************************************************************************;	

cap program drop run_f_tests;
program run_f_tests;

	*** Run F-tests for all individuals, head of household, spouse of head of household, youngest child, mother of youngest child;

	foreach var of varlist `1' {;
		svy: reg `var' group_code_1 group_code_2 group_code_3;
		mat def `var'=Ftail(e(df_m),e(df_r),e(F));
		mat colnames `var'=Ftest_Pvalue;
		mat rownames `var'=`var';
		mat2txt, matrix(`var') saving($tempresultdir/Fpval_all.txt) append;
		mat drop `var';
	};	
	
	if "`2'"!="NONE" {;
		foreach var of varlist `2' {;	
			svy: reg `var' group_code_1 group_code_2 group_code_3 if a1_09_head==1;
			mat def `var'=Ftail(e(df_m),e(df_r),e(F));
			mat colnames `var'=Ftest_Pvalue;
			mat rownames `var'=`var';
			mat2txt, matrix(`var') saving($tempresultdir/Fpval_head.txt) append;
			mat drop `var';
		};	
	};
	
	if "`3'"!="NONE" {;
		foreach var of varlist `3' {;		
			svy: reg `var' group_code_1 group_code_2 group_code_3 if a1_09_spouse==1;
			mat def `var'=Ftail(e(df_m),e(df_r),e(F));
			mat colnames `var'=Ftest_Pvalue;
			mat rownames `var'=`var';
			mat2txt, matrix(`var') saving($tempresultdir/Fpval_spouse.txt) append;
			mat drop `var';
		};	
	};
	
	if "`4'"!="NONE" {;
		foreach var of varlist `4' {;		
			svy: reg `var' group_code_1 group_code_2 group_code_3 if a1_11a_young==1;
			mat def `var'=Ftail(e(df_m),e(df_r),e(F));
			mat colnames `var'=Ftest_Pvalue;
			mat rownames `var'=`var';
			mat2txt, matrix(`var') saving($tempresultdir/Fpval_youngest.txt) append;
			mat drop `var';
		};	
	};
	
	if "`5'"!="NONE" {;
		foreach var of varlist `5' {;		
			svy: reg `var' group_code_1 group_code_2 group_code_3 if a1_15_mother==1;
			mat def `var'=Ftail(e(df_m),e(df_r),e(F));
			mat colnames `var'=Ftest_Pvalue;
			mat rownames `var'=`var';
			mat2txt, matrix(`var') saving($tempresultdir/Fpval_mother.txt) append;
			mat drop `var';
		};
	};
end;




*********************************************************************************
* Define program run_t_tests
********************************************************************************;	

cap program drop run_t_tests;
program run_t_tests;

	*** Run T-tests for all individuals, head of household, spouse of head of household, youngest child, mother of youngest child;


	*** Treatment groups T1 versus C;

	preserve;
	keep if group_code_1==1 | group_code_4==1;
	svyiesummarystats `1', treatment(group_code_1) outputfile($tempresultdir/`6'_all_t1_c) pweight(hhpweight) psuclusterunit(hrbf_id1) replace;

	if "`2'"!="NONE" {;
	restore, preserve;
	keep if (group_code_1==1 | group_code_4==1) & a1_09_head==1;
	svyiesummarystats `2', treatment(group_code_1) outputfile($tempresultdir/`6'_head_t1_c) pweight(hhpweight) psuclusterunit(hrbf_id1) replace;
	};
	
	if "`3'"!="NONE" {;
	restore, preserve;
	keep if (group_code_1==1 | group_code_4==1) & a1_09_spouse==1;
	svyiesummarystats `3', treatment(group_code_1) outputfile($tempresultdir/`6'_spouse_t1_c) pweight(hhpweight) psuclusterunit(hrbf_id1) replace;
	};

	if "`4'"!="NONE" {;
	restore, preserve;
	keep if (group_code_1==1 | group_code_4==1) & a1_11a_young==1;
	svyiesummarystats `4', treatment(group_code_1) outputfile($tempresultdir/`6'_youngest_t1_c) pweight(hhpweight) psuclusterunit(hrbf_id1) replace;
	};
	
	if "`5'"!="NONE" {;
	restore, preserve;
	keep if (group_code_1==1 | group_code_4==1) & a1_15_mother==1;
	svyiesummarystats `5', treatment(group_code_1) outputfile($tempresultdir/`6'_mother_t1_c) pweight(hhpweight) psuclusterunit(hrbf_id1) replace;
	};
	
	*** Treatment groups T2 versus C;

	restore, preserve;
	keep if group_code_2==1 | group_code_4==1;
	svyiesummarystats `1', treatment(group_code_2) outputfile($tempresultdir/`6'_all_t2_c) pweight(hhpweight) psuclusterunit(hrbf_id1) replace;

	if "`2'"!="NONE" {;
	restore, preserve;
	keep if (group_code_2==1 | group_code_4==1) & a1_09_head==1;
	svyiesummarystats `2', treatment(group_code_2) outputfile($tempresultdir/`6'_head_t2_c) pweight(hhpweight) psuclusterunit(hrbf_id1) replace;
	};
	
	if "`3'"!="NONE" {;
	restore, preserve;
	keep if (group_code_2==1 | group_code_4==1) & a1_09_spouse==1;
	svyiesummarystats `3', treatment(group_code_2) outputfile($tempresultdir/`6'_spouse_t2_c) pweight(hhpweight) psuclusterunit(hrbf_id1) replace;
	};
	
	if "`4'"!="NONE" {;
	restore, preserve;
	keep if (group_code_2==1 | group_code_4==1) & a1_11a_young==1;
	svyiesummarystats `4', treatment(group_code_2) outputfile($tempresultdir/`6'_youngest_t2_c) pweight(hhpweight) psuclusterunit(hrbf_id1) replace;
	};
	
	if "`5'"!="NONE" {;
	restore, preserve;
	keep if (group_code_2==1 | group_code_4==1) & a1_15_mother==1;
	svyiesummarystats `5', treatment(group_code_2) outputfile($tempresultdir/`6'_mother_t2_c) pweight(hhpweight) psuclusterunit(hrbf_id1) replace;
	};
	
	*** Treatment groups T3 versus C;

	restore, preserve;
	keep if group_code_3==1 | group_code_4==1;
	svyiesummarystats `1', treatment(group_code_3) outputfile($tempresultdir/`6'_all_t3_c) pweight(hhpweight) psuclusterunit(hrbf_id1) replace;

	if "`2'"!="NONE" {;
	restore, preserve;
	keep if (group_code_3==1 | group_code_4==1) & a1_09_head==1;
	svyiesummarystats `2', treatment(group_code_3) outputfile($tempresultdir/`6'_head_t3_c) pweight(hhpweight) psuclusterunit(hrbf_id1) replace;
	};
	
	if "`3'"!="NONE" {;
	restore, preserve;
	keep if (group_code_3==1 | group_code_4==1) & a1_09_spouse==1;
	svyiesummarystats `3', treatment(group_code_3) outputfile($tempresultdir/`6'_spouse_t3_c) pweight(hhpweight) psuclusterunit(hrbf_id1) replace;
	};
	
	if "`4'"!="NONE" {;
	restore, preserve;
	keep if (group_code_3==1 | group_code_4==1) & a1_11a_young==1;
	svyiesummarystats `4', treatment(group_code_3) outputfile($tempresultdir/`6'_youngest_t3_c) pweight(hhpweight) psuclusterunit(hrbf_id1) replace;
	};
	
	if "`5'"!="NONE" {;
	restore, preserve;
	keep if (group_code_3==1 | group_code_4==1) & a1_15_mother==1;
	svyiesummarystats `5', treatment(group_code_3) outputfile($tempresultdir/`6'_mother_t3_c) pweight(hhpweight) psuclusterunit(hrbf_id1) replace;
	};
	
	*** Treatment groups T1 versus T2;

	restore, preserve;
	keep if group_code_1==1 | group_code_2==1;
	svyiesummarystats `1', treatment(group_code_1) outputfile($tempresultdir/`6'_all_t1_t2) pweight(hhpweight) psuclusterunit(hrbf_id1) replace;

	if "`2'"!="NONE" {;
	restore, preserve;
	keep if (group_code_1==1 | group_code_2==1) & a1_09_head==1;
	svyiesummarystats `2', treatment(group_code_1) outputfile($tempresultdir/`6'_head_t1_t2) pweight(hhpweight) psuclusterunit(hrbf_id1) replace;
	};
	
	if "`3'"!="NONE" {;
	restore, preserve;
	keep if (group_code_1==1 | group_code_2==1) & a1_09_spouse==1;
	svyiesummarystats `3', treatment(group_code_1) outputfile($tempresultdir/`6'_spouse_t1_t2) pweight(hhpweight) psuclusterunit(hrbf_id1) replace;
	};
	
	if "`4'"!="NONE" {;
	restore, preserve;
	keep if (group_code_1==1 | group_code_2==1) & a1_11a_young==1;
	svyiesummarystats `4', treatment(group_code_1) outputfile($tempresultdir/`6'_youngest_t1_t2) pweight(hhpweight) psuclusterunit(hrbf_id1) replace;
	};
	
	if "`5'"!="NONE" {;
	restore, preserve;
	keep if (group_code_1==1 | group_code_2==1) & a1_15_mother==1;
	svyiesummarystats `5', treatment(group_code_1) outputfile($tempresultdir/`6'_mother_t1_t2) pweight(hhpweight) psuclusterunit(hrbf_id1) replace;
	};
	
	*** Treatment groups T1 versus T3;

	restore, preserve;
	keep if group_code_1==1 | group_code_3==1;
	svyiesummarystats `1', treatment(group_code_1) outputfile($tempresultdir/`6'_all_t1_t3) pweight(hhpweight) psuclusterunit(hrbf_id1) replace;

	if "`2'"!="NONE" {;
	restore, preserve;
	keep if (group_code_1==1 | group_code_3==1) & a1_09_head==1;
	svyiesummarystats `2', treatment(group_code_1) outputfile($tempresultdir/`6'_head_t1_t3) pweight(hhpweight) psuclusterunit(hrbf_id1) replace;
	};
	
	if "`3'"!="NONE" {;
	restore, preserve;
	keep if (group_code_1==1 | group_code_3==1) & a1_09_spouse==1;
	svyiesummarystats `3', treatment(group_code_1) outputfile($tempresultdir/`6'_spouse_t1_t3) pweight(hhpweight) psuclusterunit(hrbf_id1) replace;
	};
	
	if "`4'"!="NONE" {;
	restore, preserve;
	keep if (group_code_1==1 | group_code_3==1) & a1_11a_young==1;
	svyiesummarystats `4', treatment(group_code_1) outputfile($tempresultdir/`6'_youngest_t1_t3) pweight(hhpweight) psuclusterunit(hrbf_id1) replace;
	};
	
	if "`5'"!="NONE" {;
	restore, preserve;
	keep if (group_code_1==1 | group_code_3==1) & a1_15_mother==1;
	svyiesummarystats `5', treatment(group_code_1) outputfile($tempresultdir/`6'_mother_t1_t3) pweight(hhpweight) psuclusterunit(hrbf_id1) replace;
	};
	
	*** Treatment groups T2 versus T3;

	restore, preserve;
	keep if group_code_2==1 | group_code_3==1;
	svyiesummarystats `1', treatment(group_code_2) outputfile($tempresultdir/`6'_all_t2_t3) pweight(hhpweight) psuclusterunit(hrbf_id1) replace;

	if "`2'"!="NONE" {;
	restore, preserve;
	keep if (group_code_2==1 | group_code_3==1) & a1_09_head==1;
	svyiesummarystats `2', treatment(group_code_2) outputfile($tempresultdir/`6'_head_t2_t3) pweight(hhpweight) psuclusterunit(hrbf_id1) replace;
	};
	
	if "`3'"!="NONE" {;
	restore, preserve;
	keep if (group_code_2==1 | group_code_3==1) & a1_09_spouse==1;
	svyiesummarystats `3', treatment(group_code_2) outputfile($tempresultdir/`6'_spouse_t2_t3) pweight(hhpweight) psuclusterunit(hrbf_id1) replace;
	};
	
	if "`4'"!="NONE" {;
	restore, preserve;
	keep if (group_code_2==1 | group_code_3==1) & a1_11a_young==1;
	svyiesummarystats `4', treatment(group_code_2) outputfile($tempresultdir/`6'_youngest_t2_t3) pweight(hhpweight) psuclusterunit(hrbf_id1) replace;
	};
	
	if "`5'"!="NONE" {;
	restore, preserve;
	keep if (group_code_2==1 | group_code_3==1) & a1_15_mother==1;
	svyiesummarystats `5', treatment(group_code_2) outputfile($tempresultdir/`6'_mother_t2_t3) pweight(hhpweight) psuclusterunit(hrbf_id1) replace;
	};
end;