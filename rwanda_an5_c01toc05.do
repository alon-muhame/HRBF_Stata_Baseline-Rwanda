* Elisa Rothenbuhler
* Mar 2011

version 10.0
clear
set more off
set mem 500m
cap log close
#delimit ;

log using $logdir/rwanda_an5_c01toc05.log, replace;

****
* This do-file calculates means, runs F- and T-tests of difference in means for indicators and covariate variables from the child questionnaire.
***;

***********************************************
*** Section 14.1: Health status and Utilization
***********************************************;

use $cleandatadir/rwhrbf_c01_withstudyarms_withvarformeantests.dta, clear;
keep if a1_11a<5;
preserve;

local descvar_all "c14_31a_100 c14_31a_101 c14_12_100 c14_05_1 c14_06a_1 c14_06a_2 c14_06a_3 c14_06a_4 c14_06a_5 c14_06a_6 c14_06a_7 c14_06a_8 c14_06a_9 c14_06a_10 c14_06a_11 c14_06a_12 c14_06a_13 c14_06a_14 c14_06a_15 c14_06a_16 c14_06a_17 c14_06a_18 c14_06a_19 c14_06a_96 c14_06b_1 c14_06b_2 c14_06b_3 c14_06b_4 c14_06b_5 c14_06b_6 c14_06b_7 c14_06b_8 c14_06b_9 c14_06b_10 c14_06b_11 c14_06b_12 c14_06b_13 c14_06b_14 c14_06b_15 c14_06b_16 c14_06b_17 c14_06b_18 c14_06b_19 c14_06b_96 c14_06c_1 c14_06c_2 c14_06c_3 c14_06c_4 c14_06c_5 c14_06c_6 c14_06c_7 c14_06c_8 c14_06c_9 c14_06c_10 c14_06c_11 c14_06c_12 c14_06c_13 c14_06c_14 c14_06c_15 c14_06c_16 c14_06c_17 c14_06c_18 c14_06c_19 c14_06c_96 c14_08a_2 c14_09_1 c14_10_4 c14_11_4 c14_12_1 c14_12a_1 c14_12a_2 c14_12a_3 c14_12a_4 c14_12a_5 c14_12a_6 c14_12a_7 c14_12a_8 c14_12a_9 c14_12a_10 c14_12a_11 c14_12a_12 c14_12a_96 c14_25_1 c14_25_2 c14_31_1 c14_31_2 c14_31_3 c14_35 c14_39 c14_40_1 c14_40_2 c14_40_3";
local descvar_head "NONE";
local descvar_spouse "NONE";
local descvar_youngest "NONE";
local descvar_mother "NONE";
local used_dataset_nr c01;

calculate_means "`descvar_all'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'";
run_f_tests "`descvar_all'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'";

local descvar_all "c14_31a_100 c14_12_100 c14_05_1 c14_06a_1 c14_06a_2 c14_06a_3 c14_06a_4 c14_06a_5 c14_06a_6 c14_06a_7 c14_06a_8 c14_06a_9 c14_06a_10 c14_06a_11 c14_06a_12 c14_06a_13 c14_06a_14 c14_06a_15 c14_06a_18 c14_06a_19 c14_06b_1 c14_06b_2 c14_06b_3 c14_06b_4 c14_06b_6 c14_06b_7 c14_06b_11 c14_06b_12 c14_06b_14 c14_06b_15 c14_06b_16 c14_06b_17 c14_06b_19 c14_08a_2 c14_09_1 c14_10_4 c14_11_4 c14_12_1 c14_12a_1 c14_12a_2 c14_12a_3 c14_12a_5 c14_12a_7 c14_12a_8 c14_12a_9 c14_12a_10 c14_12a_11 c14_12a_12 c14_12a_96 c14_25_1 c14_25_2 c14_31_1 c14_31_2 c14_31_3 c14_35 c14_39 c14_40_1 c14_40_2 c14_40_3";

run_t_tests "`descvar_all'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'" "`used_dataset_nr'";

restore;

***************************
*** Section 15: Vaccination
***************************;

use $cleandatadir/rwhrbf_c02_withstudyarms_withvarformeantests.dta, clear;
keep if a1_11a<5;
preserve;

local descvar_all "c15_05h_100 c15_05h_101 c15_05i_100 c15_05i_101 c15_05i_102 c15_05i_103 c15_05j_100 c15_05j_101 c15_04_1 c15_04_2";
local descvar_head "NONE";
local descvar_spouse "NONE";
local descvar_youngest "NONE";
local descvar_mother "NONE";
local used_dataset_nr c02;

calculate_means "`descvar_all'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'";
run_f_tests "`descvar_all'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'";
run_t_tests "`descvar_all'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'" "`used_dataset_nr'";

restore;

****************************
*** Section 15: Immunization
****************************;

use $cleandatadir/rwhrbf_c03_withstudyarms_withvarformeantests.dta, clear;
keep if a1_11a<5;
preserve;

local descvar_all "c15_06_1 c15_07_1 c15_08_1 c15_09_1 c15_10_1 c15_11_1 c15_12 c15_12_1 c15_13_1 c15_14 c15_14_1 c15_15_1 c15_16_1 c15_16_2  c15_17_1 c15_17_2 c15_17_3 c15_17_96 c15_19_1 c15_20_1 c15_20_2 c15_20_3 c15_20_4 c15_20_5 c15_20_6 c15_20_7 c15_20_8 c15_20_9 c15_20_10 c15_20_11 c15_20_96 c15_21_1 c15_22_1 c15_23_1";
local descvar_head "NONE";
local descvar_spouse "NONE";
local descvar_youngest "NONE";
local descvar_mother "NONE";
local used_dataset_nr c03;

calculate_means "`descvar_all'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'";
run_f_tests "`descvar_all'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'";

local descvar_all "c15_06_1 c15_07_1 c15_08_1 c15_09_1 c15_10_1 c15_11_1 c15_12 c15_12_1 c15_13_1 c15_14 c15_14_1 c15_15_1 c15_16_1 c15_16_2  c15_17_1 c15_17_2 c15_17_3 c15_17_96 c15_19_1 c15_20_1 c15_20_2 c15_20_3 c15_20_5 c15_20_6 c15_20_7 c15_20_8 c15_20_9 c15_20_10 c15_20_11 c15_20_96 c15_21_1 c15_22_1 c15_23_1";

run_t_tests "`descvar_all'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'" "`used_dataset_nr'";

restore;

***********************************
*** Section 16.1: Height and Weight
***********************************;

use $cleandatadir/rwhrbf_c04_withstudyarms_withvarformeantests.dta, clear;
keep if a1_11a<5;
preserve;

local descvar_all "c16_13_100 c16_13_101 c16_13_102 c16_13_103 c16_13_104 c16_13_105 c16_11_100 c16_11_101 c16_11_102 c16_11_103 c16_02_1 c16_04_1 c16_04_2 c16_04_3 c16_04_4 c16_04_5 c16_05_1 c16_05_2 c16_05_3 c16_05_6 c16_05_8 c16_05_10 c16_05_11 c16_05_96 c16_06_1 c16_06_2 c16_06_3 c16_07_1 c16_07_2 c16_07_3 c16_07_11 c16_07_13 c16_08a_1 c16_08b_1 c16_08c_1 c16_08d_1 c16_08e_1 c16_08f_1 c16_09_1 c16_09_2 c16_09_5 c16_09_6 c16_11 c16_12_1 c16_12_2 c16_13 c16_14_1 c16_14_2 c16_14_3 _fwei _flen _fwfl _fbmi _zwei_clean _zlen_clean _zwfl_clean _zbmi_clean";
local descvar_head "NONE";
local descvar_spouse "NONE";
local descvar_youngest "NONE";
local descvar_mother "NONE";
local used_dataset_nr c04;

calculate_means "`descvar_all'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'";
run_f_tests "`descvar_all'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'";

local descvar_all "c16_13_100 c16_13_101 c16_13_102 c16_13_103 c16_13_104 c16_13_105 c16_11_102 c16_11_103 c16_02_1 c16_04_1 c16_04_2 c16_04_3 c16_04_4 c16_05_1 c16_05_3 c16_05_6 c16_05_8 c16_05_10 c16_05_11 c16_05_96 c16_06_1 c16_06_2 c16_06_3 c16_07_1 c16_07_2 c16_07_3 c16_07_11 c16_07_13 c16_08a_1 c16_08b_1 c16_08c_1 c16_08d_1 c16_09_1 c16_09_2 c16_09_5 c16_11 c16_12_1 c16_12_2 c16_13 c16_14_1 c16_14_2 _fwei _flen _fwfl _fbmi _zwei_clean _zlen_clean _zwfl_clean _zbmi_clean";

run_t_tests "`descvar_all'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'" "`used_dataset_nr'";

restore;

******************************
*** Section 16.2: Anemia Tests
******************************;

use $cleandatadir/rwhrbf_c05_withstudyarms_withvarformeantests.dta, clear;
keep if a1_11a<5;
preserve;

local descvar_all " c16_16_1 c16_18 c16_19_1 c16_20_1";
local descvar_head "NONE";
local descvar_spouse "NONE";
local descvar_youngest "NONE";
local descvar_mother "NONE";
local used_dataset_nr c05;

calculate_means "`descvar_all'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'";
run_f_tests "`descvar_all'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'";
run_t_tests "`descvar_all'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'" "`used_dataset_nr'";

restore;

log close;

