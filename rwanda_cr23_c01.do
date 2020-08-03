* Elisa Rothenbuhler - Nov 10

* This do-file:
* Creates clean child c01 dataset: $cleandatadir/rwhrbf_c01.dta.
* Merges $cleandatadir/rwhrbf_c01.dta with household roster.
* Generates appropriate variables for mean tests.


version 10.0
clear
set more off
set mem 500m
cap log close

#delimit ;

log using $logdir/rwanda_cr23_c01.log, replace;



*********************
*** Clean c01 section
*********************;

use $origdatadir/RWHRBF_C_CHILD-01.dta, clear;

drop if c14_seq==. & c14_pid==. & c14_01==. & c14_05==. & c14_06a==. & c14_06b==. & c14_06c==. & c14_07a==. & c14_07u==. & c14_08a==. & c14_08u==. & c14_09==. & c14_10==. & c14_11==. & c14_12==. & c14_12a==. & c14_25a==. & c14_25b==. & c14_25c==. & c14_25d==. & c14_25e==. & c14_31a1==. & c14_31a2==. & c14_31a3==. & c14_31b1==. & c14_31b2==. & c14_31b3==. & c14_31c1==. & c14_31c2==. & c14_31c3==. & c14_31d1==. & c14_31d2==. & c14_31d3==. & c14_31e1==. & c14_31e2==. & c14_31e3==. & c14_32a==. & c14_32b==. & c14_32c==. & c14_32d==. & c14_32e==. & c14_32f==. & c14_32g==. & c14_32h==. & c14_32i==. & c14_32j==. & c14_32k==. & c14_34a==. & c14_34b==. & c14_34c==. & c14_34d==. & c14_34e==. & c14_34f==. & c14_34g==. & c14_34h==. & c14_34i==. & c14_34j==. & c14_35==. & c14_39==. & c14_40==.;

duplicates tag hrbf_id1 hrbf_id2 c14_01 c14_seq,gen(dupl1);
duplicates tag hrbf_id1 hrbf_id2 c14_pid,gen(dupl2);
list hrbf_id1 hrbf_id2 c14_01 c14_seq c14_pid dupl1 dupl2 if dupl1!=0 | dupl2!=0;
list  hrbf_id1 hrbf_id2 c14_01 c14_seq c14_pid dupl1 dupl2 if hrbf_id1==182 & hrbf_id2==6;
replace c14_seq=1 if hrbf_id1==182 & hrbf_id2==6 & c14_pid==4;
replace c14_seq=2 if hrbf_id1==182 & hrbf_id2==6 & c14_pid==5;
list  hrbf_id1 hrbf_id2 c14_01 c14_seq c14_pid dupl1 dupl2 if hrbf_id1==203 & hrbf_id2==5;
replace c14_seq=1 if hrbf_id1==203 & hrbf_id2==5 & c14_pid==4;
replace c14_seq=2 if hrbf_id1==203 & hrbf_id2==5 & c14_pid==5;
drop dupl1;
* br if (hrbf_id1==35 & hrbf_id2==3 & c14_01==1) | (hrbf_id1==35 & hrbf_id2==12 & c14_01==2) | (hrbf_id1==35 & hrbf_id2==1 & c14_01==2) | (hrbf_id1==35 & hrbf_id2==11 & c14_01==1) | (hrbf_id1==35 & hrbf_id2==11 & c14_01==2) | (hrbf_id1==35 & hrbf_id2==8 & c14_01==2) | (hrbf_id1==96 & hrbf_id2==7) | (hrbf_id1==97 & hrbf_id2==6) | (hrbf_id1==97 & hrbf_id2==9) | (hrbf_id1==167 & hrbf_id2==8 & c14_01==5) | (hrbf_id1==167 & hrbf_id2==8 & c14_01==4) | (hrbf_id1==171 & hrbf_id2==1) | (hrbf_id1==174 & hrbf_id2==9 & c14_01==2) | (hrbf_id1==174 & hrbf_id2==5) | (hrbf_id1==191 & hrbf_id2==3);
drop if c14_05==. & c14_06a==. & c14_06b==. & c14_06c==. & c14_07a==. & c14_07u==. & c14_08a==. & c14_08u==. & c14_09==. & c14_10==. & c14_11==. & c14_12==. & c14_12a==. & c14_25a==. & c14_25b==. & c14_25c==. & c14_25d==. & c14_25e==. & c14_31a1==. & c14_31a2==. & c14_31a3==. & c14_31b1==. & c14_31b2==. & c14_31b3==. & c14_31c1==. & c14_31c2==. & c14_31c3==. & c14_31d1==. & c14_31d2==. & c14_31d3==. & c14_31e1==. & c14_31e2==. & c14_31e3==. & c14_32a==. & c14_32b==. & c14_32c==. & c14_32d==. & c14_32e==. & c14_32f==. & c14_32g==. & c14_32h==. & c14_32i==. & c14_32j==. & c14_32k==. & c14_34a==. & c14_34b==. & c14_34c==. & c14_34d==. & c14_34e==. & c14_34f==. & c14_34g==. & c14_34h==. & c14_34i==. & c14_34j==. & c14_35==. & c14_39==. & c14_40==.;
drop dupl2;
duplicates tag hrbf_id1 hrbf_id2 c14_pid,gen(dupl2);
sort hrbf_id1 hrbf_id2 c14_01 c14_seq;
list hrbf_id1 hrbf_id2 c14_01 c14_seq c14_pid dupl2 if dupl2!=0;

* use $cleandatadir/rwhrbf_household_roster.dta, clear;
* list hrbf_id1 hrbf_id2 a1_pid a1_11a a1_11b a1_15 if (hrbf_id1==35 & hrbf_id2==3) | (hrbf_id1==167 & hrbf_id2==8) | (hrbf_id1==174 & hrbf_id2==9);
replace c14_pid=2 if hrbf_id1==35 & hrbf_id2==3 & c14_01==1 & c14_seq==1;
replace c14_pid=5 if hrbf_id1==167 & hrbf_id2==8 & c14_01==5 & c14_seq==1;
replace c14_pid=4 if hrbf_id1==167 & hrbf_id2==8 & c14_01==4 & c14_seq==2;
replace c14_01=2 if hrbf_id1==167 & hrbf_id2==8 & c14_01==5 & c14_pid==5 & c14_seq==1;
replace c14_01=2 if hrbf_id1==167 & hrbf_id2==8 & c14_01==4 & c14_pid==4 & c14_seq==2;
drop if hrbf_id1==174 & hrbf_id2==9 & c14_01==2 & c14_seq==.;
drop dupl2;
duplicates report hrbf_id1 hrbf_id2 c14_01 c14_seq;
duplicates report hrbf_id1 hrbf_id2 c14_pid;

* bysort hrbf_id1 hrbf_id2 c14_01: assert c14_01!= c14_pid if c14_01!=. & c14_pid!=.;
list hrbf_id1 hrbf_id2 c14_01 c14_seq c14_pid if c14_01==c14_pid & c14_01!=. & c14_pid!=.;
* use $cleandatadir/rwhrbf_household_roster.dta, clear;
* list hrbf_id1 hrbf_id2 a1_pid a1_11a a1_11b a1_15 if (hrbf_id1==35 & hrbf_id2==4) | (hrbf_id1==58 & hrbf_id2==12) | (hrbf_id1==170 & hrbf_id2==1) | (hrbf_id1==172 & hrbf_id2==6);

replace c14_pid=4 if hrbf_id1==35 & hrbf_id2==4 & c14_01==2 & c14_pid==2 & c14_seq==1;
replace c14_01=. if hrbf_id1==58 & hrbf_id2==12 & c14_01==5 & c14_pid==5 & c14_seq==2;
replace c14_01=. if hrbf_id1==58 & hrbf_id2==12 & c14_01==6 & c14_pid==6 & c14_seq==1;
replace c14_pid=4 if hrbf_id1==170 & hrbf_id2==1 & c14_01==2 & c14_pid==2 & c14_seq==1;
replace c14_01=1 if hrbf_id1==172 & hrbf_id2==6 & c14_01==2 & c14_pid==2 & c14_seq==1;

tab1 c14_05 c14_06a c14_06b c14_06c c14_07a c14_07u c14_08a c14_08u c14_09 c14_10 c14_11 c14_12 c14_12a c14_25a c14_25b c14_25c c14_25d c14_25e c14_31a1 c14_31a2 c14_31a3 c14_31b1 c14_31b2 c14_31b3 c14_31c1 c14_31c2 c14_31c3 c14_31d1 c14_31d2 c14_31d3 c14_31e1 c14_31e2 c14_31e3 c14_32a c14_32b c14_32c c14_32d c14_32e c14_32f c14_32g c14_32h c14_32i c14_32j c14_32k c14_34a c14_34b c14_34c c14_34d c14_34e c14_34f c14_34g c14_34h c14_34i c14_34j c14_35 c14_39 c14_40,nolab;
replace c14_06b=. if c14_06b==0;
replace c14_06c=. if c14_06c==0;
replace c14_07a=.a if c14_07a==96;
replace c14_08a=.a if c14_08a==96;
replace c14_08a=.b if c14_08a==99;
replace c14_08u=. if c14_08u==0 | c14_08u==4;
replace c14_12=2 if c14_12==3;
replace c14_25a=.b if c14_25a==99;
forvalues v=1(1)3 {;
	replace c14_31a`v'=99 if c14_31a`v'==0;
	replace c14_31b`v'=99 if c14_31b`v'==0;
	replace c14_31c`v'=99 if c14_31c`v'==0;
	replace c14_31d`v'=99 if c14_31d`v'==0;
	replace c14_31e`v'=99 if c14_31e`v'==0;
};
foreach var of varlist c14_32a c14_32b c14_32c c14_32d c14_32e c14_32f c14_32g c14_32h c14_32i c14_32j c14_32k {;
	replace `var'=. if `var'==0;
};
foreach var of varlist c14_34a c14_34b c14_34c c14_34d c14_34e c14_34f c14_34g c14_34h c14_34i c14_34j {;
	replace `var'=.z if `var'==9999;
};
replace c14_35=9999 if c14_35==99999;
replace c14_35=.z if c14_35==9999;
replace c14_39=28 if c14_39==30;

* assert c14_06a==. & c14_06b==. & c14_06c==. & c14_07a==. & c14_07u==. & c14_08a==. & c14_08u==. & c14_09==. & c14_10==. & c14_11==. & c14_12==. & c14_12a==. & c14_25a==. & c14_25b==. & c14_25c==. & c14_25d==. & c14_25e==. & c14_31a1==. & c14_31a2==. & c14_31a3==. & c14_31b1==. & c14_31b2==. & c14_31b3==. & c14_31c1==. & c14_31c2==. & c14_31c3==. & c14_31d1==. & c14_31d2==. & c14_31d3==. & c14_31e1==. & c14_31e2==. & c14_31e3==. & c14_32a==. & c14_32b==. & c14_32c==. & c14_32d==. & c14_32e==. & c14_32f==. & c14_32g==. & c14_32h==. & c14_32i==. & c14_32j==. & c14_32k==. & c14_34a==. & c14_34b==. & c14_34c==. & c14_34d==. & c14_34e==. & c14_34f==. & c14_34g==. & c14_34h==. & c14_34i==. & c14_34j==. & c14_35==. & c14_39==. & c14_40==. if c14_05==2;
* br if (c14_06a!=. | c14_06b!=. | c14_06c!=. | c14_07a!=. | c14_07u!=. | c14_08a!=. | c14_08u!=. | c14_09!=. | c14_10!=. | c14_11!=. | c14_12!=. | c14_12a!=. | c14_25a!=. | c14_25b!=. | c14_25c!=. | c14_25d!=. | c14_25e!=. | c14_31a1!=. | c14_31a2!=. | c14_31a3!=. | c14_31b1!=. | c14_31b2!=. | c14_31b3!=. | c14_31c1!=. | c14_31c2!=. | c14_31c3!=. | c14_31d1!=. | c14_31d2!=. | c14_31d3!=. | c14_31e1!=. | c14_31e2!=. | c14_31e3!=. | c14_32a!=. | c14_32b!=. | c14_32c!=. | c14_32d!=. | c14_32e!=. | c14_32f!=. | c14_32g!=. | c14_32h!=. | c14_32i!=. | c14_32j!=. | c14_32k!=. | c14_34a!=. | c14_34b!=. | c14_34c!=. | c14_34d!=. | c14_34e!=. | c14_34f!=. | c14_34g!=. | c14_34h!=. | c14_34i!=. | c14_34j!=. | c14_35!=. | c14_39!=. | c14_40!=.) & c14_05==2;
foreach var of varlist c14_06a c14_06b c14_06c c14_07a c14_07u c14_08a c14_08u c14_09 c14_10 c14_11 c14_12 c14_12a c14_25a c14_25b c14_25c c14_25d c14_25e c14_31a1 c14_31a2 c14_31a3 c14_31b1 c14_31b2 c14_31b3 c14_31c1 c14_31c2 c14_31c3 c14_31d1 c14_31d2 c14_31d3 c14_31e1 c14_31e2 c14_31e3 c14_32a c14_32b c14_32c c14_32d c14_32e c14_32f c14_32g c14_32h c14_32i c14_32j c14_32k c14_34a c14_34b c14_34c c14_34d c14_34e c14_34f c14_34g c14_34h c14_34i c14_34j c14_35 c14_39 c14_40 {;
	replace `var'=. if c14_05==2;
};

gen c14_07a_1=c14_07a;
replace c14_07a_1=c14_07a*7 if c14_07u==2;
replace c14_07a_1=c14_07a*30.5 if c14_07u==3;
lab var c14_07a_1 "Illness started X days ago";
gen c14_08a_1=c14_08a;
replace c14_08a_1=c14_08a*7 if c14_08u==2;
replace c14_08a_1=0 if c14_08u==3;
lab var c14_08a_1 "Illness ended X days ago";
* assert c14_08a_1<=c14_07a_1 if c14_08a!=. & c14_08u!=. & c14_07a!=. & c14_07u!=.;
list c14_07a c14_07u c14_07a_1 c14_08a c14_08u c14_08a_1 if c14_08a_1>c14_07a_1 & c14_08a!=. & c14_08u!=. & c14_07a!=. & c14_07u!=.;
replace c14_08a=c14_07a if c14_08a_1>c14_07a_1 & c14_08a!=. & c14_08u!=. & c14_07a!=. & c14_07u!=.;
replace c14_08u=c14_07u if c14_08a_1>c14_07a_1 & c14_08a!=. & c14_08u!=. & c14_07a!=. & c14_07u!=.;
* assert c14_08a==0 | c14_08a==. if c14_08u==3;
sort hrbf_id1 hrbf_id2 c14_pid;
list c14_07a c14_07u c14_07a_1 c14_08a c14_08u c14_08a_1 c14_40 if (c14_08a!=0 | c14_08a!=.) & c14_08u==3;
list c14_07a c14_07u c14_08a c14_08u c14_40 if c14_40!=3 & c14_08u==3;
list c14_07a c14_07u c14_08a c14_08u c14_40 if c14_40==3 & c14_08u!=3;
replace c14_08u=1 if c14_40==1 & c14_08u==3 & _n==312;
replace c14_08a=4 if c14_40==1 & c14_08u==3 & _n==323;
replace c14_08u=2 if c14_40==1 & c14_08u==3 & _n==323;
replace c14_40=3 if c14_40==2 & c14_08u==3 & _n==1211;
replace c14_08a=. if c14_40==1 & c14_08u==3 & _n==1227;
replace c14_08u=. if c14_40==1 & c14_08u==3 & _n==1227;
replace c14_08u=2 if c14_40==1 & c14_08u==3 & _n==1250;
replace c14_40=3 if c14_40==. & c14_08u==3 & _n==1364;
replace c14_08u=2 if c14_40==1 & c14_08u==3 & _n==1460;
replace c14_08u=1 if c14_40==1 & c14_08u==3 & _n==1625;
replace c14_08a=4 if c14_40==1 & c14_08u==3 & _n==1920;
replace c14_08u=2 if c14_40==1 & c14_08u==3 & _n==1920;
replace c14_08a=4 if c14_40==1 & c14_08u==3 & _n==2162;
replace c14_08u=2 if c14_40==1 & c14_08u==3 & _n==2162;
replace c14_08u=1 if c14_40==1 & c14_08u==3 & _n==2822;
replace c14_08u=2 if c14_40==1 & c14_08u==3 & _n==2913;
replace c14_08a=4 if c14_40==1 & c14_08u==3 & _n==2952;
replace c14_08u=2 if c14_40==1 & c14_08u==3 & _n==2952;
replace c14_40=3 if c14_40==. & c14_08u==3 & _n==2984;
replace c14_08a=4 if c14_40==1 & c14_08u==3 & _n==2995;
replace c14_08u=2 if c14_40==1 & c14_08u==3 & _n==2995;
replace c14_08a=4 if c14_40==1 & c14_08u==3 & _n==3000;
replace c14_08u=2 if c14_40==1 & c14_08u==3 & _n==3000;
replace c14_08u=1 if c14_40==1 & c14_08u==3 & _n==3366;
replace c14_40=3 if c14_40==2 & c14_08u==3 & _n==3436;
replace c14_08a=4 if c14_40==1 & c14_08u==3 & _n==3529;
replace c14_08u=2 if c14_40==1 & c14_08u==3 & _n==3529;
replace c14_08a=4 if c14_40==1 & c14_08u==3 & _n==3530;
replace c14_08u=2 if c14_40==1 & c14_08u==3 & _n==3530;
replace c14_40=3 if c14_40==2 & c14_08u==3 & _n==3577;
replace c14_08u=1 if c14_40==1 & c14_08u==3 & _n==3700;
list c14_07a c14_07u c14_07a_1 c14_08a c14_08u c14_08a_1 c14_40 if (c14_08a!=0 | c14_08a!=.) & c14_08u==3;
replace c14_08a=0 if (c14_08a!=0 | c14_08a!=.) & c14_08u==3;
list c14_07a c14_07u c14_08a c14_08u c14_40 if c14_40!=3 & c14_08u==3;
list c14_07a c14_07u c14_08a c14_08u c14_40 if c14_40==3 & c14_08u!=3;
replace c14_08u=3 if (c14_08u==. | c14_08a==. | c14_08a==0) & c14_40==3;
list c14_07a c14_07u c14_08a c14_08u c14_40 if c14_40==3 & c14_08u!=3;
replace c14_40=2 if c14_40==3 & c14_08u!=3;
replace c14_08a=. if c14_08u==3;
drop c14_08a_1 c14_07a_1;

* assert c14_09==1 if c14_06a==7 | c14_06a==8 | c14_06a==9 | c14_06b==7 | c14_06b==8 | c14_06b==9 | c14_06c==7 | c14_06c==8 | c14_06c==9;
replace c14_09=1 if c14_06a==7 | c14_06a==8 | c14_06a==9 | c14_06b==7 | c14_06b==8 | c14_06b==9 | c14_06c==7 | c14_06c==8 | c14_06c==9;
* assert c14_09==2 if c14_06a!=7 & c14_06a!=8 & c14_06a!=9 & c14_06b!=7 & c14_06b!=8 & c14_06b!=9 & c14_06c!=7 & c14_06c!=8 & c14_06c==9;
replace c14_09=2 if c14_06a!=7 & c14_06a!=8 & c14_06a!=9 & c14_06b!=7 & c14_06b!=8 & c14_06b!=9 & c14_06c!=7 & c14_06c!=8 & c14_06c==9 & c14_06a<. & c14_06b<. & c14_06c<.;

* assert c14_12a==. if c14_12==2;
list c14_06a c14_06b c14_06c c14_09 c14_12 c14_12a if c14_12a!=. & c14_12==2;
replace c14_12=1 if c14_09==1 & c14_12a!=.;
replace c14_12a=. if c14_12==2;
* assert c14_31a1==. & c14_31a2==. & c14_31a3==. if c14_06a!=1 & c14_06b!=1 & c14_06c!=1;
list c14_06a c14_06b c14_06c c14_31a1 c14_31a2 c14_31a3 c14_31b1 c14_31b2 c14_31b3 c14_31c1 c14_31c2 c14_31c3 c14_31d1 c14_31d2 c14_31d3 c14_31e1 c14_31e2 c14_31e3 if (c14_31a1!=. | c14_31a2!=. | c14_31a3!=.) & (c14_06a!=1 & c14_06b!=1 & c14_06c!=1), compress nolab;
forvalues v=1(1)3 {;
	replace c14_31a`v'=. if c14_06a!=1 & c14_06b!=1 & c14_06c!=1;
};
* assert c14_31b1==. & c14_31b2==. & c14_31b3==. if c14_06a!=7 & c14_06a!=8 & c14_06a!=9 & c14_06b!=7 & c14_06b!=8 & c14_06b!=9 & c14_06c!=7 & c14_06c!=8 & c14_06c!=9;
forvalues v=1(1)3 {;
	replace c14_31b`v'=. if c14_06a!=7 & c14_06a!=8 & c14_06a!=9 & c14_06b!=7 & c14_06b!=8 & c14_06b!=9 & c14_06c!=7 & c14_06c!=8 & c14_06c!=9;
};
* assert c14_31c1==. & c14_31c2==. & c14_31c3==. if c14_06a!=6 & c14_06b!=6 & c14_06c!=6;
forvalues v=1(1)3 {;
	replace c14_31c`v'=. if c14_06a!=6 & c14_06b!=6 & c14_06c!=6;
};
* assert c14_31d1==. & c14_31d2==. & c14_31d3==. if c14_06a!=9 & c14_06a!=10 & c14_06b!=9 & c14_06b!=10 & c14_06c!=9 & c14_06c!=10;
forvalues v=1(1)3 {;
	replace c14_31d`v'=. if c14_06a!=9 & c14_06a!=10 & c14_06b!=9 & c14_06b!=10 & c14_06c!=9 & c14_06c!=10;
};
* assert c14_31e1==. & c14_31e2==. & c14_31e3==. if c14_06a!=2 & c14_06a!=3 & c14_06a!=4 & c14_06a!=5 & c14_06a!=11 & c14_06a!=12 & c14_06a!=13 & c14_06a!=14 & c14_06a!=15 & c14_06a!=16 & c14_06a!=17 & c14_06a!=18 & c14_06a!=19 & c14_06a!=96 & c14_06b!=2 & c14_06b!=3 & c14_06b!=4 & c14_06b!=5 & c14_06b!=11 & c14_06b!=12 & c14_06b!=13 & c14_06b!=14 & c14_06b!=15 & c14_06b!=16 & c14_06b!=17 & c14_06b!=18 & c14_06b!=19 & c14_06b!=96 & c14_06c!=2 & c14_06c!=3 & c14_06c!=4 & c14_06c!=5 & c14_06c!=11 & c14_06c!=12 & c14_06c!=13 & c14_06c!=14 & c14_06c!=15 & c14_06c!=16 & c14_06c!=17 & c14_06c!=18 & c14_06c!=19 & c14_06c!=96; 
forvalues v=1(1)3 {;
	replace c14_31e`v'=. if c14_06a!=2 & c14_06a!=3 & c14_06a!=4 & c14_06a!=5 & c14_06a!=11 & c14_06a!=12 & c14_06a!=13 & c14_06a!=14 & c14_06a!=15 & c14_06a!=16 & c14_06a!=17 & c14_06a!=18 & c14_06a!=19 & c14_06a!=96 & c14_06b!=2 & c14_06b!=3 & c14_06b!=4 & c14_06b!=5 & c14_06b!=11 & c14_06b!=12 & c14_06b!=13 & c14_06b!=14 & c14_06b!=15 & c14_06b!=16 & c14_06b!=17 & c14_06b!=18 & c14_06b!=19 & c14_06b!=96 & c14_06c!=2 & c14_06c!=3 & c14_06c!=4 & c14_06c!=5 & c14_06c!=11 & c14_06c!=12 & c14_06c!=13 & c14_06c!=14 & c14_06c!=15 & c14_06c!=16 & c14_06c!=17 & c14_06c!=18 & c14_06c!=19 & c14_06c!=96;
};

* assert c14_32a==. if c14_31a1!=1 & c14_31a2!=1 & c14_31a3!=1 & c14_31b1!=1 & c14_31b2!=1 & c14_31b3!=1 & c14_31c1!=1 & c14_31c2!=1 & c14_31c3!=1 & c14_31d1!=1 & c14_31d2!=1 & c14_31d3!=1 & c14_31e1!=1 & c14_31e2!=1 & c14_31e3!=1;
replace c14_32a=. if c14_31a1!=1 & c14_31a2!=1 & c14_31a3!=1 & c14_31b1!=1 & c14_31b2!=1 & c14_31b3!=1 & c14_31c1!=1 & c14_31c2!=1 & c14_31c3!=1 & c14_31d1!=1 & c14_31d2!=1 & c14_31d3!=1 & c14_31e1!=1 & c14_31e2!=1 & c14_31e3!=1;
* assert c14_32b==. if c14_31a1!=2 & c14_31a2!=2 & c14_31a3!=2 & c14_31b1!=2 & c14_31b2!=2 & c14_31b3!=2 & c14_31c1!=2 & c14_31c2!=2 & c14_31c3!=2 & c14_31d1!=2 & c14_31d2!=2 & c14_31d3!=2 & c14_31e1!=2 & c14_31e2!=2 & c14_31e3!=2;
replace c14_32b=. if c14_31a1!=2 & c14_31a2!=2 & c14_31a3!=2 & c14_31b1!=2 & c14_31b2!=2 & c14_31b3!=2 & c14_31c1!=2 & c14_31c2!=2 & c14_31c3!=2 & c14_31d1!=2 & c14_31d2!=2 & c14_31d3!=2 & c14_31e1!=2 & c14_31e2!=2 & c14_31e3!=2;
* assert c14_32c==. if c14_31a1!=3 & c14_31a2!=3 & c14_31a3!=3 & c14_31b1!=3 & c14_31b2!=3 & c14_31b3!=3 & c14_31c1!=3 & c14_31c2!=3 & c14_31c3!=3 & c14_31d1!=3 & c14_31d2!=3 & c14_31d3!=3 & c14_31e1!=3 & c14_31e2!=3 & c14_31e3!=3;
replace c14_32c=. if c14_31a1!=3 & c14_31a2!=3 & c14_31a3!=3 & c14_31b1!=3 & c14_31b2!=3 & c14_31b3!=3 & c14_31c1!=3 & c14_31c2!=3 & c14_31c3!=3 & c14_31d1!=3 & c14_31d2!=3 & c14_31d3!=3 & c14_31e1!=3 & c14_31e2!=3 & c14_31e3!=3;
* assert c14_32d==. if c14_31a1!=4 & c14_31a2!=4 & c14_31a3!=4 & c14_31b1!=4 & c14_31b2!=4 & c14_31b3!=4 & c14_31c1!=4 & c14_31c2!=4 & c14_31c3!=4 & c14_31d1!=4 & c14_31d2!=4 & c14_31d3!=4 & c14_31e1!=4 & c14_31e2!=4 & c14_31e3!=4;
replace c14_32d=. if c14_31a1!=4 & c14_31a2!=4 & c14_31a3!=4 & c14_31b1!=4 & c14_31b2!=4 & c14_31b3!=4 & c14_31c1!=4 & c14_31c2!=4 & c14_31c3!=4 & c14_31d1!=4 & c14_31d2!=4 & c14_31d3!=4 & c14_31e1!=4 & c14_31e2!=4 & c14_31e3!=4;
* assert c14_32e==. if c14_31a1!=5 & c14_31a2!=5 & c14_31a3!=5 & c14_31b1!=5 & c14_31b2!=5 & c14_31b3!=5 & c14_31c1!=5 & c14_31c2!=5 & c14_31c3!=5 & c14_31d1!=5 & c14_31d2!=5 & c14_31d3!=5 & c14_31e1!=5 & c14_31e2!=5 & c14_31e3!=5;
replace c14_32e=. if c14_31a1!=5 & c14_31a2!=5 & c14_31a3!=5 & c14_31b1!=5 & c14_31b2!=5 & c14_31b3!=5 & c14_31c1!=5 & c14_31c2!=5 & c14_31c3!=5 & c14_31d1!=5 & c14_31d2!=5 & c14_31d3!=5 & c14_31e1!=5 & c14_31e2!=5 & c14_31e3!=5;
* assert c14_32f==. if c14_31a1!=6 & c14_31a2!=6 & c14_31a3!=6 & c14_31b1!=6 & c14_31b2!=6 & c14_31b3!=6 & c14_31c1!=6 & c14_31c2!=6 & c14_31c3!=6 & c14_31d1!=6 & c14_31d2!=6 & c14_31d3!=6 & c14_31e1!=6 & c14_31e2!=6 & c14_31e3!=6;
replace c14_32f=. if c14_31a1!=6 & c14_31a2!=6 & c14_31a3!=6 & c14_31b1!=6 & c14_31b2!=6 & c14_31b3!=6 & c14_31c1!=6 & c14_31c2!=6 & c14_31c3!=6 & c14_31d1!=6 & c14_31d2!=6 & c14_31d3!=6 & c14_31e1!=6 & c14_31e2!=6 & c14_31e3!=6;
* assert c14_32g==. if c14_31a1!=7 & c14_31a2!=7 & c14_31a3!=7 & c14_31b1!=7 & c14_31b2!=7 & c14_31b3!=7 & c14_31c1!=7 & c14_31c2!=7 & c14_31c3!=7 & c14_31d1!=7 & c14_31d2!=7 & c14_31d3!=7 & c14_31e1!=7 & c14_31e2!=7 & c14_31e3!=7;
replace c14_32g=. if c14_31a1!=7 & c14_31a2!=7 & c14_31a3!=7 & c14_31b1!=7 & c14_31b2!=7 & c14_31b3!=7 & c14_31c1!=7 & c14_31c2!=7 & c14_31c3!=7 & c14_31d1!=7 & c14_31d2!=7 & c14_31d3!=7 & c14_31e1!=7 & c14_31e2!=7 & c14_31e3!=7;
* assert c14_32h==. if c14_31a1!=8 & c14_31a2!=8 & c14_31a3!=8 & c14_31b1!=8 & c14_31b2!=8 & c14_31b3!=8 & c14_31c1!=8 & c14_31c2!=8 & c14_31c3!=8 & c14_31d1!=8 & c14_31d2!=8 & c14_31d3!=8 & c14_31e1!=8 & c14_31e2!=8 & c14_31e3!=8;
replace c14_32h=. if c14_31a1!=8 & c14_31a2!=8 & c14_31a3!=8 & c14_31b1!=8 & c14_31b2!=8 & c14_31b3!=8 & c14_31c1!=8 & c14_31c2!=8 & c14_31c3!=8 & c14_31d1!=8 & c14_31d2!=8 & c14_31d3!=8 & c14_31e1!=8 & c14_31e2!=8 & c14_31e3!=8;
* assert c14_32i==. if c14_31a1!=9 & c14_31a2!=9 & c14_31a3!=9 & c14_31b1!=9 & c14_31b2!=9 & c14_31b3!=9 & c14_31c1!=9 & c14_31c2!=9 & c14_31c3!=9 & c14_31d1!=9 & c14_31d2!=9 & c14_31d3!=9 & c14_31e1!=9 & c14_31e2!=9 & c14_31e3!=9;
replace c14_32i=. if c14_31a1!=9 & c14_31a2!=9 & c14_31a3!=9 & c14_31b1!=9 & c14_31b2!=9 & c14_31b3!=9 & c14_31c1!=9 & c14_31c2!=9 & c14_31c3!=9 & c14_31d1!=9 & c14_31d2!=9 & c14_31d3!=9 & c14_31e1!=9 & c14_31e2!=9 & c14_31e3!=9;
* assert c14_32j==. if c14_31a1!=10 & c14_31a2!=10 & c14_31a3!=10 & c14_31b1!=10 & c14_31b2!=10 & c14_31b3!=10 & c14_31c1!=10 & c14_31c2!=10 & c14_31c3!=10 & c14_31d1!=10 & c14_31d2!=10 & c14_31d3!=10 & c14_31e1!=10 & c14_31e2!=10 & c14_31e3!=10;
replace c14_32j=. if c14_31a1!=10 & c14_31a2!=10 & c14_31a3!=10 & c14_31b1!=10 & c14_31b2!=10 & c14_31b3!=10 & c14_31c1!=10 & c14_31c2!=10 & c14_31c3!=10 & c14_31d1!=10 & c14_31d2!=10 & c14_31d3!=10 & c14_31e1!=10 & c14_31e2!=10 & c14_31e3!=10;
* assert c14_32k==. if c14_31a1!=96 & c14_31a2!=96 & c14_31a3!=96 & c14_31b1!=96 & c14_31b2!=96 & c14_31b3!=96 & c14_31c1!=96 & c14_31c2!=96 & c14_31c3!=96 & c14_31d1!=96 & c14_31d2!=96 & c14_31d3!=96 & c14_31e1!=96 & c14_31e2!=96 & c14_31e3!=96;
replace c14_32k=. if c14_31a1!=96 & c14_31a2!=96 & c14_31a3!=96 & c14_31b1!=96 & c14_31b2!=96 & c14_31b3!=96 & c14_31c1!=96 & c14_31c2!=96 & c14_31c3!=96 & c14_31d1!=96 & c14_31d2!=96 & c14_31d3!=96 & c14_31e1!=96 & c14_31e2!=96 & c14_31e3!=96;

* assert c14_34a==. if c14_31a1!=1 & c14_31a2!=1 & c14_31a3!=1 & c14_31b1!=1 & c14_31b2!=1 & c14_31b3!=1 & c14_31c1!=1 & c14_31c2!=1 & c14_31c3!=1 & c14_31d1!=1 & c14_31d2!=1 & c14_31d3!=1 & c14_31e1!=1 & c14_31e2!=1 & c14_31e3!=1;
replace c14_34a=. if c14_31a1!=1 & c14_31a2!=1 & c14_31a3!=1 & c14_31b1!=1 & c14_31b2!=1 & c14_31b3!=1 & c14_31c1!=1 & c14_31c2!=1 & c14_31c3!=1 & c14_31d1!=1 & c14_31d2!=1 & c14_31d3!=1 & c14_31e1!=1 & c14_31e2!=1 & c14_31e3!=1;
* assert c14_34b==. if c14_31a1!=2 & c14_31a2!=2 & c14_31a3!=2 & c14_31b1!=2 & c14_31b2!=2 & c14_31b3!=2 & c14_31c1!=2 & c14_31c2!=2 & c14_31c3!=2 & c14_31d1!=2 & c14_31d2!=2 & c14_31d3!=2 & c14_31e1!=2 & c14_31e2!=2 & c14_31e3!=2;
replace c14_34b=. if c14_31a1!=2 & c14_31a2!=2 & c14_31a3!=2 & c14_31b1!=2 & c14_31b2!=2 & c14_31b3!=2 & c14_31c1!=2 & c14_31c2!=2 & c14_31c3!=2 & c14_31d1!=2 & c14_31d2!=2 & c14_31d3!=2 & c14_31e1!=2 & c14_31e2!=2 & c14_31e3!=2;
* assert c14_34c==. if c14_31a1!=3 & c14_31a2!=3 & c14_31a3!=3 & c14_31b1!=3 & c14_31b2!=3 & c14_31b3!=3 & c14_31c1!=3 & c14_31c2!=3 & c14_31c3!=3 & c14_31d1!=3 & c14_31d2!=3 & c14_31d3!=3 & c14_31e1!=3 & c14_31e2!=3 & c14_31e3!=3;
replace c14_34c=. if c14_31a1!=3 & c14_31a2!=3 & c14_31a3!=3 & c14_31b1!=3 & c14_31b2!=3 & c14_31b3!=3 & c14_31c1!=3 & c14_31c2!=3 & c14_31c3!=3 & c14_31d1!=3 & c14_31d2!=3 & c14_31d3!=3 & c14_31e1!=3 & c14_31e2!=3 & c14_31e3!=3;
* assert c14_34d==. if c14_31a1!=4 & c14_31a2!=4 & c14_31a3!=4 & c14_31b1!=4 & c14_31b2!=4 & c14_31b3!=4 & c14_31c1!=4 & c14_31c2!=4 & c14_31c3!=4 & c14_31d1!=4 & c14_31d2!=4 & c14_31d3!=4 & c14_31e1!=4 & c14_31e2!=4 & c14_31e3!=4;
replace c14_34d=. if c14_31a1!=4 & c14_31a2!=4 & c14_31a3!=4 & c14_31b1!=4 & c14_31b2!=4 & c14_31b3!=4 & c14_31c1!=4 & c14_31c2!=4 & c14_31c3!=4 & c14_31d1!=4 & c14_31d2!=4 & c14_31d3!=4 & c14_31e1!=4 & c14_31e2!=4 & c14_31e3!=4;
* assert c14_34e==. if c14_31a1!=5 & c14_31a2!=5 & c14_31a3!=5 & c14_31b1!=5 & c14_31b2!=5 & c14_31b3!=5 & c14_31c1!=5 & c14_31c2!=5 & c14_31c3!=5 & c14_31d1!=5 & c14_31d2!=5 & c14_31d3!=5 & c14_31e1!=5 & c14_31e2!=5 & c14_31e3!=5;
replace c14_34e=. if c14_31a1!=5 & c14_31a2!=5 & c14_31a3!=5 & c14_31b1!=5 & c14_31b2!=5 & c14_31b3!=5 & c14_31c1!=5 & c14_31c2!=5 & c14_31c3!=5 & c14_31d1!=5 & c14_31d2!=5 & c14_31d3!=5 & c14_31e1!=5 & c14_31e2!=5 & c14_31e3!=5;
* assert c14_34f==. if c14_31a1!=6 & c14_31a2!=6 & c14_31a3!=6 & c14_31b1!=6 & c14_31b2!=6 & c14_31b3!=6 & c14_31c1!=6 & c14_31c2!=6 & c14_31c3!=6 & c14_31d1!=6 & c14_31d2!=6 & c14_31d3!=6 & c14_31e1!=6 & c14_31e2!=6 & c14_31e3!=6;
replace c14_34f=. if c14_31a1!=6 & c14_31a2!=6 & c14_31a3!=6 & c14_31b1!=6 & c14_31b2!=6 & c14_31b3!=6 & c14_31c1!=6 & c14_31c2!=6 & c14_31c3!=6 & c14_31d1!=6 & c14_31d2!=6 & c14_31d3!=6 & c14_31e1!=6 & c14_31e2!=6 & c14_31e3!=6;
* assert c14_34g==. if c14_31a1!=8 & c14_31a2!=8 & c14_31a3!=8 & c14_31b1!=8 & c14_31b2!=8 & c14_31b3!=8 & c14_31c1!=8 & c14_31c2!=8 & c14_31c3!=8 & c14_31d1!=8 & c14_31d2!=8 & c14_31d3!=8 & c14_31e1!=8 & c14_31e2!=8 & c14_31e3!=8;
replace c14_34g=. if c14_31a1!=8 & c14_31a2!=8 & c14_31a3!=8 & c14_31b1!=8 & c14_31b2!=8 & c14_31b3!=8 & c14_31c1!=8 & c14_31c2!=8 & c14_31c3!=8 & c14_31d1!=8 & c14_31d2!=8 & c14_31d3!=8 & c14_31e1!=8 & c14_31e2!=8 & c14_31e3!=8;
* assert c14_34h==. if c14_31a1!=9 & c14_31a2!=9 & c14_31a3!=9 & c14_31b1!=9 & c14_31b2!=9 & c14_31b3!=9 & c14_31c1!=9 & c14_31c2!=9 & c14_31c3!=9 & c14_31d1!=9 & c14_31d2!=9 & c14_31d3!=9 & c14_31e1!=9 & c14_31e2!=9 & c14_31e3!=9;
replace c14_34h=. if c14_31a1!=9 & c14_31a2!=9 & c14_31a3!=9 & c14_31b1!=9 & c14_31b2!=9 & c14_31b3!=9 & c14_31c1!=9 & c14_31c2!=9 & c14_31c3!=9 & c14_31d1!=9 & c14_31d2!=9 & c14_31d3!=9 & c14_31e1!=9 & c14_31e2!=9 & c14_31e3!=9;
* assert c14_34i==. if c14_31a1!=10 & c14_31a2!=10 & c14_31a3!=10 & c14_31b1!=10 & c14_31b2!=10 & c14_31b3!=10 & c14_31c1!=10 & c14_31c2!=10 & c14_31c3!=10 & c14_31d1!=10 & c14_31d2!=10 & c14_31d3!=10 & c14_31e1!=10 & c14_31e2!=10 & c14_31e3!=10;
replace c14_34i=. if c14_31a1!=10 & c14_31a2!=10 & c14_31a3!=10 & c14_31b1!=10 & c14_31b2!=10 & c14_31b3!=10 & c14_31c1!=10 & c14_31c2!=10 & c14_31c3!=10 & c14_31d1!=10 & c14_31d2!=10 & c14_31d3!=10 & c14_31e1!=10 & c14_31e2!=10 & c14_31e3!=10;
* assert c14_34j==. if c14_31a1!=96 & c14_31a2!=96 & c14_31a3!=96 & c14_31b1!=96 & c14_31b2!=96 & c14_31b3!=96 & c14_31c1!=96 & c14_31c2!=96 & c14_31c3!=96 & c14_31d1!=96 & c14_31d2!=96 & c14_31d3!=96 & c14_31e1!=96 & c14_31e2!=96 & c14_31e3!=96;
replace c14_34j=. if c14_31a1!=96 & c14_31a2!=96 & c14_31a3!=96 & c14_31b1!=96 & c14_31b2!=96 & c14_31b3!=96 & c14_31c1!=96 & c14_31c2!=96 & c14_31c3!=96 & c14_31d1!=96 & c14_31d2!=96 & c14_31d3!=96 & c14_31e1!=96 & c14_31e2!=96 & c14_31e3!=96;

foreach var of varlist c14_34a c14_34b c14_34c c14_34d c14_34e c14_34f c14_34g c14_34h c14_34i c14_34j c14_25a c14_25b c14_25c c14_25d c14_25e {;
	replace `var'=.a if `var'==99 | `var'==999 | `var'==9999;
};

gen c14_31_1=.;
replace c14_31_1=1 if c14_31a1!=. | c14_31b1!=. | c14_31c1!=. | c14_31d1!=. | c14_31e1!=.;
replace c14_31_1=0 if c14_31a1==. & c14_31b1==. & c14_31c1==. & c14_31d1==. & c14_31e1==.;
lab var c14_31_1 "Took drugs for main disease";
gen c14_31_2=.;
replace c14_31_2=1 if c14_31a2!=. | c14_31b2!=. | c14_31c2!=. | c14_31d2!=. | c14_31e2!=.;
replace c14_31_2=0 if c14_31a2==. & c14_31b2==. & c14_31c2==. & c14_31d2==. & c14_31e2==.;
lab var c14_31_2 "Took drugs for 2nd disease";
gen c14_31_3=.;
replace c14_31_3=1 if c14_31a3!=. | c14_31b3!=. | c14_31c3!=. | c14_31d3!=. | c14_31e3!=.;
replace c14_31_3=0 if c14_31a3==. & c14_31b3==. & c14_31c3==. & c14_31d3==. & c14_31e3==.;
lab var c14_31_3 "Took drugs for 3rd disease";
foreach var of varlist c14_34a c14_34b c14_34c c14_34d c14_34e c14_34f c14_34g c14_34h c14_34i c14_34j {;
	replace `var'=.b if c14_31_1!=1 & c14_31_2!=1 & c14_31_3!=1;
	* If no medication taken, treatment cost!=0 RWF spent, but rather equal to missing;
};
drop c14_31_1 c14_31_2 c14_31_3;	

* assert c14_35==0 | c14_35==. if c14_31a1==. & c14_31a2==. & c14_31a3==. & c14_31b1==. & c14_31b2==. & c14_31b3==. & c14_31c1==. & c14_31c2==. & c14_31c3==. & c14_31d1==. & c14_31d2==. & c14_31d3==. & c14_31e1==. & c14_31e2==. & c14_31e3==.;
replace c14_35=. if c14_31a1==. & c14_31a2==. & c14_31a3==. & c14_31b1==. & c14_31b2==. & c14_31b3==. & c14_31c1==. & c14_31c2==. & c14_31c3==. & c14_31d1==. & c14_31d2==. & c14_31d3==. & c14_31e1==. & c14_31e2==. & c14_31e3==.;
egen c14_35_1=rowtotal(c14_34a c14_34b c14_34c c14_34d c14_34e c14_34f c14_34g c14_34h c14_34i c14_34j);
* assert c14_35==c14_35_1 | (c14_35==. & c14_35_1==0);
replace c14_35=c14_35_1 if c14_35!=c14_35_1;
replace c14_35=. if c14_31a1==. & c14_31a2==. & c14_31a3==. & c14_31b1==. & c14_31b2==. & c14_31b3==. & c14_31c1==. & c14_31c2==. & c14_31c3==. & c14_31d1==. & c14_31d2==. & c14_31d3==. & c14_31e1==. & c14_31e2==. & c14_31e3==.;
replace c14_35=. if c14_34a==. & c14_34b==. & c14_34c==. & c14_34d==. & c14_34e==. & c14_34f==. & c14_34g==. & c14_34h==. & c14_34i==. & c14_34j==.;
drop c14_35_1;

assert c14_40==3 if c14_08u==3;
assert c14_40!=3 if c14_08u!=3;

lab var c14_39 "Days inactive due to illness 4w";


sort hrbf_id1 hrbf_id2 c14_pid;
save $cleandatadir/rwhrbf_c01.dta, replace;



************************************
*** Create rwhrbf_c01_with_studyarms
************************************;

ren c14_pid a1_pid;
save $tempdatadir/rwhrbf_c01.dta, replace;

use $cleandatadir/rwhrbf_household_roster.dta, clear;
merge hrbf_id1 hrbf_id2 a1_pid using $tempdatadir/rwhrbf_c01.dta, unique;
tab _merge;
list hrbf_id1 hrbf_id2 a1_pid a1_02 if _merge==2;
drop if _merge==2;
drop _merge;
* assert a1_11a<5 if c14_05<. | c14_06a<. | c14_06b<. | c14_06c<. | c14_07a<. | c14_07u<. | c14_08a<. | c14_08u<. | c14_09<. | c14_10<. | c14_11<. | c14_12<. | c14_12a<. | c14_25a<. | c14_25b<. | c14_25c<. | c14_25d<. | c14_25e<. | c14_31a1<. | c14_31a2<. | c14_31a3<. | c14_31b1<. | c14_31b2<. | c14_31b3<. | c14_31c1<. | c14_31c2<. | c14_31c3<. | c14_31d1<. | c14_31d2<. | c14_31d3<. | c14_31e1<. | c14_31e2<. | c14_31e3<. | c14_32a<. | c14_32b<. | c14_32c<. | c14_32d<. | c14_32e<. | c14_32f<. | c14_32g<. | c14_32h<. | c14_32i<. | c14_32j<. | c14_32k<. | c14_34a<. | c14_34b<. | c14_34c<. | c14_34d<. | c14_34e<. | c14_34f<. | c14_34g<. | c14_34h<. | c14_34i<. | c14_34j<. | c14_35<. | c14_39<. | c14_40<.;

list hrbf_id1 hrbf_id2 a1_pid a1_11a a1_11b if a1_11a>=5 & (c14_05<. | c14_06a<. | c14_06b<. | c14_06c<. | c14_07a<. | c14_07u<. | c14_08a<. | c14_08u<. | c14_09<. | c14_10<. | c14_11<. | c14_12<. | c14_12a<. | c14_25a<. | c14_25b<. | c14_25c<. | c14_25d<. | c14_25e<. | c14_31a1<. | c14_31a2<. | c14_31a3<. | c14_31b1<. | c14_31b2<. | c14_31b3<. | c14_31c1<. | c14_31c2<. | c14_31c3<. | c14_31d1<. | c14_31d2<. | c14_31d3<. | c14_31e1<. | c14_31e2<. | c14_31e3<. | c14_32a<. | c14_32b<. | c14_32c<. | c14_32d<. | c14_32e<. | c14_32f<. | c14_32g<. | c14_32h<. | c14_32i<. | c14_32j<. | c14_32k<. | c14_34a<. | c14_34b<. | c14_34c<. | c14_34d<. | c14_34e<. | c14_34f<. | c14_34g<. | c14_34h<. | c14_34i<. | c14_34j<. | c14_35<. | c14_39<. | c14_40<.);

drop if a1_11a>=5 & (c14_05<. | c14_06a<. | c14_06b<. | c14_06c<. | c14_07a<. | c14_07u<. | c14_08a<. | c14_08u<. | c14_09<. | c14_10<. | c14_11<. | c14_12<. | c14_12a<. | c14_25a<. | c14_25b<. | c14_25c<. | c14_25d<. | c14_25e<. | c14_31a1<. | c14_31a2<. | c14_31a3<. | c14_31b1<. | c14_31b2<. | c14_31b3<. | c14_31c1<. | c14_31c2<. | c14_31c3<. | c14_31d1<. | c14_31d2<. | c14_31d3<. | c14_31e1<. | c14_31e2<. | c14_31e3<. | c14_32a<. | c14_32b<. | c14_32c<. | c14_32d<. | c14_32e<. | c14_32f<. | c14_32g<. | c14_32h<. | c14_32i<. | c14_32j<. | c14_32k<. | c14_34a<. | c14_34b<. | c14_34c<. | c14_34d<. | c14_34e<. | c14_34f<. | c14_34g<. | c14_34h<. | c14_34i<. | c14_34j<. | c14_35<. | c14_39<. | c14_40<.);

save $cleandatadir/rwhrbf_c01_withstudyarms.dta, replace;



*********************************************
*** Create necessary variables for mean tests
*********************************************;

gen c14_05_1=c14_05==1;
replace c14_05_1=. if c14_05==.;
lab var c14_05_1 "Sick in past 4 weeks";

forvalues v=1(1)19 {;
	gen c14_06a_`v'=c14_06a==`v';
	replace c14_06a_`v'=. if c14_06a==.;
};
gen c14_06a_96=c14_06a==96;
replace c14_06a_96=. if c14_06a==.;
lab var c14_06a_1 "Main disease:Fever/malaria";
lab var c14_06a_2 "Main disease:cough/chest infect";
lab var c14_06a_3 "Main disease:TB";
lab var c14_06a_4 "Main disease:Asthma";
lab var c14_06a_5 "Main disease:Bronchitis";
lab var c14_06a_6 "Main disease:Pneumonia";
lab var c14_06a_7 "Main disease:Diarrhea w\blood";
lab var c14_06a_8 "Main disease:Diarrhea w/blood";
lab var c14_06a_9 "Main disease:Diarrhea vomiting";
lab var c14_06a_10 "Main disease:Vomiting";
lab var c14_06a_11 "Main disease:Abdominal pain";
lab var c14_06a_12 "Main disease:Anemia";
lab var c14_06a_13 "Main disease:Skin rash/infect";
lab var c14_06a_14 "Main disease:Eye/Ear infect";
lab var c14_06a_15 "Main disease:Measles";
lab var c14_06a_16 "Main disease:Jaundice";
lab var c14_06a_17 "Main disease:Convulsions";
lab var c14_06a_18 "Main disease:Sore throat";
lab var c14_06a_19 "Main disease:Accident injuries";
lab var c14_06a_96 "Main disease:Other";

forvalues v=1(1)19 {;
	gen c14_06b_`v'=c14_06b==`v';
	replace c14_06b_`v'=. if c14_06b==.;
};
gen c14_06b_96=c14_06b==96;
replace c14_06b_96=. if c14_06b==.;
lab var c14_06b_1 "2nd disease:Fever/malaria";
lab var c14_06b_2 "2nd disease:cough/chest infect";
lab var c14_06b_3 "2nd disease:TB";
lab var c14_06b_4 "2nd disease:Asthma";
lab var c14_06b_5 "2nd disease:Bronchitis";
lab var c14_06b_6 "2nd disease:Pneumonia";
lab var c14_06b_7 "2nd disease:Diarrhea w\blood";
lab var c14_06b_8 "2nd disease:Diarrhea w/blood";
lab var c14_06b_9 "2nd disease:Diarrhea vomiting";
lab var c14_06b_10 "2nd disease:Vomiting";
lab var c14_06b_11 "2nd disease:Abdominal pain";
lab var c14_06b_12 "2nd disease:Anemia";
lab var c14_06b_13 "2nd disease:Skin rash/infect";
lab var c14_06b_14 "2nd disease:Eye/Ear infect";
lab var c14_06b_15 "2nd disease:Measles";
lab var c14_06b_16 "2nd disease:Jaundice";
lab var c14_06b_17 "2nd disease:Convulsions";
lab var c14_06b_18 "2nd disease:Sore throat";
lab var c14_06b_19 "2nd disease:Accident injuries";
lab var c14_06b_96 "2nd disease:Other";

forvalues v=1(1)19 {;
	gen c14_06c_`v'=c14_06c==`v';
	replace c14_06c_`v'=. if c14_06c==.;
};
gen c14_06c_96=c14_06c==96;
replace c14_06c_96=. if c14_06c==.;
lab var c14_06c_1 "3rd disease:Fever/malaria";
lab var c14_06c_2 "3rd disease:cough/chest infect";
lab var c14_06c_3 "3rd disease:TB";
lab var c14_06c_4 "3rd disease:Asthma";
lab var c14_06c_5 "3rd disease:Bronchitis";
lab var c14_06c_6 "3rd disease:Pneumonia";
lab var c14_06c_7 "3rd disease:Diarrhea w\blood";
lab var c14_06c_8 "3rd disease:Diarrhea w/blood";
lab var c14_06c_9 "3rd disease:Diarrhea vomiting";
lab var c14_06c_10 "3rd disease:Vomiting";
lab var c14_06c_11 "3rd disease:Abdominal pain";
lab var c14_06c_12 "3rd disease:Anemia";
lab var c14_06c_13 "3rd disease:Skin rash/infect";
lab var c14_06c_14 "3rd disease:Eye/Ear infect";
lab var c14_06c_15 "3rd disease:Measles";
lab var c14_06c_16 "3rd disease:Jaundice";
lab var c14_06c_17 "3rd disease:Convulsions";
lab var c14_06c_18 "3rd disease:Sore throat";
lab var c14_06c_19 "3rd disease:Accident injuries";
lab var c14_06c_96 "3rd disease:Other";

gen c14_07a_1=c14_07a;
replace c14_07a_1=c14_07a*7 if c14_07u==2;
replace c14_07a_1=c14_07a*30.5 if c14_07u==3;
assert c14_07a_1==. if c14_07a==.;
lab var c14_07a_1 "Illness started X days ago";

gen c14_08a_1=c14_08a;
replace c14_08a_1=c14_08a*7 if c14_08u==2;
replace c14_08a_1=0 if c14_08u==3;
assert c14_08a_1==. if c14_08a==. & c14_08u!=3;
lab var c14_08a_1 "Illness ended X days ago";

gen c14_08a_2=c14_07a_1-c14_08a_1;
replace c14_08a_2=1 if c14_08a_1>c14_07a_1 & c14_08a_1!=. & c14_07a_1!=.;
replace c14_08a_2=. if c14_07a==. | c14_08a==.;
lab var c14_08a_2 "Nr days of illness";
tab c14_08a_2;

gen c14_09_1=c14_09==1;
replace c14_09_1=. if c14_09==.;
lab var c14_09_1 "Had diarrhea in past 4 weeks";

gen c14_10_4=.;
replace c14_10_4=1 if c14_10==4 & c14_09==1;
replace c14_10_4=0 if c14_10!=4 & c14_10<. & c14_09==1;
lab var c14_10_4 "More water against diarrhea";

gen c14_11_4=.;
replace c14_11_4=1 if (c14_11==3 | c14_11==4) & c14_09==1;
replace c14_11_4=0 if (c14_11!=3 & c14_11!=4 & c14_11<.) & c14_09==1;
lab var c14_11_4 "Continued feeding agst diarrhea";

gen c14_12_1=.;
replace c14_12_1=1 if c14_12==1 & c14_09==1;
replace c14_12_1=0 if c14_12!=1 & c14_12<. & c14_09==1;
lab var c14_12_1 "ORS against diarrhea";

forvalues v=1(1)12 {;
	gen c14_12a_`v'=c14_12a==`v';
	replace c14_12a_`v'=. if c14_12a==.;
};
gen c14_12a_96=c14_12a==96;
replace c14_12a_96=. if c14_12a==.;
lab var c14_12a_1 "ORS got at govt hospital";
lab var c14_12a_2 "ORS got at govt health center";
lab var c14_12a_3 "ORS got at govt health post";
lab var c14_12a_4 "ORS got at private hospital";
lab var c14_12a_5 "ORS got at priv health center";
lab var c14_12a_6 "ORS got at priv health post";
lab var c14_12a_7 "ORS got at pharmacy";
lab var c14_12a_8 "ORS got at medical personnel";
lab var c14_12a_9 "ORS got at traditional healer";
lab var c14_12a_10 "ORS got at faith/church healer";
lab var c14_12a_11 "ORS got at CHW";
lab var c14_12a_12 "ORS got at Friends/Neighbors";
lab var c14_12a_96 "ORS got at Other";

egen c14_25_1=rowtotal(c14_25a c14_25b c14_25c c14_25d c14_25e);
replace c14_25_1=. if c14_25a>=. & c14_25b>=. & c14_25c>=. & c14_25d>=. & c14_25e>=.;
lab var c14_25_1 "Consult cost last 4 weeks RWF";

egen c14_25_2=rowtotal(c14_25a c14_25b c14_25c c14_25d);
replace c14_25_2=. if c14_25a>=. & c14_25b>=. & c14_25c>=. & c14_25d>=.;
lab var c14_25_2 "Consult cost w\transport RWF";

gen c14_31_1=.;
replace c14_31_1=1 if c14_31a1!=. | c14_31b1!=. | c14_31c1!=. | c14_31d1!=. | c14_31e1!=.;
replace c14_31_1=0 if c14_31a1==. & c14_31b1==. & c14_31c1==. & c14_31d1==. & c14_31e1==.;
lab var c14_31_1 "Took drugs for main disease";

gen c14_31_2=.;
replace c14_31_2=1 if c14_31a2!=. | c14_31b2!=. | c14_31c2!=. | c14_31d2!=. | c14_31e2!=.;
replace c14_31_2=0 if c14_31a2==. & c14_31b2==. & c14_31c2==. & c14_31d2==. & c14_31e2==.;
lab var c14_31_2 "Took drugs for 2nd disease";

gen c14_31_3=.;
replace c14_31_3=1 if c14_31a3!=. | c14_31b3!=. | c14_31c3!=. | c14_31d3!=. | c14_31e3!=.;
replace c14_31_3=0 if c14_31a3==. & c14_31b3==. & c14_31c3==. & c14_31d3==. & c14_31e3==.;
lab var c14_31_3 "Took drugs for 3rd disease";

forvalues v=1(1)3 {;
	gen c14_40_`v'=c14_40==`v';
	replace c14_40_`v'=. if c14_40==.;
};
lab var c14_40_1 "Illness outcome:Full recovery";
lab var c14_40_2 "Illness outcome:Partial recovery";
lab var c14_40_3 "Illness outcome:Not recovered";



***
*** Indicators
***;

gen c14_31a_100=.;
replace c14_31a_100=1 if c14_07a_1<=14 & (c14_06a==1 | c14_06b==1 | c14_06c==1) & (c14_31a1<=4 | c14_31a2<=4 | c14_31a3<=4);
replace c14_31a_100=0 if c14_07a_1<=14 & (c14_06a==1 | c14_06b==1 | c14_06c==1) & c14_31a1>4 & c14_31a2>4 & c14_31a2>4;
lab var c14_31a_100 "Effective case mgt malaria";
* WHO indicator (also in JHU report);

gen c14_31a_101=.;
replace c14_31a_101=1 if c14_07a_1<=14 & (c14_06a==6 | c14_06b==6 | c14_06c==6 | (c14_06a==2 & (c14_06b==4 | c14_06c==4)) | (c14_06a==4 & (c14_06b==5 | c14_06c==5)) | (c14_06b==2 & (c14_06a==4 | c14_06c==4)) | (c14_06b==4 & (c14_06a==5 | c14_06c==5)) | (c14_06c==2 & (c14_06a==4 | c14_06b==4)) | (c14_06c==4 & (c14_06a==5 | c14_06b==5))) & (c14_31a1==9 | c14_31a2==9 | c14_31a3==9);
replace c14_31a_101=0 if c14_07a_1<=14 & (c14_06a==6 | c14_06b==6 | c14_06c==6 | (c14_06a==2 & (c14_06b==4 | c14_06c==4)) | (c14_06a==4 & (c14_06b==5 | c14_06c==5)) | (c14_06b==2 & (c14_06a==4 | c14_06c==4)) | (c14_06b==4 & (c14_06a==5 | c14_06c==5)) | (c14_06c==2 & (c14_06a==4 | c14_06b==4)) | (c14_06c==4 & (c14_06a==5 | c14_06b==5))) & (c14_31a1!=9 & c14_31a2!=9 & c14_31a3!=9);
lab var c14_31a_101 "Antibiotics Suspected pneumonia";
* JHU report indicator;

gen c14_12_100=.;
replace c14_12_100=1 if c14_09==1 & c14_07a_1<=14 & (c14_12==1 | c14_10==4) & (c14_11==3 | c14_11==4);
replace c14_12_100=0 if c14_09==1 & c14_07a_1<=14 & ((c14_12==2 & c14_10!=4 & c14_10<.) | (c14_11==1 | c14_11==2));
lab var c14_12_100 "ORS/Fluids &Feeding if Diarrhea";
* JHU report indicator;


* Note: Care seeking pneumonia cannot be calculated here because we don't ask whether the child was taken to a facility, and which facility. Indicator could be calculated otherwise if this information was collected. The indicator would be calculated like;
* gen c14_06_100=.;
* replace c14_06_100=1 if ((c14_06==2 & c14_06==4) | c14_06==6) & c14_07a_1<=14 & (TAKEN TO APPROPRIATE FACILITY);
* replace c14_06_100=0 if ((c14_06==2 & c14_06==4) | c14_06==6) & c14_07a_1<=14 & (NOT TAKEN TO APPROPRIATE FACILITY);
* lab var c14_06_100 "Care seeking pneumonia";

svyset [pweight=hhpweight], psu(hrbf_id1);
save $cleandatadir/rwhrbf_c01_withstudyarms_withvarformeantests.dta, replace;

log close;








