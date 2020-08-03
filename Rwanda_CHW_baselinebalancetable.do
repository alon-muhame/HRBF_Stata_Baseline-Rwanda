*Matt Mulligan Nov 11 Based on work by Elisa

* This do-file:
* creates summary statistics which assess the percentage, for each section of the questionnaire, of:



version 10.0
clear
set more off
set mem 500m
cap log close


ssc install mat2txt

log using "$log/rwanda_CHW_baselinebalancetables.log", replace

***************************************************************
*** T-test and F-test summary stats on Individual level dataset
*** For all individuals
***************************************************************;

cap erase "$output/Baseline_Significance_table.txt"
cap mat drop _all

use "$tempres/rwchw_baseline_mergetable.dta", clear

gen ftestind = Pval_Ftest<=.05 if !missing(Pval_Ftest)

//First Row Number of Variables
count if Pval_Ftest==. | Pval_Ftest !=.
local n = r(N)
foreach x of numlist 1/9 {
	count if idnum==`x'
	local n`x' = r(N) 
}
*local n is used for every other line too
//Missing for Last entry in first row.

mat def I = (`n', `n1', `n2', `n3', `n4', `n5', `n6', `n7', `n8',`n9', 0)
mat rownames I = "Number of Variables"
mat colnames I = AllSections Section1 Section2 Section3 Section4 Section5 Section6 Section7 Section8 Section9 Missing
mat2txt, matrix(I) saving("$output\Baseline_Significance_table.txt") append
*Not enough missing Ftests of Ttests to justify reporting in table.  Make note at the Bottom of Table
mat drop I


// Ttests Percentage Missing
foreach x in Ftest D_C S_C DS_C D_S D_DS S_DS {
	count if Pval_`x'==. 
	local m = r(N)
	count if Pval_`x'<=.05
	local s = (r(N))/(`n'-`m')
	local ms = (`m')/(`n')
	
	foreach y of numlist 1/9 {
		count if Pval_`x'==. & idnum==`y'
		local m`y' = r(N)
		count if Pval_`x'<=.05	& idnum==`y'
		local s`y' = (r(N))/(`n`y''-`m`y'')
	}
	
	mat def I = (`s', `s1', `s2', `s3', `s4', `s5', `s6', `s7', `s8',`s9', `m')
	
	if "`x'" == "Ftest" {
		mat rownames I = "% Significant for Ftest"	
	}
	else {
		mat rownames I = "% Significant for Ttest `x'"
	}
	
	mat colnames I = AllSections Section1 Section2 Section3 Section4 Section5 Section6 Section7 Section8 Section9 Missing
	mat2txt, matrix(I) saving("$output\Baseline_Significance_table.txt") append

	mat drop I
}





//proportion ftestind if !missing(ftestind)
//mat def I = (el(e(b),1,2), `n', e(N), `m')
//mat rownames I = "Ftest All Variables"
//mat colnames I = "Proportion Significant" "Number Significant" "Total Values" "Missing"
//mat2txt, matrix(I) saving("$output\Baseline_Significance_table.txt") append
//mat drop I





//foreach x in D_C S_C DS_C D_S D_DS S_DS {
	
//	count if Pval_`x' ==. 
//	local m = r(N)
//	count if Pval_`x' !=.
//	local n = r(N)
//	count if Pval_`x' <=.05 
//	local s = r(N)
//	mat def I = (`s'/`n', `s', `n', `m')
//	mat rownames I = "Ttest `x' All Variables"
//	mat colnames I = "Proportion Significant" "Number Significant" "Total Values" "Missing"
//	mat2txt, matrix(I) saving("$output\Baseline_Significance_table.txt") append
//	mat drop I
	
	
//}

//By Section

//foreach y of numlist 1/9 {
//	preserve
//	keep if idnum ==`y'
//	foreach x in Ftest D_C S_C DS_C D_S D_DS S_DS {

//		count if Pval_`x'==. 
//		local m = r(N)
//		count if Pval_`x' !=.
//		local n = r(N)
//		count if Pval_`x' <=.05 
//		local s = r(N)
//		mat def I = (`s'/`n', `s', `n', `m')
//		mat rownames I = "Ttest `x' Section `y'"
//		mat colnames I = "Proportion Significant" "Number Significant" "Total Values" "Missing"
//		mat2txt, matrix(I) saving("$output\Baseline_Significance_table.txt") append
//		mat drop I	
//	}
//	restore
//}

save "$tempres\Baseline_Significance_table1.dta", replace	

insheet using "$output\Baseline_Significance_table.txt", names clear
drop if v1==""
destring allsection section1-section9, replace
//destring proportionsignificant, replace float
//replace proportionsignificant = 100*proportionsignificant
//rename proportionsignificant percent_significant
drop v13
format allsection section1-section9 %4.2f

save "$tempres\Baseline_Significance_table_final.dta", replace
outsheet using "$output/Baseline_Significance_table_final.txt", replace

log close
exit