* Elisa Rothenbuhler - Nov 10

* This do-file:
* Creates additional baseline sample balance tables on the a04 Health knowledge section:
	* table for men only
	* table for women only
	* table of T-stats of the difference in means test between men and women
* These tables are each created for the following categories: all, head, spouse.


version 10.0
clear
set more off
set mem 500m
cap log close

#delimit ;

log using $logdir/rwanda_cr30_baselinetables_gender.log, replace;


*********************************************************************
*** Generate table of Variables/Variables labels only for a04 section
*********************************************************************;

use $resultdir/rwhrbf_indlevelvariables.dta, clear;
keep if Variable=="a4_healthscore" | Variable=="a4_10a_1" | Variable=="a4_10b_1" | Variable=="a4_10c_1" | Variable=="a4_10d_1" | Variable=="a4_11a_1" | Variable=="a4_11b_1" | Variable=="a4_11c_1" | Variable=="a4_11d_1" | Variable=="a4_12a_1" | Variable=="a4_12b_1" | Variable=="a4_12c_1" | Variable=="a4_12d_1" | Variable=="a4_12e_1" | Variable=="a4_13a_1" | Variable=="a4_13b_1" | Variable=="a4_13c_1" | Variable=="a4_13d_1" | Variable=="a4_14a_1" | Variable=="a4_14b_1" | Variable=="a4_14c_1" | Variable=="a4_14d_1" | Variable=="a4_15a_1" | Variable=="a4_15b_1" | Variable=="a4_15c_1" | Variable=="a4_15d_1" | Variable=="a4_15e_1" | Variable=="a4_16a_1" | Variable=="a4_16b_1" | Variable=="a4_16c_1" | Variable=="a4_16d_1" | Variable=="a4_16e_1";
save $a04resultdir/rwhrbf_indlevelvariables_a04only.dta, replace;
clear;



*******************************************************
*** Save all .txt output files into .dta Stata datasets
*******************************************************; 

	*********************************************	
	*** a04 Health knoweldge section for men only
	*********************************************;

foreach el in means_all means_head {;
	insheet using $a04men_tempresultdir/`el'.txt, names clear;
	cap drop v5;
	drop if v1=="";
	ren v1 Variable;
	ren obs Obs;
	ren mean Mean;
	ren sd SD;
	save $a04men_tempresultdir/`el'.dta, replace;
	clear;
};

foreach el in Fpval_all Fpval_head {;
	insheet using $a04men_tempresultdir/`el'.txt, names clear;
	cap drop v3 v4 v5;
	drop if v1=="";
	ren v1 Variable;
	ren ftest_pvalue Pval_Ftest;
	save $a04men_tempresultdir/`el'.dta, replace;
	clear;
};

foreach el in a04_b08_men_all_t1_c a04_b08_men_all_t2_c a04_b08_men_all_t3_c a04_b08_men_all_t1_t2 a04_b08_men_all_t1_t3 a04_b08_men_all_t2_t3 
a04_b08_men_head_t1_c a04_b08_men_head_t2_c a04_b08_men_head_t3_c a04_b08_men_head_t1_t2 a04_b08_men_head_t1_t3 a04_b08_men_head_t2_t3 {;
	insheet using $a04men_tempresultdir/`el'.txt, names clear;
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
save $a04men_tempresultdir/`el'_essential.dta, replace;
};



	***********************************************
	*** a04 Health knoweldge section for women only
	***********************************************;

foreach el in means_all means_head means_spouse {;
	insheet using $a04women_tempresultdir/`el'.txt, names clear;
	cap drop v5;
	drop if v1=="";
	ren v1 Variable;
	ren obs Obs;
	ren mean Mean;
	ren sd SD;
	save $a04women_tempresultdir/`el'.dta, replace;
	clear;
};

foreach el in Fpval_all Fpval_head Fpval_spouse {;
	insheet using $a04women_tempresultdir/`el'.txt, names clear;
	cap drop v3 v4 v5;
	drop if v1=="";
	ren v1 Variable;
	ren ftest_pvalue Pval_Ftest;
	save $a04women_tempresultdir/`el'.dta, replace;
	clear;
};

foreach el in a04_b08_women_all_t1_c a04_b08_women_all_t2_c a04_b08_women_all_t3_c a04_b08_women_all_t1_t2 a04_b08_women_all_t1_t3 a04_b08_women_all_t2_t3 a04_b08_women_head_t1_c a04_b08_women_head_t2_c a04_b08_women_head_t3_c a04_b08_women_head_t1_t2 a04_b08_women_head_t1_t3 a04_b08_women_head_t2_t3 a04_b08_women_spouse_t1_c a04_b08_women_spouse_t2_c a04_b08_women_spouse_t3_c a04_b08_women_spouse_t1_t2 a04_b08_women_spouse_t1_t3 a04_b08_women_spouse_t2_t3 {;
	insheet using $a04women_tempresultdir/`el'.txt, names clear;
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
save $a04women_tempresultdir/`el'_essential.dta, replace;
};

***************************************************************************
*** Build baseline table: Gender Mean tests in a04 Health knowledge section
*** For all individuals concerned by given section (suffix "all")
*** MEAN TEST BETWEEN MEN AND WOMEN (not between treatment groups)
***************************************************************************;
	
insheet using $a04men_vs_women_tempresultdir/a04_b08_gendertest_all.txt, names clear;
drop line;
ren variablename Variable;
ren meantreatment Mean_Male;
ren errortreatment SD_Male;
ren nobstreatment Obs_Male;
ren meancontrol Mean_Female;
ren errorcontrol SD_Female;
ren nobscontrol Obs_Female;
ren difference Diff_Male_Female;
ren tstat Tstat_Male_Female;
ren nobstotal Obs_total_Male_Female;
ren significance Pval_Male_Female;
ren stars stars_Male_Female;
save $a04men_vs_women_tempresultdir/a04_b08_gendertest_all_essential.dta, replace;
clear;

use $a04resultdir/rwhrbf_indlevelvariables_a04only.dta, clear;
sort Variable;
merge Variable using $a04men_vs_women_tempresultdir/a04_b08_gendertest_all_essential, unique sort;
tab _merge;
assert _merge!=2;
drop _merge;

order nr Dataset Section Variable Variable_label Mean_Male SD_Male Obs_Male Mean_Female SD_Female Obs_Female Pval_Male_Female stars_Male_Female Diff_Male_Female Tstat_Male_Female Obs_total_Male_Female; 

foreach var of varlist Obs_Male Obs_Female Obs_total_Male_Female {;
	format `var' %6.0f;
};
foreach var of varlist Mean_Male SD_Male Mean_Female SD_Female Pval_Male_Female Diff_Male_Female {;
	format `var' %20.3f;
};
format Tstat_Male_Female %7.2f;
foreach var of varlist Variable Variable_label {;
	format `var' %-32s;
};

sort nr;
drop nr;

save $a04men_vs_women_resultdir/rwhrbf_a04men_vs_women_baseline_balance_table_all_detailed.dta, replace;
outsheet using $a04men_vs_women_resultdir/rwhrbf_a04men_vs_women_baseline_balance_table_all_detailed.txt, replace;
erase $a04men_vs_women_resultdir/rwhrbf_a04men_vs_women_baseline_balance_table_all_detailed.dta;

drop Diff_Male_Female Tstat_Male_Female Obs_total_Male_Female; 

save $a04men_vs_women_resultdir/rwhrbf_a04men_vs_women_baseline_balance_table_all.dta, replace;
outsheet using $a04men_vs_women_resultdir/rwhrbf_a04men_vs_women_baseline_balance_table_all.txt, replace;


************************************************************************
*** Build baseline sample balance table for a04 Health knowledge section
*** All individuals concerned by given section (suffix "all")
*** For MEN only
************************************************************************;

use $a04resultdir/rwhrbf_indlevelvariables_a04only.dta, clear;
sort Variable;
merge Variable using $a04men_tempresultdir/means_all.dta $a04men_tempresultdir/Fpval_all.dta $a04men_tempresultdir/a04_b08_men_all_t1_c_essential $a04men_tempresultdir/a04_b08_men_all_t2_c_essential $a04men_tempresultdir/a04_b08_men_all_t3_c_essential $a04men_tempresultdir/a04_b08_men_all_t1_t2_essential $a04men_tempresultdir/a04_b08_men_all_t1_t3_essential $a04men_tempresultdir/a04_b08_men_all_t2_t3_essential 
, unique sort;

tab _merge;
tab1 _merge*;	// _merge1 should not equal 0
assert _merge1!=0;
assert _merge!=2;
drop _merge _merge*;

foreach var of varlist Obs Mean SD Pval_Ftest {;
	destring `var', replace;
};

gen stars_Ftest="";
replace stars_Ftest="*" if Pval_Ftest<0.1;
replace stars_Ftest="**" if Pval_Ftest<0.05;
replace stars_Ftest="***" if Pval_Ftest<0.01;

order nr Dataset Section Variable Variable_label Mean SD Obs Pval_Ftest stars_Ftest stars_T1_C stars_T2_C stars_T3_C stars_T1_T2 stars_T1_T3 stars_T2_T3 Mean_T1 Obs_T1 Mean_T2 Obs_T2 Mean_T3 Obs_T3 Mean_C Obs_C Pval_T1_C Pval_T2_C Pval_T3_C Pval_T1_T2 Pval_T1_T3 Pval_T2_T3 SD_T1 SD_T2 SD_T3 SD_C Diff_T1_C Diff_T2_C Diff_T3_C Diff_T1_T2 Diff_T1_T3 Diff_T2_T3 Tstat_T1_C Tstat_T2_C Tstat_T3_C Tstat_T1_T2 Tstat_T1_T3 Tstat_T2_T3 Obs_total_T1_C Obs_total_T2_C Obs_total_T3_C Obs_total_T1_T2 Obs_total_T1_T3 Obs_total_T2_T3;  

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

save $a04men_resultdir/rwhrbf_a04men_baseline_balance_table_all_detailed.dta, replace;
outsheet using $a04men_resultdir/rwhrbf_a04men_baseline_balance_table_all_detailed.txt, replace;
erase $a04men_resultdir/rwhrbf_a04men_baseline_balance_table_all_detailed.dta;

drop Diff_T1_C Diff_T2_C Diff_T3_C Diff_T1_T2 Diff_T1_T3 Diff_T2_T3 Tstat_T1_C Tstat_T2_C Tstat_T3_C Tstat_T1_T2 Tstat_T1_T3 Tstat_T2_T3 Obs_total_T1_C Obs_total_T2_C Obs_total_T3_C Obs_total_T1_T2 Obs_total_T1_T3 Obs_total_T2_T3; 

save $a04men_resultdir/rwhrbf_a04men_baseline_balance_table_all.dta, replace;
outsheet using $a04men_resultdir/rwhrbf_a04men_baseline_balance_table_all.txt, replace;


************************************************************************
*** Build baseline sample balance table for a04 Health knowledge section
*** Heads of household only (suffix "head")
*** For MEN only
************************************************************************;

use $a04resultdir/rwhrbf_indlevelvariables_a04only.dta, clear;
sort Variable;
merge Variable using $a04men_tempresultdir/means_head.dta $a04men_tempresultdir/Fpval_head.dta $a04men_tempresultdir/a04_b08_men_head_t1_c_essential $a04men_tempresultdir/a04_b08_men_head_t2_c_essential $a04men_tempresultdir/a04_b08_men_head_t3_c_essential $a04men_tempresultdir/a04_b08_men_head_t1_t2_essential $a04men_tempresultdir/a04_b08_men_head_t1_t3_essential $a04men_tempresultdir/a04_b08_men_head_t2_t3_essential 
, unique sort;

tab _merge;
tab1 _merge*;	// _merge1 should not equal 0
assert _merge1!=0;
assert _merge!=2;
drop _merge _merge*;

foreach var of varlist Obs Mean SD Pval_Ftest {;
	destring `var', replace;
};

gen stars_Ftest="";
replace stars_Ftest="*" if Pval_Ftest<0.1;
replace stars_Ftest="**" if Pval_Ftest<0.05;
replace stars_Ftest="***" if Pval_Ftest<0.01;

order nr Dataset Section Variable Variable_label Mean SD Obs Pval_Ftest stars_Ftest stars_T1_C stars_T2_C stars_T3_C stars_T1_T2 stars_T1_T3 stars_T2_T3 Mean_T1 Obs_T1 Mean_T2 Obs_T2 Mean_T3 Obs_T3 Mean_C Obs_C Pval_T1_C Pval_T2_C Pval_T3_C Pval_T1_T2 Pval_T1_T3 Pval_T2_T3 SD_T1 SD_T2 SD_T3 SD_C Diff_T1_C Diff_T2_C Diff_T3_C Diff_T1_T2 Diff_T1_T3 Diff_T2_T3 Tstat_T1_C Tstat_T2_C Tstat_T3_C Tstat_T1_T2 Tstat_T1_T3 Tstat_T2_T3 Obs_total_T1_C Obs_total_T2_C Obs_total_T3_C Obs_total_T1_T2 Obs_total_T1_T3 Obs_total_T2_T3; 

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

save $a04men_resultdir/rwhrbf_a04men_baseline_balance_table_head_detailed.dta, replace;
outsheet using $a04men_resultdir/rwhrbf_a04men_baseline_balance_table_head_detailed.txt, replace;
erase $a04men_resultdir/rwhrbf_a04men_baseline_balance_table_head_detailed.dta;

drop Diff_T1_C Diff_T2_C Diff_T3_C Diff_T1_T2 Diff_T1_T3 Diff_T2_T3 Tstat_T1_C Tstat_T2_C Tstat_T3_C Tstat_T1_T2 Tstat_T1_T3 Tstat_T2_T3 Obs_total_T1_C Obs_total_T2_C Obs_total_T3_C Obs_total_T1_T2 Obs_total_T1_T3 Obs_total_T2_T3; 

save $a04men_resultdir/rwhrbf_a04men_baseline_balance_table_head.dta, replace;
outsheet using $a04men_resultdir/rwhrbf_a04men_baseline_balance_table_head.txt, replace;

************************************************************************
*** Build baseline sample balance table for a04 Health knowledge section
*** All individuals concerned by given section (suffix "all")
*** For WOMEN only
************************************************************************;

use $a04resultdir/rwhrbf_indlevelvariables_a04only.dta, clear;
sort Variable;
merge Variable using $a04women_tempresultdir/means_all.dta $a04women_tempresultdir/Fpval_all.dta $a04women_tempresultdir/a04_b08_women_all_t1_c_essential $a04women_tempresultdir/a04_b08_women_all_t2_c_essential $a04women_tempresultdir/a04_b08_women_all_t3_c_essential $a04women_tempresultdir/a04_b08_women_all_t1_t2_essential $a04women_tempresultdir/a04_b08_women_all_t1_t3_essential $a04women_tempresultdir/a04_b08_women_all_t2_t3_essential 
, unique sort;

tab _merge;
tab1 _merge*;	// _merge1 should not equal 0
assert _merge1!=0;
assert _merge!=2;
drop _merge _merge*;

foreach var of varlist Obs Mean SD Pval_Ftest {;
	destring `var', replace;
};

gen stars_Ftest="";
replace stars_Ftest="*" if Pval_Ftest<0.1;
replace stars_Ftest="**" if Pval_Ftest<0.05;
replace stars_Ftest="***" if Pval_Ftest<0.01;

order nr Dataset Section Variable Variable_label Mean SD Obs Pval_Ftest stars_Ftest stars_T1_C stars_T2_C stars_T3_C stars_T1_T2 stars_T1_T3 stars_T2_T3 Mean_T1 Obs_T1 Mean_T2 Obs_T2 Mean_T3 Obs_T3 Mean_C Obs_C Pval_T1_C Pval_T2_C Pval_T3_C Pval_T1_T2 Pval_T1_T3 Pval_T2_T3 SD_T1 SD_T2 SD_T3 SD_C Diff_T1_C Diff_T2_C Diff_T3_C Diff_T1_T2 Diff_T1_T3 Diff_T2_T3 Tstat_T1_C Tstat_T2_C Tstat_T3_C Tstat_T1_T2 Tstat_T1_T3 Tstat_T2_T3 Obs_total_T1_C Obs_total_T2_C Obs_total_T3_C Obs_total_T1_T2 Obs_total_T1_T3 Obs_total_T2_T3; 

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

save $a04women_resultdir/rwhrbf_a04women_baseline_balance_table_all_detailed.dta, replace;
outsheet using $a04women_resultdir/rwhrbf_a04women_baseline_balance_table_all_detailed.txt, replace;
erase $a04women_resultdir/rwhrbf_a04women_baseline_balance_table_all_detailed.dta;

drop Diff_T1_C Diff_T2_C Diff_T3_C Diff_T1_T2 Diff_T1_T3 Diff_T2_T3 Tstat_T1_C Tstat_T2_C Tstat_T3_C Tstat_T1_T2 Tstat_T1_T3 Tstat_T2_T3 Obs_total_T1_C Obs_total_T2_C Obs_total_T3_C Obs_total_T1_T2 Obs_total_T1_T3 Obs_total_T2_T3; 

save $a04women_resultdir/rwhrbf_a04women_baseline_balance_table_all.dta, replace;
outsheet using $a04women_resultdir/rwhrbf_a04women_baseline_balance_table_all.txt, replace;


************************************************************************
*** Build baseline sample balance table for a04 Health knowledge section
*** Heads of household only (suffix "head")
*** For WOMEN only
************************************************************************;

use $a04resultdir/rwhrbf_indlevelvariables_a04only.dta, clear;
sort Variable;
merge Variable using $a04women_tempresultdir/means_head.dta $a04women_tempresultdir/Fpval_head.dta $a04women_tempresultdir/a04_b08_women_head_t1_c_essential $a04women_tempresultdir/a04_b08_women_head_t2_c_essential $a04women_tempresultdir/a04_b08_women_head_t3_c_essential $a04women_tempresultdir/a04_b08_women_head_t1_t2_essential $a04women_tempresultdir/a04_b08_women_head_t1_t3_essential $a04women_tempresultdir/a04_b08_women_head_t2_t3_essential 
, unique sort;

tab _merge;
tab1 _merge*;	// _merge1 should not equal 0
assert _merge1!=0;
assert _merge!=2;
drop _merge _merge*;

foreach var of varlist Obs Mean SD Pval_Ftest {;
	destring `var', replace;
};

gen stars_Ftest="";
replace stars_Ftest="*" if Pval_Ftest<0.1;
replace stars_Ftest="**" if Pval_Ftest<0.05;
replace stars_Ftest="***" if Pval_Ftest<0.01;

order nr Dataset Section Variable Variable_label Mean SD Obs Pval_Ftest stars_Ftest stars_T1_C stars_T2_C stars_T3_C stars_T1_T2 stars_T1_T3 stars_T2_T3 Mean_T1 Obs_T1 Mean_T2 Obs_T2 Mean_T3 Obs_T3 Mean_C Obs_C Pval_T1_C Pval_T2_C Pval_T3_C Pval_T1_T2 Pval_T1_T3 Pval_T2_T3 SD_T1 SD_T2 SD_T3 SD_C Diff_T1_C Diff_T2_C Diff_T3_C Diff_T1_T2 Diff_T1_T3 Diff_T2_T3 Tstat_T1_C Tstat_T2_C Tstat_T3_C Tstat_T1_T2 Tstat_T1_T3 Tstat_T2_T3 Obs_total_T1_C Obs_total_T2_C Obs_total_T3_C Obs_total_T1_T2 Obs_total_T1_T3 Obs_total_T2_T3; 

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

save $a04women_resultdir/rwhrbf_a04women_baseline_balance_table_head_detailed.dta, replace;
outsheet using $a04women_resultdir/rwhrbf_a04women_baseline_balance_table_head_detailed.txt, replace;
erase $a04women_resultdir/rwhrbf_a04women_baseline_balance_table_head_detailed.dta;

drop Diff_T1_C Diff_T2_C Diff_T3_C Diff_T1_T2 Diff_T1_T3 Diff_T2_T3 Tstat_T1_C Tstat_T2_C Tstat_T3_C Tstat_T1_T2 Tstat_T1_T3 Tstat_T2_T3 Obs_total_T1_C Obs_total_T2_C Obs_total_T3_C Obs_total_T1_T2 Obs_total_T1_T3 Obs_total_T2_T3; 

save $a04women_resultdir/rwhrbf_a04women_baseline_balance_table_head.dta, replace;
outsheet using $a04women_resultdir/rwhrbf_a04women_baseline_balance_table_head.txt, replace;

************************************************************************
*** Build baseline sample balance table for a04 Health knowledge section
*** Spouses only (suffix "spouse")
*** For WOMEN only
************************************************************************;

use $a04resultdir/rwhrbf_indlevelvariables_a04only.dta, clear;
sort Variable;
merge Variable using $a04women_tempresultdir/means_spouse.dta $a04women_tempresultdir/Fpval_spouse.dta $a04women_tempresultdir/a04_b08_women_spouse_t1_c_essential $a04women_tempresultdir/a04_b08_women_spouse_t2_c_essential $a04women_tempresultdir/a04_b08_women_spouse_t3_c_essential $a04women_tempresultdir/a04_b08_women_spouse_t1_t2_essential $a04women_tempresultdir/a04_b08_women_spouse_t1_t3_essential $a04women_tempresultdir/a04_b08_women_spouse_t2_t3_essential 
, unique sort;

tab _merge;
tab1 _merge*;	// _merge1 should not equal 0
assert _merge1!=0;
assert _merge!=2;
drop _merge _merge*;

foreach var of varlist Obs Mean SD Pval_Ftest {;
	destring `var', replace;
};

gen stars_Ftest="";
replace stars_Ftest="*" if Pval_Ftest<0.1;
replace stars_Ftest="**" if Pval_Ftest<0.05;
replace stars_Ftest="***" if Pval_Ftest<0.01;

order nr Dataset Section Variable Variable_label Mean SD Obs Pval_Ftest stars_Ftest stars_T1_C stars_T2_C stars_T3_C stars_T1_T2 stars_T1_T3 stars_T2_T3 Mean_T1 Obs_T1 Mean_T2 Obs_T2 Mean_T3 Obs_T3 Mean_C Obs_C Pval_T1_C Pval_T2_C Pval_T3_C Pval_T1_T2 Pval_T1_T3 Pval_T2_T3 SD_T1 SD_T2 SD_T3 SD_C Diff_T1_C Diff_T2_C Diff_T3_C Diff_T1_T2 Diff_T1_T3 Diff_T2_T3 Tstat_T1_C Tstat_T2_C Tstat_T3_C Tstat_T1_T2 Tstat_T1_T3 Tstat_T2_T3 Obs_total_T1_C Obs_total_T2_C Obs_total_T3_C Obs_total_T1_T2 Obs_total_T1_T3 Obs_total_T2_T3; 

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

save $a04women_resultdir/rwhrbf_a04women_baseline_balance_table_spouse_detailed.dta, replace;
outsheet using $a04women_resultdir/rwhrbf_a04women_baseline_balance_table_spouse_detailed.txt, replace;
erase $a04women_resultdir/rwhrbf_a04women_baseline_balance_table_spouse_detailed.dta;

drop Diff_T1_C Diff_T2_C Diff_T3_C Diff_T1_T2 Diff_T1_T3 Diff_T2_T3 Tstat_T1_C Tstat_T2_C Tstat_T3_C Tstat_T1_T2 Tstat_T1_T3 Tstat_T2_T3 Obs_total_T1_C Obs_total_T2_C Obs_total_T3_C Obs_total_T1_T2 Obs_total_T1_T3 Obs_total_T2_T3; 

save $a04women_resultdir/rwhrbf_a04women_baseline_balance_table_spouse.dta, replace;
outsheet using $a04women_resultdir/rwhrbf_a04women_baseline_balance_table_spouse.txt, replace;

clear;
log close;

