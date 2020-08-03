* Elisa Rothenbuhler - Nov 10

* This do-file:
* Creates clean child c02 dataset: $cleandatadir/rwhrbf_c02.dta.
* Merges $cleandatadir/rwhrbf_c02.dta with household roster.
* Generates appropriate variables for mean tests.


version 10.0
clear
set more off
set mem 500m
cap log close

#delimit ;

log using $logdir/rwanda_cr24_c02.log, replace;



*********************
*** Clean c02 section
*********************;

use $origdatadir/RWHRBF_C_CHILD-02.dta, clear;

drop if c15a_seq==. & c15_02==. & c15_03==. & c15_04==. & c15_05ad==. & c15_05am==. & c15_05ay==. & c15_05bd==. & c15_05bm==. & c15_05by==. & c15_05cd==. & c15_05cm==. & c15_05cy==. & c15_05dd==. & c15_05dm==. & c15_05dy==. & c15_05ed==. & c15_05em==. & c15_05ey==. & c15_05fd==. & c15_05fm==. & c15_05fy==. & c15_05gd==. & c15_05gm==. & c15_05gy==. & c15_05hd==. & c15_05hm==. & c15_05hy==. & c15_05id==. & c15_05im==. & c15_05iy==. & c15_05jd==. & c15_05jm==. & c15_05jy==.;

duplicates tag hrbf_id1 hrbf_id2 c15_03, gen(dupl1);
duplicates tag hrbf_id1 hrbf_id2 c15_02 c15a_seq, gen(dupl2);
list hrbf_id1 hrbf_id2 c15_02 c15a_seq c15_03 dupl1 dupl2 if dupl1!=0 | dupl2!=0;
list hrbf_id1 hrbf_id2 c15_02 c15a_seq c15_03 dupl1 dupl2 if (hrbf_id1==82 & hrbf_id2==4) | (hrbf_id1==88 & hrbf_id2==3) | (hrbf_id1==97 & hrbf_id2==6) | (hrbf_id1==97 & hrbf_id2==9) | (hrbf_id1==109 & hrbf_id2==1) | (hrbf_id1==167 & hrbf_id2==3) | (hrbf_id1==174 & hrbf_id2==3) | (hrbf_id1==182 & hrbf_id2==6);
replace c15a_seq=1 if hrbf_id1==174 & hrbf_id2==3 & c15_03==4;
replace c15a_seq=2 if hrbf_id1==174 & hrbf_id2==3 & c15_03==3;
replace c15a_seq=1 if hrbf_id1==182 & hrbf_id2==6 & c15_03==5;
replace c15a_seq=2 if hrbf_id1==182 & hrbf_id2==6 & c15_03==4;
* br if dupl1!=0 | dupl2!=0;
drop if hrbf_id1==88 & hrbf_id2==3 & c15_02==. & c15_03==. & c15_04==. & c15_05ad==. & c15_05am==. & c15_05ay==. & c15_05bd==. & c15_05bm==. & c15_05by==. & c15_05cd==. & c15_05cm==. & c15_05cy==. & c15_05dd==. & c15_05dm==. & c15_05dy==. & c15_05ed==. & c15_05em==. & c15_05ey==. & c15_05fd==. & c15_05fm==. & c15_05fy==. & c15_05gd==. & c15_05gm==. & c15_05gy==. & c15_05hd==. & c15_05hm==. & c15_05hy==. & c15_05id==. & c15_05im==. & c15_05iy==. & c15_05jd==. & c15_05jm==. & c15_05jy==.;
drop if hrbf_id1==167 & hrbf_id2==3 & c15_04==. & c15_05ad==. & c15_05am==. & c15_05ay==. & c15_05bd==. & c15_05bm==. & c15_05by==. & c15_05cd==. & c15_05cm==. & c15_05cy==. & c15_05dd==. & c15_05dm==. & c15_05dy==. & c15_05ed==. & c15_05em==. & c15_05ey==. & c15_05fd==. & c15_05fm==. & c15_05fy==. & c15_05gd==. & c15_05gm==. & c15_05gy==. & c15_05hd==. & c15_05hm==. & c15_05hy==. & c15_05id==. & c15_05im==. & c15_05iy==. & c15_05jd==. & c15_05jm==. & c15_05jy==.;
drop dupl1 dupl2;
duplicates tag hrbf_id1 hrbf_id2 c15_03, gen(dupl1);
duplicates tag hrbf_id1 hrbf_id2 c15_02 c15a_seq, gen(dupl2);
list hrbf_id1 hrbf_id2 c15_02 c15a_seq c15_03 dupl1 dupl2 if dupl1!=0 | dupl2!=0;
list hrbf_id1 hrbf_id2 c15_02 c15a_seq c15_03 dupl1 dupl2 if (hrbf_id1==82 & hrbf_id2==4) | (hrbf_id1==88 & hrbf_id2==3) | (hrbf_id1==97 & hrbf_id2==6) | (hrbf_id1==97 & hrbf_id2==9) | (hrbf_id1==109 & hrbf_id2==1) | (hrbf_id1==167 & hrbf_id2==3);

* use $cleandatadir/rwhrbf_household_roster.dta, clear;
* list hrbf_id1 hrbf_id2 a1_pid a1_11a a1_11b a1_15 if (hrbf_id1==82 & hrbf_id2==4) | (hrbf_id1==88 & hrbf_id2==3) | (hrbf_id1==97 & hrbf_id2==6) | (hrbf_id1==97 & hrbf_id2==9) | (hrbf_id1==109 & hrbf_id2==1) | (hrbf_id1==167 & hrbf_id2==3);
replace c15_03=8 if hrbf_id1==82 & hrbf_id2==4 & c15_02==8 & c15_03==.;
replace c15_03=7 if hrbf_id1==82 & hrbf_id2==4 & c15_02==7 & c15_03==.;
replace c15_02=2 if hrbf_id1==82 & hrbf_id2==4 & c15_02==8;
replace c15_02=2 if hrbf_id1==82 & hrbf_id2==4 & c15_02==7;
replace c15_03=6 if hrbf_id1==88 & hrbf_id2==3 & c15_02==6 & c15_03==.;
replace c15_03=5 if hrbf_id1==88 & hrbf_id2==3 & c15_02==5 & c15_03==.;
replace c15_02=2 if hrbf_id1==88 & hrbf_id2==3 & c15_02==6;
replace c15_02=2 if hrbf_id1==88 & hrbf_id2==3 & c15_02==5;
replace c15_02=2 if hrbf_id1==97 & hrbf_id2==6 & c15_02==.;
replace c15_03=4 if hrbf_id1==97 & hrbf_id2==6 & c15_02==2 & c15a_seq==3;
replace c15_03=3 if hrbf_id1==97 & hrbf_id2==6 & c15_02==2 & c15a_seq==4;
drop if hrbf_id1==97 & hrbf_id2==9 & c15_02==. & c15_03==.;
replace c15_03=9 if hrbf_id1==109 & hrbf_id2==1 & c15_02==2 & c15a_seq==1; 
replace c15_03=4 if hrbf_id1==167 & hrbf_id2==3 & c15_02==4 & c15_03==2;
replace c15_03=3 if hrbf_id1==167 & hrbf_id2==3 & c15_02==3 & c15_03==2;
replace c15_02=2 if hrbf_id1==167 & hrbf_id2==3 & c15_02==4 & c15_03==4;
replace c15_02=2 if hrbf_id1==167 & hrbf_id2==3 & c15_02==3 & c15_03==3;
drop dupl1 dupl2;
duplicates report hrbf_id1 hrbf_id2 c15_03;
duplicates report hrbf_id1 hrbf_id2 c15_02 c15a_seq;

tab1 c15_04 c15_05ad c15_05am c15_05ay c15_05bd c15_05bm c15_05by c15_05cd c15_05cm c15_05cy c15_05dd c15_05dm c15_05dy c15_05ed c15_05em c15_05ey c15_05fd c15_05fm c15_05fy c15_05gd c15_05gm c15_05gy c15_05hd c15_05hm c15_05hy c15_05id c15_05im c15_05iy c15_05jd c15_05jm c15_05jy, nolab;

replace c15_05ay=2009 if c15_05ay==9;
replace c15_05by=2009 if c15_05by==209;
* br if c15_05cy==3;
* use $cleandatadir/rwhrbf_household_roster.dta, clear;
* list hrbf_id1 hrbf_id2 a1_pid a1_11a a1_11b a1_15 if hrbf_id1==203 & hrbf_id2==9 & a1_pid==5;
* Child is 3 years old: 3 cannot be 2003, so should be 2009 (misreading at data entry);
replace c15_05cy=2009 if c15_05cy==3;
* br if c15_05fy==10 | c15_05fy==2020;
replace c15_05fy=2010 if c15_05fy==10;
replace c15_05fy=2010 if c15_05fy==2020;
* br if c15_05jy==0;
replace c15_05jy=. if c15_05jy==0;

foreach var of varlist c15_05ad c15_05bd c15_05cd c15_05dd c15_05ed c15_05fd c15_05gd c15_05hd c15_05id c15_05jd {;
	replace `var'=.a if `var'==0;
};
foreach letter in a b c d e f g h i j {;
	replace c15_05`letter'm=.a if c15_05`letter'd==.a;
	replace c15_05`letter'y=.a if c15_05`letter'd==.a;
};

foreach var of varlist c15_05ay c15_05by c15_05cy c15_05dy c15_05ey c15_05fy c15_05gy c15_05hy c15_05iy c15_05jy {;
	assert `var'>=2004 & (`var'<=2010 | `var'==. | `var'==.a);
};

* assert c15_04==1 if c15_05ad<. | c15_05am<. | c15_05ay<. | c15_05bd<. | c15_05bm<. | c15_05by<. | c15_05cd<. | c15_05cm<. | c15_05cy<. | c15_05dd<. | c15_05dm<. | c15_05dy<. | c15_05ed<. | c15_05em<. | c15_05ey<. | c15_05fd<. | c15_05fm<. | c15_05fy<. | c15_05gd<. | c15_05gm<. | c15_05gy<. | c15_05hd<. | c15_05hm<. | c15_05hy<. | c15_05id<. | c15_05im<. | c15_05iy<. | c15_05jd<. | c15_05jm<. | c15_05jy<.;
* br if c15_04!=1 & (c15_05ad<. | c15_05am<. | c15_05ay<. | c15_05bd<. | c15_05bm<. | c15_05by<. | c15_05cd<. | c15_05cm<. | c15_05cy<. | c15_05dd<. | c15_05dm<. | c15_05dy<. | c15_05ed<. | c15_05em<. | c15_05ey<. | c15_05fd<. | c15_05fm<. | c15_05fy<. | c15_05gd<. | c15_05gm<. | c15_05gy<. | c15_05hd<. | c15_05hm<. | c15_05hy<. | c15_05id<. | c15_05im<. | c15_05iy<. | c15_05jd<. | c15_05jm<. | c15_05jy<.);
replace c15_04=1 if c15_05ad<. | c15_05am<. | c15_05ay<. | c15_05bd<. | c15_05bm<. | c15_05by<. | c15_05cd<. | c15_05cm<. | c15_05cy<. | c15_05dd<. | c15_05dm<. | c15_05dy<. | c15_05ed<. | c15_05em<. | c15_05ey<. | c15_05fd<. | c15_05fm<. | c15_05fy<. | c15_05gd<. | c15_05gm<. | c15_05gy<. | c15_05hd<. | c15_05hm<. | c15_05hy<. | c15_05id<. | c15_05im<. | c15_05iy<. | c15_05jd<. | c15_05jm<. | c15_05jy<.;

* assert c15_04!=1 if c15_05ad>=. & c15_05am>=. & c15_05ay>=. & c15_05bd>=. & c15_05bm>=. & c15_05by>=. & c15_05cd>=. & c15_05cm>=. & c15_05cy>=. & c15_05dd>=. & c15_05dm>=. & c15_05dy>=. & c15_05ed>=. & c15_05em>=. & c15_05ey>=. & c15_05fd>=. & c15_05fm>=. & c15_05fy>=. & c15_05gd>=. & c15_05gm>=. & c15_05gy>=. & c15_05hd>=. & c15_05hm>=. & c15_05hy>=. & c15_05id>=. & c15_05im>=. & c15_05iy>=. & c15_05jd>=. & c15_05jm>=. & c15_05jy>=.;
* br if c15_04==1 & c15_05ad>=. & c15_05am>=. & c15_05ay>=. & c15_05bd>=. & c15_05bm>=. & c15_05by>=. & c15_05cd>=. & c15_05cm>=. & c15_05cy>=. & c15_05dd>=. & c15_05dm>=. & c15_05dy>=. & c15_05ed>=. & c15_05em>=. & c15_05ey>=. & c15_05fd>=. & c15_05fm>=. & c15_05fy>=. & c15_05gd>=. & c15_05gm>=. & c15_05gy>=. & c15_05hd>=. & c15_05hm>=. & c15_05hy>=. & c15_05id>=. & c15_05im>=. & c15_05iy>=. & c15_05jd>=. & c15_05jm>=. & c15_05jy>=.;
foreach var of varlist c15_05ad c15_05bd c15_05cd c15_05dd c15_05ed c15_05fd c15_05gd c15_05hd c15_05id c15_05jd {;
	replace `var'=.a if c15_04==1 & c15_05ad>=. & c15_05am>=. & c15_05ay>=. & c15_05bd>=. & c15_05bm>=. & c15_05by>=. & c15_05cd>=. & c15_05cm>=. & c15_05cy>=. & c15_05dd>=. & c15_05dm>=. & c15_05dy>=. & c15_05ed>=. & c15_05em>=. & c15_05ey>=. & c15_05fd>=. & c15_05fm>=. & c15_05fy>=. & c15_05gd>=. & c15_05gm>=. & c15_05gy>=. & c15_05hd>=. & c15_05hm>=. & c15_05hy>=. & c15_05id>=. & c15_05im>=. & c15_05iy>=. & c15_05jd>=. & c15_05jm>=. & c15_05jy>=.;
};

foreach letter in a b c d e f g h i j {;
	assert c15_05`letter'd<. if c15_05`letter'm<. | c15_05`letter'y<.;
	assert c15_05`letter'm<. if c15_05`letter'd<. | c15_05`letter'y<.;
	assert c15_05`letter'y<. if c15_05`letter'm<. | c15_05`letter'd<.;
};

sort hrbf_id1 hrbf_id2 c15_03;
save $cleandatadir/rwhrbf_c02.dta, replace;

************************************
*** Create rwhrbf_c02_with_studyarms
************************************;

ren c15_03 a1_pid;
save $tempdatadir/rwhrbf_c02.dta, replace;

use $cleandatadir/rwhrbf_household_roster.dta, clear;
merge hrbf_id1 hrbf_id2 a1_pid using $tempdatadir/rwhrbf_c02.dta, unique;
tab _merge;
list hrbf_id1 hrbf_id2 a1_pid a1_02 if _merge==2;
drop if _merge==2;
drop _merge;
* assert a1_11a<5 if c15_04<. | c15_05ad<. | c15_05am<. | c15_05ay<. | c15_05bd<. | c15_05bm<. | c15_05by<. | c15_05cd<. | c15_05cm<. | c15_05cy<. | c15_05dd<. | c15_05dm<. | c15_05dy<. | c15_05ed<. | c15_05em<. | c15_05ey<. | c15_05fd<. | c15_05fm<. | c15_05fy<. | c15_05gd<. | c15_05gm<. | c15_05gy<. | c15_05hd<. | c15_05hm<. | c15_05hy<. | c15_05id<. | c15_05im<. | c15_05iy<. | c15_05jd<. | c15_05jm<. | c15_05jy<.;
list hrbf_id1 hrbf_id2 a1_pid a1_11a a1_11b if a1_11a>=5 & (c15_04<. | c15_05ad<. | c15_05am<. | c15_05ay<. | c15_05bd<. | c15_05bm<. | c15_05by<. | c15_05cd<. | c15_05cm<. | c15_05cy<. | c15_05dd<. | c15_05dm<. | c15_05dy<. | c15_05ed<. | c15_05em<. | c15_05ey<. | c15_05fd<. | c15_05fm<. | c15_05fy<. | c15_05gd<. | c15_05gm<. | c15_05gy<. | c15_05hd<. | c15_05hm<. | c15_05hy<. | c15_05id<. | c15_05im<. | c15_05iy<. | c15_05jd<. | c15_05jm<. | c15_05jy<.);
drop if a1_11a>=5 & (c15_04<. | c15_05ad<. | c15_05am<. | c15_05ay<. | c15_05bd<. | c15_05bm<. | c15_05by<. | c15_05cd<. | c15_05cm<. | c15_05cy<. | c15_05dd<. | c15_05dm<. | c15_05dy<. | c15_05ed<. | c15_05em<. | c15_05ey<. | c15_05fd<. | c15_05fm<. | c15_05fy<. | c15_05gd<. | c15_05gm<. | c15_05gy<. | c15_05hd<. | c15_05hm<. | c15_05hy<. | c15_05id<. | c15_05im<. | c15_05iy<. | c15_05jd<. | c15_05jm<. | c15_05jy<.);

save $cleandatadir/rwhrbf_c02_withstudyarms.dta, replace;



*********************************************
*** Create necessary variables for mean tests
*********************************************;

gen c15_04_1=c15_04==1 | c15_04==2;
replace c15_04_1=. if c15_04==.;
lab var c15_04_1 "Had vaccination card seen/unseen";

gen c15_04_2=c15_04==1;
replace c15_04_2=. if c15_04==.;
lab var c15_04_2 "Had vaccination card seen";

* Calculate interval between birth/interview and dates of vaccination;

egen dateitw_str=concat(a0_in1_d a0_in1_m a0_in1_y), punct(-);
gen dateitw=date(dateitw_str, "DMY");

gen a1_10_d2=a1_10_d;
replace a1_10_d2=1 if a1_10_d==. & a1_10_y!=.;
gen a1_10_m2=a1_10_m;
replace a1_10_m2=1 if a1_10_m==. & a1_10_y!=.;
egen datebirth_str=concat(a1_10_d2 a1_10_m2 a1_10_y), punct(-);
gen datebirth=date(datebirth_str, "DMY");

egen dateBCG_str=concat(c15_05ad c15_05am c15_05ay), punct(-);
gen dateBCG=date(dateBCG_str, "DMY");
egen dateOPV0_str=concat(c15_05bd c15_05bm c15_05by), punct(-);
gen dateOPV0=date(dateOPV0_str, "DMY");
egen dateOPV1_str=concat(c15_05cd c15_05cm c15_05cy), punct(-);
gen dateOPV1=date(dateOPV1_str, "DMY");
egen dateOPV2_str=concat(c15_05dd c15_05dm c15_05dy), punct(-);
gen dateOPV2=date(dateOPV2_str, "DMY");
egen dateOPV3_str=concat(c15_05ed c15_05em c15_05ey), punct(-);
gen dateOPV3=date(dateOPV3_str, "DMY");
egen datePENTV1_str=concat(c15_05fd c15_05fm c15_05fy), punct(-);
gen datePENTV1=date(datePENTV1_str, "DMY");
egen datePENTV2_str=concat(c15_05gd c15_05gm c15_05gy), punct(-);
gen datePENTV2=date(datePENTV2_str, "DMY"); 
egen datePENTV3_str=concat(c15_05hd c15_05hm c15_05hy), punct(-);
gen datePENTV3=date(datePENTV3_str, "DMY");
egen dateMEASLES_str=concat(c15_05id c15_05im c15_05iy), punct(-);
gen dateMEASLES=date(dateMEASLES_str, "DMY");
egen dateVitA_str=concat(c15_05jd c15_05jm c15_05jy), punct(-);
gen dateVitA=date(dateVitA_str, "DMY");

gen PENTV3_before1=datePENTV3-datebirth<=365;
replace PENTV3_before1=. if datebirth==.;
lab var PENTV3_before1 "Got PENTV3 vaccine before age 1y";
* Note: Children having missing date of PENTV3 vaccine are considered as PENTV3_before1=0, i.e. as children who were not vaccinated before age 1. I assume children who don't have a card or for which card hasn't been seen are not vaccinated. Possible under estimation of vaccination rate if children were vaccinated but vaccine card was not presented or no vaccine card was obtained by the mother at the time of vaccination;

gen MEASLES_before1=dateMEASLES-datebirth<=365;
replace MEASLES_before1=. if datebirth==.;
lab var MEASLES_before1 "Got MEASLES vaccine before age 1y";
* Note: same as note PENTV3_before1;



***
*** Indicators
***;

gen c15_05h_100=.;
replace c15_05h_100=1 if (round(a1_11b)>=12 & round(a1_11b)<=23) & c15_05fd<. & c15_05fm<. & c15_05fy<. & c15_05gd<. & c15_05gm<. & c15_05gy<. & c15_05hd<. & c15_05hm<. & c15_05hy<. & PENTV3_before1==1;
replace c15_05h_100=0 if (round(a1_11b)>=12 & round(a1_11b)<=23) & (c15_05fd>=. | c15_05fm>=. | c15_05fy>=. | c15_05gd>=. | c15_05gm>=. | c15_05gy>=. | c15_05hd>=. | c15_05hm>=. | c15_05hy>=. | PENTV3_before1==0);
lab var c15_05h_100 "Pentavalent immu coverage 12-23m";
* Possible under estimation because all children are included in denominator, including those for whom no vaccination card was seen;
* WHO/JHU report indicator;

gen c15_05h_101=.;
replace c15_05h_101=1 if (round(a1_11b)>=12 & round(a1_11b)<=23) & c15_05fd<. & c15_05fm<. & c15_05fy<. & c15_05gd<. & c15_05gm<. & c15_05gy<. & c15_05hd<. & c15_05hm<. & c15_05hy<. & PENTV3_before1==1 & c15_04_2==1;
replace c15_05h_101=0 if (round(a1_11b)>=12 & round(a1_11b)<=23) & (c15_05fd>=. | c15_05fm>=. | c15_05fy>=. | c15_05gd>=. | c15_05gm>=. | c15_05gy>=. | c15_05hd>=. | c15_05hm>=. | c15_05hy>=. | PENTV3_before1==0) & c15_04_2==1;
lab var c15_05h_101 "PentaV cover 12-23m w/vacc card";
* Possible over estimation because only children with vaccination card are included in denominator, excluding those who don't have a vaccination card because they were not vaccinated;
* WHO/JHU report indicator;

gen c15_05i_100=.;
replace c15_05i_100=1 if (round(a1_11b)>=12 & round(a1_11b)<=23) & c15_05id<. & c15_05im<. & c15_05iy<. & MEASLES_before1==1;
replace c15_05i_100=0 if (round(a1_11b)>=12 & round(a1_11b)<=23) & (c15_05id>=. | c15_05im>=. | c15_05iy>=. | MEASLES_before1==0);
lab var c15_05i_100 "Measles immu coverage 12-23m";
* Possible under estimation because all children are included in denominator, including those for whom no vaccination card was seen;
* JHU report indicator;

gen c15_05i_101=.;
replace c15_05i_101=1 if (round(a1_11b)>=12 & round(a1_11b)<=23) & c15_05id<. & c15_05im<. & c15_05iy<. & MEASLES_before1==1 & c15_04_2==1;
replace c15_05i_101=0 if (round(a1_11b)>=12 & round(a1_11b)<=23) & (c15_05id>=. | c15_05im>=. | c15_05iy>=. | MEASLES_before1==0) & c15_04_2==1;
lab var c15_05i_101 "Measles cover 12-23m w/vacc card";
* Possible over estimation because only children with vaccination card are included in denominator, excluding those who don't have a vaccination card because they were not vaccinated;
* JHU report indicator;

gen c15_05i_102=.;
replace c15_05i_102=1 if round(a1_11b)<12 & c15_05id<. & c15_05im<. & c15_05iy<. & MEASLES_before1==1;
replace c15_05i_102=0 if round(a1_11b)<12 & (c15_05id>=. | c15_05im>=. | c15_05iy>=. | MEASLES_before1==0);
lab var c15_05i_102 "Measles immu coverage 0-12m";
* Possible under estimation because all children are included in denominator, including those for whom no vaccination card was seen;
* WHO indicator;

gen c15_05i_103=.;
replace c15_05i_103=1 if round(a1_11b)<12 & c15_05id<. & c15_05im<. & c15_05iy<. & MEASLES_before1==1 & c15_04_2==1;
replace c15_05i_103=0 if round(a1_11b)<12 & (c15_05id>=. | c15_05im>=. | c15_05iy>=. | MEASLES_before1==0) & c15_04_2==1;
lab var c15_05i_103 "Measles cover 0-12m w/vacc card";
* Possible over estimation because only children with vaccination card are included in denominator, excluding those who don't have a vaccination card because they were not vaccinated;
* WHO indicator;

gen c15_05j_100=dateitw-dateVitA<=182.5;
replace c15_05j_100=. if dateitw==.;
lab var c15_05j_100 "VitA coverage last 6m";
* Possible under estimation because all children are included in denominator, including those for whom no vaccination card was seen;
* WHO/JHU report indicator;

gen c15_05j_101=dateitw-dateVitA<=182.5 & c15_04_2==1;
replace c15_05j_101=. if dateitw==. | c15_04_2!=1;
lab var c15_05j_101 "VitA cover last 6m w/vacc card";
* Possible over estimation because only children with vaccination card are included in denominator, excluding those who don't have a vaccination card because they were not vaccinated;
* WHO/JHU report indicator;

svyset [pweight=hhpweight], psu(hrbf_id1);
save $cleandatadir/rwhrbf_c02_withstudyarms_withvarformeantests.dta, replace;

log close;































