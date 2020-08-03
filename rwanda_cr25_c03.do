* Elisa Rothenbuhler - Nov 10

* This do-file:
* Creates clean child c03 dataset: $cleandatadir/rwhrbf_c03.dta.
* Merges $cleandatadir/rwhrbf_c03.dta with household roster.
* Generates appropriate variables for mean tests.


version 10.0
clear
set more off
set mem 500m
cap log close

#delimit ;

log using $logdir/rwanda_cr25_c03.log, replace;



*********************
*** Clean c03 section
*********************;

use $origdatadir/RWHRBF_C_CHILD-03.dta, clear;

drop if c15b_seq==. & c15b_pid==. & c15_06==. & c15_07==. & c15_08==. & c15_09==. & c15_10==. & c15_11==. & c15_12==. & c15_13==. & c15_14==. & c15_15==. & c15_16==. & c15_17==. & c15_18==. & c15_19==. & c15_20==. & c15_21==. & c15_22==. & c15_23==.;

duplicates tag hrbf_id1 hrbf_id2 c15b_pid, gen(dupl);
list hrbf_id1 hrbf_id2 c15b_pid dupl if dupl!=0;
list hrbf_id1 hrbf_id2 c15b_pid c15b_seq dupl if (hrbf_id1==30 & hrbf_id2==2) |  (hrbf_id1==51 & hrbf_id2==5) | (hrbf_id1==63 & hrbf_id2==12) |  (hrbf_id1==71 & hrbf_id2==1) |  (hrbf_id1==97 & hrbf_id2==6) |  (hrbf_id1==97 & hrbf_id2==9) |  (hrbf_id1==139 & hrbf_id2==12) |  (hrbf_id1==150 & hrbf_id2==12) |  (hrbf_id1==156 & hrbf_id2==3) |  (hrbf_id1==171 & hrbf_id2==10) |  (hrbf_id1==204 & hrbf_id2==11);
* use $cleandatadir/rwhrbf_household_roster.dta, clear;
* list hrbf_id1 hrbf_id2 a1_pid a1_11a a1_11b a1_15 if (hrbf_id1==30 & hrbf_id2==2) |  (hrbf_id1==51 & hrbf_id2==5) | (hrbf_id1==63 & hrbf_id2==12) |  (hrbf_id1==71 & hrbf_id2==1) |  (hrbf_id1==97 & hrbf_id2==6) |  (hrbf_id1==97 & hrbf_id2==9) |  (hrbf_id1==139 & hrbf_id2==12) |  (hrbf_id1==150 & hrbf_id2==12) |  (hrbf_id1==156 & hrbf_id2==3) |  (hrbf_id1==171 & hrbf_id2==10) |  (hrbf_id1==204 & hrbf_id2==11);
replace c15b_pid=4 if hrbf_id1==30 & hrbf_id2==2 & c15b_pid==2 & c15b_seq==1;
replace c15b_pid=3 if hrbf_id1==30 & hrbf_id2==2 & c15b_pid==2 & c15b_seq==2;
replace c15b_pid=8 if hrbf_id1==51 & hrbf_id2==5 & c15b_pid==2 & c15b_seq==1;
replace c15b_pid=7 if hrbf_id1==51 & hrbf_id2==5 & c15b_pid==2 & c15b_seq==2;
replace c15b_pid=3 if hrbf_id1==63 & hrbf_id2==12 & c15b_pid==4 & c15b_seq==1;
replace c15b_pid=2 if hrbf_id1==63 & hrbf_id2==12 & c15b_pid==4 & c15b_seq==2;
replace c15b_pid=5 if hrbf_id1==71 & hrbf_id2==1 & c15b_pid==4 & c15b_seq==1;
replace c15b_pid=4 if hrbf_id1==71 & hrbf_id2==1 & c15b_pid==4 & c15b_seq==2;
replace c15b_pid=4 if hrbf_id1==97 & hrbf_id2==6 & c15b_pid==. & c15b_seq==3;
replace c15b_pid=3 if hrbf_id1==97 & hrbf_id2==6 & c15b_pid==. & c15b_seq==4;
drop if hrbf_id1==97 & hrbf_id2==9 & c15b_pid==.;
replace c15b_pid=4 if hrbf_id1==139 & hrbf_id2==12 & c15b_pid==2 & c15b_seq==1;
replace c15b_pid=3 if hrbf_id1==139 & hrbf_id2==12 & c15b_pid==2 & c15b_seq==2;
replace c15b_pid=3 if hrbf_id1==150 & hrbf_id2==12 & c15b_pid==4 & c15b_seq==2;
replace c15b_pid=5 if hrbf_id1==156 & hrbf_id2==3 & c15b_pid==2 & c15b_seq==1;
replace c15b_pid=4 if hrbf_id1==156 & hrbf_id2==3 & c15b_pid==2 & c15b_seq==2;
replace c15b_pid=6 if hrbf_id1==171 & hrbf_id2==10 & c15b_pid==. & c15b_seq==1;
replace c15b_pid=5 if hrbf_id1==171 & hrbf_id2==10 & c15b_pid==. & c15b_seq==2;
replace c15b_pid=7 if hrbf_id1==204 & hrbf_id2==11 & c15b_pid==5 & c15b_seq==1;
drop dupl;

duplicates report hrbf_id1 hrbf_id2 c15b_pid;

tab1 c15_06 c15_07 c15_08 c15_09 c15_10 c15_11 c15_12 c15_13 c15_14 c15_15 c15_16 c15_17 c15_18 c15_19 c15_20 c15_21 c15_22 c15_23, nolab;

replace c15_12=.a if c15_12==96 | c15_12==99;
replace c15_13=2 if c15_13==3;
replace c15_14=.a if c15_14==96 | c15_14==99;
replace c15_17=1 if c15_17==4;
replace c15_18=2 if c15_18==6;
replace c15_19=2 if c15_19==0;

* assert c15_07==. & c15_08==. & c15_09==. & c15_10==. & c15_11==. & c15_12==. & c15_13==. & c15_14==. & c15_15==. if c15_06==2;
* br if (c15_07!=. | c15_08!=. | c15_09!=. | c15_10!=. | c15_11!=. | c15_12!=. | c15_13!=. | c15_14!=. | c15_15!=.) & c15_06==2;
foreach var of varlist c15_07 c15_08 c15_09 c15_10 c15_11 c15_12 c15_13 c15_14 c15_15 {; 
	replace `var'=. if c15_06==2;
};
* assert c15_07==. & c15_08==. if c15_06==1;
* assert c15_09==. & c15_10==. & c15_11==. & c15_12==. & c15_13==. & c15_14==. & c15_15==. if c15_08==2;
* br if (c15_09!=. | c15_10!=. | c15_11!=. | c15_12!=. | c15_13!=. | c15_14!=. | c15_15!=.) & c15_08==2;
foreach var of varlist c15_09 c15_10 c15_11 c15_12 c15_13 c15_14 c15_15 {; 
	replace `var'=. if c15_08==2;
};
* assert c15_11==. & c15_12==. if c15_10==2;
replace c15_12=. if c15_12==0;
replace c15_10=1 if c15_11<. | c15_12<.;
* assert c15_14==. if c15_13==2;
* br if c15_14!=. & c15_13==2;
replace c15_14=. if c15_14==0;
replace c15_13=1 if c15_14<.;
* assert c15_17==. & c15_18==. if c15_16==2;
replace c15_16=1 if c15_17<. | c15_18<.;

lab var c15_12 "Nr polio vaccines given";

sort hrbf_id1 hrbf_id2 c15b_pid;
save $cleandatadir/rwhrbf_c03.dta, replace;

************************************
*** Create rwhrbf_c03_with_studyarms
************************************;

ren c15b_pid a1_pid;
save $tempdatadir/rwhrbf_c03.dta, replace;

use $cleandatadir/rwhrbf_household_roster.dta, clear;
merge hrbf_id1 hrbf_id2 a1_pid using $tempdatadir/rwhrbf_c03.dta, unique;
tab _merge;
list hrbf_id1 hrbf_id2 a1_pid a1_02 if _merge==2;
drop if _merge==2;
drop _merge;
* assert a1_11a<5 if c15_06<. | c15_07<. | c15_08<. | c15_09<. | c15_10<. | c15_11<. | c15_12<. | c15_13<. | c15_14<. | c15_15<. | c15_16<. | c15_17<. | c15_18<. | c15_19<. | c15_20<. | c15_21<. | c15_22<. | c15_23<.;
list hrbf_id1 hrbf_id2 a1_pid a1_11a a1_11b if a1_11a>=5 & (c15_06<. | c15_07<. | c15_08<. | c15_09<. | c15_10<. | c15_11<. | c15_12<. | c15_13<. | c15_14<. | c15_15<. | c15_16<. | c15_17<. | c15_18<. | c15_19<. | c15_20<. | c15_21<. | c15_22<. | c15_23<.);
drop if a1_11a>=5 & (c15_06<. | c15_07<. | c15_08<. | c15_09<. | c15_10<. | c15_11<. | c15_12<. | c15_13<. | c15_14<. | c15_15<. | c15_16<. | c15_17<. | c15_18<. | c15_19<. | c15_20<. | c15_21<. | c15_22<. | c15_23<.);

save $cleandatadir/rwhrbf_c03_withstudyarms.dta, replace;



*********************************************
*** Create necessary variables for mean tests
*********************************************;

gen c15_06_1=c15_06==1;
replace c15_06_1=. if c15_06==.;
lab var c15_06_1 "Received vaccines not on card";

gen c15_07_1=c15_07==1;
replace c15_07_1=. if c15_07==.;
lab var c15_07_1 "Ever had card if not presented";

gen c15_08_1=c15_08==1;
replace c15_08_1=. if c15_08==.;
lab var c15_08_1 "Ever vaccined if no card";

gen c15_09_1=c15_09==1;
replace c15_09_1=. if c15_09==.;
lab var c15_09_1 "BCG on immu day or if no card";

gen c15_10_1=c15_10==1;
replace c15_10_1=. if c15_10==.;
lab var c15_10_1 "Polio on immu day or if no card";

gen c15_11_1=c15_11==1;
replace c15_11_1=. if c15_11==.;
lab var c15_11_1 "Polio right after birth";

gen c15_12_1=c15_12>=3 & c15_12<.;
replace c15_12_1=. if c15_12_1==.;
lab var c15_12_1 "Polio 3+ doses";

gen c15_13_1=c15_13==1;
replace c15_13_1=. if c15_13==.;
lab var c15_13_1 "DTP on immu day or if no card";

gen c15_14_1=c15_14>=3 & c15_14<.;
replace c15_14_1=. if c15_14==.;
lab var c15_14_1 "DTP 3+ doses";

gen c15_15_1=c15_15==1;
replace c15_15_1=. if c15_15==.;
lab var c15_15_1 "Measles immu day or if no card";

gen c15_16_1=c15_16==1;
replace c15_16_1=. if c15_16==.;
lab var c15_16_1 "VitA on immu day or if no card";

gen c15_16_2=c15_16==1 & c15_18==1;
replace c15_16_2=. if c15_16==.;
lab var c15_16_2 "VitA immu day or if no card -6m";

forvalues v=1(1)3 {;
	gen c15_17_`v'=c15_17==`v';
	replace c15_17_`v'=. if c15_17==.;
};
gen c15_17_96=c15_17==96;
replace c15_17_96=. if c15_17==.;
lab var c15_17_1 "VitA in tablet";
lab var c15_17_2 "VitA in capsule";
lab var c15_17_3 "VitA in injection";
lab var c15_17_96 "VitA in other form";

gen c15_19_1=c15_19==1;
replace c15_19_1=. if c15_19==.;
lab var c15_19_1 "Vaccinated in last 3m";

forvalues v=1(1)11 {;
	gen c15_20_`v'=c15_20==`v';
	replace c15_20_`v'=. if c15_20==.;
};
gen c15_20_96=c15_20==96;
replace c15_20_96=. if c15_20==.;
lab var c15_20_1 "Vaccine last 3m at govt hospital";
lab var c15_20_2 "Vaccine last 3m at govt Hcenter";
lab var c15_20_3 "Vaccine last 3m at govt Hpost";
lab var c15_20_4 "Vaccine last 3m at priv hospital";
lab var c15_20_5 "Vaccine last 3m at priv Hcenter";
lab var c15_20_6 "Vaccine last 3m at priv Hpost";
lab var c15_20_7 "Vaccine last 3m at pharmacy";
lab var c15_20_8 "Vaccine last 3m at med staff";
lab var c15_20_9 "Vaccine last 3m at trad healer";
lab var c15_20_10 "Vaccine last 3m at faith healer";
lab var c15_20_11 "Vaccine last 3m at CHW";
lab var c15_20_96 "Vaccine last 3m at other";

gen c15_21_1=c15_21==1;
replace c15_21_1=. if c15_21==.;
lab var c15_21_1 "Brought own needle/syringe";

gen c15_22_1=c15_22==1;
replace c15_22_1=. if c15_22==.;
lab var c15_22_1 "Needle/syringe were new";

gen c15_23_1=c15_23==1;
replace c15_23_1=. if c15_23==.;
lab var c15_23_1 "Kept needle/syringe";

svyset [pweight=hhpweight], psu(hrbf_id1);
save $cleandatadir/rwhrbf_c03_withstudyarms_withvarformeantests.dta, replace;

log close;







