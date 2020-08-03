* Jennifer Sturdy September 2010 Updated Matt Mulligan Nov 11
* This do-file creates means, f-tests and t-tests
* Use with Master Do File

version 10.0
clear
cap log close
set trace off

ssc install lincomest
ssc install makematrix
ssc install mat2txt

log using "$log\Rwanda_CHW an1.log", replace

*************************************************************************************************************************************
local descvar_01 "d1_00 d1_00_2 d1_01_2 d1_02 d1_03_2 d1_04 d1_05_2 d1_06_2 d1_07a_2 d1_07b_2 d1_07c_2 d1_07d_2 d1_07e_2 d1_08 d1_09_3_2 d1_09_5_2 d1_09_6_2 d1_09_7_2 d1_10 d1_11_2 d1_12_2 d1_13y time_chw d1_14days d1_14hrs hours_week d1_15km total_minutes_HC d1_17_2 d1_18_2 d1_23_2  d1_24 d1_25_2 d1_26_2 d1_27_2"
local descvar_02 "d2_01a_2- d2_06w_2"
local descvar_03 "d3_01_2 d3_02 d3_03a- d3_03fth d3_04_2 d3_06a- d3_06fth d3_07_2 d3_08a- d3_09c d3_10_2 d3_12_2 d3_13_2 d3_13_3 d3_14_2 d3_15_2"
local descvar_04 "d4_01_2 d4_02a_2 d4_02b_2 d4_02c_2 d4_02d_2 d4_02e_2 d4_02fth_2 d4_03 d4_04_2 d4_05a_2 d4_05b_2 d4_05c_2 d4_05d_2 d4_05e_2 d4_05f_2 d4_05g_2 d4_05h_2 d4_05i_2"
local descvar_05 "d5_01_2 d5_02a_2- d5_02ith_2 d5_03_2 d5_04_2 d5_05a_2- d5_05fth_2"
local descvar_06 "d6_01a_2-d6_05e_2 d6_06_2 d6_07_2 d6_08_2 d6_09a_2- d6_09rth_23 d6_10a_2- d6_10qth_2"
local descvar_07 "d7_01a- d7_healthscore"
local descvar_08 "d8_01-d8_17 "
local descvar_09 "d9_01- d9_10"
***************************************************************************************************************************************


foreach x in 01 02 03 04 05 06 07 08 09 {
	display "`x'"
	use "$clean\rwHRBF_D CHWs -`x'.dta", clear
	cap erase "$tempres\means_`x'.txt"
	display "`x'"
*** Means and Standard Errors
		
	foreach var of varlist `descvar_`x'' {
	display "`var'"
		qui regress `var', vce(cluster hrbf_id1) 
		mat def `var'= (e(N),el(e(b),1,1),(el(e(V),1,1))^(1/2))
		mat colnames `var'=Obs Mean Std_Dev
		mat rownames `var'=`var'
	
		mat list `var'
		mat2txt, matrix(`var') saving("$tempres\means_`x'.txt") append
		mat drop `var'
	}


	//makematrix means_`x', from(e(N) el(e(b),1,1) (el(e(V),1,1))^(1/2)) label listwise: regress `descvar_`x'', vce(cluster hrbf_id1) 
	//mat2txt, matrix(means_`x') saving("$tempres\means_`x'.txt") append
	//mat drop _all

*** F-tests for all `x' variables
	cap erase "$tempres\Fpval_`x'.txt"

	
	foreach var of varlist `descvar_`x'' {
		qui reg `var' group_code_1 group_code_2 group_code_3, vce(cluster hrbf_id1) 
		mat def `var'=Ftail(e(df_m),e(df_r),e(F))
		mat colnames `var'=Ftest_Pvalue
		mat rownames `var'=`var'
		mat2txt, matrix(`var') saving($tempres/Fpval_`x'.txt) append
		mat drop `var'
	}
	


	
	//makematrix Fpval_`x', from(Ftail(e(df_m),e(df_r),e(F))) lhs(`descvar_`x'') label listwise: regress group_code_1 group_code_2 group_code_3, vce(cluster hrbf_id1)
	//mat2txt, matrix(Fpval_`x') saving("$tempres/Fpval_`x'.txt") append
	//mat drop _all

*** T-test for Means of 3 treatment and 1 control groups, for all obs
	///cap erase "$tempres\means_`x'_t1.txt"
	//cap erase "$tempres\means_`x'_t2.txt"
	//cap erase "$tempres\means_`x'_t3.txt"
	//cap erase "$tempres\means_`x'_t4.txt"
	//Had to edit the iesummarystats ado file to incorporate a more direct temp directory, and also to allow spaces in the file name.  	
	
	preserve
	keep if group_code_1==1 | group_code_4==1
	svyiesummarystats `descvar_`x'', treatment(group_code_1) psuclusterunit(hrbf_id1)  outputfile($tempres/a`x'_all_D_c) replace
	
	restore, preserve
	keep if group_code_2==1 | group_code_4==1
	svyiesummarystats `descvar_`x'', treatment(group_code_2) psuclusterunit(hrbf_id1)  outputfile($tempres/a`x'_all_S_c) replace
		
	
	restore, preserve
	keep if group_code_3==1 | group_code_4==1
	svyiesummarystats `descvar_`x'', treatment(group_code_3) psuclusterunit(hrbf_id1)  outputfile($tempres/a`x'_all_DS_c) replace
	
	restore, preserve
	keep if group_code_1==1 | group_code_2==1
	svyiesummarystats `descvar_`x'', treatment(group_code_1) psuclusterunit(hrbf_id1)  outputfile($tempres/a`x'_all_D_S) replace


	restore, preserve
	keep if group_code_1==1 | group_code_3==1
	svyiesummarystats `descvar_`x'', treatment(group_code_1) psuclusterunit(hrbf_id1)  outputfile($tempres/a`x'_all_D_DS) replace

	restore, preserve
	keep if group_code_2==1 | group_code_3==1
	svyiesummarystats `descvar_`x'', treatment(group_code_2) psuclusterunit(hrbf_id1)  outputfile($tempres/a`x'_all_S_DS) replace

	//restore, preserve
	//keep if group_code_2==1 | group_code_3==1
	//iesummarystats `descvar_`x'', treatment(group_code_2) outputfile($tempresultdir/a01_all_t2_t3) pweight(hhpweight) psuclusterunit(hrbf_id1) replace

	restore, not
}
	
	
	//forvalues t=1(1)4 {

		//makematrix means_`x'_t`t', from(e(N) el(e(b),1,1) (el(e(V),1,1))^(1/2)) label listwise: regress `descvar_`x'' if group_code_`t'==1, vce(cluster hrbf_id1) 
		//mat2txt, matrix(means_`x'_t`t') saving("$temp\means_`x'_t`t'.txt") append


//mat drop _all

//cap erase "$temp\Tstat_`x'_t1to4.txt"
//mat input Tstat_`x'_t1to4=(1,1,1,1,1,1)
//mat rownames Tstat_`x'_t1to4=ERASE
//mat colnames Tstat_`x'_t1to4=T1-C T2-C T3-C T1-T2 T1-T3 T2-T3
//mat2txt, matrix(Tstat_`x'_t1to4) saving("$temp\Tstat_`x'_t1to4.txt") replace


//foreach var of varlist `descvar_`x'' {

//	cap mat drop t1minusc t2minusc t3minusc t1minust2 t1minust3 t2minust3 `var'_tstats
//	qui regress `var' group_code_1 group_code_2 group_code_3 group_code_4, vce(cluster hrbf_id1)	
//	lincomest group_code_1-group_code_4
//	mat def t1minusc=(el(e(b),1,1)/((el(e(V),1,1))^(1/2)))
//	qui regress `var' group_code_1 group_code_2 group_code_3 group_code_4, vce(cluster hrbf_id1)
//	lincomest group_code_2-group_code_4
//	mat def t2minusc=(el(e(b),1,1)/((el(e(V),1,1))^(1/2)))
//	qui regress `var' group_code_1 group_code_2 group_code_3 group_code_4, vce(cluster hrbf_id1)
//	lincomest group_code_3-group_code_4
//	mat def t3minusc=(el(e(b),1,1)/((el(e(V),1,1))^(1/2)))
//	qui regress `var' group_code_1 group_code_2 group_code_3 group_code_4, vce(cluster hrbf_id1)
//	lincomest group_code_1-group_code_2
//	mat def t1minust2=(el(e(b),1,1)/((el(e(V),1,1))^(1/2)))
//	qui regress `var' group_code_1 group_code_2 group_code_3 group_code_4, vce(cluster hrbf_id1)
//	lincomest group_code_1-group_code_3
//	mat def t1minust3=(el(e(b),1,1)/((el(e(V),1,1))^(1/2)))
//	qui regress `var' group_code_1 group_code_2 group_code_3 group_code_4, vce(cluster hrbf_id1)
//	lincomest group_code_2-group_code_3
//	mat def t2minust3=(el(e(b),1,1)/((el(e(V),1,1))^(1/2)))
//	mat def `var'_tstats=(t1minusc,t2minusc, t3minusc, t1minust2, t1minust3, t2minust3)
//	mat rownames `var'_tstats=`var'
//	mat2txt, matrix(`var'_tstats) saving("$temp\Tstat_`x'_t1to4.txt") append
	


//clear
//insheet using "$temp\Tstat_`x'_t1to4.txt"
//drop if v1=="" | v1=="ERASE"
//drop v8
//ren v1 variable
//ren v2 t1_c
//ren v3 t2_c
//ren v4 t3_c
//ren v5 t1_t2
//ren v6 t1_t3
//ren v7 t2_t3
//outsheet using "$temp\Tstat_`x'_t1to4.txt", replace


log close
exit