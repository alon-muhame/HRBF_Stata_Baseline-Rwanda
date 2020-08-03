* Elisa Rothenbuhler
* Feb 2011

version 10.0
clear
set more off
set mem 500m
cap log close
#delimit ;

log using $logdir/rwanda_an3_a02toa08.log, replace;

****
* This do-file calculates means, runs F- and T-tests of difference in means for indicators and covariate variables from the main household questionnaire. 
* The do-file uses the programs defined in rwanda_an1000_programs, i.e. calculate_means, run_f_test and run_t_test. Those programs require the user-defined svyiesummarystats ado-file to be installed in Stata.
* Prior to running those programs, macros should be defined in order to match the local macros `1', `2', `3', etc. defined in rwanda_an1000_programs. These macros are different for each section of the questionnaire. They may be changed between the calculate_means, run_f_test and run_t_test if certain variables have no observations for certain groups (e.g. if trying to run a T-test between T2 and T3 for mothers of youngest child on a variable that is missing in T2 and T3 for mother of youngest child).
***;


************************
*** Section 2: Education
************************;

use $cleandatadir/rwhrbf_a02_withstudyarms_withvarformeantests.dta, clear;
keep if a1_11a>=5;
preserve;

local descvar_all "a2_03_1 a2_08_1 a2_09_1 a2_09_2 a2_09_3 a2_09_4 a2_09_5 a2_05h_1 a2_06 a2_07_01 a2_07_02 a2_07_03 a2_07_04 a2_07_05 a2_07_06 a2_07_07 a2_07_08 a2_07_09 a2_07_10 a2_07_11 a2_07_12 a2_07_13 a2_07_14 a2_07_96 a2_10a a2_10b a2_10c a2_10d a2_10e a2_10f a2_10g";
local descvar_head "a2_03_1 a2_08_1 a2_09_1 a2_09_2 a2_09_3 a2_09_4 a2_09_5 a2_10a a2_10b a2_10c a2_10d a2_10e a2_10f a2_10g";
local descvar_spouse "a2_03_1 a2_08_1 a2_09_1 a2_09_2 a2_09_3 a2_09_4 a2_09_5 a2_10a a2_10b a2_10c a2_10d a2_10e a2_10f a2_10g";
local descvar_youngest "NONE";
local descvar_mother "a2_03_1 a2_08_1 a2_09_1 a2_09_2 a2_09_3 a2_09_4 a2_09_5 a2_10a a2_10b a2_10c a2_10d a2_10e a2_10f a2_10g";
local used_dataset_nr a02;

calculate_means "`descvar_all'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'";
run_f_tests "`descvar_all'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'";

local descvar_all "a2_03_1 a2_08_1 a2_09_1 a2_09_2 a2_09_3 a2_09_4 a2_09_5 a2_05h_1 a2_06 a2_10a a2_10b a2_10c a2_10d a2_10e a2_10f a2_10g";

run_t_tests "`descvar_all'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'" "`used_dataset_nr'";

restore;

********************
*** Section 3: Labor
********************;

use $cleandatadir/rwhrbf_a03_withstudyarms_withvarformeantests.dta, clear;
keep if a1_11a>=12;
preserve;

local descvar_all "a3_01_106 a3_01_107 a3_01_101 a3_01_102 a3_01_103 a3_01_104 a3_01_105 a3_02_1 a3_03_1 a3_03_2 a3_03_3 a3_03_4 a3_03_5 a3_03_6 a3_03_7 a3_03_96 a3_04_1 a3_05a_1 a3_05b_1 a3_07_2 a3_08_101 a3_10_1 a3_11_1 a3_12a_1 a3_12b_1 a3_14_2 a3_15_101 a3_17_1 a3_18_1";
local descvar_head "a3_01_106 a3_01_107 a3_01_101 a3_01_102 a3_01_103 a3_01_104 a3_01_105 a3_02_1 a3_03_1 a3_03_2 a3_03_3 a3_03_4 a3_03_5 a3_03_6 a3_03_7 a3_03_96 a3_04_1 a3_05a_1 a3_05b_1 a3_07_2 a3_08_101 a3_10_1 a3_11_1 a3_12a_1 a3_12b_1 a3_14_2 a3_15_101 a3_17_1 a3_18_1";
local descvar_spouse "a3_01_106 a3_01_107 a3_01_101 a3_01_102 a3_01_103 a3_01_104 a3_01_105 a3_02_1 a3_03_1 a3_03_2 a3_03_3 a3_03_4 a3_03_5 a3_03_6 a3_03_7 a3_03_96 a3_04_1 a3_05a_1 a3_05b_1 a3_07_2 a3_08_101 a3_10_1 a3_11_1 a3_12a_1 a3_12b_1 a3_14_2 a3_15_101 a3_17_1 a3_18_1";
local descvar_youngest "NONE";
local descvar_mother "a3_01_106 a3_01_107 a3_01_101 a3_01_102 a3_01_103 a3_01_104 a3_01_105 a3_02_1 a3_03_1 a3_03_2 a3_03_3 a3_03_4 a3_03_5 a3_03_6 a3_03_7 a3_03_96 a3_04_1 a3_05a_1 a3_05b_1 a3_07_2 a3_08_101 a3_10_1 a3_11_1 a3_12a_1 a3_12b_1 a3_14_2 a3_15_101 a3_17_1 a3_18_1";
local used_dataset_nr a03;

calculate_means "`descvar_all'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'";
run_f_tests "`descvar_all'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'";

local descvar_all "a3_01_106 a3_01_107 a3_01_101 a3_01_102 a3_01_103 a3_01_104 a3_01_105 a3_02_1 a3_03_1 a3_03_2 a3_03_3 a3_03_4 a3_03_5 a3_03_6 a3_03_7 a3_03_96 a3_04_1 a3_05a_1 a3_05b_1 a3_07_2 a3_08_101 a3_10_1 a3_11_1 a3_12a_1 a3_14_2 a3_15_101 a3_17_1 a3_18_1";
local descvar_head "a3_01_106 a3_01_107 a3_01_101 a3_01_102 a3_01_103 a3_01_104 a3_01_105 a3_02_1 a3_03_1 a3_03_2 a3_03_3 a3_03_4 a3_03_5 a3_03_6 a3_03_7 a3_03_96 a3_04_1 a3_05a_1 a3_05b_1 a3_07_2 a3_08_101 a3_10_1 a3_11_1 a3_12a_1 a3_12b_1 a3_14_2 a3_15_101 a3_17_1 a3_18_1";
local descvar_spouse "a3_01_106 a3_01_107 a3_01_101 a3_01_102 a3_01_103 a3_01_104 a3_01_105 a3_02_1 a3_03_1 a3_03_2 a3_03_3 a3_03_4 a3_03_5 a3_03_6 a3_03_7 a3_03_96 a3_04_1 a3_05a_1 a3_05b_1 a3_07_2 a3_08_101 a3_10_1 a3_11_1 a3_12b_1 a3_14_2 a3_15_101 a3_17_1 a3_18_1";
local descvar_mother "a3_01_106 a3_01_107 a3_01_101 a3_01_102 a3_01_103 a3_01_104 a3_01_105 a3_02_1 a3_03_1 a3_03_2 a3_03_3 a3_03_4 a3_03_6 a3_03_7 a3_03_96 a3_04_1 a3_05a_1 a3_05b_1 a3_07_2 a3_08_101 a3_10_1 a3_11_1 a3_12a_1 a3_14_2 a3_15_101 a3_17_1 a3_18_1";

run_t_tests "`descvar_all'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'" "`used_dataset_nr'";

restore;

***********************************************
*** Section 4: Health knowledge - Men and Women
***********************************************;

use $cleandatadir/rwhrbf_a04_b08_withstudyarms_withvarformeantests.dta, clear;
keep if a1_11a>=15 & a1_11a<=49;
preserve;

local descvar_all "a4_healthscore a4_10a_1 a4_10b_1 a4_10c_1 a4_10d_1 a4_11a_1 a4_11b_1 a4_11c_1 a4_11d_1 a4_12a_1 a4_12b_1 a4_12c_1 a4_12d_1 a4_12e_1 a4_13a_1 a4_13b_1 a4_13c_1 a4_13d_1 a4_14a_1 a4_14b_1 a4_14c_1 a4_14d_1 a4_15a_1 a4_15b_1 a4_15c_1 a4_15d_1 a4_15e_1 a4_16a_1 a4_16b_1 a4_16c_1 a4_16d_1 a4_16e_1";
local descvar_head "a4_healthscore a4_10a_1 a4_10b_1 a4_10c_1 a4_10d_1 a4_11a_1 a4_11b_1 a4_11c_1 a4_11d_1 a4_12a_1 a4_12b_1 a4_12c_1 a4_12d_1 a4_12e_1 a4_13a_1 a4_13b_1 a4_13c_1 a4_13d_1 a4_14a_1 a4_14b_1 a4_14c_1 a4_14d_1 a4_15a_1 a4_15b_1 a4_15c_1 a4_15d_1 a4_15e_1 a4_16a_1 a4_16b_1 a4_16c_1 a4_16d_1 a4_16e_1";
local descvar_spouse "a4_healthscore a4_10a_1 a4_10b_1 a4_10c_1 a4_10d_1 a4_11a_1 a4_11b_1 a4_11c_1 a4_11d_1 a4_12a_1 a4_12b_1 a4_12c_1 a4_12d_1 a4_12e_1 a4_13a_1 a4_13b_1 a4_13c_1 a4_13d_1 a4_14a_1 a4_14b_1 a4_14c_1 a4_14d_1 a4_15a_1 a4_15b_1 a4_15c_1 a4_15d_1 a4_15e_1 a4_16a_1 a4_16b_1 a4_16c_1 a4_16d_1 a4_16e_1";
local descvar_youngest "NONE";
local descvar_mother "a4_healthscore a4_10a_1 a4_10b_1 a4_10c_1 a4_10d_1 a4_11a_1 a4_11b_1 a4_11c_1 a4_11d_1 a4_12a_1 a4_12b_1 a4_12c_1 a4_12d_1 a4_12e_1 a4_13a_1 a4_13b_1 a4_13c_1 a4_13d_1 a4_14a_1 a4_14b_1 a4_14c_1 a4_14d_1 a4_15a_1 a4_15b_1 a4_15c_1 a4_15d_1 a4_15e_1 a4_16a_1 a4_16b_1 a4_16c_1 a4_16d_1 a4_16e_1";
local used_dataset_nr a04_b08;

calculate_means "`descvar_all'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'";
run_f_tests "`descvar_all'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'";
run_t_tests "`descvar_all'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'" "`used_dataset_nr'";

restore;

**********************
*** Section 5: Housing
**********************;

use $cleandatadir/rwhrbf_a00_withstudyarms_withvarformeantests.dta, clear;
preserve;

local descvar_hh "a5_03_1 a5_03_2 a5_03_3 a5_03_4 a5_03_5 a5_03_6 a5_03_7 a5_03_8 a5_03_9 a5_03_96 a5_04_1 a5_06_1 a5_08a_100 a5_08b_100 a5_08a_1 a5_08a_2 a5_08a_3 a5_08a_4 a5_08a_5 a5_08a_6 a5_08a_7 a5_08a_8 a5_08a_9 a5_08a_10 a5_08a_11 a5_08a_96 a5_08b_1 a5_08b_2 a5_08b_3 a5_08b_4 a5_08b_5 a5_08b_6 a5_08b_7 a5_08b_8 a5_08b_9 a5_08b_10 a5_08b_11 a5_08b_96 a5_09a a5_09b a5_10a_1 a5_10a_2 a5_10a_3 a5_10a_4 a5_10a_96 a5_10b_1 a5_10b_2 a5_10b_3 a5_10b_4 a5_10b_96 a5_11_100 a5_11_1 a5_11_2 a5_11_3 a5_11_4 a5_11_5 a5_11_6 a5_11_7 a5_11_8 a5_11_9 a5_11_10 a5_11_96 a5_13_1 a5_13_2 a5_13_3 a5_13_4 a5_13_5 a5_13_96 a5_14_1 a5_14_2 a5_14_3 a5_14_4 a5_14_5 a5_14_6 a5_14_7 a5_14_8 a5_14_9 a5_14_10 a5_14_96 a5_15_1 a5_15_2 a5_15_3 a5_15_4 a5_15_5 a5_15_6 a5_15_7 a5_15_8 a5_15_9 a5_15_10 a5_15_96";
local descvar_head "NONE";
local descvar_spouse "NONE";
local descvar_youngest "NONE";
local descvar_mother "NONE";
local used_dataset_nr a00_section5;

calculate_means "`descvar_hh'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'" "`used_dataset_nr'";
run_f_tests "`descvar_hh'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'" "`used_dataset_nr'";

local descvar_hh "a5_03_1 a5_03_2 a5_03_3 a5_03_4 a5_03_5 a5_03_6 a5_03_7 a5_03_9 a5_03_96 a5_04_1 a5_06_1 a5_08a_100 a5_08b_100 a5_08a_1 a5_08a_2 a5_08a_3 a5_08a_4 a5_08a_5 a5_08a_6 a5_08a_7 a5_08a_8 a5_08a_9 a5_08a_10 a5_08a_11 a5_08a_96 a5_08b_1 a5_08b_2 a5_08b_3 a5_08b_4 a5_08b_5 a5_08b_6 a5_08b_7 a5_08b_8 a5_08b_9 a5_08b_10 a5_08b_11 a5_08b_96 a5_09a a5_09b a5_10a_1 a5_10a_2 a5_10a_3 a5_10a_4 a5_10a_96 a5_10b_1 a5_10b_2 a5_10b_3 a5_10b_4 a5_10b_96 a5_11_100 a5_11_1 a5_11_2 a5_11_3 a5_11_4 a5_11_5 a5_11_6 a5_11_7 a5_11_8 a5_11_9 a5_11_10 a5_11_96 a5_13_1 a5_13_2 a5_13_3 a5_13_4 a5_13_5 a5_13_96 a5_14_1 a5_14_2 a5_14_3 a5_14_4 a5_14_5 a5_14_6 a5_14_7 a5_14_8 a5_14_9 a5_14_10 a5_14_96 a5_15_1 a5_15_2 a5_15_4 a5_15_5 a5_15_6 a5_15_7 a5_15_8 a5_15_9 a5_15_10 a5_15_96";

run_t_tests "`descvar_hh'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'" "`used_dataset_nr'";

restore;

*******************************
*** Section 6: Household assets
*******************************;

***
*** Part 1
***;

use $cleandatadir/rwhrbf_a05_with_1obs_for_1hh_withstudyarms_withvarformeantests.dta, clear;
preserve;

local descvar_hh "a6_02_100 a6_01_1 a6_02_1 a6_01_2 a6_02_2 a6_01_3 a6_02_3 a6_01_4 a6_02_4 a6_01_5 a6_02_5 a6_01_6 a6_02_6 a6_01_7 a6_02_7 a6_01_8 a6_02_8 a6_01_9 a6_02_9 a6_01_10 a6_02_10 a6_01_11 a6_02_11 a6_01_12 a6_02_12 a6_01_13 a6_02_13 a6_01_14 a6_02_14 a6_01_15 a6_02_15 a6_01_16 a6_02_16 a6_01_17 a6_02_17 a6_01_18 a6_02_18 a6_01_19 a6_02_19 a6_01_20 a6_02_20";
* Note: a6_02_4 excluded because not enough obs;
local descvar_head "NONE";
local descvar_spouse "NONE";
local descvar_youngest "NONE";
local descvar_mother "NONE";
local used_dataset_nr a05;

calculate_means "`descvar_hh'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'" "`used_dataset_nr'";
run_f_tests "`descvar_hh'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'" "`used_dataset_nr'";

local descvar_hh "a6_02_100 a6_01_1 a6_02_1 a6_01_2 a6_02_2 a6_01_3 a6_02_3 a6_01_4 a6_01_5 a6_02_5 a6_01_6 a6_02_6 a6_01_7 a6_02_7 a6_01_8 a6_02_8 a6_01_9 a6_02_9 a6_01_10 a6_02_10 a6_01_11 a6_02_11 a6_01_12 a6_02_12 a6_01_13 a6_02_13 a6_01_14 a6_02_14 a6_01_15 a6_02_15 a6_01_16 a6_02_16 a6_01_17 a6_02_17 a6_01_18 a6_02_18 a6_01_19 a6_01_20 a6_02_20";
* Note: a6_02_4 and a6_02_19 excluded because not enough obs;

run_t_tests "`descvar_hh'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'" "`used_dataset_nr'";

restore;

***
*** Part 2
***;

use $cleandatadir/rwhrbf_a00_withstudyarms_withvarformeantests.dta, clear;
preserve;

local descvar_hh "a6_05_2 a6_06n_2 a6_07 a6_08n_1 a6_09n_1 a6_10n_1";
local descvar_head "NONE";
local descvar_spouse "NONE";
local descvar_youngest "NONE";
local descvar_mother "NONE";
local used_dataset_nr a00_section6;

calculate_means "`descvar_hh'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'" "`used_dataset_nr'";
run_f_tests "`descvar_hh'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'" "`used_dataset_nr'";
run_t_tests "`descvar_hh'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'" "`used_dataset_nr'";

restore;

***
*** Part 3
***;

use $cleandatadir/rwhrbf_a06_with_1obs_for_1hh_withstudyarms_withvarformeantests.dta, clear;
preserve;

local descvar_hh "a6_12_100 a6_13_100 a6_13_101 a6_13_102 a6_13_103 a6_13_104";
local descvar_head "NONE";
local descvar_spouse "NONE";
local descvar_youngest "NONE";
local descvar_mother "NONE";
local used_dataset_nr a06;

calculate_means "`descvar_hh'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'" "`used_dataset_nr'";
run_f_tests "`descvar_hh'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'" "`used_dataset_nr'";
run_t_tests "`descvar_hh'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'" "`used_dataset_nr'";

restore;

***********************************************************************
*** Section 7: Transfers and other income and subjective life valuation
***********************************************************************;

***
*** Part 1
***;

use $cleandatadir/rwhrbf_a07_with_1obs_for_1hh_withstudyarms_withvarformeantests.dta, clear;
preserve;

local descvar_hh "a7_01_100 a7_01_1 a7_01_2 a7_01_3 a7_01_4 a7_01_5 a7_01_6 a7_01_7 a7_01_8 a7_01_9 a7_01_10 a7_01_11 a7_01_12";
local descvar_head "NONE";
local descvar_spouse "NONE";
local descvar_youngest "NONE";
local descvar_mother "NONE";
local used_dataset_nr a07;

calculate_means "`descvar_hh'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'" "`used_dataset_nr'";
run_f_tests "`descvar_hh'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'" "`used_dataset_nr'";
run_t_tests "`descvar_hh'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'" "`used_dataset_nr'";

restore;

***
*** Part 2
***;

use $cleandatadir/rwhrbf_a00_withstudyarms_withvarformeantests.dta, clear;
preserve;

local descvar_hh "a7_03_1 a7_03_2 a7_04_1_1 a7_04_1_2 a7_04_1_3 a7_04_1_4 a7_04_1_5 a7_04_1_6 a7_04_1_7 a7_04_1_8 a7_04_1_9 a7_04_1_10  a7_04_1_11  a7_04_1_96 a7_04_2_1 a7_04_2_2 a7_04_2_3 a7_04_2_4 a7_04_2_5 a7_04_2_6 a7_04_2_7 a7_04_2_8 a7_04_2_9 a7_04_2_10 a7_04_2_11 a7_04_2_96 ";
local descvar_head "NONE";
local descvar_spouse "NONE";
local descvar_youngest "NONE";
local descvar_mother "NONE";
local used_dataset_nr a00_section7;

calculate_means "`descvar_hh'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'" "`used_dataset_nr'";
run_f_tests "`descvar_hh'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'" "`used_dataset_nr'";
run_t_tests "`descvar_hh'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'" "`used_dataset_nr'";

restore;

**************************
*** Section 8=9: Mortality
**************************;

***
*** Part 1
***;

use $cleandatadir/rwhrbf_a00_withstudyarms_withvarformeantests.dta, clear;
preserve;

local descvar_hh "a9_01_1";
local descvar_head "NONE";
local descvar_spouse "NONE";
local descvar_youngest "NONE";
local descvar_mother "NONE";
local used_dataset_nr a00_section8;

calculate_means "`descvar_hh'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'" "`used_dataset_nr'";
run_f_tests "`descvar_hh'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'" "`used_dataset_nr'";
run_t_tests "`descvar_hh'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'" "`used_dataset_nr'";

restore;

***
*** Part 2
***;

use $cleandatadir/rwhrbf_a08_with_1obs_for_1hh_withstudyarms_withvarformeantests.dta, clear;
preserve;

local descvar_hh "a9_05_1_1 a9_06n_1_1 a9_06n_1_2 a9_07_1_1 a9_07_1_2 a9_07_1_3 a9_07_1_4 a9_07_1_5 a9_07_1_6 a9_07_1_7 a9_07_1_8 a9_07_1_9 a9_07_1_10 a9_07_1_11 a9_07_1_12 a9_07_1_13 a9_07_1_14 a9_07_1_15 a9_07_1_16 a9_07_1_17 a9_07_1_96 a9_08_1_1 a9_08_1_2 a9_08_1_3 a9_08_1_4 a9_08_1_5 a9_08_1_96";
local descvar_head "NONE";
local descvar_spouse "NONE";
local descvar_youngest "NONE";
local descvar_mother "NONE";
local used_dataset_nr a08;

calculate_means "`descvar_hh'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'" "`used_dataset_nr'";
run_f_tests "`descvar_hh'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'" "`used_dataset_nr'";

local descvar_hh "a9_05_1_1 a9_06n_1_1 a9_06n_1_2 a9_07_1_1 a9_07_1_2 a9_07_1_3 a9_07_1_4 a9_07_1_5 a9_07_1_6 a9_07_1_7 a9_07_1_8 a9_07_1_9 a9_07_1_10 a9_07_1_11 a9_07_1_12 a9_07_1_13 a9_07_1_14 a9_07_1_16 a9_07_1_17 a9_07_1_96 a9_08_1_1 a9_08_1_2 a9_08_1_4 a9_08_1_5 a9_08_1_96";

run_t_tests "`descvar_hh'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'" "`used_dataset_nr'";

restore;

*********************************************************************
*** Add-up on health knowledge with distinction between men and women
*** to be added to sample balance tables separately
*********************************************************************;

******************************************
*** Section 4: Health knowledge - MEN ONLY
******************************************;

cap mkdir $resultdir/health_knowledge_results;
cap mkdir $resultdir/health_knowledge_results/men;
cap mkdir $resultdir/health_knowledge_results/men/temp;

global resultdir $resultdir/health_knowledge_results/men;
global tempresultdir $resultdir/temp;

cap erase $tempresultdir/means_all.txt;
cap erase $tempresultdir/means_head.txt;
cap erase $tempresultdir/means_spouse.txt;
cap erase $tempresultdir/means_youngest.txt;
cap erase $tempresultdir/means_mother.txt;

cap erase $tempresultdir/Fpval_all.txt;
cap erase $tempresultdir/Fpval_head.txt;
cap erase $tempresultdir/Fpval_spouse.txt;
cap erase $tempresultdir/Fpval_youngest.txt;
cap erase $tempresultdir/Fpval_mother.txt;

use $cleandatadir/rwhrbf_a04_b08_withstudyarms_withvarformeantests.dta, clear;
keep if a1_02==1 & a1_11a>=15 & a1_11a<=49;
preserve;

local descvar_all "a4_healthscore a4_10a_1 a4_10b_1 a4_10c_1 a4_10d_1 a4_11a_1 a4_11b_1 a4_11c_1 a4_11d_1 a4_12a_1 a4_12b_1 a4_12c_1 a4_12d_1 a4_12e_1 a4_13a_1 a4_13b_1 a4_13c_1 a4_13d_1 a4_14a_1 a4_14b_1 a4_14c_1 a4_14d_1 a4_15a_1 a4_15b_1 a4_15c_1 a4_15d_1 a4_15e_1 a4_16a_1 a4_16b_1 a4_16c_1 a4_16d_1 a4_16e_1";
local descvar_head "a4_healthscore a4_10a_1 a4_10b_1 a4_10c_1 a4_10d_1 a4_11a_1 a4_11b_1 a4_11c_1 a4_11d_1 a4_12a_1 a4_12b_1 a4_12c_1 a4_12d_1 a4_12e_1 a4_13a_1 a4_13b_1 a4_13c_1 a4_13d_1 a4_14a_1 a4_14b_1 a4_14c_1 a4_14d_1 a4_15a_1 a4_15b_1 a4_15c_1 a4_15d_1 a4_15e_1 a4_16a_1 a4_16b_1 a4_16c_1 a4_16d_1 a4_16e_1";
local descvar_spouse "NONE";
local descvar_youngest "NONE";
local descvar_mother "NONE";
local used_dataset_nr a04_b08_men;

calculate_means "`descvar_all'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'";
run_f_tests "`descvar_all'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'";

local descvar_all "a4_healthscore a4_10a_1 a4_10b_1 a4_10c_1 a4_10d_1 a4_11a_1 a4_11b_1 a4_11c_1 a4_11d_1 a4_12a_1 a4_12b_1 a4_12c_1 a4_12d_1 a4_12e_1 a4_13a_1 a4_13b_1 a4_13c_1 a4_13d_1 a4_14a_1 a4_14b_1 a4_14c_1 a4_14d_1 a4_15a_1 a4_15c_1 a4_15d_1 a4_15e_1 a4_16a_1 a4_16b_1 a4_16c_1 a4_16d_1 a4_16e_1";

run_t_tests "`descvar_all'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'" "`used_dataset_nr'";

restore;

********************************************
*** Section 4: Health knowledge - WOMEN ONLY
********************************************;

do $dodir/rwanda_directories;
cap mkdir $resultdir/health_knowledge_results/women;
cap mkdir $resultdir/health_knowledge_results/women/temp;

global resultdir $resultdir/health_knowledge_results/women;
global tempresultdir $resultdir/temp;

cap erase $tempresultdir/means_all.txt;
cap erase $tempresultdir/means_head.txt;
cap erase $tempresultdir/means_spouse.txt;
cap erase $tempresultdir/means_youngest.txt;
cap erase $tempresultdir/means_mother.txt;

cap erase $tempresultdir/Fpval_all.txt;
cap erase $tempresultdir/Fpval_head.txt;
cap erase $tempresultdir/Fpval_spouse.txt;
cap erase $tempresultdir/Fpval_youngest.txt;
cap erase $tempresultdir/Fpval_mother.txt;

use $cleandatadir/rwhrbf_a04_b08_withstudyarms_withvarformeantests.dta, clear;
keep if a1_02==2 & a1_11a>=15 & a1_11a<=49;
preserve;

local descvar_all "a4_healthscore a4_10a_1 a4_10b_1 a4_10c_1 a4_10d_1 a4_11a_1 a4_11b_1 a4_11c_1 a4_11d_1 a4_12a_1 a4_12b_1 a4_12c_1 a4_12d_1 a4_12e_1 a4_13a_1 a4_13b_1 a4_13c_1 a4_13d_1 a4_14a_1 a4_14b_1 a4_14c_1 a4_14d_1 a4_15a_1 a4_15b_1 a4_15c_1 a4_15d_1 a4_15e_1 a4_16a_1 a4_16b_1 a4_16c_1 a4_16d_1 a4_16e_1";
local descvar_head "a4_healthscore a4_10a_1 a4_10b_1 a4_10c_1 a4_10d_1 a4_11a_1 a4_11b_1 a4_11c_1 a4_11d_1 a4_12a_1 a4_12b_1 a4_12c_1 a4_12d_1 a4_12e_1 a4_13a_1 a4_13b_1 a4_13c_1 a4_13d_1 a4_14a_1 a4_14b_1 a4_14c_1 a4_14d_1 a4_15a_1 a4_15b_1 a4_15c_1 a4_15d_1 a4_15e_1 a4_16a_1 a4_16b_1 a4_16c_1 a4_16d_1 a4_16e_1";
local descvar_spouse "a4_healthscore a4_10a_1 a4_10b_1 a4_10c_1 a4_10d_1 a4_11a_1 a4_11b_1 a4_11c_1 a4_11d_1 a4_12a_1 a4_12b_1 a4_12c_1 a4_12d_1 a4_12e_1 a4_13a_1 a4_13b_1 a4_13c_1 a4_13d_1 a4_14a_1 a4_14b_1 a4_14c_1 a4_14d_1 a4_15a_1 a4_15b_1 a4_15c_1 a4_15d_1 a4_15e_1 a4_16a_1 a4_16b_1 a4_16c_1 a4_16d_1 a4_16e_1";
local descvar_youngest "NONE";
local descvar_mother "NONE";
local used_dataset_nr a04_b08_women;

calculate_means "`descvar_all'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'";
run_f_tests "`descvar_all'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'";

local descvar_head "a4_healthscore a4_10b_1 a4_10c_1 a4_10d_1 a4_11a_1 a4_11b_1 a4_11c_1 a4_11d_1 a4_12a_1 a4_12b_1 a4_12c_1 a4_12d_1 a4_12e_1 a4_13a_1 a4_13b_1 a4_13c_1 a4_14b_1 a4_14c_1 a4_14d_1 a4_15a_1 a4_15b_1 a4_15c_1 a4_15d_1 a4_15e_1 a4_16a_1 a4_16b_1 a4_16c_1 a4_16d_1 a4_16e_1";

run_t_tests "`descvar_all'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'" "`used_dataset_nr'";

restore;

*****************************************************************************
*** Section 4: Health knowledge - T-Tests of difference between men and women
*****************************************************************************;

do $dodir/rwanda_directories;
cap mkdir $resultdir/health_knowledge_results/men_vs_women;
cap mkdir $resultdir/health_knowledge_results/men_vs_women/temp;

global resultdir $resultdir/health_knowledge_results/men_vs_women;
global tempresultdir $resultdir/temp;

use $cleandatadir/rwhrbf_a04_b08_withstudyarms_withvarformeantests.dta, clear;
keep if a1_11a>=15 & a1_11a<=49;
gen male=a1_02==1;
drop if a1_02==.;
save $tempdatadir/rwhrbf_a04_b08_withstudyarms_withvarformeantests_men_vs_women.dta, replace;
preserve;

svyiesummarystats a4_healthscore a4_10a_1 a4_10b_1 a4_10c_1 a4_10d_1 a4_11a_1 a4_11b_1 a4_11c_1 a4_11d_1 a4_12a_1 a4_12b_1 a4_12c_1 a4_12d_1 a4_12e_1 a4_13a_1 a4_13b_1 a4_13c_1 a4_13d_1 a4_14a_1 a4_14b_1 a4_14c_1 a4_14d_1 a4_15a_1 a4_15b_1 a4_15c_1 a4_15d_1 a4_15e_1 a4_16a_1 a4_16b_1 a4_16c_1 a4_16d_1 a4_16e_1, treatment(male) outputfile($tempresultdir/a04_b08_gendertest_all) pweight(hhpweight) psuclusterunit(hrbf_id1) replace;

restore;

**********************************
*** Come back to usual directories
**********************************;

do $dodir/rwanda_directories;


log close;