* Elisa Rothenbuhler - Feb 11

version 10.0
clear
set more off
set mem 500m
cap log close

cd "/Users/elisarothenbuhler/Desktop/WB*HRITF/Rwanda/dofiles"


*****************************************
*** Data cleaning and dataset creation
*****************************************

do rwanda_directories
do rwanda_cr1_a00			// Create household-level dataset with study arms
do rwanda_cr2_a01_roster	// Create clean a01 + a01 with mean test var + household roster

*** Main household questionnaire
do rwanda_cr3_a02			// Create clean a02 + a02 with mean test var
do rwanda_cr4_a03			// Create clean a03 + a03 with mean test var
do rwanda_cr5_a04			// Create clean a04
do rwanda_cr6_b08			// Create clean b08
do rwanda_cr7_a04_b08		// Merges a04 and b08 + creates a04_b08 with mean test var
do rwanda_cr8_a00			// Generate variables for mean tests for a00
do rwanda_cr9_a05			// Create clean a05
do rwanda_cr10_a06			// Create clean a06
do rwanda_cr11_a07			// Create clean a07
do rwanda_cr12_a08			// Create clean a08

*** Female questionnaire
do rwanda_cr13_b01			// Create clean b01
do rwanda_cr14_b02			// Create clean b02
do rwanda_cr15_b03			// Create clean b03
do rwanda_cr16_b04			// Create clean b04
do rwanda_cr17_b05			// Create clean b05
do rwanda_cr18_b06			// Create clean b06
do rwanda_cr19_b03_b04		// Create closest measure of unmet neet for FP from WHO definition
do rwanda_cr20_b07			// Create clean b07
do rwanda_cr21_b09			// Create clean b09

*** Child questionnaire
do rwanda_cr22_c00			// Create clean c00
do rwanda_cr23_c01			// Create clean c01
do rwanda_cr24_c02			// Create clean c02
do rwanda_cr25_c03			// Create clean c03
do rwanda_cr26_c04			// Create clean c04 - Run Z-score WHO macro
do rwanda_cr27_c05			// Create clean c05


***************************************************************
*** Analysis - saved in raw text files: Descriptives statistics
***************************************************************

do rwanda_an1_a00			// General statistics on sample

*** Main household questionnaire
do rwanda_an2_a01			// Mean tests on a01
do rwanda_an1000_programs	// Define programs to run mean tests systematically
do rwanda_an3_a02toa08		// Mean tests on a02, a03, a04, a05, a06, a07, a08

*** Female questionnaire
do rwanda_an4_b01tob09		// Mean tests on b01, b02, b03, b04, b05, b06, b03_b04, b07, b09

*** Child questionnaire
do rwanda_an5_c01toc05		// Mean tests on c01, c02, c03, c04, c05

*** Compile results in formatted tables
do rwanda_cr28_meantestvarlist	// Describe all variables used in analysis 
								// WARNING: Create table of variables and variables labels manually
do rwanda_cr29_baselinetables	// Create tables of balance of the sample at baseline (descriptive statistics by treatment group and results of mean tests)
do rwanda_cr30_baselinetables_gender	// Build tables on Health knowledge section a04 for men only, women only, and build table of result of mean test between men and women


************************
*** Graphs of results
************************

do rwanda_an6_graphs		// Draw and save Graphs on all sections of the questionnaire


****************************************************************
*** Additional tables for comparison with national statistics
****************************************************************

cd "/Users/elisarothenbuhler/Desktop/WB*HRITF/Rwanda/dofiles"

do rwanda_an7_a01			// Build small tables on the structure of the sample (nr. women, children under 5, etc.)
							// Build small tables on specific characteristics to compare with DHS (age groups, education, asset ownership)
							

************************************************************************
*** Tables on the balance of the sample (% of significant F- or T-tests)
************************************************************************

do rwanda_cr31_baselinebalancetables	// Create variables flagging if F- or T-tests were performed, and if they were significant
do rwanda_an8_baselinebalancetables		// Obtain tables describing the percentage of balanced indicators and covariates in the sample (i.e. significance of F- and T-tests), the % of F- or T-tests not performed

exit