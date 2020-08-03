* Elisa Rothenbuhler - Aug 10

* This do-file:
* Creates clean female b08 dataset: $cleandatadir/rwhrbf_b08.dta 
* Merges $cleandatadir/rwhrbf_b08.dta with household roster.

version 10.0
clear
set more off
set mem 500m
cap log close

#delimit ;

log using $logdir/rwanda_cr6_b08.log, replace;


*********************
*** Clean b08 section
*********************;

use $origdatadir/RWHRBF_B_FEMALE-08.dta, clear;
drop if b13_111a==. & b13_111b==. & b13_111c==. & b13_111d==. & b13_112a==. & b13_112b==. & b13_112c==. & b13_112d==. & b13_113a==. & b13_113b==. & b13_113c==. & b13_113d==. & b13_113e==. & b13_114a==. & b13_114b==. & b13_114c==. & b13_114d==. & b13_115a==. & b13_115b==. & b13_115c==. & b13_115d==. & b13_116a==. & b13_116b==. & b13_116c==. & b13_116d==. & b13_116e==. & b13_117a==. & b13_117b==. & b13_117c==. & b13_117d==. & b13_117e==.;
* assert b13e_pid!=.;
list hrbf_id1 hrbf_id2 b13e_pid if b13e_pid==.;

***
*** 14 missing b13e_pid in households 7-6, 12-11, 96-10, 112-1, 169-7, 176-5, 176-8, 176-9, 176-10, 176-11, 176-12, 209-12.
***;

drop if b13e_pid==.;
duplicates report hrbf_id1 hrbf_id2 b13e_pid;
duplicates tag hrbf_id1 hrbf_id2 b13e_pid, gen(dupl);
list hrbf_id1 hrbf_id2  b13e_pid if dupl!=0;
drop dupl;

* use $cleandatadir/rwhrbf_household_roster.dta, clear;
* list hrbf_id1 hrbf_id2 a1_pid a1_09 a1_02 a1_11a if (hrbf_id1==28 & hrbf_id2==6) | (hrbf_id1==34 & hrbf_id2==8) | (hrbf_id1==34 & hrbf_id2==9) | (hrbf_id1==116 & hrbf_id2==2) | (hrbf_id1==116 & hrbf_id2==10) | (hrbf_id1==193 & hrbf_id2==4);
* Change PIDs in rwhrbf_b08.dta according to information in household roster;
sort hrbf_id1 hrbf_id2 b13e_pid;
replace b13e_pid=3 if hrbf_id1==28 & hrbf_id2==6 & b13e_pid==2 & hrbf_id1[_n-1]==28 & hrbf_id2[_n-1]==6 & b13e_pid[_n-1]==2;
replace b13e_pid=1 if hrbf_id1==34 & hrbf_id2==8 & b13e_pid==2 & hrbf_id1[_n+1]==34 & hrbf_id2[_n+1]==8 & b13e_pid[_n+1]==2;
replace b13e_pid=3 if hrbf_id1==34 & hrbf_id2==9 & b13e_pid==2;
replace b13e_pid=6 if hrbf_id1==34 & hrbf_id2==9 & b13e_pid==3 & hrbf_id1[_n-1]==34 & hrbf_id2[_n-1]==9 & b13e_pid[_n-1]==3;
replace b13e_pid=7 if hrbf_id1==116 & hrbf_id2==2 & b13e_pid==2 & hrbf_id1[_n-1]==116 & hrbf_id2[_n-1]==2 & b13e_pid[_n-1]==2;
replace b13e_pid=3 if hrbf_id1==116 & hrbf_id2==10 & b13e_pid==2 & hrbf_id1[_n-1]==116 & hrbf_id2[_n-1]==10 & b13e_pid[_n-1]==2;
replace b13e_pid=3 if hrbf_id1==193 & hrbf_id2==4 & b13e_pid==2 & hrbf_id1[_n-1]==193 & hrbf_id2[_n-1]==4 & b13e_pid[_n-1]==2;

duplicates report hrbf_id1 hrbf_id2 b13e_pid;

sort hrbf_id1 hrbf_id2 b13e_pid;
save $cleandatadir/rwhrbf_b08.dta, replace;



**********************************************************************
*** Create rwhrbf_b08_with_studyarms - Correct entries in rwbf_b08.dta
**********************************************************************;

ren b13e_pid a1_pid;
save $tempdatadir/rwhrbf_b08.dta, replace;

use $cleandatadir/rwhrbf_household_roster.dta, clear;
merge hrbf_id1 hrbf_id2 a1_pid using $tempdatadir/rwhrbf_b08.dta, unique;
tab _merge;
list hrbf_id1 hrbf_id2 a1_pid a1_02 if _merge==2;
drop if _merge==2;
drop _merge;
* assert a1_02==2 if b13_111a!=. | b13_111b!=. | b13_111c!=. | b13_111d!=. | b13_112a!=. | b13_112b!=. | b13_112c!=. | b13_112d!=. | b13_113a!=. | b13_113b!=. | b13_113c!=. | b13_113d!=. | b13_113e!=. | b13_114a!=. | b13_114b!=. | b13_114c!=. | b13_114d!=. | b13_115a!=. | b13_115b!=. | b13_115c!=. | b13_115d!=. | b13_116a!=. | b13_116b!=. | b13_116c!=. | b13_116d!=. | b13_116e!=. | b13_117a!=. | b13_117b!=. | b13_117c!=. | b13_117d!=. | b13_117e!=.;
list hrbf_id1 hrbf_id2 a1_pid a1_02 a1_09 a1_11a a1_11b if a1_02!=2 & (b13_111a!=. | b13_111b!=. | b13_111c!=. | b13_111d!=. | b13_112a!=. | b13_112b!=. | b13_112c!=. | b13_112d!=. | b13_113a!=. | b13_113b!=. | b13_113c!=. | b13_113d!=. | b13_113e!=. | b13_114a!=. | b13_114b!=. | b13_114c!=. | b13_114d!=. | b13_115a!=. | b13_115b!=. | b13_115c!=. | b13_115d!=. | b13_116a!=. | b13_116b!=. | b13_116c!=. | b13_116d!=. | b13_116e!=. | b13_117a!=. | b13_117b!=. | b13_117c!=. | b13_117d!=. | b13_117e!=.);
list hrbf_id1 hrbf_id2 a1_pid a1_09 a1_02 a1_11a if (hrbf_id1==9 & hrbf_id2==8) | (hrbf_id1==13 & hrbf_id2==5) | (hrbf_id1==14 & hrbf_id2==6) | (hrbf_id1==30 & hrbf_id2==6) | (hrbf_id1==33 & hrbf_id2==6) | (hrbf_id1==37 & hrbf_id2==7) | (hrbf_id1==56 & hrbf_id2==2) | (hrbf_id1==60 & hrbf_id2==7) | (hrbf_id1==62 & hrbf_id2==11) | (hrbf_id1==65 & hrbf_id2==3) | (hrbf_id1==95 & hrbf_id2==9) | (hrbf_id1==104 & hrbf_id2==10) | (hrbf_id1==109 & hrbf_id2==2) | (hrbf_id1==128 & hrbf_id2==6) | (hrbf_id1==161 & hrbf_id2==8) | (hrbf_id1==164 & hrbf_id2==1) | (hrbf_id1==167 & hrbf_id2==10) | (hrbf_id1==169 & hrbf_id2==11) | (hrbf_id1==182 & hrbf_id2==12) | (hrbf_id1==203 & hrbf_id2==5) | (hrbf_id1==204 & hrbf_id2==1) | (hrbf_id1==213 & hrbf_id2==10);
* use $origdatadir/RWHRBF_B_FEMALE-08.dta, clear;
* list hrbf_id1 hrbf_id2 b13e_pid if (hrbf_id1==9 & hrbf_id2==8) | (hrbf_id1==13 & hrbf_id2==5) | (hrbf_id1==14 & hrbf_id2==6) | (hrbf_id1==30 & hrbf_id2==6) | (hrbf_id1==33 & hrbf_id2==6) | (hrbf_id1==37 & hrbf_id2==7) | (hrbf_id1==56 & hrbf_id2==2) | (hrbf_id1==60 & hrbf_id2==7) | (hrbf_id1==62 & hrbf_id2==11) | (hrbf_id1==65 & hrbf_id2==3) | (hrbf_id1==95 & hrbf_id2==9) | (hrbf_id1==104 & hrbf_id2==10) | (hrbf_id1==109 & hrbf_id2==2) | (hrbf_id1==128 & hrbf_id2==6) | (hrbf_id1==161 & hrbf_id2==8) | (hrbf_id1==164 & hrbf_id2==1) | (hrbf_id1==167 & hrbf_id2==10) | (hrbf_id1==169 & hrbf_id2==11) | (hrbf_id1==182 & hrbf_id2==12) | (hrbf_id1==203 & hrbf_id2==5) | (hrbf_id1==204 & hrbf_id2==1) | (hrbf_id1==213 & hrbf_id2==10);
* Change PIDs in rwhrbf_b08.dta according to information in household roster;

use $cleandatadir/rwhrbf_b08.dta, clear;
replace b13e_pid=1 if hrbf_id1==9 & hrbf_id2==8 & b13e_pid==2;
replace b13e_pid=2 if hrbf_id1==13 & hrbf_id2==5 & b13e_pid==1;
replace b13e_pid=2 if hrbf_id1==14 & hrbf_id2==6 & b13e_pid==1;
replace b13e_pid=2 if hrbf_id1==30 & hrbf_id2==6 & b13e_pid==1;
replace b13e_pid=2 if hrbf_id1==33 & hrbf_id2==6 & b13e_pid==1;
replace b13e_pid=2 if hrbf_id1==37 & hrbf_id2==7 & b13e_pid==1;
replace b13e_pid=2 if hrbf_id1==56 & hrbf_id2==2 & b13e_pid==1;
replace b13e_pid=2 if hrbf_id1==60 & hrbf_id2==7 & b13e_pid==1;
replace b13e_pid=2 if hrbf_id1==62 & hrbf_id2==11 & b13e_pid==1;
replace b13e_pid=2 if hrbf_id1==65 & hrbf_id2==3 & b13e_pid==6;
replace b13e_pid=2 if hrbf_id1==95 & hrbf_id2==9 & b13e_pid==1;
replace b13e_pid=1 if hrbf_id1==104 & hrbf_id2==10 & b13e_pid==2;
replace b13e_pid=2 if hrbf_id1==109 & hrbf_id2==2 & b13e_pid==1;
replace b13e_pid=1 if hrbf_id1==128 & hrbf_id2==6 & b13e_pid==2;
replace b13e_pid=1 if hrbf_id1==161 & hrbf_id2==8 & b13e_pid==2;
replace b13e_pid=2 if hrbf_id1==164 & hrbf_id2==1 & b13e_pid==1;
replace b13e_pid=2 if hrbf_id1==167 & hrbf_id2==10 & b13e_pid==1;
replace b13e_pid=4 if hrbf_id1==169 & hrbf_id2==11 & b13e_pid==3;
replace b13e_pid=3 if hrbf_id1==182 & hrbf_id2==12 & b13e_pid==2;
replace b13e_pid=3 if hrbf_id1==203 & hrbf_id2==5 & b13e_pid==2;
replace b13e_pid=2 if hrbf_id1==204 & hrbf_id2==1 & b13e_pid==1;
replace b13e_pid=1 if hrbf_id1==213 & hrbf_id2==10 & b13e_pid==2;

sort hrbf_id1 hrbf_id2 b13e_pid;
save $cleandatadir/rwhrbf_b08.dta, replace;

ren b13e_pid a1_pid;
save $tempdatadir/rwhrbf_b08.dta, replace;

use $cleandatadir/rwhrbf_household_roster.dta, clear;
merge hrbf_id1 hrbf_id2 a1_pid using $tempdatadir/rwhrbf_b08.dta, unique;
tab _merge;
list hrbf_id1 hrbf_id2 a1_pid a1_02 if _merge==2;
drop if _merge==2;
drop _merge;
assert a1_02==2 if b13_111a!=. | b13_111b!=. | b13_111c!=. | b13_111d!=. | b13_112a!=. | b13_112b!=. | b13_112c!=. | b13_112d!=. | b13_113a!=. | b13_113b!=. | b13_113c!=. | b13_113d!=. | b13_113e!=. | b13_114a!=. | b13_114b!=. | b13_114c!=. | b13_114d!=. | b13_115a!=. | b13_115b!=. | b13_115c!=. | b13_115d!=. | b13_116a!=. | b13_116b!=. | b13_116c!=. | b13_116d!=. | b13_116e!=. | b13_117a!=. | b13_117b!=. | b13_117c!=. | b13_117d!=. | b13_117e!=.;

sort hrbf_id1 hrbf_id2 a1_pid;
save $cleandatadir/rwhrbf_b08_withstudyarms.dta, replace;

log close;