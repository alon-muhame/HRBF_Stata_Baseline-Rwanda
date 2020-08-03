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

log using $logdir/rwanda_cr12_a08.log, replace;


****************************************************
*** Clean a08 section (Section 9 from questionnaire)
****************************************************;

use $origdatadir/RWHRBF_A_HOUSEHOLD-08.dta, clear;

drop if a9_seq==. | (a9_04m==. & a9_04y==. & a9_05==. & a9_06n==. & a9_06c==. & a9_07==. & a9_08==. & a9_09==.);
tab a9_04m;
replace a9_04m=12 if a9_04m==13;
tab a9_04y;
replace a9_04y=2010 if a9_04y==210;
replace a9_04y=. if a9_04y<30;
tab a9_06n a9_06c;
replace a9_06c=. if a9_06c==4;

sort hrbf_id1 hrbf_id2 a9_seq;
save $cleandatadir/rwhrbf_a08.dta, replace;



***************************************
*** Create rwhrbf_a08_with_1obs_for_1hh
***************************************;

sum a9_seq;
forvalues v=1(1)`r(max)' {;
	gen a9_04m_`v'_2=.;
	replace a9_04m_`v'_2=a9_04m if a9_seq==`v';
	by hrbf_id1 hrbf_id2: egen a9_04m_`v'=min(a9_04m_`v'_2);
	drop a9_04m_`v'_2;
	gen a9_04y_`v'_2=.;
	replace a9_04y_`v'_2=a9_04y if a9_seq==`v';
	by hrbf_id1 hrbf_id2: egen a9_04y_`v'=min(a9_04y_`v'_2);
	drop a9_04y_`v'_2;
	gen a9_05_`v'_2=.;
	replace a9_05_`v'_2=a9_05 if a9_seq==`v';
	by hrbf_id1 hrbf_id2: egen a9_05_`v'=min(a9_05_`v'_2);
	drop a9_05_`v'_2;
	gen a9_06n_`v'_2=.;
	replace a9_06n_`v'_2=a9_06n if a9_seq==`v';
	by hrbf_id1 hrbf_id2: egen a9_06n_`v'=min(a9_06n_`v'_2);
	drop a9_06n_`v'_2;
	gen a9_06c_`v'_2=.;
	replace a9_06c_`v'_2=a9_06c if a9_seq==`v';
	by hrbf_id1 hrbf_id2: egen a9_06c_`v'=min(a9_06c_`v'_2);
	drop a9_06c_`v'_2;
	gen a9_07_`v'_2=.;
	replace a9_07_`v'_2=a9_07 if a9_seq==`v';
	by hrbf_id1 hrbf_id2: egen a9_07_`v'=min(a9_07_`v'_2);
	drop a9_07_`v'_2;
	gen a9_08_`v'_2=.;
	replace a9_08_`v'_2=a9_08 if a9_seq==`v';
	by hrbf_id1 hrbf_id2: egen a9_08_`v'=min(a9_08_`v'_2);
	drop a9_08_`v'_2;
	gen a9_09_`v'_2=.;
	replace a9_09_`v'_2=a9_09 if a9_seq==`v';
	by hrbf_id1 hrbf_id2: egen a9_09_`v'=min(a9_09_`v'_2);
	drop a9_09_`v'_2;
};
drop a9_seq a9_04m a9_04y a9_05 a9_06n a9_06c a9_07 a9_08 a9_09;

lab var a9_04m_1 "Month of death 1";
lab var a9_04m_2 "Month of death 2";
lab var a9_04m_3 "Month of death 3";
lab var a9_04m_4 "Month of death 4";
lab var a9_04y_1 "Year of death 1";
lab var a9_04y_2 "Year of death 2";
lab var a9_04y_3 "Year of death 3";
lab var a9_04y_4 "Year of death 4";
lab var a9_05_1 "Gender deceased 1";
lab var a9_05_2 "Gender deceased 2";
lab var a9_05_3 "Gender deceased 3";
lab var a9_05_4 "Gender deceased 4";
lab var a9_06n_1 "Age(nr) deceased 1";
lab var a9_06n_2 "Age(nr) deceased 2";
lab var a9_06n_3 "Age(nr) deceased 3";
lab var a9_06n_4 "Age(nr) deceased 4";
lab var a9_06c_1 "Age(code) deceased 1";
lab var a9_06c_2 "Age(code) deceased 2";
lab var a9_06c_3 "Age(code) deceased 3";
lab var a9_06c_4 "Age(code) deceased 4";
lab var a9_07_1 "Cause of death 1";
lab var a9_07_2 "Cause of death 2";
lab var a9_07_3 "Cause of death 3";
lab var a9_07_4 "Cause of death 4";
lab var a9_08_1 "Place of death 1";
lab var a9_08_2 "Place of death 2";
lab var a9_08_3 "Place of death 3";
lab var a9_08_4 "Place of death 4";
lab var a9_09_1 "Relation to head deceased 1";
lab var a9_09_2 "Relation to head deceased 2";
lab var a9_09_3 "Relation to head deceased 3";
lab var a9_09_4 "Relation to head deceased 4";

sort hrbf_id1 hrbf_id2;
by hrbf_id1 hrbf_id2: keep if _n==1;
sort hrbf_id1 hrbf_id2;
save $cleandatadir/rwhrbf_a08_with_1obs_for_1hh.dta, replace;



******************************************************
*** Create rwhrbf_a08_with_1obs_for_1hh_with_studyarms
******************************************************;

use $cleandatadir/rwhrbf_a00_withstudyarms.dta, clear;
merge hrbf_id1 hrbf_id2 using $cleandatadir/rwhrbf_a08_with_1obs_for_1hh.dta, unique;
tab _merge;
list hrbf_id1 hrbf_id2 if _merge==2;
drop if _merge==2;
drop _merge;
save $cleandatadir/rwhrbf_a08_with_1obs_for_1hh_withstudyarms.dta, replace;


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

gen a9_05_1_1=a9_05_1==2;
replace a9_05_1_1=. if a9_05_1==.;
lab var a9_05_1_1 "Most recent death:female";

gen a9_05_2_1=a9_05_2==2;
replace a9_05_2_1=. if a9_05_2==.;
lab var a9_05_2_1 "2nd death:female";

gen a9_05_3_1=a9_05_3==2;
replace a9_05_3_1=. if a9_05_3==.;
lab var a9_05_3_1 "3rd death:female";

gen a9_05_4_1=a9_05_4==2;
replace a9_05_4_1=. if a9_05_4==.;
lab var a9_05_4_1 "4th death:female";

gen a9_06n_1_1=a9_06n_1;
replace a9_06n_1_1=a9_06n_1/365 if a9_06c_1==1;
replace a9_06n_1_1=a9_06n_1/12 if a9_06c_1==2;
lab var a9_06n_1_1 "Most recent death:age yrs";

gen a9_06n_2_1=a9_06n_2;
replace a9_06n_2_1=a9_06n_2/365 if a9_06c_2==1;
replace a9_06n_2_1=a9_06n_2/12 if a9_06c_2==2;
lab var a9_06n_2_1 "2nd death:age yrs";

gen a9_06n_3_1=a9_06n_3;
replace a9_06n_3_1=a9_06n_3/365 if a9_06c_3==1;
replace a9_06n_3_1=a9_06n_3/12 if a9_06c_3==2;
lab var a9_06n_3_1 "3rd death:age yrs";

gen a9_06n_4_1=a9_06n_1;
replace a9_06n_4_1=a9_06n_4/365 if a9_06c_4==1;
replace a9_06n_4_1=a9_06n_4/12 if a9_06c_4==2;
lab var a9_06n_4_1 "4th death:age yrs";

gen a9_06n_1_2=a9_06n_1_1*12 if a9_06n_1_1<5;
lab var a9_06n_1_2 "Recent death:age mths for<5";

gen a9_06n_2_2=a9_06n_2_1*12 if a9_06n_2_1<5;
lab var a9_06n_2_2 "2nd death:age mths for <5";

gen a9_06n_3_2=a9_06n_3_1*12 if a9_06n_3_1<5;
lab var a9_06n_3_2 "3rd death:age mths for <5";

gen a9_06n_4_2=a9_06n_4_1*12 if a9_06n_4_1<5;
lab var a9_06n_4_2 "4th death:age mths for <5";

forvalues v=1(1)17 {;
	gen a9_07_1_`v'=a9_07_1==`v';
	replace a9_07_1_`v'=. if a9_07_1==.;
};
gen a9_07_1_96=a9_07_1==96;
replace a9_07_1_96=. if a9_07_1==.;
lab var a9_07_1_1 "Most recent death:birth trauma";
lab var a9_07_1_2 "Most recent death:congenital";
lab var a9_07_1_3 "Most recent death:sickle cell";
lab var a9_07_1_4 "Most recent death:measles";
lab var a9_07_1_5 "Most recent death:malaria";
lab var a9_07_1_6 "Most recent death:malnutrition";
lab var a9_07_1_7 "Most recent death:diarrhea";
lab var a9_07_1_8 "Most recent death:pneumonia";
lab var a9_07_1_9 "Most recent death:TB";
lab var a9_07_1_10 "Most recent death:AIDS";
lab var a9_07_1_11 "Most recent death:accident";
lab var a9_07_1_12 "Most recent death:violence";
lab var a9_07_1_13 "Most recent death:stroke";
lab var a9_07_1_14 "Most recent death:cancer";
lab var a9_07_1_15 "Most recent death:heart disease";
lab var a9_07_1_16 "Most recent death:old age";
lab var a9_07_1_17 "Most recent death:unknown";
lab var a9_07_1_96 "Most recent death:other";

forvalues v=1(1)17 {;
	gen a9_07_2_`v'=a9_07_2==`v';
	replace a9_07_2_`v'=. if a9_07_2==.;
};
gen a9_07_2_96=a9_07_2==96;
replace a9_07_2_96=. if a9_07_2==.;
lab var a9_07_2_1 "2nd death:birth trauma";
lab var a9_07_2_2 "2nd death:congenital";
lab var a9_07_2_3 "2nd death:sickle cell";
lab var a9_07_2_4 "2nd death:measles";
lab var a9_07_2_5 "2nd death:malaria";
lab var a9_07_2_6 "2nd death:malnutrition";
lab var a9_07_2_7 "2nd death:diarrhea";
lab var a9_07_2_8 "2nd death:pneumonia";
lab var a9_07_2_9 "2nd death:TB";
lab var a9_07_2_10 "2nd death:AIDS";
lab var a9_07_2_11 "2nd death:accident";
lab var a9_07_2_12 "2nd death:violence";
lab var a9_07_2_13 "2nd death:stroke";
lab var a9_07_2_14 "2nd death:cancer";
lab var a9_07_2_15 "2nd death:heart disease";
lab var a9_07_2_16 "2nd death:old age";
lab var a9_07_2_17 "2nd death:unknown";
lab var a9_07_2_96 "2nd death:other";

forvalues v=1(1)17 {;
	gen a9_07_3_`v'=a9_07_3==`v';
	replace a9_07_3_`v'=. if a9_07_3==.;
};
gen a9_07_3_96=a9_07_3==96;
replace a9_07_3_96=. if a9_07_3==.;
lab var a9_07_3_1 "3rd death:birth trauma";
lab var a9_07_3_2 "3rd death:congenital";
lab var a9_07_3_3 "3rd death:sickle cell";
lab var a9_07_3_4 "3rd death:measles";
lab var a9_07_3_5 "3rd death:malaria";
lab var a9_07_3_6 "3rd death:malnutrition";
lab var a9_07_3_7 "3rd death:diarrhea";
lab var a9_07_3_8 "3rd death:pneumonia";
lab var a9_07_3_9 "3rd death:TB";
lab var a9_07_3_10 "3rd death:AIDS";
lab var a9_07_3_11 "3rd death:accident";
lab var a9_07_3_12 "3rd death:violence";
lab var a9_07_3_13 "3rd death:stroke";
lab var a9_07_3_14 "3rd death:cancer";
lab var a9_07_3_15 "3rd death:heart disease";
lab var a9_07_3_16 "3rd death:old age";
lab var a9_07_3_17 "3rd death:unknown";
lab var a9_07_3_96 "3rd death:other";

forvalues v=1(1)17 {;
	gen a9_07_4_`v'=a9_07_4==`v';
	replace a9_07_4_`v'=. if a9_07_4==.;
};
gen a9_07_4_96=a9_07_4==96;
replace a9_07_4_96=. if a9_07_4==.;
lab var a9_07_4_1 "4th death:birth trauma";
lab var a9_07_4_2 "4th death:congenital";
lab var a9_07_4_3 "4th death:sickle cell";
lab var a9_07_4_4 "4th death:measles";
lab var a9_07_4_5 "4th death:malaria";
lab var a9_07_4_6 "4th death:malnutrition";
lab var a9_07_4_7 "4th death:diarrhea";
lab var a9_07_4_8 "4th death:pneumonia";
lab var a9_07_4_9 "4th death:TB";
lab var a9_07_4_10 "4th death:AIDS";
lab var a9_07_4_11 "4th death:accident";
lab var a9_07_4_12 "4th death:violence";
lab var a9_07_4_13 "4th death:stroke";
lab var a9_07_4_14 "4th death:cancer";
lab var a9_07_4_15 "4th death:heart disease";
lab var a9_07_4_16 "4th death:old age";
lab var a9_07_4_17 "4th death:unknown";
lab var a9_07_4_96 "4th death:other";

forvalues v=1(1)5 {;
	gen a9_08_1_`v'=a9_08_1==`v';
	replace a9_08_1_`v'=. if a9_08_1==.;
};
gen a9_08_1_96=a9_08_1==96;
replace a9_08_1_96=. if a9_08_1==.;
lab var a9_08_1_1 "Most recent death at home";
lab var a9_08_1_2 "Most recent death at relatives";
lab var a9_08_1_3 "Most recent death in street";
lab var a9_08_1_4 "Most recent death in health fac";
lab var a9_08_1_5 "Most recent death in hospital";
lab var a9_08_1_96 "Most recent death in other";

forvalues v=1(1)5 {;
	gen a9_08_2_`v'=a9_08_2==`v';
	replace a9_08_2_`v'=. if a9_08_2==.;
};
gen a9_08_2_96=a9_08_2==96;
replace a9_08_2_96=. if a9_08_2==.;
lab var a9_08_2_1 "2nd death at home";
lab var a9_08_2_2 "2nd death at relatives";
lab var a9_08_2_3 "2nd death in street";
lab var a9_08_2_4 "2nd death in health fac.";
lab var a9_08_2_5 "2nd death in hospital";
lab var a9_08_2_96 "2nd death in other";

forvalues v=1(1)5 {;
	gen a9_08_3_`v'=a9_08_3==`v';
	replace a9_08_3_`v'=. if a9_08_3==.;
};
gen a9_08_3_96=a9_08_3==96;
replace a9_08_3_96=. if a9_08_3==.;
lab var a9_08_3_1 "3rd death at home";
lab var a9_08_3_2 "3rd death at relatives";
lab var a9_08_3_3 "3rd death in street";
lab var a9_08_3_4 "3rd death in health fac.";
lab var a9_08_3_5 "3rd death in hospital";
lab var a9_08_3_96 "3rd death in other";

forvalues v=1(1)5 {;
	gen a9_08_4_`v'=a9_08_4==`v';
	replace a9_08_4_`v'=. if a9_08_4==.;
};
gen a9_08_4_96=a9_08_4==96;
replace a9_08_4_96=. if a9_08_4==.;
lab var a9_08_4_1 "4th death at home";
lab var a9_08_4_2 "4th death at relatives";
lab var a9_08_4_3 "4th death in street";
lab var a9_08_4_4 "4th death in health fac.";
lab var a9_08_4_5 "4th death in hospital";
lab var a9_08_4_96 "4th death in other";

svyset [pweight=hhpweight], psu(hrbf_id1);
save $cleandatadir/rwhrbf_a08_with_1obs_for_1hh_withstudyarms_withvarformeantests.dta, replace;
 
log close;











