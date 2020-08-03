*Matt Mulligan Nov 2011
*To be used with Master Do File

use "$tempres\rwchw_baseline_mergetable.dta", clear



*Variables to be Kept for Tables
local keepvars "Variable_label Mean SD Mean_S Mean_D Mean_DS Mean_C stars_Ftest"
order `keepvars'
local i = 1

preserve

************************************* Section 1 *******************************************
*Table - CHW Demographics
keep if Variable == "d1_01_2" | Variable =="d1_02" | Variable =="d1_03_2" | Variable =="d1_06_2" | Variable =="d1_09" | Variable =="d1_05_2" 
keep `keepvars'

outsheet using "$output/Tables/01table`i'.txt", replace
local i = `i' + 1

restore, preserve

*Table -Education
keep if Variable == "d1_09_3_2" | Variable == "d1_09_5_2" | Variable =="d1_09_6_2" | Variable == "d1_09_7_2" | Variable == "d1_10" | Variable =="d1_12_2"
keep `keepvars'

outsheet using "$output/Tables/01table`i'.txt", replace
local i = `i' + 1

restore, preserve

*Table CHW Characteristics
keep if Variable == "d1_13y" | Variable == "total_minutes_HC" | Variable =="hours_week" | Variable == "d1_17_2" | Variable == "d1_18_2" | Variable =="d1_23_2" | Variable == "d1_24" | Variable =="d1_27_2" 
keep `keepvars'

outsheet using "$output/Tables/01table`i'.txt", replace
local i = `i' + 1


**************************************Section 2 ********************************************
local i =1
restore, preserve

*Table CHW Training>50%
keep if Variable == "d2_01a_2" | Variable == "d2_01b_2" | Variable =="d2_01c_2" | Variable == "d2_01d_2" | Variable == "d2_01e_2" | Variable =="d2_01f_2" | Variable =="d2_01g_2" | Variable =="d2_01h_2" | Variable =="d2_01i_2" | Variable =="d2_01j_2" | Variable =="d2_01k_2" | Variable =="d2_01l_2" | Variable =="d2_01m_2" | Variable =="d2_01n_2" | Variable =="d2_01o_2" | Variable =="d2_01p_2" | Variable == "d2_01qth_2" 
keep if Mean >= .5
keep  Variable_label Mean SD stars_Ftest
keep  Variable_label Mean SD stars_Ftest

outsheet using "$output/Tables/02table`i'.txt", replace
local i = `i' + 1

restore, preserve
*Table CHW Training <50%
keep if Variable == "d2_01a_2" | Variable == "d2_01b_2" | Variable =="d2_01c_2" | Variable == "d2_01d_2" | Variable == "d2_01e_2" | Variable =="d2_01f_2" | Variable =="d2_01g_2" | Variable =="d2_01h_2" | Variable =="d2_01i_2" | Variable =="d2_01j_2" | Variable =="d2_01k_2" | Variable =="d2_01l_2" | Variable =="d2_01m_2" | Variable =="d2_01n_2" | Variable =="d2_01o_2" | Variable =="d2_01p_2" | Variable == "d2_01qth_2" 
keep if Mean <.5
keep  Variable_label Mean SD stars_Ftest

outsheet using "$output/Tables/02table`i'.txt", replace
local i = `i' + 1

restore, preserve

*Table CHW Training last 12 months if Greater than 50%
keep if Variable == "d2_03_2" | regexm(Variable, "d2_04")==1


keep if Mean >.5
keep  Variable_label Mean SD stars_Ftest

outsheet using "$output/Tables/02table`i'.txt", replace
local i= `i' + 1

restore, preserve
*Table CHW Training last 12 months if Less than 50%
keep if regexm(Variable, "d2_04")==1
keep if Mean <=.5
keep  Variable_label Mean SD stars_Ftest

outsheet using "$output/Tables/02table`i'.txt", replace
local i= `i' + 1

restore, preserve


*Table CHW Main Services Provided > 50%
keep if regexm(Variable, "d2_06")==1 & regexm(Variable, "d2_06w")==0
keep if Mean >.5
keep  Variable_label Mean SD stars_Ftest

outsheet using "$output/Tables/02table`i'.txt", replace
local i= `i' + 1

restore, preserve

*Table CHW Main Services Provided < 50%
keep if regexm(Variable, "d2_06")==1 
keep if Mean <=.5
keep  Variable_label Mean SD stars_Ftest

outsheet using "$output/Tables/02table`i'.txt", replace
local i= `i' + 1

restore, preserve


*************************************Section 3 ***************************************************
local i =1
*Monetary Payments Recieved
keep if Variable == "d3_01_2" | Variable == "d3_02" | Variable=="d3_03a"  | Variable == "d3_03b" | Variable == "d3_03c" | Variable =="d3_03d" | Variable =="d3_03e" | Variable =="d3_03fth" 
keep  Variable_label Mean SD stars_Ftest

outsheet using "$output/Tables/03table`i'.txt", replace
local i = `i' + 1

restore, preserve

*In-Kind Payments Recieved
keep if Variable == "d3_04_2" | Variable == "d3_06a" | Variable =="d3_06b" | Variable == "d3_06c" | Variable == "d3_06d" | Variable =="d3_06e" | Variable =="d3_06fth"
keep  Variable_label Mean SD stars_Ftest

outsheet using "$output/Tables/03table`i'.txt", replace
local i = `i' + 1

restore, preserve

*Patient Fees
keep if Variable == "d3_07_2" | Variable == "d3_10_2" | Variable =="d3_08a" | Variable == "d3_08b" | Variable == "d3_08c" | Variable =="d3_09a"| Variable == "d3_09b" | Variable == "d3_09c" 
keep  `keepvars'

outsheet using "$output/Tables/03table`i'.txt", replace
local i = `i' + 1

restore, preserve

*Income Generating Activities
keep if Variable == "d3_12_2" | Variable == "d3_13_2" | Variable =="d3_13_3" | Variable == "d3_14_2" | Variable == "d3_15_2" 
keep `keepvars'

outsheet using "$output/Tables/03table`i'.txt", replace
local i = `i' + 1

restore, preserve

********************************* Section 4 ************************************************************
local i =1
*Supervision

keep if Variable == "d4_01_2" | Variable == "d4_03" | Variable =="d4_04_2"
keep  Variable_label Mean SD stars_Ftest

outsheet using "$output/Tables/04table`i'.txt", replace
local i = `i' + 1

restore, preserve

******************************** Section 5 **************************************************************
local i =1
*Steering Committee
keep if Variable == "d5_01_2" | Variable == "d5_03_2" | Variable =="d5_04_2" | Variable =="d5_05a_2" | Variable =="d5_05b_2" | Variable =="d5_05c_2"| Variable =="d5_05d_2" | Variable =="d5_05e_2" | Variable == "d5_05fth"
keep  Variable_label Mean SD stars_Ftest

outsheet using "$output/Tables/05table`i'.txt", replace
local i = `i' + 1

restore, preserve

***************************** Section 6 *******************************************************************
local i =1
*Support from Other CHW's
keep if Variable == "d6_05a_2" | Variable == "d6_05b_2" | Variable =="d6_05c_2" | Variable =="d6_05d_2" | Variable =="d6_05e_2" | Variable =="d6_05f_2"| Variable =="d6_05g_2" | Variable =="d6_05hth_2"
keep  Variable_label Mean SD stars_Ftest

outsheet using "$output/Tables/06table`i'.txt", replace
local i = `i' + 1

restore, preserve



*CHW Kits
keep if Variable == "d6_06_2" | Variable == "d6_07_2" | Variable =="d6_08_2"
keep  Variable_label Mean SD stars_Ftest

outsheet using "$output/Tables/06table`i'.txt", replace
local i = `i' + 1

restore, preserve

*Stock Significant
keep if regexm(Variable, "d6_09")==1 & Pval_Ftest <=.05
keep `keepvars'

outsheet using "$output/Tables/06table`i'.txt", replace

restore, preserve
local i = `i' + 1

*Biggest Difficulties
keep if regexm(Variable, "d6_10")==1
keep `keepvars'

outsheet using "$output/Tables/06table`i'.txt", replace
restore, preserve
***************************** Section 7 *******************************************************************
local i =1
*Health Score
keep if Variable == "d7_healthscore"| Variable =="d7_handwash" | Variable == "d7_safewater" | Variable =="d7_infantdiarrhea" | Variable =="d7_dangersignspreg" | Variable == "d7_dangersignsinfant" | Variable =="d7_solidfoods" | Variable == "d7_vaccineprevent" | Variable =="d7_contraception" | Variable == "d7_tuberculosis" 
keep Variable `keepvars' 

outsheet using "$output/Tables/07table`i'.txt", replace
local i = `i' + 1

restore, preserve

***************************** Section 8 *******************************************************************
local i =1
*CHW Satisfied
keep if Variable == "d8_01" | Variable == "d8_02" | Variable == "d8_03" | Variable == "d8_04"| Variable == "d8_05" | Variable == "d8_06"| Variable == "d8_07" | Variable == "d8_08" | Variable == "d8_09" | Variable == "d8_10" | Variable == "d8_11" | Variable == "d8_12"| Variable == "d8_13" | Variable == "d8_14"| Variable == "d8_15" | Variable == "d8_16"| Variable == "d8_17" 
keep if Mean>2.5
keep `keepvars'

outsheet using "$output/Tables/08table`i'.txt", replace
local i = `i' + 1

restore, preserve

*CHW Unsatisfied
keep if Variable == "d8_01" | Variable == "d8_02" | Variable == "d8_03" | Variable == "d8_04"| Variable == "d8_05" | Variable == "d8_06"| Variable == "d8_07" | Variable == "d8_08" | Variable == "d8_09" | Variable == "d8_10" | Variable == "d8_11" | Variable == "d8_12"| Variable == "d8_13" | Variable == "d8_14"| Variable == "d8_15" | Variable == "d8_16"| Variable == "d8_17" 
keep if Mean<2.5
keep `keepvars'

outsheet using "$output/Tables/08table`i'.txt", replace


restore, preserve


***************************** Section 9 *******************************************************************
local i =1

*CHW Unsatisfied
keep if Variable == "d9_01" | Variable == "d9_02" | Variable == "d9_03" | Variable == "d9_04"| Variable == "d9_05" | Variable == "d9_06"| Variable == "d9_07" | Variable == "d9_08" | Variable == "d9_09" | Variable == "d9_10" 
keep `keepvars'

outsheet using "$output/Tables/09table`i'.txt", replace


restore, preserve

exit