* Elisa Rothenbuhler - Nov 10

* This do-file creates tables containing variable name - variable label of all the variables included in the analysis. 

* This do-file should be run with a big enough scrollbufsize (see help set), so that all the output of the do-file is visible on the results window once the do-file is run. 

* Whenever a table is produced after the describe command, copy this table (select the table, right-click, "copy table" (not "copy")), paste it into Excel to obtain in the end 2 big tables, one for household-level variables, one for individual-level variables.
* Then copy those tables into Stata editor, i.e. do the following for each of the 2 tables:
	* edit
	* ren var1 Variable
	* ren var2 Variable_label
	* drop if _n==1 (only if you have copied column names from Excel and they appear as data)
* Then save those two data files. Here I have saved my files as:
	* $resultdir/rwhrbf_hhlevelvariables.dta with the variable names "Variable Variable_label"
	* $resultdir/rwhrbf_indlevelvariables.dta with the variable names "Variable Variable_label"
	
* These two tables will be used for merging all the output files gotten through the analysis in a systematic way - instead of dealing with everything in Excel, which is time-consuming and can generate mistakes.

* WARNING: you must make sure your datasets include variable names and correct variable labels. You must also make sure that none of your labels exceeds 32 characters, otherwise it won't have been exported in your Means/F-test tables, which will cause you problem once you merge all the datasets together. If you encounter that situation, modify the labels on your do-files, re-run the analysis, and recreate the $resultdir/rwhrbf_hhlevelvariables.dta and $resultdir/rwhrbf_indlevelvariables.dta datasets accordingly.

* Note to Stata 11 Users: Use "describe, replace" and then append datasets- should be much easier.



set scrollbufsize 500000
* Note: quit Stata after set scrollbufsize command; Reopen Stata for this command to take effect.


version 10.0
clear
set more off
set mem 500m
cap log close

#delimit ;

log using $logdir/rwanda_cr28_meantestvarlist.log, replace;


*** Step 1: Get variables description in log file;


***********************************************************
*** Household level tables
***********************************************************;

***
*** Generate variable-variable label list for household-level tables of means and mean tests
***;

use $cleandatadir/rwhrbf_a00_withstudyarms_withvarformeantests.dta, clear;
desc a5_03_1 a5_03_2 a5_03_3 a5_03_4 a5_03_5 a5_03_6 a5_03_7 a5_03_8 a5_03_9 a5_03_96 a5_04_1 a5_06_1 a5_08a_100 a5_08b_100 a5_08a_1 a5_08a_2 a5_08a_3 a5_08a_4 a5_08a_5 a5_08a_6 a5_08a_7 a5_08a_8 a5_08a_9 a5_08a_10 a5_08a_11 a5_08a_96 a5_08b_1 a5_08b_2 a5_08b_3 a5_08b_4 a5_08b_5 a5_08b_6 a5_08b_7 a5_08b_8 a5_08b_9 a5_08b_10 a5_08b_11 a5_08b_96 a5_09a a5_09b a5_10a_1 a5_10a_2 a5_10a_3 a5_10a_4 a5_10a_96 a5_10b_1 a5_10b_2 a5_10b_3 a5_10b_4 a5_10b_96 a5_11_100 a5_11_1 a5_11_2 a5_11_3 a5_11_4 a5_11_5 a5_11_6 a5_11_7 a5_11_8 a5_11_9 a5_11_10 a5_11_96 a5_13_1 a5_13_2 a5_13_3 a5_13_4 a5_13_5 a5_13_96 a5_14_1 a5_14_2 a5_14_3 a5_14_4 a5_14_5 a5_14_6 a5_14_7 a5_14_8 a5_14_9 a5_14_10 a5_14_96 a5_15_1 a5_15_2 a5_15_3 a5_15_4 a5_15_5 a5_15_6 a5_15_7 a5_15_8 a5_15_9 a5_15_10 a5_15_96;

use $cleandatadir/rwhrbf_a05_with_1obs_for_1hh_withstudyarms_withvarformeantests.dta, clear;
desc a6_02_100 a6_01_1 a6_02_1 a6_01_2 a6_02_2 a6_01_3 a6_02_3 a6_01_4 a6_02_4 a6_01_5 a6_02_5 a6_01_6 a6_02_6 a6_01_7 a6_02_7 a6_01_8 a6_02_8 a6_01_9 a6_02_9 a6_01_10 a6_02_10 a6_01_11 a6_02_11 a6_01_12 a6_02_12 a6_01_13 a6_02_13 a6_01_14 a6_02_14 a6_01_15 a6_02_15 a6_01_16 a6_02_16 a6_01_17 a6_02_17 a6_01_18 a6_02_18 a6_01_19 a6_02_19 a6_01_20 a6_02_20;

use $cleandatadir/rwhrbf_a00_withstudyarms_withvarformeantests.dta, clear;
desc a6_05_2 a6_06n_2 a6_07 a6_08n_1 a6_09n_1 a6_10n_1;

use $cleandatadir/rwhrbf_a06_with_1obs_for_1hh_withstudyarms_withvarformeantests.dta, clear;
desc a6_12_100 a6_13_100 a6_13_101 a6_13_102 a6_13_103 a6_13_104;

use $cleandatadir/rwhrbf_a07_with_1obs_for_1hh_withstudyarms_withvarformeantests.dta, clear;
desc a7_01_100 a7_01_1 a7_01_2 a7_01_3 a7_01_4 a7_01_5 a7_01_6 a7_01_7 a7_01_8 a7_01_9 a7_01_10 a7_01_11 a7_01_12;

use $cleandatadir/rwhrbf_a00_withstudyarms_withvarformeantests.dta, clear;
desc a7_03_1 a7_03_2 a7_04_1_1 a7_04_1_2 a7_04_1_3 a7_04_1_4 a7_04_1_5 a7_04_1_6 a7_04_1_7 a7_04_1_8 a7_04_1_9 a7_04_1_10  a7_04_1_11  a7_04_1_96 a7_04_2_1 a7_04_2_2 a7_04_2_3 a7_04_2_4 a7_04_2_5 a7_04_2_6 a7_04_2_7 a7_04_2_8 a7_04_2_9 a7_04_2_10 a7_04_2_11 a7_04_2_96;

use $cleandatadir/rwhrbf_a00_withstudyarms_withvarformeantests.dta, clear;
desc a9_01_1;

use $cleandatadir/rwhrbf_a08_with_1obs_for_1hh_withstudyarms_withvarformeantests.dta, clear;
desc a9_05_1_1 a9_06n_1_1 a9_06n_1_2 a9_07_1_1 a9_07_1_2 a9_07_1_3 a9_07_1_4 a9_07_1_5 a9_07_1_6 a9_07_1_7 a9_07_1_8 a9_07_1_9 a9_07_1_10 a9_07_1_11 a9_07_1_12 a9_07_1_13 a9_07_1_14 a9_07_1_15 a9_07_1_16 a9_07_1_17 a9_07_1_96 a9_08_1_1 a9_08_1_2 a9_08_1_3 a9_08_1_4 a9_08_1_5 a9_08_1_96;




***********************************************************
*** Individual level tables
***********************************************************;

***
*** Generate variable - variable label list for individual-level tables of means and mean tests
***;

use $cleandatadir/rwhrbf_a01_withstudyarms_withvarformeantests.dta, clear;
desc a1_hhsize;

use $cleandatadir/rwhrbf_a01_withstudyarms_withvarformeantests.dta, clear;
desc a1_02_02 a1_11a a1_11b a1_12_01 a1_12_02 a1_12_03 a1_12_04 a1_12_05 a1_12_06 a1_12_07 a1_14_99 a1_15_99 a1_15_1 a1_14ag_1 a1_15ag_1 a1_14al_2 a1_14al_3 a1_14al_4 a1_14al_5 a1_15al_2 a1_15al_3 a1_15al_4 a1_15al_5 a1_16_01 a1_16_02 a1_16_03 a1_16_04 a1_16_05 a1_16_96 a1_17_01 a1_17_2 a1_20_01 a1_22_01;

use $cleandatadir/rwhrbf_a02_withstudyarms_withvarformeantests.dta, clear;
desc a2_03_1 a2_08_1 a2_09_1 a2_09_2 a2_09_3 a2_09_4 a2_09_5 a2_05h_1 a2_06 a2_07_01 a2_07_02 a2_07_03 a2_07_04 a2_07_05 a2_07_06 a2_07_07 a2_07_08 a2_07_09 a2_07_10 a2_07_11 a2_07_12 a2_07_13 a2_07_14 a2_07_96 a2_10a a2_10b a2_10c a2_10d a2_10e a2_10f a2_10g;

use $cleandatadir/rwhrbf_a03_withstudyarms_withvarformeantests.dta, clear;
desc a3_01_106 a3_01_107 a3_01_101 a3_01_102 a3_01_103 a3_01_104 a3_01_105 a3_02_1 a3_03_1 a3_03_2 a3_03_3 a3_03_4 a3_03_5 a3_03_6 a3_03_7 a3_03_96 a3_04_1 a3_05a_1 a3_05b_1 a3_07_2 a3_08_101 a3_10_1 a3_11_1 a3_12a_1 a3_12b_1 a3_14_2 a3_15_101 a3_17_1 a3_18_1;

use $cleandatadir/rwhrbf_a04_b08_withstudyarms_withvarformeantests.dta, clear;
desc a4_healthscore a4_10a_1 a4_10b_1 a4_10c_1 a4_10d_1 a4_11a_1 a4_11b_1 a4_11c_1 a4_11d_1 a4_12a_1 a4_12b_1 a4_12c_1 a4_12d_1 a4_12e_1 a4_13a_1 a4_13b_1 a4_13c_1 a4_13d_1 a4_14a_1 a4_14b_1 a4_14c_1 a4_14d_1 a4_15a_1 a4_15b_1 a4_15c_1 a4_15d_1 a4_15e_1 a4_16a_1 a4_16b_1 a4_16c_1 a4_16d_1 a4_16e_1;

use $cleandatadir/rwhrbf_b01_withstudyarms_withvarformeantests.dta, clear;
desc b10_00_1 b10_01_1 b10_01_2 b10_01_3 b10_01_4 b10_02_1 b10_02_2 b10_02_3 b10_03_1 b10_03_2 b10_03_3 b10_03_4 b10_04_1 b10_05b_100 b10_05c_100 b10_05a_1 b10_05a_2 b10_05a_3 b10_05a_4 b10_05a_7 b10_05a_8 b10_05a_9 b10_05a_10 b10_05a_11 b10_05a_12 b10_05a_13 b10_05a_14 b10_05a_15 b10_05a_16 b10_05a_17 b10_05a_18 b10_05a_19 b10_05a_96 b10_05b_1 b10_05b_2 b10_05b_3 b10_05b_4 b10_05b_7 b10_05b_11 b10_05b_12 b10_05b_96 b10_05c_1 b10_05c_2 b10_05c_3 b10_05c_12 b10_05c_96 b10_07a_2 b10_07a_4 b10_08_1;

use $cleandatadir/rwhrbf_b02_withstudyarms_withvarformeantests.dta, clear;
desc b11_01a_1 b11_01a_2 b11_01a_3 b11_01b_1 b11_01b_2 b11_01b_3 b11_01c_1 b11_01c_2 b11_01c_3 b11_01d_1 b11_01d_2 b11_01d_3 b11_02_1 b11_03_1 b11_03_4 b11_03_7 b11_03_10 b11_03_11 b11_04_1;

use $cleandatadir/rwhrbf_b03_withstudyarms_withvarformeantests.dta, clear;
desc b12_12_1 b12_12_100 b12_12_101 b12_12_102 b12_12_103 b12_12_104 b12_12_105 b12_12_106 b12_12_107 b12_12_108 b12_12_109 b12_01a b12_01b b12_01_1 b12_02_1 b12_02_2 b12_02_3 b12_02_4 b12_02_5 b12_02_96 b12_03_1 b12_03_2 b12_03_3 b12_03_4 b12_04_1 b12_05_1 b12_06_1 b12_07_1 b12_08_1 b12_09_1 b12_10_1 b12_11_1 b12_11_2 b12_11_3 b12_11_99 b12_12_3 b12_13a_1 b12_13b_1 b12_13c_1 b12_13d_1 b12_13e_1 b12_13f_1 b12_13g_1 b12_13h_1 b12_13i_1 b12_13j_1 b12_13k_1 b12_13l_1 b12_13a_2 b12_14_1 b12_14_2 b12_14_3 b12_14_4 b12_14_5 b12_14_6 b12_14_7 b12_14_8 b12_14_9 b12_14_10 b12_14_96 b12_14a_1 b12_15_1 b12_15_2 b12_15_3 b12_15_4 b12_15_5 b12_15_6 b12_15_7 b12_15_8 b12_15_9 b12_15_10 b12_15_96 b12_16y_1 b12_18a_1 b12_18b_1 b12_18c_1 b12_18d_1 b12_18e_1;

use $cleandatadir/rwhrbf_b04_withstudyarms_withvarformeantests.dta, clear;
desc b13_001_1 b13_003_100 b13_003_1 b13_003_2 b13_003_3 b13_006_2 b13_004_1 b13_006_1 b13_007_1 b13_007a_1 b13_007b_1 b13_008_1 b13_009a b13_009b b13_012_1 b13_013 b13_013_1 b13_014 b13_014_1;

use $cleandatadir/rwhrbf_b03_b04_withstudyarms_withvarformeantests.dta, clear;
desc b12_12_200 b12_12_201;

use $cleandatadir/rwhrbf_b05_withstudyarms_withvarformeantests.dta, clear;
desc b13_022n_1 b13_023_1 b13_024_1 b13_026_2 b13_028_2 b13_030a_1 b13_030a_2;

use $cleandatadir/rwhrbf_b06_withstudyarms_withvarformeantests.dta, clear;
desc b13_035_2 b13_035_3 b13_035_4 b13_035_5 b13_035_6 b13_037_100 b13_037_101 b13_037_102 b13_037_103 b13_037_104 b13_046_2 b13_046_3 b13_046_4 b13_046_5 b13_046_6 b13_039_1 b13_039_2 b13_039_3 b13_039_4 b13_039_5 b13_041_100 b13_041_101 b13_041_102 b13_041_103 b13_041_104 b13_049_1 b13_049_2 b13_049_4 b13_049_5 b13_051_1 b13_051_2 b13_053_2 b13_053_3 b13_058_100 b13_058_101 b13_059_100 b13_059_101 b13_062_1 b13_062_2 b13_067a_1 b13_067b_1 b13_069a_100 b13_069b_100 b13_071a_100 b13_071a_101 b13_080_100 b13_080_101 b13_080_102 b13_083_100 b13_092_100 b13_035_1 b13_036_1 b13_036_2 b13_036_3 b13_036_96 b13_036_100 b13_037_1 b13_037_2 b13_037_3 b13_037_4 b13_037_5 b13_037_10 b13_037_11 b13_037_12 b13_037_96 b13_039 b13_040a_1 b13_040b b13_041 b13_041_1 b13_041_2 b13_042 b13_042_1 b13_042_2 b13_044_1 b13_044a_1 b13_044b_1 b13_044c_1 b13_044d_1 b13_044e_1 b13_044f_1 b13_045_1 b13_045a_1 b13_047_1 b13_047_2 b13_047_3 b13_047_4 b13_047_5 b13_047_7 b13_047_11 b13_047_96 b13_048_1 b13_053_1 b13_054a_1 b13_054b_1 b13_054c_1 b13_054d_1 b13_054e_1 b13_055a_1 b13_055a_2 b13_055a_3 b13_055a_96 b13_055b_1 b13_055b_2 b13_055b_96 b13_055c_1 b13_055c_2 b13_055c_96 b13_055d_1 b13_055d_2 b13_055d_96 b13_055e_1 b13_055e_2 b13_055e_96 b13_057_1 b13_057_2 b13_057_3 b13_057_4 b13_057_5 b13_058_1 b13_058_2 b13_058_3 b13_058_5 b13_058_6 b13_058_8 b13_058_9 b13_058_10 b13_058_11 b13_058_96 b13_059_1 b13_059_2 b13_059_3 b13_059_4 b13_059_5 b13_059_9 b13_059_11 b13_059_12 b13_059_96 b13_061all_1 b13_061all_2 b13_061all_3 b13_061all_5 b13_061all_96 b13_061a_1 b13_061b b13_064a_1 b13_064b_1 b13_065a_1 b13_065b_1 b13_066a_2 b13_066b_2 b13_067a b13_067b b13_068a_1 b13_068a_2 b13_068a_3 b13_068a_4 b13_068a_5 b13_068b_1 b13_068b_2 b13_068b_3 b13_068b_4 b13_068b_5 b13_069a_1 b13_069b_1 b13_070a_1 b13_070a_2 b13_070a_3 b13_070b_1 b13_070b_2 b13_070b_3 b13_071a b13_071b b13_072a_1 b13_072b_1 b13_073a_1 b13_073b_1 b13_074a_1 b13_074b_1 b13_075an_1 b13_076a_1 b13_076b_1 b13_078a b13_078b b13_080_1 b13_081a_1 b13_082_1 b13_082_2 b13_082_3 b13_082_6 b13_082_8 b13_082_96 b13_082_100 b13_083_1 b13_083_2 b13_083_3 b13_083_4 b13_083_5 b13_083_9 b13_083_12 b13_083_96 b13_083a_1 b13_083b b13_084 b13_087_1 b13_087_2 b13_087_3 b13_087_4 b13_087_5 b13_087_8 b13_087_9 b13_087_10 b13_087_11 b13_087_96 b13_088_1 b13_089n_1 b13_090_1 b13_090_2 b13_090_3 b13_090_5 b13_090_7 b13_090_10 b13_092_1 b13_093n_1 b13_094_1 b13_094_2 b13_094_3 b13_094_6 b13_094_7 b13_094_8;

use $cleandatadir/rwhrbf_b07_withstudyarms_withvarformeantests.dta, clear;
desc b13_096_1 b13_096a_1 b13_096b_1 b13_097_1 b13_097a_1 b13_097b_1 b13_097c_1 b13_097d_1 b13_097e_1 b13_097f_1 b13_097g_1 b13_097h_1 b13_098_1 b13_098a_1 b13_098a_2 b13_098a_3 b13_098b_1 b13_098b_2 b13_098b_3 b13_098c_1 b13_098c_2 b13_098c_3 b13_098d_1 b13_098d_2 b13_098d_3 b13_098e_1 b13_098e_2 b13_098e_3 b13_098f_1 b13_098f_2 b13_098f_3 b13_099_1 b13_100_1 b13_100_2 b13_100_3 b13_100_4 b13_100_96 b13_101_1 b13_102_1  b13_103_1 b13_103_2 b13_103_3 b13_103_4 b13_103_96 b13_104_1 b13_105_1 b13_106_1 b13_107_1 b13_107_2 b13_108_1 b13_109_1 b13_110_1;

use $cleandatadir/rwhrbf_b09_withstudyarms_withvarformeantests.dta, clear;
desc b13_118_1 b13_119_1 b13_121 b13_122_1 b13_123;

use $cleandatadir/rwhrbf_c01_withstudyarms_withvarformeantests.dta, clear;
desc c14_31a_100 c14_31a_101 c14_12_100 c14_05_1 c14_06a_1 c14_06a_2 c14_06a_3 c14_06a_4 c14_06a_5 c14_06a_6 c14_06a_7 c14_06a_8 c14_06a_9 c14_06a_10 c14_06a_11 c14_06a_12 c14_06a_13 c14_06a_14 c14_06a_15 c14_06a_16 c14_06a_17 c14_06a_18 c14_06a_19 c14_06a_96 c14_06b_1 c14_06b_2 c14_06b_3 c14_06b_4 c14_06b_5 c14_06b_6 c14_06b_7 c14_06b_8 c14_06b_9 c14_06b_10 c14_06b_11 c14_06b_12 c14_06b_13 c14_06b_14 c14_06b_15 c14_06b_16 c14_06b_17 c14_06b_18 c14_06b_19 c14_06b_96 c14_06c_1 c14_06c_2 c14_06c_3 c14_06c_4 c14_06c_5 c14_06c_6 c14_06c_7 c14_06c_8 c14_06c_9 c14_06c_10 c14_06c_11 c14_06c_12 c14_06c_13 c14_06c_14 c14_06c_15 c14_06c_16 c14_06c_17 c14_06c_18 c14_06c_19 c14_06c_96 c14_08a_2 c14_09_1 c14_10_4 c14_11_4 c14_12_1 c14_12a_1 c14_12a_2 c14_12a_3 c14_12a_4 c14_12a_5 c14_12a_6 c14_12a_7 c14_12a_8 c14_12a_9 c14_12a_10 c14_12a_11 c14_12a_12 c14_12a_96 c14_25_1 c14_25_2 c14_31_1 c14_31_2 c14_31_3 c14_35 c14_39 c14_40_1 c14_40_2 c14_40_3;

use $cleandatadir/rwhrbf_c02_withstudyarms_withvarformeantests.dta, clear;
desc c15_05h_100 c15_05h_101 c15_05i_100 c15_05i_101 c15_05i_102 c15_05i_103 c15_05j_100 c15_05j_101 c15_04_1 c15_04_2;

use $cleandatadir/rwhrbf_c03_withstudyarms_withvarformeantests.dta, clear;
desc c15_06_1 c15_07_1 c15_08_1 c15_09_1 c15_10_1 c15_11_1 c15_12 c15_12_1 c15_13_1 c15_14 c15_14_1 c15_15_1 c15_16_1 c15_16_2  c15_17_1 c15_17_2 c15_17_3 c15_17_96 c15_19_1 c15_20_1 c15_20_2 c15_20_3 c15_20_4 c15_20_5 c15_20_6 c15_20_7 c15_20_8 c15_20_9 c15_20_10 c15_20_11 c15_20_96 c15_21_1 c15_22_1 c15_23_1;

use $cleandatadir/rwhrbf_c04_withstudyarms_withvarformeantests.dta, clear;
desc c16_13_100 c16_13_101 c16_13_102 c16_13_103 c16_13_104 c16_13_105 c16_11_100 c16_11_101 c16_11_102 c16_11_103 c16_02_1 c16_04_1 c16_04_2 c16_04_3 c16_04_4 c16_04_5 c16_05_1 c16_05_2 c16_05_3 c16_05_6 c16_05_8 c16_05_10 c16_05_11 c16_05_96 c16_06_1 c16_06_2 c16_06_3 c16_07_1 c16_07_2 c16_07_3 c16_07_11 c16_07_13 c16_08a_1 c16_08b_1 c16_08c_1 c16_08d_1 c16_08e_1 c16_08f_1 c16_09_1 c16_09_2 c16_09_5 c16_09_6 c16_11 c16_12_1 c16_12_2 c16_13 c16_14_1 c16_14_2 c16_14_3 _fwei _flen _fwfl _fbmi _zwei_clean _zlen_clean _zwfl_clean _zbmi_clean;

use $cleandatadir/rwhrbf_c05_withstudyarms_withvarformeantests.dta, clear;
desc c16_16_1 c16_18 c16_19_1 c16_20_1;

log close;