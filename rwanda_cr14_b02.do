* Elisa Rothenbuhler - Sep 10

* This do-file:
* Creates clean female b02 dataset: $cleandatadir/rwhrbf_b02.dta.
* Merges $cleandatadir/rwhrbf_b02.dta with household roster.
* Generates appropriate variables for mean tests.


version 10.0
clear
set more off
set mem 500m
cap log close

#delimit ;

log using $logdir/rwanda_cr14_b02.log, replace;



*********************
*** Clean b02 section
*********************;

use $origdatadir/RWHRBF_B_FEMALE-02.dta, clear;
drop if b11_01a==. & b11_01b==. & b11_01c==. & b11_01d==. & b11_02==. & b11_03==. & b11_04==.;
duplicates tag hrbf_id1 hrbf_id2 b11_pid, gen(dupl);
list hrbf_id1 hrbf_id2 b11_pid if dupl!=0;
bysort hrbf_id1 hrbf_id2: replace b11_pid=2 if hrbf_id1==182 & hrbf_id2==2 & _n==1;
bysort hrbf_id1 hrbf_id2: replace b11_pid=5 if hrbf_id1==182 & hrbf_id2==2 & _n==_N;
drop dupl;
duplicates report hrbf_id1 hrbf_id2 b11_pid;

sort hrbf_id1 hrbf_id2 b11_pid;
save $cleandatadir/rwhrbf_b02.dta, replace;



************************************
*** Create rwhrbf_b02_with_studyarms
************************************;

ren b11_pid a1_pid;
save $tempdatadir/rwhrbf_b02.dta, replace;

use $cleandatadir/rwhrbf_household_roster.dta, clear;
merge hrbf_id1 hrbf_id2 a1_pid using $tempdatadir/rwhrbf_b02.dta, unique;
tab _merge;
list hrbf_id1 hrbf_id2 a1_pid a1_02 if _merge==2;
drop if _merge==2;
drop _merge;
save $cleandatadir/rwhrbf_b02_withstudyarms.dta, replace;



*********************************************
*** Create necessary variables for mean tests
*********************************************;

forvalues v=1(1)3 {;
	gen b11_01a_`v'=b11_01a==`v';
	replace b11_01a_`v'=. if b11_01a==.;
};
lab var b11_01a_1 "Slowed down often";
lab var b11_01a_2 "Slowed down sometimes";
lab var b11_01a_3 "Slowed down never";

forvalues v=1(1)3 {;
	gen b11_01b_`v'=b11_01b==`v';
	replace b11_01b_`v'=. if b11_01b==.;
};
lab var b11_01b_1 "Deep sadness often";
lab var b11_01b_2 "Deep sadness sometimes";
lab var b11_01b_3 "Deep sadness never";

forvalues v=1(1)3 {;
	gen b11_01c_`v'=b11_01c==`v';
	replace b11_01c_`v'=. if b11_01c==.;
};
lab var b11_01c_1 "No longer enjoying often";
lab var b11_01c_2 "No longer enjoying sometimes";
lab var b11_01c_3 "No longer enjoying never";

forvalues v=1(1)3 {;
	gen b11_01d_`v'=b11_01d==`v';
	replace b11_01d_`v'=. if b11_01d==.;
};
lab var b11_01d_1 "Felt hopeless often";
lab var b11_01d_2 "Felt hopeless sometimes";
lab var b11_01d_3 "Felt hopeless never";

gen b11_02_1=b11_02==1;
replace b11_02_1=. if b11_02==.;
lab var b11_02_1 "Treated/counseled for depression";

forvalues v=1(1)11 {;
	gen b11_03_`v'=b11_03==`v';
	replace b11_03_`v'=. if b11_03==.;
};
gen b11_03_96=b11_03==96;
replace b11_03_96=. if b11_03==.;
lab var b11_03_1 "Treated govt hosp";
lab var b11_03_2 "Treated govt clinic";
lab var b11_03_3 "Treated govt health post";
lab var b11_03_4 "Treated priv hosp";
lab var b11_03_5 "Treated priv clinic";
lab var b11_03_6 "Treated priv health post";
lab var b11_03_7 "Treated pharmacy";
lab var b11_03_8 "Treated medical staff";
lab var b11_03_9 "Treated trad healer";
lab var b11_03_10 "Treated church healer";
lab var b11_03_11 "Treated CHW";
lab var b11_03_96 "Treated other";

gen b11_04_1=b11_04==1;
replace b11_04_1=. if b11_04==.;
lab var b11_04_1 "Currently treated for depression";

svyset [pweight=hhpweight], psu(hrbf_id1);
save $cleandatadir/rwhrbf_b02_withstudyarms_withvarformeantests.dta, replace;




