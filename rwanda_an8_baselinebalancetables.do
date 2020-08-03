* Elisa Rothenbuhler, January 2011 

* This do-file:
* creates summary statistics which assess the percentage, for each section of the questionnaire, of:
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

log using $logdir/rwanda_an8_baselinebalancetables.log, replace;


***************************************************************
*** T-test and F-test summary stats on Individual level dataset
*** For all individuals
***************************************************************;

cap erase $resultdir/Indicators_Significance_table_individual.txt;
cap erase $resultdir/Covariates_Significance_table_individual.txt;
cap mat drop _all;

use $tempdatadir/rwhrbf_indlevel_baseline_balance_table_all_with_tests_flags.dta, clear;


*** General tabulations for all sections;

proportion ftest  if indic_var==1, missing;
mat I_all_ftest=e(b)'\e(N);
mat I_all_ftest= I_all_ftest[2..4,1];
mat rownames I_all_ftest=Significant Missing "Number of indicators";

proportion ftest if indic_var==0, missing;
mat C_all_ftest=e(b)'\e(N);
mat C_all_ftest= C_all_ftest[2..4,1];
mat rownames C_all_ftest=Significant Missing "Number of covariates";

foreach var of varlist ttest_t1_c ttest_t2_c ttest_t3_c ttest_t1_t2 ttest_t1_t3 ttest_t2_t3 {;
	proportion `var'  if indic_var==1, missing;
	mat I_all_`var'=e(b)';
	mat I_all_`var'= I_all_`var'[2..3,1];
	mat rownames I_all_`var'=Significant Missing;
	
	proportion `var' if indic_var==0, missing;
	mat C_all_`var'=e(b)';
	mat C_all_`var'= C_all_`var'[2..3,1];
	mat rownames C_all_`var'=Significant Missing;
};

mat I_all_sections=I_all_ftest\ I_all_ttest_t1_c\ I_all_ttest_t2_c\ I_all_ttest_t3_c\ I_all_ttest_t1_t2\ I_all_ttest_t1_t3\ I_all_ttest_t2_t3;
mat C_all_sections=C_all_ftest\ C_all_ttest_t1_c\ C_all_ttest_t2_c\ C_all_ttest_t3_c\ C_all_ttest_t1_t2\ C_all_ttest_t1_t3\ C_all_ttest_t2_t3;

*** Tabulations by section of the questionnaire;

foreach section_nr in a01 a02 a03 a04_b08 b01 b02 b03 b04 b03_b04 b05 b06 b07 b09 c01 c02 c03 c04 c05 {;

	if "`section_nr'"=="a01" {;
		local section_full_name="a01 Household roster";
	};
	if "`section_nr'"=="a02" {;
		local section_full_name= "a02 Education";
	};
	if "`section_nr'"=="a03" {;
		local section_full_name="a03 Labor";
	};
	if "`section_nr'"=="a04_b08" {;
		local section_full_name= "a04_b08 Health knowledge";
	};
	if "`section_nr'"=="b01" {;
		local section_full_name="b01 Health status and utilization";
	};
	if "`section_nr'"=="b02" {;
		local section_full_name="b02 Mental health";
	};
	if "`section_nr'"=="b03" {;
		local section_full_name="b03 Reproductive health";
	};
	if "`section_nr'"=="b04" {;
		local section_full_name="b04 Pregnancy history";
	};
	if "`section_nr'"=="b03_b04" {;
		local section_full_name="b03_b04 Reproductive health - Pregnancy history";
	};
	if "`section_nr'"=="b05" {;
		local section_full_name="b05 Birth history";
	};
	if "`section_nr'"=="b06" {;
		local section_full_name="b06 Antenatal and postnatal care";
	};
	if "`section_nr'"=="b07" {;
		local section_full_name="b07 Patient satisfaction and knowledge";
	};
	if "`section_nr'"=="b09" {;
		local section_full_name="b09 Height and weight";
	};
	if "`section_nr'"=="c01" {;
		local section_full_name="c01 Health status and utilization";
	};
	if "`section_nr'"=="c02" {;
		local section_full_name="c02 Vaccination";
	};
	if "`section_nr'"=="c03" {;
		local section_full_name="c03 Immunization";
	};
	if "`section_nr'"=="c04" {;
		local section_full_name="c04 Height and weight";
	};
	if "`section_nr'"=="c05" {;
		local section_full_name="c05 Anemia tests";
	};

	*** Tabulation of F-tests for indicators only;
	cap proportion ftest if section_var=="`section_full_name'" & indic_var==1, missing;
	if _rc!=0 {;
		mat I_`section_nr'_ftest=.\.\.\0;
		mat I_`section_nr'_ftest= I_`section_nr'_ftest[2..4,1];
		mat rownames I_`section_nr'_ftest=Significant Missing "Number of indicators";
	};
	else {;
		mat A=e(b);
		* Note: Matrix A has 3 columns if there are missing observations, less if there is missing data or if all tests were significant or if all tests were not significant;
		if colsof(A)==1  & e(label1)=="0" {;
			mat I_`section_nr'_ftest=e(b)'\0\0\e(N);
			mat I_`section_nr'_ftest= I_`section_nr'_ftest[2..4,1];
			mat rownames I_`section_nr'_ftest=Significant Missing "Number of indicators";
		};
		if colsof(A)==1  & e(label1)=="1" {;
			mat I_`section_nr'_ftest=0\e(b)'\0\e(N);
			mat I_`section_nr'_ftest= I_`section_nr'_ftest[2..4,1];
			mat rownames I_`section_nr'_ftest=Significant Missing "Number of indicators";
		};
		if colsof(A)==1  & e(label1)=="." {;
			mat I_`section_nr'_ftest=0\0\e(b)'\e(N);
			mat I_`section_nr'_ftest= I_`section_nr'_ftest[2..4,1];
			mat rownames I_`section_nr'_ftest=Significant Missing "Number of indicators";
		};
		if colsof(A)==2 & e(label1)=="0 1" {;
			mat I_`section_nr'_ftest=e(b)'\0\e(N);
			mat I_`section_nr'_ftest= I_`section_nr'_ftest[2..4,1];
			mat rownames I_`section_nr'_ftest=Significant Missing "Number of indicators";
		};
		if colsof(A)==2 & e(label1)=="1 ." {;
			mat I_`section_nr'_ftest=0\e(b)'\e(N);
			mat I_`section_nr'_ftest= I_`section_nr'_ftest[2..4,1];
			mat rownames I_`section_nr'_ftest=Significant Missing "Number of indicators";
		};
		if colsof(A)==2 & e(label1)=="0 ." {;
			mat I_`section_nr'_ftest=el(e(b),1,1)\0\el(e(b),1,2)\e(N);
			mat I_`section_nr'_ftest= I_`section_nr'_ftest[2..4,1];
			mat rownames I_`section_nr'_ftest=Significant Missing "Number of indicators";
		};
		if colsof(A)==3 {;
			mat I_`section_nr'_ftest=e(b)'\e(N);
			mat I_`section_nr'_ftest= I_`section_nr'_ftest[2..4,1];
			mat rownames I_`section_nr'_ftest=Significant Missing "Number of indicators";
		};
	};
	
	*** Tabulation of F-tests for covariates only;
	cap proportion ftest if section_var=="`section_full_name'" & indic_var==0, missing;
	if _rc!=0 {;
		mat C_`section_nr'_ftest=.\.\.\0;
		mat C_`section_nr'_ftest= C_`section_nr'_ftest[2..4,1];
		mat rownames C_`section_nr'_ftest=Significant Missing "Number of indicators";
	};
	else {;
		mat A=e(b);
		* Note: Matrix A has 3 columns if there are missing observations, less if there is missing data or if all tests were significant or if all tests were not significant;
		if colsof(A)==1  & e(label1)=="0" {;
			mat C_`section_nr'_ftest=e(b)'\0\0\e(N);
			mat C_`section_nr'_ftest= C_`section_nr'_ftest[2..4,1];
			mat rownames C_`section_nr'_ftest=Significant Missing "Number of indicators";
		};
		if colsof(A)==1  & e(label1)=="1" {;
			mat C_`section_nr'_ftest=0\e(b)'\0\e(N);
			mat C_`section_nr'_ftest= C_`section_nr'_ftest[2..4,1];
			mat rownames C_`section_nr'_ftest=Significant Missing "Number of indicators";
		};
		if colsof(A)==1  & e(label1)=="." {;
			mat C_`section_nr'_ftest=0\0\e(b)'\e(N);
			mat C_`section_nr'_ftest= C_`section_nr'_ftest[2..4,1];
			mat rownames C_`section_nr'_ftest=Significant Missing "Number of indicators";
		};
		if colsof(A)==2 & e(label1)=="0 1" {;
			mat C_`section_nr'_ftest=e(b)'\0\e(N);
			mat C_`section_nr'_ftest= C_`section_nr'_ftest[2..4,1];
			mat rownames C_`section_nr'_ftest=Significant Missing "Number of indicators";
		};
		if colsof(A)==2 & e(label1)=="1 ." {;
			mat C_`section_nr'_ftest=0\e(b)'\e(N);
			mat C_`section_nr'_ftest= C_`section_nr'_ftest[2..4,1];
			mat rownames C_`section_nr'_ftest=Significant Missing "Number of indicators";
		};
		if colsof(A)==2 & e(label1)=="0 ." {;
			mat C_`section_nr'_ftest=el(e(b),1,1)\0\el(e(b),1,2)\e(N);
			mat C_`section_nr'_ftest= C_`section_nr'_ftest[2..4,1];
			mat rownames C_`section_nr'_ftest=Significant Missing "Number of indicators";
		};
		if colsof(A)==3 {;
			mat C_`section_nr'_ftest=e(b)'\e(N);
			mat C_`section_nr'_ftest= C_`section_nr'_ftest[2..4,1];
			mat rownames C_`section_nr'_ftest=Significant Missing "Number of indicators";
		};
	};

	foreach var of varlist ttest_t1_c ttest_t2_c ttest_t3_c ttest_t1_t2 ttest_t1_t3 ttest_t2_t3 {;
	
		*** Tabulation of T-tests for indicators only;
		cap proportion `var'  if section_var=="`section_full_name'" & indic_var==1, missing;
		if _rc!=0 {;
			mat I_`section_nr'_`var'=.\.\.;
			mat I_`section_nr'_`var'= I_`section_nr'_`var'[2..3,1];
			mat rownames I_`section_nr'_`var'=Significant Missing;
		};
		else {;
			mat A=e(b);
			if colsof(A)==1  & e(label1)=="0" {;
				mat I_`section_nr'_`var'=e(b)'\0\0;
				mat I_`section_nr'_`var'= I_`section_nr'_`var'[2..3,1];
				mat rownames I_`section_nr'_`var'=Significant Missing;
			};
			if colsof(A)==1  & e(label1)=="1" {;
				mat I_`section_nr'_`var'=0\e(b)'\0;
				mat I_`section_nr'_`var'= I_`section_nr'_`var'[2..3,1];
				mat rownames I_`section_nr'_`var'=Significant Missing;
			};
			if colsof(A)==1  & e(label1)=="." {;
				mat I_`section_nr'_`var'=0\0\e(b)';
				mat I_`section_nr'_`var'= I_`section_nr'_`var'[2..3,1];
				mat rownames I_`section_nr'_`var'=Significant Missing;
			};
			if colsof(A)==2 & e(label1)=="0 1" {;
				mat I_`section_nr'_`var'=e(b)'\0;
				mat I_`section_nr'_`var'= I_`section_nr'_`var'[2..3,1];
				mat rownames I_`section_nr'_`var'=Significant Missing;
			};
			if colsof(A)==2 & e(label1)=="1 ." {;
				mat I_`section_nr'_`var'=0\e(b)';
				mat I_`section_nr'_`var'= I_`section_nr'_`var'[2..3,1];
				mat rownames I_`section_nr'_`var'=Significant Missing;
			};
			if colsof(A)==2 & e(label1)=="0 ." {;
				mat I_`section_nr'_`var'=el(e(b),1,1)\0\el(e(b),1,2);
				mat I_`section_nr'_`var'= I_`section_nr'_`var'[2..3,1];
				mat rownames I_`section_nr'_`var'=Significant Missing;
			};
			if colsof(A)==3 {;
				mat I_`section_nr'_`var'=e(b)';
				mat I_`section_nr'_`var'= I_`section_nr'_`var'[2..3,1];
				mat rownames I_`section_nr'_`var'=Significant Missing;
			};
		};

		*** Tabulation of T-tests for covariates only;
		cap proportion `var' if section_var=="`section_full_name'" & indic_var==0, missing;
		if _rc!=0 {;
			mat C_`section_nr'_`var'=.\.\.;
			mat C_`section_nr'_`var'= C_`section_nr'_`var'[2..3,1];
			mat rownames C_`section_nr'_`var'=Significant Missing;
		};
		else {;
			mat A=e(b);
			if colsof(A)==1  & e(label1)=="0" {;
				mat C_`section_nr'_`var'=e(b)'\0\0;
				mat C_`section_nr'_`var'= C_`section_nr'_`var'[2..3,1];
				mat rownames C_`section_nr'_`var'=Significant Missing;
			};
			if colsof(A)==1  & e(label1)=="1" {;
				mat C_`section_nr'_`var'=0\e(b)'\0;
				mat C_`section_nr'_`var'= C_`section_nr'_`var'[2..3,1];
				mat rownames C_`section_nr'_`var'=Significant Missing;
			};
			if colsof(A)==1  & e(label1)=="." {;
				mat C_`section_nr'_`var'=0\0\e(b)';
				mat C_`section_nr'_`var'= C_`section_nr'_`var'[2..3,1];
				mat rownames C_`section_nr'_`var'=Significant Missing;
			};
			if colsof(A)==2 & e(label1)=="0 1" {;
				mat C_`section_nr'_`var'=e(b)'\0;
				mat C_`section_nr'_`var'= C_`section_nr'_`var'[2..3,1];
				mat rownames C_`section_nr'_`var'=Significant Missing;
			};
			if colsof(A)==2 & e(label1)=="1 ." {;
				mat C_`section_nr'_`var'=0\e(b)';
				mat C_`section_nr'_`var'= C_`section_nr'_`var'[2..3,1];
				mat rownames C_`section_nr'_`var'=Significant Missing;
			};
			if colsof(A)==2 & e(label1)=="0 ." {;
				mat C_`section_nr'_`var'=el(e(b),1,1)\0\el(e(b),1,2);
				mat C_`section_nr'_`var'= C_`section_nr'_`var'[2..3,1];
				mat rownames C_`section_nr'_`var'=Significant Missing;
			};
			if colsof(A)==3 {;
				mat C_`section_nr'_`var'=e(b)';
				mat C_`section_nr'_`var'= C_`section_nr'_`var'[2..3,1];
				mat rownames C_`section_nr'_`var'=Significant Missing;
			};
		};
	};

	mat I_`section_nr'_section=I_`section_nr'_ftest\ I_`section_nr'_ttest_t1_c\ I_`section_nr'_ttest_t2_c\ I_`section_nr'_ttest_t3_c\ I_`section_nr'_ttest_t1_t2\ I_`section_nr'_ttest_t1_t3\ I_`section_nr'_ttest_t2_t3;
	mat C_`section_nr'_section=C_`section_nr'_ftest\ C_`section_nr'_ttest_t1_c\ C_`section_nr'_ttest_t2_c\ C_`section_nr'_ttest_t3_c\ C_`section_nr'_ttest_t1_t2\ C_`section_nr'_ttest_t1_t3\ C_`section_nr'_ttest_t2_t3;
};

*** Obtain tables indicating, for both the whole questionnaire and each section, if F-tests and T-tests were not performed on indicators/covariates, if they were significant when they were performed, and the number of indicators/covariates involved in the calculations;

mat I_significance_table=I_all_sections, I_a01_section, I_a02_section, I_a03_section, I_a04_b08_section, I_b01_section, I_b02_section, I_b03_section, I_b04_section, I_b03_b04_section, I_b05_section, I_b06_section, I_b07_section, I_b09_section, I_c01_section, I_c02_section, I_c03_section, I_c04_section, I_c05_section;
mat colnames I_significance_table="All sections" "a01 Household roster" "a02 Education" "a03 Labor" "a04_b08 Health knowledge" "b01 Health status and utilization" "b02 Mental health" "b03 Reproductive health" "b04 Pregnancy history" "b03_b04 Reprod health-Pregnancy" "b05 Birth history" "b06 Antenatal and postnatal care" "b07 Patient satisf/knowledge" "b09 Height and weight" "c01 Health status and utilization" "c02 Vaccination" "c03 Immunization" "c04 Height and weight" "c05 Anemia tests";
mat2txt, matrix(I_significance_table) saving($resultdir/Indicators_Significance_table_individual.txt) append;


mat C_significance_table=C_all_sections, C_a01_section, C_a02_section, C_a03_section, C_a04_b08_section, C_b01_section, C_b02_section, C_b03_section, C_b04_section, C_b03_b04_section, C_b05_section, C_b06_section, C_b07_section, C_b09_section, C_c01_section, C_c02_section, C_c03_section, C_c04_section, C_c05_section;
mat colnames C_significance_table="All sections" "a01 Household roster" "a02 Education" "a03 Labor" "a04_b08 Health knowledge" "b01 Health status and utilization" "b02 Mental health" "b03 Reproductive health" "b04 Pregnancy history" "b03_b04 Reprod health-Pregnancy " "b05 Birth history" "b06 Antenatal and postnatal care" "b07 Patient satisf/knowledge" "b09 Height and weight" "c01 Health status and utilization" "c02 Vaccination" "c03 Immunization" "c04 Height and weight" "c05 Anemia tests";
mat2txt, matrix(C_significance_table) saving($resultdir/Covariates_Significance_table_individual.txt) append;

mat drop _all;

**************************************************************
*** T-test and F-test summary stats on Household level dataset
**************************************************************;

* Note: No indicator in the household section;

cap erase $resultdir/Covariates_Significance_table_household.txt;

use $tempdatadir/rwhrbf_hhlevel_baseline_balance_table_with_tests_flags.dta, clear;

*** General tabulations for all sections;

proportion ftest if indic_var==0, missing;
mat C_all_ftest=e(b)'\e(N);
mat C_all_ftest= C_all_ftest[2..4,1];
mat rownames C_all_ftest=Significant Missing "Number of covariates";

foreach var of varlist ttest_t1_c ttest_t2_c ttest_t3_c ttest_t1_t2 ttest_t1_t3 ttest_t2_t3 {;
	
	proportion `var' if indic_var==0, missing;
	mat C_all_`var'=e(b)';
	mat C_all_`var'= C_all_`var'[2..3,1];
	mat rownames C_all_`var'=Significant Missing;
};

mat C_all_sections=C_all_ftest\ C_all_ttest_t1_c\ C_all_ttest_t2_c\ C_all_ttest_t3_c\ C_all_ttest_t1_t2\ C_all_ttest_t1_t3\ C_all_ttest_t2_t3;

*** Tabulations by section of the questionnaire;

foreach section_nr in a00_1 a05_a00_a06 a07 a00_2 a00_a08 {;

	if "`section_nr'"=="a00_1" {;
		local section_full_name="a00 Housing";
	};
	if "`section_nr'"=="a05_a00_a06" {;
		local section_full_name= "a05_a00_a06 Household assets";
	};
	if "`section_nr'"=="a07" {;
		local section_full_name="a07 Transfers and other income";
	};
	if "`section_nr'"=="a00_2" {;
		local section_full_name= "a00 Subjective life valuation";
	};
	if "`section_nr'"=="a00_a08" {;
		local section_full_name="a00_a08 Mortality";
	};

	*** Tabulation of F-tests for covariates only;
	cap proportion ftest if section_var=="`section_full_name'" & indic_var==0, missing;
	if _rc!=0 {;
		mat C_`section_nr'_ftest=.\.\.\0;
		mat C_`section_nr'_ftest= C_`section_nr'_ftest[2..4,1];
		mat rownames C_`section_nr'_ftest=Significant Missing "Number of indicators";
	};
	else {;
		mat A=e(b);
		* Note: Matrix A has 3 columns if there are missing observations, less if there is missing data or if all tests were significant or if all tests were not significant;
		if colsof(A)==1  & e(label1)=="0" {;
			mat C_`section_nr'_ftest=e(b)'\0\0\e(N);
			mat C_`section_nr'_ftest= C_`section_nr'_ftest[2..4,1];
			mat rownames C_`section_nr'_ftest=Significant Missing "Number of indicators";
		};
		if colsof(A)==1  & e(label1)=="1" {;
			mat C_`section_nr'_ftest=0\e(b)'\0\e(N);
			mat C_`section_nr'_ftest= C_`section_nr'_ftest[2..4,1];
			mat rownames C_`section_nr'_ftest=Significant Missing "Number of indicators";
		};
		if colsof(A)==1  & e(label1)=="." {;
			mat C_`section_nr'_ftest=0\0\e(b)'\e(N);
			mat C_`section_nr'_ftest= C_`section_nr'_ftest[2..4,1];
			mat rownames C_`section_nr'_ftest=Significant Missing "Number of indicators";
		};
		if colsof(A)==2 & e(label1)=="0 1" {;
			mat C_`section_nr'_ftest=e(b)'\0\e(N);
			mat C_`section_nr'_ftest= C_`section_nr'_ftest[2..4,1];
			mat rownames C_`section_nr'_ftest=Significant Missing "Number of indicators";
		};
		if colsof(A)==2 & e(label1)=="1 ." {;
			mat C_`section_nr'_ftest=0\e(b)'\e(N);
			mat C_`section_nr'_ftest= C_`section_nr'_ftest[2..4,1];
			mat rownames C_`section_nr'_ftest=Significant Missing "Number of indicators";
		};
		if colsof(A)==2 & e(label1)=="0 ." {;
			mat C_`section_nr'_ftest=el(e(b),1,1)\0\el(e(b),1,2)\e(N);
			mat C_`section_nr'_ftest= C_`section_nr'_ftest[2..4,1];
			mat rownames C_`section_nr'_ftest=Significant Missing "Number of indicators";
		};
		if colsof(A)==3 {;
			mat C_`section_nr'_ftest=e(b)'\e(N);
			mat C_`section_nr'_ftest= C_`section_nr'_ftest[2..4,1];
			mat rownames C_`section_nr'_ftest=Significant Missing "Number of indicators";
		};
	};

	foreach var of varlist ttest_t1_c ttest_t2_c ttest_t3_c ttest_t1_t2 ttest_t1_t3 ttest_t2_t3 {;

		*** Tabulation of T-tests for covariates only;
		cap proportion `var' if section_var=="`section_full_name'" & indic_var==0, missing;
		if _rc!=0 {;
			mat C_`section_nr'_`var'=.\.\.;
			mat C_`section_nr'_`var'= C_`section_nr'_`var'[2..3,1];
			mat rownames C_`section_nr'_`var'=Significant Missing;
		};
		else {;
			mat A=e(b);
			if colsof(A)==1  & e(label1)=="0" {;
				mat C_`section_nr'_`var'=e(b)'\0\0;
				mat C_`section_nr'_`var'= C_`section_nr'_`var'[2..3,1];
				mat rownames C_`section_nr'_`var'=Significant Missing;
			};
			if colsof(A)==1  & e(label1)=="1" {;
				mat C_`section_nr'_`var'=0\e(b)'\0;
				mat C_`section_nr'_`var'= C_`section_nr'_`var'[2..3,1];
				mat rownames C_`section_nr'_`var'=Significant Missing;
			};
			if colsof(A)==1  & e(label1)=="." {;
				mat C_`section_nr'_`var'=0\0\e(b)';
				mat C_`section_nr'_`var'= C_`section_nr'_`var'[2..3,1];
				mat rownames C_`section_nr'_`var'=Significant Missing;
			};
			if colsof(A)==2 & e(label1)=="0 1" {;
				mat C_`section_nr'_`var'=e(b)'\0;
				mat C_`section_nr'_`var'= C_`section_nr'_`var'[2..3,1];
				mat rownames C_`section_nr'_`var'=Significant Missing;
			};
			if colsof(A)==2 & e(label1)=="1 ." {;
				mat C_`section_nr'_`var'=0\e(b)';
				mat C_`section_nr'_`var'= C_`section_nr'_`var'[2..3,1];
				mat rownames C_`section_nr'_`var'=Significant Missing;
			};
			if colsof(A)==2 & e(label1)=="0 ." {;
				mat C_`section_nr'_`var'=el(e(b),1,1)\0\el(e(b),1,2);
				mat C_`section_nr'_`var'= C_`section_nr'_`var'[2..3,1];
				mat rownames C_`section_nr'_`var'=Significant Missing;
			};
			if colsof(A)==3 {;
				mat C_`section_nr'_`var'=e(b)';
				mat C_`section_nr'_`var'= C_`section_nr'_`var'[2..3,1];
				mat rownames C_`section_nr'_`var'=Significant Missing;
			};
		};
	};

	mat C_`section_nr'_section=C_`section_nr'_ftest\ C_`section_nr'_ttest_t1_c\ C_`section_nr'_ttest_t2_c\ C_`section_nr'_ttest_t3_c\ C_`section_nr'_ttest_t1_t2\ C_`section_nr'_ttest_t1_t3\ C_`section_nr'_ttest_t2_t3;
};

*** Obtain tables indicating, for both the whole questionnaire and each section, if F-tests and T-tests were not performed on covariates, if they were significant when they were performed, and the number of covariates involved in the calculations;

mat C_significance_table=C_all_sections, C_a00_1_section, C_a05_a00_a06_section, C_a07_section, C_a00_2_section, C_a00_a08_section;

mat colnames C_significance_table="All sections" "a00 Housing" "a05_a00_a06 Household assets" "a07 Transfers and other income" "a00 Subjective life valuation" "a00_a08 Mortality";
mat2txt, matrix(C_significance_table) saving($resultdir/Covariates_Significance_table_household.txt) append;

mat drop _all;

log close;

