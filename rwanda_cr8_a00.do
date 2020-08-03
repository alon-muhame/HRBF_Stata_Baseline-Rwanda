* Elisa Rothenbuhler - Aug 10

* This do-file:
*  Generates appropriate variables for mean tests on $cleandatadir/rwhrbf_a00_withstudyarms.dta
* (includes sections 5, part of section 6, part of section 7).

version 10.0
clear
set more off
set mem 500m
cap log close

#delimit ;

log using $logdir/rwanda_cr8_a00.log, replace;

use $cleandatadir/rwhrbf_a00_withstudyarms.dta;

gen group_code_1=group_code==1;
gen group_code_2=group_code==2;
gen group_code_3=group_code==3;
gen group_code_4=group_code==4;
lab var group_code_1 "Demand-side treatment";
lab var group_code_2 "Supply-side treatment";
lab var group_code_3 "Demand- and supply-side treatment";
lab var group_code_4 "Control";

forvalues v=1(1)9 {;
	gen a5_03_`v'=a5_03==`v';
	replace a5_03_`v'=. if a5_03==.;
};
gen a5_03_96=a5_03==96;
replace a5_03_96=. if a5_03==.;
lab var a5_03_1 "Dwelling:owned w/mortgage";
lab var a5_03_2 "Dwelling:owned w\mortgage";
lab var a5_03_3 "Dwelling:rented";
lab var a5_03_4 "Dwelling:rented tied to job";
lab var a5_03_5 "Dwelling:rent free";
lab var a5_03_6 "Dwelling:municipality plot";
lab var a5_03_7 "Dwelling:govt employer provided";
lab var a5_03_8 "Dwelling:private empl provided";
lab var a5_03_9 "Dwelling:temporary";
lab var a5_03_96 "Dwelling:other";

gen a5_04_1=a5_04a;
lab var a5_04_1 "Monthly rent/mortgage paid RWF";
replace a5_04_1=a5_04a/3 if a5_04b==2;
replace a5_04_1=a5_04a/6 if a5_04b==3;
replace a5_04_1=a5_04a/12 if a5_04b==4;
replace a5_04_1=a5_04a*4 if a5_04b==5;
replace a5_04_1=a5_04a*2 if a5_04b==6;
replace a5_04_1=. if a5_04b==96;

gen a5_06_1=a5_06a;
lab var a5_06_1 "Monthly saved rent RWF";
replace a5_06_1=a5_06a/3 if a5_06b==2;
replace a5_06_1=a5_06a/6 if a5_06b==3;
replace a5_06_1=a5_06a/12 if a5_06b==4;
replace a5_06_1=a5_06a*4 if a5_06b==5;
replace a5_06_1=a5_06a*2 if a5_06b==6;
replace a5_06_1=. if a5_06b==96;

forvalues v=1(1)11 {;
	gen a5_08a_`v'=a5_08a==`v';
	replace a5_08a_`v'=. if a5_08a==.;
	gen a5_08b_`v'=a5_08b==`v';
	replace a5_08b_`v'=. if a5_08b==.;
};
gen a5_08a_96=a5_08a==96;
replace a5_08a_96=. if a5_08a==.;
gen a5_08b_96=a5_08b==96;
replace a5_08b_96=. if a5_08b==.;
lab var a5_08a_1 "Water dry:Piped dwelling";
lab var a5_08a_2 "Water dry:Piped yard";
lab var a5_08a_3 "Water dry:Public tap";
lab var a5_08a_4 "Water dry:Protected well";
lab var a5_08a_5 "Water dry:Unprotected well";
lab var a5_08a_6 "Water dry:Protected spring";
lab var a5_08a_7 "Water dry:Unprotected spring";
lab var a5_08a_8 "Water dry:rainwater";
lab var a5_08a_9 "Water dry:tanker truck";
lab var a5_08a_10 "Water dry:surface water";
lab var a5_08a_11 "Water dry:bottled water";
lab var a5_08a_96 "Water dry:other";
lab var a5_08b_1 "Water rainy:Piped dwelling";
lab var a5_08b_2 "Water rainy:Piped yard";
lab var a5_08b_3 "Water rainy:Public tap";
lab var a5_08b_4 "Water rainy:Protected well";
lab var a5_08b_5 "Water rainy:Unprotected well";
lab var a5_08b_6 "Water rainy:Protected spring";
lab var a5_08b_7 "Water rainy:Unprotected spring";
lab var a5_08b_8 "Water rainy:rainwater";
lab var a5_08b_9 "Water rainy:tanker truck";
lab var a5_08b_10 "Water rainy:surface water";
lab var a5_08b_11 "Water rainy:bottled water";
lab var a5_08b_96 "Water rainy:other";

gen a5_08a_100=a5_08a<=4 | a5_08a==6 | a5_08a==8;
replace a5_08a_100=. if a5_08a==.;
lab var a5_08a_100 "Dry:Access improved water";

gen a5_08b_100=a5_08b<=4 | a5_08b==6 | a5_08b==8;
replace a5_08b_100=. if a5_08b==.;
lab var a5_08b_100 "Rainy:Access improved water";

forvalues v=1(1)4 {;
	gen a5_10a_`v'=a5_10a==`v';
	replace a5_10a_`v'=. if a5_10a==.;
	gen a5_10b_`v'=a5_10b==`v';
	replace a5_10b_`v'=. if a5_10b==.;
};
gen a5_10a_96=a5_10a==96;
replace a5_10a_96=. if a5_10a==.;
gen a5_10b_96=a5_10b==96;
replace a5_10b_96=. if a5_10b==.;
lab var a5_10a_1 "Water treatment dry:none";
lab var a5_10a_2 "Water treatment dry:boil";
lab var a5_10a_3 "Water treatment dry:chlorine";
lab var a5_10a_4 "Water treatment dry:iodine";
lab var a5_10a_96 "Water treatment dry:other";
lab var a5_10b_1 "Water treatment rainy:none";
lab var a5_10b_2 "Water treatment rainy:boil";
lab var a5_10b_3 "Water treatment rainy:chlorine";
lab var a5_10b_4 "Water treatment rainy:iodine";
lab var a5_10b_96 "Water treatment rainy:other";

tab a5_11;
forvalues v=1(1)11 {;
	gen a5_11_`v'=a5_11==`v';
	replace a5_11_`v'=. if a5_11==.;
};
drop a5_11_11;
gen a5_11_96=a5_11==96;
replace a5_11_96=. if a5_11==.;
lab var a5_11_1 "Toilet:flush to sewer";
lab var a5_11_2 "Toilet:flush to septic";
lab var a5_11_3 "Toilet:flush to pit latrine";
lab var a5_11_4 "Toilet:flush to other";
lab var a5_11_5 "Toilet:ventil pit latrine";
lab var a5_11_6 "Toilet:pit latrine w/slab";
lab var a5_11_7 "Toilet:composting toilet";
lab var a5_11_8 "Toilet:open pit";
lab var a5_11_9 "Toilet:bucket";
lab var a5_11_10 "Toilet:hanging toilet";
lab var a5_11_96 "Toilet:other";

gen a5_11_100=a5_11<=3 | a5_11==5 | a5_11==6 | a5_11==7;
replace a5_11_100=. if a5_11==.;
lab var a5_11_100 "Access improved sanitation";

forvalues v=1(1)5 {;
	gen a5_13_`v'=a5_13==`v';
	replace a5_13_`v'=. if a5_13==.;
};
gen a5_13_96=a5_13==96;
replace a5_13_96=. if a5_13==.;
lab var a5_13_1 "Rubbish:Collected";
lab var a5_13_2 "Rubbish:Pit";
lab var a5_13_3 "Rubbish:Bury";
lab var a5_13_4 "Rubbish:Burn";
lab var a5_13_5 "Rubbish:Nothing";
lab var a5_13_96 "Rubbish:Other";

forvalues v=1(1)10 {;
	gen a5_14_`v'=a5_14==`v';
	replace a5_14_`v'=. if a5_14==.;
};
gen a5_14_96=a5_14==96;
replace a5_14_96=. if a5_14==.;
lab var a5_14_1 "Energy Light:Keros Paraf Oil";
lab var a5_14_2 "Energy Light:Electricity";
lab var a5_14_3 "Energy Light:Candles";
lab var a5_14_4 "Energy Light:Diesel";
lab var a5_14_5 "Energy Light:Open fire";
lab var a5_14_6 "Energy Light:Torch";
lab var a5_14_7 "Energy Light:Solar panel";
lab var a5_14_8 "Energy Light:Coal";
lab var a5_14_9 "Energy Light:Gas";
lab var a5_14_10 "Energy Light:Generator";
lab var a5_14_96 "Energy Light:Other";

forvalues v=1(1)10 {;
	gen a5_15_`v'=a5_15==`v';
	replace a5_15_`v'=. if a5_15==.;
};
gen a5_15_96=a5_15==96;
replace a5_15_96=. if a5_15==.;
lab var a5_15_1 "Energy Cook:Keros Paraf Oil";
lab var a5_15_2 "Energy Cook:Electricity";
lab var a5_15_3 "Energy Cook:Candles";
lab var a5_15_4 "Energy Cook:Diesel";
lab var a5_15_5 "Energy Cook:Open fire";
lab var a5_15_6 "Energy Cook:Torch";
lab var a5_15_7 "Energy Cook:Solar panel";
lab var a5_15_8 "Energy Cook:Coal";
lab var a5_15_9 "Energy Cook:Gas";
lab var a5_15_10 "Energy Cook:Generator";
lab var a5_15_96 "Energy Cook:Other";

gen a6_03_1=a6_03==1;
replace a6_03_1=. if a6_03==.;
lab var a6_03_1 "HH owns land for residence";

gen a6_04n_1=a6_04n;
replace a6_04n_1=a6_04n*0.405 if a6_04u==2;
replace a6_04n_1=a6_04n*0.0001 if a6_04u==4;
lab var a6_04n_1 "Residence land size ha";

gen a6_05_1=a6_05==1;
replace a6_05_1=. if a6_05==.;
lab var a6_05_1 "HH owns other land";

gen a6_06n_1=a6_06n;
replace a6_06n_1=a6_06n*0.405 if a6_06u==2;
replace a6_06n_1=a6_06n*0.0001 if a6_06u==4;
lab var a6_06n_1 "Other land size ha";

gen a6_05_2=a6_03_1==1 | a6_05_1==1;
replace a6_05_2=. if a6_03_1==. & a6_05_1==.;
lab var a6_05_2 "HH owns land";

gen a6_06n_2=a6_04n_1+a6_06n_1;
replace a6_06n_2=. if a6_04n_1==. & a6_06n_1==.;
lab var a6_06n_2 "Size of land owned ha";

gen a6_08n_1=a6_08n;
replace a6_08n_1=a6_08n*0.405 if a6_08u==2;
replace a6_08n_1=a6_08n*0.0001 if a6_08u==4;
replace a6_08n_1=. if a6_08u==5 & a6_08n!=.;
replace a6_08n_1=0 if a6_08u==5 & a6_08n==0;
lab var a6_08n_1 "Land sold last 12m ha";

gen a6_09n_1=a6_09n;
replace a6_09n_1=a6_09n*0.405 if a6_09u==2;
replace a6_09n_1=a6_09n*0.0001 if a6_09u==4;
replace a6_09n_1=. if a6_09u==5 & a6_09n!=.;
replace a6_09n_1=0 if a6_09u==5 & a6_09n==0;
lab var a6_09n_1 "Land bought last 12m ha";

gen a6_10n_1=a6_10n;
replace a6_10n_1=a6_10n*0.405 if a6_10u==2;
replace a6_10n_1=a6_10n*0.0001 if a6_10u==4;
replace a6_10n_1=. if a6_10u==5 & a6_10n!=.;
replace a6_10n_1=0 if a6_10u==5 & a6_10n==0;
lab var a6_10n_1 "Land received last 12m ha";

gen a7_03_1=a7_03>a7_02 & a7_03!=. & a7_02!=.;
replace a7_03_1=. if a7_03==. | a7_02==.;
lab var a7_03_1 "HH worse off than last year";

gen a7_03_2=a7_03<a7_02 & a7_03!=. & a7_02!=.;
replace a7_03_2=. if a7_03==. | a7_02==.;
lab var a7_03_2 "HH better off than last year";

assert a7_03_1!=1 if a7_03_2==1;
assert a7_03_2!=1 if a7_03_1==1;

gen a7_04_1=a7_04 if a7_03_1==1;
replace a7_04_1=. if a7_04==.;
lab var a7_04_1 "Reason if worse off";

gen a7_04_2=a7_04 if a7_03_2==1;
replace a7_04_2=. if a7_04==.;
lab var a7_04_2 "Reason if better off";

forvalues v=1(1)11 {;
	gen a7_04_1_`v'=a7_04_1==`v';
	replace a7_04_1_`v'=. if a7_04_1==.;
	gen a7_04_2_`v'=a7_04_2==`v';
	replace a7_04_2_`v'=. if a7_04_2==.;
};
gen a7_04_1_96=a7_04_1==96;
replace a7_04_1_96=. if a7_04_1==.;
gen a7_04_2_96=a7_04_2==96;
replace a7_04_2_96=. if a7_04_2==.;
lab var a7_04_1_1 "Worse off:natural disaster";
lab var a7_04_1_2 "Worse off:weather";
lab var a7_04_1_3 "Worse off:bad economy";
lab var a7_04_1_4 "Worse off:investment";
lab var a7_04_1_5 "Worse off:govt support";
lab var a7_04_1_6 "Worse off:commu support";
lab var a7_04_1_7 "Worse off:relatives support";
lab var a7_04_1_8 "Worse off:health";
lab var a7_04_1_9 "Worse off:death";
lab var a7_04_1_10 "Worse off:new job";
lab var a7_04_1_11 "Worse off:robbed";
lab var a7_04_1_96 "Worse off:other";
lab var a7_04_2_1 "Better off:natural disaster";
lab var a7_04_2_2 "Better off:weather";
lab var a7_04_2_3 "Better off:bad economy";
lab var a7_04_2_4 "Better off:investment";
lab var a7_04_2_5 "Better off:govt support";
lab var a7_04_2_6 "Better off:commu support";
lab var a7_04_2_7 "Better off:relatives support";
lab var a7_04_2_8 "Better off:health";
lab var a7_04_2_9 "Better off:death";
lab var a7_04_2_10 "Better off:new job";
lab var a7_04_2_11 "Better off:robbed";
lab var a7_04_2_96 "Better off:other";

gen a9_01_1=a9_01==1 | a9_02==1;
replace a9_01_1=. if a9_01==. & a9_02==.;
lab var a9_01_1 "Death in household";

svyset [pweight=hhpweight], psu(hrbf_id1);
save $cleandatadir/rwhrbf_a00_withstudyarms_withvarformeantests.dta, replace;

log close;

	









	

	


