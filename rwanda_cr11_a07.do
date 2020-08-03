* Elisa Rothenbuhler - Sep 10

* This do-file:
* Creates clean household a07 dataset: $cleandatadir/rwhrbf_a07.dta.
* Creates a07 dataset with only one observation per household: $cleandatadir/rwhrbf_a07_with_1obs_for_1hh.dta
* Merges $cleandatadir/rwhrbf_a07_with_1obs_for_1hh.dta with household-level dataset a00 to create a07 dataset with only one observation per household with study arms: $cleandatadir/rwhrbf_a07_with_1obs_for_1hh_withstudyarms.dta
* Creates appropriate variables for mean tests.

version 10.0
clear
set more off
set mem 500m
cap log close

#delimit ;

log using $logdir/rwanda_cr11_a07.log, replace;


*********************
*** Clean a07 section
*********************;

use $origdatadir/RWHRBF_A_HOUSEHOLD-07.dta, clear;
duplicates report hrbf_id1 hrbf_id2 a7a_seq;
tab a7a_seq, nolab;
tab a7_01;

sort hrbf_id1 hrbf_id2;
save $cleandatadir/rwhrbf_a07.dta, replace;


***************************************
*** Create rwhrbf_a07_with_1obs_for_1hh
***************************************;

forvalues v=1(1)12 {;
	gen a7_01_`v'_2=.;
	replace a7_01_`v'_2=a7_01 if a7a_seq==`v';
	by hrbf_id1 hrbf_id2: egen a7_01_`v'=min(a7_01_`v'_2);
	drop a7_01_`v'_2;
};

drop a7a_seq a7a_txt a7_01;

lab var a7_01_1 "Income 12m RWF:Interest";
lab var a7_01_2 "Income 12m RWF:Rent land";
lab var a7_01_3 "Income 12m RWF:Rent equipmt";
lab var a7_01_4 "Income 12m RWF:Rent animals";
lab var a7_01_5 "Income 12m RWF:Pension etc";
lab var a7_01_6 "Income 12m RWF:Other govt";
lab var a7_01_7 "Income 12m RWF:Scholarship";
lab var a7_01_8 "Income 12m RWF:Commu assistance";
lab var a7_01_9 "Income 12m RWF:Nal remittance";
lab var a7_01_10 "Income 12m RWF:Intal remittance";
lab var a7_01_11 "Income 12m RWF:Inheritance";
lab var a7_01_12 "Income 12m RWF:Other";

sort hrbf_id1 hrbf_id2;
by hrbf_id1 hrbf_id2: keep if _n==1;
sort hrbf_id1 hrbf_id2;
save $cleandatadir/rwhrbf_a07_with_1obs_for_1hh.dta, replace;


******************************************************
*** Create rwhrbf_a07_with_1obs_for_1hh_with_studyarms
******************************************************;

use $cleandatadir/rwhrbf_a00_withstudyarms.dta, clear;
merge hrbf_id1 hrbf_id2 using $cleandatadir/rwhrbf_a07_with_1obs_for_1hh.dta, unique;
tab _merge;
list hrbf_id1 hrbf_id2 if _merge==2;
drop if _merge==2;
drop _merge;
save $cleandatadir/rwhrbf_a07_with_1obs_for_1hh_withstudyarms.dta, replace;


*********************************************
*** Create necessary variables for mean tests
*********************************************;

gen group_code_1=group_code==1;
gen group_code_2=group_code==2;
gen group_code_3=group_code==3;
gen group_code_4=group_code==4;
lab var group_code_1 "Demand-side treatment";
lab var group_code_2 "Supply-side treatment";
lab var group_code_3 "Demand- and supply-side treatment";
lab var group_code_4 "Control";

egen a7_01_100=rowtotal(a7_01_1 a7_01_2 a7_01_3 a7_01_4 a7_01_5 a7_01_6 a7_01_7 a7_01_8 a7_01_9 a7_01_10 a7_01_11 a7_01_12);
lab var a7_01_100 "Income past 12m-not from work";

svyset [pweight=hhpweight], psu(hrbf_id1);
save $cleandatadir/rwhrbf_a07_with_1obs_for_1hh_withstudyarms_withvarformeantests.dta, replace;

log close;

