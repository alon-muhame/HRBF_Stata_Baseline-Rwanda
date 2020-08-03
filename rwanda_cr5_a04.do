* Elisa Rothenbuhler - Aug 10

* This do-file:
* Creates clean household a04 dataset: $cleandatadir/rwhrbf_a04.dta.
* Merges $cleandatadir/rwhrbf_a04.dta with household roster.

version 10.0
clear
set more off
set mem 500m
cap log close

#delimit ;

log using $logdir/rwanda_cr5_a04_b08.log, replace;


*********************
*** Clean a04 section
*********************;

use $origdatadir/RWHRBF_A_HOUSEHOLD-04.dta, clear;

drop if a4_10a==. & a4_10b==. & a4_10c==. & a4_10d==. & a4_11a==. & a4_11b==. & a4_11c==. & a4_11d==. & a4_12a==. & a4_12b==. & a4_12c==. & a4_12d==. & a4_12e==. & a4_13a==. & a4_13b==. & a4_13c==. & a4_13d==. & a4_14a==. & a4_14b==. & a4_14c==. & a4_14d==. & a4_15a==. & a4_15b==. & a4_15c==. & a4_15d==. & a4_15e==. & a4_16a==. & a4_16b==. & a4_16c==. & a4_16d==. & a4_16e==.;
* assert a4_pid!=.;
list hrbf_id1 hrbf_id2 a4_pid if a4_pid==.;

***
*** 4 missing a4_pid in households 127-1, 180-5, 180-11, 180-12.
***;

drop if a4_pid==.;
duplicates report hrbf_id1 hrbf_id2 a4_pid;

replace a4_10a=. if a4_10a==6;
replace a4_16e=. if a4_16e==0;

sort hrbf_id1 hrbf_id2 a4_pid;
save $cleandatadir/rwhrbf_a04.dta, replace;



************************************************************************
*** Create rwhrbf_a04_with_studyarms - Correct entries in rwhrbf_a04.dta
************************************************************************;

ren a4_pid a1_pid;
save $tempdatadir/rwhrbf_a04.dta, replace;

use $cleandatadir/rwhrbf_household_roster.dta, clear;
merge hrbf_id1 hrbf_id2 a1_pid using $tempdatadir/rwhrbf_a04.dta, unique;
tab _merge;
list hrbf_id1 hrbf_id2 a1_pid a1_02 if _merge==2;
drop if _merge==2;
drop _merge;
* assert a1_02==1 if a4_10a!=. | a4_10b!=. | a4_10c!=. | a4_10d!=. | a4_11a!=. | a4_11b!=. | a4_11c!=. | a4_11d!=. | a4_12a!=. | a4_12b!=. | a4_12c!=. | a4_12d!=. | a4_12e!=. | a4_13a!=. | a4_13b!=. | a4_13c!=. | a4_13d!=. | a4_14a!=. | a4_14b!=. | a4_14c!=. | a4_14d!=. | a4_15a!=. | a4_15b!=. | a4_15c!=. | a4_15d!=. | a4_15e!=. | a4_16a!=. | a4_16b!=. | a4_16c!=. | a4_16d!=. | a4_16e!=.;
list hrbf_id1 hrbf_id2 a1_pid a1_02 a1_09 a1_11a a1_11b if a1_02!=1 & (a4_10a!=. | a4_10b!=. | a4_10c!=. | a4_10d!=. | a4_11a!=. | a4_11b!=. | a4_11c!=. | a4_11d!=. | a4_12a!=. | a4_12b!=. | a4_12c!=. | a4_12d!=. | a4_12e!=. | a4_13a!=. | a4_13b!=. | a4_13c!=. | a4_13d!=. | a4_14a!=. | a4_14b!=. | a4_14c!=. | a4_14d!=. | a4_15a!=. | a4_15b!=. | a4_15c!=. | a4_15d!=. | a4_15e!=. | a4_16a!=. | a4_16b!=. | a4_16c!=. | a4_16d!=. | a4_16e!=.);
list hrbf_id1 hrbf_id2 a1_pid a1_09 a1_02 a1_11a if (hrbf_id1==97 & hrbf_id2==9) | (hrbf_id1==155 & hrbf_id2==8) | (hrbf_id1==196 & hrbf_id2==10) | (hrbf_id1==203 & hrbf_id2==4);
* use $origdatadir/RWHRBF_A_HOUSEHOLD-04.dta, clear;
* list hrbf_id1 hrbf_id2 a4_pid if (hrbf_id1==97 & hrbf_id2==9) | (hrbf_id1==155 & hrbf_id2==8) | (hrbf_id1==196 & hrbf_id2==10) | (hrbf_id1==203 & hrbf_id2==4); 
* Change PIDs in rwhrbf_a04.dta according to information in household roster;

use $cleandatadir/rwhrbf_a04.dta, clear;
replace a4_pid=8 if hrbf_id1==97 & hrbf_id2==9 & a4_pid==1;
replace a4_pid=2 if hrbf_id1==155 & hrbf_id2==8 & a4_pid==1;
replace a4_pid=4 if hrbf_id1==196 & hrbf_id2==10 & a4_pid==1;
replace a4_pid=3 if hrbf_id1==203 & hrbf_id2==4 & a4_pid==1;

save $cleandatadir/rwhrbf_a04.dta, replace;

sort hrbf_id1 hrbf_id2 a4_pid;
ren a4_pid a1_pid;
save $tempdatadir/rwhrbf_a04.dta, replace;

use $cleandatadir/rwhrbf_household_roster.dta, clear;
merge hrbf_id1 hrbf_id2 a1_pid using $tempdatadir/rwhrbf_a04.dta, unique;
tab _merge;
list hrbf_id1 hrbf_id2 a1_pid a1_02 if _merge==2;
drop if _merge==2;
drop _merge;
assert a1_02==1 if a4_10a!=. | a4_10b!=. | a4_10c!=. | a4_10d!=. | a4_11a!=. | a4_11b!=. | a4_11c!=. | a4_11d!=. | a4_12a!=. | a4_12b!=. | a4_12c!=. | a4_12d!=. | a4_12e!=. | a4_13a!=. | a4_13b!=. | a4_13c!=. | a4_13d!=. | a4_14a!=. | a4_14b!=. | a4_14c!=. | a4_14d!=. | a4_15a!=. | a4_15b!=. | a4_15c!=. | a4_15d!=. | a4_15e!=. | a4_16a!=. | a4_16b!=. | a4_16c!=. | a4_16d!=. | a4_16e!=.;

sort hrbf_id1 hrbf_id2 a1_pid;
save $cleandatadir/rwhrbf_a04_withstudyarms.dta, replace;

log close;



