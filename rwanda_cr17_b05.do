* Elisa Rothenbuhler - Sep 10

* This do-file:
* Creates clean female b05 dataset: $cleandatadir/rwhrbf_b05.dta.
* Merges $cleandatadir/rwhrbf_b05.dta with household roster.
* Generates appropriate variables for mean tests.


version 10.0
clear
set more off
set mem 500m
cap log close

#delimit ;

log using $logdir/rwanda_cr17_b05.log, replace;



*********************
*** Clean b05 section
*********************;

use $origdatadir/RWHRBF_B_FEMALE-05.dta, clear;
drop if b13b_seq==. & b13_020==. & b13_021==. & b13_022n==. & b13_023==. & b13_024==. & b13_025d==. & b13_025m==. & b13_025y==. & b13_026==. & b13_027==. & b13_028==. & b13_029==. & b13_030a==. & b13_030b==. & b13_031==.;

* assert b13_020!=. | b13_022n!=.;
sort hrbf_id1 hrbf_id2 b13_020 b13_022n;
list hrbf_id1 hrbf_id2 b13_020 b13_022n b13b_seq if b13_020==. | b13_022n==.;
list hrbf_id1 hrbf_id2 b13_020 b13_022n b13b_seq b13_023 b13_024 b13_025d b13_025m b13_025y if (hrbf_id1==15 & hrbf_id2==8) | (hrbf_id1==20 & hrbf_id2==2) | (hrbf_id1==33 & hrbf_id2==6) | (hrbf_id1==64 & hrbf_id2==2) | (hrbf_id1==81 & hrbf_id2==6) | (hrbf_id1==88 & hrbf_id2==9) | (hrbf_id1==109 & hrbf_id2==8) | (hrbf_id1==133 & hrbf_id2==12) | (hrbf_id1==141 & hrbf_id2==6) | (hrbf_id1==169 & hrbf_id2==11) | (hrbf_id1==171 & hrbf_id2==7) | (hrbf_id1==172 & hrbf_id2==12) | (hrbf_id1==182 & hrbf_id2==4) | (hrbf_id1==203 & hrbf_id2==5) | (hrbf_id1==203 & hrbf_id2==8) | (hrbf_id1==211 & hrbf_id2==11) | (hrbf_id1==220 & hrbf_id2==2);
replace b13_020=1 if _n==4571;
replace b13_022n=2 if _n==4571;
replace b13_020=1 if _n==5726;
replace b13_022n=1 if _n==6797;
replace b13_020=2 if _n==7346;
drop if b13_020==. | b13_022n==.;
* bysort hrbf_id1 hrbf_id2 b13_020: assert _N==b13_021;
bysort hrbf_id1 hrbf_id2 b13_020: replace b13_021=_N;
tab b13_021;
list hrbf_id1 hrbf_id2 b13b_seq b13_020 b13_021 b13_022n b13_023 b13_024 b13_025d b13_025m b13_025y if b13_021>=10, compress;
drop if hrbf_id1==66 & hrbf_id2==11 & b13_020==2 & b13b_seq==.;
bysort hrbf_id1 hrbf_id2 b13_020: replace b13_021=_N;
duplicates tag hrbf_id1 hrbf_id2 b13_020 b13_022n, gen(dupl);
list hrbf_id1 hrbf_id2 b13_020 b13_022n b13b_seq if dupl!=0;
list hrbf_id1 hrbf_id2 b13_020 b13_022n b13b_seq b13_023 b13_024 b13_025d b13_025m b13_025y if (hrbf_id1==55 & hrbf_id2==11 & b13_020==2) | (hrbf_id1==116 & hrbf_id2==3 & b13_020==2) |  (hrbf_id1==121 & hrbf_id2==9 & b13_020==2) |  (hrbf_id1==182 & hrbf_id2==2 & b13_020==2), compress;
replace b13_022n=7 if hrbf_id1==55 & hrbf_id2==11 & b13_020==2 & b13b_seq==7;
replace b13_022n=2 if hrbf_id1==116 & hrbf_id2==3 & b13_020==2 & b13b_seq==2;
replace b13_022n=1 if hrbf_id1==121 & hrbf_id2==9 & b13_020==2 & b13b_seq==1;
replace b13_022n=2 if hrbf_id1==121 & hrbf_id2==9 & b13_020==2 & b13b_seq==2;
replace b13_022n=3 if hrbf_id1==121 & hrbf_id2==9 & b13_020==2 & b13b_seq==3;
replace b13_022n=1 if hrbf_id1==182 & hrbf_id2==2 & b13_020==2 & b13b_seq==1;
replace b13_022n=2 if hrbf_id1==182 & hrbf_id2==2 & b13_020==2 & b13b_seq==2;
replace b13_022n=3 if hrbf_id1==182 & hrbf_id2==2 & b13_020==2 & b13b_seq==3;
drop if hrbf_id1==182 & hrbf_id2==2 & b13_020==2 & b13b_seq==.;
duplicates report hrbf_id1 hrbf_id2 b13_020 b13_022n;

*** Ensure the series of b13_022n start from 1 for each woman;
bysort hrbf_id1 hrbf_id2 b13_020: egen b13_022n_1=count(b13_022n);
bysort hrbf_id1 hrbf_id2 b13_020: replace b13_022n_1=b13_022n_1 - (b13_022n_1-1);
gen b13_022n_2=b13_022n==b13_022n_1;
bysort hrbf_id1 hrbf_id2 b13_020: egen b13_022n_3=total(b13_022n_2);
* bysort hrbf_id1 hrbf_id2 b13_020: assert b13_022n_3==1;
sort hrbf_id1 hrbf_id2 b13_020 b13_022n;
list hrbf_id1 hrbf_id2 b13_020 b13_022n b13b_seq b13_023 b13_024 b13_025d b13_025m b13_025y if b13_022n_3!=1;
list hrbf_id1 hrbf_id2 b13_020 b13b_seq b13_022n b13_023 b13_024 b13_025d b13_025m b13_025y if (hrbf_id1==14 & hrbf_id2==4) | (hrbf_id1==82 & hrbf_id2==2);
replace b13_022n=1 if _n==465;
replace b13_020=2 if _n==2721;
drop b13_022n_1 b13_022n_2 b13_022n_3;

replace b13_024=2 if b13_024==0;
replace b13_025d=. if b13_025d==0 | b13_025d>=96;
replace b13_025m=. if b13_025m==99;
replace b13_025y=. if b13_025y<=99 | b13_025y==9999;
replace b13_025y=2000 if b13_025y==200;
replace b13_025y=2001 if b13_025y==201;
replace b13_025y=1982 if b13_025y==2982;

replace b13_026=2 if b13_026==0;
replace b13_027=. if b13_027==98; 
replace b13_028=. if b13_028>2;
replace b13_028=2 if b13_028==0;
* assert b13_029!=. if b13_028==1;
replace b13_030a=. if b13_030a==99;
replace b13_030b=. if b13_030b==0;
* assert b13_030a==. if b13_026==1;
list hrbf_id1 hrbf_id2 b13_020 b13_022n b13_025d b13_025m b13_025y b13_026 b13_027 b13_030a b13_030b if b13_030a!=. & b13_026==1, compress;
replace b13_026=2 if hrbf_id1==4 & hrbf_id2==9 & b13_020==2 & b13_022n==2;
replace b13_030a=. if hrbf_id1==18 & hrbf_id2==11 & b13_020==2 & b13_022n==4;
replace b13_030b=. if hrbf_id1==18 & hrbf_id2==11 & b13_020==2 & b13_022n==4;
replace b13_030a=. if hrbf_id1==20 & hrbf_id2==6 & b13_020==2 & b13_022n==6;
replace b13_030b=. if hrbf_id1==20 & hrbf_id2==6 & b13_020==2 & b13_022n==6;
replace b13_026=. if hrbf_id1==26 & hrbf_id2==5 & b13_020==2 & b13_022n==2;
replace b13_027=. if hrbf_id1==26 & hrbf_id2==5 & b13_020==2 & b13_022n==2;
replace b13_026=2 if hrbf_id1==35 & hrbf_id2==1 & b13_020==2 & b13_022n==1;
replace b13_030a=. if hrbf_id1==37 & hrbf_id2==11 & b13_020==2 & b13_022n==1;
replace b13_030b=. if hrbf_id1==37 & hrbf_id2==11 & b13_020==2 & b13_022n==1;
replace b13_030a=. if hrbf_id1==52 & hrbf_id2==12 & b13_020==2 & b13_022n==2;
replace b13_030b=. if hrbf_id1==52 & hrbf_id2==12 & b13_020==2 & b13_022n==2;
replace b13_030a=. if hrbf_id1==68 & hrbf_id2==11 & b13_020==2 & b13_022n==6;
replace b13_030b=. if hrbf_id1==68 & hrbf_id2==11 & b13_020==2 & b13_022n==6;
replace b13_030a=. if hrbf_id1==76 & hrbf_id2==8 & b13_020==2 & b13_022n==7;
replace b13_030b=. if hrbf_id1==76 & hrbf_id2==8 & b13_020==2 & b13_022n==7;
replace b13_030a=. if hrbf_id1==84 & hrbf_id2==1 & b13_020==2 & b13_022n==1;
replace b13_030b=. if hrbf_id1==84 & hrbf_id2==1 & b13_020==2 & b13_022n==1;
replace b13_026=2 if hrbf_id1==89 & hrbf_id2==4 & b13_020==1 & b13_022n==8;
replace b13_027=. if hrbf_id1==89 & hrbf_id2==4 & b13_020==1 & b13_022n==8;
replace b13_030a=. if hrbf_id1==100 & hrbf_id2==4 & b13_020==2 & b13_022n==1;
replace b13_030a=. if hrbf_id1==129 & hrbf_id2==2 & b13_020==2 & b13_022n==4;
replace b13_030b=. if hrbf_id1==129 & hrbf_id2==2 & b13_020==2 & b13_022n==4;
replace b13_026=2 if hrbf_id1==139 & hrbf_id2==8 & b13_020==2 & b13_022n==2;
replace b13_027=. if hrbf_id1==139 & hrbf_id2==8 & b13_020==2 & b13_022n==2;
replace b13_026=2 if hrbf_id1==145 & hrbf_id2==10 & b13_020==2 & b13_022n==9;
replace b13_030a=. if hrbf_id1==166 & hrbf_id2==10 & b13_020==2 & b13_022n==6;
replace b13_030a=. if hrbf_id1==166 & hrbf_id2==10 & b13_020==2 & b13_022n==7;
replace b13_026=2 if hrbf_id1==167 & hrbf_id2==8 & b13_020==2 & b13_022n==1;
replace b13_026=2 if hrbf_id1==169 & hrbf_id2==11 & b13_020==2 & b13_022n==4;
replace b13_026=2 if hrbf_id1==169 & hrbf_id2==11 & b13_020==2 & b13_022n==5;
replace b13_026=2 if hrbf_id1==169 & hrbf_id2==11 & b13_020==2 & b13_022n==6;
replace b13_030a=. if hrbf_id1==180 & hrbf_id2==11 & b13_020==3 & b13_022n==2;
replace b13_030b=. if hrbf_id1==180 & hrbf_id2==11 & b13_020==3 & b13_022n==2;
replace b13_030a=. if hrbf_id1==189 & hrbf_id2==1 & b13_020==2 & b13_022n==7;
replace b13_030b=. if hrbf_id1==189 & hrbf_id2==1 & b13_020==2 & b13_022n==7;
replace b13_030a=. if hrbf_id1==189 & hrbf_id2==2 & b13_020==2 & b13_022n==1;
replace b13_030b=. if hrbf_id1==189 & hrbf_id2==2 & b13_020==2 & b13_022n==1;
replace b13_030a=. if hrbf_id1==204 & hrbf_id2==7 & b13_020==2 & b13_022n==10;
replace b13_027=. if hrbf_id1==204 & hrbf_id2==7 & b13_020==2 & b13_022n==10;
assert b13_030b==. if b13_026==1;
* assert b13_030a!=. if b13_026==2;
list hrbf_id1 hrbf_id2 b13_020 b13_022n b13_025d b13_025m b13_025y b13_026 b13_027 b13_030a b13_030b if b13_030a==. & b13_026==2, compress;
* assert b13_030b!=. if b13_026==2;
* assert b13_027==. if b13_026==2;
list hrbf_id1 hrbf_id2 b13_020 b13_022n b13_025y b13_026 b13_027 b13_030a b13_030b if b13_027!=. & b13_026==2, compress;
replace b13_027=. if b13_026==2;

*** Ensure youngest child is number b13_022n==1, 2nd youngest is number b13_022n==2, etc.;
* assert b13_025y>1965;
replace b13_025y=. if b13_025y==1948;
gen b13_025d_2=b13_025d;
replace b13_025d_2=1 if b13_025d==.;
gen b13_025m_2=b13_025m;
replace b13_025m_2=1 if b13_025m==.;
gen b13_025y_2=b13_025y;
replace b13_025y_2=1960 if b13_025y==.;
gen b13_025_date=mdy(b13_025m_2, b13_025d_2, b13_025y_2);
bysort hrbf_id1 hrbf_id2 b13_020: egen b13_025_datemin=min(b13_025_date);
gen cond1=b13_025_date==b13_025_datemin;
gen cond2=.;
bysort hrbf_id1 hrbf_id2 b13_020: replace cond2=_N if cond1==1;
bysort hrbf_id1 hrbf_id2 b13_020 b13_025_date: replace cond2=. if _n!=1;
sort hrbf_id1 hrbf_id2 b13_020 b13_025_date;
replace cond2=cond2[_n-1]-1 if cond2==. & cond2[_n-1]!=.;
replace b13_022n=cond2;
drop b13_025d_2 b13_025m_2 b13_025y_2 cond1 cond2 b13_025_date b13_025_datemin;

sort hrbf_id1 hrbf_id2 b13_020 b13_022n;
* bysort hrbf_id1 hrbf_id2 b13_020: assert b13_022n[_n+1]!=. if b13_031[_n]==1 & _n!=_N;
* bysort hrbf_id1 hrbf_id2 b13_020: assert b13_031[_N]==2;
bysort hrbf_id1 hrbf_id2 b13_020: replace b13_031=1 if _n!=_N;
bysort hrbf_id1 hrbf_id2 b13_020: replace b13_031=2 if _n==_N;

sort hrbf_id1 hrbf_id2 b13_020 b13_022n;
save $cleandatadir/rwhrbf_b05.dta, replace;



************************************
*** Create rwhrbf_b05_with_studyarms
************************************;

ren b13_020 a1_pid;
save $tempdatadir/rwhrbf_b05.dta, replace;

merge hrbf_id1 hrbf_id2 a1_pid using $cleandatadir/rwhrbf_household_roster.dta, uniqusing;
tab _merge;
list hrbf_id1 hrbf_id2 a1_pid a1_02 if _merge==2 | _merge==1;
drop if _merge==2 | _merge==1;
drop _merge;
save $cleandatadir/rwhrbf_b05_withstudyarms.dta, replace;



*********************************************
*** Create necessary variables for mean tests
*********************************************;

bysort hrbf_id1 hrbf_id2 a1_pid: gen b13_022n_1=b13_022n if _n==_N;
lab var b13_022n_1 "Nr births per woman";

gen b13_023_1=b13_023==1;
replace b13_023_1=. if b13_023==.;
lab var b13_023_1 "Single birth";

gen b13_024_1=b13_024==1;
replace b13_024_1=. if b13_024==.;
lab var b13_024_1 "Male birth";

gen b13_026_2=b13_026==2;
replace b13_026_2=. if b13_026==.;
lab var b13_026_2 "Child died";

gen b13_028_2=b13_028==2;
replace b13_028_2=. if b13_028==.;
lab var b13_028_2 "Child lives away";

gen b13_030a_1=b13_030a;
replace b13_030a_1=b13_030a/365 if b13_030b==1;
replace b13_030a_1=b13_030a/12 if b13_030b==2;
replace b13_030a_1=round(b13_030a_1);
lab var b13_030a_1 "Age at death in yrs";

gen b13_030a_2=b13_030a_1*12 if b13_030a_1<5;
lab var b13_030a_2 "Age at death in mths if <5";

svyset [pweight=hhpweight], psu(hrbf_id1);
save $cleandatadir/rwhrbf_b05_withstudyarms_withvarformeantests.dta, replace;