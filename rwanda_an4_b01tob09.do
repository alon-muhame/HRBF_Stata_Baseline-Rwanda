* Elisa Rothenbuhler
* Feb 2011

version 10.0
clear
set more off
set mem 500m
cap log close
#delimit ;

log using $logdir/rwanda_an4_b01tob09.log, replace;

****
* This do-file calculates means, runs F- and T-tests of difference in means for indicators and covariate variables from the female questionnaire.
***;


***********************************************
*** Section 10.1: Health status and utilization
***********************************************;

use $cleandatadir/rwhrbf_b01_withstudyarms_withvarformeantests.dta, clear;
keep if a1_11a>=15 & a1_11a<=49 & a1_02==2;
preserve;

local descvar_all "b10_00_1 b10_01_1 b10_01_2 b10_01_3 b10_01_4 b10_02_1 b10_02_2 b10_02_3 b10_03_1 b10_03_2 b10_03_3 b10_03_4 b10_04_1 b10_05b_100 b10_05c_100 b10_05a_1 b10_05a_2 b10_05a_3 b10_05a_4 b10_05a_7 b10_05a_8 b10_05a_9 b10_05a_10 b10_05a_11 b10_05a_12 b10_05a_13 b10_05a_14 b10_05a_15 b10_05a_16 b10_05a_17 b10_05a_18 b10_05a_19 b10_05a_96 b10_05b_1 b10_05b_2 b10_05b_3 b10_05b_4 b10_05b_7 b10_05b_11 b10_05b_12 b10_05b_96 b10_05c_1 b10_05c_2 b10_05c_3 b10_05c_12 b10_05c_96 b10_07a_2 b10_07a_4 b10_08_1";
local descvar_head "NONE";
local descvar_spouse "NONE";
local descvar_youngest "NONE";
local descvar_mother "b10_00_1 b10_01_1 b10_01_2 b10_01_3 b10_01_4 b10_02_1 b10_02_2 b10_02_3 b10_03_1 b10_03_2 b10_03_3 b10_03_4 b10_04_1 b10_05b_100 b10_05c_100 b10_05a_1 b10_05a_2 b10_05a_3 b10_05a_4 b10_05a_7 b10_05a_8 b10_05a_9 b10_05a_10 b10_05a_11 b10_05a_12 b10_05a_13 b10_05a_14 b10_05a_15 b10_05a_16 b10_05a_17 b10_05a_18 b10_05a_19 b10_05a_96 b10_07a_2 b10_07a_4 b10_08_1";
local used_dataset_nr b01;

calculate_means "`descvar_all'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'";
run_f_tests "`descvar_all'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'";

local descvar_all "b10_00_1 b10_01_1 b10_01_2 b10_01_3 b10_01_4 b10_02_1 b10_02_2 b10_02_3 b10_03_1 b10_03_2 b10_03_3 b10_03_4 b10_04_1 b10_05b_100 b10_05c_100 b10_05a_1 b10_05a_2 b10_05a_3 b10_05a_4 b10_05a_7 b10_05a_9 b10_05a_10 b10_05a_11 b10_05a_12 b10_05a_13 b10_05a_14 b10_05a_15 b10_05a_16 b10_05a_17 b10_05a_18 b10_05a_19 b10_05a_96 b10_05b_1 b10_05b_2 b10_05b_3 b10_05b_4 b10_05b_11 b10_05b_96 b10_05c_1 b10_05c_3 b10_05c_12 b10_07a_2 b10_07a_4 b10_08_1";
local descvar_mother "b10_00_1 b10_01_1 b10_01_2 b10_01_3 b10_01_4 b10_02_1 b10_02_2 b10_02_3 b10_03_1 b10_03_2 b10_03_3 b10_03_4 b10_04_1 b10_05b_100 b10_05c_100 b10_05a_1 b10_05a_2 b10_05a_3 b10_05a_4 b10_05a_7 b10_05a_8 b10_05a_9 b10_05a_10 b10_05a_11 b10_05a_12 b10_05a_13 b10_05a_14 b10_05a_15 b10_05a_16 b10_05a_17 b10_05a_18 b10_05a_96 b10_07a_2 b10_07a_4 b10_08_1";

run_t_tests "`descvar_all'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'" "`used_dataset_nr'";

restore;

*****************************
*** Section 11: Mental health
*****************************;

use $cleandatadir/rwhrbf_b02_withstudyarms_withvarformeantests.dta, clear;
keep if a1_11a>=15 & a1_11a<=49 & a1_02==2;
preserve;

local descvar_all "b11_01a_1 b11_01a_2 b11_01a_3 b11_01b_1 b11_01b_2 b11_01b_3 b11_01c_1 b11_01c_2 b11_01c_3 b11_01d_1 b11_01d_2 b11_01d_3 b11_02_1 b11_03_1 b11_03_4 b11_03_7 b11_03_10 b11_03_11 b11_04_1";
local descvar_head "NONE";
local descvar_spouse "NONE";
local descvar_youngest "NONE";
local descvar_mother "b11_01a_1 b11_01a_2 b11_01a_3 b11_01b_1 b11_01b_2 b11_01b_3 b11_01c_1 b11_01c_2 b11_01c_3 b11_01d_1 b11_01d_2 b11_01d_3 b11_02_1 b11_03_1 b11_03_4 b11_03_7 b11_03_10 b11_03_11 b11_04_1";
local used_dataset_nr b02;

calculate_means "`descvar_all'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'";
run_f_tests "`descvar_all'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'";
run_t_tests "`descvar_all'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'" "`used_dataset_nr'";

restore;

***********************************
*** Section 12: Reproductive health
***********************************;

use $cleandatadir/rwhrbf_b03_withstudyarms_withvarformeantests.dta, clear;
keep if a1_11a>=15 & a1_11a<=49 & a1_02==2;
preserve;

local descvar_all "b12_12_1 b12_12_100 b12_12_101 b12_12_102 b12_12_103 b12_12_104 b12_12_105 b12_12_106 b12_12_107 b12_12_108 b12_12_109 b12_01a b12_01b b12_01_1 b12_02_1 b12_02_2 b12_02_3 b12_02_4 b12_02_5 b12_02_96 b12_03_1 b12_03_2 b12_03_3 b12_03_4 b12_04_1 b12_05_1 b12_06_1 b12_07_1 b12_08_1 b12_09_1 b12_10_1 b12_11_1 b12_11_2 b12_11_3 b12_11_99 b12_12_3 b12_13a_1 b12_13b_1 b12_13c_1 b12_13d_1 b12_13e_1 b12_13f_1 b12_13g_1 b12_13h_1 b12_13i_1 b12_13j_1 b12_13k_1 b12_13l_1 b12_13a_2 b12_14_1 b12_14_2 b12_14_3 b12_14_4 b12_14_5 b12_14_6 b12_14_7 b12_14_8 b12_14_9 b12_14_10 b12_14_96 b12_14a_1 b12_15_1 b12_15_2 b12_15_3 b12_15_4 b12_15_5 b12_15_6 b12_15_7 b12_15_8 b12_15_9 b12_15_10 b12_15_96 b12_16y_1 b12_18a_1 b12_18b_1 b12_18c_1 b12_18d_1 b12_18e_1";
local descvar_head "NONE";
local descvar_spouse "NONE";
local descvar_youngest "NONE";
local descvar_mother "b12_12_1 b12_12_100 b12_12_101 b12_12_102 b12_12_103 b12_12_104 b12_12_105 b12_12_106 b12_12_107 b12_12_108 b12_12_109 b12_01a b12_01b b12_01_1 b12_02_1 b12_02_2 b12_02_3 b12_02_4 b12_02_5 b12_02_96 b12_03_1 b12_03_2 b12_03_3 b12_03_4 b12_04_1 b12_05_1 b12_06_1 b12_07_1 b12_08_1 b12_09_1 b12_10_1 b12_11_1 b12_11_2 b12_11_3 b12_11_99 b12_12_3 b12_13a_1 b12_13b_1 b12_13c_1 b12_13d_1 b12_13e_1 b12_13f_1 b12_13g_1 b12_13h_1 b12_13i_1 b12_13j_1 b12_13k_1 b12_13l_1 b12_13a_2 b12_14_1 b12_14_2 b12_14_3 b12_14_4 b12_14_5 b12_14_6 b12_14_7 b12_14_8 b12_14_9 b12_14_10 b12_14_96 b12_14a_1 b12_15_1 b12_15_2 b12_15_3 b12_15_4 b12_15_5 b12_15_6 b12_15_7 b12_15_8 b12_15_9 b12_15_10 b12_15_96 b12_16y_1 b12_18a_1 b12_18b_1 b12_18c_1 b12_18d_1 b12_18e_1";
local used_dataset_nr b03;

calculate_means "`descvar_all'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'";
run_f_tests "`descvar_all'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'";

local descvar_all "b12_12_1 b12_12_100 b12_12_101 b12_12_102 b12_12_103 b12_12_104 b12_12_105 b12_12_106 b12_12_107 b12_12_108 b12_12_109 b12_01a b12_01b b12_01_1 b12_02_1 b12_02_2 b12_02_3 b12_02_4 b12_02_5 b12_02_96 b12_03_1 b12_03_2 b12_03_3 b12_03_4 b12_04_1 b12_05_1 b12_06_1 b12_07_1 b12_08_1 b12_09_1 b12_10_1 b12_11_1 b12_11_2 b12_11_3 b12_11_99 b12_12_3 b12_13a_1 b12_13b_1 b12_13c_1 b12_13d_1 b12_13e_1 b12_13f_1 b12_13g_1 b12_13h_1 b12_13i_1 b12_13j_1 b12_13k_1 b12_13l_1 b12_13a_2 b12_14_1 b12_14_2 b12_14_3 b12_14_4 b12_14_6 b12_14_7 b12_14_8 b12_14_9 b12_14_10 b12_14_96 b12_14a_1 b12_15_1 b12_15_2 b12_15_3 b12_15_4 b12_15_5 b12_15_6 b12_15_7 b12_15_8 b12_15_9 b12_15_10 b12_15_96 b12_16y_1 b12_18a_1 b12_18b_1 b12_18c_1 b12_18d_1 b12_18e_1";
local descvar_mother "b12_12_1 b12_12_100 b12_12_101 b12_12_102 b12_12_103 b12_12_104 b12_12_105 b12_12_106 b12_12_107 b12_12_108 b12_12_109 b12_01a b12_01b b12_01_1 b12_02_1 b12_02_2 b12_02_3 b12_02_4 b12_02_5 b12_02_96 b12_03_1 b12_03_2 b12_03_3 b12_03_4 b12_04_1 b12_05_1 b12_06_1 b12_07_1 b12_08_1 b12_09_1 b12_10_1 b12_11_1 b12_11_2 b12_11_3 b12_11_99 b12_12_3 b12_13a_1 b12_13b_1 b12_13c_1 b12_13d_1 b12_13e_1 b12_13f_1 b12_13g_1 b12_13h_1 b12_13i_1 b12_13j_1 b12_13k_1 b12_13a_2 b12_14_1 b12_14_2 b12_14_3 b12_14_4 b12_14_5 b12_14_6 b12_14_7 b12_14_8 b12_14_10 b12_14_96 b12_14a_1 b12_15_1 b12_15_2 b12_15_3 b12_15_4 b12_15_6 b12_15_7 b12_15_8 b12_15_10 b12_15_96 b12_16y_1 b12_18a_1 b12_18b_1 b12_18c_1 b12_18d_1 b12_18e_1";

run_t_tests "`descvar_all'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'" "`used_dataset_nr'";

restore;

***********************************
*** Section 13.1: Pregnancy history
***********************************;

use $cleandatadir/rwhrbf_b04_withstudyarms_withvarformeantests.dta, clear;
keep if a1_11a>=15 & a1_11a<=49 & a1_02==2;
preserve;

local descvar_all "b13_001_1 b13_003_100 b13_003_1 b13_003_2 b13_003_3 b13_006_2 b13_004_1 b13_006_1 b13_007_1 b13_007a_1 b13_007b_1 b13_008_1 b13_009a b13_009b b13_012_1 b13_013 b13_013_1 b13_014 b13_014_1";
local descvar_head "NONE";
local descvar_spouse "NONE";
local descvar_youngest "NONE";
local descvar_mother "b13_001_1 b13_003_100 b13_003_1 b13_003_2 b13_003_3 b13_006_2 b13_004_1 b13_006_1 b13_007_1 b13_007a_1 b13_007b_1 b13_008_1 b13_009a b13_009b b13_012_1 b13_013 b13_013_1 b13_014 b13_014_1";
local used_dataset_nr b04;

calculate_means "`descvar_all'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'";
run_f_tests "`descvar_all'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'";

local descvar_all "b13_001_1 b13_006_2 b13_004_1 b13_006_1 b13_007_1 b13_007a_1 b13_007b_1 b13_008_1 b13_009a b13_009b b13_012_1 b13_013 b13_013_1 b13_014 b13_014_1";
local descvar_mother "b13_001_1 b13_006_2 b13_004_1 b13_006_1 b13_007_1 b13_007a_1 b13_007b_1 b13_008_1 b13_009a b13_009b b13_012_1 b13_013 b13_013_1 b13_014 b13_014_1";

run_t_tests "`descvar_all'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'" "`used_dataset_nr'";

restore;

*******************************
*** Section 13.2: Birth history
*******************************;

use $cleandatadir/rwhrbf_b05_withstudyarms_withvarformeantests.dta, clear;
keep if a1_11a>=15 & a1_11a<=49 & a1_02==2;
preserve;

local descvar_all "b13_022n_1 b13_023_1 b13_024_1 b13_026_2 b13_028_2 b13_030a_1 b13_030a_2";
local descvar_head "NONE";
local descvar_spouse "NONE";
local descvar_youngest "NONE";
local descvar_mother "b13_022n_1 b13_023_1 b13_024_1 b13_026_2 b13_028_2 b13_030a_1 b13_030a_2";
local used_dataset_nr b05;

calculate_means "`descvar_all'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'";

local descvar_all "b13_022n_1 b13_023_1 b13_024_1 b13_026_2 b13_028_2 b13_030a_1 b13_030a_2";
local descvar_mother "b13_022n_1 b13_023_1 b13_024_1 b13_026_2 b13_028_2 b13_030a_1 b13_030a_2";

run_f_tests "`descvar_all'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'";
run_t_tests "`descvar_all'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'" "`used_dataset_nr'";

restore;

**********************************************
*** Section 13.3: Antenatal and Postnatal care
**********************************************;

use $cleandatadir/rwhrbf_b06_withstudyarms_withvarformeantests.dta, clear;
keep if a1_11a>=15 & a1_11a<=49 & a1_02==2;
preserve;

local descvar_all "b13_035_2 b13_035_3 b13_035_4 b13_035_5 b13_035_6 b13_037_100 b13_037_101 b13_037_102 b13_037_103 b13_037_104 b13_046_2 b13_046_3 b13_046_4 b13_046_5 b13_046_6 b13_039_1 b13_039_2 b13_039_3 b13_039_4 b13_039_5 b13_041_100 b13_041_101 b13_041_102 b13_041_103 b13_041_104 b13_049_1 b13_049_2 b13_049_4 b13_049_5 b13_051_1 b13_051_2 b13_053_2 b13_053_3 b13_058_100 b13_058_101 b13_059_100 b13_059_101 b13_062_1 b13_062_2 b13_067a_1 b13_067b_1 b13_069a_100 b13_069b_100 b13_071a_100 b13_071a_101 b13_080_100 b13_080_101 b13_080_102 b13_083_100 b13_092_100 
b13_035_1 b13_036_1 b13_036_2 b13_036_3 b13_036_96 b13_036_100 b13_037_1 b13_037_2 b13_037_3 b13_037_4 b13_037_5 b13_037_10 b13_037_11 b13_037_12 b13_037_96 b13_039 b13_040a_1 b13_040b b13_041 b13_041_1 b13_041_2 b13_042 b13_042_1 b13_042_2 b13_044_1 b13_044a_1 b13_044b_1 b13_044c_1 b13_044d_1 b13_044e_1 b13_044f_1 b13_045_1 b13_045a_1 b13_047_1 b13_047_2 b13_047_3 b13_047_4 b13_047_5 b13_047_7 b13_047_11 b13_047_96 b13_048_1 b13_053_1 b13_054a_1 b13_054b_1 b13_054c_1 b13_054d_1 b13_054e_1 b13_055a_1 b13_055a_2 b13_055a_3 b13_055a_96 b13_055b_1 b13_055b_2 b13_055b_96 b13_055c_1 b13_055c_2 b13_055c_96 b13_055d_1 b13_055d_2 b13_055d_96 b13_055e_1 b13_055e_2 b13_055e_96 b13_057_1 b13_057_2 b13_057_3 b13_057_4 b13_057_5 b13_058_1 b13_058_2 b13_058_3 b13_058_5 b13_058_6 b13_058_8 b13_058_9 b13_058_10 b13_058_11 b13_058_96 b13_059_1 b13_059_2 b13_059_3 b13_059_4 b13_059_5 b13_059_9 b13_059_11 b13_059_12 b13_059_96 b13_061all_1 b13_061all_2 b13_061all_3 b13_061all_5 b13_061all_96 b13_061a_1 b13_061b b13_064a_1 b13_064b_1 b13_065a_1 b13_065b_1 b13_066a_2 b13_066b_2 b13_067a b13_067b b13_068a_1 b13_068a_2 b13_068a_3 b13_068a_4 b13_068a_5 b13_068b_1 b13_068b_2 b13_068b_3 b13_068b_4 b13_068b_5 b13_069a_1 b13_069b_1 b13_070a_1 b13_070a_2 b13_070a_3 b13_070b_1 b13_070b_2 b13_070b_3 b13_071a b13_071b b13_072a_1 b13_072b_1 b13_073a_1 b13_073b_1 b13_074a_1 b13_074b_1 b13_075an_1 b13_076a_1 b13_076b_1 b13_078a b13_078b b13_080_1 b13_081a_1 b13_082_1 b13_082_2 b13_082_3 b13_082_6 b13_082_8 b13_082_96 b13_082_100 b13_083_1 b13_083_2 b13_083_3 b13_083_4 b13_083_5 b13_083_9 b13_083_12 b13_083_96 b13_083a_1 b13_083b b13_084 b13_087_1 b13_087_2 b13_087_3 b13_087_4 b13_087_5 b13_087_8 b13_087_9 b13_087_10 b13_087_11 b13_087_96 b13_088_1 b13_089n_1 b13_090_1 b13_090_2 b13_090_3 b13_090_5 b13_090_7 b13_090_10 b13_092_1 b13_093n_1 b13_094_1 b13_094_2 b13_094_3 b13_094_6 b13_094_7 b13_094_8";
local descvar_head "NONE";
local descvar_spouse "NONE";
local descvar_youngest "NONE";
local descvar_mother "b13_035_2 b13_035_3 b13_035_4 b13_035_5 b13_035_6 b13_037_100 b13_037_101 b13_037_102 b13_037_103 b13_037_104 b13_046_2 b13_046_3 b13_046_4 b13_046_5 b13_046_6 b13_039_1 b13_039_2 b13_039_3 b13_039_4 b13_039_5 b13_041_100 b13_041_101 b13_041_102 b13_041_103 b13_041_104 b13_049_1 b13_049_2 b13_049_4 b13_049_5 b13_051_1 b13_051_2 b13_053_2 b13_053_3 b13_058_100 b13_058_101 b13_059_100 b13_059_101 b13_062_1 b13_062_2 b13_067a_1 b13_067b_1 b13_069a_100 b13_069b_100 b13_071a_100 b13_071a_101 b13_080_100 b13_080_101 b13_080_102 b13_083_100 b13_092_100 
b13_035_1 b13_036_1 b13_036_2 b13_036_3 b13_036_96 b13_036_100 b13_037_1 b13_037_2 b13_037_3 b13_037_4 b13_037_5 b13_037_10 b13_037_11 b13_037_12 b13_037_96 b13_039 b13_040a_1 b13_040b b13_041 b13_041_1 b13_041_2 b13_042 b13_042_1 b13_042_2 b13_044_1 b13_044a_1 b13_044b_1 b13_044c_1 b13_044d_1 b13_044e_1 b13_044f_1 b13_045_1 b13_045a_1 b13_047_1 b13_047_2 b13_047_3 b13_047_4 b13_047_5 b13_047_7 b13_047_11 b13_047_96 b13_048_1 b13_053_1 b13_054a_1 b13_054b_1 b13_054c_1 b13_054d_1 b13_054e_1 b13_055a_1 b13_055a_2 b13_055a_3 b13_055a_96 b13_055b_1 b13_055b_2 b13_055b_96 b13_055c_1 b13_055c_2 b13_055c_96 b13_055d_1 b13_055d_2 b13_055d_96 b13_055e_1 b13_055e_2 b13_055e_96 b13_057_1 b13_057_2 b13_057_3 b13_057_4 b13_057_5 b13_058_1 b13_058_2 b13_058_3 b13_058_5 b13_058_6 b13_058_8 b13_058_9 b13_058_10 b13_058_11 b13_058_96 b13_059_1 b13_059_2 b13_059_3 b13_059_4 b13_059_5 b13_059_9 b13_059_11 b13_059_12 b13_059_96 b13_061all_1 b13_061all_2 b13_061all_3 b13_061all_5 b13_061all_96 b13_061a_1 b13_061b b13_064a_1 b13_064b_1 b13_065a_1 b13_065b_1 b13_066a_2 b13_066b_2 b13_067a b13_067b b13_068a_1 b13_068a_2 b13_068a_3 b13_068a_4 b13_068a_5 b13_068b_1 b13_068b_2 b13_068b_3 b13_068b_4 b13_068b_5 b13_069a_1 b13_069b_1 b13_070a_1 b13_070a_2 b13_070a_3 b13_070b_1 b13_070b_2 b13_070b_3 b13_071a b13_071b b13_072a_1 b13_072b_1 b13_073a_1 b13_073b_1 b13_074a_1 b13_074b_1 b13_075an_1 b13_076a_1 b13_076b_1 b13_078a b13_078b b13_080_1 b13_081a_1 b13_082_1 b13_082_2 b13_082_3 b13_082_6 b13_082_8 b13_082_96 b13_082_100 b13_083_1 b13_083_2 b13_083_3 b13_083_4 b13_083_5 b13_083_9 b13_083_12 b13_083_96 b13_083a_1 b13_083b b13_084 b13_087_1 b13_087_2 b13_087_3 b13_087_4 b13_087_5 b13_087_8 b13_087_9 b13_087_10 b13_087_11 b13_087_96 b13_088_1 b13_089n_1 b13_090_1 b13_090_2 b13_090_3 b13_090_5 b13_090_7 b13_090_10 b13_092_1 b13_093n_1 b13_094_1 b13_094_2 b13_094_3 b13_094_6 b13_094_7 b13_094_8";
local used_dataset_nr b06;

calculate_means "`descvar_all'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'";
run_f_tests "`descvar_all'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'";

local descvar_all "b13_035_2 b13_035_3 b13_035_5 b13_035_6 b13_037_100 b13_037_101 b13_037_103 b13_037_104 b13_046_2 b13_046_3 b13_046_5 b13_046_6 b13_039_1 b13_039_2 b13_039_4 b13_039_5 b13_041_100 b13_041_101 b13_041_103 b13_041_104 b13_049_1 b13_049_2 b13_049_4 b13_051_1 b13_051_2 b13_053_2 b13_058_100 b13_058_101 b13_059_100 b13_059_101 b13_062_1 b13_062_2 b13_067a_1 b13_067b_1 b13_069a_100 b13_069b_100 b13_071a_100 b13_071a_101 b13_080_100 b13_080_101 b13_080_102 b13_083_100 b13_092_100 
b13_035_1 b13_036_1 b13_036_2 b13_036_3 b13_036_96 b13_036_100 b13_037_1 b13_037_2 b13_037_3 b13_037_4 b13_037_5 b13_037_10 b13_037_11 b13_037_12 b13_037_96 b13_039 b13_040a_1 b13_040b b13_041 b13_041_1 b13_041_2 b13_042 b13_042_1 b13_042_2 b13_044_1 b13_044a_1 b13_044b_1 b13_044c_1 b13_044d_1 b13_044e_1 b13_044f_1 b13_045_1 b13_045a_1 b13_047_1 b13_047_2 b13_047_3 b13_047_4 b13_047_5 b13_047_7 b13_047_11 
b13_047_96 b13_048_1 b13_053_1 b13_054a_1 b13_054b_1 b13_054c_1 b13_054d_1 b13_054e_1 b13_055a_1 b13_055a_2 b13_055a_3 b13_055a_96 b13_055b_1 b13_055b_2 b13_055b_96 b13_055c_1 b13_055c_2 b13_055c_96 b13_055d_1 b13_055d_2 b13_055d_96 b13_055e_1 b13_055e_2 b13_055e_96 b13_057_1 b13_057_2 b13_057_3 b13_057_4 b13_057_5 b13_058_1 b13_058_2 b13_058_3 b13_058_5 b13_058_6 b13_058_8 b13_058_9 b13_058_10 b13_058_11 b13_058_96 b13_059_1 b13_059_2 b13_059_3 b13_059_4 b13_059_5 b13_059_9 b13_059_11 b13_059_12 b13_059_96 b13_061all_1 b13_061all_2 b13_061all_3 b13_061all_5 b13_061all_96 b13_061a_1 b13_061b b13_064a_1 b13_064b_1 b13_065a_1 b13_065b_1 b13_066a_2 b13_066b_2 b13_067a b13_067b b13_068a_1 b13_068a_2 b13_068a_3 b13_068a_4 b13_068a_5 b13_068b_1 b13_068b_2 b13_068b_3 b13_068b_4 b13_068b_5 b13_069a_1 b13_069b_1 b13_070a_1 b13_070a_2 b13_070a_3 b13_070b_1 b13_070b_2 b13_070b_3 b13_071a b13_072a_1 b13_072b_1 b13_073a_1 b13_073b_1 b13_074a_1 b13_074b_1 b13_075an_1 b13_076a_1 b13_076b_1 b13_078a b13_080_1 b13_081a_1 b13_082_1 b13_082_2 b13_082_3 b13_082_6 b13_082_8 b13_082_96 b13_082_100 b13_083_1 b13_083_2 b13_083_3 b13_083_4 b13_083_5 b13_083_9 b13_083_12 b13_083_96 b13_083a_1  b13_084 b13_087_1 b13_087_2 b13_087_3 b13_087_4 b13_087_5 b13_087_8 b13_087_9 b13_087_10 b13_087_11 b13_087_96 b13_088_1 b13_089n_1 b13_090_1 b13_090_2 b13_090_3 b13_090_5 b13_090_7 b13_090_10 b13_092_1 b13_093n_1 b13_094_1 b13_094_2 b13_094_3 b13_094_6 b13_094_7 b13_094_8";

local descvar_mother "b13_035_2 b13_035_3 b13_035_5 b13_035_6 b13_037_100 b13_037_101 b13_037_103 b13_037_104 b13_046_2 b13_046_3 b13_046_5 b13_046_6 b13_039_1 b13_039_2 b13_039_4 b13_039_5 b13_041_100 b13_041_101 b13_041_103 b13_041_104 b13_049_1 b13_049_2 b13_049_4 b13_051_1 b13_051_2 b13_053_2 b13_058_100 b13_058_101 b13_059_100 b13_059_101 b13_062_1 b13_062_2 b13_067a_1 b13_067b_1 b13_069a_100 b13_069b_100 b13_071a_100 b13_071a_101 b13_080_100 b13_080_101 b13_080_102 b13_083_100 b13_092_100 
b13_035_1 b13_036_1 b13_036_2 b13_036_3 b13_036_96 b13_036_100 b13_037_1 b13_037_2 b13_037_3 b13_037_4 b13_037_5 b13_037_10 b13_037_11 b13_037_12 b13_037_96 b13_039 b13_040a_1 b13_040b b13_041 b13_041_1 b13_041_2 b13_042 b13_042_1 b13_042_2 b13_044_1 b13_044a_1 b13_044b_1 b13_044c_1 b13_044d_1 b13_044e_1 b13_044f_1 b13_045_1 b13_045a_1 b13_047_1 b13_047_2 b13_047_3 b13_047_4 b13_047_5 b13_047_7 b13_047_11 
b13_047_96 b13_048_1 b13_053_1 b13_054a_1 b13_054b_1 b13_054c_1 b13_054d_1 b13_054e_1 b13_055a_1 b13_055a_2 b13_055a_3 b13_055a_96 b13_055b_1 b13_055b_2 b13_055b_96 b13_055c_1 b13_055c_2 b13_055c_96 b13_055d_1 b13_055d_2 b13_055d_96 b13_055e_1 b13_055e_2 b13_055e_96 b13_057_1 b13_057_2 b13_057_3 b13_057_4 b13_057_5 b13_058_1 b13_058_2 b13_058_3 b13_058_5 b13_058_6 b13_058_8 b13_058_9 b13_058_10 b13_058_11 b13_058_96 b13_059_1 b13_059_2 b13_059_3 b13_059_4 b13_059_5 b13_059_9 b13_059_11 b13_059_12 b13_059_96 b13_061all_1 b13_061all_2 b13_061all_3 b13_061all_5 b13_061all_96 b13_061a_1 b13_061b b13_064a_1 b13_064b_1 b13_065a_1 b13_065b_1 b13_066a_2 b13_066b_2 b13_067a b13_067b b13_068a_1 b13_068a_2 b13_068a_3 b13_068a_4 b13_068a_5 b13_068b_1 b13_068b_2 b13_068b_3 b13_068b_4 b13_068b_5 b13_069a_1 b13_069b_1 b13_070a_1 b13_070a_2 b13_070a_3 b13_070b_1 b13_070b_2 b13_070b_3 b13_071a b13_072a_1 b13_072b_1 b13_073a_1 b13_073b_1 b13_074a_1 b13_074b_1 b13_075an_1 b13_076a_1 b13_076b_1 b13_078a b13_080_1 b13_081a_1 b13_082_1 b13_082_2 b13_082_3 b13_082_6 b13_082_8 b13_082_96 b13_082_100 b13_083_1 b13_083_2 b13_083_3 b13_083_4 b13_083_5 b13_083_9 b13_083_12 b13_083_96 b13_083a_1  b13_084 b13_087_1 b13_087_2 b13_087_3 b13_087_4 b13_087_5 b13_087_8 b13_087_9 b13_087_10 b13_087_11 b13_087_96 b13_088_1 b13_089n_1 b13_090_1 b13_090_2 b13_090_3 b13_090_5 b13_090_7 b13_090_10 b13_092_1 b13_093n_1 b13_094_1 b13_094_2 b13_094_3 b13_094_6 b13_094_7 b13_094_8";

run_t_tests "`descvar_all'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'" "`used_dataset_nr'";

restore;

**************************************************************
*** Sections 12: Reproductive health / 13.1: Pregnancy history
**************************************************************;

use $cleandatadir/rwhrbf_b03_b04_withstudyarms_withvarformeantests.dta, clear;
keep if a1_11a>=15 & a1_11a<=49 & a1_02==2;
preserve;

local descvar_all "b12_12_200 b12_12_201";
local descvar_head "NONE";
local descvar_spouse "NONE";
local descvar_youngest "NONE";
local descvar_mother "b12_12_200 b12_12_201";
local used_dataset_nr b03_b04;

calculate_means "`descvar_all'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'";
run_f_tests "`descvar_all'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'";
run_t_tests "`descvar_all'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'" "`used_dataset_nr'";

restore;

**************************************
*** Section 13.4: Patient satisfaction
**************************************;

use $cleandatadir/rwhrbf_b07_withstudyarms_withvarformeantests.dta, clear;
keep if a1_11a>=15 & a1_11a<=49 & a1_02==2;
preserve;

local descvar_all "b13_096_1 b13_096a_1 b13_096b_1 b13_097_1 b13_097a_1 b13_097b_1 b13_097c_1 b13_097d_1 b13_097e_1 b13_097f_1 b13_097g_1 b13_097h_1 b13_098_1 b13_098a_1 b13_098a_2 b13_098a_3 b13_098b_1 b13_098b_2 b13_098b_3 b13_098c_1 b13_098c_2 b13_098c_3 b13_098d_1 b13_098d_2 b13_098d_3 b13_098e_1 b13_098e_2 b13_098e_3 b13_098f_1 b13_098f_2 b13_098f_3 b13_099_1 b13_100_1 b13_100_2 b13_100_3 b13_100_4 b13_100_96 b13_101_1 b13_102_1  b13_103_1 b13_103_2 b13_103_3 b13_103_4 b13_103_96 b13_104_1 b13_105_1 b13_106_1 b13_107_1 b13_107_2 b13_108_1 b13_109_1 b13_110_1";
local descvar_head "NONE";
local descvar_spouse "NONE";
local descvar_youngest "NONE";
local descvar_mother "b13_096_1 b13_096a_1 b13_096b_1 b13_097_1 b13_097a_1 b13_097b_1 b13_097c_1 b13_097d_1 b13_097e_1 b13_097f_1 b13_097g_1 b13_097h_1 b13_098_1 b13_098a_1 b13_098a_2 b13_098a_3 b13_098b_1 b13_098b_2 b13_098b_3 b13_098c_1 b13_098c_2 b13_098c_3 b13_098d_1 b13_098d_2 b13_098d_3 b13_098e_1 b13_098e_2 b13_098e_3 b13_098f_1 b13_098f_2 b13_098f_3 b13_099_1 b13_100_1 b13_100_2 b13_100_3 b13_100_4 b13_100_96 b13_101_1 b13_102_1  b13_103_1 b13_103_2 b13_103_3 b13_103_4 b13_103_96 b13_104_1 b13_105_1 b13_106_1 b13_107_1 b13_107_2 b13_108_1 b13_109_1 b13_110_1";
local used_dataset_nr b07;

calculate_means "`descvar_all'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'";
run_f_tests "`descvar_all'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'";

local descvar_all "b13_096_1 b13_096a_1 b13_096b_1 b13_097_1 b13_097a_1 b13_097b_1 b13_097c_1 b13_097d_1 b13_097e_1 b13_097f_1 b13_097g_1 b13_097h_1 b13_098_1 b13_098a_1 b13_098a_2 b13_098a_3 b13_098b_1 b13_098b_2 b13_098b_3 b13_098c_1 b13_098c_2 b13_098c_3 b13_098d_1 b13_098d_2 b13_098d_3 b13_098e_1 b13_098e_2 b13_098e_3 b13_098f_1 b13_098f_2 b13_098f_3 b13_099_1 b13_101_1 b13_102_1  b13_103_1 b13_103_2 b13_103_3 b13_103_4 b13_103_96 b13_104_1 b13_105_1 b13_106_1 b13_107_1 b13_107_2 b13_108_1 b13_109_1 b13_110_1";
local descvar_mother "b13_096_1 b13_096a_1 b13_096b_1 b13_097_1 b13_097a_1 b13_097b_1 b13_097c_1 b13_097d_1 b13_097e_1 b13_097f_1 b13_097g_1 b13_097h_1 b13_098_1 b13_098a_1 b13_098a_2 b13_098a_3 b13_098b_1 b13_098b_2 b13_098b_3 b13_098c_1 b13_098c_2 b13_098c_3 b13_098d_1 b13_098d_2 b13_098d_3 b13_098e_1 b13_098e_2 b13_098e_3 b13_098f_1 b13_098f_2 b13_098f_3 b13_099_1 b13_101_1 b13_102_1  b13_103_1 b13_103_2 b13_103_3 b13_103_4 b13_103_96 b13_104_1 b13_105_1 b13_106_1 b13_107_1 b13_107_2 b13_108_1 b13_109_1 b13_110_1";

run_t_tests "`descvar_all'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'" "`used_dataset_nr'";

restore;

***********************************
*** Section 13.5: Weight and Height
***********************************;

use $cleandatadir/rwhrbf_b09_withstudyarms_withvarformeantests.dta, clear;
keep if a1_02==2 & (b13_118y!=. | b13_118m!=. | b13_119!=. | b13_120d!=. | b13_120m!=. | b13_120y!=. | b13_121!=. | b13_122!=. | b13_123!=.);
preserve;

local descvar_all "b13_118_1 b13_119_1 b13_121 b13_122_1 b13_123";
local descvar_head "NONE";
local descvar_spouse "NONE";
local descvar_youngest "NONE";
local descvar_mother "b13_118_1 b13_119_1 b13_121 b13_122_1 b13_123";
local used_dataset_nr b09;

calculate_means "`descvar_all'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'";
run_f_tests "`descvar_all'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'";
run_t_tests "`descvar_all'" "`descvar_head'" "`descvar_spouse'" "`descvar_youngest'" "`descvar_mother'" "`used_dataset_nr'";

restore;

log close;