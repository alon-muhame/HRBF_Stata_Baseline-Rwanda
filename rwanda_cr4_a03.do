* Elisa Rothenbuhler - Aug 10

* This do-file:
* Creates clean household a03 dataset: $cleandatadir/rwhrbf_a03.dta.
* Merges $cleandatadir/rwhrbf_a03.dta with household roster.
* Generates appropriate variables for mean tests.

version 10.0
clear
set more off
set mem 500m
cap log close

#delimit ;

log using $logdir/rwanda_cr4_a03.log, replace;


*********************
*** Clean a03 section
*********************;

use $origdatadir/RWHRBF_A_HOUSEHOLD-03.dta, clear;

drop if a3_01==. & a3_02==. & a3_03==. & a3_04a==. & a3_04b==. & a3_05a==. & a3_05b==. & a3_06a==. & a3_06b==. & a3_07a==. & a3_07b==. & a3_08==. & a3_09==. & a3_10==. & a3_11a==. & a3_11b==. & a3_12a==. & a3_12b==. & a3_13a==. & a3_13b==. & a3_14a==. & a3_14b==. & a3_15==. & a3_16==. & a3_17==. & a3_18a==. & a3_18b==.;
* assert a3_pid!=.;
list hrbf_id1 hrbf_id2 a3_pid if a3_pid==.;

***
*** 2 missing a3_pid in household 176-6
***;

drop if a3_pid==.;
duplicates report hrbf_id1 hrbf_id2 a3_pid;

replace a3_01=96 if a3_01==0;
replace a3_03=96 if a3_03==0;
replace a3_03=1 if a3_03==11;
replace a3_04b=. if a3_04b==0;
assert a3_06a<=7 | a3_06a==.;
assert a3_06b<=24 | a3_06b==.;
assert a3_07a<=7 | a3_07a==.;
assert a3_07b<=24 | a3_07b==.;
replace a3_08=96 if a3_08==0;
assert a3_09<=12 | a3_09==.;
replace a3_12a=. if a3_12a==4;
assert a3_13a<=7 | a3_13a==.;
assert a3_13b<=24 | a3_13b==.;
* assert a3_14a<=7 | a3_14a==.;
list a3_14a if a3_14a>7 & a3_14a!=.;
replace a3_14a=3 if a3_14a==9;
assert a3_14b<=24 | a3_14b==.;
replace a3_15=. if a3_15==0;
assert a3_16<=12 | a3_16==.;

sort hrbf_id1 hrbf_id2 a3_pid;
save $cleandatadir/rwhrbf_a03.dta, replace;



************************************
*** Create rwhrbf_a03_with_studyarms
************************************;

ren a3_pid a1_pid;
save $tempdatadir/rwhrbf_a03.dta, replace;

use $cleandatadir/rwhrbf_household_roster.dta, clear;
merge hrbf_id1 hrbf_id2 a1_pid using $tempdatadir/rwhrbf_a03.dta, unique;
tab _merge;
list hrbf_id1 hrbf_id2 a1_pid a1_02 if _merge==2;
drop if _merge==2;
drop _merge;
save $cleandatadir/rwhrbf_a03_withstudyarms.dta, replace;



*********************************************
*** Create necessary variables for mean tests
*********************************************;

forvalues v=1(1)12 {;
	gen a3_01_`v'=a3_01==`v';
	replace a3_01_`v'=. if a3_01==.;
};
gen a3_01_96=a3_01==96;
replace a3_01_96=. if a3_01==.;
lab var a3_01_1 "Wage employment";
lab var a3_01_2 "Self employed";
lab var a3_01_3 "Agriculture";
lab var a3_01_4 "Piecework";
lab var a3_01_5 "Unpaid family worker";
lab var a3_01_6 "Looking for work";
lab var a3_01_7 "Capable not looking";
lab var a3_01_8 "Full time student";
lab var a3_01_9 "Homemaker";
lab var a3_01_10 "Retired";
lab var a3_01_11 "Too old to work";
lab var a3_01_12 "Too sick to work";
lab var a3_01_96 "Other act";

gen a3_01_101=a3_01==1;
gen a3_01_102=a3_01==2;
gen a3_01_103=a3_01==3;
gen a3_01_104=a3_01==4;
gen a3_01_105=a3_01!=1 & a3_01!=2 & a3_01!=3 & a3_01!=4;
forvalues v=1(1)5 {;
	replace a3_01_10`v'=. if a3_01==.;
};
lab var a3_01_101 "Wage employment";
lab var a3_01_102 "Self employed";
lab var a3_01_103 "Agriculture";
lab var a3_01_104 "Piecework";
lab var a3_01_105 "Other activity";

gen a3_01_106=a3_01<4 | a3_01==6;
replace a3_01_106=. if a3_01==.;
lab var a3_01_106 "In labor market";

gen a3_01_107=a3_01<4;
replace a3_01_107=. if a3_01==.;
lab var a3_01_107 "Employed in labor market";

gen a3_02_1=a3_02==1;
replace a3_02_1=. if a3_02==.;
lab var a3_02_1 "Helped family earn income";

forvalues v=1(1)7 {;
	gen a3_03_`v'=a3_03==`v';
	replace a3_03_`v'=. if a3_03==.;
};
gen a3_03_96=a3_03==96;
replace a3_03_96=. if a3_03==.;
lab var a3_03_1 "Employer:self";
lab var a3_03_2 "Employer:Family";
lab var a3_03_3 "Employer:Private";
lab var a3_03_4 "Employer:Public";
lab var a3_03_5 "Employer:NGO";
lab var a3_03_6 "Day laborer";
lab var a3_03_7 "Worker with no pay";
lab var a3_03_96 "Employer:other";

gen a3_04_1=.;
lab var a3_04_1 "Prim:Daily pay RWF";
replace a3_04_1=a3_04a if a3_04b==1;
replace a3_04_1=a3_04a/7 if a3_04b==2;
replace a3_04_1=a3_04a/14 if a3_04b==3;
replace a3_04_1=a3_04a/30.5 if a3_04b==4;
replace a3_04_1=a3_04a/365 if a3_04b==5;

gen a3_05a_1=a3_05a==1;
replace a3_05a_1=. if a3_05a==.;
lab var a3_05a_1 "Prim:Got insurance in 12m";

gen a3_05b_1=a3_05b==1;
replace a3_05b_1=. if a3_05b==.;
lab var a3_05b_1 "Prim:Got sick leave in 12m";

gen a3_06_1=a3_06a*a3_06b;
replace a3_06_1=. if a3_06a==. | a3_06b==.;
lab var a3_06_1 "Prim:Weekly hrs in 12m";

gen a3_07_1=a3_07a*a3_07b;
replace a3_07_1=. if a3_07a==. | a3_07b==.;
lab var a3_07_1 "Prim:Weekly hrs in 7d";

gen a3_07_2=a3_07_1<a3_06_1;
replace a3_07_2=. if a3_07_1==. | a3_06_1==.;
lab var a3_07_2 "Prim:Worked less in 7d vs 12m ";

forval v=1(1)5 {;
	gen a3_08_`v'=a3_08==`v';
	replace a3_08_`v'=. if a3_08==.;
};
gen a3_08_96=a3_08==96;
replace a3_08_96=. if a3_08==.;
lab var a3_08_1 "Less work bc holidays";
lab var a3_08_2 "Less work bc illness";
lab var a3_08_3 "Less work bc injury";
lab var a3_08_4 "Less work bc care for sick";
lab var a3_08_5 "Less work bc seasonal work";
lab var a3_08_96 "Less work bc other reason";

gen a3_08_101=a3_08==2 | a3_08==3;
replace a3_08_101=. if a3_08==.;
lab var a3_08_101 "Less work bc illness (self/fam)";

gen a3_10_1=a3_10==1;
replace a3_10_1=. if a3_10==.;
lab var a3_10_1 "Had secondary act in 12m";

gen a3_11_1=.;
lab var a3_11_1 "Sec:Daily pay RWF";
replace a3_11_1=a3_11a if a3_11b==1;
replace a3_11_1=a3_11a/7 if a3_11b==2;
replace a3_11_1=a3_11a/14 if a3_11b==3;
replace a3_11_1=a3_11a/30.5 if a3_11b==4;
replace a3_11_1=a3_11a/365 if a3_11b==5;

gen a3_12a_1=a3_12a==1;
replace a3_12a_1=. if a3_12a==.;
lab var a3_12a_1 "Sec:Got insurance in 12m";

gen a3_12b_1=a3_12b==1;
replace a3_12b_1=. if a3_12b==.;
lab var a3_12b_1 "Sec:Got sick leave in 12m";

gen a3_13_1=a3_13a*a3_13b;
replace a3_13_1=. if a3_13a==. | a3_13b==.;
lab var a3_13_1 "Sec:Weekly hrs in 12m";

gen a3_14_1=a3_14a*a3_14b;
replace a3_14_1=. if a3_14a==. | a3_14b==.;
lab var a3_14_1 "Sec:Weekly hrs in 7d";

gen a3_14_2=a3_14_1<a3_13_1;
replace a3_14_2=. if a3_14_1==. | a3_13_1==.;
lab var a3_14_2 "Sec:Worked less in 7d vs 12m ";

forval v=1(1)5 {;
	gen a3_15_`v'=a3_15==`v';
	replace a3_15_`v'=. if a3_15==.;
};
gen a3_15_96=a3_15==96;
replace a3_15_96=. if a3_15==.;
lab var a3_15_1 "Less work bc holidays";
lab var a3_15_2 "Less work bc illness";
lab var a3_15_3 "Less work bc injury";
lab var a3_15_4 "Less work bc care for sick";
lab var a3_15_5 "Less work bc seasonal work";
lab var a3_15_96 "Less work bc other reason";

gen a3_15_101=a3_15==2 | a3_15==3;
replace a3_15_101=. if a3_15==.;
lab var a3_15_101 "Less work bc illness (self/fam)";

gen a3_17_1=a3_17==1;
replace a3_17_1=. if a3_17==.;
lab var a3_17_1 "Had other income in 12m";

gen a3_18_1=.;
lab var a3_18_1 "Other income RWF";
replace a3_18_1=a3_18a if a3_18b==1;
replace a3_18_1=a3_18a/7 if a3_18b==2;
replace a3_18_1=a3_18a/14 if a3_18b==3;
replace a3_18_1=a3_18a/30.5 if a3_18b==4;
replace a3_18_1=a3_18a/365 if a3_18b==5;

svyset [pweight=hhpweight], psu(hrbf_id1);
save $cleandatadir/rwhrbf_a03_withstudyarms_withvarformeantests.dta, replace;

log close;






