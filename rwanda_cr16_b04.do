* Elisa Rothenbuhler - Sep 10

* This do-file:
* Creates clean female b04 dataset: $cleandatadir/rwhrbf_b04.dta.
* Merges $cleandatadir/rwhrbf_b04.dta with household roster.
* Generates appropriate variables for mean tests.


version 10.0
clear
set more off
set mem 500m
cap log close

#delimit ;

log using $logdir/rwanda_cr16_b04.log, replace;



*********************
*** Clean b04 section
*********************;

use $origdatadir/RWHRBF_B_FEMALE-04.dta, clear;
drop if b13_001==. & b13_002==. & b13_003==. & b13_004==. & b13_005a==. & b13_005b==. & b13_006==. & b13_007a==. & b13_007b==. & b13_008==. & b13_009a==. & b13_009b==. & b13_010==. & b13_011==. & b13_012==. & b13_013==. & b13_014==. & b13_015==. & b13_016m==. & b13_016y==. & b13_017==. & b13_018m==. & b13_018y==. & b13_019==.;
duplicates tag hrbf_id1 hrbf_id2 b13a_pid, gen(dupl);
list hrbf_id1 hrbf_id2 b13a_pid if dupl!=0;
bysort hrbf_id1 hrbf_id2: replace b13a_pid=2 if hrbf_id1==182 & hrbf_id2==2 & _n==1;
bysort hrbf_id1 hrbf_id2: replace b13a_pid=5 if hrbf_id1==182 & hrbf_id2==2 & _n==_N;
drop dupl;
duplicates report hrbf_id1 hrbf_id2 b13a_pid;
replace b13_001=2 if b13_001==6;
replace b13_006=2 if b13_006==0;
replace b13_009a=. if b13_009a==0 & b13_008==2;
replace b13_009b=. if b13_009b==0 & b13_008==2;
replace b13_010=0 if b13_005a==. & b13_005b==. & b13_007a==. & b13_007b==. & b13_009a==. & b13_009b==.;
egen b13_010_1=rowtotal(b13_005a b13_005b b13_007a b13_007b b13_009a b13_009b);
* assert b13_010_1==b13_010 | (b13_010_1==0 & b13_010==.);
list hrbf_id1 hrbf_id2 b13a_pid b13_005a b13_005b b13_007a b13_007b b13_009a b13_009b b13_010_1 b13_010 b13_011 if b13_010_1!=b13_010, compress;
replace b13_011=1 if b13_011!=1 & b13_011!=2 & b13_011!=. & b13_010==b13_010_1;
replace b13_011=2 if b13_011!=1 & b13_011!=2 & b13_011!=. & b13_010!=b13_010_1;
replace b13_010=b13_010_1; 
replace b13_011=1 if (hrbf_id1==62 & hrbf_id2==4 & b13a_pid==2) | (hrbf_id1==208 & hrbf_id2==5 & b13a_pid==2);
assert b13_011==1 | b13_011==2 | b13_011==.;
tab b13_011;
drop b13_010_1;
egen b13_015_1=rowtotal(b13_013 b13_014);
replace b13_015=0 if b13_013==. & b13_014==.;
* assert b13_015_1==b13_015;
list hrbf_id1 hrbf_id2 b13a_pid b13_013 b13_014 b13_015 b13_015_1 if b13_015_1!=b13_015;
replace b13_015=b13_015_1;
drop b13_015_1;
replace b13_016m=. if b13_016m==99;
replace b13_016y=. if b13_016y==99 | b13_016y==0 | b13_016y==8;
replace b13_018m=. if b13_018m==99;
replace b13_018y=. if b13_018y==0;

* assert b13_001==1 if b13_002!=.;
list hrbf_id1 hrbf_id2 b13a_pid b13_001 b13_002 b13_003 if b13_001!=1 & b13_002!=.;
replace b13_002=. if b13_001!=1 & b13_002!=.;
* assert b13_001==1 if b13_003!=.;
list hrbf_id1 hrbf_id2 b13a_pid b13_001 b13_002 b13_003 if b13_001!=1 & b13_003!=.;
replace b13_003=. if b13_001!=1 & b13_003!=.;
assert b13_002==. if b13_001>1 & b13_001!=.;
assert b13_003==. if b13_001>1 & b13_001!=.;
* assert b13_005a!=. if b13_004==1 & (b13_005b==. | b13_005b==0);
list hrbf_id1 hrbf_id2 b13a_pid b13_004 b13_005a b13_005b if b13_005a==. & b13_004==1 & (b13_005b==. | b13_005b==0);
replace b13_004=2 if b13_005a==. & b13_004==1 & (b13_005b==. | b13_005b==0);
assert b13_005b!=. if b13_004==1 & (b13_005a==. | b13_005a==0);
replace b13_005a=0 if b13_004==1 & b13_005a==.;
replace b13_005b=0 if b13_004==1 & b13_005b==.;
assert b13_005a!=. if b13_004==1;
assert b13_005b!=. if b13_004==1;
replace b13_007a=0 if b13_006==1 & b13_007a==.;
replace b13_007b=0 if b13_006==1 & b13_007b==.;
assert b13_007a!=. if b13_006==1;
assert b13_007b!=. if b13_006==1;
replace b13_009a=0 if b13_008==1 & b13_009a==.;
replace b13_009b=0 if b13_008==1 & b13_009b==.;
assert b13_009a!=. if b13_008==1;
assert b13_009b!=. if b13_008==1;
* assert b13_011!=2;
list hrbf_id1 hrbf_id2 b13a_pid b13_005a b13_005b b13_007a b13_007b b13_009a b13_009b b13_010 b13_011 if b13_011==2;
replace b13_013=. if b13_012==2 & b13_013==0;
replace b13_014=. if b13_012==2 & b13_014==0;
replace b13_015=. if b13_012==2 & b13_015==0;
replace b13_016m=. if b13_012==2 & b13_016m==0;
replace b13_016y=. if b13_012==2 & b13_016y==0;
replace b13_017=. if b13_012==2 & b13_017==0;
replace b13_018m=. if b13_012==2 & b13_018m==0;
replace b13_018y=. if b13_012==2 & b13_018y==0;
replace b13_019=. if b13_012==2 & b13_019==0;
* assert b13_013==. if b13_012==2;
list hrbf_id1 hrbf_id2 b13a_pid b13_012 b13_013 b13_014 b13_015 b13_016m b13_016y b13_017 b13_018m b13_018y if b13_013!=. & b13_012==2,compress;
replace b13_014=0 if b13_013!=. & b13_012==2;
replace b13_012=1 if b13_013!=. & b13_012==2;
assert b13_014==. if b13_012==2;
assert b13_015==. if b13_012==2;
assert b13_016m==. if b13_012==2;
assert b13_016y==. if b13_012==2;
assert b13_017==. if b13_012==2;
assert b13_018m==. if b13_012==2;
assert b13_018y==. if b13_012==2;
assert b13_019==. if b13_012==2;
* assert b13_018m!=. if b13_015>1 & b13_015!=.;
list hrbf_id1 hrbf_id2 b13a_pid b13_012 b13_013 b13_014 b13_015 b13_016m b13_016y b13_017 b13_018m b13_018y if b13_018m==. & b13_015>1 & b13_015!=., compress;
* assert b13_018y!=. if b13_015>1 & b13_015!=.;

sort hrbf_id1 hrbf_id2 b13a_pid;
save $cleandatadir/rwhrbf_b04.dta, replace;


************************************
*** Create rwhrbf_b04_with_studyarms
************************************;

ren b13a_pid a1_pid;
save $tempdatadir/rwhrbf_b04.dta, replace;

use $cleandatadir/rwhrbf_household_roster.dta, clear;
merge hrbf_id1 hrbf_id2 a1_pid using $tempdatadir/rwhrbf_b04.dta, unique;
tab _merge;
list hrbf_id1 hrbf_id2 a1_pid a1_02 if _merge==2;
drop if _merge==2;
drop _merge;
save $cleandatadir/rwhrbf_b04_withstudyarms.dta, replace;



*********************************************
*** Create necessary variables for mean tests
*********************************************;

gen b13_001_1=b13_001==1;
replace b13_001_1=. if b13_001==.;
lab var b13_001_1 "Pregnant now";

forvalues v=1(1)3 {;
	gen b13_003_`v'=b13_003==`v';
	replace b13_003_`v'=. if b13_003==.;
};
lab var b13_003_1 "Wanted pregnancy then";
lab var b13_003_2 "Wanted pregnancy later";
lab var b13_003_3 "Wanted no more pregnancy";

gen b13_004_1=.;
replace b13_004_1=1 if b13_004==1 & b13_006!=1;
replace b13_004_1=0 if b13_004==2;
lab var b13_004_1 "Has kids living w/her only";

gen b13_006_1=.;
replace b13_006_1=1 if b13_006==1 & b13_004!=1;
replace b13_006_1=0 if b13_006==2;
lab var b13_006_1 "Has kids not w/her only";

gen b13_004_2=.;
replace b13_004_2=1 if b13_004==1 & b13_006==1;
replace b13_004_2=0 if (b13_004==1 & (b13_006==2 | b13_006==.)) | ((b13_004==2 | b13_004==.) & b13_006==1);
lab var b13_004_2 "Has kids both w/& w\her";

gen b13_006_2=.;
replace b13_006_2=1 if b13_004==1 | b13_006==1;
replace b13_006_2=0 if (b13_004==2 & b13_006==2) | (b13_004==. & b13_006==2) | (b13_004==2 & b13_006==.);
lab var b13_006_2 "Has children";

tab b13_004_1;
tab b13_006_1;
tab b13_004_2;
tab b13_006_2;

gen b13_007a_1=b13_007a/(b13_005a+b13_007a);
lab var b13_007a_1 "% sons live elsewhere";

gen b13_007b_1=b13_007b/(b13_005b+b13_007b);
lab var b13_007b_1 "% daughters live elsewhere";

gen b13_007_1=(b13_007a+b13_007b)/(b13_007a+b13_007b+b13_005a+b13_005b);
lab var b13_007_1 "% children living elsewhere";

tab b13_007a_1;
tab b13_007b_1;
tab b13_007_1;

gen b13_008_1=b13_008==1;
replace b13_008_1=. if b13_008==.;
lab var b13_008_1 "Had child who died later";

gen b13_012_1=b13_012==1;
replace b13_012_1=. if b13_012==.;
lab var b13_012_1 "Had miscarr/abort/stillbirth";

gen b13_013_1=b13_013/(b13_010+b13_013+b13_014);
replace b13_013_1=0 if b13_012==2 & b13_010!=0;
lab var b13_013_1 "Miscarr/stillbirth (%births)";

gen b13_014_1=b13_014/(b13_010+b13_013+b13_014);
replace b13_014_1=0 if b13_012==2 & b13_010!=0;
lab var b13_014_1 "Abortion (%births)";

tab b13_012_1;
tab b13_013_1;
tab b13_014_1;

***
*** Indicators
***;

gen b13_003_100=.;
replace b13_003_100=1 if b13_001==1 & (b13_003==2 | b13_003==3);
replace b13_003_100=0 if b13_001==1 & b13_003==1;
lab var b13_003_100 "Unmet need for FP (pregnt only)";
tab b13_003_100;

svyset [pweight=hhpweight], psu(hrbf_id1);
save $cleandatadir/rwhrbf_b04_withstudyarms_withvarformeantests.dta, replace;
