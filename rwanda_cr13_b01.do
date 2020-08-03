* Elisa Rothenbuhler - Sep 10

* This do-file:
* Creates clean female b01 dataset: $cleandatadir/rwhrbf_b01.dta.
* Merges $cleandatadir/rwhrbf_b01.dta with household roster.
* Generates appropriate variables for mean tests.


version 10.0
clear
set more off
set mem 500m
cap log close

#delimit ;

log using $logdir/rwanda_cr13_b01.log, replace;



*********************
*** Clean b01 section
*********************;

use $origdatadir/RWHRBF_B_FEMALE-01.dta, clear;
drop if b10_00==. & b10_01==. & b10_02==. & b10_03==. & b10_04==. & b10_05a==. & b10_05b==. & b10_05c==. & b10_06a==. & b10_06u==. & b10_07a==. & b10_07u==. & b10_08==. & b10_44==.;
duplicates tag hrbf_id1 hrbf_id2 b10_pid, gen(dupl);
list hrbf_id1 hrbf_id2 b10_pid b10_00 b10_01 if dupl!=0;
replace b10_pid=2 if hrbf_id1==182 & hrbf_id2==2 & b10_pid==. & b10_00==1 & b10_01==4;
replace b10_pid=5 if hrbf_id1==182 & hrbf_id2==2 & b10_pid==. & b10_00==1 & b10_01==1;
replace b10_pid=6 if hrbf_id1==182 & hrbf_id2==2 & b10_pid==. & b10_00==2;
duplicates report hrbf_id1 hrbf_id2 b10_pid;
drop dupl;
replace b10_00=2 if b10_00==3;
replace b10_02=. if b10_02==4;
replace b10_05b=. if b10_05b==0;
replace b10_05c=. if b10_05c==0;
replace b10_06a=. if b10_06a==96;
tab b10_44;
replace b10_44=12 if b10_44==120;
replace b10_44=21 if b10_44==210;
replace b10_44=. if b10_44==96;
replace b10_44=7 if b10_44==70;
replace b10_44=6 if b10_44==60;
replace b10_44=28 if b10_44>28;

sort hrbf_id1 hrbf_id2 b10_pid;
save $cleandatadir/rwhrbf_b01.dta, replace;



************************************
*** Create rwhrbf_b01_with_studyarms
************************************;

ren b10_pid a1_pid;
save $tempdatadir/rwhrbf_b01.dta, replace;

use $cleandatadir/rwhrbf_household_roster.dta, clear;
merge hrbf_id1 hrbf_id2 a1_pid using $tempdatadir/rwhrbf_b01.dta, unique;
tab _merge;
list hrbf_id1 hrbf_id2 a1_pid a1_02 if _merge==2;
drop if _merge==2;
drop _merge;
save $cleandatadir/rwhrbf_b01_withstudyarms.dta, replace;



*********************************************
*** Create necessary variables for mean tests
*********************************************;

gen b10_00_1=b10_00==1;
replace b10_00_1=. if b10_00==.;
lab var b10_00_1 "Present for interview";

forvalues v=1(1)4 {;
	gen b10_01_`v'=b10_01==`v';
	replace b10_01_`v'=. if b10_01==.;
};
lab var b10_01_1 "Excellent health 12m ago";
lab var b10_01_2 "Good health 12m ago";
lab var b10_01_3 "Fair health 12m ago";
lab var b10_01_4 "Poor health 12m ago";

forvalues v=1(1)3 {;
	gen b10_02_`v'=b10_02==`v';
	replace b10_02_`v'=. if b10_02==.;
};
lab var b10_02_1 "Better health today";
lab var b10_02_2 "Worse health today";
lab var b10_02_3 "Same health today";

forvalues v=1(1)4 {;
	gen b10_03_`v'=b10_03==`v';
	replace b10_03_`v'=. if b10_03==.;
};
lab var b10_03_1 "Daily act easily";
lab var b10_03_2 "Daily act w/some diffic";
lab var b10_03_3 "Daily act w/much diffic";
lab var b10_03_4 "Daily act w/same diffic";

gen b10_04_1=b10_04==1;
replace b10_04_1=. if b10_04==.;
lab var b10_04_1 "Sick in past 4weeks";

* assert b10_05a!=. if b10_04==1;
replace b10_05a=96 if b10_04==1 & b10_05a==.;
gen b10_05b_100=b10_05b!=. & b10_04==1;
replace b10_05b_100=. if b10_04==.;
gen b10_05c_100=b10_05c!=. & b10_04==1;
replace b10_05c_100=. if b10_04==.;
lab var b10_05b_100 "Had at least 2 diseases if sick";
lab var b10_05c_100 "Had at least 3 diseases if sick";

tab b10_05b_100;
tab b10_05c_100;


forvalues v=1(1)19 {;
	gen b10_05a_`v'=b10_05a==`v';
	replace b10_05a_`v'=. if b10_05a==.;
};
gen b10_05a_96=b10_05a==96;
replace b10_05a_96=. if b10_05a==.;
lab var b10_05a_1 "Fever/malaria";
lab var b10_05a_2 "Cough/chest infection";
lab var b10_05a_3 "TB";
lab var b10_05a_4 "Asthma";
lab var b10_05a_6 "Pneumonia";
lab var b10_05a_7 "Diarrhea w\blood";
lab var b10_05a_8 "Diarrhea w/blood";
lab var b10_05a_9 "Diarrhea & vomiting";
lab var b10_05a_10 "Vomiting";
lab var b10_05a_11 "Abdominal pain";
lab var b10_05a_12 "Anemia";
lab var b10_05a_13 "Skin rash/infection";
lab var b10_05a_14 "Eye/Ear infection";
lab var b10_05a_15 "Measles";
lab var b10_05a_16 "Jaundice";
lab var b10_05a_17 "Convulsions";
lab var b10_05a_18 "Sore throat";
lab var b10_05a_19 "Accident/injuries";
lab var b10_05a_96 "Other";

forvalues v=1(1)19 {;
	gen b10_05b_`v'=b10_05b==`v';
	replace b10_05b_`v'=. if b10_05b==.;
};
gen b10_05b_96=b10_05b==96;
replace b10_05b_96=. if b10_05b==.;
lab var b10_05b_1 "Fever/malaria";
lab var b10_05b_2 "Cough/chest infection";
lab var b10_05b_3 "TB";
lab var b10_05b_4 "Asthma";
lab var b10_05b_6 "Pneumonia";
lab var b10_05b_7 "Diarrhea w\blood";
lab var b10_05b_8 "Diarrhea w/blood";
lab var b10_05b_9 "Diarrhea & vomiting";
lab var b10_05b_10 "Vomiting";
lab var b10_05b_11 "Abdominal pain";
lab var b10_05b_12 "Anemia";
lab var b10_05b_13 "Skin rash/infection";
lab var b10_05b_14 "Eye/Ear infection";
lab var b10_05b_15 "Measles";
lab var b10_05b_16 "Jaundice";
lab var b10_05b_17 "Convulsions";
lab var b10_05b_18 "Sore throat";
lab var b10_05b_19 "Accident/injuries";
lab var b10_05b_96 "Other";

forvalues v=1(1)19 {;
	gen b10_05c_`v'=b10_05c==`v';
	replace b10_05c_`v'=. if b10_05c==.;
};
gen b10_05c_96=b10_05c==96;
replace b10_05c_96=. if b10_05c==.;
lab var b10_05c_1 "Fever/malaria";
lab var b10_05c_2 "Cough/chest infection";
lab var b10_05c_3 "TB";
lab var b10_05c_4 "Asthma";
lab var b10_05c_6 "Pneumonia";
lab var b10_05c_7 "Diarrhea w\blood";
lab var b10_05c_8 "Diarrhea w/blood";
lab var b10_05c_9 "Diarrhea & vomiting";
lab var b10_05c_10 "Vomiting";
lab var b10_05c_11 "Abdominal pain";
lab var b10_05c_12 "Anemia";
lab var b10_05c_13 "Skin rash/infection";
lab var b10_05c_14 "Eye/Ear infection";
lab var b10_05c_15 "Measles";
lab var b10_05c_16 "Jaundice";
lab var b10_05c_17 "Convulsions";
lab var b10_05c_18 "Sore throat";
lab var b10_05c_19 "Accident/injuries";
lab var b10_05c_96 "Other";

gen b10_06a_1=b10_06a;
replace b10_06a_1=b10_06a*7 if b10_06u==2;
replace b10_06a_1=b10_06a*30 if b10_06u==3;
lab var b10_06a_1 "Nr days ago illness started";

gen b10_07a_1=b10_07a==3;
replace b10_07a_1=. if b10_07a==.;
lab var b10_07a_1 "Still sick";

gen b10_07a_2=b10_07a!=3;
replace b10_07a_2=. if b10_07a==.;
lab var b10_07a_2 "Not sick anymore";

gen b10_07a_3=b10_07a if b10_07a!=3;
replace b10_07a_3=b10_07a*7 if b10_07u==2;
lab var b10_07a_3 "Nr days ago illness stopped";
* assert b10_07a_3<=b10_06a_1 if b10_07a_3!=. & b10_06a_1!=.;
replace b10_07a_3=. if b10_07a_3>b10_06a_1 & b10_07a_3!=. & b10_06a_1!=.;
replace b10_06a_1=. if b10_07a_3>b10_06a_1 & b10_07a_3!=. & b10_06a_1!=.;

gen b10_07a_4=b10_06a_1 - b10_07a_3 if b10_07a!=3 & b10_07a_3!=. & b10_06a_1!=.;
lab var b10_07a_4 "Nr days of illness if over";

tab b10_06a_1;
tab b10_07a_1;
tab b10_07a_2;
tab b10_07a_3;
tab b10_07a_4;
tab b10_07a_4 b10_07a_1;
tab b10_07a_4 b10_07a_2;

gen b10_08_1=b10_08==1;
replace b10_08_1=. if b10_08==.;
lab var b10_08_1 "Consulted health staff";

svyset [pweight=hhpweight], psu(hrbf_id1);
save $cleandatadir/rwhrbf_b01_withstudyarms_withvarformeantests.dta, replace;

log close;




