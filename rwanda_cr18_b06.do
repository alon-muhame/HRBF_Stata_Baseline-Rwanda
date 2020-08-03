* Elisa Rothenbuhler - Sep 10

* This do-file:
* Creates clean female b06 dataset: $cleandatadir/rwhrbf_b06.dta.
* Merges $cleandatadir/rwhrbf_b06.dta with household roster.
* Generates appropriate variables for mean tests.


version 10.0
clear
set more off
set mem 500m
cap log close

#delimit ;

log using $logdir/rwanda_cr18_b06.log, replace;



*********************
*** Clean b06 section
*********************;

use $origdatadir/RWHRBF_B_FEMALE-06.dta, clear;
drop if b13_035==. & b13_036==. & b13_037==. & b13_038n=="" & b13_038c==. & b13_039==. & b13_040m==. & b13_040y==. & b13_040a==. & b13_040b==. & b13_041==. & b13_042==. & b13_043m==. & b13_043y==. & b13_044a==. & b13_044b==. & b13_044c==. & b13_044d==. & b13_044e==. & b13_044f==. & b13_045==. & b13_045a==. & b13_046==. & b13_047a==. & b13_047b==. & b13_047c==. & b13_048==. & b13_049==. & b13_050==. & b13_051==. & b13_052==. & b13_053==. & b13_054a==. & b13_054b==. & b13_054c==. & b13_054d==. & b13_054e==. & b13_055a==. & b13_055b==. & b13_055c==. & b13_055d==. & b13_055e==. & b13_056a==. & b13_056b==. & b13_056c==. & b13_056d==. & b13_056e==. & b13_057==. & b13_058==. & b13_059==. & b13_060n=="" & b13_060c==. & b13_061_1==. & b13_061_2==. & b13_061_3==. & b13_061a==. & b13_061b==. & b13_062==. & b13_063a==. & b13_063b==. & b13_064a==. & b13_064b==. & b13_064c==. & b13_065a==. & b13_066a==. & b13_067a==. & b13_068a==. & b13_069a==. & b13_070a==. & b13_071a==. & b13_072a==. & b13_073a1==. & b13_073a2==. & b13_073a3==. & b13_074a==. & b13_075an==. & b13_075au==. & b13_076a==. & b13_077a==. & b13_078a==. & b13_065b==. & b13_066b==. & b13_067b==. & b13_068b==. & b13_069b==. & b13_070b==. & b13_071b==. & b13_072b==. & b13_073b1==. & b13_073b2==. & b13_073b3==. & b13_074b==. & b13_075bn==. & b13_075bu==. & b13_076b==. & b13_077b==. & b13_078b==. & b13_065c==. & b13_066c==. & b13_067c==. & b13_068c==. & b13_069c==. & b13_070c==. & b13_071c==. & b13_072c==. & b13_073c1==. & b13_073c2==. & b13_073c3==. & b13_074c==. & b13_075cn==. & b13_075cu==. & b13_076c==. & b13_077c==. & b13_078c==. & b13_079a==. & b13_079b==. & b13_079c==. & b13_079d==. & b13_079e==. & b13_079f==. & b13_079g==. & b13_079h==. & b13_079i==. & b13_080==. & b13_081a==. & b13_081b==. & b13_082==. & b13_083==. & b13_083a==. & b13_083b==. & b13_084==. & b13_085n=="" & b13_085c==. & b13_086==. & b13_087a==. & b13_087b==. & b13_087c==. & b13_088==. & b13_089n==. & b13_089u==. & b13_090==. & b13_091==. & b13_092==. & b13_093n==. & b13_093u==. & b13_094==. & b13_095==.;
count;

list hrbf_id1 hrbf_id2 b13_033 b13_034n b13c_seq b13_034 if b13_033==.;
* br if b13_033==.;
drop if b13_033==.;

tab1 b13_034 b13_034n b13_035 b13_036 b13_037 b13_038c b13_039 b13_040m b13_040y b13_040a b13_040b b13_041 b13_042 b13_043m b13_043y b13_044a b13_044b b13_044c b13_044d b13_044e b13_044f b13_045 b13_045a b13_046 b13_047a b13_047b b13_047c b13_048 b13_049 b13_050 b13_051 b13_052 b13_053 b13_054a b13_054b b13_054c b13_054d b13_054e b13_055a b13_055b b13_055c b13_055d b13_055e b13_056a b13_056b b13_056c b13_056d b13_056e b13_057 b13_058 b13_059 b13_060c b13_061_1 b13_061_2 b13_061_3 b13_061a b13_061b b13_062 b13_063a b13_063b b13_064a b13_064b b13_064c b13_065a b13_066a b13_067a b13_068a b13_069a b13_070a b13_071a b13_072a b13_073a1 b13_073a2 b13_073a3 b13_074a b13_075an b13_075au b13_076a b13_077a b13_078a b13_065b b13_066b b13_067b b13_068b b13_069b b13_070b b13_071b b13_072b b13_073b1 b13_073b2 b13_073b3 b13_074b b13_075bn b13_075bu b13_076b b13_077b b13_078b b13_065c b13_066c b13_067c b13_068c b13_069c b13_070c b13_071c b13_072c b13_073c1 b13_073c2 b13_073c3 b13_074c b13_075cn b13_075cu b13_076c b13_077c b13_078c b13_079a b13_079b b13_079c b13_079d b13_079e b13_079f b13_079g b13_079h b13_079i b13_080 b13_081a b13_081b b13_082 b13_083 b13_083a b13_083b b13_084 b13_085n b13_085c b13_086 b13_087a b13_087b b13_087c b13_088 b13_089n b13_089u b13_090 b13_091 b13_092 b13_093n b13_093u b13_094 b13_095, nolab;

replace b13_040m=. if b13_040m>=96 | b13_040m==0;
tab b13_040y;
list hrbf_id1 hrbf_id2 b13_033 b13_034n b13c_seq b13_040m b13_040y b13_043m b13_043y if b13_040y<2000;
replace b13_040y=2008 if b13_040y==8;
replace b13_040y=2009 if b13_040y==9;
replace b13_040y=2010 if b13_040y==200;
* br if hrbf_id1==196 & hrbf_id2==10 & b13_033==1 & b13_034n==1;
replace b13_040y=. if b13_040y==99;
replace b13_040m=. if hrbf_id1==196 & hrbf_id2==10 & b13_033==1 & b13_034n==1;
tab b13_040b b13_040a;
replace b13_040a=2 if b13_040b<10;
replace b13_040b=. if b13_040b<10;
tab b13_041;
replace b13_041=2 if b13_041==23;
replace b13_041=. if b13_041==80;
replace b13_043m=. if b13_043m>=96;
tab b13_043y;
list  hrbf_id1 hrbf_id2 b13_033 b13_034n b13_040m b13_040y b13_043m b13_043y if b13_043y<2001 | b13_043y==2012;
replace b13_043y=2010 if b13_043y==2012;
replace b13_043y=2008 if b13_043y==8 & hrbf_id1==19 & hrbf_id2==10 & b13_033==2 & b13_034n==1;
replace b13_043y=2008 if b13_043y==1 & hrbf_id1==26 & hrbf_id2==12 & b13_033==2 & b13_034n==2;
replace b13_043y=2008 if b13_043y==0 & hrbf_id1==28 & hrbf_id2==8 & b13_033==2 & b13_034n==1;
replace b13_043y=2010 if b13_043y==0 & hrbf_id1==28 & hrbf_id2==8 & b13_033==2 & b13_034n==2;
replace b13_043y=2010 if b13_043y==10 & hrbf_id1==29 & hrbf_id2==7 & b13_033==2 & b13_034n==1;
replace b13_043y=2010 if b13_043y==10 & hrbf_id1==29 & hrbf_id2==8 & b13_033==2 & b13_034n==1;
replace b13_043y=2009 if b13_043y==9 & hrbf_id1==31 & hrbf_id2==8 & b13_033==2 & b13_034n==1;
replace b13_043y=2010 if b13_043y==1 & hrbf_id1==33 & hrbf_id2==12 & b13_033==2 & b13_034n==1;
replace b13_043y=2007 if b13_043y==7 & hrbf_id1==66 & hrbf_id2==5 & b13_033==2 & b13_034n==2;
replace b13_040y=2008 if b13_043y==9 & hrbf_id1==97 & hrbf_id2==2 & b13_033==2 & b13_034n==1;
replace b13_043y=2009 if b13_043y==9 & hrbf_id1==97 & hrbf_id2==2 & b13_033==2 & b13_034n==1;
replace b13_043y=2010 if b13_043y==1 & hrbf_id1==97 & hrbf_id2==5 & b13_033==2 & b13_034n==1;
replace b13_043y=2010 if b13_043y==10 & hrbf_id1==97 & hrbf_id2==8 & b13_033==2 & b13_034n==1;
replace b13_043y=2009 if b13_043y==209 & hrbf_id1==102 & hrbf_id2==4 & b13_033==2 & b13_034n==1;
replace b13_043y=2009 if b13_043y==9 & hrbf_id1==134 & hrbf_id2==7 & b13_033==2 & b13_034n==1;
replace b13_043y=2009 if b13_043y==9 & hrbf_id1==145 & hrbf_id2==4 & b13_033==2 & b13_034n==1;
replace b13_043y=2010 if b13_043y==10 & hrbf_id1==148 & hrbf_id2==6 & b13_033==2 & b13_034n==1;
replace b13_043y=2009 if b13_043y==9 & hrbf_id1==150 & hrbf_id2==11 & b13_033==2 & b13_034n==1;
replace b13_043y=2010 if b13_043y==1 & hrbf_id1==151 & hrbf_id2==3 & b13_033==2 & b13_034n==1;
replace b13_043y=2010 if b13_043y==1 & hrbf_id1==156 & hrbf_id2==5 & b13_033==2 & b13_034n==1;
replace b13_043y=2009 if b13_043y==9 & hrbf_id1==176 & hrbf_id2==3 & b13_033==2 & b13_034n==1;
replace b13_043y=. if b13_043y==0 & hrbf_id1==180 & hrbf_id2==10 & b13_033==2 & b13_034n==1;
replace b13_043y=2009 if b13_043y==9 & hrbf_id1==183 & hrbf_id2==8 & b13_033==2 & b13_034n==1;
replace b13_043m=. if hrbf_id1==183 & hrbf_id2==8 & b13_033==2 & b13_034n==1;
replace b13_043y=. if hrbf_id1==196 & hrbf_id2==10 & b13_033==1 & b13_034n==1;
replace b13_043m=. if hrbf_id1==196 & hrbf_id2==10 & b13_033==1 & b13_034n==1;
replace b13_043y=2009 if b13_043y==9 & hrbf_id1==201 & hrbf_id2==1 & b13_033==2 & b13_034n==1;
replace b13_043y=. if b13_043y==0 & hrbf_id1==206 & hrbf_id2==7 & b13_033==2 & b13_034n==1;
replace b13_043y=. if b13_043y==1 & hrbf_id1==217 & hrbf_id2==3 & b13_033==3 & b13_034n==1;
replace b13_043m=. if hrbf_id1==217 & hrbf_id2==3 & b13_033==3 & b13_034n==1;
replace b13_034n=2 if b13_043y==2 & hrbf_id1==217 & hrbf_id2==3 & b13_033==3 & b13_034n==1;
replace b13_043y=2008 if b13_043y==2 & hrbf_id1==217 & hrbf_id2==3 & b13_033==3 & b13_034n==2;
replace b13_043y=2009 if b13_043y==9 & hrbf_id1==220 & hrbf_id2==1 & b13_033==2 & b13_034n==1;
replace b13_043y=2009 if b13_043y==1 & hrbf_id1==220 & hrbf_id2==6 & b13_033==2 & b13_034n==1;
replace b13_043y=2009 if b13_043y==9 & hrbf_id1==223 & hrbf_id2==3 & b13_033==2 & b13_034n==1;
replace b13_045a=2 if b13_045a==3;
replace b13_047b=. if b13_047b==0;
replace b13_052=. if b13_052==96 | b13_052==99;
replace b13_053=2 if b13_053==9;
replace b13_054e=2 if b13_054e==9;
replace b13_056e=. if b13_056e==96;
replace b13_061a=2 if b13_061a==6;
tab b13_063a;
replace b13_063a=. if b13_063a>12;
list  hrbf_id1 hrbf_id2 b13_033 b13_034n b13_057 b13_040m b13_040y b13_043m b13_043y b13_063a b13_063b if b13_063a==0;
* br if hrbf_id1==206 & hrbf_id2==9 & b13_033==3;
* child PID: 6;
* Verif: use $cleandatadir/rwhrbf_a01_withstudyarms.dta, clear;
* Verif: list a1_10_d a1_10_m a1_10_y a1_11a a1_11b a1_11b if hrbf_id1==206 & hrbf_id2==9 & a1_pid==6;
replace b13_063a=10 if hrbf_id1==206 & hrbf_id2==9 & b13_033==3 & b13_034n==1;
replace b13_063b=2009 if hrbf_id1==206 & hrbf_id2==9 & b13_033==3 & b13_034n==1;
tab b13_063b;
list  hrbf_id1 hrbf_id2 b13_033 b13_034n b13_040m b13_040y b13_043m b13_043y b13_063a b13_063b if b13_063b==0;
replace b13_063b=2010 if b13_063b==0;
list  hrbf_id1 hrbf_id2 b13_033 b13_034n b13_040m b13_040y b13_043m b13_043y b13_063a b13_063b if b13_063b<2008 | b13_063b==2201 | b13_063b==3010;
replace b13_063b=2010 if b13_063b==10;
replace b13_063b=2009 if b13_063b==2201;
replace b13_063b=2010 if b13_063b==3010;
replace b13_063b=2008 if b13_063b==2007 & hrbf_id1==28 & hrbf_id2==8 & b13_033==2 & b13_034n==2;
replace b13_063b=2008 if b13_063b==2005 & hrbf_id1==88 & hrbf_id2==1 & b13_033==2 & b13_034n==1;
replace b13_040y=2008 if hrbf_id1==88 & hrbf_id2==1 & b13_033==2 & b13_034n==1;
replace b13_043y=2008 if hrbf_id1==88 & hrbf_id2==1 & b13_033==2 & b13_034n==1;
replace b13_063b=2010 if b13_063b==2007 & hrbf_id1==150 & hrbf_id2==12 & b13_033==2 & b13_034n==1;
replace b13_063b=2010 if b13_063b==2007 & hrbf_id1==163 & hrbf_id2==6 & b13_033==2 & b13_034n==1;
replace b13_063b=2009 if b13_063b==1994;
replace b13_063b=. if b13_063b==1996;
replace b13_063b=2010 if b13_063b==0 & hrbf_id1==190 & hrbf_id2==6 & b13_033==2 & b13_034n==1;
replace b13_063b=. if b13_063b==0 & hrbf_id1==206 & hrbf_id2==9 & b13_033==3 & b13_034n==1;
replace b13_063b=. if hrbf_id1==196 & hrbf_id2==10 & b13_033==1 & b13_034n==1;
replace b13_063a=. if hrbf_id1==196 & hrbf_id2==10 & b13_033==1 & b13_034n==1;
replace b13_063b=2009 if b13_063b==2;
* assert b13_047a==. if b13_046==1;
replace b13_047a=. if b13_046==1;
* assert b13_047b==. if b13_046==1;
replace b13_047b=. if b13_046==1;
assert b13_047c==. if b13_046==1;
* assert b13_050==. if b13_049==2;
replace b13_049=1 if b13_050!=. & b13_050!=0;
replace b13_049=2 if b13_050==0;
* assert b13_052==. if b13_051==2;
replace b13_051=1 if b13_052!=. & b13_052!=0;
replace b13_051=2 if b13_052==0;
foreach letter in a b c d e {;
	* assert b13_054`letter'==. if b13_053==2;
	replace b13_053=1 if b13_054`letter'==1;
	* assert b13_055`letter'==. if b13_053==2;
	replace b13_053=1 if b13_055`letter'!=.;
	* assert b13_056`letter'==. if b13_053==2;
	replace b13_053=1 if b13_056`letter'!=.;
};
* assert b13_058==. & b13_059==. & b13_060n=="" & b13_060c==. & b13_061_1==. & b13_061_2==. & b13_061_3==. & b13_061a==. & b13_061b==. & b13_062==. & b13_063a==. & b13_063b==. & b13_064a==. & b13_064b==. & b13_064c==. & b13_065a==. & b13_066a==. & b13_067a==. & b13_068a==. & b13_069a==. & b13_070a==. & b13_071a==. & b13_072a==. & b13_073a1==. & b13_073a2==. & b13_073a3==. & b13_074a==. & b13_075an==. & b13_075au==. & b13_076a==. & b13_077a==. & b13_078a==. & b13_065b==. & b13_066b==. & b13_067b==. & b13_068b==. & b13_069b==. & b13_070b==. & b13_071b==. & b13_072b==. & b13_073b1==. & b13_073b2==. & b13_073b3==. & b13_074b==. & b13_075bn==. & b13_075bu==. & b13_076b==. & b13_077b==. & b13_078b==. & b13_065c==. & b13_066c==. & b13_067c==. & b13_068c==. & b13_069c==. & b13_070c==. & b13_071c==. & b13_072c==. & b13_073c1==. & b13_073c2==. & b13_073c3==. & b13_074c==. & b13_075cn==. & b13_075cu==. & b13_076c==. & b13_077c==. & b13_078c==. & b13_079a==. & b13_079b==. & b13_079c==. & b13_079d==. & b13_079e==. & b13_079f==. & b13_079g==. & b13_079h==. & b13_079i==. if b13_057>=4 & b13_057<=6;
* br if (b13_058!=. | b13_059!=. | b13_060n!="" | b13_060c!=. | b13_061_1!=. | b13_061_2!=. | b13_061_3!=. | b13_061a!=. | b13_061b!=. | b13_062!=. | b13_063a!=. | b13_063b!=. | b13_064a!=. | b13_064b!=. | b13_064c!=. | b13_065a!=. | b13_066a!=. | b13_067a!=. | b13_068a!=. | b13_069a!=. | b13_070a!=. | b13_071a!=. | b13_072a!=. | b13_073a1!=. | b13_073a2!=. | b13_073a3!=. | b13_074a!=. | b13_075an!=. | b13_075au!=. | b13_076a!=. | b13_077a!=. | b13_078a!=. | b13_065b!=. | b13_066b!=. | b13_067b!=. | b13_068b!=. | b13_069b!=. | b13_070b!=. | b13_071b!=. | b13_072b!=. | b13_073b1!=. | b13_073b2!=. | b13_073b3!=. | b13_074b!=. | b13_075bn!=. | b13_075bu!=. | b13_076b!=. | b13_077b!=. | b13_078b!=. | b13_065c!=. | b13_066c!=. | b13_067c!=. | b13_068c!=. | b13_069c!=. | b13_070c!=. | b13_071c!=. | b13_072c!=. | b13_073c1!=. | b13_073c2!=. | b13_073c3!=. | b13_074c!=. | b13_075cn!=. | b13_075cu!=. | b13_076c!=. | b13_077c!=. | b13_078c!=. | b13_079a!=. | b13_079b!=. | b13_079c!=. | b13_079d!=. | b13_079e!=. | b13_079f!=. | b13_079g!=. | b13_079h!=. | b13_079i!=.) & b13_057>=4 & b13_057<=6;
replace b13_057=1 if b13_057==4 & b13_063a!=. & b13_063b!=. & b13_069a==1;
foreach var of varlist b13_058 b13_059 b13_060c b13_061_1 b13_061_2 b13_061_3 b13_061a b13_061b b13_062 b13_063a b13_063b b13_064a b13_064b b13_064c b13_065a b13_066a b13_067a b13_068a b13_069a b13_070a b13_071a b13_072a b13_073a1 b13_073a2 b13_073a3 b13_074a b13_075an b13_075au b13_076a b13_077a b13_078a b13_065b b13_066b b13_067b b13_068b b13_069b b13_070b b13_071b b13_072b b13_073b1 b13_073b2 b13_073b3 b13_074b b13_075bn b13_075bu b13_076b b13_077b b13_078b b13_065c b13_066c b13_067c b13_068c b13_069c b13_070c b13_071c b13_072c b13_073c1 b13_073c2 b13_073c3 b13_074c b13_075cn b13_075cu b13_076c b13_077c b13_078c b13_079a b13_079b b13_079c b13_079d b13_079e b13_079f b13_079g b13_079h b13_079i {;
	replace `var'=. if b13_057==5 | b13_057==4;
};
replace b13_060n ="" if b13_057==5 | b13_057==4;
* assert b13_080==. & b13_081a==. & b13_081b==. & b13_082==. & b13_083==. & b13_083a==. & b13_083b==. & b13_084==. & b13_085n=="" & b13_085c==. & b13_086==. & b13_087a==. & b13_087b==. & b13_087c==. & b13_088==. & b13_089n==. & b13_089u==. & b13_090==. & b13_091==. & b13_092==. & b13_093n==. & b13_093u==. & b13_094==. & b13_095==. if b13_057==4;
* br if (b13_080!=. | b13_081a!=. | b13_081b!=. | b13_082!=. | b13_083!=. | b13_083a!=. | b13_083b!=. | b13_084!=. | b13_085n!="" | b13_085c!=. | b13_086!=. | b13_087a!=. | b13_087b!=. | b13_087c!=. | b13_088!=. | b13_089n!=. | b13_089u!=. | b13_090!=. | b13_091!=. | b13_092!=. | b13_093n!=. | b13_093u!=. | b13_094!=. | b13_095!=.) & b13_057==4;
foreach var of varlist b13_080 b13_081a b13_081b b13_082 b13_083 b13_083a b13_083b b13_084 b13_085c b13_086 b13_087a b13_087b b13_087c b13_088 b13_089n b13_089u b13_090 b13_091 b13_092 b13_093n b13_093u b13_094 b13_095 {;
	replace `var'=. if b13_057==4;
};
replace b13_085n="" if b13_057==4; 
* assert b13_061_1==. if b13_059<6;
* assert b13_061_2==. if b13_059<6;
* assert b13_061_3==. if b13_059<6;
forvalues v=1(1)3 {;
	replace b13_061_`v'=. if b13_059<6;
};
* assert b13_061b==. if b13_061a==2;
replace b13_061a=2 if b13_061b<10;
replace b13_061b=. if b13_061b<10;
list  hrbf_id1 hrbf_id2 b13_033 b13_034n b13_040m b13_040y b13_043m b13_043y b13_063a b13_063b b13_062 b13_064b if b13_064b==0, compress;
replace b13_064b=. if b13_064b==0;
replace b13_064c=. if b13_064c==0;
replace b13_065a=2 if b13_065a==0 | b13_065a==3;
* foreach letter in a b c {;
	* assert b13_066`letter'==. if b13_065`letter'==2;
	* assert b13_067`letter'==. if b13_065`letter'==2;
* };
list b13_065a b13_066a b13_067a b13_068a if  b13_066a!=. & b13_065a==2;
replace b13_066a=. if b13_065a==2;
list b13_065b b13_066b b13_067b b13_068b if  b13_066b!=. & b13_065b==2;
replace b13_065b=1 if b13_066b==2 & b13_067b==4600;
list b13_065a b13_066a b13_067a b13_068a if  b13_067a!=. & b13_065a==2;
tab b13_067a;
replace b13_067a=. if b13_067a<1000;
list b13_065b b13_066b b13_067b b13_068b if  b13_067b!=. & b13_065b==2;
replace b13_065b=1 if b13_066b==2 & b13_067b==4600;
* assert b13_070a==. if b13_069a==2;
list b13_069a b13_070a b13_071a b13_072a b13_073a1 if b13_070a!=. & b13_069a==2;
replace b13_069a=1 if b13_070a!=.;
* assert b13_071a==. if b13_069a==2; 
list b13_069a b13_070a b13_071a b13_072a b13_073a1 if b13_071a!=. & b13_069a==2;
replace b13_069a=1 if b13_071a!=.;
assert b13_072a==. if b13_069a==2;
* assert b13_070b==. if b13_069b==2;
list b13_069b b13_070b b13_071b b13_072b b13_073b1 if b13_070b!=. & b13_069b==2;
replace b13_069b=1 if b13_070b!=.;
assert b13_071b==. if b13_069b==2;
assert b13_072b==. if b13_069b==2;
replace b13_071a=. if b13_071a>=96 & b13_071a!=98;
list  hrbf_id1 hrbf_id2 b13_033 b13_034n b13_040m b13_040y b13_043m b13_043y b13_063a b13_063b if b13_071a==98, compress;
***;
gen b13_071a_98=b13_071a==98;
replace b13_071a_98=. if b13_071a==.;
lab var b13_071a_98 "Still breastfeeding";
replace b13_071a=. if b13_071a==98;
***;
replace b13_072a=2 if b13_072a==3;
replace b13_073a1=10 if b13_073a1==11;
replace b13_073a1=96 if b13_073a1==98;
* assert b13_075an==. if b13_074a==1;
* br if b13_075an!=. & b13_074a==1;
replace b13_074a=2 if b13_074a==1 & b13_075an==9 & b13_076a==.;
replace b13_075an=. if b13_074a==1;
replace b13_075au=. if b13_074a==1;
assert b13_075bn==. if b13_074b==1;
assert b13_075cn==. if b13_074c==1;
assert b13_075bu==. if b13_074b==1;
assert b13_075cu==. if b13_074c==1;
assert b13_074a==2 if b13_075an!=.; 
assert b13_074a==2 if b13_075au!=.; 
assert b13_074b==2 if b13_075bn!=.; 
* assert b13_074b==2 if b13_075bu!=.; 
replace b13_075bu=. if b13_074b==2;
* assert b13_074c==2 if b13_075cn!=.; 
* assert b13_074c==2 if b13_075cu!=.; 
replace b13_075cn=. if b13_075cn!=. & b13_074c==.;
replace b13_075cu=. if b13_075cu!=. & b13_074c==.;
replace b13_075an=. if b13_075an==96;
replace b13_076a=2 if b13_076a==5;
replace b13_076a=1 if b13_076a==4;
replace b13_077a=. if b13_077a==96;
tab b13_078a;
list  hrbf_id1 hrbf_id2 b13_033 b13_034n b13_040m b13_040y b13_043m b13_043y b13_063a b13_063b b13_062 b13_064b b13_078a if b13_078a>3 & b13_078a<., compress;
replace b13_078a=. if b13_078a==98;
replace b13_078a=2 if b13_078a==4 & hrbf_id1==111 & hrbf_id2==10 & b13_033==2 & b13_034n==2;
replace b13_078a=0 if b13_078a==7 & hrbf_id1==138 & hrbf_id2==8 & b13_033==2 & b13_034n==1;
replace b13_078a=2 if b13_078a==12;
replace b13_078a=1 if b13_078a==4 & hrbf_id1==165 & hrbf_id2==2 & b13_033==2 & b13_034n==1;
replace b13_078a=0 if b13_078a==78 & hrbf_id1==171 & hrbf_id2==9 & b13_033==2 & b13_034n==1;
replace b13_078a=1 if b13_078a==4 & hrbf_id1==182 & hrbf_id2==12 & b13_033==3 & b13_034n==1;
replace b13_067b=. if b13_067b==99 | b13_067b==200;
list  hrbf_id1 hrbf_id2 b13_033 b13_034n b13_040m b13_040y b13_043m b13_043y b13_063a b13_063b if b13_071b==98, compress;
***;
gen b13_071b_98=b13_071b==98;
replace b13_071b_98=. if b13_071b==.;
lab var b13_071b_98 "Still breastfeeding";
replace b13_071b=. if b13_071b==98;
***;
replace b13_073b2=10 if b13_073b2==0;
replace b13_073b3=10 if b13_073b3==0;
replace b13_078b=. if b13_078b==98;
replace b13_080=2 if b13_080==0;
* assert b13_081a==. & b13_081b==. & b13_082==. & b13_083==. & b13_083a==. & b13_083b==. & b13_084==. & b13_085n=="" & b13_085c==. & b13_086==. if b13_080==2;
list b13_080 b13_081a b13_081b b13_082 b13_083 b13_083a b13_083b b13_084 b13_085n b13_085c b13_086 if (b13_081a!=. | b13_081b!=. | b13_082!=. | b13_083!=. | b13_083a!=. | b13_083b!=. | b13_084!=. | b13_085n=="" | b13_085c==.  | b13_086!=.) & b13_080==2, compress;
replace b13_080=1 if b13_081a!=. & b13_081b!=. & b13_082!=.;
foreach var of varlist b13_080 b13_081a b13_081b b13_082 b13_083 b13_083a b13_083b b13_084  b13_085c b13_086 {;
	replace `var'=. if b13_080==2;
};
replace b13_085n="" if b13_080==2;
* assert b13_083b==. if b13_083a==2;
tab b13_083b b13_083a;
replace b13_083a=2 if b13_083b<100;
replace b13_083b=. if b13_083b<100;
replace b13_087a=96 if b13_087a==46 | b13_087a==98;
replace b13_087a=. if b13_087a==0;
replace b13_087b=. if b13_087b==0;
replace b13_087c=. if b13_087c==0;
* assert b13_087a==. if b13_086==1;
list b13_080 b13_081a b13_081b b13_084 b13_086 b13_087a b13_087b b13_087c b13_088 if b13_087a!=. & b13_086==1;
replace b13_087a=. if b13_086==1;
* assert b13_089n==. & b13_089u==. & b13_090==. & b13_091==. if b13_088==2;
list b13_088 b13_089n b13_089u b13_090 b13_091 if (b13_089n!=. |  b13_089u!=. | b13_090!=. | b13_091!=.) & b13_088==2;
replace b13_088=1 if b13_089n!=. & b13_089u!=.;
replace b13_089n=. if b13_089n==96;
replace b13_089u=. if b13_089u==0;
replace b13_091=. if b13_091==96;
replace b13_095=. if b13_095==96;
* assert b13_093n==. & b13_093u==. & b13_094==. & b13_095==. if b13_092==2;
list b13_092 b13_093n b13_093u b13_094 b13_095 if (b13_093n!=. | b13_093u!=. | b13_094!=. | b13_095!=.) & b13_092==2;
replace b13_092=1 if b13_093n!=. & b13_093u!=.;

*** Dates and birth order cleaning;

gen b13_040y_1=ym(b13_040y,b13_040m);
replace b13_040y_1=dofm(b13_040y_1);
replace b13_040y_1=. if b13_040y==.;
* assert year(b13_040y_1)>=2007 | b13_040y_1==.;
list b13_039 b13_040y b13_040m b13_040y_1 b13_043y b13_043m if year(b13_040y_1)<2007;
replace b13_040y=2009 if b13_040y==2004;
replace b13_040y=2009 if b13_040y==2000 & b13_043y==2010;
replace b13_040y=2008 if b13_040y==2000 & b13_043y==2009;
replace b13_040y=2009 if b13_040y==2006 & b13_043y==2009;

gen b13_043y_1=ym(b13_043y,b13_043m);
replace b13_043y_1=dofm(b13_043y_1);
replace b13_043y_1=. if b13_043y==.;
* assert year(b13_043y_1)>=2008 | b13_043y_1==.;
sort hrbf_id1 hrbf_id2 b13_033 b13_034n;
list b13_040y_1 b13_040m b13_040y b13_043m b13_043y b13_063a b13_063b if year(b13_043y_1)<2008;
replace b13_040y=2008 if b13_043y==2005;
replace b13_043y=2008 if b13_043y==2005;
replace b13_043y=2008 if b13_043y==2002;
replace b13_043y=2010 if b13_043y==2003;
list hrbf_id1 hrbf_id2 b13c_seq b13_033 b13_034n b13_040m b13_040y b13_043m b13_043y b13_063a b13_063b if _n>=535 & _n<=545, compress;
replace b13_063b=2008 if _n==538;
replace b13_043y=2008 if b13_043y==2007 & b13_043m==1 & b13_040m==12 & b13_040y==2007 & b13_063a==2 & b13_063b==2008;
replace b13_043y=2010 if b13_043y==2001;
replace b13_043y=2008 if b13_043y==2007 & b13_043m==3 & b13_040m==8 & b13_040y==2007 & b13_063b==2008 & b13_063a==3;
replace b13_063a=2 if b13_043y==2007 & b13_043m==12 & b13_040m==5 & b13_040y==2007 & b13_063b==2008 & b13_063a==.;
replace b13_043y=2008 if b13_043y==2007 & b13_043m==5 & b13_040m==2 & b13_040y==2008 & b13_063b==2008 & b13_063a==6;
replace b13_043y=2008 if b13_043y==2007 & b13_043m==5 & b13_040m==11 & b13_040y==2007 & b13_063b==2008 & b13_063a==5;
replace b13_043y=2008 if b13_043y==2007 & b13_043m==3 & b13_040m==11 & b13_040y==2007 & b13_063b==2008 & b13_063a==4;
drop if b13_040y<2008 & b13_043y<2008 & b13_063b<2008 & b13_040y!=. & b13_043y!=. & b13_063b!=.;

* assert b13_043y_1>=b13_040y_1 if b13_043y!=. & b13_043m!=. & b13_040y!=. & b13_040m!=.;
list hrbf_id1 hrbf_id2 b13_033 b13_034n b13_040m b13_040y b13_043m b13_043y if b13_043y_1<b13_040y_1 & b13_043y!=. & b13_043m!=. & b13_040y!=. & b13_040m!=.;
list hrbf_id1 hrbf_id2 b13_033 b13_034n b13_040m b13_040y b13_043m b13_043y b13_063a b13_063b b13c_seq if (hrbf_id1==2 & hrbf_id2==6 & b13_033==2) | (hrbf_id1==4 & hrbf_id2==6 & b13_033==2) | (hrbf_id1==7 & hrbf_id2==4 & b13_033==2) | (hrbf_id1==9 & hrbf_id2==5 & b13_033==2) | (hrbf_id1==11 & hrbf_id2==8 & b13_033==2) | (hrbf_id1==12 & hrbf_id2==10 & b13_033==2) | (hrbf_id1==15 & hrbf_id2==10 & b13_033==2) | (hrbf_id1==16 & hrbf_id2==5 & b13_033==2) | (hrbf_id1==17 & hrbf_id2==10 & b13_033==2) | (hrbf_id1==21 & hrbf_id2==1 & b13_033==2) | (hrbf_id1==21 & hrbf_id2==10 & b13_033==2) | (hrbf_id1==28 & hrbf_id2==8 & b13_033==2) | (hrbf_id1==29 & hrbf_id2==6 & b13_033==2) | (hrbf_id1==30 & hrbf_id2==1 & b13_033==2) | (hrbf_id1==30 & hrbf_id2==7 & b13_033==4) | (hrbf_id1==30 & hrbf_id2==12 & b13_033==2) | (hrbf_id1==35 & hrbf_id2==12 & b13_033==2) | (hrbf_id1==37 & hrbf_id2==11 & b13_033==2) | (hrbf_id1==39 & hrbf_id2==6 & b13_033==2) | (hrbf_id1==40 & hrbf_id2==10 & b13_033==2) | (hrbf_id1==40 & hrbf_id2==10 & b13_033==2 ) | (hrbf_id1==44 & hrbf_id2==7 & b13_033==2) | (hrbf_id1==47 & hrbf_id2==5 & b13_033==2) | (hrbf_id1==48 & hrbf_id2==5 & b13_033==2) | (hrbf_id1==48 & hrbf_id2==11 & b13_033==2) | (hrbf_id1==50 & hrbf_id2==4 & b13_033==2) | (hrbf_id1==53 & hrbf_id2==3 & b13_033==2) | (hrbf_id1==53 & hrbf_id2==6 & b13_033==2) | (hrbf_id1==57 & hrbf_id2==9 & b13_033==2) | (hrbf_id1==57 & hrbf_id2==11 & b13_033==2 ) | (hrbf_id1==59 & hrbf_id2==6 & b13_033==2) | (hrbf_id1==63 & hrbf_id2==5 & b13_033==2) | (hrbf_id1==64 & hrbf_id2==2 & b13_033==2) | (hrbf_id1==64 & hrbf_id2==11 & b13_033==2) | (hrbf_id1==66 & hrbf_id2==2 & b13_033==2) | (hrbf_id1==66 & hrbf_id2==8 & b13_033==2) | (hrbf_id1==71 & hrbf_id2==7 & b13_033==2) | (hrbf_id1==72 & hrbf_id2==1 & b13_033==2) | (hrbf_id1==75 & hrbf_id2==11 & b13_033==2 ) | (hrbf_id1==78 & hrbf_id2==7 & b13_033==2) | (hrbf_id1==79 & hrbf_id2==4 & b13_033==2) | (hrbf_id1==79 & hrbf_id2==8 & b13_033==2) | (hrbf_id1==79 & hrbf_id2==11 & b13_033==2 ) | (hrbf_id1==81 & hrbf_id2==5 & b13_033==3) | (hrbf_id1==81 & hrbf_id2==5 & b13_033==4) | (hrbf_id1==86 & hrbf_id2==4 & b13_033==2) | (hrbf_id1==88 & hrbf_id2==1 & b13_033==2) | (hrbf_id1==88 & hrbf_id2==1 & b13_033==2) | (hrbf_id1==90 & hrbf_id2==1 & b13_033==2) | (hrbf_id1==93 & hrbf_id2==5 & b13_033==2) | (hrbf_id1==95 & hrbf_id2==9 & b13_033==2) | (hrbf_id1==97 & hrbf_id2==6 & b13_033==2) | (hrbf_id1==97 & hrbf_id2==9 & b13_033==2) | (hrbf_id1==100 & hrbf_id2==4 & b13_033==2) | (hrbf_id1==100 & hrbf_id2==4 & b13_033==2) | (hrbf_id1==101 & hrbf_id2==1 & b13_033==3) | (hrbf_id1==101 & hrbf_id2==6 & b13_033==2) | (hrbf_id1==101 & hrbf_id2==7 & b13_033==2) | (hrbf_id1==102 & hrbf_id2==7 & b13_033==2) | (hrbf_id1==103 & hrbf_id2==8 & b13_033==2) | (hrbf_id1==106 & hrbf_id2==8 & b13_033==2) | (hrbf_id1==108 & hrbf_id2==3 & b13_033==2) | (hrbf_id1==109 & hrbf_id2==9 & b13_033==2) | (hrbf_id1==110 & hrbf_id2==6 & b13_033==1 ) | (hrbf_id1==114 & hrbf_id2==12 & b13_033==2) | (hrbf_id1==116 & hrbf_id2==12 & b13_033==2) | (hrbf_id1==117 & hrbf_id2==10 & b13_033==2) | (hrbf_id1==119 & hrbf_id2==3 & b13_033==2) | (hrbf_id1==119 & hrbf_id2==5 & b13_033==2) | (hrbf_id1==119 & hrbf_id2==8 & b13_033==2) | (hrbf_id1==119 & hrbf_id2==9 & b13_033==1) | (hrbf_id1==125 & hrbf_id2==5 & b13_033==2) | (hrbf_id1==126 & hrbf_id2==11 & b13_033==2) | (hrbf_id1==128 & hrbf_id2==2 & b13_033==2) | (hrbf_id1==129 & hrbf_id2==4 & b13_033==2) | (hrbf_id1==130 & hrbf_id2==11 & b13_033==2) | (hrbf_id1==130 & hrbf_id2==8 & b13_033==2) | (hrbf_id1==132 & hrbf_id2==7 & b13_033==2) | (hrbf_id1==133 & hrbf_id2==7 & b13_033==2) | (hrbf_id1==133 & hrbf_id2==11 & b13_033==2) | (hrbf_id1==134 & hrbf_id2==8 & b13_033==2) | (hrbf_id1==136 & hrbf_id2==2 & b13_033==2) | (hrbf_id1==138 & hrbf_id2==12 & b13_033==2) | (hrbf_id1==141 & hrbf_id2==12 & b13_033==2) | (hrbf_id1==141 & hrbf_id2==11 & b13_033==2) | (hrbf_id1==146 & hrbf_id2==7 & b13_033==2) | (hrbf_id1==149 & hrbf_id2==4 & b13_033==2) | (hrbf_id1==149 & hrbf_id2==8 & b13_033==2) | (hrbf_id1==164 & hrbf_id2==2 & b13_033==2) | (hrbf_id1==165 & hrbf_id2==3 & b13_033==2) | (hrbf_id1==169 & hrbf_id2==6 & b13_033==2) | (hrbf_id1==170 & hrbf_id2==2 & b13_033==2) | (hrbf_id1==171 & hrbf_id2==11 & b13_033==2) | (hrbf_id1==180 & hrbf_id2==1 & b13_033==2) | (hrbf_id1==180 & hrbf_id2==9 & b13_033==2) | (hrbf_id1==181 & hrbf_id2==12 & b13_033==2) | (hrbf_id1==185 & hrbf_id2==6 & b13_033==2 ) | (hrbf_id1==187 & hrbf_id2==1 & b13_033==2) | (hrbf_id1==191 & hrbf_id2==10 & b13_033==2) | (hrbf_id1==193 & hrbf_id2==2 & b13_033==2) | (hrbf_id1==193 & hrbf_id2==2 & b13_033==2) | (hrbf_id1==200 & hrbf_id2==6 & b13_033==2) | (hrbf_id1==200 & hrbf_id2==1 & b13_033==2) | (hrbf_id1==205 & hrbf_id2==9 & b13_033==2) | (hrbf_id1==208 & hrbf_id2==2 & b13_033==2) | (hrbf_id1==211 & hrbf_id2==3 & b13_033==2) | (hrbf_id1==215 & hrbf_id2==6 & b13_033==3) | (hrbf_id1==215 & hrbf_id2==11 & b13_033==1) | (hrbf_id1==216 & hrbf_id2==11 & b13_033==2) | (hrbf_id1==217 & hrbf_id2==7 & b13_033==2) | (hrbf_id1==222 & hrbf_id2==3 & b13_033==2);
replace b13_040y=2009 if hrbf_id1==2 & hrbf_id2==6 & b13_033==2 & b13_034n==1;
replace b13_040y=2009 if hrbf_id1==4 & hrbf_id2==6 & b13_033==2 & b13_034n==1;
replace b13_040y=2007 if hrbf_id1==7 & hrbf_id2==4 & b13_033==2 & b13_034n==2;
replace b13_043y=2010 if hrbf_id1==9 & hrbf_id2==5 & b13_033==2 & b13_034n==1;
replace b13_043m=12 if hrbf_id1==11 & hrbf_id2==8 & b13_033==2 & b13_034n==1;
replace b13_040y=2009 if hrbf_id1==12 & hrbf_id2==10 & b13_033==2 & b13_034n==1;
replace b13_040m=2 if hrbf_id1==15 & hrbf_id2==10 & b13_033==2 & b13_034n==1;
replace b13_040y=2009 if hrbf_id1==16 & hrbf_id2==5 & b13_033==2 & b13_034n==1;
replace b13_040y=2009 if hrbf_id1==17 & hrbf_id2==10 & b13_033==2 & b13_034n==1;
replace b13_043y=2010 if hrbf_id1==21 & hrbf_id2==1 & b13_033==2 & b13_034n==1;
replace b13_043y=2010 if hrbf_id1==21 & hrbf_id2==10 & b13_033==2 & b13_034n==1;
replace b13_043y=. if hrbf_id1==28 & hrbf_id2==8 & b13_033==2 & b13_034n==1;
replace b13_043m=. if hrbf_id1==28 & hrbf_id2==8 & b13_033==2 & b13_034n==1;
replace b13_040y=2009 if hrbf_id1==28 & hrbf_id2==8 & b13_033==2 & b13_034n==2;
replace b13_043y=2010 if hrbf_id1==29 & hrbf_id2==6 & b13_033==2 & b13_034n==1;
replace b13_043m=11 if hrbf_id1==30 & hrbf_id2==1 & b13_033==2 & b13_034n==1;
replace b13_043y=2010 if hrbf_id1==30 & hrbf_id2==7 & b13_033==4 & b13_034n==1;
replace b13_043y=2010 if hrbf_id1==30 & hrbf_id2==12 & b13_033==2 & b13_034n==1;
replace b13_040m=. if hrbf_id1==35 & hrbf_id2==12 & b13_033==2 & b13_034n==1;
replace b13_040y=. if hrbf_id1==35 & hrbf_id2==12 & b13_033==2 & b13_034n==1;
replace b13_043m=. if hrbf_id1==35 & hrbf_id2==12 & b13_033==2 & b13_034n==1;
replace b13_043y=. if hrbf_id1==35 & hrbf_id2==12 & b13_033==2 & b13_034n==1;
replace b13_043m=7 if hrbf_id1==37 & hrbf_id2==11 & b13_033==2 & b13_034n==2;
replace b13_043m=11 if hrbf_id1==39 & hrbf_id2==6 & b13_033==2 & b13_034n==1;
replace b13_043m=9 if hrbf_id1==40 & hrbf_id2==10 & b13_033==2 & b13_034n==1;
replace b13_043y=2008 if hrbf_id1==40 & hrbf_id2==10 & b13_033==2 & b13_034n==2;
replace b13_040y=2007 if hrbf_id1==40 & hrbf_id2==10 & b13_033==2 & b13_034n==2;
replace b13_043m=11 if hrbf_id1==44 & hrbf_id2==7 & b13_033==2 & b13_034n==1;
replace b13_040y=2007 if hrbf_id1==47 & hrbf_id2==5 & b13_033==2 & b13_034n==1;
replace b13_043y=2010 if hrbf_id1==48 & hrbf_id2==5 & b13_033==2 & b13_034n==1;
replace b13_043m=7 if hrbf_id1==48 & hrbf_id2==11 & b13_033==2 & b13_034n==2;
replace b13_040y=2009 if hrbf_id1==50 & hrbf_id2==4 & b13_033==2 & b13_034n==1;
replace b13_043y=2010 if hrbf_id1==53 & hrbf_id2==3 & b13_033==2 & b13_034n==1;
replace b13_043y=. if hrbf_id1==53 & hrbf_id2==3 & b13_033==2 & b13_034n==2;
replace b13_043y=2008 if hrbf_id1==53 & hrbf_id2==3 & b13_033==2 & b13_034n==2;
replace b13_043m=2 if hrbf_id1==53 & hrbf_id2==3 & b13_033==2 & b13_034n==2;
replace b13_043y=2010 if hrbf_id1==53 & hrbf_id2==6 & b13_033==2 & b13_034n==1;
replace b13_040y=2009 if hrbf_id1==57 & hrbf_id2==9 & b13_033==2 & b13_034n==1;
replace b13_040y=2009 if hrbf_id1==57 & hrbf_id2==11 & b13_033==2 & b13_034n==1;
replace b13_040y=2009 if hrbf_id1==59 & hrbf_id2==6 & b13_033==2 & b13_034n==1;
replace b13_043y=2010 if hrbf_id1==63 & hrbf_id2==5 & b13_033==2 & b13_034n==1;
replace b13_043y=2010 if hrbf_id1==64 & hrbf_id2==2 & b13_033==2 & b13_034n==1;
replace b13_043y=2010 if hrbf_id1==64 & hrbf_id2==11 & b13_033==2 & b13_034n==1;
replace b13_040y=2008 if hrbf_id1==66 & hrbf_id2==2 & b13_033==2 & b13_034n==1;
replace b13_043y=2010 if hrbf_id1==66 & hrbf_id2==8 & b13_033==2 & b13_034n==1;
replace b13_040y=2007 if hrbf_id1==71 & hrbf_id2==7 & b13_033==2 & b13_034n==1 & b13_040m==12;
replace b13_043y=2008 if hrbf_id1==71 & hrbf_id2==7 & b13_033==2 & b13_034n==1 & b13_040m==12;
replace b13_034n=2 if hrbf_id1==71 & hrbf_id2==7 & b13_033==2 & b13_034n==1 & b13_040m==12;
replace b13_040y=2007 if hrbf_id1==72 & hrbf_id2==1 & b13_033==2 & b13_034n==1 & b13_040m==11;
replace b13_034n=2 if hrbf_id1==72 & hrbf_id2==1 & b13_033==2 & b13_034n==1 & b13_040m==11;
replace b13_063a=3 if hrbf_id1==75 & hrbf_id2==11 & b13_033==2 & b13_034n==1;
replace b13_040y=2009 if hrbf_id1==75 & hrbf_id2==11 & b13_033==2 & b13_034n==1;
replace b13_043y=2010 if hrbf_id1==78 & hrbf_id2==7 & b13_033==2 & b13_034n==1;
replace b13_040y=2008 if hrbf_id1==79 & hrbf_id2==4 & b13_033==2 & b13_034n==1;
replace b13_043y=2010 if hrbf_id1==79 & hrbf_id2==8 & b13_033==2 & b13_034n==1;
replace b13_043y=2010 if hrbf_id1==79 & hrbf_id2==11 & b13_033==2 & b13_034n==1;
replace b13_043y=2010 if hrbf_id1==81 & hrbf_id2==5 & b13_033==3 & b13_034n==1;
replace b13_043y=2010 if hrbf_id1==81 & hrbf_id2==5 & b13_033==4 & b13_034n==1;
replace b13_043y=2009 if hrbf_id1==86 & hrbf_id2==4 & b13_033==2 & b13_034n==1 & b13_040m==8;
replace b13_034n=2 if hrbf_id1==86 & hrbf_id2==4 & b13_033==2 & b13_034n==1 & b13_040m==8;
drop if hrbf_id1==88 & hrbf_id2==1 & b13_033==2 & b13_034n==1;
replace b13_043y=2010 if hrbf_id1==90 & hrbf_id2==1 & b13_033==2 & b13_034n==1;
replace b13_040y=2009 if hrbf_id1==93 & hrbf_id2==5 & b13_033==2 & b13_034n==1;
replace b13_043y=2010 if hrbf_id1==95 & hrbf_id2==9 & b13_033==2 & b13_034n==1;
replace b13_040y=2009 if hrbf_id1==97 & hrbf_id2==6 & b13_033==2 & b13_034n==1;
replace b13_040y=2009 if hrbf_id1==97 & hrbf_id2==9 & b13_033==2 & b13_034n==1;
replace b13_040y=2007 if hrbf_id1==100 & hrbf_id2==4 & b13_033==2 & b13_034n==1;
replace b13_040y=2009 if hrbf_id1==100 & hrbf_id2==4 & b13_033==2 & b13_034n==2;
replace b13_040y=2009 if hrbf_id1==101 & hrbf_id2==1 & b13_033==3 & b13_034n==1;
replace b13_043m=1 if hrbf_id1==101 & hrbf_id2==1 & b13_033==3 & b13_034n==1;
replace b13_034n=2 if hrbf_id1==101 & hrbf_id2==6 & b13_033==2 & b13_034n==1 & b13c_seq==2;
replace b13_043y=2008 if hrbf_id1==101 & hrbf_id2==6 & b13_033==2 & b13_034n==2;
replace b13_040y=2007 if hrbf_id1==101 & hrbf_id2==6 & b13_033==2 & b13_034n==2;
replace b13_040y=2009 if hrbf_id1==101 & hrbf_id2==7 & b13_033==2 & b13_034n==1;
replace b13_043y=2010 if hrbf_id1==102 & hrbf_id2==7 & b13_033==2 & b13_034n==1;
replace b13_043y=2010 if hrbf_id1==103 & hrbf_id2==8 & b13_033==2 & b13_034n==1;
replace b13_040y=2009 if hrbf_id1==106 & hrbf_id2==8 & b13_033==2 & b13_034n==1;
replace b13_043y=2010 if hrbf_id1==108 & hrbf_id2==3 & b13_033==2 & b13_034n==1;
replace b13_043y=2010 if hrbf_id1==109 & hrbf_id2==9 & b13_033==2 & b13_034n==1;
replace b13_040y=2009 if hrbf_id1==110 & hrbf_id2==6 & b13_033==1 & b13_034n==1;
replace b13_043y=2010 if hrbf_id1==114 & hrbf_id2==12 & b13_033==2 & b13_034n==1;
replace b13_040y=2009 if hrbf_id1==116 & hrbf_id2==12 & b13_033==2 & b13_034n==1;
replace b13_034n=2 if hrbf_id1==117 & hrbf_id2==10 & b13_033==2 & b13_034n==1 & b13c_seq==2;
replace b13_040y=2007 if hrbf_id1==117 & hrbf_id2==10 & b13_033==2 & b13_034n==2;
replace b13_040y=2009 if hrbf_id1==119 & hrbf_id2==3 & b13_033==2 & b13_034n==1;
replace b13_040y=2009 if hrbf_id1==119 & hrbf_id2==5 & b13_033==2 & b13_034n==1;
replace b13_043y=2010 if hrbf_id1==119 & hrbf_id2==8 & b13_033==2 & b13_034n==1;
replace b13_043m=12 if hrbf_id1==119 & hrbf_id2==9 & b13_033==1 & b13_034n==1;
replace b13_040y=2008 if hrbf_id1==125 & hrbf_id2==5 & b13_033==2 & b13_034n==1;
replace b13_063a=4 if hrbf_id1==125 & hrbf_id2==5 & b13_033==2 & b13_034n==1;
replace b13_063a=4 if hrbf_id1==125 & hrbf_id2==5 & b13_033==2 & b13_034n==2;
replace b13_043y=2010 if hrbf_id1==126 & hrbf_id2==11 & b13_033==2 & b13_034n==1;
replace b13_043m=12 if hrbf_id1==128 & hrbf_id2==2 & b13_033==2 & b13_034n==1;
replace b13_040y=2009 if hrbf_id1==129 & hrbf_id2==4 & b13_033==2 & b13_034n==1;
replace b13_043y=2010 if hrbf_id1==130 & hrbf_id2==8 & b13_033==2 & b13_034n==1;
replace b13_063b=2008 if hrbf_id1==130 & hrbf_id2==11 & b13_033==2 & b13_034n==2;
replace b13_040m=1 if hrbf_id1==130 & hrbf_id2==11 & b13_033==2 & b13_034n==2;
replace b13_043m=9 if hrbf_id1==132 & hrbf_id2==7 & b13_033==2 & b13_034n==1;
replace b13_040y=2007 if hrbf_id1==133 & hrbf_id2==7 & b13_033==2 & b13_034n==2;
replace b13_040m=7 if hrbf_id1==133 & hrbf_id2==11 & b13_033==2 & b13_034n==1;
replace b13_040y=2008 if hrbf_id1==133 & hrbf_id2==11 & b13_033==2 & b13_034n==2;
replace b13_040y=2009 if hrbf_id1==134 & hrbf_id2==8 & b13_033==2 & b13_034n==1;
replace b13_040y=2009 if hrbf_id1==136 & hrbf_id2==2 & b13_033==2 & b13_034n==1;
replace b13_040y=2009 if hrbf_id1==138 & hrbf_id2==12 & b13_033==2 & b13_034n==1;
replace b13_040y=2009 if hrbf_id1==141 & hrbf_id2==11 & b13_033==2 & b13_034n==1;
replace b13_040y=2009 if hrbf_id1==141 & hrbf_id2==12 & b13_033==2 & b13_034n==1;
replace b13_040y=2008 if hrbf_id1==146 & hrbf_id2==7 & b13_033==2 & b13_034n==1;
replace b13_040y=2009 if hrbf_id1==149 & hrbf_id2==4 & b13_033==2 & b13_034n==1;
replace b13_043y=2010 if hrbf_id1==149 & hrbf_id2==8 & b13_033==2 & b13_034n==1;
replace b13_034n=2 if hrbf_id1==164 & hrbf_id2==2 & b13_033==2 & b13_034n==1 & b13c_seq==2;
replace b13_040m=2 if hrbf_id1==164 & hrbf_id2==2 & b13_033==2 & b13_034n==2;
replace b13_040y=2007 if hrbf_id1==165 & hrbf_id2==3 & b13_033==2 & b13_034n==1;
replace b13_063a=12 if hrbf_id1==169 & hrbf_id2==6 & b13_033==2 & b13_034n==1;
replace b13_040y=2008 if hrbf_id1==169 & hrbf_id2==6 & b13_033==2 & b13_034n==1;
replace b13_043y=2010 if hrbf_id1==170 & hrbf_id2==2 & b13_033==2 & b13_034n==1;
replace b13_043y=2010 if hrbf_id1==171 & hrbf_id2==11 & b13_033==2 & b13_034n==1;
replace b13_040y=2008 if hrbf_id1==180 & hrbf_id2==1 & b13_033==2 & b13_034n==1;
replace b13_040y=2007 if hrbf_id1==180 & hrbf_id2==9 & b13_033==2 & b13_034n==2;
replace b13_040y=2009 if hrbf_id1==181 & hrbf_id2==12 & b13_033==2 & b13_034n==1;
replace b13_043m=2 if hrbf_id1==185 & hrbf_id2==6 & b13_033==2 & b13_034n==1;
replace b13_034n=2 if hrbf_id1==187 & hrbf_id2==1 & b13_033==2 & b13_034n==1 & b13c_seq==2;
replace b13_043y=2010 if hrbf_id1==187 & hrbf_id2==1 & b13_033==2 & b13_034n==1;
replace b13_043m=1 if hrbf_id1==187 & hrbf_id2==1 & b13_033==2 & b13_034n==1;
replace b13_043y=2008 if hrbf_id1==187 & hrbf_id2==1 & b13_033==2 & b13_034n==2;
replace b13_043m=5 if hrbf_id1==187 & hrbf_id2==1 & b13_033==2 & b13_034n==2;
replace b13_034n=2 if hrbf_id1==191 & hrbf_id2==10 & b13_033==2 & b13_034n==1 & b13c_seq==2;
replace b13_040y=2007 if hrbf_id1==191 & hrbf_id2==10 & b13_033==2 & b13_034n==2;
replace b13_034n=2 if hrbf_id1==193 & hrbf_id2==2 & b13_033==2 & b13_034n==1 & b13c_seq==2;
replace b13_040m=2 if hrbf_id1==193 & hrbf_id2==2 & b13_033==2 & b13_034n==1;
replace b13_040m=2 if hrbf_id1==193 & hrbf_id2==2 & b13_033==2 & b13_034n==2;
replace b13_040y=2009 if hrbf_id1==200 & hrbf_id2==1 & b13_033==2 & b13_034n==1;
replace b13_034n=2 if hrbf_id1==200 & hrbf_id2==6 & b13_033==2 & b13_034n==1 & b13c_seq==2;
replace b13_043y=2009 if hrbf_id1==200 & hrbf_id2==6 & b13_033==2 & b13_034n==2;
replace b13_034n=2 if hrbf_id1==205 & hrbf_id2==9 & b13_033==2 & b13_034n==1 & b13c_seq==2;
replace b13_043y=2009 if hrbf_id1==205 & hrbf_id2==9 & b13_033==2 & b13_034n==2;
replace b13_063b=2009 if hrbf_id1==205 & hrbf_id2==9 & b13_033==2 & b13_034n==2;
replace b13_063a=10 if hrbf_id1==208 & hrbf_id2==2 & b13_033==2 & b13_034n==1;
replace b13_043y=2009 if hrbf_id1==208 & hrbf_id2==2 & b13_033==2 & b13_034n==2;
replace b13_040y=2007 if hrbf_id1==211 & hrbf_id2==3 & b13_033==2 & b13_034n==2;
replace b13_034n=1 if hrbf_id1==215 & hrbf_id2==6 & b13_033==3 & b13_034n==.;
replace b13_040y=2009 if hrbf_id1==215 & hrbf_id2==6 & b13_033==3 & b13_034n==1;
replace b13_040y=2009 if hrbf_id1==215 & hrbf_id2==11 & b13_033==1 & b13_034n==1;
replace b13_043y=2010 if hrbf_id1==216 & hrbf_id2==11 & b13_033==2 & b13_034n==1;
replace b13_043y=2010 if hrbf_id1==217 & hrbf_id2==7 & b13_033==2 & b13_034n==1;
replace b13_063a=11 if hrbf_id1==222 & hrbf_id2==3 & b13_033==2 & b13_034n==1;
replace b13_043m=9 if hrbf_id1==222 & hrbf_id2==3 & b13_033==2 & b13_034n==2;
drop b13_043y_1 b13_040y_1;
gen b13_040y_1=ym(b13_040y,b13_040m);
replace b13_040y_1=dofm(b13_040y_1);
replace b13_040y_1=. if b13_040y==.;
gen b13_043y_1=ym(b13_043y,b13_043m);
replace b13_043y_1=dofm(b13_043y_1);
replace b13_043y_1=. if b13_043y==.;
assert b13_043y_1>=b13_040y_1 if b13_043y!=. & b13_043m!=. & b13_040y!=. & b13_040m!=.;

gen b13_063b_1=ym(b13_063b,b13_063a);
replace b13_063b_1=dofm(b13_063b_1);
replace b13_063b_1=. if b13_063b==.;
* assert b13_063b_1>=b13_043y_1 if b13_063b!=. & b13_063a!=. & b13_043y!=. & b13_043m!=.;
list hrbf_id1 hrbf_id2 b13_033 b13_034n b13_040m b13_040y b13_043m b13_043y b13_063a b13_063b b13c_seq if b13_063b_1<b13_043y_1 & b13_063b!=. & b13_063a!=. & b13_043y!=. & b13_043m!=.;
replace b13_063a=3 if hrbf_id1==1 & hrbf_id2==8 & b13_033==3 & b13_034n==2;
replace b13_043y=2008 if hrbf_id1==3 & hrbf_id2==3 & b13_033==2 & b13_034n==2;
replace b13_043y=2009 if hrbf_id1==4 & hrbf_id2==7 & b13_033==2 & b13_034n==1;
replace b13_043y=2009 if hrbf_id1==9 & hrbf_id2==10 & b13_033==2 & b13_034n==1;
replace b13_043y=2009 if hrbf_id1==10 & hrbf_id2==9 & b13_033==2 & b13_034n==1;
replace b13_043y=2009 if hrbf_id1==11 & hrbf_id2==2 & b13_033==2 & b13_034n==1;
replace b13_063b=2010 if hrbf_id1==14 & hrbf_id2==4 & b13_033==2 & b13_034n==1;
replace b13_043m=1 if hrbf_id1==14 & hrbf_id2==6 & b13_033==2 & b13_034n==1;
replace b13_043m=2 if hrbf_id1==21 & hrbf_id2==2 & b13_033==2 & b13_034n==1;
replace b13_063b=2010 if hrbf_id1==21 & hrbf_id2==6 & b13_033==2 & b13_034n==1;
replace b13_043y=2009 if hrbf_id1==26 & hrbf_id2==7 & b13_033==3 & b13_034n==1;
replace b13_063a=3 if hrbf_id1==26 & hrbf_id2==12 & b13_033==2 & b13_034n==2;
replace b13_063b=2010 if hrbf_id1==26 & hrbf_id2==12 & b13_033==2 & b13_034n==2;
replace b13_063b=2010 if hrbf_id1==28 & hrbf_id2==8 & b13_033==2 & b13_034n==2;
replace b13_043m=1 if hrbf_id1==29 & hrbf_id2==4 & b13_033==2 & b13_034n==2;
replace b13_063a=8 if hrbf_id1==39 & hrbf_id2==4 & b13_033==2 & b13_034n==.;
replace b13_063b=2010 if hrbf_id1==42 & hrbf_id2==12 & b13_033==2 & b13_034n==1;
replace b13_063b=2009 if hrbf_id1==44 & hrbf_id2==3 & b13_033==2 & b13_034n==1;
replace b13_034n=2 if hrbf_id1==45 & hrbf_id2==3 & b13_033==2 & b13_034n==1 & b13c_seq==2;
replace b13_043y=2008 if hrbf_id1==45 & hrbf_id2==3 & b13_033==2 & b13_034n==2;
replace b13_043m=1 if hrbf_id1==46 & hrbf_id2==6 & b13_033==2 & b13_034n==1;
replace b13_063a=2 if hrbf_id1==50 & hrbf_id2==5 & b13_033==2 & b13_034n==1;
replace b13_063b=2010 if hrbf_id1==50 & hrbf_id2==5 & b13_033==2 & b13_034n==1;
replace b13_043y=2009 if hrbf_id1==52 & hrbf_id2==9 & b13_033==2 & b13_034n==2;
replace b13_043m=3 if hrbf_id1==53 & hrbf_id2==8 & b13_033==2 & b13_034n==1;
replace b13_043y=2008 if hrbf_id1==54 & hrbf_id2==7 & b13_033==2 & b13_034n==1;
replace b13_063a=9 if hrbf_id1==56 & hrbf_id2==1 & b13_033==2 & b13_034n==2;
replace b13_043m=1 if hrbf_id1==62 & hrbf_id2==5 & b13_033==2 & b13_034n==1;
replace b13_040m=9 if hrbf_id1==62 & hrbf_id2==5 & b13_033==2 & b13_034n==1;
replace b13_043m=2 if hrbf_id1==63 & hrbf_id2==6 & b13_033==2 & b13_034n==1;
replace b13_063b=2010 if hrbf_id1==69 & hrbf_id2==10 & b13_033==2 & b13_034n==1;
replace b13_063b=2010 if hrbf_id1==81 & hrbf_id2==5 & b13_033==3 & b13_034n==1;
replace b13_043y=2009 if hrbf_id1==83 & hrbf_id2==12 & b13_033==2 & b13_034n==1;
replace b13_040y=2009 if hrbf_id1==85 & hrbf_id2==9 & b13_033==2 & b13_034n==1;
replace b13_043y=2009 if hrbf_id1==85 & hrbf_id2==9 & b13_033==2 & b13_034n==1;
replace b13_063b=2010 if hrbf_id1==89 & hrbf_id2==1 & b13_033==2 & b13_034n==1;
replace b13_063b=2010 if hrbf_id1==90 & hrbf_id2==7 & b13_033==2 & b13_034n==1;
replace b13_043m=1 if hrbf_id1==95 & hrbf_id2==9 & b13_033==2 & b13_034n==1;
replace b13_063b=2010 if hrbf_id1==97 & hrbf_id2==4 & b13_033==2 & b13_034n==1;
replace b13_043m=2 if hrbf_id1==98 & hrbf_id2==3 & b13_033==2 & b13_034n==1;
replace b13_063a=9 if hrbf_id1==98 & hrbf_id2==5 & b13_033==2 & b13_034n==2;
replace b13_034n=2 if hrbf_id1==99 & hrbf_id2==11 & b13_033==2 & b13_034n==1 & b13c_seq==2;
replace b13_043y=2007 if hrbf_id1==99 & hrbf_id2==11 & b13_033==2 & b13_034n==2;
replace b13_043y=2009 if hrbf_id1==101 & hrbf_id2==3 & b13_033==2 & b13_034n==1;
replace b13_043y=2009 if hrbf_id1==101 & hrbf_id2==9 & b13_033==2 & b13_034n==1;
replace b13_063a=12 if hrbf_id1==101 & hrbf_id2==11 & b13_033==2 & b13_034n==1;
replace b13_063b=2009 if hrbf_id1==101 & hrbf_id2==11 & b13_033==2 & b13_034n==1;
replace b13_043y=2009 if hrbf_id1==101 & hrbf_id2==12 & b13_033==2 & b13_034n==1;
replace b13_063b=2010 if hrbf_id1==105 & hrbf_id2==4 & b13_033==2 & b13_034n==1;
replace b13_040y=2007 if hrbf_id1==106 & hrbf_id2==10 & b13_033==2 & b13_034n==2;
replace b13_043y=2007 if hrbf_id1==106 & hrbf_id2==10 & b13_033==2 & b13_034n==2;
replace b13_043y=2009 if hrbf_id1==108 & hrbf_id2==1 & b13_033==2 & b13_034n==1;
replace b13_063b=2009 if hrbf_id1==110 & hrbf_id2==2 & b13_033==2 & b13_034n==1;
replace b13_043y=2009 if hrbf_id1==113 & hrbf_id2==4 & b13_033==2 & b13_034n==1;
replace b13_063b=2010 if hrbf_id1==113 & hrbf_id2==5 & b13_033==2 & b13_034n==1;
replace b13_034n=2 if hrbf_id1==113 & hrbf_id2==11 & b13_033==2 & b13_034n==1 & b13c_seq==2;
replace b13_043y=2008 if hrbf_id1==113 & hrbf_id2==11 & b13_033==2 & b13_034n==2;
replace b13_043y=2009 if hrbf_id1==114 & hrbf_id2==8 & b13_033==2 & b13_034n==1;
replace b13_043m=1 if hrbf_id1==116 & hrbf_id2==1 & b13_033==2 & b13_034n==1;
replace b13_040y=2007 if hrbf_id1==116 & hrbf_id2==9 & b13_033==2 & b13_034n==2;
replace b13_043y=2007 if hrbf_id1==116 & hrbf_id2==9 & b13_033==2 & b13_034n==2;
replace b13_043y=2007 if hrbf_id1==119 & hrbf_id2==12 & b13_033==2 & b13_034n==1;
replace b13_063b=2010 if hrbf_id1==122 & hrbf_id2==5 & b13_033==2 & b13_034n==1;
replace b13_063b=2010 if hrbf_id1==125 & hrbf_id2==2 & b13_033==2 & b13_034n==1;
replace b13_063b=2009 if hrbf_id1==126 & hrbf_id2==10 & b13_033==2 & b13_034n==1;
replace b13_040y=2009 if hrbf_id1==126 & hrbf_id2==10 & b13_033==2 & b13_034n==2;
replace b13_043y=2009 if hrbf_id1==126 & hrbf_id2==10 & b13_033==2 & b13_034n==2;
replace b13_043m=3 if hrbf_id1==132 & hrbf_id2==10 & b13_033==2 & b13_034n==1;
replace b13_043m=3 if hrbf_id1==136 & hrbf_id2==10 & b13_033==2 & b13_034n==1;
replace b13_043y=2008 if hrbf_id1==139 & hrbf_id2==12 & b13_033==2 & b13_034n==2;
replace b13_063b=2010 if hrbf_id1==141 & hrbf_id2==8 & b13_033==2 & b13_034n==1;
replace b13_043y=2009 if hrbf_id1==144 & hrbf_id2==6 & b13_033==2 & b13_034n==1;
replace b13_063b=2010 if hrbf_id1==144 & hrbf_id2==7 & b13_033==2 & b13_034n==1;
replace b13_043m=10 if hrbf_id1==151 & hrbf_id2==6 & b13_033==2 & b13_034n==1;
replace b13_043m=12 if hrbf_id1==156 & hrbf_id2==5 & b13_033==2 & b13_034n==1;
replace b13_043y=2009 if hrbf_id1==156 & hrbf_id2==5 & b13_033==2 & b13_034n==1;
replace b13_043m=3 if hrbf_id1==156 & hrbf_id2==6 & b13_033==2 & b13_034n==1;
replace b13_040y=2007 if hrbf_id1==159 & hrbf_id2==8 & b13_033==2 & b13_034n==2;
replace b13_043y=2007 if hrbf_id1==159 & hrbf_id2==8 & b13_033==2 & b13_034n==2;
replace b13_063b=2010 if hrbf_id1==164 & hrbf_id2==3 & b13_033==3 & b13_034n==1;
replace b13_043y=2009 if hrbf_id1==164 & hrbf_id2==11 & b13_033==2 & b13_034n==1;
replace b13_063b=2010 if hrbf_id1==166 & hrbf_id2==9 & b13_033==2 & b13_034n==1;
replace b13_063b=2009 if hrbf_id1==168 & hrbf_id2==2 & b13_033==2 & b13_034n==1;
replace b13_043y=2009 if hrbf_id1==168 & hrbf_id2==9 & b13_033==2 & b13_034n==1;
replace b13_043m=2 if hrbf_id1==172 & hrbf_id2==11 & b13_033==3 & b13_034n==1;
replace b13_063b=2010 if hrbf_id1==176 & hrbf_id2==9 & b13_033==2 & b13_034n==1;
replace b13_043m=1 if hrbf_id1==177 & hrbf_id2==9 & b13_033==2 & b13_034n==1;
replace b13_063b=2010 if hrbf_id1==180 & hrbf_id2==7 & b13_033==2 & b13_034n==1;
replace b13_063a=8 if hrbf_id1==181 & hrbf_id2==4 & b13_033==2 & b13_034n==2;
replace b13_063b=2010 if hrbf_id1==192 & hrbf_id2==6 & b13_033==2 & b13_034n==1;
replace b13_043m=1 if hrbf_id1==193 & hrbf_id2==11 & b13_033==2 & b13_034n==1;
replace b13_063b=2009 if hrbf_id1==196 & hrbf_id2==3 & b13_033==1 & b13_034n==1;
replace b13_034n=2 if hrbf_id1==198 & hrbf_id2==9 & b13_033==2 & b13_034n==1 & b13c_seq==2;
replace b13_043m=1 if hrbf_id1==198 & hrbf_id2==9 & b13_033==2 & b13_034n==1;
replace b13_063b=2010 if hrbf_id1==200 & hrbf_id2==4 & b13_033==2 & b13_034n==2;
replace b13_063a=1 if hrbf_id1==200 & hrbf_id2==4 & b13_033==2 & b13_034n==2;
replace b13_043y=2009 if hrbf_id1==202 & hrbf_id2==7 & b13_033==2 & b13_034n==1;
replace b13_063a=4 if hrbf_id1==203 & hrbf_id2==9 & b13_033==2 & b13_034n==1;
replace b13_043y=2009 if hrbf_id1==205 & hrbf_id2==1 & b13_033==2 & b13_034n==1;
replace b13_063a=9 if hrbf_id1==205 & hrbf_id2==6 & b13_033==2 & b13_034n==2;
replace b13_063b=2010 if hrbf_id1==205 & hrbf_id2==10 & b13_033==2 & b13_034n==1;
replace b13_043m=1 if hrbf_id1==208 & hrbf_id2==6 & b13_033==2 & b13_034n==2;
replace b13_043y=2009 if hrbf_id1==208 & hrbf_id2==7 & b13_033==2 & b13_034n==1;
replace b13_063b=2009 if hrbf_id1==208 & hrbf_id2==11 & b13_033==2 & b13_034n==1;
replace b13_040y=2009 if hrbf_id1==211 & hrbf_id2==4 & b13_033==4 & b13_034n==1;
replace b13_043y=2009 if hrbf_id1==211 & hrbf_id2==4 & b13_033==4 & b13_034n==1;
replace b13_063b=2010 if hrbf_id1==212 & hrbf_id2==1 & b13_033==2 & b13_034n==1;
replace b13_063b=2009 if hrbf_id1==212 & hrbf_id2==1 & b13_033==2 & b13_034n==2;
replace b13_063a=12 if hrbf_id1==212 & hrbf_id2==4 & b13_033==2 & b13_034n==1;
list hrbf_id1 hrbf_id2 b13_033 b13_034n b13_040m b13_040y b13_043m b13_043y b13_063a b13_063b b13c_seq if hrbf_id1==213 & hrbf_id2==3 & b13_033==2;
replace b13_063a=8 if hrbf_id1==213 & hrbf_id2==3 & b13_033==2 & b13_034n==1;
replace b13_043y=2008 if hrbf_id1==213 & hrbf_id2==3 & b13_033==2 & b13_034n==1;
replace b13_040y=2007 if hrbf_id1==213 & hrbf_id2==3 & b13_033==2 & b13_034n==1;
replace b13_040m=12 if hrbf_id1==220 & hrbf_id2==11 & b13_033==2 & b13_034n==1;
replace b13_040y=2009 if hrbf_id1==220 & hrbf_id2==11 & b13_033==2 & b13_034n==1;
replace b13_043y=2009 if hrbf_id1==220 & hrbf_id2==11 & b13_033==2 & b13_034n==1;
replace b13_043y=2009 if hrbf_id1==221 & hrbf_id2==1 & b13_033==2 & b13_034n==1;
replace b13_043m=7 if hrbf_id1==223 & hrbf_id2==7 & b13_033==2 & b13_034n==1;
drop b13_043y_1 b13_040y_1 b13_063b_1;
gen b13_040y_1=ym(b13_040y,b13_040m);
replace b13_040y_1=dofm(b13_040y_1);
replace b13_040y_1=. if b13_040y==.;
gen b13_043y_1=ym(b13_043y,b13_043m);
replace b13_043y_1=dofm(b13_043y_1);
replace b13_043y_1=. if b13_043y==.;
gen b13_063b_1=ym(b13_063b,b13_063a);
replace b13_063b_1=dofm(b13_063b_1);
replace b13_063b_1=. if b13_063b==.;
assert b13_043y_1>=b13_040y_1 if b13_043y!=. & b13_043m!=. & b13_040y!=. & b13_040m!=.;
assert b13_063b_1>=b13_043y_1 if b13_063b!=. & b13_063a!=. & b13_043y!=. & b13_043m!=.;
drop b13_063b_1 b13_043y_1 b13_040y_1;
* assert b13_040y<=b13_043y;
list hrbf_id1 hrbf_id2 b13_033 b13_034n b13_041 b13_040m b13_040y b13_043m b13_043y b13_063a b13_063b b13c_seq if b13_040y>b13_043y, compress;
replace b13_043y=2010 if hrbf_id1==19 & hrbf_id2==6 & b13_033==2 & b13_034n==1;
replace b13_040y=2010 if hrbf_id1==19 & hrbf_id2==6 & b13_033==2 & b13_034n==1;
replace b13_040y=2009  if hrbf_id1==148 & hrbf_id2==9 & b13_033==2 & b13_034n==1;
replace b13_040y=2009 if hrbf_id1==164 & hrbf_id2==1 & b13_033==2 & b13_034n==.;
replace b13_040y=2009 if hrbf_id1==164 & hrbf_id2==4 & b13_033==2 & b13_034n==. & b13c_seq==1;
replace b13_043m=4 if hrbf_id1==164 & hrbf_id2==4 & b13_033==2 & b13_034n==. & b13c_seq==1;
replace b13_040y=2008 if hrbf_id1==181 & hrbf_id2==11 & b13_033==2 & b13_034n==1;
replace b13_043y=2009 if hrbf_id1==216 & hrbf_id2==10 & b13_033==4 & b13_034n==1;
* assert b13_043y<=b13_063b;
list hrbf_id1 hrbf_id2 b13_033 b13_034n b13_041 b13_040m b13_040y b13_043m b13_043y b13_063a b13_063b b13c_seq if b13_043y>b13_063b, compress;
replace b13_063b=2009 if hrbf_id1==46 & hrbf_id2==3 & b13_033==2 & b13_034n==1;
replace b13_043m=. if hrbf_id1==156 & hrbf_id2==6 & b13_033==2 & b13_034n==1;
replace b13_063b=2009 if hrbf_id1==212 & hrbf_id2==7 & b13_033==2 & b13_034n==1;
* assert ym(b13_063b,b13_063a)-ym(b13_040y,b13_040m)<=9 if b13_063b!=. & b13_063a!=. & b13_040y!=. & b13_040m!=.;
list hrbf_id1 hrbf_id2 b13_033 b13_034n b13_041 b13_040m b13_040y b13_043m b13_043y b13_063a b13_063b b13c_seq if ym(b13_063b,b13_063a)-ym(b13_040y,b13_040m)>9 & b13_063b!=. & b13_063a!=. & b13_040y!=. & b13_040m!=., compress;
replace b13_063b=2009 if hrbf_id1==2 & hrbf_id2==7 & b13_033==2 & b13_034n==1;
replace b13_063b=2009 if hrbf_id1==3 & hrbf_id2==8 & b13_033==2 & b13_034n==1;
replace b13_040m=9 if hrbf_id1==3 & hrbf_id2==10 & b13_033==2 & b13_034n==1;
replace b13_063a=2 if hrbf_id1==7 & hrbf_id2==4 & b13_033==2 & b13_034n==2;
replace b13_040m=9 if hrbf_id1==8 & hrbf_id2==10 & b13_033==2 & b13_034n==1;
replace b13_040m=7 if hrbf_id1==10 & hrbf_id2==12 & b13_033==2 & b13_034n==1;
replace b13_063a=3 if hrbf_id1==14 & hrbf_id2==4 & b13_033==2 & b13_034n==2;
replace b13_063b=2008 if hrbf_id1==14 & hrbf_id2==4 & b13_033==2 & b13_034n==2;
replace b13_040y=2010 if hrbf_id1==15 & hrbf_id2==12 & b13_033==2 & b13_034n==1;
replace b13_040y=2010 if hrbf_id1==16 & hrbf_id2==11 & b13_033==2 & b13_034n==1 & b13c_seq==1;
replace b13_040m=6 if hrbf_id1==20 & hrbf_id2==3 & b13_033==2 & b13_034n==1;
replace b13_063b=2009 if hrbf_id1==25 & hrbf_id2==10 & b13_033==2 & b13_034n==1;
replace b13_040m=7 if hrbf_id1==26 & hrbf_id2==6 & b13_033==2 & b13_034n==1;
replace b13_063b=2008 if hrbf_id1==26 & hrbf_id2==12 & b13_033==2 & b13_034n==2 & b13c_seq==1;
replace b13_040m=9 if hrbf_id1==29 & hrbf_id2==1 & b13_033==2 & b13_034n==1;
replace b13_040m=7 if hrbf_id1==29 & hrbf_id2==10 & b13_033==2 & b13_034n==1;
replace b13_040y=2010 if hrbf_id1==31 & hrbf_id2==6 & b13_033==3 & b13_034n==1;
replace b13_040m=7 if hrbf_id1==32 & hrbf_id2==2 & b13_033==2 & b13_034n==1;
replace b13_040m=7 if hrbf_id1==32 & hrbf_id2==9 & b13_033==2 & b13_034n==1;
replace b13_040y=2009 if hrbf_id1==32 & hrbf_id2==11 & b13_033==2 & b13_034n==1;
replace b13_040m=9 if hrbf_id1==33 & hrbf_id2==6 & b13_033==2 & b13_034n==1;
replace b13_063a=1 if hrbf_id1==33 & hrbf_id2==11 & b13_033==2 & b13_034n==1;
replace b13_040m=7 if hrbf_id1==35 & hrbf_id2==10 & b13_033==2 & b13_034n==1;
replace b13_040m=7 if hrbf_id1==36 & hrbf_id2==5 & b13_033==2 & b13_034n==1;
replace b13_040y=2008 if hrbf_id1==38 & hrbf_id2==2 & b13_033==2 & b13_034n==2;
replace b13_040m=8 if hrbf_id1==38 & hrbf_id2==5 & b13_033==2 & b13_034n==1;
replace b13_043m=2 if hrbf_id1==39 & hrbf_id2==4 & b13_033==2 & b13_034n==.;
replace b13_063a=2 if hrbf_id1==39 & hrbf_id2==4 & b13_033==2 & b13_034n==.;
replace b13_063b=2007 if hrbf_id1==44 & hrbf_id2==2 & b13_033==2 & b13_034n==1;
replace b13_040m=9 if hrbf_id1==44 & hrbf_id2==5 & b13_033==1 & b13_034n==1;
replace b13_063b=2008 if hrbf_id1==45 & hrbf_id2==1 & b13_033==2 & b13_034n==1 & b13c_seq==2;
replace b13_040m=7 if hrbf_id1==46 & hrbf_id2==9 & b13_033==2 & b13_034n==1;
replace b13_040y=2009 if hrbf_id1==46 & hrbf_id2==11 & b13_033==3 & b13_034n==1;
replace b13_063b=2009 if hrbf_id1==47 & hrbf_id2==2 & b13_033==2 & b13_034n==1;
replace b13_040m=7 if hrbf_id1==48 & hrbf_id2==1 & b13_033==3 & b13_034n==1;
replace b13_040m=8 if hrbf_id1==49 & hrbf_id2==9 & b13_033==2 & b13_034n==2;
replace b13_040m=8 if hrbf_id1==50 & hrbf_id2==1 & b13_033==2 & b13_034n==1;
replace b13_063b=2009 if hrbf_id1==50 & hrbf_id2==2 & b13_033==2 & b13_034n==1;
replace b13_040y=2010 if hrbf_id1==52 & hrbf_id2==10 & b13_033==2 & b13_034n==1;
replace b13_040m=9 if hrbf_id1==59 & hrbf_id2==11 & b13_033==2 & b13_034n==2;
replace b13_040m=9 if hrbf_id1==60 & hrbf_id2==2 & b13_033==2 & b13_034n==1;
replace b13_040m=9 if hrbf_id1==60 & hrbf_id2==6 & b13_033==2 & b13_034n==1;
replace b13_040m=8 if hrbf_id1==60 & hrbf_id2==11 & b13_033==2 & b13_034n==1;
replace b13_040y=2010 if hrbf_id1==61 & hrbf_id2==12 & b13_033==2 & b13_034n==1;
replace b13_040m=7 if hrbf_id1==63 & hrbf_id2==10 & b13_033==2 & b13_034n==1;
replace b13_063b=2009 if hrbf_id1==64 & hrbf_id2==3 & b13_033==2 & b13_034n==1;
replace b13_040m=7 if hrbf_id1==71 & hrbf_id2==5 & b13_033==2 & b13_034n==1;
replace b13_040y=2010 if hrbf_id1==75 & hrbf_id2==7 & b13_033==2 & b13_034n==1;
replace b13_040m=8 if hrbf_id1==76 & hrbf_id2==1 & b13_033==2 & b13_034n==1;
replace b13_040y=2008 if hrbf_id1==76 & hrbf_id2==3 & b13_033==2 & b13_034n==2;
replace b13_040m=7 if hrbf_id1==79 & hrbf_id2==9 & b13_033==2 & b13_034n==1;
replace b13_040y=2008 if hrbf_id1==81 & hrbf_id2==1 & b13_033==2 & b13_034n==1;
replace b13_040y=2010 if hrbf_id1==81 & hrbf_id2==11 & b13_033==2 & b13_034n==1;
replace b13_040m=9 if hrbf_id1==87 & hrbf_id2==3 & b13_033==2 & b13_034n==1;
replace b13_063a=9 if hrbf_id1==87 & hrbf_id2==6 & b13_033==2 & b13_034n==1;
replace b13_063b=2009 if hrbf_id1==87 & hrbf_id2==6 & b13_033==2 & b13_034n==1;
replace b13_040m=8 if hrbf_id1==88 & hrbf_id2==10 & b13_033==2 & b13_034n==1;
replace b13_040m=8 if hrbf_id1==90 & hrbf_id2==6 & b13_033==2 & b13_034n==1;
replace b13_040m=9 if hrbf_id1==90 & hrbf_id2==12 & b13_033==2 & b13_034n==1;
replace b13_040m=9 if hrbf_id1==95 & hrbf_id2==5 & b13_033==2 & b13_034n==1;
replace b13_040m=9 if hrbf_id1==95 & hrbf_id2==7 & b13_033==2 & b13_034n==1 & b13c_seq==1;
replace b13_040m=9 if hrbf_id1==96 & hrbf_id2==9 & b13_033==2 & b13_034n==1;
replace b13_063b=2009 if hrbf_id1==97 & hrbf_id2==2 & b13_033==2 & b13_034n==1;
replace b13_040m=9 if hrbf_id1==98 & hrbf_id2==8 & b13_033==2 & b13_034n==1;
replace b13_063a=1 if hrbf_id1==103 & hrbf_id2==7 & b13_033==2 & b13_034n==1;
replace b13_040m=9 if hrbf_id1==104 & hrbf_id2==1 & b13_033==2 & b13_034n==1;
replace b13_040y=2009 if hrbf_id1==110 & hrbf_id2==2 & b13_033==2 & b13_034n==1 & b13c_seq==1;
replace b13_040m=8 if hrbf_id1==112 & hrbf_id2==10 & b13_033==2 & b13_034n==1;
replace b13_040m=7 if hrbf_id1==113 & hrbf_id2==6 & b13_033==2 & b13_034n==1;
replace b13_040y=2009 if hrbf_id1==116 & hrbf_id2==9 & b13_033==2 & b13_034n==1;
replace b13_063a=1 if hrbf_id1==116 & hrbf_id2==10 & b13_033==2 & b13_034n==1;
replace b13_063b=2009 if hrbf_id1==121 & hrbf_id2==12 & b13_033==2 & b13_034n==1;
replace b13_040y=2009 if hrbf_id1==122 & hrbf_id2==3 & b13_033==2 & b13_034n==1;
replace b13_040m=9 if hrbf_id1==125 & hrbf_id2==3 & b13_033==2 & b13_034n==1;
replace b13_040m=8 if hrbf_id1==125 & hrbf_id2==12 & b13_033==2 & b13_034n==1;
replace b13_063b=2009 if hrbf_id1==129 & hrbf_id2==7 & b13_033==2 & b13_034n==1;
replace b13_063b=2009 if hrbf_id1==130 & hrbf_id2==4 & b13_033==2 & b13_034n==1;
replace b13_063a=1 if hrbf_id1==133 & hrbf_id2==5 & b13_033==2 & b13_034n==1;
replace b13_040m=7 if hrbf_id1==135 & hrbf_id2==1 & b13_033==2 & b13_034n==1;
replace b13_040m=9 if hrbf_id1==135 & hrbf_id2==6 & b13_033==2 & b13_034n==1;
replace b13_040m=9 if hrbf_id1==138 & hrbf_id2==1 & b13_033==2 & b13_034n==1;
replace b13_040m=9 if hrbf_id1==138 & hrbf_id2==5 & b13_033==2 & b13_034n==1;
replace b13_063b=2009 if hrbf_id1==138 & hrbf_id2==6 & b13_033==2 & b13_034n==1;
replace b13_040y=2008 if hrbf_id1==139 & hrbf_id2==12 & b13_033==2 & b13_034n==2;
replace b13_040y=2010 if hrbf_id1==140 & hrbf_id2==8 & b13_033==2 & b13_034n==1;
replace b13_040m=9 if hrbf_id1==143 & hrbf_id2==12 & b13_033==2 & b13_034n==1;
replace b13_063b=2009 if hrbf_id1==149 & hrbf_id2==5 & b13_033==2 & b13_034n==1;
replace b13_063b=2009 if hrbf_id1==155 & hrbf_id2==7 & b13_033==2 & b13_034n==1;
replace b13_063b=2009 if hrbf_id1==155 & hrbf_id2==10 & b13_033==2 & b13_034n==1;
replace b13_063b=2009 if hrbf_id1==155 & hrbf_id2==11 & b13_033==2 & b13_034n==1;
replace b13_063b=2009 if hrbf_id1==156 & hrbf_id2==3 & b13_033==2 & b13_034n==1;
replace b13_063b=2008 if hrbf_id1==156 & hrbf_id2==7 & b13_033==2 & b13_034n==1;
replace b13_040y=2009 if hrbf_id1==156 & hrbf_id2==7 & b13_033==2 & b13_034n==2;
replace b13_040y=2009 if hrbf_id1==157 & hrbf_id2==7 & b13_033==2 & b13_034n==1;
replace b13_040y=2009 if hrbf_id1==159 & hrbf_id2==4 & b13_033==2 & b13_034n==2;
replace b13_063a=1 if hrbf_id1==159 & hrbf_id2==8 & b13_033==2 & b13_034n==1;
replace b13_040y=2008 if hrbf_id1==160 & hrbf_id2==9 & b13_033==2 & b13_034n==1;
replace b13_040m=7 if hrbf_id1==163 & hrbf_id2==9 & b13_033==2 & b13_034n==1;
replace b13_040y=2009 if hrbf_id1==164 & hrbf_id2==12 & b13_033==1 & b13_034n==1;
replace b13_040y=2009 if hrbf_id1==166 & hrbf_id2==5 & b13_033==2 & b13_034n==1;
replace b13_040y=2010 if hrbf_id1==166 & hrbf_id2==8 & b13_033==2 & b13_034n==1;
replace b13_040y=2008 if hrbf_id1==167 & hrbf_id2==7 & b13_033==2 & b13_034n==1;
replace b13_063b=2008 if hrbf_id1==169 & hrbf_id2==5 & b13_033==2 & b13_034n==1;
replace b13_043y=. if hrbf_id1==169 & hrbf_id2==5 & b13_033==2 & b13_034n==1;
replace b13_040y=2009 if hrbf_id1==169 & hrbf_id2==6 & b13_033==2 & b13_034n==1;
replace b13_043m=. if hrbf_id1==169 & hrbf_id2==6 & b13_033==2 & b13_034n==1;
replace b13_043y=. if hrbf_id1==169 & hrbf_id2==6 & b13_033==2 & b13_034n==1;
replace b13_040m=8 if hrbf_id1==172 & hrbf_id2==2 & b13_033==2 & b13_034n==1;
replace b13_040m=9 if hrbf_id1==172 & hrbf_id2==10 & b13_033==2 & b13_034n==1;
replace b13_040m=9 if hrbf_id1==173 & hrbf_id2==7 & b13_033==2 & b13_034n==1;
replace b13_043y=2009 if hrbf_id1==174 & hrbf_id2==1 & b13_033==2 & b13_034n==1;
replace b13_063b=2009 if hrbf_id1==174 & hrbf_id2==1 & b13_033==2 & b13_034n==1;
replace b13_040m=7 if hrbf_id1==174 & hrbf_id2==8 & b13_033==2 & b13_034n==1;
replace b13_040m=7 if hrbf_id1==176 & hrbf_id2==11 & b13_033==2 & b13_034n==1;
replace b13_040m=7 if hrbf_id1==177 & hrbf_id2==3 & b13_033==2 & b13_034n==1;
replace b13_040m=8 if hrbf_id1==177 & hrbf_id2==10 & b13_033==2 & b13_034n==1;
replace b13_040m=8 if hrbf_id1==184 & hrbf_id2==1 & b13_033==2 & b13_034n==1;
replace b13_040m=9 if hrbf_id1==188 & hrbf_id2==3 & b13_033==2 & b13_034n==1;
replace b13_063a=1 if hrbf_id1==192 & hrbf_id2==6 & b13_033==2 & b13_034n==2;
replace b13_063b=2008 if hrbf_id1==192 & hrbf_id2==6 & b13_033==2 & b13_034n==2;
replace b13_063b=2009 if hrbf_id1==193 & hrbf_id2==1 & b13_033==2 & b13_034n==1;
replace b13_040m=11 if hrbf_id1==195 & hrbf_id2==6 & b13_033==2 & b13_034n==1;
replace b13_063b=2009 if hrbf_id1==198 & hrbf_id2==11 & b13_033==2 & b13_034n==1;
replace b13_063a=3 if hrbf_id1==199 & hrbf_id2==10 & b13_033==2 & b13_034n==1;
replace b13_063a=3 if hrbf_id1==200 & hrbf_id2==4 & b13_033==2 & b13_034n==1; 
replace b13_063b=2008 if hrbf_id1==200 & hrbf_id2==4 & b13_033==2 & b13_034n==1; 
replace b13_040y=2010 if hrbf_id1==202 & hrbf_id2==8 & b13_033==2 & b13_034n==1;
replace b13_063a=2 if hrbf_id1==207 & hrbf_id2==6 & b13_033==2 & b13_034n==1;
replace b13_063b=2009 if hrbf_id1==208 & hrbf_id2==1 & b13_033==2 & b13_034n==1;
replace b13_063b=2009 if hrbf_id1==208 & hrbf_id2==12 & b13_033==2 & b13_034n==1;
replace b13_040m=9 if hrbf_id1==211 & hrbf_id2==6 & b13_033==2 & b13_034n==1;
replace b13_040m=4 if hrbf_id1==212 & hrbf_id2==4 & b13_033==2 & b13_034n==1;
replace b13_040y=2009 if hrbf_id1==212 & hrbf_id2==11 & b13_033==2 & b13_034n==1;
replace b13_063b=2008 if hrbf_id1==213 & hrbf_id2==2 & b13_033==2 & b13_034n==1  & b13c_seq==2;
replace b13_040m=11 if hrbf_id1==213 & hrbf_id2==3 & b13_033==2 & b13_034n==1 & b13c_seq==1;
replace b13_040y=2008 if hrbf_id1==213 & hrbf_id2==3 & b13_033==2 & b13_034n==1 & b13c_seq==1;
replace b13_040m=7 if hrbf_id1==215 & hrbf_id2==3 & b13_033==2 & b13_034n==1;
replace b13_040y=2008 if hrbf_id1==217 & hrbf_id2==5 & b13_033==2 & b13_034n==1 & b13c_seq==2;
replace b13_063b=2009 if hrbf_id1==217 & hrbf_id2==9 & b13_033==2 & b13_034n==1;
replace b13_063b=2008 if hrbf_id1==222 & hrbf_id2==4 & b13_033==2 & b13_034n==1;
replace b13_063a=8 if hrbf_id1==223 & hrbf_id2==7 & b13_033==2 & b13_034n==2;
gen b13_040y_1=ym(b13_040y,b13_040m);
replace b13_040y_1=dofm(b13_040y_1);
replace b13_040y_1=. if b13_040y==.;
gen b13_043y_1=ym(b13_043y,b13_043m);
replace b13_043y_1=dofm(b13_043y_1);
replace b13_043y_1=. if b13_043y==.;
gen b13_063b_1=ym(b13_063b,b13_063a);
replace b13_063b_1=dofm(b13_063b_1);
replace b13_063b_1=. if b13_063b==.;
assert b13_043y_1>=b13_040y_1 if b13_043y!=. & b13_043m!=. & b13_040y!=. & b13_040m!=.;
assert b13_063b_1>=b13_043y_1 if b13_063b!=. & b13_063a!=. & b13_043y!=. & b13_043m!=.;
drop b13_063b_1 b13_043y_1 b13_040y_1;
assert ym(b13_063b,b13_063a)-ym(b13_040y,b13_040m)<=10 if b13_063b!=. & b13_063a!=. & b13_040y!=. & b13_040m!=.;
* assert b13_043m==. & b13_043y==. if b13_041==1;
list hrbf_id1 hrbf_id2 b13_033 b13_034n b13_041 b13_040m b13_040y b13_043m b13_043y b13_063a b13_063b b13c_seq if b13_043m!=. & b13_043y!=. & b13_041==1, compress;
replace b13_040m=9 if hrbf_id1==184 & hrbf_id2==12 & b13_033==2 & b13_034n==1 & b13c_seq==1;
replace b13_040y=2009 if hrbf_id1==184 & hrbf_id2==12 & b13_033==2 & b13_034n==1 & b13c_seq==1;
replace b13_043m=. if hrbf_id1==184 & hrbf_id2==12 & b13_033==2 & b13_034n==1 & b13c_seq==1;
replace b13_043y=. if hrbf_id1==184 & hrbf_id2==12 & b13_033==2 & b13_034n==1 & b13c_seq==1;
replace b13_041=2 if hrbf_id1==191 & hrbf_id2==5 & b13_033==2 & b13_034n==1 & b13c_seq==1;
replace b13_043m=. if b13_041==1;
replace b13_043y=. if b13_041==1;


* assert b13_036==. & b13_037==. & b13_038c==. & b13_039==. & b13_040m==. & b13_040y==. & b13_040a==. & b13_040b==. & b13_041==. & b13_042==. & b13_043m==. & b13_043y==. & b13_044a==. & b13_044b==. & b13_044c==. & b13_044d==. & b13_044e==. & b13_044f==. & b13_045==. & b13_045a==. & b13_046==. if b13_035==2;
list hrbf_id1 hrbf_id2 b13c_seq b13_033 b13_034n b13_035 b13_036 b13_037 b13_038n b13_038c if (b13_036!=. | b13_037!=. | b13_038c!=. | b13_039!=. | b13_040m!=. | b13_040y!=. | b13_040a!=. | b13_040b!=. | b13_041!=. | b13_042!=. | b13_043m!=. | b13_043y!=. | b13_044a!=. | b13_044b!=. | b13_044c!=. | b13_044d!=. | b13_044e!=. | b13_044f!=. | b13_045!=. | b13_045a!=. | b13_046==.) & b13_035==2;
foreach var of varlist b13_036 b13_037 b13_038c b13_039 b13_040m b13_040y b13_040a b13_040b b13_041 b13_042 b13_043m b13_043y b13_044a b13_044b b13_044c b13_044d b13_044e b13_044f b13_045 b13_045a b13_046 {;
	replace `var'=. if b13_035==2;
};
replace b13_038n="" if b13_035==2;
* assert b13_036==. & b13_037==. & b13_038c==. & b13_039==. & b13_040m==. & b13_040y==. & b13_040a==. & b13_040b==. & b13_041==. & b13_042==. & b13_043m==. & b13_043y==. & b13_044a==. & b13_044b==. & b13_044c==. & b13_044d==. & b13_044e==. & b13_044f==. & b13_045==. & b13_045a==. & b13_046==. if b13_035==.;
list b13_035 b13_036 b13_037 b13_040m b13_040y b13_041 b13_042 b13_042 if (b13_036!=. | b13_037!=. | b13_038c!=. | b13_039!=. | b13_040m!=. | b13_040y!=. | b13_040a!=. | b13_040b!=. | b13_041!=. | b13_042!=. | b13_043m!=. | b13_043y!=. | b13_044a!=. | b13_044b!=. | b13_044c!=. | b13_044d!=. | b13_044e!=. | b13_044f!=. | b13_045!=. | b13_045a!=. | b13_046==.) & b13_035==., compress;
replace b13_035=1 if b13_035==. & b13_040y!=.;
foreach var of varlist b13_036 b13_037 b13_038c b13_039 b13_040m b13_040y b13_040a b13_040b b13_041 b13_042 b13_043m b13_043y b13_044a b13_044b b13_044c b13_044d b13_044e b13_044f b13_045 b13_045a b13_046 {;
	replace `var'=. if b13_035==.;
};

tab b13_036 b13_037;
replace b13_036=3 if b13_037==11;
tab b13_058 b13_059;
replace b13_059=11 if b13_058==3;
replace b13_058=3 if b13_059==11;
replace b13_058=6 if b13_059==9 & b13_058==1;
replace b13_058=3 if b13_058==11 & b13_059==11;
tab b13_082 b13_083;


*** Ensure youngest child is number b13_034n==1, 2nd youngest is number b13_034n==2, etc. Ensure baby not born yet is b13_034n==1;
gen b13_034n_2=.;
replace b13_034n_2=1 if b13_057==4;
* assert b13_057!=. if b13_063b!=.;
list hrbf_id1 hrbf_id2 b13_033 b13_034n b13_034n_2 b13_057 b13_040m b13_040y b13_043m b13_043y b13_063a b13_063b if b13_057==. & b13_063b!=., compress;
list hrbf_id1 hrbf_id2 b13_033 b13_034n b13_034n_2 b13_057 b13_040m b13_040y b13_043m b13_043y b13_063a b13_063b if (hrbf_id1==14 & hrbf_id2==4 & b13_033==2) | (hrbf_id1==33 & hrbf_id2==10 & b13_033==2) | (hrbf_id1==96 & hrbf_id2==12 & b13_033==2) | (hrbf_id1==119 & hrbf_id2==10 & b13_033==2) | (hrbf_id1==126 & hrbf_id2==5 & b13_033==2) | (hrbf_id1==181 & hrbf_id2==11 & b13_033==2) | (hrbf_id1==205 & hrbf_id2==6 & b13_033==2), compress;
replace b13_063a=3 if hrbf_id1==14 & hrbf_id2==4 & b13_033==2 & b13_034n==2;
replace b13_063b=2008 if hrbf_id1==14 & hrbf_id2==4 & b13_033==2 & b13_034n==2;
replace b13_057=1 if hrbf_id1==14 & hrbf_id2==4 & b13_033==2 & b13_034n==2;
replace b13_057=1 if hrbf_id1==33 & hrbf_id2==10 & b13_033==2 & b13_034n==1;
replace b13_057=1 if hrbf_id1==96 & hrbf_id2==12 & b13_033==2 & b13_034n==1;
replace b13_057=1 if hrbf_id1==96 & hrbf_id2==12 & b13_033==2 & b13_034n==2;
replace b13_057=1 if hrbf_id1==119 & hrbf_id2==10 & b13_033==2 & b13_034n==1;
replace b13_057=1 if hrbf_id1==126 & hrbf_id2==5 & b13_033==2 & b13_034n==1;
replace b13_040y=2008 if hrbf_id1==181 & hrbf_id2==11 & b13_033==2 & b13_034n==1;
replace b13_057=1 if hrbf_id1==181 & hrbf_id2==11 & b13_033==2 & b13_034n==1;
replace b13_057=1 if hrbf_id1==181 & hrbf_id2==11 & b13_033==2 & b13_034n==2;
replace b13_057=1 if hrbf_id1==205 & hrbf_id2==6 & b13_033==2 & b13_034n==1;
assert b13_063b==. if b13_057==4 | b13_057==5 | b13_057==6;
assert b13_063a==. if b13_057==4 | b13_057==5 | b13_057==6;
* assert b13_063b>=2008;
drop if b13_063b<2008;
gen b13_063a_1=b13_063a;
replace b13_063a_1=1 if b13_063a==. & b13_057<4;	
	* make sure month of birth exists to calculate date of birth if baby born. 
	* If month of birth missing, assume it's January;
gen b13_063b_1=b13_063b;
replace b13_063b_1=2000 if b13_063b==. & b13_057<4;
	* make sure year of birth exists to calculate date of birth if baby born. 
	* If year of birth was missing, assume child was the oldest;
gen b13_063date=ym(b13_063b_1, b13_063a_1);
	* not missing only for babies born. Missing (i.e. maximum value) if not born;
replace b13_063date=tm(2010-09) if b13_057==4;	
	* make sure children from still pregnant woman are youngest 
	* (replace their fake date of birth by today's date);
gen b13_040m_1=b13_040m if b13_057==5 | b13_057==6;
replace b13_040m_1=1 if b13_057==5 | b13_057==6 & b13_040m==. & b13_040y!=.;
replace b13_063date=ym(b13_040y, b13_040m_1) if (b13_057==5 | b13_057==6) & b13_040y!=.;
	* replace fake date of birth of miscarriage/abortion by date of 1st ANC visit as proxy for date of pregnancy;
* assert b13_063date!=.;
list hrbf_id1 hrbf_id2 b13_033 b13_034n b13_057 b13_041 b13_040m b13_040y b13_043m b13_043y b13_063a b13_063b b13c_seq if b13_063date==., compress;
replace b13_063a=10 if hrbf_id1==206 & hrbf_id2==9 & b13_033==3 & b13_034n==1 & b13c_seq==1;
replace b13_063b=2009 if hrbf_id1==206 & hrbf_id2==9 & b13_033==3 & b13_034n==1 & b13c_seq==1;
drop if b13_057==. & b13_041==. & b13_040m==. & b13_040y==. & b13_043m==. & b13_043y==. & b13_063a==. & b13_063b==.;
list hrbf_id1 hrbf_id2 b13_033 b13_034n b13_057 b13_041 b13_040m b13_040y b13_043m b13_043y b13_063a b13_063b b13c_seq if (hrbf_id1==109 & hrbf_id2==12 & b13_033==2) | (hrbf_id1==210 & hrbf_id2==4 & b13_033==2), compress;
replace b13_063date=tm(2000-01) if (hrbf_id1==109 & hrbf_id2==12 & b13_033==2 & b13_034n==2) | (hrbf_id1==210 & hrbf_id2==4 & b13_033==2 & b13_034n==1);
assert b13_063date!=.;
bysort hrbf_id1 hrbf_id2 b13_033: egen b13_063datemin=min(b13_063date);
gen oldest=b13_063date==b13_063datemin;
gen pnumber_oldest=.;
bysort hrbf_id1 hrbf_id2 b13_033: replace pnumber_oldest=_N if oldest==1;
bysort hrbf_id1 hrbf_id2 b13_033 b13_063date: replace pnumber_oldest=. if _n!=1;
	* in case 2 births are the same date, we don't want to have them having the same birth order number: arbitrary replace one of them by missing, so it can be filled by following command;
sort hrbf_id1 hrbf_id2 b13_033 b13_063date pnumber_oldest;
replace pnumber_oldest=pnumber_oldest[_n-1]-1 if pnumber_oldest==. & pnumber_oldest[_n-1]!=.;
assert b13_034n_2==pnumber_oldest if b13_034n_2==1;
	* make sure still pregnant corresponds to pregnancy number 1;
* assert b13_034n==pnumber_oldest;
replace b13_034n=pnumber_oldest;
drop if b13_034n>3;
drop if b13_063date-9<tm(2008-01);
drop oldest b13_034n_2 pnumber_oldest b13_040m_1 b13_063b_1 b13_063a_1 b13_063date b13_063datemin;
tab b13_034n;

duplicates report hrbf_id1 hrbf_id2 b13_033 b13_034n;
* bysort hrbf_id1 hrbf_id2 b13_033: assert _N==b13_034;
bysort hrbf_id1 hrbf_id2 b13_033: replace b13_034=_N;
tab b13_034;
bysort hrbf_id1 hrbf_id2 b13_033: replace b13_034=. if _n!=_N;
tab b13_034;

lab var b13_039 "Nr months pregnancy at 1st ANC";
lab var b13_040b "Value of gift 1st ANC-RWF";
lab var b13_042 "Nr months pregnancy at last ANC";
lab var b13_071a "Nr months breastfeeding";
lab var b13_071b "Nr months breastfeeding C2";
lab var b13_078a "Child age last birthday (not HH)";
lab var b13_078b "C2 age last birthday (not HH)";
lab var b13_083b "Value of gift 1st PNC-RWF";

save $cleandatadir/rwhrbf_b06.dta, replace;



************************************
*** Create rwhrbf_b06_with_studyarms
************************************;

ren b13_033 a1_pid;
save $tempdatadir/rwhrbf_b06.dta, replace;

merge hrbf_id1 hrbf_id2 a1_pid using $cleandatadir/rwhrbf_household_roster.dta, uniqusing;
tab _merge;
list hrbf_id1 hrbf_id2 a1_pid a1_02 if _merge==2 | _merge==1;
drop if _merge==2 | _merge==1;
drop _merge;
save $cleandatadir/rwhrbf_b06_withstudyarms.dta, replace;



*********************************************
*** Create necessary variables for mean tests
*********************************************;

gen b13_057_100=b13_057<=2;
replace b13_057_100=. if b13_057==.;
lab var b13_057_100 "Pregn result:live birth LB";

gen b13_057_101=b13_057!=4;
replace b13_057_101=. if b13_057==.;
lab var b13_057_101 "No more pregnant";

gen b13_057_102=b13_057==4;
replace b13_057_102=. if b13_057==.;
lab var b13_057_102 "Still pregnant P";

gen b13_057_103=b13_057<=3;
replace b13_057_103=. if b13_057==.;
lab var b13_057_103 "Pregn result:birth(live/stillborn)";

gen a0_in1_100=ym(a0_in1_y, a0_in1_m);
replace a0_in1_100=. if a0_in1_y==. | a0_in1_m==.;
lab var a0_in1_100 "Complete M/Y of interview";
gen b13_063b_100=ym(b13_063b,b13_063a);
replace b13_063b_100=. if b13_063b==. | b13_063a==.;
lab var b13_063b_100 "Complete M/Y of birth";
gen b13_063b_101=a0_in1_100-b13_063b_100;
lab var b13_063b_101 "Time since birth at itw in months";
gen b13_063b_102=b13_063b_101<=12;
replace b13_063b_102=. if b13_063b_101==.;
lab var b13_063b_102 "Born in past 12mths";

gen b13_035_1=b13_035==1;
replace b13_035_1=. if b13_035==.;
lab var b13_035_1 "Consulted health prof ANC";

forvalues v=1(1)10 {;
	gen b13_036_`v'=b13_036==`v';
	replace b13_036_`v'=. if b13_036==.;
};
gen b13_036_96=b13_036==96;
replace b13_036_96=. if b13_036==.;
lab var b13_036_1 "ANC:med doctor";
lab var b13_036_2 "ANC:nurse/midwife";
lab var b13_036_3 "ANC:CHW";
lab var b13_036_4 "ANC:lab technician";
lab var b13_036_5 "ANC:pharmacist";
lab var b13_036_6 "ANC:trad healer";
lab var b13_036_7 "ANC:spirit healer";
lab var b13_036_8 "ANC:trad birth attendt";
lab var b13_036_9 "ANC:fam member";
lab var b13_036_10 "ANC:friend/neighbor";
lab var b13_036_96 "ANC:other";

gen b13_036_100=b13_036<=2;
replace b13_036_100=. if b13_036==.;
lab var b13_036_100 "Skilled ANC visit";

forvalues v=1(1)12 {;
	gen b13_037_`v'=b13_037==`v';
	replace b13_037_`v'=. if b13_037==.;
};
drop b13_037_6 b13_037_8;
gen b13_037_96=b13_037==96;
replace b13_037_96=. if b13_037==.;
lab var b13_037_1 "ANC:Govt hospital";
lab var b13_037_2 "ANC:Govt health center";
lab var b13_037_3 "ANC:Govt health post";
lab var b13_037_4 "ANC:private hospital";
lab var b13_037_5 "ANC:priv health center";
lab var b13_037_7 "ANC:pharmacy";
lab var b13_037_9 "ANC:trad healer";
lab var b13_037_10 "ANC:faith/church healer";
lab var b13_037_11 "ANC:CHW";
lab var b13_037_12 "ANC:home";
lab var b13_037_96 "ANC:other";

gen b13_040a_1=b13_040a==1;
replace b13_040a_1=. if b13_040a==.;
lab var b13_040a_1 "Received gift ANC visit";

gen b13_041_1=b13_041 if b13_034n==1;
lab var b13_041_1 "Nr ANC visits last birth";

gen b13_041_2=b13_041 if b13_034n==2;
lab var b13_041_2 "Nr ANC visits 2nd-to-last birth";

gen b13_042_1=b13_042 if b13_034n==1;
lab var b13_042_1 "Mths pregn last ANC last birth";

gen b13_042_2=b13_042 if b13_034n==2;
lab var b13_042_2 "Mths pregn last ANC 2nd-to-last";

* Note: WHO guidelines are specific on the content of antenatal care visits, which should include clinical examination, blood testing to detect syphilis & severe anemia (and others such as HIV, malaria as necessary according to the epidemiological context), gestational age estimation, uterine height, blood pressure taken, maternal weight / height, detection of sexually transmitted infections (STI)s, urine test (multiple dipstick) performed, blood type and Rh requested, tetanus toxoid given, iron / Folic acid supplementation provided, recommendation for emergencies / hotline for emergencies.;

gen b13_044_1=b13_044a==1 & b13_044b==1 & b13_044c==1 & b13_044d==1 & b13_044e==1 & b13_045==1 & b13_049==1 & b13_051==1;
replace b13_044_1=. if b13_044a==. | b13_044b==. | b13_044c==. | b13_044d==. | b13_044e==. | b13_045==. | b13_049==. | b13_051==.;
lab var b13_044_1 "Minimum tests at ANC";

foreach letter in a b c d e f {;
	gen b13_044`letter'_1=b13_044`letter'==1;
	replace b13_044`letter'_1=. if b13_044`letter'==.;
};
lab var b13_044a_1 "Weighted ANC";
lab var b13_044b_1 "Height measured ANC";
lab var b13_044c_1 "Blood pressure measured ANC";
lab var b13_044d_1 "Urine sample ANC";
lab var b13_044e_1 "Blood sample ANC";
lab var b13_044f_1 "Info deliv at facility ANC";

gen b13_045_1=b13_045==1;
replace b13_045_1=. if b13_045==.;
lab var b13_045_1 "Offered counsel/test HIV";

gen b13_045a_1=b13_045a==1;
replace b13_045a_1=. if b13_045a==.;
lab var b13_045a_1 "Tested for HIV";

forvalues v=1(1)11 {;
	gen b13_047_`v'=b13_047a==`v' | b13_047b==`v' | b13_047c==`v';
	replace b13_047_`v'=. if b13_047a==. & b13_047b==. & b13_047c==.;
};
gen b13_047_96=b13_047a==96 | b13_047b==96 | b13_047c==96;
replace b13_047_96=. if b13_047a==. & b13_047b==. & b13_047c==.;
lab var b13_047_1 "No HF:expensive";
lab var b13_047_2 "No HF:far";
lab var b13_047_3 "No HF:busy";
lab var b13_047_4 "No HF:self-treated";
lab var b13_047_5 "No HF:unsanitary";
lab var b13_047_6 "No HF:poor structure";
lab var b13_047_7 "No HF:poor stock";
lab var b13_047_8 "No HF:staff attitude";
lab var b13_047_9 "No HF:staff knowledge";
lab var b13_047_10 "No HF:no trust in staff";
lab var b13_047_11 "No HF:service N/A";
lab var b13_047_96 "No HF:other";

gen b13_048_1=b13_048==1;
replace b13_048_1=. if b13_048==.;
lab var b13_048_1 "ANC unavailable at visit";

gen b13_053_1=b13_053==1;
replace b13_053_1=. if b13_053==.;
lab var b13_053_1 "Any preventive tmt malaria";

foreach letter in a b c d e {;
	gen b13_054`letter'_1=b13_054`letter'==1;
	replace b13_054`letter'_1=. if b13_054`letter'==.;
};
lab var b13_054a_1 "Took Fansidar/SP";
lab var b13_054b_1 "Took Quinine";
lab var b13_054c_1 "Took Coartem";
lab var b13_054d_1 "Took Amodiaquine";
lab var b13_054e_1 "Took other";

foreach letter in a b c d e {;
	forvalues v=1(1)5 {;
		gen b13_055`letter'_`v'=b13_055`letter'==`v';
		replace b13_055`letter'_`v'=. if b13_055`letter'==.;
	};
	gen b13_055`letter'_96=b13_055`letter'==96;
	replace b13_055`letter'_96=. if b13_055`letter'==.;
};
lab var b13_055a_1 "SP at HF";
lab var b13_055a_2 "SP at CHW";
lab var b13_055a_3 "SP at trad healer";
lab var b13_055a_4 "SP at fam member";
lab var b13_055a_5 "SP at friend/neighbor";
lab var b13_055a_96 "SP at other";
lab var b13_055b_1 "QUININE at HF";
lab var b13_055b_2 "QUININE at CHW";
lab var b13_055b_3 "QUININE at trad healer";
lab var b13_055b_4 "QUININE at fam member";
lab var b13_055b_5 "QUININE at friend/neighbor";
lab var b13_055b_96 "QUININE at other";
lab var b13_055c_1 "COARTEM at HF";
lab var b13_055c_2 "COARTEM at CHW";
lab var b13_055c_3 "COARTEM at trad healer";
lab var b13_055c_4 "COARTEM at fam member";
lab var b13_055c_5 "COARTEM at friend/neighbor";
lab var b13_055c_96 "COARTEM at other";
lab var b13_055d_1 "AMODIAQUINE at HF";
lab var b13_055d_2 "AMODIAQUINE at CHW";
lab var b13_055d_3 "AMODIAQUINE at trad healer";
lab var b13_055d_4 "AMODIAQUINE at fam member";
lab var b13_055d_5 "AMODIAQUINE at friend/neighbor";
lab var b13_055d_96 "AMODIAQUINE at other";
lab var b13_055e_1 "OTHER at HF";
lab var b13_055e_2 "OTHER at CHW";
lab var b13_055e_3 "OTHER at trad healer";
lab var b13_055e_4 "OTHER at fam member";
lab var b13_055e_5 "OTHER at friend/neighbor";
lab var b13_055e_96 "OTHER at other";

forvalues v=1(1)6 {;
	gen b13_057_`v'=b13_057==`v';
	replace b13_057_`v'=. if b13_057==.;
};
lab var b13_057_1 "Result:Live single birth";
lab var b13_057_2 "Result:Live multiple";
lab var b13_057_3 "Result:stillbirth";
lab var b13_057_4 "Still pregnant";
lab var b13_057_5 "Result:miscarriage";
lab var b13_057_6 "Result:abortion";

forvalues v=1(1)11 {;
	gen b13_058_`v'=b13_058==`v';
	replace b13_058_`v'=. if b13_058==.;
};
gen b13_058_96=b13_058==96;
replace b13_058_96=. if b13_058==.;
lab var b13_058_1 "Delivery:med doctor";
lab var b13_058_2 "Deliv:nurse/midwife";
lab var b13_058_3 "Delivery:CHW";
lab var b13_058_4 "Deliv:lab technician";
lab var b13_058_5 "Delivery:pharmacist";
lab var b13_058_6 "Delivery:trad healer";
lab var b13_058_7 "Deliv:spirit healer";
lab var b13_058_8 "Deliv:trad birth attendt";
lab var b13_058_9 "Delivery:fam member";
lab var b13_058_10 "Deliv:friend/neighbor";
lab var b13_058_11 "Delivery:no one";
lab var b13_058_96 "Delivery:other";

forvalues v=1(1)12 {;
	gen b13_059_`v'=b13_059==`v';
	replace b13_059_`v'=. if b13_059==.;
};
drop b13_059_6 b13_059_8;
gen b13_059_96=b13_059==96;
replace b13_059_96=. if b13_059==.;
lab var b13_059_1 "Deliv:Govt hospital";
lab var b13_059_2 "Deliv:Govt health center";
lab var b13_059_3 "Deliv:Govt health post";
lab var b13_059_4 "Deliv:private hospital";
lab var b13_059_5 "Deliv:priv health center";
lab var b13_059_7 "Deliv:pharmacy";
lab var b13_059_9 "Deliv:trad healer";
lab var b13_059_10 "Deliv:faith/church healer";
lab var b13_059_11 "Deliv:CHW";
lab var b13_059_12 "Deliv:home";
lab var b13_059_96 "Deliv:other";

forvalues v=1(1)11 {;
	gen b13_061all_`v'=b13_061_1==`v' | b13_061_2==`v' | b13_061_3==`v';
	replace b13_061all_`v'=. if b13_061_1==. & b13_061_2==. & b13_061_3==.;
};
gen b13_061all_96=b13_061_1==96 | b13_061_2==96 | b13_061_3==96;
replace b13_061all_96=. if b13_061_1==. & b13_061_2==. & b13_061_3==.;
lab var b13_061all_1 "No HF:expensive";
lab var b13_061all_2 "No HF:far";
lab var b13_061all_3 "No HF:busy";
lab var b13_061all_4 "No HF:self-treated";
lab var b13_061all_5 "No HF:unsanitary";
lab var b13_061all_6 "No HF:poor structure";
lab var b13_061all_7 "No HF:poor stock";
lab var b13_061all_8 "No HF:staff attitude";
lab var b13_061all_9 "No HF:staff knowledge";
lab var b13_061all_10 "No HF:no trust in staff";
lab var b13_061all_11 "No HF:service N/A";
lab var b13_061all_96 "No HF:other";

gen b13_061a_1=b13_061a==1;
replace b13_061a_1=. if b13_061a==.;
lab var b13_061a_1 "Received gift delivery";

foreach letter in a b c {;
	gen b13_064`letter'_1=b13_064`letter'==1;
	replace b13_064`letter'_1=. if b13_064`letter'==.;
};
lab var b13_064a_1 "Male birth";
lab var b13_064b_1 "Male birth, C2";
lab var b13_064c_1 "Male birth, C3";

foreach letter in a b c {;
	gen b13_065`letter'_1=b13_065`letter'==1;
	replace b13_065`letter'_1=. if b13_065`letter'==.;
};
lab var b13_065a_1 "Weighted at birth";
lab var b13_065b_1 "Weighted at birth C2";
lab var b13_065c_1 "Weighted at birth C3";

foreach letter in a b c {;
	gen b13_066`letter'_2=b13_066`letter'==2;
	replace b13_066`letter'_2=. if b13_066`letter'==.;
};
lab var b13_066a_2 "Weight:no recall,health card";
lab var b13_066b_2 "Weight:no recall,health card C2";
lab var b13_066c_2 "Weight:no recall,health card C3";

foreach letter in a b c {;
	forvalues v=1(1)5 {;
		gen b13_068`letter'_`v'=b13_068`letter'==`v';
		replace b13_068`letter'_`v'=. if b13_068`letter'==.;
	};
};
lab var b13_068a_1 "Child very large";
lab var b13_068a_2 "Child larger";
lab var b13_068a_3 "Child average";
lab var b13_068a_4 "Child smaller";
lab var b13_068a_5 "Child very small";
lab var b13_068b_1 "C2 very large";
lab var b13_068b_2 "C2 larger";
lab var b13_068b_3 "C2 average";
lab var b13_068b_4 "C2 smaller";
lab var b13_068b_5 "C2 very small";
lab var b13_068c_1 "C3 very large";
lab var b13_068c_2 "C3 larger";
lab var b13_068c_3 "C3 average";
lab var b13_068c_4 "C3 smaller";
lab var b13_068c_5 "C3 very small";

foreach letter in a b c {;
	gen b13_069`letter'_1=b13_069`letter'==1;
	replace b13_069`letter'_1=. if b13_069`letter'==.;
};
lab var b13_069a_1 "Child breastfed";
lab var b13_069b_1 "C2 breastfed";
lab var b13_069c_1 "C3 breastfed";

foreach letter in a b c {;
	forvalues v=1(1)4 {;
		gen b13_070`letter'_`v'=b13_070`letter'==`v';
		replace b13_070`letter'_`v'=. if b13_070`letter'==.;
	};
};
lab var b13_070a_1 "Breastfed 1st hr";
lab var b13_070a_2 "Breastfed 1st day";
lab var b13_070a_3 "Breastfed 1st week";
lab var b13_070a_4 "Breastfed 1st month";
lab var b13_070b_1 "Breastfed 1st hr C2";
lab var b13_070b_2 "Breastfed 1st day C2";
lab var b13_070b_3 "Breastfed 1st week C2";
lab var b13_070b_4 "Breastfed 1st month C2";
lab var b13_070c_1 "Breastfed 1st hr C3";
lab var b13_070c_2 "Breastfed 1st day C3";
lab var b13_070c_3 "Breastfed 1st week C3";
lab var b13_070c_4 "Breastfed 1st month C3";

foreach letter in a b c {;
	gen b13_072`letter'_1=b13_072`letter'==1;
	replace b13_072`letter'_1=. if b13_072`letter'==.;
};
lab var b13_072a_1 "Drank besides milk 1st 3d";
lab var b13_072b_1 "Drank besides milk 1st 3d C2";
lab var b13_072c_1 "Drank besides milk 1st 3d C3";

foreach letter in a b c {;
	gen b13_073`letter'_1=(b13_073`letter'1!=10 & b13_073`letter'1!=.) | (b13_073`letter'2!=10 & b13_073`letter'2!=.) | (b13_073`letter'3!=10 & b13_073`letter'3!=.);
	replace b13_073`letter'_1=. if b13_073`letter'1==. & b13_073`letter'2==. & b13_073`letter'3==.;
};
lab var b13_073a_1 "Drank besides milk 1st 4m";
lab var b13_073b_1 "Drank besides milk 1st 4m C2";
lab var b13_073c_1 "Drank besides milk 1st 4m C3";

foreach letter in a b c {;
	gen b13_074`letter'_1=b13_074`letter'==1;
	replace b13_074`letter'_1=. if b13_074`letter'==.;
};
lab var b13_074a_1 "Child still alive";
lab var b13_074b_1 "C2 still alive";
lab var b13_074c_1 "C3 still alive";

foreach letter in a b c {;
	gen b13_075`letter'n_1=b13_075`letter'n;
	replace b13_075`letter'n_1=b13_075`letter'n/30.5 if b13_075`letter'u==1;
	replace b13_075`letter'n_1=b13_075`letter'n/4 if b13_075`letter'u==2;
	replace b13_075`letter'n_1=b13_075`letter'n*12 if b13_075`letter'u==4;
	replace b13_075`letter'n_1=. if b13_075`letter'n==. | b13_075`letter'u==.;
};
lab var b13_075an_1 "Age at death in mths";
lab var b13_075bn_1 "Age at death in mths C2";
lab var b13_075cn_1 "Age at death in mths C3";

foreach letter in a b c {;
	gen b13_076`letter'_1=b13_076`letter'==1;
	replace b13_076`letter'_1=. if b13_076`letter'==.;
};
lab var b13_076a_1 "Still lives w/mother";
lab var b13_076b_1 "Still lives w/mother C2";
lab var b13_076c_1 "Still lives w/mother C3";

gen b13_080_1=b13_080==1;
replace b13_080_1=. if b13_080==.;
lab var b13_080_1 "Mother went to PNC";

gen b13_081a_1=b13_081a;
replace b13_081a_1=b13_081a/24 if b13_081b==1;
replace b13_081a_1=b13_081a*7 if b13_081b==3;
replace b13_081a_1=b13_081a*30.5 if b13_081b==4;
replace b13_081a_1=. if b13_081a==. | b13_081b==.;
lab var b13_081a_1 "Delay birth-PNC in days";

forvalues v=1(1)10 {;
	gen b13_082_`v'=b13_082==`v';
	replace b13_082_`v'=. if b13_082==.;
};
gen b13_082_96=b13_082==96;
replace b13_082_96=. if b13_082==.;
lab var b13_082_1 "PNC:med doctor";
lab var b13_082_2 "PNC:nurse/midwife";
lab var b13_082_3 "PNC:CHW";
lab var b13_082_4 "PNC:lab technician";
lab var b13_082_5 "PNC:pharmacist";
lab var b13_082_6 "PNC:trad healer";
lab var b13_082_7 "PNC:spirit healer";
lab var b13_082_8 "PNC:trad birth attendt";
lab var b13_082_9 "PNC:fam member";
lab var b13_082_10 "PNC:friend/neighbor";
lab var b13_082_96 "PNC:other";

gen b13_082_100=b13_082<=2;
replace b13_082_100=. if b13_082==.;
lab var b13_082_100 "Skilled PNC visit";

forvalues v=1(1)12 {;
	gen b13_083_`v'=b13_083==`v';
	replace b13_083_`v'=. if b13_083==.;
};
drop b13_083_6 b13_083_8;
gen b13_083_96=b13_083==96;
replace b13_083_96=. if b13_083==.;
lab var b13_083_1 "PNC:Govt hospital";
lab var b13_083_2 "PNC:Govt clinic";
lab var b13_083_3 "PNC:Govt health post";
lab var b13_083_4 "PNC:private hospital";
lab var b13_083_5 "PNC:private clinic";
lab var b13_083_7 "PNC:pharmacy";
lab var b13_083_9 "PNC:trad healer";
lab var b13_083_10 "PNC:faith/church healer";
lab var b13_083_11 "PNC:CHW";
lab var b13_083_12 "PNC:home";
lab var b13_083_96 "PNC:other";

gen b13_083a_1=b13_083a==1;
replace b13_083a_1=. if b13_083a==.;
lab var b13_083a_1 "Received gift PNC";

forvalues v=1(1)11 {;
	gen b13_087_`v'=b13_087a==`v' | b13_087b==`v' | b13_087c==`v';
	replace b13_087_`v'=. if b13_087a==. & b13_087b==. & b13_087c==.;
};
gen b13_087_96=b13_087a==96 | b13_087b==96 | b13_087c==96;
replace b13_087_96=. if b13_087a==. & b13_087b==. & b13_087c==.;
lab var b13_087_1 "No HF:expensive";
lab var b13_087_2 "No HF:far";
lab var b13_087_3 "No HF:busy";
lab var b13_087_4 "No HF:self-treated";
lab var b13_087_5 "No HF:unsanitary";
lab var b13_087_6 "No HF:poor structure";
lab var b13_087_7 "No HF:poor stock";
lab var b13_087_8 "No HF:staff attitude";
lab var b13_087_9 "No HF:staff knowledge";
lab var b13_087_10 "No HF:no trust in staff";
lab var b13_087_11 "No HF:service N/A";
lab var b13_087_96 "No HF:other";

gen b13_088_1=b13_088==1;
replace b13_088_1=. if b13_088==.;
lab var b13_088_1 "Got iron suppl after birth";

gen b13_089n_1=b13_089n;
replace b13_089n_1=b13_089n/24 if b13_089u==1;
replace b13_089n_1=b13_089n*7 if b13_089u==3;
replace b13_089n_1=b13_089n*30.5 if b13_089u==4;
replace b13_089n_1=. if b13_089n==. | b13_089u==.;
lab var b13_089n_1 "Delay birth-iron dose in days";

forvalues v=1(1)10 {;
	gen b13_090_`v'=b13_090==`v';
	replace b13_090_`v'=. if b13_090==.;
};
gen b13_090_96=b13_090==96;
replace b13_090_96=. if b13_090==.;
lab var b13_090_1 "Iron:med doctor";
lab var b13_090_2 "Iron:nurse/midwife";
lab var b13_090_3 "Iron:CHW";
lab var b13_090_4 "Iron:lab technician";
lab var b13_090_5 "Iron:pharmacist";
lab var b13_090_6 "Iron:trad healer";
lab var b13_090_7 "Iron:spirit healer";
lab var b13_090_8 "Iron:trad birth attendt";
lab var b13_090_9 "Iron:fam member";
lab var b13_090_10 "Iron:friend/neighbor";
lab var b13_090_96 "Iron:other";

gen b13_092_1=b13_092==1;
replace b13_092_1=. if b13_092==.;
lab var b13_092_1 "Got vitA suppl after birth";

gen b13_093n_1=b13_093n;
replace b13_093n_1=b13_093n/732 if b13_093u==1;
replace b13_093n_1=b13_093n/30.5 if b13_093u==2;
replace b13_093n_1=b13_093n/4 if b13_093u==3;
replace b13_093n_1=. if b13_093n==. | b13_093u==.;
lab var b13_093n_1 "Delay birth-vitA dose in mths";

forvalues v=1(1)10 {;
	gen b13_094_`v'=b13_094==`v';
	replace b13_094_`v'=. if b13_094==.;
};
gen b13_094_96=b13_094==96;
replace b13_094_96=. if b13_094==.;
lab var b13_094_1 "VitA:med doctor";
lab var b13_094_2 "VitA:nurse/midwife";
lab var b13_094_3 "VitA:CHW";
lab var b13_094_4 "VitA:lab technician";
lab var b13_094_5 "VitA:pharmacist";
lab var b13_094_6 "VitA:trad healer";
lab var b13_094_7 "VitA:spirit healer";
lab var b13_094_8 "VitA:trad birth attendt";
lab var b13_094_9 "VitA:fam member";
lab var b13_094_10 "VitA:friend/neighbor";
lab var b13_094_96 "VitA:other";








***
*** Indicators
***;


*** ANC:

* Note: ANC indicators are defined either for all pregnancies (resulting in live birth, stillbirth, miscarriage or abortion), or, as WHO guidelines state, for live births only, or for still pregnant women only;

gen b13_035_2=.;
replace b13_035_2=1 if b13_035==1 & b13_036<=2 & b13_034n==1;
replace b13_035_2=0 if (b13_035==2 | (b13_035==1 & b13_036>2 & b13_036!=.)) & b13_034n==1;
lab var b13_035_2 "ANC coverage: 1+ visit";


gen b13_035_3=.;
replace b13_035_3=1 if b13_035==1 & b13_036<=2 & b13_034n==1 & b13_057_100==1;
replace b13_035_3=0 if (b13_035==2 | (b13_035==1 & b13_036>2 & b13_036!=.)) & b13_034n==1 & b13_057_100==1;
lab var b13_035_3 "ANC coverage: 1+ visit LB";
* WHO indicator;

gen b13_035_4=.;
replace b13_035_4=1 if b13_035==1 & b13_036<=2 & b13_034n==1 & b13_057_102==1;
replace b13_035_4=0 if (b13_035==2 | (b13_035==1 & b13_036>2 & b13_036!=.)) & b13_034n==1 & b13_057_102==1;
lab var b13_035_4 "ANC coverage: 1+ visit P";

gen b13_035_5=.;
replace b13_035_5=1 if b13_035==1 & b13_036<=2 & b13_034n==2;
replace b13_035_5=0 if (b13_035==2 | (b13_035==1 & b13_036>2 & b13_036!=.)) & b13_034n==2;
lab var b13_035_5 "ANC coverage: 1+ visit 2nd";

gen b13_035_6=.;
replace b13_035_6=1 if b13_035==1 & b13_036<=2 & b13_034n==2 & b13_057_100==1;
replace b13_035_6=0 if (b13_035==2 | (b13_035==1 & b13_036>2 & b13_036!=.)) & b13_034n==2 & b13_057_100==1;
lab var b13_035_6 "ANC coverage: 1+ visit LB 2nd";
* WHO indicator;

gen b13_035_7=.;
replace b13_035_7=1 if b13_035==1 & b13_036<=2 & b13_034n==2 & b13_057_102==1;
replace b13_035_7=0 if (b13_035==2 | (b13_035==1 & b13_036>2 & b13_036!=.)) & b13_034n==2 & b13_057_102==1;
lab var b13_035_7 "ANC coverage: 1+ visit P 2nd";
* No obs: not included in analysis;

gen b13_037_100=.;
replace b13_037_100=1 if b13_037<=5 & b13_034n==1;
replace b13_037_100=0 if b13_037>5 & b13_037!=. & b13_034n==1;
lab var b13_037_100 "ANC in formal HF";

gen b13_037_101=.;
replace b13_037_101=1 if b13_037<=5 & b13_034n==1 & b13_057_100==1;
replace b13_037_101=0 if b13_037>5 & b13_037!=. & b13_034n==1 & b13_057_100==1;
lab var b13_037_101 "ANC in formal HF LB";

gen b13_037_102=.;
replace b13_037_102=1 if b13_037<=5 & b13_034n==1 & b13_057_102==1;
replace b13_037_102=0 if b13_037>5 & b13_037!=. & b13_034n==1 & b13_057_102==1;
lab var b13_037_102 "ANC in formal HF P";

gen b13_037_103=.;
replace b13_037_103=1 if b13_037<=5 & b13_034n==2;
replace b13_037_103=0 if b13_037>5 & b13_037!=. & b13_034n==2;
lab var b13_037_103 "ANC in formal HF 2nd";

gen b13_037_104=.;
replace b13_037_104=1 if b13_037<=5 & b13_034n==2 & b13_057_100==1;
replace b13_037_104=0 if b13_037>5 & b13_037!=. & b13_034n==2 & b13_057_100==1;
lab var b13_037_104 "ANC in formal HF LB 2nd";

gen b13_037_105=.;
replace b13_037_105=1 if b13_037<=5 & b13_034n==2 & b13_057_102==1;
replace b13_037_105=0 if b13_037>5 & b13_037!=. & b13_034n==2 & b13_057_102==1;
lab var b13_037_105 "ANC in formal HF P 2nd";
* No obs: not included in analysis;

gen b13_046_2=.;
replace b13_046_2=1 if b13_046==1 & b13_034n==1;
replace b13_046_2=0 if b13_046==2 & b13_034n==1;
lab var b13_046_2 "Confirm:ANC in formal HF";

gen b13_046_3=.;
replace b13_046_3=1 if b13_046==1 & b13_034n==1 & b13_057_100==1;
replace b13_046_3=0 if b13_046==2 & b13_034n==1 & b13_057_100==1;
lab var b13_046_3 "Confirm:ANC in formal HF LB";

gen b13_046_4=.;
replace b13_046_4=1 if b13_046==1 & b13_034n==1 & b13_057_102==1;
replace b13_046_4=0 if b13_046==2 & b13_034n==1 & b13_057_102==1;
lab var b13_046_4 "Confirm:ANC in formal HF P";

gen b13_046_5=.;
replace b13_046_5=1 if b13_046==1 & b13_034n==2;
replace b13_046_5=0 if b13_046==2 & b13_034n==2;
lab var b13_046_5 "Confirm:ANC in formal HF 2nd";

gen b13_046_6=.;
replace b13_046_6=1 if b13_046==1 & b13_034n==2 & b13_057_100==1;
replace b13_046_6=0 if b13_046==2 & b13_034n==2 & b13_057_100==1;
lab var b13_046_6 "Confirm:ANC in formal HF LB 2nd";

gen b13_046_7=.;
replace b13_046_7=1 if b13_046==1 & b13_034n==2 & b13_057_102==1;
replace b13_046_7=0 if b13_046==2 & b13_034n==2 & b13_057_102==1;
lab var b13_046_7 "Confirm:ANC in formal HF P 2nd";
* No obs: not included in analysis;

gen b13_039_1=.;
replace b13_039_1=1 if b13_039<=4 & b13_034n==1;
replace b13_039_1=0 if b13_039>4 & b13_039!=. & b13_034n==1;
lab var b13_039_1 "Timely ANC (<=4m)";

gen b13_039_2=.;
replace b13_039_2=1 if b13_039<=4 & b13_034n==1  & b13_057_100==1;
replace b13_039_2=0 if b13_039>4 & b13_039!=. & b13_034n==1  & b13_057_100==1;
lab var b13_039_2 "Timely ANC (<=4m) LB";

gen b13_039_3=.;
replace b13_039_3=1 if b13_039<=4 & b13_034n==1  & b13_057_102==1;
replace b13_039_3=0 if b13_039>4 & b13_039!=. & b13_034n==1  & b13_057_102==1;
lab var b13_039_3 "Timely ANC (<=4m) P";

gen b13_039_4=.;
replace b13_039_4=1 if b13_039<=4 & b13_034n==2;
replace b13_039_4=0 if b13_039>4 & b13_039!=. & b13_034n==2;
lab var b13_039_4 "Timely ANC (<=4m) 2nd";

gen b13_039_5=.;
replace b13_039_5=1 if b13_039<=4 & b13_034n==2 & b13_057_100==1;
replace b13_039_5=0 if b13_039>4 & b13_039!=. & b13_034n==2 & b13_057_100==1;
lab var b13_039_5 "Timely ANC (<=4m) LB 2nd";

gen b13_039_6=.;
replace b13_039_6=1 if b13_039<=4 & b13_034n==2 & b13_057_102==1;
replace b13_039_6=0 if b13_039>4 & b13_039!=. & b13_034n==2 & b13_057_102==1;
lab var b13_039_6 "Timely ANC (<=4m) P 2nd";
* No obs: not included in analysis;

gen b13_041_100=.;
replace b13_041_100=1 if b13_041>=4 & b13_041!=. & b13_034n==1;
replace b13_041_100=0 if b13_041<4 & b13_034n==1;
lab var b13_041_100 "ANC coverage: 4+ visits";

gen b13_041_101=.;
replace b13_041_101=1 if b13_041>=4 & b13_041!=. & b13_034n==1 & b13_057_100==1;
replace b13_041_101=0 if b13_041<4 & b13_034n==1 & b13_057_100==1;
lab var b13_041_101 "ANC coverage: 4+ visits LB";
* WHO indicator;

gen b13_041_102=.;
replace b13_041_102=1 if b13_041>=4 & b13_041!=. & b13_034n==1 & b13_057_102==1;
replace b13_041_102=0 if b13_041<4 & b13_034n==1 & b13_057_102==1;
lab var b13_041_102 "ANC coverage: 4+ visits P";

gen b13_041_103=.;
replace b13_041_103=1 if b13_041>=4 & b13_041!=. & b13_034n==2;
replace b13_041_103=0 if b13_041<4 & b13_034n==2;
lab var b13_041_103 "ANC coverage: 4+ visits 2nd";

gen b13_041_104=.;
replace b13_041_104=1 if b13_041>=4 & b13_041!=. & b13_034n==2 & b13_057_100==1;
replace b13_041_104=0 if b13_041<4 & b13_034n==2 & b13_057_100==1;
lab var b13_041_104 "ANC coverage: 4+ visits LB 2nd";
* WHO indicator;

gen b13_041_105=.;
replace b13_041_105=1 if b13_041>=4 & b13_041!=. & b13_034n==2 & b13_057_102==1;
replace b13_041_105=0 if b13_041<4 & b13_034n==2 & b13_057_102==1;
lab var b13_041_105 "ANC coverage: 4+ visits P 2nd";
* No obs: not included in analysis;

gen b13_049_1=.;
replace b13_049_1=1 if b13_049==1 & b13_050>=2 & b13_050!=. & b13_063b_102==1  & b13_034n==1;
replace b13_049_1=0 if (b13_049==2 | (b13_049==1 & b13_050<2)) & b13_063b_102==1  & b13_034n==1;
lab var b13_049_1 "TT2 coverage during pregnancy";

gen b13_049_2=.;
replace b13_049_2=1 if b13_049==1 & b13_050>=2 & b13_050!=. & b13_063b_102==1  & b13_034n==1  & b13_057_100==1;
replace b13_049_2=0 if (b13_049==2 | (b13_049==1 & b13_050<2)) & b13_063b_102==1  & b13_034n==1  & b13_057_100==1;
lab var b13_049_2 "TT2 coverage in pregnancy LB";
* JHU report indicator (Johns Hopkins University);

gen b13_049_3=.;
replace b13_049_3=1 if b13_049==1 & b13_050>=2 & b13_050!=. & b13_063b_102==1  & b13_034n==1  & b13_057_102==1;
replace b13_049_3=0 if (b13_049==2 | (b13_049==1 & b13_050<2)) & b13_063b_102==1  & b13_034n==1  & b13_057_102==1;
lab var b13_049_3 "TT2 coverage in pregnancy P";
* No obs: not included in analysis;

gen b13_049_4=.;
replace b13_049_4=1 if b13_049==1 & b13_050>=2 & b13_050!=. & b13_063b_102==1  & b13_034n==2;
replace b13_049_4=0 if (b13_049==2 | (b13_049==1 & b13_050<2)) & b13_063b_102==1  & b13_034n==2;
lab var b13_049_4 "TT2 coverage in pregnancy 2nd";

gen b13_049_5=.;
replace b13_049_5=1 if b13_049==1 & b13_050>=2 & b13_050!=. & b13_063b_102==1  & b13_034n==2 & b13_057_100==1;
replace b13_049_5=0 if (b13_049==2 | (b13_049==1 & b13_050<2)) & b13_063b_102==1  & b13_034n==2 & b13_057_100==1;
lab var b13_049_5 "TT2 coverage in pregn LB 2nd";
* JHU report indicator;

gen b13_049_6=.;
replace b13_049_6=1 if b13_049==1 & b13_050>=2 & b13_050!=. & b13_063b_102==1  & b13_034n==2 & b13_057_102==1;
replace b13_049_6=0 if (b13_049==2 | (b13_049==1 & b13_050<2)) & b13_063b_102==1  & b13_034n==2 & b13_057_102==1;
lab var b13_049_6 "TT2 coverage in pregn P 2nd";
* No osb: not included in analysis;

gen b13_051_1=.;
replace b13_051_1=1 if b13_051==1 & b13_052>=90 & b13_052!=. & b13_034n==1 & b13_063b_102==1;
replace b13_051_1=0 if (b13_051==2 | (b13_051==1 & b13_052<90)) & b13_034n==1 & b13_063b_102==1;
lab var b13_051_1 "90d Iron suppl pregnancy";

gen b13_051_2=.;
replace b13_051_2=1 if b13_051==1 & b13_052>=90 & b13_052!=. & b13_034n==1 & b13_063b_102==1 & b13_057_100==1;
replace b13_051_2=0 if (b13_051==2 | (b13_051==1 & b13_052<90)) & b13_034n==1 & b13_063b_102==1 & b13_057_100==1;
lab var b13_051_2 "90d Iron suppl pregnancy LB";
* JHU report indicator;

gen b13_051_3=.;
replace b13_051_3=1 if b13_051==1 & b13_052>=90 & b13_052!=. & b13_034n==1 & b13_063b_102==1 & b13_057_102==1;
replace b13_051_3=0 if (b13_051==2 | (b13_051==1 & b13_052<90)) & b13_034n==1 & b13_063b_102==1 & b13_057_102==1;
lab var b13_051_3 "90d Iron suppl pregnancy P";
* No obs: not included in analysis;

gen b13_051_4=.;
replace b13_051_4=1 if b13_051==1 & b13_052>=90 & b13_052!=. & b13_034n==2 & b13_063b_102==1;
replace b13_051_4=0 if (b13_051==2 | (b13_051==1 & b13_052<90)) & b13_034n==2 & b13_063b_102==1;
lab var b13_051_4 "90d Iron suppl pregnancy 2nd";
* all zeros: not included in analysis (dropped by Stata when do mean);

gen b13_051_5=.;
replace b13_051_5=1 if b13_051==1 & b13_052>=90 & b13_052!=. & b13_034n==2 & b13_063b_102==1 & b13_057_100==1;
replace b13_051_5=0 if (b13_051==2 | (b13_051==1 & b13_052<90)) & b13_034n==2 & b13_063b_102==1 & b13_057_100==1;
lab var b13_051_5 "90d Iron suppl pregnancy LB 2nd";
* JHU report indicator;
* all zeros: not included in analysis (dropped by Stata when do mean);

gen b13_051_6=.;
replace b13_051_6=1 if b13_051==1 & b13_052>=90 & b13_052!=. & b13_034n==2 & b13_063b_102==1 & b13_057_102==1;
replace b13_051_6=0 if (b13_051==2 | (b13_051==1 & b13_052<90)) & b13_034n==2 & b13_063b_102==1 & b13_057_102==1;
lab var b13_051_6 "90d Iron suppl pregnancy P 2nd";
* No obs: not included in analysis;

gen b13_053_2=.;
replace b13_053_2=1 if b13_053==1 & b13_054a==1 & b13_034n==1 & b13_057_103==1 & b13_063b_102==1;
replace b13_053_2=0 if (b13_053==2 | (b13_053==1 & b13_054a==2)) & b13_034n==1 & b13_057_103==1 & b13_063b_102==1;
lab var b13_053_2 "SP preventive tmt malaria";
* JHU report indicator;

gen b13_053_3=.;
replace b13_053_3=1 if b13_053==1 & b13_054a==1 & b13_034n==1 & b13_057_102==1;
replace b13_053_3=0 if (b13_053==2 | (b13_053==1 & b13_054a==2)) & b13_034n==1 & b13_057_102==1;
lab var b13_053_3 "SP preventive tmt malaria P";

gen b13_053_4=.;
replace b13_053_4=1 if b13_053==1 & b13_054a==1 & b13_034n==2 & b13_057_103==1 & b13_063b_102==1;
replace b13_053_4=0 if (b13_053==2 | (b13_053==1 & b13_054a==2)) & b13_034n==2 & b13_057_103==1 & b13_063b_102==1;
lab var b13_053_4 "SP preventive tmt malaria 2nd";
* JHU report indicator;
* all zeros: not included in analysis (dropped by Stata when do mean);

gen b13_053_5=.;
replace b13_053_5=1 if b13_053==1 & b13_054a==1 & b13_034n==2 & b13_057_102==1;
replace b13_053_5=0 if (b13_053==2 | (b13_053==1 & b13_054a==2)) & b13_034n==2 & b13_057_102==1;
lab var b13_053_5 "SP preventive tmt malaria P 2nd";
* No obs: not included in analysis;


*** Delivery;

gen b13_058_100=.;
replace b13_058_100=1 if b13_058<=2 & b13_034n==1 & b13_063b_102==1;
replace b13_058_100=0 if b13_058>2 & b13_058!=. & b13_034n==1 & b13_063b_102==1;
lab var b13_058_100 "Skilled delivery";
* WHO indicator;

gen b13_058_101=.;
replace b13_058_101=1 if b13_058<=2 & b13_034n==2 & b13_063b_102==1;
replace b13_058_101=0 if b13_058>2 & b13_058!=. & b13_034n==2 & b13_063b_102==1;
lab var b13_058_101 "Skilled delivery 2nd";
* WHO indicator;

gen b13_059_100=.;
replace b13_059_100=1 if b13_059<=5 & b13_034n==1 & b13_063b_102==1;
replace b13_059_100=0 if b13_059>5 & b13_059!=. & b13_034n==1 & b13_063b_102==1;
lab var b13_059_100 "Deliv in formal HF";

gen b13_059_101=.;
replace b13_059_101=1 if b13_059<=5 & b13_034n==2 & b13_063b_102==1;
replace b13_059_101=0 if b13_059>5 & b13_059!=. & b13_034n==2 & b13_063b_102==1;
lab var b13_059_101 "Deliv in formal HF 2nd";

gen b13_062_1=.;
replace b13_062_1=1 if b13_062==1 & b13_034n==1 & b13_057_100==1;
replace b13_062_1=0 if b13_062==2 & b13_034n==1 & b13_057_100==1;
lab var b13_062_1 "C-section rate";
* JHU report indicator (more simple than WHO);

gen b13_062_2=.;
replace b13_062_2=1 if b13_062==1 & b13_034n==2 & b13_057_100==1;
replace b13_062_2=0 if b13_062==2 & b13_034n==2 & b13_057_100==1;
lab var b13_062_2 "C-section rate 2nd";
* JHU report indicator (more simple than WHO);


*** Low-birth-weight newborns;

gen b13_067a_1=.;
replace b13_067a_1=1 if b13_067a<2500 & b13_034n==1 & b13_057_100==1;
replace b13_067a_1=0 if b13_067a>=2500 & b13_067a!=. & b13_034n==1 & b13_057_100==1;
lab var b13_067a_1 "Low-birth-weight newborns";
* WHO indicator;

gen b13_067b_1=.;
replace b13_067b_1=1 if b13_067a<2500 & b13_034n==2 & b13_057_100==1;
replace b13_067b_1=0 if b13_067a>=2500 & b13_067a!=. & b13_034n==2 & b13_057_100==1;
lab var b13_067b_1 "Low-birth-weight newborns 2nd";
* WHO indicator;


*** Breastfeeding;

foreach letter in a b c {;
	gen b13_069`letter'_100=.;
	replace b13_069`letter'_100=1 if b13_069`letter'==1 & b13_070`letter'==1 & b13_034n==1 & b13_063b_102==1;
	replace b13_069`letter'_100=0 if (b13_069`letter'==2 | (b13_069`letter'==1 & b13_070`letter'!=1)) & b13_034n==1 & b13_063b_102==1;
};
lab var b13_069a_100 "Timely initiation breastfeeding";
lab var b13_069b_100 "Timely init breastfeeding C2";
lab var b13_069c_100 "Timely init breastfeeding C3";

gen b13_071a_100=.;
replace b13_071a_100=1 if b13_069a==1 & b13_071a_98==1 & b13_079a==2 & b13_079b==2 & b13_079c==2 & b13_079d==2 & b13_079e==2 & b13_079f==2 & b13_079g==2 & b13_079h==2 & b13_079i==2 & b13_034n==1 & b13_063b_101<6 & b13_076a==1 & b13_074a==1;
replace b13_071a_100=0 if (b13_069a==2 | (b13_069a==1 & b13_071a_98==0) | (b13_069a==1 & b13_071a_98==1 & (b13_079a==1 | b13_079b==1 | b13_079c==1 | b13_079d==1 | b13_079e==1 | b13_079f==1 | b13_079g==1 | b13_079h==1 | b13_079i==1))) & b13_034n==1 & b13_063b_101<6 & b13_076a==1 & b13_074a==1;
lab var b13_071a_100 "Exclusive breastfeeding 0-6m";
* WHO indicator;

gen b13_071a_101=.;
replace b13_071a_101=1 if b13_069a==1 & b13_071a_98==1 & (b13_079a==1 | b13_079b==1 | b13_079c==1 | b13_079d==1 | b13_079e==1 | b13_079f==1 | b13_079g==1 | b13_079h==1 | b13_079i==1) & b13_034n==1 & (b13_063b_101>=6 & b13_063b_101<10) & b13_076a==1 & b13_074a==1;
replace b13_071a_101=0 if (b13_069a==2 | (b13_069a==1 & b13_071a_98==0) | (b13_069a==1 & b13_071a_98==1 & (b13_079a==2 & b13_079b==2 & b13_079c==2 & b13_079d==2 & b13_079e==2 & b13_079f==2 & b13_079g==2 & b13_079h==2 & b13_079i==2))) & b13_034n==1 & (b13_063b_101>=6 & b13_063b_101<10) & b13_076a==1 & b13_074a==1;
lab var b13_071a_101 "Breastfed & compl fed 6-9m";
* JHU report indicator;

gen b13_071a_102=.;
replace b13_071a_102=1 if b13_069a==1 & b13_071a_98==1 &  b13_034n==1 & (b13_063b_101>=20 & b13_063b_101<24) & b13_076a==1 & b13_074a==1;
replace b13_071a_102=0 if (b13_069a==2 | (b13_069a==1 & b13_071a_98==0)) &  b13_034n==1 & (b13_063b_101>=20 & b13_063b_101<24) & b13_076a==1 & b13_074a==1;
lab var b13_071a_102 "Breastfed continued 20-23m";
* JHU report indicator;
* No obs (pregnancies since 2008 only: no child 20-23m): not included in analysis;


*** PNC;

gen b13_080_100=.;
replace b13_080_100=1 if b13_080==1 & b13_081a_1<=2 & b13_034n==1 & b13_057_100==1;
replace b13_080_100=0 if (b13_080==2 | (b13_080==1 & b13_081a_1>2 & b13_081a_1!=.)) & b13_034n==1 & b13_057_100==1;
lab var b13_080_100 "Timely PNC for mothers";
* JHU report indicator;

gen b13_080_101=.;
replace b13_080_101=1 if b13_080==1 & b13_081a_1<=2 & b13_034n==2 & b13_057_100==1;
replace b13_080_101=0 if (b13_080==2 | (b13_080==1 & b13_081a_1>2 & b13_081a_1!=.)) & b13_034n==2 & b13_057_100==1;
lab var b13_080_101 "Timely PNC for mothers 2nd";
* JHU report indicator;

gen b13_080_102=.;
replace b13_080_102=1 if b13_080==1 & b13_081a_1<=2 & b13_059>5 & b13_059!=. & b13_034n==1;
replace b13_080_102=0 if (b13_080==2 | (b13_080==1 & b13_081a_1>2 & b13_081a!=.)) & b13_059>5 & b13_059!=. & b13_034n==1;
lab var b13_080_102 "Timely PNC babies born at home";
* JHU report indicator;

gen b13_083_100=.;
replace b13_083_100=1 if b13_080==1 & b13_081a_1<=2 & b13_083<=5 & b13_034n==1;
replace b13_083_100=0 if (b13_080==2 | (b13_080==1 & b13_081a_1>2 & b13_081a!=.) | (b13_080==1 & b13_083>5 & b13_083!=.)) & b13_034n==1;
lab var b13_083_100 "Timely PNC in formal HF";

gen b13_086_1=.;
replace b13_086=1 if b13_086==1 & b13_081a_1<=2 & b13_034n==1;
replace b13_086_1=0 if (b13_086==2 | (b13_086==1 & b13_081a_1>2 & b13_081a!=.)) & b13_034n==1;
lab var b13_086_1 "Confirm:Timely PNC in formal HF";
* all zeros: not included in analysis (dropped by Stata when do mean);

gen b13_092_100=.;
replace b13_092_100=1 if b13_092==1 & b13_093n_1<=2 & b13_057_100==1 & b13_063b_102==1 & b13_034n==1;
replace b13_092_100=0 if (b13_092==2 | (b13_092==1 & b13_093n_1>2 & b13_093n_1!=.)) & b13_057_100==1 & b13_063b_102==1 & b13_034n==1;
lab var b13_092_100 "Postnatal suppl w/vitA";
* JHU report indicator;

svyset [pweight=hhpweight], psu(hrbf_id1);
save $cleandatadir/rwhrbf_b06_withstudyarms_withvarformeantests.dta, replace;
log close;