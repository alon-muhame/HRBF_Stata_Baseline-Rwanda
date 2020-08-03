* Elisa Rothenbuhler, January 2011 

* This do-file:
* creates variables flagging if the F-test or each of the T-test found a significant difference in the variables across treatment groups, in the general individual-level and in the household-level datasets.
* Prepares variables for summary statistics which assess the percentage, for each section of the questionnaire, of:
* - variables for which the F-test detected a significant difference
* - variables for which each of the T-tests detected a significant difference
* - variables for which no F-test was performed
* - variables for which no T-test was performed

* Core indicators assessing the impact of the program per se are dealt with separately.

version 10.0
clear
set more off
set mem 500m
cap log close

#delimit ;

log using $logdir/rwanda_cr31_baselinebalancetables.log, replace;



********************************************************************
*** Create variables that flag the results of T-tests and F-test 
*** on Individual level dataset - for all individuals (suffix "all")
********************************************************************;

insheet using $resultdir/rwhrbf_indlevel_baseline_balance_table_all.txt, names clear;

egen nr=fill(1 2 3);
order nr;

gen ftest=.;
lab var ftest "Flags if F-test significant";
gen ttest_t1_c=.;
lab var ttest_t1_c "Flags if T-test significant btw T1 and C";
gen ttest_t2_c=.;
lab var ttest_t2_c "Flags if T-test significant btw T2 and C";
gen ttest_t3_c=.;
lab var ttest_t3_c "Flags if T-test significant btw T3 and C";
gen ttest_t1_t2=.;
lab var ttest_t1_t2 "Flags if T-test significant btw T1 and T2";
gen ttest_t1_t3=.;
lab var ttest_t1_t3 "Flags if T-test significant btw T1 and T3";
gen ttest_t2_t3=.;
lab var ttest_t2_t3 "Flags if T-test significant btw T2 and T3";

replace ftest=1 if pval_ftest<0.1;
replace ftest=0 if pval_ftest>=0.1 & pval_ftest<.;
foreach el in t1_c t2_c t3_c t1_t2 t1_t3 t2_t3 {;
	replace ttest_`el'=1 if pval_`el'<0.1;
	replace ttest_`el'=0 if pval_`el'>=0.1 & pval_`el'<.;
};

gen miss_ftest=0;
replace miss_ftest=1 if pval_ftest==.;
lab var miss_ftest "Flags if F-test was not performed";
gen miss_ttests=0;
replace miss_ttests=1 if pval_t1_c==. & pval_t2_c==. & pval_t3_c==. & pval_t1_t2==. & pval_t1_t3==. & pval_t2_t3==.;
lab var miss_ttests "Flags if T-tests were not performed";

gen str100 section_var="";
lab var section_var "Flags section of questionnaire with dataset number";
replace section_var="a01 Household roster" if nr>=1 & nr<=34;
replace section_var="a02 Education" if nr>=35 & nr<=65;
replace section_var="a03 Labor" if nr>=66 & nr<=94;
replace section_var="a04_b08 Health knowledge" if nr>=95 & nr<=126;
replace section_var="b01 Health status and utilization" if nr>=127 & nr<=175;
replace section_var="b02 Mental health" if nr>=176 & nr<=194;
replace section_var="b03 Reproductive health" if nr>=195 & nr<=272;
replace section_var="b04 Pregnancy history" if nr>=273 & nr<=291;
replace section_var="b03_b04 Reproductive health - Pregnancy history" if nr>=292 & nr<=293;
replace section_var="b05 Birth history" if nr>=294 & nr<=300;
replace section_var="b06 Antenatal and postnatal care" if nr>=301 & nr<=530;
replace section_var="b07 Patient satisfaction and knowledge" if nr>=531 & nr<=582;
replace section_var="b09 Height and weight" if nr>=583 & nr<=587;
replace section_var="c01 Health status and utilization" if nr>=588 & nr<=679;
replace section_var="c02 Vaccination" if nr>=680 & nr<=689;
replace section_var="c03 Immunization" if nr>=690 & nr<=723;
replace section_var="c04 Height and weight" if nr>=724 & nr<=780;
replace section_var="c05 Anemia tests" if nr>=781 & nr<=784;

gen indic_var=0;
lab var indic_var "Flags core indicators of impact of RBF program";
replace indic_var=1 if (nr>=195 & nr<=205) | nr==274 | (nr>=292 & nr<=293) | (nr>=301 & nr<=350) | (nr>=588 & nr<=590) | (nr>=680 & nr<=687) | (nr>=724 & nr<=733) | nr==783;

save $tempdatadir/rwhrbf_indlevel_baseline_balance_table_all_with_tests_flags.dta, replace;


********************************************************************
*** Create variables that flag the results of T-tests and F-test 
*** on Household level dataset
********************************************************************;

insheet using $resultdir/rwhrbf_hhlevel_baseline_balance_table.txt, names clear;

egen nr=fill(1 2 3);
order nr;

gen ftest=.;
lab var ftest "Flags if F-test significant";
gen ttest_t1_c=.;
lab var ttest_t1_c "Flags if T-test significant btw T1 and C";
gen ttest_t2_c=.;
lab var ttest_t2_c "Flags if T-test significant btw T2 and C";
gen ttest_t3_c=.;
lab var ttest_t3_c "Flags if T-test significant btw T3 and C";
gen ttest_t1_t2=.;
lab var ttest_t1_t2 "Flags if T-test significant btw T1 and T2";
gen ttest_t1_t3=.;
lab var ttest_t1_t3 "Flags if T-test significant btw T1 and T3";
gen ttest_t2_t3=.;
lab var ttest_t2_t3 "Flags if T-test significant btw T2 and T3";

replace ftest=1 if pval_ftest<0.1;
replace ftest=0 if pval_ftest>=0.1 & pval_ftest<.;
foreach el in t1_c t2_c t3_c t1_t2 t1_t3 t2_t3 {;
	replace ttest_`el'=1 if pval_`el'<0.1;
	replace ttest_`el'=0 if pval_`el'>=0.1 & pval_`el'<.;
};

gen miss_ftest=0;
replace miss_ftest=1 if pval_ftest==.;
lab var miss_ftest "Flags if F-test was not performed";
gen miss_ttests=0;
replace miss_ttests=1 if pval_t1_c==. & pval_t2_c==. & pval_t3_c==. & pval_t1_t2==. & pval_t1_t3==. & pval_t2_t3==.;
lab var miss_ttests "Flags if T-tests were not performed";

gen section_var="";
lab var section_var "Flags section of questionnaire with dataset number";
replace section_var="a00 Housing" if nr>=1 & nr<=90;
replace section_var="a05_a00_a06 Household assets" if nr>=91 & nr<=143;
replace section_var="a07 Transfers and other income" if nr>=144 & nr<=156;
replace section_var="a00 Subjective life valuation" if nr>=157 & nr<=182;
replace section_var="a00_a08 Mortality" if nr>=183 & nr<=210;

gen indic_var=0;
lab var indic_var "Flags core indicators of impact of RBF program";

save $tempdatadir/rwhrbf_hhlevel_baseline_balance_table_with_tests_flags.dta, replace;

log close;







