*Matt Mulligan Nov 11 Based on rwanda_cr29_basyinetables.do by yisa Rothenbuhler
*To be used with Master Do file

version 10.0
clear 
cap log close

log using "$log/rwanda_chw_basyinetables.log", replace

*******************************************************
*** Save all .txt output files into .dta Stata datasets
*******************************************************

foreach x in 01 02 03 04 05 06 07 08 09 {
	insheet using "$tempres/means_`x'.txt", names clear
	cap drop v5
	drop if v1==""
	ren v1 Variable
	ren obs Obs
	ren mean Mean
	ren std_dev SD
	save "$tempres/means_`x'.dta", replace
	clear

	insheet using "$tempres/Fpval_`x'.txt", names clear
	cap drop v3 v4 v5
	drop if v1==""
	ren v1 Variable
	ren ftest_pvalue Pval_Ftest
	save "$tempres/Fpval_`x'.dta", replace
	clear
	
*Renames Variables for Merge	
	foreach y in D_c D_S D_DS S_c S_DS DS_c {
	//insheet using $tempres/a`x'_all_`y'.txt, names clear
	use "$tempres/a`x'_all_`y'.dta", clear
	drop line
	ren variablename Variable
	
	if strmatch("`y'","D_c")==1 {
		ren meantreatment Mean_D
		ren errortreatment SD_D
		ren nobstreatment Obs_D
		ren meancontrol Mean_C
		ren errorcontrol SD_C
		ren nobscontrol Obs_C
		ren difference Diff_D_C
		ren tstat Tstat_D_C
		ren nobstotal Obs_total_D_C
		ren significance Pval_D_C
		ren stars stars_D_C
	}
	if strmatch("`y'","S_c")==1 {
		ren meantreatment Mean_S
		ren errortreatment SD_S
		ren nobstreatment Obs_S
		ren meancontrol Mean_C
		ren errorcontrol SD_C
		ren nobscontrol Obs_C
		ren difference Diff_S_C
		ren tstat Tstat_S_C
		ren nobstotal Obs_total_S_C
		ren significance Pval_S_C
		ren stars stars_S_C
		drop Mean_C SD_C Obs_C
	}
	if strmatch("`y'","DS_c")==1 {
		ren meantreatment Mean_DS
		ren errortreatment SD_DS
		ren nobstreatment Obs_DS
		ren meancontrol Mean_C
		ren errorcontrol SD_C
		ren nobscontrol Obs_C
		ren difference Diff_DS_C
		ren tstat Tstat_DS_C
		ren nobstotal Obs_total_DS_C
		ren significance Pval_DS_C
		ren stars stars_DS_C
		drop Mean_C SD_C Obs_C
	}
	if strmatch("`y'","D_S")==1 {
		ren meantreatment Mean_D
		ren errortreatment SD_D
		ren nobstreatment Obs_D
		ren meancontrol Mean_S
		ren errorcontrol SD_S
		ren nobscontrol Obs_S
		ren difference Diff_D_S
		ren tstat Tstat_D_S
		ren nobstotal Obs_total_D_S
		ren significance Pval_D_S
		ren stars stars_D_S
		drop Mean_D SD_D Obs_D
		drop Mean_S SD_S Obs_S
	}
	if strmatch("`y'","D_DS")==1 {
		ren meantreatment Mean_D
		ren errortreatment SD_D
		ren nobstreatment Obs_D
		ren meancontrol Mean_DS
		ren errorcontrol SD_DS
		ren nobscontrol Obs_DS
		ren difference Diff_D_DS
		ren tstat Tstat_D_DS
		ren nobstotal Obs_total_D_DS
		ren significance Pval_D_DS
		ren stars stars_D_DS
		drop Mean_D SD_D Obs_D
		drop Mean_DS SD_DS Obs_DS
	}
	if strmatch("`y'","S_DS")==1 {
		ren meantreatment Mean_S
		ren errortreatment SD_S
		ren nobstreatment Obs_S
		ren meancontrol Mean_DS
		ren errorcontrol SD_DS
		ren nobscontrol Obs_DS
		ren difference Diff_S_DS
		ren tstat Tstat_S_DS
		ren nobstotal Obs_total_S_DS
		ren significance Pval_S_DS
		ren stars stars_S_DS
		drop Mean_S SD_S Obs_S
		drop Mean_DS SD_DS Obs_DS
	}
save "$tempres/`x'`y'_essential.dta", replace

	}
}
clear
********************************************************************
*** Build Baseline sample balance table for household-level variables
*********************************************************************

use "$tempres/desc01_labels.dta", clear
sort Variable
local i=0
foreach c in 02 03 04 05 06 07 08 09 {
	merge Variable using "$tempres/desc`c'_labels.dta", sort unique _merge(_merge`i')
	local i = `i' + 1
}

drop _merge0-_merge7

sort Variable idnum
local i=0

foreach a in 01 02 03 04 05 06 07 08 09 {
	
		
		merge Variable using "$tempres/means_`a'.dta", sort unique _merge(_merge`i') update 
		local i =`i'+1
		merge Variable using "$tempres/Fpval_`a'.dta", sort unique _merge(_merge`i') update 
		local i =`i'+1
		merge Variable using "$tempres/`a'D_c_essential.dta", sort unique _merge(_merge`i') update 
		local i =`i'+1
		merge Variable using "$tempres/`a'D_S_essential.dta", sort unique _merge(_merge`i') update 
		local i =`i'+1
		merge Variable using "$tempres/`a'D_DS_essential.dta", sort unique _merge(_merge`i') update 
		local i =`i'+1
		merge Variable using "$tempres/`a'S_c_essential.dta", sort unique _merge(_merge`i') update 
		local i =`i'+1
		merge Variable using "$tempres/`a'S_DS_essential.dta", sort unique _merge(_merge`i') update 
		local i =`i'+1
		merge Variable using "$tempres/`a'DS_c_essential.dta", sort unique _merge(_merge`i') update 
		local i =`i'+1
}

sort idnum order

tab1 _merge*
drop _merge*

foreach var of varlist Obs Mean SD Pval_Ftest {
	destring `var', replace
}

gen stars_Ftest="";
replace stars_Ftest="*" if Pval_Ftest<0.1
replace stars_Ftest="**" if Pval_Ftest<0.05
replace stars_Ftest="***" if Pval_Ftest<0.01

rename varlab Variable_label


order idnum Variable Variable_label Mean SD Obs Pval_Ftest stars_Ftest stars_D_C stars_S_C stars_DS_C stars_D_S stars_D_DS stars_S_DS Mean_D Obs_D Mean_S Obs_S Mean_DS Obs_DS Mean_C Obs_C Pval_D_C Pval_S_C Pval_DS_C Pval_D_S Pval_D_DS Pval_S_DS SD_D SD_S SD_DS SD_C Diff_D_C Diff_S_C Diff_DS_C Diff_D_S Diff_D_DS Diff_S_DS Tstat_D_C Tstat_S_C Tstat_DS_C Tstat_D_S Tstat_D_DS Tstat_S_DS Obs_total_D_C Obs_total_S_C Obs_total_DS_C Obs_total_D_S Obs_total_D_DS Obs_total_S_DS 
keep idnum Variable Variable_label Mean SD Obs Pval_Ftest stars_Ftest stars_D_C stars_S_C stars_DS_C stars_D_S stars_D_DS stars_S_DS Mean_D Obs_D Mean_S Obs_S Mean_DS Obs_DS Mean_C Obs_C Pval_D_C Pval_S_C Pval_DS_C Pval_D_S Pval_D_DS Pval_S_DS SD_D SD_S SD_DS SD_C Diff_D_C Diff_S_C Diff_DS_C Diff_D_S Diff_D_DS Diff_S_DS Tstat_D_C Tstat_S_C Tstat_DS_C Tstat_D_S Tstat_D_DS Tstat_S_DS Obs_total_D_C Obs_total_S_C Obs_total_DS_C Obs_total_D_S Obs_total_D_DS Obs_total_S_DS



foreach var of varlist Obs Obs_D Obs_S Obs_DS Obs_C Obs_total_D_C Obs_total_S_C Obs_total_DS_C Obs_total_D_S Obs_total_D_DS Obs_total_S_DS {
	format `var' %6.0f
}


foreach var of varlist Mean SD Pval_Ftest Mean_D SD_D Mean_S SD_S Mean_DS SD_DS Mean_C SD_C Pval_D_C Pval_S_C Pval_DS_C Pval_D_S Pval_D_DS Pval_S_DS Diff_D_C Diff_S_C Diff_DS_C Diff_D_S Diff_D_DS Diff_S_DS {
	format `var' %8.3f
}
foreach var of varlist Tstat_D_C Tstat_S_C Tstat_DS_C Tstat_D_S Tstat_D_DS Tstat_S_DS {
	format `var' %8.2f
}

	format Variable_label %-36s
	format Variable %-16s
	

save "$tempres/rwchw_baseline_mergetable.dta", replace
outsheet using "$output/rwanda_CHW_baseline_balance.txt", replace

log close

exit