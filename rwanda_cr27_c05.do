* Elisa Rothenbuhler - Nov 10

* This do-file:
* Creates clean child c05 dataset: $cleandatadir/rwhrbf_c05.dta.
* Merges $cleandatadir/rwhrbf_c05.dta with household roster.
* Generates appropriate variables for mean tests.


version 10.0
clear
set more off
set mem 500m
cap log close

#delimit ;

log using $logdir/rwanda_cr27_c05.log, replace;



*********************
*** Clean c05 section
*********************;

use $origdatadir/RWHRBF_C_CHILD-05.dta, clear;

drop if c16b_seq==. & c16b_pid==. & c16_15==. & c16_16==. & c16_17==. & c16_18==. & c16_19==. & c16_20==.;
duplicates tag hrbf_id1 hrbf_id2 c16b_pid, gen(dupl1);
duplicates tag  hrbf_id1 hrbf_id2 c16_15 c16b_seq, gen(dupl2);
list hrbf_id1 hrbf_id2 c16b_pid c16_15 c16b_seq if dupl1!=0 | dupl2!=0;
* list hrbf_id1 hrbf_id2 c16b_pid c16_15 c16b_seq if (hrbf_id1==9 & hrbf_id2==5) | (hrbf_id1==9 & hrbf_id2==10) | (hrbf_id1==15 & hrbf_id2==2) | (hrbf_id1==15 & hrbf_id2==11) | (hrbf_id1==15 & hrbf_id2==12) | (hrbf_id1==31 & hrbf_id2==5) | (hrbf_id1==35 & hrbf_id2==1) | (hrbf_id1==35 & hrbf_id2==5) | (hrbf_id1==35 & hrbf_id2==8) | (hrbf_id1==52 & hrbf_id2==4) | (hrbf_id1==58 & hrbf_id2==7) | (hrbf_id1==58 & hrbf_id2==4) | (hrbf_id1==66 & hrbf_id2==2) | (hrbf_id1==88 & hrbf_id2==12) | (hrbf_id1==88 & hrbf_id2==10) | (hrbf_id1==88 & hrbf_id2==3) | (hrbf_id1==97 & hrbf_id2==1) | (hrbf_id1==112 & hrbf_id2==5) | (hrbf_id1==112 & hrbf_id2==6) | (hrbf_id1==112 & hrbf_id2==12) | (hrbf_id1==150 & hrbf_id2==3) | (hrbf_id1==154 & hrbf_id2==12) | (hrbf_id1==157 & hrbf_id2==1) | (hrbf_id1==157 & hrbf_id2==11) | (hrbf_id1==169 & hrbf_id2==1) | (hrbf_id1==169 & hrbf_id2==4) | (hrbf_id1==169 & hrbf_id2==5) | (hrbf_id1==169 & hrbf_id2==9) | (hrbf_id1==169 & hrbf_id2==11) | (hrbf_id1==180 & hrbf_id2==11) | (hrbf_id1==192 & hrbf_id2==10) | (hrbf_id1==203 & hrbf_id2==5) | (hrbf_id1==203 & hrbf_id2==11) | (hrbf_id1==220 & hrbf_id2==2) | (hrbf_id1==220 & hrbf_id2==3) | (hrbf_id1==220 & hrbf_id2==4) | (hrbf_id1==220 & hrbf_id2==6);
list hrbf_id1 hrbf_id2 c16b_pid c16_15 c16b_seq if dupl1!=0;
list hrbf_id1 hrbf_id2 c16b_pid c16_15 c16b_seq if (hrbf_id1==9 & hrbf_id2==10) | (hrbf_id1==154 & hrbf_id2==12) | (hrbf_id1==180 & hrbf_id2==11) | (hrbf_id1==192 & hrbf_id2==10);

* use $cleandatadir/rwhrbf_household_roster.dta, clear;
* list hrbf_id1 hrbf_id2 a1_pid a1_11a a1_11b a1_15 if (hrbf_id1==9 & hrbf_id2==10) | (hrbf_id1==154 & hrbf_id2==12) | (hrbf_id1==180 & hrbf_id2==11) | (hrbf_id1==192 & hrbf_id2==10);
replace c16b_pid=3 if hrbf_id1==9 & hrbf_id2==10 & c16b_pid==. & c16_15==. & c16b_seq==1;
replace c16b_pid=4 if hrbf_id1==9 & hrbf_id2==10 & c16b_pid==. & c16_15==. & c16b_seq==2;
replace c16_15=2 if hrbf_id1==9 & hrbf_id2==10 & c16b_pid==3 & c16_15==. & c16b_seq==1;
replace c16_15=2 if hrbf_id1==9 & hrbf_id2==10 & c16b_pid==4 & c16_15==. & c16b_seq==2;
replace c16b_pid=3 if hrbf_id1==154 & hrbf_id2==12 & c16b_pid==. & c16_15==. & c16b_seq==1;
replace c16b_pid=4 if hrbf_id1==154 & hrbf_id2==12 & c16b_pid==. & c16_15==. & c16b_seq==2;
replace c16_15=2 if hrbf_id1==154 & hrbf_id2==12 & c16b_pid==3 & c16_15==. & c16b_seq==1;
replace c16_15=2 if hrbf_id1==154 & hrbf_id2==12 & c16b_pid==4 & c16_15==. & c16b_seq==2;
replace c16b_pid=7 if hrbf_id1==180 & hrbf_id2==11 & c16b_pid==. & c16_15==. & c16b_seq==2;
replace c16b_pid=8 if hrbf_id1==180 & hrbf_id2==11 & c16b_pid==. & c16_15==. & c16b_seq==3;
replace c16_15=2 if hrbf_id1==180 & hrbf_id2==11 & c16b_pid==7 & c16_15==. & c16b_seq==2;
replace c16_15=2 if hrbf_id1==180 & hrbf_id2==11 & c16b_pid==8 & c16_15==. & c16b_seq==3;
replace c16b_pid=4 if hrbf_id1==192 & hrbf_id2==10 & c16b_pid==. & c16_15==. & c16b_seq==2;
replace c16b_pid=5 if hrbf_id1==192 & hrbf_id2==10 & c16b_pid==. & c16_15==. & c16b_seq==3;
replace c16_15=2 if hrbf_id1==192 & hrbf_id2==10 & c16b_pid==4 & c16_15==. & c16b_seq==2;
replace c16_15=2 if hrbf_id1==192 & hrbf_id2==10 & c16b_pid==5 & c16_15==. & c16b_seq==3;
drop dupl1 dupl2;
duplicates report hrbf_id1 hrbf_id2 c16b_pid;

* bysort hrbf_id1 hrbf_id2 c16_15: assert c16_15!= c16b_pid if c16_15 !=. & c16b_pid !=.;
list hrbf_id1 hrbf_id2 c16b_pid c16_15 c16b_seq if c16_15==c16b_pid & c16_15!=. & c16b_pid!=.;
list hrbf_id1 hrbf_id2 c16b_pid c16_15 c16b_seq if (hrbf_id1==33 & hrbf_id2==12) | (hrbf_id1==133 & hrbf_id2==12) | (hrbf_id1==221 & hrbf_id2==9);
* use $cleandatadir/rwhrbf_household_roster.dta, clear;
* list hrbf_id1 hrbf_id2 a1_pid a1_11a a1_11b a1_15 if (hrbf_id1==33 & hrbf_id2==12) | (hrbf_id1==133 & hrbf_id2==12) | (hrbf_id1==221 & hrbf_id2==9);
replace c16b_pid=4 if hrbf_id1==33 & hrbf_id2==12 & c16b_pid==2 & c16_15==2 & c16b_seq==.;
drop if hrbf_id1==133 & hrbf_id2==12;
drop if hrbf_id1==221 & hrbf_id2==9;

tab1 c16_16 c16_17 c16_18 c16_19 c16_20, nolab;
list c16_16 c16_17 c16_18 c16_19 c16_20 if c16_16==0;
replace c16_17=. if c16_16==0;
replace c16_16=1 if c16_16==0;

* Norms for Hemoglobin levels for woman and child: 13.5 (11.5-15) g/dL.
* Anemia if Hg level<12g/dL;
list c16_16 c16_17 c16_18 c16_19 c16_20 if c16_18<=5 | (c16_18>20 & c16_18!=.);
replace c16_18=c16_18/10 if c16_18>23 & c16_18!=.;
replace c16_18=. if c16_18==0;

assert c16_17==. if c16_16==1;
assert c16_16!=1 if c16_17!=.;
* assert c16_17==. & c16_18==. & c16_19==. & c16_20==. if c16_16==3;
list if (c16_17!=. | c16_18!=. | c16_19!=. | c16_20!=.) & c16_16==3;
replace c16_19=. if (c16_17!=. | c16_18!=. | c16_19!=. | c16_20!=.) & c16_16==3;
* assert c16_18==. & c16_19==. & c16_20==. if c16_17!=.;
list if (c16_18!=. | c16_19!=. | c16_20!=.) & c16_17!=., compress;
replace c16_16=1 if (c16_18!=. | c16_19!=. | c16_20!=.) & c16_17!=.;
replace c16_17=. if (c16_18!=. | c16_19!=. | c16_20!=.) & c16_17!=.;
* assert c16_20==. if c16_19==2;
list if c16_20!=. & c16_19==2;
replace c16_19=1 if c16_20==1 & c16_19==2;
replace c16_20=. if c16_20!=. & c16_19==2;

sort hrbf_id1 hrbf_id2 c16b_pid;
save $cleandatadir/rwhrbf_c05.dta, replace;



************************************
*** Create rwhrbf_c05_with_studyarms
************************************;

ren c16b_pid a1_pid;
save $tempdatadir/rwhrbf_c05.dta, replace;

use $cleandatadir/rwhrbf_household_roster.dta, clear;
merge hrbf_id1 hrbf_id2 a1_pid using $tempdatadir/rwhrbf_c05.dta, unique;
tab _merge;
list hrbf_id1 hrbf_id2 a1_pid a1_02 if _merge==2;
drop if _merge==2;
drop _merge;
* assert a1_11a<5 if c16b_seq<. | c16_15<. | c16_16<. | c16_17<. | c16_18<. | c16_19<. | c16_20<.;
list hrbf_id1 hrbf_id2 a1_pid a1_11a a1_11b if a1_11a>=5 & (c16b_seq<. | c16_15<. | c16_16<. | c16_17<. | c16_18<. | c16_19<. | c16_20<.);
drop if a1_11a>=5 & (c16b_seq<. | c16_15<. | c16_16<. | c16_17<. | c16_18<. | c16_19<. | c16_20<.);

save $cleandatadir/rwhrbf_c05_withstudyarms.dta, replace;



*********************************************
*** Create necessary variables for mean tests
*********************************************;

gen c16_16_1=c16_16==1;
replace c16_16_1=. if c16_16>=.;
lab var c16_16_1 "Mother consent to anemia test";

gen c16_19_1=c16_19==1;
replace c16_19_1=. if c16_19>=.;
lab var c16_19_1 "Anemia detected";

gen c16_20_1=c16_20==1;
replace c16_20_1=. if c16_20>=.;
lab var c16_20_1 "Anemia detected & referral";

svyset [pweight=hhpweight], psu(hrbf_id1);
save $cleandatadir/rwhrbf_c05_withstudyarms_withvarformeantests.dta, replace;

log close;



