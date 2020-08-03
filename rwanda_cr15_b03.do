* Elisa Rothenbuhler - Sep 10

* This do-file:
* Creates clean female b03 dataset: $cleandatadir/rwhrbf_b03.dta.
* Merges $cleandatadir/rwhrbf_b03.dta with household roster.
* Generates appropriate variables for mean tests.


version 10.0
clear
set more off
set mem 500m
cap log close

#delimit ;

log using $logdir/rwanda_cr15_b03.log, replace;



*********************
*** Clean b03 section
*********************;

use $origdatadir/RWHRBF_B_FEMALE-03.dta, clear;
drop if b12_01a==. & b12_01b==. & b12_02==. & b12_03==. & b12_04==. & b12_05a==. & b12_05b==. & b12_05c==. & b12_05d==. & b12_05e==. & b12_05f==. & b12_05g==. & b12_05h==. & b12_05i==. & b12_05j==. & b12_05k==. & b12_05l==. & b12_06a==. & b12_06b==. & b12_06c==. & b12_06d==. & b12_06e==. & b12_06f==. & b12_06g==. & b12_06h==. & b12_06i==. & b12_06j==. & b12_06k==. & b12_06l==. & b12_07a==. & b12_07b==. & b12_07c==. & b12_07d==. & b12_07e==. & b12_07f==. & b12_07g==. & b12_07h==. & b12_07i==. & b12_07j==. & b12_07k==. & b12_07l==. & b12_08==. & b12_09==. & b12_10==. & b12_11==. & b12_12==. & b12_13a==. & b12_13b==. & b12_13c==. & b12_13d==. & b12_13e==. & b12_13f==. & b12_13g==. & b12_13h==. & b12_13i==. & b12_13j==. & b12_13k==. & b12_13l==. & b12_14==. & b12_14a==. & b12_14b==. & b12_15==. & b12_16y==. & b12_16m==. & b12_17==. & b12_18a==. & b12_18b==. & b12_18c==. & b12_18d==. & b12_18e==.;
duplicates report hrbf_id1 hrbf_id2 b12_pid b12_pid;

replace b12_01a=0 if b12_01a==.;
replace b12_01b=0 if b12_01b==.;
replace b12_01b=. if b12_01b==96;
replace b12_02=5 if b12_02==15;
foreach letter in a b c d e f g h i j k l {;
	replace b12_07`letter'=. if b12_07`letter'==0;
};
* foreach letter in a b c d e f g h i j k l {;
* 	assert b12_07`letter'==. if b12_06`letter'==2;
*	br b12_07`letter' b12_12 b12_13a b12_13b b12_13c b12_13d b12_13e b12_13f b12_13g b12_13h b12_13i b12_13j b12_13k b12_13l if b12_07`letter'!=. & b12_06`letter'==2;
* };
replace b12_06c=1 if hrbf_id1==115 & hrbf_id2==7 & b12_pid==1;
replace b12_07b=. if b12_06b==2;
replace b12_07c=. if b12_06c==2;
replace b12_07d=. if b12_06d==2;
replace b12_07g=. if b12_06g==2;
foreach letter in a b c d e f g h i j k l {;
	assert b12_07`letter'==. if b12_06`letter'==2;
};
replace b12_13a=2 if b12_13a==0;
* assert b12_13a!=1 & b12_13b!=1 & b12_13c!=1 & b12_13d!=1 & b12_13e!=1 & b12_13f!=1 & b12_13g!=1 & b12_13h!=1 & b12_13i!=1 & b12_13j!=1 & b12_13k!=1 & b12_13l!=1 if b12_12==2 | b12_12==3;
* br if (b12_13a==1 | b12_13b==1 | b12_13c==1 | b12_13d==1 | b12_13e==1 | b12_13f==1 | b12_13g==1 | b12_13h==1 | b12_13i==1 | b12_13j==1 | b12_13k==1 | b12_13l==1) & (b12_12==2 | b12_12==3);
replace b12_12=1 if (hrbf_id1==50 & hrbf_id2==6 & b12_pid==2) | (hrbf_id1==81 & hrbf_id2==3 & b12_pid==2) | (hrbf_id1==84 & hrbf_id2==7 & b12_pid==2) | (hrbf_id1==93 & hrbf_id2==10 & b12_pid==2) | (hrbf_id1==102 & hrbf_id2==11 & b12_pid==2) | (hrbf_id1==191 & hrbf_id2==1 & b12_pid==3) | (hrbf_id1==199 & hrbf_id2==5 & b12_pid==2); 
* assert b12_14==. if b12_12==2 | b12_12==3;
* br if b12_14!=. & (b12_12==2 | b12_12==3);
replace b12_12=1 if b12_14!=. & b12_15!=.;
* assert b12_14a==. if b12_12==2 | b12_12==3;
* br if b12_14a!=. & (b12_12==2 | b12_12==3);
replace b12_12=1 if b12_15!=. & b12_16y!=.;
replace b12_14=. if b12_12!=1;
replace b12_14a=. if b12_12==2 | b12_12==3;
assert b12_14b==. if b12_12==2 | b12_12==3;
* assert b12_14b==. if b12_14a==2;
replace b12_14b=. if b12_14a==2;
* assert b12_15==. if b12_12==2 | b12_12==3;
replace b12_15=. if b12_12==2 | b12_12==3;
* assert b12_16y==. if b12_12==2 | b12_12==3;
* br if b12_16y!=. & (b12_12==2 | b12_12==3);
replace b12_16y=. if b12_12==2 | b12_12==3;
* assert b12_16m==. if b12_12==2 | b12_12==3;
* br if b12_16m!=. & (b12_12==2 | b12_12==3);
replace b12_16m=. if b12_12==2 | b12_12==3;
* assert b12_17==. if b12_12==2 | b12_12==3;
* br if b12_17!=. & (b12_12==2 | b12_12==3);
replace b12_17=. if b12_12==2 | b12_12==3;

* assert b12_13a==. & b12_13b==. & b12_13c==. & b12_13d==. & b12_13e==. & b12_13f==. & b12_13g==. & b12_13h==. & b12_13i==. & b12_13j==. & b12_13k==. & b12_13l==. if b12_12==2 | b12_12==3;
* br if (b12_13a!=. | b12_13b!=. | b12_13c!=. | b12_13d!=. | b12_13e!=. | b12_13f!=. | b12_13g!=. | b12_13h!=. | b12_13i!=. | b12_13j!=. | b12_13k!=. | b12_13l!=.) & (b12_12==2 | b12_12==3);
foreach letter in a b c d e f g h i j k l {;
	replace b12_13`letter'=. if b12_12==2 | b12_12==3;
};
assert b12_13a==. & b12_13b==. & b12_13c==. & b12_13d==. & b12_13e==. & b12_13f==. & b12_13g==. & b12_13h==. & b12_13i==. & b12_13j==. & b12_13k==. & b12_13l==. if b12_12==2 | b12_12==3;

sort hrbf_id1 hrbf_id2 b12_pid;
save $cleandatadir/rwhrbf_b03.dta, replace;


************************************
*** Create rwhrbf_b03_with_studyarms
************************************;

ren b12_pid a1_pid;
save $tempdatadir/rwhrbf_b03.dta, replace;

use $cleandatadir/rwhrbf_household_roster.dta, clear;
merge hrbf_id1 hrbf_id2 a1_pid using $tempdatadir/rwhrbf_b03.dta, unique;
tab _merge;
list hrbf_id1 hrbf_id2 a1_pid a1_02 if _merge==2;
drop if _merge==2;
drop _merge;
save $cleandatadir/rwhrbf_b03_withstudyarms.dta, replace;



*********************************************
*** Create necessary variables for mean tests
*********************************************;

lab var b12_01a "Nr male children";
lab var b12_01b "Nr female children";

egen b12_01_1=rowtotal(b12_01a b12_01b);
replace b12_01_1=. if b12_01a==. & b12_01b==.;
lab var b12_01_1 "Nr children";

forvalues v=1(1)5 {;
	gen b12_02_`v'=b12_02==`v';
	replace b12_02_`v'=. if b12_02==.;
};
gen b12_02_96=b12_02==96;
replace b12_02_96=. if b12_02==.;
lab var b12_02_1 "Next child:never";
lab var b12_02_2 "Next child:infertile";
lab var b12_02_3 "Next child:in years";
lab var b12_02_4 "Next child:soon/now";
lab var b12_02_5 "Next child:after marriage";
lab var b12_02_96 "Next child:other";

forvalues v=1(1)4 {;
	gen b12_03_`v'=b12_03==`v';
	replace b12_03_`v'=. if b12_03==.;
};
lab var b12_03_1 "If pregnant:Big problem";
lab var b12_03_2 "If pregnant:Small problem";
lab var b12_03_3 "If pregnant:No problem";
lab var b12_03_4 "If pregnant:Cant get pregnt";

gen b12_04_1=b12_04==1;
replace b12_04_1=. if b12_04==.;
lab var b12_04_1 "Approves contraception";

gen b12_05_1=b12_05a==1 | b12_05b==1 | b12_05c==1 | b12_05d==1 | b12_05e==1 | b12_05f==1 | b12_05g==1 | b12_05h==1 | b12_05i==1 | b12_05j==1 | b12_05k==1 | b12_05l==1;
replace b12_05_1=. if b12_05a==. & b12_05b==. & b12_05c==. & b12_05d==. & b12_05e==. & b12_05f==. & b12_05g==. & b12_05h==. & b12_05i==. & b12_05j==. & b12_05k==. & b12_05l==.;
lab var b12_05_1 "Heard of contraception means";

gen b12_06_1=b12_06a==1 | b12_06b==1 | b12_06c==1 | b12_06d==1 | b12_06e==1 | b12_06f==1 | b12_06g==1 | b12_06h==1 | b12_06i==1 | b12_06j==1 | b12_06k==1 | b12_06l==1;
replace b12_06_1=. if b12_06a==. & b12_06b==. & b12_06c==. & b12_06d==. & b12_06e==. & b12_06f==. & b12_06g==. & b12_06h==. & b12_06i==. & b12_06j==. & b12_06k==. & b12_06l==.;
lab var b12_06_1 "Ever used contraception";

egen b12_07_1=rowmin(b12_07a b12_07b b12_07c b12_07d b12_07e b12_07f b12_07g b12_07h b12_07i b12_07j b12_07k b12_07l);
lab var b12_07_1 "Age of start of contraception";

gen b12_08_1=b12_08==1;
replace b12_08_1=. if b12_08==.;
lab var b12_08_1 "Currently has sexual partner";

gen b12_09_1=b12_09==1;
replace b12_09_1=. if b12_09==.;
lab var b12_09_1 "Partner approves contraception";

gen b12_10_1=b12_10==1;
replace b12_10_1=. if b12_10==.;
lab var b12_10_1 "Talk w/partner on contraceptive";

forvalues v=1(1)3 {;
	gen b12_11_`v'=b12_11==`v';
	replace b12_11_`v'=. if b12_11==.;
};
gen b12_11_99=b12_11==99;
replace b12_11_99=. if b12_11==.;
lab var b12_11_1 "Partner wants =children";
lab var b12_11_2 "Partner wants >children";
lab var b12_11_3 "Partner wants <children";
lab var b12_11_99 "DK what partner wants";

gen b12_12_3=b12_12==3;
replace b12_12_3=. if b12_12==.;
lab var b12_12_3 "Refuses contraception";

foreach letter in a b c d e f g h i j k l {;
	gen b12_13`letter'_1=b12_13`letter'==1;
	replace b12_13`letter'_1=. if b12_13`letter'==.;
};
lab var b12_13a_1 "Use pill";
lab var b12_13b_1 "Use IUD/AKRDR/spiral";
lab var b12_13c_1 "Use injections";
lab var b12_13d_1 "Use implants";
lab var b12_13e_1 "Use female condom";
lab var b12_13f_1 "Use female steril";
lab var b12_13g_1 "Use lactational amen";
lab var b12_13h_1 "Use male condom";
lab var b12_13i_1 "Use male steril";
lab var b12_13j_1 "Use rhythm";
lab var b12_13k_1 "Use withdrawal";
lab var b12_13l_1 "Use other";

gen b12_13a_2=b12_13a==1 | b12_13b==1 | b12_13c==1 | b12_13d==1 | b12_13e==1 | b12_13f==1 | b12_13g==1 | b12_13h==1 | b12_13i==1;
replace b12_13a_2=. if b12_13a==. & b12_13b==. & b12_13c==. & b12_13d==. & b12_13e==. & b12_13f==. & b12_13g==. & b12_13h==. & b12_13i==. & b12_13j==. & b12_13k==. & b12_13l==.;
lab var b12_13a_2 "Uses modern contraception";

forvalues v=1(1)10 {;
	gen b12_14_`v'=b12_14==`v';
	replace b12_14_`v'=. if b12_14==.;
};
gen b12_14_96=b12_14==96;
replace b12_14_96=. if b12_14==.;
lab var b12_14_1 "1st got:doctor";
lab var b12_14_2 "1st got:nurse";
lab var b12_14_3 "1st got:CHW";
lab var b12_14_4 "1st got:lab";
lab var b12_14_5 "1st got:pharma";
lab var b12_14_6 "1st got:trad healer";
lab var b12_14_7 "1st got:spirit healer";
lab var b12_14_8 "1st got:trad birth attendt";
lab var b12_14_9 "1st got:fam member";
lab var b12_14_10 "1st got:friend";
lab var b12_14_96 "1st got:other";

gen b12_14a_1=b12_14a==1;
replace b12_14a_1=. if b12_14a==.;
lab var b12_14a_1 "Gift when contraception started";

forvalues v=1(1)10 {;
	gen b12_15_`v'=b12_15==`v';
	replace b12_15_`v'=. if b12_15==.;
};
gen b12_15_96=b12_15==96;
replace b12_15_96=. if b12_15==.;
lab var b12_15_1 "Last got:doctor";
lab var b12_15_2 "Last got:nurse";
lab var b12_15_3 "Last got:CHW";
lab var b12_15_4 "Last got:lab";
lab var b12_15_5 "Last got:pharma";
lab var b12_15_6 "Last got:trad healer";
lab var b12_15_7 "Last got:spirit healer";
lab var b12_15_8 "Last got:trad birth attendt";
lab var b12_15_9 "Last got:fam member";
lab var b12_15_10 "Last got:friend";
lab var b12_15_96 "Last got:other";

gen b12_16y_1=b12_16y;
replace b12_16y_1=b12_16y+b12_16m/12 if b12_16y!=. & b12_16m!=.;
replace b12_16y_1=b12_16m/12 if b12_16y==. & b12_16m!=.;
lab var b12_16y_1 "Duration contraception yrs";

foreach letter in a b c d e {;
	gen b12_18`letter'_1=b12_18`letter'==1;
	replace b12_18`letter'_1=. if b12_18`letter'==.;
};
lab var b12_18a_1 "HF staff talked of FP";
lab var b12_18b_1 "CHW talked of FP";
lab var b12_18c_1 "Friends/Fam talked of FP";
lab var b12_18d_1 "Govt talked of FP";
lab var b12_18e_1 "Other talked of FP";

***
*** Indicators
***;

gen b12_12_100=.;
replace b12_12_100=1 if b12_04==1 & b12_08==1 & b12_12==2 & (b12_02==1 | b12_02==3 |b12_02==5);
replace b12_12_100=0 if b12_08==1 & b12_12_100!=1;
lab var b12_12_100 "Unmet need for FP";

gen b12_12_101=.;
replace b12_12_101=1 if b12_12_100==1 & b12_09==2;
replace b12_12_101=0 if b12_12_100==1 & (b12_09==1 | b12_09==.);
lab var b12_12_101 "Unmet need & partner disapproves";

gen b12_12_102=.;
replace b12_12_102=1 if b12_04==1 & (a1_12==2 | a1_12==3) & b12_12==2 & (b12_02==1 | b12_02==3 |b12_02==5);
replace b12_12_102=0 if (a1_12==2 | a1_12==3) & b12_12_102!=1;
lab var b12_12_102 "Unmet need for FP -married";

gen b12_12_103=.;
replace b12_12_103=1 if b12_04==1 & (a1_12!=2 & a1_12!=3 & b12_08==1) & b12_12==2 & (b12_02==1 | b12_02==3 |b12_02==5);
replace b12_12_103=0 if (a1_12!=2 & a1_12!=3 & b12_08==1) & b12_12_103!=1;
lab var b12_12_103 "Unmet need for FP -unmarried";

gen b12_12_1=.;
replace b12_12_1=1 if b12_12==1 & b12_08==1;
replace b12_12_1=0 if b12_08==1 & b12_12_1!=1;
lab var b12_12_1 "Contraceptive prevalence";

gen b12_12_104=.;
replace b12_12_104=1 if b12_12==1 & (a1_12==2 | a1_12==3);
replace b12_12_104=0 if (b12_12==2 | b12_12==3) & (a1_12==2 | a1_12==3);
lab var b12_12_104 "Contracep prevalence -married";

gen b12_12_105=.;
replace b12_12_105=1 if b12_12==1 & (a1_12!=2 & a1_12!=3 & b12_08==1);
replace b12_12_105=0 if (b12_12==2 | b12_12==3) & (a1_12!=2 & a1_12!=3 & b12_08==1);
lab var b12_12_105 "Contracep prev -unmarried";

gen b12_12_106=.;
replace b12_12_106=1 if b12_12==1 & (b12_13a==1 | b12_13b==1 | b12_13c==1 | b12_13d==1 | b12_13e==1 | b12_13f==1 | b12_13g==1 | b12_13h==1 | b12_13i==1) & b12_08==1;
replace b12_12_106=0 if (b12_12==2 | b12_12==3 | (b12_12==1 & b12_13a!=1 & b12_13b!=1 & b12_13c!=1 & b12_13d!=1 & b12_13e!=1 & b12_13f!=1 & b12_13g!=1 & b12_13h!=1 & b12_13i!=1)) & b12_08==1;
lab var b12_12_106 "Modern contracep prev";

gen b12_12_107=.;
replace b12_12_107=1 if b12_12==1 & (b12_13a==1 | b12_13b==1 | b12_13c==1 | b12_13d==1 | b12_13e==1 | b12_13f==1 | b12_13g==1 | b12_13h==1 | b12_13i==1) & (a1_12==2 | a1_12==3);
replace b12_12_107=0 if (b12_12==2 | b12_12==3 | (b12_12==1 & b12_13a!=1 & b12_13b!=1 & b12_13c!=1 & b12_13d!=1 & b12_13e!=1 & b12_13f!=1 & b12_13g!=1 & b12_13h!=1 & b12_13i!=1)) & (a1_12==2 | a1_12==3);
lab var b12_12_107 "Modern contracep prev -married";

gen b12_12_108=.;
replace b12_12_108=1 if b12_12==1 & (b12_13a==1 | b12_13b==1 | b12_13c==1 | b12_13d==1 | b12_13e==1 | b12_13f==1 | b12_13g==1 | b12_13h==1 | b12_13i==1) & (a1_12!=2 & a1_12!=3 & b12_08==1);
replace b12_12_108=0 if (b12_12==2 | b12_12==3 | (b12_12==1 & b12_13a!=1 & b12_13b!=1 & b12_13c!=1 & b12_13d!=1 & b12_13e!=1 & b12_13f!=1 & b12_13g!=1 & b12_13h!=1 & b12_13i!=1)) & (a1_12!=2 & a1_12!=3 & b12_08==1);
lab var b12_12_108 "Modern contracep prev -unmarried";

gen b12_12_109=b12_12==1;
lab var b12_12_109 "Contracep prev -ever sex active";

svyset [pweight=hhpweight], psu(hrbf_id1);
save $cleandatadir/rwhrbf_b03_withstudyarms_withvarformeantests.dta, replace;











