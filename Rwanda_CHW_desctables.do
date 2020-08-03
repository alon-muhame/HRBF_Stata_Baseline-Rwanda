*Matt Mulligan Nov 2011
*This do file

version 10.0
clear
cap log close

ssc install descsave



********************************************************************
local descvar_01 "d1_00 d1_00_2 d1_01_2 d1_02 d1_03_2 d1_04 d1_05_2 d1_06_2 d1_07a_2 d1_07b_2 d1_07c_2 d1_07d_2 d1_07e_2 d1_08 d1_09_3_2 d1_09_5_2 d1_09_6_2 d1_09_7_2 d1_10 d1_11_2 d1_12_2 d1_13y time_chw d1_14days d1_14hrs hours_week d1_15km total_minutes_HC d1_17_2 d1_18_2 d1_23_2  d1_24 d1_25_2 d1_26_2 d1_27_2"
local descvar_02 "d2_01a_2- d2_06w_2"
local descvar_03 "d3_01_2 d3_02 d3_03a- d3_03fth d3_04_2 d3_06a- d3_06fth d3_07_2 d3_08a- d3_09c d3_10_2 d3_12_2 d3_13_2 d3_13_3 d3_14_2 d3_15_2"
local descvar_04 "d4_01_2 d4_02a_2 d4_02b_2 d4_02c_2 d4_02d_2 d4_02e_2 d4_02fth_2 d4_03 d4_04_2 d4_05a_2 d4_05b_2 d4_05c_2 d4_05d_2 d4_05e_2 d4_05f_2 d4_05g_2 d4_05h_2 d4_05i_2"
local descvar_05 "d5_01_2 d5_02a_2- d5_02ith_2 d5_03_2 d5_04_2 d5_05a_2- d5_05fth_2"
local descvar_06 "d6_01a_2-d6_05e_2 d6_06_2 d6_07_2 d6_08_2 d6_09a_2- d6_09rth_23 d6_10a_2- d6_10qth_2"
local descvar_07 "d7_01a- d7_healthscore"
local descvar_08 "d8_01-d8_17 "
local descvar_09 "d9_01- d9_10"
*********************************************************

local i=1
foreach x in 01 02 03 04 05 06 07 08 09 {
	use "$clean\rwHRBF_D CHWs -`x'.dta", clear
	descsave `descvar_`x'', saving("$tempres\desc`x'_labels", replace) rename(name Variable) idnum(`i') keep(Variable varlab order idnum)
	local i = `i' + 1 
}

exit