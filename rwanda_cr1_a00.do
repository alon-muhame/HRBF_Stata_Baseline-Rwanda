
version 10.0
clear
set more off
set mem 500m
cap log close

#delimit ;

log using $logdir/rwanda_cr1_a00.log, replace;

************************************************************
*** Household Questionnaire - a00 section at household level
************************************************************;	

use $origdatadir/RWHRBF_A_HH-00.dta, clear;
*duplicates report a0_sect hrbf_id2;
duplicates report hrbf_id1 hrbf_id2;
* Check there aren't more than 12 households interviewed per sector;
bysort hrbf_id1: gen nr_hh=_N;
list hrbf_id1 hrbf_id2 if nr_hh>12;
drop nr_hh;
tab a5_08a;
tab a5_08a, nolab;
lab drop A5_08A;
lab def A5_08A 1 "Piped into dwelling" 2 "Piped into yard/plot" 3 "Public tap/standpipe" 4 "Protected well" 5 "Unprotected well" 6 "Protected spring" 7 "Unprotected spring" 8 "Rainwater" 9 "Tanker truck" 10 "Surface water (lakes)" 11 "Bottled water" 96 "Other";
lab values a5_08a A5_08A;
tab a5_08b;
tab a5_08b, nolab;
replace a5_08b=0 if a5_08b==10;
lab drop A5_08B;
lab def A5_08B 1 "Piped into dwelling" 2 "Piped into yard/plot" 3 "Public tap/standpipe" 4 "Protected well" 5 "Unprotected well" 6 "Protected spring" 7 "Unprotected spring" 8 "Rainwater" 9 "Tanker truck" 10 "Surface water (lakes)" 11 "Bottled water" 96 "Other";
lab values a5_08b A5_08B;
lab var a5_09a "Distance dry water source km";
lab var a5_09b "Distance rainy water source km";
tab a5_10a, nolab;
replace a5_10a=96 if a5_10a==0;
tab a5_10b, nolab;
replace a5_10b=96 if a5_10b==0;
tab a5_13;
replace a5_13=96 if a5_13==0;
tab a5_15;
replace a5_15=96 if a5_15==99;
tab a6_04u;
replace a6_04u=. if a6_04u==0 | a6_04u==5;
tab a6_06u;
replace a6_06u=. if a6_06u==0 | a6_06u==5;
lab var a6_07 "Subjective value of land RWF";
tab a6_08u;
tab a6_09u;
tab a6_10u;
replace a6_08u=. if a6_08u==0;
replace a6_09u=. if a6_09u==0;
replace a6_10u=. if a6_10u==0;
tab a7_02;
replace a7_02=4 if a7_02==43;
tab a7_04;
replace a7_04=96 if a7_04==0;

count;
merge hrbf_id1 hrbf_id2 using "$cleandatadir/rwhrbf_hh_key_anon.dta", unique sort;
drop if hrbf_id1==87 | hrbf_id1==158 | hrbf_id1==166;
*These sectors have no group_code and should be not be included;

tab _merge;
keep if _merge==3;
drop _merge;

sort hrbf_id1 hrbf_id2;
save "$cleandatadir/rwhrbf_a00_withstudyarms.dta", replace;
log close;