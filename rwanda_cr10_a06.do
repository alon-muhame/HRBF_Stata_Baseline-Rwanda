* Elisa Rothenbuhler - Sep 10

* This do-file:
* Creates clean household a06 dataset: $cleandatadir/rwhrbf_a06.dta.
* Creates a06 dataset with only one observation per household: $cleandatadir/rwhrbf_a06_with_1obs_for_1hh.dta
* Merges $cleandatadir/rwhrbf_a06_with_1obs_for_1hh.dta with household-level dataset a00 to create a06 dataset with only one observation per household with study arms: $cleandatadir/rwhrbf_a06_with_1obs_for_1hh_withstudyarms.dta
* Creates appropriate variables for mean tests.

version 10.0
clear
set more off
set mem 500m
cap log close

#delimit ;

log using $logdir/rwanda_cr10_a06.log, replace;


******************************************************************
*** Clean a06 section (questionnaire section 6: Assets part B-end)
******************************************************************;

use $origdatadir/RWHRBF_A_HOUSEHOLD-06.dta, clear;
duplicates tag hrbf_id1 hrbf_id2 a6b_seq, gen(dupl);
list hrbf_id1 hrbf_id2 a6b_seq a6b_txt if dupl!=0;
drop if a6b_seq==.;
drop dupl;
duplicates report hrbf_id1 hrbf_id2 a6b_seq;
tab a6b_seq, nolab;
tab a6_11;
list hrbf_id1 hrbf_id2 a6b_seq a6b_txt a6_11 a6_12 a6_13 a6_13 if a6_11>20 & a6_11!=.;
replace a6_11=0 if a6_11==400;
replace a6_11=. if a6_11==96;
tab a6_12;
list hrbf_id1 hrbf_id2 a6b_seq a6b_txt a6_11 a6_12 a6_13 a6_13 if a6_12>500000 & a6_12!=.;
tab a6_13;
list hrbf_id1 hrbf_id2 a6b_seq a6b_txt a6_11 a6_12 a6_13 a6_13 if a6_13==10000000;

sort hrbf_id1 hrbf_id2;
save $cleandatadir/rwhrbf_a06.dta, replace;



***************************************
*** Create rwhrbf_a06_with_1obs_for_1hh
***************************************;

forvalues v=1(1)9 {;
	gen a6_11_`v'_2=.;
	replace a6_11_`v'_2=a6_11 if a6b_seq==`v';
	gen a6_12_`v'_2=.;
	replace a6_12_`v'_2=a6_12 if a6b_seq==`v';
	gen a6_13_`v'_2=.;
	replace a6_13_`v'_2=a6_13 if a6b_seq==`v';
	by hrbf_id1 hrbf_id2: egen a6_11_`v'=min(a6_11_`v'_2);
	by hrbf_id1 hrbf_id2: egen a6_12_`v'=min(a6_12_`v'_2);
	by hrbf_id1 hrbf_id2: egen a6_13_`v'=min(a6_13_`v'_2);
	drop a6_11_`v'_2 a6_12_`v'_2 a6_13_`v'_2;
};

drop a6b_seq a6b_txt a6_11 a6_12 a6_13;

lab var a6_11_1 "Nr cattle";
lab var a6_12_1 "Original value cattle RWF";
lab var a6_13_1 "Todays value cattle RWF";
lab var a6_11_2 "Nr goat";
lab var a6_12_2 "Original value goat RWF";
lab var a6_13_2 "Todays value goat RWF";
lab var a6_11_3 "Nr sheep";
lab var a6_12_3 "Original value sheep RWF";
lab var a6_13_3 "Todays value sheep RWF";
lab var a6_11_4 "Nr pig";
lab var a6_12_4 "Original value pig RWF";
lab var a6_13_4 "Todays value pig RWF";
lab var a6_11_5 "Nr chicken";
lab var a6_12_5 "Original value chicken RWF";
lab var a6_13_5 "Todays value chicken RWF";
lab var a6_11_6 "Nr turkey";
lab var a6_12_6 "Original value turkey RWF";
lab var a6_13_6 "Todays value turkey RWF";
lab var a6_11_7 "Nr donkey/horse";
lab var a6_12_7 "Original value donkey/horse RWF";
lab var a6_13_7 "Todays value donkey/horse RWF";
lab var a6_11_8 "Nr oxen";
lab var a6_12_8 "Original value oxen RWF";
lab var a6_13_8 "Todays value oxen RWF";
lab var a6_11_9 "Nr other";
lab var a6_12_9 "Original value other RWF";
lab var a6_13_9 "Todays value other RWF";

sort hrbf_id1 hrbf_id2;
by hrbf_id1 hrbf_id2: keep if _n==1;
sort hrbf_id1 hrbf_id2;
save $cleandatadir/rwhrbf_a06_with_1obs_for_1hh.dta, replace;



******************************************************
*** Create rwhrbf_a06_with_1obs_for_1hh_with_studyarms
******************************************************;

use $cleandatadir/rwhrbf_a00_withstudyarms.dta, clear;
merge hrbf_id1 hrbf_id2 using $cleandatadir/rwhrbf_a06_with_1obs_for_1hh.dta, unique;
tab _merge;
list hrbf_id1 hrbf_id2 if _merge==2;
drop if _merge==2;
drop _merge;
save $cleandatadir/rwhrbf_a06_with_1obs_for_1hh_withstudyarms.dta, replace;


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

egen a6_12_100=rowtotal(a6_12_1 a6_12_2 a6_12_3 a6_12_4 a6_12_5 a6_12_6 a6_12_7 a6_12_8 a6_12_9);
lab var a6_12_100 "Original value animals RWF";

egen a6_13_100=rowtotal(a6_13_1 a6_13_2 a6_13_3 a6_13_4 a6_13_5 a6_13_6 a6_13_7 a6_13_8 a6_13_9);
lab var a6_13_100 "Current value animals RWF";

gen a6_13_101=a6_12_100>a6_13_100 & a6_12_100!=. & a6_12_100!=.;
lab var a6_13_101 "Animals value decreased";

gen a6_13_102=a6_12_100<a6_13_100 & a6_12_100!=. & a6_12_100!=.;
lab var a6_13_102 "Animals value increased";

gen a6_13_103=a6_13_100-a6_12_100 if a6_12_100<a6_13_100 & a6_12_100!=. & a6_12_100!=.;
lab var a6_13_103 "Increase in animals value";

gen a6_13_104=a6_12_100-a6_13_100 if a6_12_100>a6_13_100 & a6_12_100!=. & a6_12_100!=.;
lab var a6_13_104 "Decrease in animals value";

svyset [pweight=hhpweight], psu(hrbf_id1);
save $cleandatadir/rwhrbf_a06_with_1obs_for_1hh_withstudyarms_withvarformeantests.dta, replace;

log close;



