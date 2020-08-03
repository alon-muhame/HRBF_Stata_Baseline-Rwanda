* Elisa Rothenbuhler - Nov 10

* This do-file:
* Creates clean child c04 dataset: $cleandatadir/rwhrbf_c04.dta.
* Merges $cleandatadir/rwhrbf_c04.dta with household roster.
* Generates appropriate variables for mean tests.


version 10.0
clear
set more off
set mem 500m
cap log close

#delimit ;

log using $logdir/rwanda_cr26_c04.log, replace;



*********************
*** Clean c04 section
*********************;

use $origdatadir/RWHRBF_C_CHILD-04.dta, clear;

drop if c16a_seq==. & c16a_pid==. & c16_01y==. & c16_01m==. & c16_02==. & c16_03m==. & c16_03y==. & c16_04==. & c16_05==. & c16_06==. & c16_07==. & c16_08a==. & c16_08b==. & c16_08c==. & c16_08d==. & c16_08e==. & c16_08f==. & c16_09==. & c16_10d==. & c16_10m==. & c16_10y==. & c16_11==. & c16_12==. & c16_13==. & c16_14==.;

duplicates tag hrbf_id1 hrbf_id2 c16a_seq, gen(dupl1);
duplicates tag hrbf_id1 hrbf_id2 c16a_pid, gen(dupl2);
list hrbf_id1 hrbf_id2 c16a_pid c16a_seq c16_01y c16_01m dupl1 dupl2 if dupl1!=0 | dupl2!=0;
list hrbf_id1 hrbf_id2 c16a_pid c16a_seq c16_01y c16_01m dupl1 dupl2 if (hrbf_id1==8 & hrbf_id2==7) | (hrbf_id1==9 & hrbf_id2==3) | (hrbf_id1==14 & hrbf_id2==5) | (hrbf_id1==15 & hrbf_id2==11) | (hrbf_id1==88 & hrbf_id2==4) | (hrbf_id1==88 & hrbf_id2==11) | (hrbf_id1==88 & hrbf_id2==12) | (hrbf_id1== 97& hrbf_id2==6) | (hrbf_id1==97 & hrbf_id2==9) | (hrbf_id1==141 & hrbf_id2==7) | (hrbf_id1==176 & hrbf_id2==7) | (hrbf_id1==182 & hrbf_id2==6) | (hrbf_id1==203 & hrbf_id2==3) | (hrbf_id1==203 & hrbf_id2==5);

* use $cleandatadir/rwhrbf_household_roster.dta, clear;
* list hrbf_id1 hrbf_id2 a1_pid a1_11a a1_11b a1_15 if (hrbf_id1==8 & hrbf_id2==7) | (hrbf_id1==9 & hrbf_id2==3) | (hrbf_id1==14 & hrbf_id2==5) | (hrbf_id1==15 & hrbf_id2==11) | (hrbf_id1==88 & hrbf_id2==4) | (hrbf_id1==88 & hrbf_id2==11) | (hrbf_id1==88 & hrbf_id2==12) | (hrbf_id1== 97& hrbf_id2==6) | (hrbf_id1==97 & hrbf_id2==9) | (hrbf_id1==141 & hrbf_id2==7) | (hrbf_id1==176 & hrbf_id2==7) | (hrbf_id1==182 & hrbf_id2==6) | (hrbf_id1==203 & hrbf_id2==3) | (hrbf_id1==203 & hrbf_id2==5);

replace c16a_pid=5 if hrbf_id1==8 & hrbf_id2==7 & c16a_pid==. & c16a_seq==1;
replace c16a_pid=4 if hrbf_id1==8 & hrbf_id2==7 & c16a_pid==. & c16a_seq==2;
replace c16a_pid=5 if hrbf_id1==9 & hrbf_id2==3 & c16a_pid==. & c16a_seq==1;
replace c16a_pid=4 if hrbf_id1==9 & hrbf_id2==3 & c16a_pid==. & c16a_seq==2;
replace c16a_pid=6 if hrbf_id1==14 & hrbf_id2==5 & c16a_pid==. & c16a_seq==2;
replace c16a_pid=5 if hrbf_id1==14 & hrbf_id2==5 & c16a_pid==. & c16a_seq==3;
replace c16a_pid=4 if hrbf_id1==15 & hrbf_id2==11 & c16a_pid==5 & c16a_seq==2;
replace c16a_pid=3 if hrbf_id1==88 & hrbf_id2==4 & c16a_pid==5 & c16a_seq==3;
replace c16a_pid=5 if hrbf_id1==88 & hrbf_id2==11 & c16a_pid==. & c16a_seq==1;
replace c16a_pid=4 if hrbf_id1==88 & hrbf_id2==11 & c16a_pid==. & c16a_seq==2;
replace c16a_pid=3 if hrbf_id1==88 & hrbf_id2==11 & c16a_pid==27 & c16a_seq==3;
replace c16a_seq=1 if hrbf_id1==88 & hrbf_id2==12 & c16a_pid==4 & c16a_seq==.;
replace c16a_seq=2 if hrbf_id1==88 & hrbf_id2==12 & c16a_pid==3 & c16a_seq==.;
replace c16a_pid=4 if hrbf_id1==97 & hrbf_id2==6 & c16a_pid==. & c16a_seq==3;
replace c16a_pid=3 if hrbf_id1==97 & hrbf_id2==6 & c16a_pid==. & c16a_seq==4;
drop if hrbf_id1==97 & hrbf_id2==9 & c16a_pid==.;
drop if hrbf_id1==141 & hrbf_id2==7 & c16a_pid==.;
replace c16a_seq=1 if hrbf_id1==176 & hrbf_id2==7 & c16a_pid==6 & c16a_seq==.;
replace c16a_seq=2 if hrbf_id1==176 & hrbf_id2==7 & c16a_pid==5 & c16a_seq==.;
replace c16a_seq=1 if hrbf_id1==182 & hrbf_id2==6 & c16a_pid==5 & c16a_seq==.;
replace c16a_seq=2 if hrbf_id1==182 & hrbf_id2==6 & c16a_pid==4 & c16a_seq==.;
replace c16a_pid=4 if hrbf_id1==203 & hrbf_id2==3 & c16a_pid==. & c16a_seq==2;
replace c16a_pid=3 if hrbf_id1==203 & hrbf_id2==3 & c16a_pid==. & c16a_seq==3;
replace c16a_seq=1 if hrbf_id1==203 & hrbf_id2==5 & c16a_pid==5 & c16a_seq==.;
replace c16a_seq=2 if hrbf_id1==203 & hrbf_id2==5 & c16a_pid==4 & c16a_seq==.;
drop dupl1 dupl2;
duplicates report hrbf_id1 hrbf_id2 c16a_seq;
duplicates report hrbf_id1 hrbf_id2 c16a_pid;

tab1 c16_01y c16_01m c16_02 c16_03m c16_03y c16_04 c16_05 c16_06 c16_07 c16_08a c16_08b c16_08c c16_08d c16_08e c16_08f c16_09 c16_10d c16_10m c16_10y c16_11 c16_12 c16_13 c16_14, nolab;
replace c16_01y=.a if c16_01y==0;
replace c16_01m=.a if c16_01m==0;
replace c16_03m=.a if c16_03m==0;
replace c16_03m=12 if c16_03m==17;
replace c16_03m=12 if c16_03m==19;
replace c16_03m=10 if c16_03m==20;
replace c16_03m=.b if c16_03m==96;
replace c16_03m=.b if c16_03m==99;
replace c16_03y=.a if c16_03y==0;
replace c16_03y=2010 if c16_03y==2011 | c16_03y==210 | c16_03y==10;
replace c16_03y=2010 if c16_03y==210;
forvalues v=1(1)9 {;
	replace c16_03y=200`v' if c16_03y==`v';
};
replace c16_03y=. if c16_03y==11 | c16_03y==12 | c16_03y==22 | c16_03y==24 | c16_03y==69;
replace c16_04=1 if c16_04==7;
replace c16_04=2 if c16_04==6;
replace c16_06=. if c16_06==0;
replace c16_10d=.a if c16_10d==0 | c16_10d==99; 
	* c16_10d is month, not day;
replace c16_10d=12 if c16_10d==16;
replace c16_10m=.a if c16_10m==0 | c16_10m==99;
	* c16_10m is day, not month;
replace c16_10y=.a if c16_10y==0;
replace c16_10y=2009 if c16_10y==3 | c16_10y==2007 | c16_10y==2008;
replace c16_10y=2010 if c16_10y!=2009 & c16_10y<.;
replace c16_11=.z if c16_11<30;
replace c16_11=20.1 if c16_11==201;
replace c16_11=49.2 if c16_11==492;
replace c16_13=.a if c16_13==0;
replace c16_13=c16_13/10 if c16_13>26 & c16_13<.;
replace c16_14=.a if c16_14==0;

plot c16_11 c16_01y;
plot c16_13 c16_01y;
plot c16_11 c16_01m;
plot c16_13 c16_01m;
* Below: do these plots with age from household roster to check outliers;

* assert c16_03m>=. & c16_03y>=. & c16_04>=. & c16_05>=. & c16_06>=. & c16_07>=. & c16_08a>=. & c16_08b>=. & c16_08c>=. & c16_08d>=. & c16_08e>=. & c16_08f>=. if c16_02==2;
* br c16_03m c16_03y c16_04 c16_05 c16_06 c16_07 c16_08a c16_08b c16_08c c16_08d c16_08e c16_08f if (c16_03m<. | c16_03y<. | c16_04<. | c16_05<. | c16_06<. | c16_07<. | c16_08a<. | c16_08b<. | c16_08c<. | c16_08d<. | c16_08e<. | c16_08f<.) & c16_02==2;
foreach var of varlist c16_03m c16_03y {;
	replace `var'=. if c16_02==2 & c16_04==. & c16_05==. & c16_06==. & c16_07==. & c16_08a==. & c16_08b==. & c16_08c==. & c16_08d==. & c16_08e==. & c16_08f==.;
};
replace c16_07=. if c16_02==2 & c16_04==. & c16_05==. & c16_06==. & c16_08a==. & c16_08b==. & c16_08c==. & c16_08d==. & c16_08e==. & c16_08f==.;
* assert c16_03m<. | c16_03y<. | c16_04<. | c16_05<. | c16_06<. | c16_07<. | c16_08a<. | c16_08b<. | c16_08c<. | c16_08d<. | c16_08e<. | c16_08f<. if c16_02==1;
replace c16_02=2 if c16_03m>=. & c16_03y>=. & c16_04>=. & c16_05>=. & c16_06>=. & c16_07>=. & c16_08a>=. & c16_08b>=. & c16_08c>=. & c16_08d>=. & c16_08e>=. & c16_08f>=.;
* assert c16_07>=. & c16_08a>=. & c16_08b>=. & c16_08c>=. & c16_08d>=. & c16_08e>=. & c16_08f>=. if c16_06==1;
list c16_07 c16_08a c16_08b c16_08c c16_08d c16_08e c16_08f if c16_06==1 & (c16_07<. | c16_08a<. | c16_08b<. | c16_08c<. | c16_08d<. | c16_08e<. | c16_08f<.);
replace c16_07=. if c16_06==1 & (c16_07==13 | (c16_08a==2 & c16_08b==2 & c16_08c==2 & c16_08d==2 & c16_08e==2 & c16_08f==2));
replace c16_08a=. if c16_06==1 & c16_07==. & c16_08a==2 & c16_08b==2 & c16_08c==2 & c16_08d==2 & c16_08e==2 & c16_08f==2;
replace c16_08b=. if c16_06==1 & c16_07==. & c16_08a==. & c16_08b==2 & c16_08c==2 & c16_08d==2 & c16_08e==2 & c16_08f==2;
replace c16_08c=. if c16_06==1 & c16_07==. & c16_08a==. & c16_08b==. & c16_08c==2 & c16_08d==2 & c16_08e==2 & c16_08f==2;
replace c16_08d=. if c16_06==1 & c16_07==. & c16_08a==. & c16_08b==. & c16_08c==. & c16_08d==2 & c16_08e==2 & c16_08f==2;
replace c16_08e=. if c16_06==1 & c16_07==. & c16_08a==. & c16_08b==. & c16_08c==. & c16_08d==. & c16_08e==2 & c16_08f==2;
replace c16_08f=. if c16_06==1 & c16_07==. & c16_08a==. & c16_08b==. & c16_08c==. & c16_08d==. & c16_08e==. & c16_08f==2;
replace c16_06=2 if c16_06==1 & (c16_07<. | c16_08a<. | c16_08b<. | c16_08c<. | c16_08d<. | c16_08e<. | c16_08f<.);
* assert c16_07<. | c16_08a<. | c16_08b<. | c16_08c<. | c16_08d<. | c16_08e<. | c16_08f<. if c16_06==2 | c16_06==3;
replace c16_06=1 if c16_07>=. & c16_08a>=. & c16_08b>=. & c16_08c>=. & c16_08d>=. & c16_08e>=. & c16_08f>=.; 
* assert c16_10d>=. & c16_10m>=. & c16_10y>=. & c16_11>=. & c16_12>=. & c16_13>=. & c16_14>=. if c16_09!=1;
list c16_10d c16_10m c16_10y c16_11 c16_12 c16_13 c16_14 if c16_09!=1 & (c16_10d<. | c16_10m<. | c16_10y<. | c16_11<. | c16_12<. | c16_13<. | c16_14<.);
replace c16_09=1 if c16_09!=1 & (c16_10d<. | c16_10m<. | c16_10y<. | c16_11<. | c16_12<. | c16_13<. | c16_14<.);
* assert c16_10d<. | c16_10m<. | c16_10y<. | c16_11<. | c16_12<. | c16_13<. | c16_14<. if c16_09==1;
replace c16_09=.z if c16_09==1 & c16_10d>=. & c16_10m>=. & c16_10y>=. & c16_11>=. & c16_12>=. & c16_13>=. & c16_14>=.;

sort hrbf_id1 hrbf_id2 c16a_pid;
save $cleandatadir/rwhrbf_c04.dta, replace;



************************************
*** Create rwhrbf_c04_with_studyarms
************************************;

ren c16a_pid a1_pid;
save $tempdatadir/rwhrbf_c04.dta, replace;

use $cleandatadir/rwhrbf_household_roster.dta, clear;
merge hrbf_id1 hrbf_id2 a1_pid using $tempdatadir/rwhrbf_c04.dta, unique;
tab _merge;
list hrbf_id1 hrbf_id2 a1_pid a1_02 if _merge==2;
drop if _merge==2;
drop _merge;
* assert a1_11a<5 if c16_01y<. | c16_01m<. | c16_02<. | c16_03m<. | c16_03y<. | c16_04<. | c16_05<. | c16_06<. | c16_07<. | c16_08a<. | c16_08b<. | c16_08c<. | c16_08d<. | c16_08e<. | c16_08f<. | c16_09<. | c16_10d<. | c16_10m<. | c16_10y<. | c16_11<. | c16_12<. | c16_13<. | c16_14<.;
list hrbf_id1 hrbf_id2 a1_pid a1_11a a1_11b if a1_11a>=5 & (c16_01y<. | c16_01m<. | c16_02<. | c16_03m<. | c16_03y<. | c16_04<. | c16_05<. | c16_06<. | c16_07<. | c16_08a<. | c16_08b<. | c16_08c<. | c16_08d<. | c16_08e<. | c16_08f<. | c16_09<. | c16_10d<. | c16_10m<. | c16_10y<. | c16_11<. | c16_12<. | c16_13<. | c16_14<.);
drop if a1_11a>=5 & (c16_01y<. | c16_01m<. | c16_02<. | c16_03m<. | c16_03y<. | c16_04<. | c16_05<. | c16_06<. | c16_07<. | c16_08a<. | c16_08b<. | c16_08c<. | c16_08d<. | c16_08e<. | c16_08f<. | c16_09<. | c16_10d<. | c16_10m<. | c16_10y<. | c16_11<. | c16_12<. | c16_13<. | c16_14<.);

plot c16_11 a1_11a;
replace c16_11=.z if c16_11>90 & a1_11a<1;
replace c16_11=.z if c16_11<30 & a1_11a>0;
plot c16_11 a1_11a;
plot c16_13 a1_11a;
plot c16_11 a1_11b;
plot c16_13 a1_11b;

save $cleandatadir/rwhrbf_c04_withstudyarms.dta, replace;



*********************************************************************
*** Incorporate weight and height corrections into rwhrbf_c04 dataset
*********************************************************************;

ren a1_pid c16a_pid;
keep hrbf_id1 hrbf_id2 hrbf_id3 hrbf_rectype c16a_seq c16a_pid c16_01y c16_01m c16_02 c16_03m c16_03y c16_04 c16_05 c16_06 c16_07 c16_08a c16_08b c16_08c c16_08d c16_08e c16_08f c16_09 c16_10d c16_10m c16_10y c16_11 c16_12 c16_13 c16_14;

sort hrbf_id1 hrbf_id2 c16a_pid;
save $cleandatadir/rwhrbf_c04.dta, replace;



*********************************************
*** Create necessary variables for mean tests
*********************************************;

use $cleandatadir/rwhrbf_c04_withstudyarms.dta, clear;

gen c16_02_1=c16_02==1;
replace c16_02_1=. if c16_02>=.;
lab var c16_02_1 "Measured in last 6m";

forvalues v=1(1)5 {;
	gen c16_04_`v'=c16_04==`v';
	replace c16_04_`v'=. if c16_04>=.;
};
lab var c16_04_1 "Height only measured";
lab var c16_04_2 "Weight only measured";
lab var c16_04_3 "Height/weight measured";
lab var c16_04_4 "Upper arm circonference measured";
lab var c16_04_5 "Height/Weight/UAC measured";

forvalues v=1(1)12 {;
	gen c16_05_`v'=c16_05==`v';
	replace c16_05_`v'=. if c16_05>=.;
};
gen c16_05_96=c16_05==96;
replace c16_05_96=. if c16_05>=.;
lab var c16_05_1 "Measured at govt hospital";
lab var c16_05_2 "Measured at govt health center";
lab var c16_05_3 "Measured at govt health post";
lab var c16_05_4 "Measured at private hospital";
lab var c16_05_5 "Measured at priv health center";
lab var c16_05_6 "Measured at priv health post";
lab var c16_05_7 "Measured at pharmacy";
lab var c16_05_8 "Measured at medical staff";
lab var c16_05_9 "Measured at trad healer";
lab var c16_05_10 "Measured at faith healer";
lab var c16_05_11 "Measured at CHW";
lab var c16_05_12 "Measured at Friends/Neighbors";
lab var c16_05_96 "Measured at other";
tab c16_05, nolab;
drop c16_05_4 c16_05_5 c16_05_7 c16_05_9 c16_05_12;

forvalues v=1(1)3 {;
	gen c16_06_`v'=c16_06==`v';
	replace c16_06_`v'=. if c16_06>=.;
};
lab var c16_06_1 "Last measuremt:No malnutrition";
lab var c16_06_2 "Last measuremt:Risk malnutrition";
lab var c16_06_3 "Last measure:Severe malnutrition";

forvalues v=1(1)14 {;
	gen c16_07_`v'=c16_07==`v';
	replace c16_07_`v'=. if c16_07>=.;
};
gen c16_07_96=c16_07==96;
replace c16_07_96=. if c16_07>=.;
lab var c16_07_1 "Referred govt hospital";
lab var c16_07_2 "Referred govt health center";
lab var c16_07_3 "Referred govt health post";
lab var c16_07_4 "Referred private hospital";
lab var c16_07_5 "Referred priv health center";
lab var c16_07_6 "Referred priv health post";
lab var c16_07_7 "Referred pharmacy";
lab var c16_07_8 "Referred medical staff";
lab var c16_07_9 "Referred trad healer";
lab var c16_07_10 "Referred faith healer";
lab var c16_07_11 "Referred CHW";
lab var c16_07_12 "Referred Friends/Neighbors";
lab var c16_07_13 "Not Referred";
lab var c16_07_14 "Referred but didnt go";
lab var c16_07_96 "Referred other";
tab c16_07, nolab;
drop c16_07_4 c16_07_5 c16_07_6 c16_07_7 c16_07_8 c16_07_9 c16_07_10 c16_07_12 c16_07_14 c16_07_96;

foreach letter in a b c d e f {;
	gen c16_08`letter'_1=c16_08`letter'==1;
	replace c16_08`letter'_1=. if c16_08`letter'>=.;
};
lab var c16_08a_1 "VitA given if malnourished";
lab var c16_08b_1 "Advise given if malnourished";
lab var c16_08c_1 "Rehabilitated if malnourished";
lab var c16_08d_1 "Coartem given if malnourished";
lab var c16_08e_1 "Referred higher if malnourished";
lab var c16_08f_1 "Other given if malnourished";

gen c16_09_1=c16_09==1;
replace c16_09_1=. if c16_09>=.;
lab var c16_09_1 "Child measured at itw";

gen c16_09_2=c16_09==2 | c16_09==3 | c16_09==4;
replace c16_09_2=. if c16_09>=.;
lab var c16_09_2 "Child not measured:not present";

gen c16_09_5=c16_09==5;
replace c16_09_5=. if c16_09>=.;
lab var c16_09_5 "Child not measured:ill/disabled";

gen c16_09_6=c16_09==6;
replace c16_09_6=. if c16_09>=.;
lab var c16_09_6 "Child not measured: refusal";

gen c16_12_1=c16_12==1;
replace c16_12_1=. if c16_12>=.;
lab var c16_12_1 "Measured standing";

gen c16_12_2=c16_12==2;
replace c16_12_2=. if c16_12>=.;
lab var c16_12_2 "Measured lying";

forvalues v=1(1)3 {;
	gen c16_14_`v'=c16_14==`v';
	replace c16_14_`v'=. if c16_14>=.;
};
lab var c16_14_1 "UACM:No malnutrition";
lab var c16_14_2 "UACM:Risk of malnutrition";
lab var c16_14_3 "UACM:Severe malnutrition";

save $cleandatadir/rwhrbf_c04_withstudyarms_withvarformeantests.dta, replace;
* Also save in WHO macro input/output file, where Zscore calculations will be saved too (see below);
save $resultdir/who_igrowup_stata_inputs_outputs/rwhrbf_c04_withstudyarms_withvarformeantests.dta, replace;


*** 
*** Indicators
***;

****************************
*** Calculation of Z-scores
****************************;

* 1/ Please visit WHO website about program Anthro and macros developed to calculate Z-scores in specific statistical programs (http://www.who.int/childgrowth/software/en/) and download required macro;
* 2/ Refer to Read me and to the survey_restricted do-file of the WHO package for calculation of four anthropometric indicators based on the WHO Child Growth Standards:
		* weight-for-age, 
		* length/height-for-age, 
		* weight-for-length/height 
		* body mass index (BMI)-for-age;
* 3/ Modify survey_restricted.do file according to current data based on instructions of Read me (see current survey_restricted_rwanda.do file modified based on rwandan dataset for reference);
* 4/ Run modified survey_resricted do file; 

do $resultdir/who_igrowup_stata_inputs_outputs/survey_restricted_rwanda.do;

*5/ The macro creates, in the working directory specified in survey_restricted_rwanda.do, a STATA dataset called rwanda_z_rc.dta. This dataset retains all the records and variables from the input STATA dataset and adds on the following 11 variables derived by the macro:
	* _agedays - calculated age in days for deriving z score
	* _clenhei - converted length/height (cm) for deriving z score
	* _cbmi - calculated bmi=weight / squared(_clenhei)
	* _zwei - Weight-for-age z-score
	* _zlen - Length/height-for-age z-score
	* _zwfl - Weight-for-length/height z-score
	* _zbmi - BMI-for-age z-score
	* _fwei - Flagfor_zwei<-6or_zwei>5
	* _flen - Flagfor_zlen<-6or_zlen>6
	* _fwfl - Flagfor_zwfl<-5or_zwfl>5
	* _fbmi - Flagfor_zbmi<-5or_zbmi>5
*6/ Generate additional variables for nutrition indicators based on Z-scores;

use $resultdir/who_igrowup_stata_inputs_outputs/rwanda_zscores_z_rc, clear;

tab1 _fwei _flen _fwfl _fbmi;
desc _zwei, detail;
sum _zwei;
desc _zlen;
sum _zlen;
desc _zwfl;
sum _zwfl;
desc _zbmi;
sum _zbmi;

gen _zwei_clean=_zwei;
replace _zwei_clean=.z if _fwei==1;
lab var _zwei_clean "Weight-for-age z-score";
gen _zlen_clean=_zlen;
replace _zlen_clean=.z if _flen==1;
lab var _zlen_clean "Height-for-age z-score";
gen _zwfl_clean=_zwfl;
replace _zwfl_clean=.z if _fwfl==1;
lab var _zwfl_clean "Weight-for-height z-score";
gen _zbmi_clean=_zbmi;
replace _zbmi_clean=.z if _fbmi==1;
lab var _zbmi_clean "BMI-for-age z-score";

gen c16_13_100=.;
replace c16_13_100=1 if _zwei_clean<-2;
replace c16_13_100=0 if _zwei_clean>=-2 & _zwei_clean<.;
lab var c16_13_100 "Moderate/Severe underwght 0-59m";
* JHU report indicator;

gen c16_13_101=.;
replace c16_13_101=1 if _zwei_clean<-3;
replace c16_13_101=0 if _zwei_clean>=-3 & _zwei<.;
lab var c16_13_101 "Severe underweight 0-59m";
* JHU report indicator;

gen c16_13_102=.;
replace c16_13_102=1 if a1_11b<=23 & _zwfl_clean<-2;
replace c16_13_102=0 if a1_11b<=23 & _zwfl_clean>=-2 & _zwfl_clean<.;
lab var c16_13_102 "Moderate/Severe wasting 0-23m";
* JHU report indicator;

gen c16_13_103=.;
replace c16_13_103=1 if a1_11b<=23 & _zwfl_clean<-3;
replace c16_13_103=0 if a1_11b<=23 & _zwfl_clean>=-3 & _zwfl_clean<.;
lab var c16_13_103 "Severe wasting 0-23m";
* JHU report indicator;

gen c16_13_104=.;
replace c16_13_104=1 if _zwfl_clean<-2;
replace c16_13_104=0 if _zwfl_clean>=-2 & _zwfl_clean<.;
lab var c16_13_104 "Moderate/Severe wasting 0-59m";
* WHO indicator;

gen c16_13_105=.;
replace c16_13_105=1 if _zwfl_clean<-3;
replace c16_13_105=0 if _zwfl_clean>=-3 & _zwfl_clean<.;
lab var c16_13_105 "Severe wasting 0-59m";
* WHO indicator;

gen c16_11_100=.;
replace c16_11_100=1 if a1_11b>=24 & a1_11b<60 & _zlen_clean<-2;
replace c16_11_100=0 if a1_11b>=24 & a1_11b<60 & _zlen_clean>=-2 & _zlen_clean<.;
lab var c16_11_100 "Moderate/Severe stunting 24-59m";
* JHU report indicator;

gen c16_11_101=.;
replace c16_11_101=1 if a1_11b>=24 & a1_11b<60 & _zlen_clean<-3;
replace c16_11_101=0 if a1_11b>=24 & a1_11b<60 & _zlen_clean>=-3 & _zlen_clean<.;
lab var c16_11_101 "Severe stunting 24-59m";
* JHU report indicator;

gen c16_11_102=.;
replace c16_11_102=1 if _zlen_clean<-2;
replace c16_11_102=0 if _zlen_clean>=-2 & _zlen_clean<.;
lab var c16_11_102 "Moderate/Severe stunting 0-59m";
* WHO indicator;

gen c16_11_103=.;
replace c16_11_103=1 if _zlen_clean<-3;
replace c16_11_103=0 if _zlen_clean>=-3 & _zlen_clean<.;
lab var c16_11_103 "Severe stunting 0-59m";
* WHO indicator;

svyset [pweight=hhpweight], psu(hrbf_id1);
save $cleandatadir/rwhrbf_c04_withstudyarms_withvarformeantests.dta, replace;

log close;