* Elisa Rothenbuhler - Jan 11

* This do-file:
* Obtains frequencies of different categories of household members (women, children under 5, etc.) by treatment group, based on $cleandatadir/rwhrbf_a01_withstudyarms_withvarformeantests.dta.
* Obtains frequencies of different age categories of household members, based on $cleandatadir/rwhrbf_a01_withstudyarms_withvarformeantests.dta.
* Obtains frequencies regarding asset ownership by treatment group, based on $cleandatadir/rwhrbf_a00_withstudyarms_withvarformeantests.dta.
* Obtains frequencies of different education levels of household members, including under 5 years old who are then classified as uneducated, based on $cleandatadir/rwhrbf_a02_withstudyarms_withvarformeantests.dta.

* These frequencies are obtained for comparison with DHS. They should be adapted depending on what national statistics will be compared to the RBF IE data.

* Tables obtained in text files should be opened in Excel (right click, open with: Excel) and used for reports or powerpoints.

version 10.0
clear
set more off
set mem 500m
cap log close

#delimit ;

log using $logdir/rwanda_an7_a01.log, replace;

cap erase $resultdir/women_per_group.txt;
cap erase $resultdir/women1549_per_group.txt;
cap erase $resultdir/childunder5_per_group.txt;
cap erase $resultdir/childunder1_per_group.txt;
cap erase $resultdir/childunder1_per_group_outof_childunder5.txt;
cap erase $resultdir/age_groups.txt;
cap erase $resultdir/asset_ownership.txt;
cap erase $resultdir/education.txt;

use $cleandatadir/rwhrbf_a01_withstudyarms_withvarformeantests.dta, clear;
preserve;

* Proportion of women in sample;
svy: tab group_code a1_02, obs;
mat A=e(Obs);
mat B=e(Prop)*100;
mat C=A[1..4,2],B[1..4,2];
svy: tab a1_02, obs;
mat D=e(Obs)';
mat E=(e(Prop)*100)';
mat F=D[1,2];
mat G=E[1,2];
mat women_per_group=C\F,G;
mat colnames women_per_group="Nr Obs" Frequency;
mat rownames women_per_group="Demand side" "Supply side" "Demand & Supply side" "Control" "TOTAL";
mat2txt, matrix(women_per_group) saving($resultdir/women_per_group.txt) append;
mat drop _all;

* Proportion of women 15-49 years old in sample;
gen a1_02_1549=a1_02==2 & a1_11a>=15 & a1_11a<=49;
replace a1_02_1549=. if a1_02>=. | a1_11a>=.;
svy: tab group_code a1_02_1549, obs;
mat A=e(Obs);
mat B=e(Prop)*100;
mat C=A[1..4,2],B[1..4,2];
svy: tab a1_02_1549, obs;
mat D=e(Obs)';
mat E=(e(Prop)*100)';
mat F=D[1,2];
mat G=E[1,2];
mat women1549_per_group=C\F,G;
mat colnames women1549_per_group="Nr Obs" Frequency;
mat rownames women1549_per_group="Demand side" "Supply side" "Demand & Supply side" "Control" "TOTAL";
mat2txt, matrix(women1549_per_group) saving($resultdir/women1549_per_group.txt) append;
mat drop _all;

* Proportion of children <5 years old;
gen a1_11a_5=a1_11a<5;
replace a1_11a_5=. if a1_11a>=.;
svy: tab group_code a1_11a_5, obs;
mat A=e(Obs);
mat B=e(Prop)*100;
mat C=A[1..4,2],B[1..4,2];
svy: tab a1_11a_5, obs;
mat D=e(Obs)';
mat E=(e(Prop)*100)';
mat F=D[1,2];
mat G=E[1,2];
mat childunder5_per_group=C\F,G;
mat colnames childunder5_per_group="Nr Obs" Frequency;
mat rownames childunder5_per_group="Demand side" "Supply side" "Demand & Supply side" "Control" "TOTAL";
mat2txt, matrix(childunder5_per_group) saving($resultdir/childunder5_per_group.txt) append;
mat drop _all;

* Proportion of children <1 year old (out of total sample);
gen a1_11a_1=a1_11a<1;
replace a1_11a_1=. if a1_11a>=.;
svy: tab group_code a1_11a_1, obs;
mat A=e(Obs);
mat B=e(Prop)*100;
mat C=A[1..4,2],B[1..4,2];
svy: tab a1_11a_1, obs;
mat D=e(Obs)';
mat E=(e(Prop)*100)';
mat F=D[1,2];
mat G=E[1,2];
mat childunder1_per_group=C\F,G;
mat colnames childunder1_per_group="Nr Obs" Frequency;
mat rownames childunder1_per_group="Demand side" "Supply side" "Demand & Supply side" "Control" "TOTAL";
mat2txt, matrix(childunder1_per_group) saving($resultdir/childunder1_per_group.txt) append;
mat drop _all;

* Proportion of children <1 year old (out of total number of children<5);
gen a1_11b_12=a1_11b<12;
replace a1_11b_12=. if a1_11b>=.;
svy: tab group_code a1_11b_12, obs;
mat A=e(Obs);
mat B=e(Prop)*100;
mat C=A[1..4,2],B[1..4,2];
svy: tab a1_11b_12, obs;
mat D=e(Obs)';
mat E=(e(Prop)*100)';
mat F=D[1,2];
mat G=E[1,2];
mat childunder1_outof_childunder5=C\F,G;
mat colnames childunder1_outof_childunder5="Nr Obs" Frequency;
mat rownames childunder1_outof_childunder5="Demand side" "Supply side" "Demand & Supply side" "Control" "TOTAL";
mat2txt, matrix(childunder1_outof_childunder5) saving($resultdir/childunder1_per_group_outof_childunder5.txt) append;
mat drop _all;

* Age categories (for comparison with DHS);
gen a1_11a_cat=.;
replace a1_11a_cat=1 if a1_11a<5;
replace a1_11a_cat=2 if a1_11a>=5 & a1_11a<10;
replace a1_11a_cat=3 if a1_11a>=10 & a1_11a<15;
replace a1_11a_cat=4 if a1_11a>=15 & a1_11a<20;
replace a1_11a_cat=5 if a1_11a>=20 & a1_11a<25;
replace a1_11a_cat=6 if a1_11a>=25 & a1_11a<30;
replace a1_11a_cat=7 if a1_11a>=30 & a1_11a<35;
replace a1_11a_cat=8 if a1_11a>=35 & a1_11a<40;
replace a1_11a_cat=9 if a1_11a>=40 & a1_11a<45;
replace a1_11a_cat=10 if a1_11a>=45 & a1_11a<50;
replace a1_11a_cat=11 if a1_11a>=50 & a1_11a<55;
replace a1_11a_cat=12 if a1_11a>=55 & a1_11a<60;
replace a1_11a_cat=13 if a1_11a>=60 & a1_11a<65;
replace a1_11a_cat=14 if a1_11a>=65 & a1_11a<70;
replace a1_11a_cat=15 if a1_11a>=70 & a1_11a<75;
replace a1_11a_cat=16 if a1_11a>=75 & a1_11a<80;
replace a1_11a_cat=17 if a1_11a>=80 & a1_11a<.;
svy: tab a1_11a_cat, obs;
mat age_groups=e(Obs),e(Prop)*100;
mat colnames age_groups="Nr Obs" Frequency;
mat rownames age_groups=0-4 5-9 10-14 15-19 20-24 25-29 30-34 35-39 40-44 45-49 50-54 55-59 60-64 65-69 70-74 75-79 80+;
mat2txt, matrix(age_groups) saving($resultdir/age_groups.txt) append;
mat drop _all;

restore;

use $cleandatadir/rwhrbf_a05_with_1obs_for_1hh_withstudyarms_withvarformeantests.dta, clear;
preserve;

* Frequency of asset ownership (for comparison with DHS);

gen a6_01_radio=.;
replace a6_01_radio=1 if a6_01_1>0 & a6_01_1<.;
replace a6_01_radio=0 if a6_01_1==0;
gen a6_01_tv=.;
replace a6_01_tv=1 if a6_01_2>0 & a6_01_2<.;
replace a6_01_tv=0 if a6_01_2==0;
gen a6_01_cell=.;
replace a6_01_cell=1 if a6_01_14>0 & a6_01_14<.;
replace a6_01_cell=0 if a6_01_14==0;
gen a6_01_landphone=.;
replace a6_01_landphone=1 if a6_01_13>0 & a6_01_13<.;
replace a6_01_landphone=0 if a6_01_13==0;
gen a6_01_refrig=.;
replace a6_01_refrig=1 if a6_01_9>0 & a6_01_9<.;
replace a6_01_refrig=0 if a6_01_9==0;
gen a6_01_bicycle=.;
replace a6_01_bicycle=1 if a6_01_16>0 & a6_01_16<.;
replace a6_01_bicycle=0 if a6_01_16==0;
gen a6_01_moto=.;
replace a6_01_moto=1 if a6_01_15>0 & a6_01_15<.;
replace a6_01_moto=0 if a6_01_15==0;
gen a6_01_car=.;
replace a6_01_car=1 if a6_01_17>0 & a6_01_17<.;
replace a6_01_car=0 if a6_01_17==0;
gen a6_01_none=.;
replace a6_01_none=1 if a6_01_1==0 & a6_01_2==0 & a6_01_14==0 & a6_01_13==0 & a6_01_9==0 & a6_01_16==0 & a6_01_15==0 & a6_01_17==0;
replace a6_01_none=0 if a6_01_1==1 | a6_01_2==1 | a6_01_14==1 | a6_01_13==1 | a6_01_9==1 | a6_01_16==1 | a6_01_15==1 | a6_01_17==1;

foreach var of varlist a6_01_radio a6_01_tv a6_01_cell a6_01_landphone a6_01_refrig a6_01_bicycle a6_01_moto a6_01_car a6_01_none {;
	svy:tab `var', obs;
	mat `var'=e(Obs),e(Prop)*100;
	mat `var'=`var'[2,1..2];
};
mat asset_ownership= a6_01_radio\a6_01_tv\a6_01_cell\a6_01_landphone\a6_01_refrig\a6_01_bicycle\a6_01_moto\a6_01_car\a6_01_none;
mat colnames asset_ownership="Nr Obs" Frequency;
mat rownames asset_ownership=Radio Television "Mobile phone" "Landline phone" Refrigerator Bicycle Motorcycle/Scooter Car/Truck None;
mat2txt, matrix(asset_ownership) saving($resultdir/asset_ownership.txt) append;
mat drop _all;

restore;

use $cleandatadir/rwhrbf_a02_withstudyarms_withvarformeantests.dta, clear;
preserve;

* Educational attainment: based on a2_09_ variables, but modifying a2_09_ to also include under 5 yeard old children as uneducated (for comparison with DHS);

gen a2_09_2_child=a2_09_2;
replace a2_09_2_child=1 if a1_11a<=5;
lab var a2_09_2_child "No school completed - under 5 included";
gen a2_09_3_child=a2_09_3;
replace a2_09_3_child=0 if a1_11a<=5;
lab var a2_09_3_child "<Primary completed - under 5 included";
gen a2_09_4_child=a2_09_4;
replace a2_09_4_child=0 if a1_11a<=5;
lab var a2_09_4_child "Primary completed - under 5 included";
gen a2_09_5_child=a2_09_5;
replace a2_09_5_child=0 if a1_11a<=5;
lab var a2_09_5_child ">Primary completed - under 5 included";

foreach var of varlist a2_09_2_child a2_09_3_child a2_09_4_child a2_09_5_child {;
	svy: regress `var';
	mat def `var'=el(e(b),1,1)*100;
};
mat education=a2_09_2_child\a2_09_3_child\a2_09_4_child\a2_09_5_child;
mat colnames education=Frequency;
mat rownames education="No education" Primary "Primary complete" >Primary;
mat2txt, matrix(education) saving($resultdir/education.txt) append;
mat drop _all;

restore;
log close;
