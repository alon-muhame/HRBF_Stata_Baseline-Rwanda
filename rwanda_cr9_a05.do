* Elisa Rothenbuhler - Sep 10

* This do-file:
* Creates clean household a05 dataset: $cleandatadir/rwhrbf_a05.dta.
* Creates a05 dataset with only one observation per household: $cleandatadir/rwhrbf_a05_with_1obs_for_1hh.dta
* Merges $cleandatadir/rwhrbf_a05_with_1obs_for_1hh.dta with household-level dataset a00 to create a05 dataset with only one observation per household with study arms: $cleandatadir/rwhrbf_a05_with_1obs_for_1hh_withstudyarms.dta
* Creates appropriate variables for mean tests.

version 10.0
clear
set more off
set mem 500m
cap log close

#delimit ;

log using $logdir/rwanda_cr9_a05.log, replace;


****************************************************************
*** Clean a05 section (questionnaire section 6: Assets - part A)
****************************************************************;

use $origdatadir/RWHRBF_A_HOUSEHOLD-05.dta, clear;
duplicates report hrbf_id1 hrbf_id2 a6a_seq;
tab a6a_seq;
list if a6a_txt!="";
drop a6a_txt;
tab a6_01;
list a6a_seq  a6_01 a6_02 if a6_01>15 & a6_01!=.;
replace a6_01=0 if a6_01==60 & a6_02==0;
replace a6_01=0 if a6_01==20 & a6_02==0;
replace a6_01=0 if a6_01==70 & a6_02==0;
replace a6_02=. if a6a_seq==12 & a6_01==16 & a6_02==2;
replace a6_01=. if a6a_seq==12 & a6_01==16 & a6_02==.;
replace a6_02=. if a6a_seq==19 & a6_01==20 & a6_02==2500;
replace a6_01=. if a6a_seq==19 & a6_01==20 & a6_02==.;
replace a6_02=. if a6a_seq==6 & a6_01==50 & a6_02==1;
replace a6_01=. if a6a_seq==6 & a6_01==50 & a6_02==.;

list a6a_seq  a6_01 a6_02 if a6_02>300000 & a6_02!=.;
replace a6_02=. if a6a_seq==14 & a6_01==1 & a6_02==400000;
replace a6_02=. if a6a_seq==14 & a6_01==2 & a6_02==460000;
replace a6_02=. if a6a_seq==14 & a6_01==1 & a6_02==2500000;
replace a6_02=. if a6a_seq==14 & a6_01==1 & a6_02==700000;

sort hrbf_id1 hrbf_id2;
save $cleandatadir/rwhrbf_a05.dta, replace;



***************************************
*** Create rwhrbf_a05_with_1obs_for_1hh
***************************************;

forvalues v=1(1)20 {;
	gen a6_01_`v'_2=.;
	replace a6_01_`v'_2=a6_01 if a6a_seq==`v';
	gen a6_02_`v'_2=.;
	replace a6_02_`v'_2=a6_02 if a6a_seq==`v';
	by hrbf_id1 hrbf_id2: egen a6_01_`v'=min(a6_01_`v'_2);
	by hrbf_id1 hrbf_id2: egen a6_02_`v'=min(a6_02_`v'_2);
	drop a6_01_`v'_2 a6_02_`v'_2;
};
drop a6a_seq a6_01 a6_02;

lab var a6_01_1 "Nr media player";
lab var a6_02_1 "Value media player RWF";
lab var a6_01_2 "Nr TV";
lab var a6_02_2 "Value TV RWF";
lab var a6_01_3 "Nr iron";
lab var a6_02_3 "Value iron RWF";
lab var a6_01_4 "Nr elect stove";
lab var a6_02_4 "Value elect stove RWF";
lab var a6_01_5 "Nr gas stove";
lab var a6_02_5 "Value gas stove RWF";
lab var a6_01_6 "Nr paraffin lamp";
lab var a6_02_6 "Value paraffin lamp RWF";
lab var a6_01_7 "Nr bed";
lab var a6_02_7 "Value bed RWF";
lab var a6_01_8 "Nr mattress";
lab var a6_02_8 "Value mattress RWF";
lab var a6_01_9 "Nr fridge";
lab var a6_02_9 "Value fridge RWF";
lab var a6_01_10 "Nr sewing machine";
lab var a6_02_10 "Value sewing machine RWF";
lab var a6_01_11 "Nr table";
lab var a6_02_11 "Value table RWF";
lab var a6_01_12 "Nr sofa";
lab var a6_02_12 "Value sofa RWF";
lab var a6_01_13 "Nr land phone";
lab var a6_02_13 "Value land phone RWF";
lab var a6_01_14 "Nr cell phone";
lab var a6_02_14 "Value cell phone RWF";
lab var a6_01_15 "Nr motorcycle";
lab var a6_02_15 "Value motorcycle RWF";
lab var a6_01_16 "Nr bicycle";
lab var a6_02_16 "Value bicycle RWF";
lab var a6_01_17 "Nr truck/car";
lab var a6_02_17 "Value truck/car RWF";
lab var a6_01_18 "Nr wheelbarrow";
lab var a6_02_18 "Value wheelbarrow RWF";
lab var a6_01_19 "Nr plough";
lab var a6_02_19 "Value plough RWF";
lab var a6_01_20 "Nr hoes/axes";
lab var a6_02_20 "Value hoes/axes RWF";

bysort hrbf_id1 hrbf_id2: keep if _n==1;
sort hrbf_id1 hrbf_id2;
save $cleandatadir/rwhrbf_a05_with_1obs_for_1hh.dta, replace;



******************************************************
*** Create rwhrbf_a05_with_1obs_for_1hh_with_studyarms
******************************************************;

use $cleandatadir/rwhrbf_a00_withstudyarms.dta, clear;
merge hrbf_id1 hrbf_id2 using $cleandatadir/rwhrbf_a05_with_1obs_for_1hh.dta, unique;
tab _merge;
list hrbf_id1 hrbf_id2 if _merge==2;
drop if _merge==2;
drop _merge;
save $cleandatadir/rwhrbf_a05_with_1obs_for_1hh_withstudyarms.dta, replace;



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

egen a6_02_100=rowtotal(a6_02_1 a6_02_2 a6_02_3 a6_02_4 a6_02_5 a6_02_6 a6_02_7 a6_02_8 a6_02_9 a6_02_10 a6_02_11 a6_02_12 a6_02_13 a6_02_14 a6_02_15 a6_02_16 a6_02_17 a6_02_18 a6_02_19 a6_02_20);
lab var a6_02_100 "Value material assets RWF";

svyset [pweight=hhpweight], psu(hrbf_id1);
save $cleandatadir/rwhrbf_a05_with_1obs_for_1hh_withstudyarms_withvarformeantests.dta, replace;

log close;


