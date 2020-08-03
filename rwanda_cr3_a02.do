* Elisa Rothenbuhler - Aug 10

* This do-file:
* Creates clean household a02 dataset: $cleandatadir/rwhrbf_a02.dta.
* Merges $cleandatadir/rwhrbf_a02.dta with household roster.
* Generates appropriate variables for mean tests.


version 10.0
clear
set more off
set mem 500m
cap log close

#delimit ;

log using $logdir/rwanda_cr3_a02.log, replace;



*********************
*** Clean a02 section
*********************;

use $origdatadir/RWHRBF_A_HOUSEHOLD-02.dta, clear;
drop if a2_03==. & a2_04l==. & a2_04g==. & a2_05h==. & a2_05m==. & a2_06==. & a2_07==. & a2_08==. & a2_09l==. & a2_09g==. & a2_10a==. & a2_10b==. & a2_10c==. & a2_10d==. & a2_10e==. & a2_10f==. & a2_10g==.;
count;
* assert a2_pid!=.;		// 13 contradictions
list hrbf_id1 hrbf_id2 a2_pid if a2_pid==.;

***
*** a2_pid missing for 13 individuals in following households: 141-3, 176-6, 182-6
***;

drop if a2_pid==.;
duplicates report hrbf_id1 hrbf_id2 a2_pid;

replace a2_03=2 if a2_03==3;
assert a2_06<=30 | a2_06==.;
replace a2_07=96 if a2_07==0;
replace a2_09l=96 if a2_09l==0;
foreach var of varlist a2_10a a2_10b a2_10c a2_10d a2_10e a2_10f a2_10g {;
	replace `var'=0 if `var'==88;
	assert `var'<=168 | `var'==.;		//7*24=168
};

sort hrbf_id1 hrbf_id2 a2_pid;
save $cleandatadir/rwhrbf_a02.dta, replace;



************************************
*** Create rwhrbf_a02_with_studyarms
************************************;

ren a2_pid a1_pid;
save $tempdatadir/rwhrbf_a02.dta, replace;

use $cleandatadir/rwhrbf_household_roster.dta, clear;
merge hrbf_id1 hrbf_id2 a1_pid using $tempdatadir/rwhrbf_a02.dta, unique;
tab _merge;
list hrbf_id1 hrbf_id2 a1_pid a1_02 if _merge==2;
drop if _merge==2;
drop _merge;
save $cleandatadir/rwhrbf_a02_withstudyarms.dta, replace;



*********************************************
*** Create necessary variables for mean tests
*********************************************;

gen a2_03_1=a2_03==1;
replace a2_03_1=. if a2_03==.;
lab var a2_03_1 "Currently in school";

replace a2_04g=. if a2_04g==96;
tab a2_04g a2_04l;
gen a2_04g_1=.;
lab var a2_04g_1 "Years of educ if in school";
replace a2_04g_1=0 if a2_04g==0 | a2_04l<3;
replace a2_04g_1=1 if a2_04g==1 & (a2_04l==1 | a2_04l==2 | a2_04l==3);
replace a2_04g_1=2 if a2_04g==2 & (a2_04l==1 | a2_04l==2 | a2_04l==3);
replace a2_04g_1=3 if a2_04g==3 & (a2_04l==1 | a2_04l==2 | a2_04l==3);
replace a2_04g_1=4 if a2_04g==4 & a2_04l==3;
replace a2_04g_1=5 if a2_04g==5 & a2_04l==3;
replace a2_04g_1=6 if a2_04g==6 & a2_04l==3;
replace a2_04g_1=7 if a2_04g==7 & a2_04l==3;
replace a2_04g_1=8 if a2_04g==8 & a2_04l==3;
replace a2_04g_1=6 if a2_04g==0 & a2_04l==4;
replace a2_04g_1=7 if (a2_04g==7 | a2_04g==1) & a2_04l==4;
replace a2_04g_1=8 if (a2_04g==8 | a2_04g==2) & a2_04l==4;
replace a2_04g_1=9 if (a2_04g==9 | a2_04g==3) & a2_04l==4;
replace a2_04g_1=9 if a2_04g==0 & a2_04l==5;
replace a2_04g_1=9 if a2_04g==9 & a2_04l==5;
replace a2_04g_1=10 if (a2_04g==10 | a2_04g==1) & a2_04l==5;
replace a2_04g_1=11 if (a2_04g==11 | a2_04g==2) & a2_04l==5;
replace a2_04g_1=12 if (a2_04g==12 | a2_04g==3) & a2_04l==5;
replace a2_04g_1=9 if a2_04g==0 & a2_04l==6;
replace a2_04g_1=13 if (a2_04g==13 | a2_04g==1) & a2_04l==6;
replace a2_04g_1=14 if (a2_04g==14 | a2_04g==2) & a2_04l==6;
replace a2_04g_1=15 if (a2_04g==15 | a2_04g==3) & a2_04l==6;
replace a2_04g_1=16 if (a2_04g==16 | a2_04g==4) & a2_04l==6;
replace a2_04g_1=17 if (a2_04g==17 | a2_04g==5) & a2_04l==6;
replace a2_04g_1=18 if (a2_04g==18 | a2_04g==6) & a2_04l==6;
replace a2_04g_1=7 if (a2_04g==7 | a2_04g==1) & a2_04l==7;
replace a2_04g_1=8 if (a2_04g==8 | a2_04g==2) & a2_04l==7;
replace a2_04g_1=9 if (a2_04g==9 | a2_04g==3) & a2_04l==7;

gen a2_05h_1=a2_05h;
replace a2_05h_1=a2_05m/60 if a2_05h==. & a2_05m!=.;
replace a2_05h_1=a2_05h+a2_05m/60 if a2_05h!=. & a2_05m!=.;
lab var a2_05h_1 "Time to school by foot (hrs)";
mean a2_05h_1;

forvalues v=1(1)14 {;
	if `v'<10 {;
		gen a2_07_0`v'=a2_07==`v';
		replace a2_07_0`v'=. if a2_07==.;
		tab a2_07_0`v';
	};
	if `v'>=10 {;
		gen a2_07_`v'=a2_07==`v';
		replace a2_07_`v'=. if a2_07==.;
		tab a2_07_`v';
	};
};
gen a2_07_96=a2_07==96;
replace a2_07_96=. if a2_07==.;
tab a2_07_96;
lab var a2_07_01 "No school:No food";
lab var a2_07_02 "No school:No transportation";
lab var a2_07_03 "No school:Ill/Injured";
lab var a2_07_04 "No school:Illness in family";
lab var a2_07_05 "No school:Domestic chores";
lab var a2_07_06 "No school:School too hard";
lab var a2_07_07 "No school:Child not interested";
lab var a2_07_08 "No school:Help family business";
lab var a2_07_09 "No school:Earn money";
lab var a2_07_10 "No school:Care of siblings";
lab var a2_07_11 "No school:Education useless";
lab var a2_07_12 "No school:Got pregnant";
lab var a2_07_13 "No school:No teacher";
lab var a2_07_14 "No school:School closed";
lab var a2_07_96 "No school:Other";

tab a2_09g a2_09l;
replace a2_09g=4 if a2_09g==43;
replace a2_09g=5 if a2_09g==53;
replace a2_09g=6 if a2_09g==63;
gen a2_09g_1=.;
lab var a2_09g_1 "Years of educ if no school";
replace a2_09g_1=0 if a2_09g==0 | a2_09l<3;
replace a2_09g_1=1 if a2_09g==1 & (a2_09l==1 | a2_09l==2 | a2_09l==3);
replace a2_09g_1=2 if a2_09g==2 & (a2_09l==1 | a2_09l==2 | a2_09l==3);
replace a2_09g_1=3 if a2_09g==3 & (a2_09l==1 | a2_09l==2 | a2_09l==3);
replace a2_09g_1=4 if a2_09g==4 & a2_09l==3;
replace a2_09g_1=5 if a2_09g==5 & a2_09l==3;
replace a2_09g_1=6 if a2_09g==6 & a2_09l==3;
replace a2_09g_1=7 if a2_09g==7 & a2_09l==3;
replace a2_09g_1=8 if a2_09g==8 & a2_09l==3;
replace a2_09g_1=7 if (a2_09g==7 | a2_09g==1) & a2_09l==4;
replace a2_09g_1=8 if (a2_09g==8 | a2_09g==2) & a2_09l==4;
replace a2_09g_1=9 if (a2_09g==9 | a2_09g==3) & a2_09l==4;
replace a2_09g_1=9 if a2_09g==0 & a2_09l==5;
replace a2_09g_1=9 if a2_09g==9 & a2_09l==5;
replace a2_09g_1=10 if (a2_09g==10 | a2_09g==1) & a2_09l==5;
replace a2_09g_1=11 if (a2_09g==11 | a2_09g==2) & a2_09l==5;
replace a2_09g_1=12 if (a2_09g==12 | a2_09g==3) & a2_09l==5;
replace a2_09g_1=12 if a2_09g==0 & a2_09l==6;
replace a2_09g_1=13 if (a2_09g==13 | a2_09g==1) & a2_09l==6;
replace a2_09g_1=14 if (a2_09g==14 | a2_09g==2) & a2_09l==6;
replace a2_09g_1=15 if (a2_09g==15 | a2_09g==3) & a2_09l==6;
replace a2_09g_1=16 if (a2_09g==16 | a2_09g==4) & a2_09l==6;
replace a2_09g_1=17 if (a2_09g==17 | a2_09g==5) & a2_09l==6;
replace a2_09g_1=18 if (a2_09g==18 | a2_09g==6) & a2_09l==6;
replace a2_09g_1=6 if a2_09g==0 & a2_09l==7;
replace a2_09g_1=7 if (a2_09g==7 | a2_09g==1) & a2_09l==7;
replace a2_09g_1=8 if (a2_09g==8 | a2_09g==2) & a2_09l==7;
replace a2_09g_1=9 if (a2_09g==9 | a2_09g==3) & a2_09l==7;



* assert a2_08==. if a2_03==1;
replace a2_08=. if a2_03==1;
gen a2_08_1=.;
replace a2_08_1=1 if a2_03==1 | (a2_03==2 & a2_08==1);
replace a2_08_1=0 if a2_03==2 & a2_08==2;
lab var a2_08_1 "Ever attended/attends school";

tab a2_03;
tab a2_08 if a2_03==2;
tab a2_08_1;
* Note: yes(a2_03) + yes(a2_08)=yes(a2_08_1);

gen a2_09_1=a2_04g_1;
replace a2_09_1=a2_09g_1 if a2_04g_1==.;
lab var a2_09_1 "Years of educ completed";

gen a2_09_2=a2_09_1==0;
replace a2_09_2=. if a2_09_1==.;
lab var a2_09_2 "No school completed";

gen a2_09_3=a2_09_1>0 & a2_09_1<6;
replace a2_09_3=. if a2_09_1==.;
lab var a2_09_3 "<Primary completed";

gen a2_09_4=a2_09_1==6;
replace a2_09_4=. if a2_09_1==.;
lab var a2_09_4 "Primary completed";

gen a2_09_5=a2_09_1>6;
replace a2_09_5=. if a2_09_1==.;
lab var a2_09_5 ">Primary completed";

tab a2_09_1;
tab a2_09_2;
tab a2_09_3;
tab a2_09_4;
tab a2_09_5;
*Note: sum(yes(5 var))=Total;

tab a2_04g if a2_04l!=., missing;
tab a2_09g if a2_09l!=., missing;
* 97+29=126 missing grades for non missing levels;
* 6544 have ever been to school, 6372 have correctly recorded grades, 126 have missing grades: 6544-6372-126=46 (0.70% of those who have ever been to school, 0.72% of those 6372+46=6418 who had grades reported) have badly reported grades which could not be included in analysis;




*** Re-label some variables so labels<30 characters (otherwise not included in tables);
lab var a2_06 "Days absent from school 30d";
lab var a2_10a "School (hrs)";
lab var a2_10b "Studying (hrs)";
lab var a2_10c "Children care (hrs)";
lab var a2_10d "Sick relative care (hrs)";
lab var a2_10e "Housework (hrs)";
lab var a2_10f "Work for income (hrs)";
lab var a2_10g "Recreation (hrs)";

svyset [pweight=hhpweight], psu(hrbf_id1);
save $cleandatadir/rwhrbf_a02_withstudyarms_withvarformeantests.dta, replace;

log close;




