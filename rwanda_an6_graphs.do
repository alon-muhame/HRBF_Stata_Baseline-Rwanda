* Elisa Rothenbuhler - Nov 10

* This do-file creates graphs of potential interest to be inserted in household baseline data report and/or presentations.


version 10.0
clear
set more off
set mem 500m
cap log close

#delimit ;

log using $logdir/rwanda_an6_graphs.log, replace;

set scheme s2color;
cd $graphresultdir;
* set graphics off;


*************************************************************************************************
****************************** Main Household Questionnaire *************************************
*************************************************************************************************;



*******************************
*** Section 1: Household roster
*******************************;

use $cleandatadir/rwhrbf_a01_withstudyarms_withvarformeantests.dta, clear;
preserve;
replace a1_12=7 if a1_12==96;
lab define group_code_lab 1 "Demand" 2 "Supply" 3 "Demand & Supply" 4 "Control";
lab values group_code group_code_lab;

graph pie [pweight=hhpweight], over(a1_12) sort title("Distribution of Marital Status", span);
graph export a01_marital_status_1, as(pdf) replace;
graph pie [pweight=hhpweight], over(a1_12) sort title("Distribution of Marital Status", span) pie(_all,explode);
graph export a01_marital_status_2, as(pdf) replace;
* hist a1_12, discrete percent title("Distribution of Marital Status", span) xlabel(1 "Never married" 2 "Married/Civil union monogamous" 3 "Married polygamous" 4 "Cohabitating" 5 "Divorced/Separated" 6 "Widowed" 7 "Other", angle(45));
* No pweight allowed with hist;
* graph export a01_marital_status_3, as(pdf) replace;
* hist a1_12, discrete percent title("Distribution of Marital Status by treatment group", span) xlabel(1 "Never married" 2 "Married/Civil union monogamous" 3 "Married polygamous" 4 "Cohabitating" 5 "Divorced/Separated" 6 "Widowed" 7 "Other", angle(45)) by(group_code);
* graph export a01_marital_status_4, as(pdf) replace;

* graph hbar a1_hhsize [pweight=hhpweight], over(group_code) title("Average Size of Household", span); 
graph dot a1_hhsize [pweight=hhpweight], over(group_code) title("Average Size of Household", span);
graph export a01_hh_size_1, as(pdf) replace;

* hist a1_11a, percent title("Age Distribution", span);
* graph export a01_age_1, as(pdf) replace;
* hist a1_11a, percent by(a1_02, title("Age Distribution by gender", span));
* graph export a01_age_2, as(pdf) replace;
* hist a1_11a, percent by(group_code, title("Age Distribution by treatment group", span));
* graph export a01_age_3, as(pdf) replace;

* hist a1_11b, percent title("Age Distribution for under-5 year olds", span);
* graph export a01_age_4, as(pdf) replace;
* hist a1_11b, percent by(a1_02, title("Age Distribution by gender for under-5 year olds", span));
* graph export a01_age_5, as(pdf) replace;
* hist a1_11b, percent by(group_code, title("Age Distribution by treatment group for under-5 year olds", span));
* graph export a01_age_6, as(pdf) replace;

graph pie [pweight=hhpweight], over(a1_16) sort title("Religious Distribution", span);
graph export a01_religion_1, as(pdf) replace;
graph pie [pweight=hhpweight], over(a1_16) sort title("Religious Distribution", span) pie(_all,explode);
graph export a01_religion_2, as(pdf) replace;

graph dot a1_20_01 [pweight=hhpweight], over(group_code) title("Mutual insurance coverage by treatment group", span) ytitle("Proportion Currently covered by mutuelle");
graph export a01_mutuelle_1, as(pdf) replace;

* hist a1_02, percent discrete xlabel(1 "Male" 2 "Female") width (.1) title("Gender distribution", span);
* graph export a01_gender_1, as(pdf) replace;
* hist a1_02, percent discrete xlabel(1 "Male" 2 "Female") by(group_code, title("Gender distribution by treatment group", span));
* graph export a01_gender_2, as(pdf) replace;

restore;


************************
*** Section 2: Education
************************;

use $cleandatadir/rwhrbf_a02_withstudyarms_withvarformeantests.dta, clear;
preserve;
keep if a1_11a>4;
lab define group_code_lab 1 "Demand" 2 "Supply" 3 "Demand & Supply" 4 "Control";
lab values group_code group_code_lab;

graph pie a2_07_01 a2_07_02 a2_07_03 a2_07_04 a2_07_05 a2_07_06 a2_07_07 a2_07_08 a2_07_09 a2_07_10 a2_07_11 a2_07_12 a2_07_13 a2_07_14 a2_07_96 [pweight=hhpweight], sort title("Main reason for absence from school - 5-year olds and older", span);
graph export a02_school_1, as(pdf) replace;

graph bar a2_09_2 a2_09_3 a2_09_4 a2_09_5 [pweight=hhpweight], legend(label(1 "No school completed") label(2 "<Primary completed") label(3 "Primary completed") label(4 ">Primary completed") rows(4)) title("Distribution of the levels of education", span);
graph export a02_school_2, as(pdf) replace;
graph bar a2_09_2 a2_09_3 a2_09_4 a2_09_5 [pweight=hhpweight], legend(label(1 "No school completed") label(2 "<Primary completed") label(3 "Primary completed") label(4 ">Primary completed") rows(4)) title("Distribution of the levels of education", span) stack;
graph export a02_school_3, as(pdf) replace;
graph bar a2_09_2 a2_09_3 a2_09_4 a2_09_5 [pweight=hhpweight], legend(label(1 "No school completed") label(2 "<Primary completed") label(3 "Primary completed") label(4 ">Primary completed") rows(4)) title("Distribution of the levels of education", span) over(group_code);
graph export a02_school_4, as(pdf) replace;
graph bar a2_09_2 a2_09_3 a2_09_4 a2_09_5 [pweight=hhpweight], legend(label(1 "No school completed") label(2 "<Primary completed") label(3 "Primary completed") label(4 ">Primary completed") rows(4)) title("Distribution of the levels of education", span) stack over(group_code);
graph export a02_school_5, as(pdf) replace;

lab var a2_10a "School"; 
lab var a2_10b "Studying"; 
lab var a2_10c "Child care"; 
lab var a2_10d "Sick relative care"; 
lab var a2_10e "Housework"; 
lab var a2_10f "Work for income"; 
lab var a2_10g "Recreation";

graph pie a2_10a a2_10b a2_10c a2_10d a2_10e a2_10f a2_10g [pweight=hhpweight], sort title("Hours spent in various activities in last 7 days - 5-year olds and older", size(medsmall) span);
graph export a02_time_use_1, as(pdf) replace;
graph pie a2_10a a2_10b a2_10c a2_10d a2_10e a2_10f a2_10g if a1_02==2 [pweight=hhpweight], sort title("Hours spent in various activities in last 7 days - Women 5 year old and older", size(medsmall) span);
graph export a02_time_use_2, as(pdf) replace;
graph pie a2_10a a2_10b a2_10c a2_10d a2_10e a2_10f a2_10g if a1_15_mother==1 [pweight=hhpweight], sort title("Hours spent in various activities in last 7 days - Mother of youngest child", size(medsmall) span);
graph export a02_time_use_3, as(pdf) replace;
graph pie a2_10a a2_10b a2_10c a2_10d a2_10e a2_10f a2_10g if a1_11a<=12 [pweight=hhpweight], sort title("Hours spent in various activities in last 7 days - Children 5-12", size(medsmall) span);
graph export a02_time_use_4, as(pdf) replace;
graph pie a2_10a a2_10b a2_10c a2_10d a2_10e a2_10f a2_10g if a1_11a<=12 & a1_02==2 [pweight=hhpweight], sort title("Hours spent in various activities in last 7 days - Girls 5-12", size(medsmall) span);
graph export a02_time_use_5, as(pdf) replace;
graph pie a2_10a a2_10b a2_10c a2_10d a2_10e a2_10f a2_10g [pweight=hhpweight], sort by(group_code, title("Hours spent in various activities in last 7 days per treatment group - 5-year olds and older", size(small) span)) legend(size(small));
graph export a02_time_use_6, as(pdf) replace;

restore;


********************
*** Section 3: Labor
********************;

use $cleandatadir/rwhrbf_a03_withstudyarms_withvarformeantests.dta, clear;
preserve;
keep if a1_11a>11;
lab define group_code_lab 1 "Demand" 2 "Supply" 3 "Demand & Supply" 4 "Control";
lab values group_code group_code_lab;

graph pie [pweight=hhpweight], over(a3_01) sort title("Main economic activity in last 12 months (12y and older)", span);
graph export a03_eco_activity_1, as(pdf) replace;
* graph pie [pweight=hhpweight], over(a3_03) sort by(group_code, title("Main employer in last 12 months by treatment group (12y and older)", span)) legend(size(vsmall));
* too many subcategories to draw graph;

graph pie [pweight=hhpweight], over(a3_03) sort title("Main employer in last 12 months (12y and older)", span);
graph export a03_employer_1, as(pdf) replace;
graph pie [pweight=hhpweight], over(a3_03) sort by(group_code, title("Main employer in last 12 months by treatment group (12y and older)", size(medsmall) span)) legend(size(vsmall));
graph export a03_employer_2, as(pdf) replace;

graph dot a3_04_1 [pweight=hhpweight], over(group_code) title("Daily pay in primary activity in last 12m in RWF by treatment group (12y and older)", size(medsmall) span) ytitle("Daily pay in RWF");
graph export a03_daily_pay_prim_1, as(pdf) replace;

* hist a3_05a_1, percent discrete xlabel(0 "No insurance" 1 "Insurance") by(group_code, title("Distribution of the reception of insurance compensation for primary work", size(medsmall) span) subtitle("in last 12m by treatment group (12y and older)", size(medsmall) span));
* graph export a03_compensation_prim_1, as(pdf) replace;

* hist a3_05b_1, percent discrete xlabel(0 "No sick leave" 1 "Sick leave") by(group_code, title("Distributuon of the reception of sick leave for primary work", size(medsmall) span) subtitle("in last 12m by treatment group (12y and older)", size(small) span));
* graph export a03_compensation_prim_2, as(pdf) replace;

graph dot a3_06_1 [pweight=hhpweight], over(group_code) title("Weekly hours in primary activity by treatment group in last 12m (12y and older)", size(medsmall) span) ytitle("Hours per week");
graph export a03_hours_prim_1, as(pdf) replace;

graph dot a3_07_1 [pweight=hhpweight], over(group_code) title("Weekly hours in primary activity by treatment group in last week (12y and older)", size(medsmall) span) ytitle("Hours per week");
graph export a03_hours_prim_2, as(pdf) replace;

graph pie [pweight=hhpweight], over(a3_08) sort title("Reason for working less than usual in last week in primary activity", size(medsmall) span) subtitle("12y and older", size(medsmall) span);
graph export a03_reason_leave_prim_1, as(pdf) replace;
graph pie [pweight=hhpweight], over(a3_08) sort by(group_code, title("Reason for working less than usual in last week in primary activity", size(medsmall) span) subtitle("12y and older", size(medsmall) span)) legend(size(vsmall));
graph export a03_reason_leave_prim_2, as(pdf) replace;

* hist a3_10_1, percent discrete xlabel(0 "No other act." 1 "Secondary act.") by(group_code, title("Secondary activity distribution by treatment group", span) subtitle("12y and older", span));
* graph export a03_reason_leave_prim_1, as(pdf) replace;

graph dot a3_11_1 [pweight=hhpweight], over(group_code) title("Daily pay in secondary activity in last 12m in RWF by treatment group", size(medsmall) span) subtitle("12y and older", size(medsmall) span) ytitle("Daily pay in RWF");
graph export a03_daily_pay_sec_1, as(pdf) replace;

* hist a3_12a_1, percent discrete xlabel(0 "No insurance" 1 "Insurance") by(group_code, title("Distribution of the reception of insurance compensation for secondary work", size(medsmall) span) subtitle("in last 12m by treatment group (12y and older)", size(medsmall) span));
* graph export a03_compensation_sec_1, as(pdf) replace;

* hist a3_12b_1, percent discrete xlabel(0 "No sick leave" 1 "Sick leave") by(group_code, title("Distributuon of the reception of sick leave for secondary work", size(medsmall) span) subtitle("in last 12m by treatment group (12y and older)", size(small) span));
* graph export a03_compensation_sec_2, as(pdf) replace;

graph dot a3_13_1 [pweight=hhpweight], over(group_code) title("Weekly hours in secondary activity by treatment group in last 12m", size(medsmall) span) subtitle("12y and older", size(medsmall) span) ytitle("Hours per week");
graph export a03_hours_sec_1, as(pdf) replace;

graph dot a3_14_1 [pweight=hhpweight], over(group_code) title("Weekly hours in secondary activity by treatment group in last week", size(medsmall) span) subtitle("12y and older", size(medsmall) span) ytitle("Hours per week");
graph export a03_hours_sec_2, as(pdf) replace;

graph pie [pweight=hhpweight], over(a3_15) sort title("Reason for working less than usual in last week in secondary activity", size(medsmall) span) subtitle("12y and older", size(medsmall) span);
graph export a03_reason_leave_sec_1, as(pdf) replace;
graph pie [pweight=hhpweight], over(a3_15) sort by(group_code, title("Reason for working less than usual in last week in secondary activity", size(medsmall) span) subtitle("12y and older", size(medsmall) span)) legend(size(vsmall));
graph export a03_reason_leave_sec_2, as(pdf) replace;

restore;


*******************************************
*** Sections 4.2 and 13.4: Health knowledge
*******************************************;

use $cleandatadir/rwhrbf_a04_b08_withstudyarms_withvarformeantests.dta, clear;
preserve;
keep if a1_11a>=15 & a1_11a<=49;
lab define group_code_lab 1 "Demand" 2 "Supply" 3 "Demand & Supply" 4 "Control";
lab values group_code group_code_lab;

graph dot a4_healthscore [pweight=hhpweight], over(group_code) title("Health knowledge 0-1 score by treatment group", span) subtitle("15-49 years old", span) ytitle("0 to 1 Health knowledge score");
graph export a04_b08__healthscore_1, as(pdf) replace;
graph dot a4_healthscore [pweight=hhpweight], over(a1_02) over(group_code) title("Health knowledge 0-1 score by treatment group and gender", span) subtitle("15-49 years old", span) ytitle("0 to 1 Health knowledge score");
graph export a04_b08_healthscore_2, as(pdf) replace;

graph bar a4_10a_1 a4_10b_1 a4_10c_1 a4_10d_1 [pweight=hhpweight], title("Distribution of correct answers on why to wash hands", size(medsmall) span) subtitle("15-49 years old", size(medsmall) span) legend(label(1 "Removes dirt from hands=yes") label(2 "Prevents HIV=no") label(3 "Avoids spread infectious diseases=yes") label(4 "Prevents skin infections=yes") rows(4));
graph export a04_b08_wash_hands_1, as(pdf) replace;
graph bar a4_11a_1 a4_11b_1 a4_11c_1 a4_11d_1 [pweight=hhpweight], title("Distribution of correct answers on what kind of water to drink", size(medsmall) span) subtitle("15-49 years old", size(medsmall) span) legend(label(1 "Treated water near animals=no") label(2 "Treated stagnate water=no") label(3 "Treated water from spring or deep well=yes") label(4 "Treated water in streams or rivers=no") rows(4));
graph export a04_b08_water_1, as(pdf) replace;
graph bar a4_12a_1 a4_12b_1 a4_12c_1 a4_12d_1 a4_12e_1 [pweight=hhpweight], title("Distribution of correct answers on what to give to one 1/2 year old for watery diarrhea without dehydration", size(small) span) subtitle("15-49 years old", size(small) span) legend(label(1 "1 liter ORT a day=no") label(2 "3-4 glasses a day ORT=no") label(3 "1/4th-1/2 cup ORt for every watery stool=yes") label(4 "1 liter water per day only=no") label(5 "Other=no") rows(5)); 
graph export a04_b08_diarrhea_1, as(pdf) replace;
graph bar a4_13a_1 a4_13b_1 a4_13c_1 a4_13d_1 [pweight=hhpweight], title("Distribution of correct answers on dangerous signs for pregnant woman", size(medsmall) span) subtitle("15-49 years old", size(medsmall) span) legend(label(1 "Fever=yes") label(2 "Vaginal bleeding=yes") label(3 "Swelling of hands, face and feet=yes") label(4 "Loss of appetite=no") rows(4)); 
graph export a04_b08_pregnancy_1, as(pdf) replace;
graph bar a4_14a_1 a4_14b_1 a4_14c_1 a4_14d_1 [pweight=hhpweight], title("Distribution of correct answers on dangerous signs for baby", size(medsmall) span) subtitle("15-49 years old", size(medsmall) span) legend(label(1 "Baby convulsing=yes") label(2 "Baby has fever=yes") label(3 "Baby not breasfeeding=yes") label(4 "Baby breathing too quickly=yes") rows(4)); 
graph export a04_b08_baby_1, as(pdf) replace;
graph bar a4_15a_1 a4_15b_1 a4_15c_1 a4_15d_1 a4_15e_1 [pweight=hhpweight], title("Distribution of correct answers on which disease can be prevented by vaccine", size(medsmall) span) subtitle("15-49 years old", size(medsmall) span) legend(label(1 "Poliomyelitis=yes") label(2 "Measles=yes") label(3 "Tetanus=yes") label(4 "Tuberculosis=yes") label(5 "AIDS=no") rows(5)); 
graph export a04_b08_vaccine_1, as(pdf) replace;
graph bar a4_16a_1 a4_16b_1 a4_16c_1 a4_16d_1 a4_16e_1 [pweight=hhpweight], title("Distribution of correct answers on effective methods of contraception", size(medsmall) span) subtitle("15-49 years old", size(medsmall) span) legend(label(1 "Oral contraceptives=yes") label(2 "Depoprovera injection (DMPA)=yes") label(3 "IUD=yes") label(4 "Breastfeeding=no") label(5 "Withdrawal=no") rows(5));
graph export a04_b08_contraception_1, as(pdf) replace;

graph bar a4_10a_1 a4_10b_1 a4_10c_1 a4_10d_1 [pweight=hhpweight], title("Distribution of correct answers on why to wash hands by treatment group", size(medsmall) span) subtitle("15-49 years old", size(medsmall) span) legend(label(1 "Removes dirt from hands=yes") label(2 "Prevents HIV=no") label(3 "Avoids spread infectious diseases=yes") label(4 "Prevents skin infections=yes") rows(4)) over(group_code);
graph export a04_b08_wash_hands_2, as(pdf) replace;
graph bar a4_11a_1 a4_11b_1 a4_11c_1 a4_11d_1 [pweight=hhpweight], title("Distribution of correct answers on what kind of water to drink by treatment group", size(small) span) subtitle("15-49 years old", size(small) span) legend(label(1 "Treated water near animals=no") label(2 "Treated stagnate water=no") label(3 "Treated water from spring or deep well=yes") label(4 "Treated water in streams or rivers=no") rows(4)) over(group_code);
graph export a04_b08_water_2, as(pdf) replace;
graph bar a4_12a_1 a4_12b_1 a4_12c_1 a4_12d_1 a4_12e_1 [pweight=hhpweight], title("Distribution of correct answers on what to give to one 1/2 year old for watery diarrhea without dehydration", size(small) span) subtitle(" by treatment group - 15-49 years old", size(small) span) legend(label(1 "1 liter ORT a day=no") label(2 "3-4 glasses a day ORT=no") label(3 "1/4th-1/2 cup ORt for every watery stool=yes") label(4 "1 liter water per day only=no") label(5 "Other=no") rows(5)) over(group_code); 
graph export a04_b08_diarrhea_2, as(pdf) replace;
graph bar a4_13a_1 a4_13b_1 a4_13c_1 a4_13d_1 [pweight=hhpweight], title("Distribution of correct answers on dangerous signs for pregnant woman by treatment group", size(small) span) subtitle("15-49 years old", size(small) span) legend(label(1 "Fever=yes") label(2 "Vaginal bleeding=yes") label(3 "Swelling of hands, face and feet=yes") label(4 "Loss of appetite=no") rows(4)) over(group_code); 
graph export a04_b08_pregnancy_2, as(pdf) replace;
graph bar a4_14a_1 a4_14b_1 a4_14c_1 a4_14d_1 [pweight=hhpweight], title("Distribution of correct answers on dangerous signs for baby by treatment group", size(small) span) subtitle("15-49 years old", size(small) span) legend(label(1 "Baby convulsing=yes") label(2 "Baby has fever=yes") label(3 "Baby not breasfeeding=yes") label(4 "Baby breathing too quickly=yes") rows(4)) over(group_code); 
graph export a04_b08_baby_2, as(pdf) replace;
graph bar a4_15a_1 a4_15b_1 a4_15c_1 a4_15d_1 a4_15e_1 [pweight=hhpweight], title("Distribution of correct answers on which disease can be prevented by vaccine by treatment group", size(small) span) subtitle("15-49 years old", size(small) span) legend(label(1 "Poliomyelitis=yes") label(2 "Measles=yes") label(3 "Tetanus=yes") label(4 "Tuberculosis=yes") label(5 "AIDS=no") rows(5)) over(group_code); 
graph export a04_b08_vaccine_2, as(pdf) replace;
graph bar a4_16a_1 a4_16b_1 a4_16c_1 a4_16d_1 a4_16e_1 [pweight=hhpweight], title("Distribution of correct answers on effective methods of contraception by treatment group", size(small) span) subtitle("15-49 years old", size(small) span) legend(label(1 "Oral contraceptives=yes") label(2 "Depoprovera injection (DMPA)=yes") label(3 "IUD=yes") label(4 "Breastfeeding=no") label(5 "Withdrawal=no") rows(5)) over(group_code);
graph export a04_b08_contraception_2, as(pdf) replace;

graph bar a4_10a_1 a4_10b_1 a4_10c_1 a4_10d_1 [pweight=hhpweight], title("Distribution of correct answers on why to wash hands by treatment group and gender", size(small) span) subtitle("15-49 years old", size(small) span) legend(label(1 "Removes dirt from hands=yes") label(2 "Prevents HIV=no") label(3 "Avoids spread infectious diseases=yes") label(4 "Prevents skin infections=yes") rows(4)) over(a1_02) over(group_code);
graph export a04_b08_wash_hands_3, as(pdf) replace;
graph bar a4_11a_1 a4_11b_1 a4_11c_1 a4_11d_1 [pweight=hhpweight], title("Distribution of correct answers on what kind of water to drink by treatment group and gender", size(small) span) subtitle("15-49 years old", size(small) span) legend(label(1 "Treated water near animals=no") label(2 "Treated stagnate water=no") label(3 "Treated water from spring or deep well=yes") label(4 "Treated water in streams or rivers=no") rows(4)) over(a1_02) over(group_code);
graph export a04_b08_water_3, as(pdf) replace;
graph bar a4_12a_1 a4_12b_1 a4_12c_1 a4_12d_1 a4_12e_1 [pweight=hhpweight], title("Distribution of correct answers on what to give to one 1/2 year old for watery diarrhea without dehydration", size(small) span) subtitle(" by treatment group and gender - 15-49 years old", size(small) span) legend(label(1 "1 liter ORT a day=no") label(2 "3-4 glasses a day ORT=no") label(3 "1/4th-1/2 cup ORt for every watery stool=yes") label(4 "1 liter water per day only=no") label(5 "Other=no") rows(5)) over(a1_02) over(group_code); 
graph export a04_b08_diarrhea_3, as(pdf) replace;
graph bar a4_13a_1 a4_13b_1 a4_13c_1 a4_13d_1 [pweight=hhpweight], title("Distribution of correct answers on dangerous signs for pregnant woman by treatment group and gender", size(small) span) subtitle("15-49 years old", size(small) span) legend(label(1 "Fever=yes") label(2 "Vaginal bleeding=yes") label(3 "Swelling of hands, face and feet=yes") label(4 "Loss of appetite=no") rows(4)) over(a1_02) over(group_code); 
graph export a04_b08_pregnancy_3, as(pdf) replace;
graph bar a4_14a_1 a4_14b_1 a4_14c_1 a4_14d_1 [pweight=hhpweight], title("Distribution of correct answers on dangerous signs for baby by treatment group and gender", size(small) span) subtitle("15-49 years old", size(small) span) legend(label(1 "Baby convulsing=yes") label(2 "Baby has fever=yes") label(3 "Baby not breasfeeding=yes") label(4 "Baby breathing too quickly=yes") rows(4)) over(a1_02) over(group_code); 
graph export a04_b08_baby_3, as(pdf) replace;
graph bar a4_15a_1 a4_15b_1 a4_15c_1 a4_15d_1 a4_15e_1 [pweight=hhpweight], title("Distribution of correct answers on which disease can be prevented by vaccine by treatment group and gender", size(small) span) subtitle("15-49 years old", size(small) span) legend(label(1 "Poliomyelitis=yes") label(2 "Measles=yes") label(3 "Tetanus=yes") label(4 "Tuberculosis=yes") label(5 "AIDS=no") rows(5)) over(a1_02) over(group_code); 
graph export a04_b08_vaccine_3, as(pdf) replace;
graph bar a4_16a_1 a4_16b_1 a4_16c_1 a4_16d_1 a4_16e_1 [pweight=hhpweight], title("Distribution of correct answers on effective methods of contraception by treatment group and gender", size(small) span) subtitle("15-49 years old", size(small) span) legend(label(1 "Oral contraceptives=yes") label(2 "Depoprovera injection (DMPA)=yes") label(3 "IUD=yes") label(4 "Breastfeeding=no") label(5 "Withdrawal=no") rows(5)) over(a1_02) over(group_code);
graph export a04_b08_contraception_3, as(pdf) replace;

restore;


**********************
*** Section 5: Housing
**********************;

use $cleandatadir/rwhrbf_a00_withstudyarms_withvarformeantests.dta, clear;
preserve;
lab define group_code_lab 1 "Demand" 2 "Supply" 3 "Demand & Supply" 4 "Control";
lab values group_code group_code_lab;
replace a5_08a=12 if a5_08a==96;
replace a5_08b=12 if a5_08b==96;
replace a5_10a=5 if a5_10a==96;
replace a5_10b=5 if a5_10b==96;

graph bar a5_03_1 a5_03_2 a5_03_3 a5_03_4 a5_03_5 a5_03_6 a5_03_7 a5_03_8 a5_03_9 a5_03_96 [pweight=hhpweight], title("Ownership status of property", span) legend(label(1 "Owned with mortgages") label(2 "Owned without mortgages") label (3 "Rented - not tied to job") label(4 "Rented - tied to job") label(5 "Rent free") label(6 "Municipality plot") label(7 "Provided by govt employer") label(8 "Provided by private employer") label(9 "Temporary housing") label(10 "Other") rows(5) cols(2)) over(group_code);
graph export a00_house_1, as(pdf) replace;

graph pie [pweight=hhpweight], over(a5_08a) sort title("Main source of drinking water - Dry season", span);
graph export a00_water_source_1, as(pdf) replace;
graph pie [pweight=hhpweight], over(a5_08b) sort title("Main source of drinking water - Rainy season", span);
graph export a00_water_source_2, as(pdf) replace;
* graph pie [pweight=hhpweight], over(a5_08a) sort by(group_code, title("Main source of drinking water - Dry season", span) subtitle("by treatment group", span));
* graph pie [pweight=hhpweight], over(a5_08b) sort by(group_code, title("Main source of drinking water - Rainy season", span) subtitle("by treatment group", span));

graph bar a5_08a_100 a5_08b_100 [pweight=hhpweight], title("Access to improved water source", span) legend(label(1 "Dry season") label(2 "Rainy season"));
graph export a00_improved_water_source_1, as(pdf) replace;
graph bar a5_08a_100 a5_08b_100 [pweight=hhpweight], over(group_code) title("Access to improved water source by treatment group", span) legend(label(1 "Dry season") label(2 "Rainy season"));
graph export a00_improved_water_source_2, as(pdf) replace;

graph dot a5_09a a5_09b [pweight=hhpweight], over(group_code) title("Distance from water source in Km by treatment group", span) legend(label(1 "Dry season") label(2 "Rainy season"));
graph export a00_dist_water_source_1, as(pdf) replace;

* hist a5_10a, percent discrete by(group_code, title("Treatment of drinking water in dry season by treatment group", span));
* graph export a00_water_tmt_1, as(pdf) replace;
* hist a5_10b, percent discrete by(group_code, title("Treatment of drinking water in rainy season by treatment group", span));
* graph export a00_water_tmt_2, as(pdf) replace;

graph pie [pweight=hhpweight], over(a5_13) sort title("Trash management", span);
graph export a00_rubbish_1, as(pdf) replace;
graph pie [pweight=hhpweight], over(a5_13) sort by(group_code, title("Trash management by treatment group", span));
graph export a00_rubbish_2, as(pdf) replace;

graph pie [pweight=hhpweight], over(a5_14) sort title("Main source of energy for lighting", span);
graph export a00_energy_light_1, as(pdf) replace;
graph pie [pweight=hhpweight], over(a5_14) sort by(group_code, title("Main source of energy for lighting by treatment group", span)) legend(size(vsmall));
graph export a00_energy_light_2, as(pdf) replace;

graph pie [pweight=hhpweight], over(a5_15) sort title("Main source of energy for cooking", span);
graph export a00_energy_cook_1, as(pdf) replace;
graph pie [pweight=hhpweight], over(a5_15) sort by(group_code, title("Main source of energy for cooking by treatment group", span)) legend(size(vsmall));
graph export a00_energy_cook_2, as(pdf) replace;

* hist a5_11_100, percent discrete xlabel(0 "No access" 1 "Access") title("Access to improved sanitation", span);
* graph export a00_sanitation_1, as(pdf) replace;
* hist a5_11_100, percent discrete xlabel(0 "No access" 1 "Access") by(group_code, title("Access to improved sanitation by treatment group", span));
* graph export a00_sanitation_2, as(pdf) replace;

restore;


*******************************
*** Section 6: Household assets
*******************************;

use $cleandatadir/rwhrbf_a05_with_1obs_for_1hh_withstudyarms_withvarformeantests.dta, clear;
preserve;
lab define group_code_lab 1 "Demand" 2 "Supply" 3 "Demand & Supply" 4 "Control";
lab values group_code group_code_lab;

graph dot a6_02_100 [pweight=hhpweight], over(group_code) title("Current value of material assets in RWF per treatment group", span) ytitle("Value in RWF");
graph export a05_assets_1, as(pdf) replace;

restore;

use $cleandatadir/rwhrbf_a00_withstudyarms_withvarformeantests.dta, clear;
preserve;
lab define group_code_lab 1 "Demand" 2 "Supply" 3 "Demand & Supply" 4 "Control";
lab values group_code group_code_lab;

graph bar a6_03_1 [pweight=hhpweight], over(group_code) title("Residential land ownership", span) ytitle("Land is owned by household (proportion)");
graph export a00_land_1, as(pdf) replace;
graph bar a6_05_1 [pweight=hhpweight], over(group_code) title("Non residential land ownership", span) ytitle("Land is owned by household (proportion)");
graph export a00_land_2, as(pdf) replace;
graph bar a6_05_2 [pweight=hhpweight], over(group_code) title("Total land ownership", span) ytitle("Land is owned by household (proportion)");
graph export a00_land_3, as(pdf) replace;
graph dot a6_06n_2 [pweight=hhpweight], over(group_code) title("Size of total land owned", span) ytitle("Size of land owned in ha");
graph export a00_land_4, as(pdf) replace;
graph dot a6_07 [pweight=hhpweight], over(group_code) title("Current value of total land owned", span) ytitle("Value of land owned in RWF");
graph export a00_land_5, as(pdf) replace;

restore;

use $cleandatadir/rwhrbf_a06_with_1obs_for_1hh_withstudyarms_withvarformeantests.dta, clear;
preserve;
lab define group_code_lab 1 "Demand" 2 "Supply" 3 "Demand & Supply" 4 "Control";
lab values group_code group_code_lab;

graph dot a6_12_100 a6_13_100 [pweight=hhpweight], over(group_code) title("Original vs. current value of livestock by treatment group", span) ytitle(Value in RWF) legend(label(1 "Value paid at purchase in RWF") label(2 "Current estimated value in RWF"));
graph export a06_livestock_1, as(pdf) replace;
graph bar a6_13_101 a6_13_102 [pweight=hhpweight], over(group_code) title("Decrease or increase in livestock value by treatment group", span) ytitle("Proportion of households who saw decrease or increase") legend(label(1 "Household saw decrease in value") label(2 "Household saw increase in value") rows(2));
graph export a06_livestock_2, as(pdf) replace;

restore;


*****************************************************************************
*** Section 7: Transfers and Other income and Subjective Life Valuation (SLV)
*****************************************************************************;

use $cleandatadir/rwhrbf_a07_with_1obs_for_1hh_withstudyarms_withvarformeantests.dta, clear;
preserve;
lab define group_code_lab 1 "Demand" 2 "Supply" 3 "Demand & Supply" 4 "Control";
lab values group_code group_code_lab;

graph dot a7_01_100 [pweight=hhpweight], over(group_code) title("Income outside of employment by treatment group", span) ytitle("Income in RWF");
graph export a07_income_1, as(pdf) replace;

graph dot a7_01_1 a7_01_2 a7_01_3 a7_01_4 a7_01_5 a7_01_6 a7_01_7 a7_01_8 a7_01_9 a7_01_10 a7_01_11 a7_01_12 [pweight=hhpweight], over(group_code) title("Incomes outside of employment by treatment group", span) ytitle("Income in RWF") legend(label(1 "Interest or investment income") label(2 "Rent from land/building") label(3 "Rent from equipment") label(4 "Rent from animals") label(5 "Pension/Insurance/Compensation from past work") label(6 "Other govt transfer (VUP)") label(7 "Scholarship") label(8 "Community/NGO/Church support") label(9 "Remittances/Gifts from within Rwanda") label(10 "Remittances/Gifts from outside Rwanda") label(11 "Inheritance") label(12 "Other") rows(6) cols(2) size(small)); 
graph export a07_income_2, as(pdf) replace;

restore;

use $cleandatadir/rwhrbf_a00_withstudyarms_withvarformeantests.dta, clear;
preserve;
lab define group_code_lab 1 "Demand" 2 "Supply" 3 "Demand & Supply" 4 "Control";
lab values group_code group_code_lab;
lab define a7_04_lab 1 "Natural disaster" 2 "Weather" 3 "Bad economy" 4 "Investment" 5 "Support from government" 6 "Support from community" 7 "Support from family/friends" 8 "Health" 9 "Death" 10 "New job/work" 11 "Robbed" 96 "Other";
lab values a7_04_1 a7_04_lab;
lab values a7_04_2 a7_04_lab;

graph bar a7_03_1 a7_03_2 [pweight=hhpweight], over(group_code) title("Subjective life valuation by treatment group", span) ytitle("Proportion of Households worse or better off than 1 year ago") legend(label(1 "Worse off") label(2 "Better off"));
graph export a00_slv_1, as(pdf) replace;

graph pie [pweight=hhpweight], over(a7_04_1) by(group_code, title("Reason if worse off by treatment group", span));
graph export a00_slv_2, as(pdf) replace;
graph pie [pweight=hhpweight], over(a7_04_2) by(group_code, title("Reason if better off by treatment group", span));
graph export a00_slv_3, as(pdf) replace;

graph bar a7_04_1_8 a7_04_2_8 [pweight=hhpweight], over(group_code) title("Worse or better off because of health-related reasons", span) legend(label(1 "Worse off") label(2 "Better off") rows(1)) ytitle("Proportion of Households worse or better off for health-related reasons");
graph export a00_slv_4, as(pdf) replace;

restore;


*******************************
*** Sections 8 and 9: Mortality
*******************************;

use $cleandatadir/rwhrbf_a00_withstudyarms_withvarformeantests.dta, clear;
preserve;
lab define group_code_lab 1 "Demand" 2 "Supply" 3 "Demand & Supply" 4 "Control";
lab values group_code group_code_lab;

graph bar a9_01_1 [pweight=hhpweight], over(group_code) title("Death in household in past 12 months by treatment group", span) ytitle("Proportion of Households where death in past 12 months") ylabel(0(.02).1);
graph export a00_death_1, as(pdf) replace;

restore;

use $cleandatadir/rwhrbf_a08_with_1obs_for_1hh_withstudyarms_withvarformeantests.dta, clear;
preserve;
lab define group_code_lab 1 "Demand" 2 "Supply" 3 "Demand & Supply" 4 "Control";
lab values group_code group_code_lab;

* hist a9_05_1, discrete percent by(group_code, title("Gender of most recent deceased by treatment group", span)) xlabel(1 "Male" 2 "Female") ytitle("Proportion of Most recent death that was male or female");
* graph export a08_death_1, as(pdf) replace;

graph dot a9_06n_1_1 [pweight=hhpweight], over(group_code) title("Age of most recent deceased by treatment group", span) ytitle("Age at death in years");
graph export a08_death_2, as(pdf) replace;
* hist a9_06n_1_1, discrete percent title("Age distribution of most recent death", span);
* graph export a08_death_3, as(pdf) replace;
* hist a9_06n_1_1, discrete percent by(group_code, title("Age distribution of most recent death by treatment group", span));
* graph export a08_death_4, as(pdf) replace;

graph bar a9_07_1_1 a9_07_1_2 a9_07_1_3 a9_07_1_4 a9_07_1_5 a9_07_1_6 a9_07_1_7 a9_07_1_8 a9_07_1_9 a9_07_1_10 a9_07_1_11 a9_07_1_12 a9_07_1_13 a9_07_1_14 a9_07_1_15 a9_07_1_16 a9_07_1_17 a9_07_1_96 [pweight=hhpweight], over(group_code) title("Cause of most recent death - Most respondents do not know the cause of death", size(medsmall) span) ytitle("Proportion Most recent death due to") legend(label(1 "Birth trauma") label(2 "Congenital anomalies") label(3 "Sickle cell") label(4 "Measles") label(5 "Malaria") label(6 "Malnutrition") label(7 "Diarrhea") label(8 "Pneumonia") label(9 "Tuberculosis") label(10 "AIDS") label(11 "Accident") label(12 "Violence") label(13 "Stroke") label(14 "Cancer") label(15 "Heart disease") label(16 "Old age") label(17 "Unknown cause") label(18 "Other cause") cols(3));
graph export a08_death_5, as(pdf) replace;

restore;




*************************************************************************************************
********************************** Female Questionnaire *****************************************
*************************************************************************************************;


***********************************************
*** Section 10.1: Health status and utilization
***********************************************;

use $cleandatadir/rwhrbf_b01_withstudyarms_withvarformeantests.dta, clear;
preserve;
keep if a1_11a>=15 & a1_11a<=49 & a1_02==2;
lab define group_code_lab 1 "Demand" 2 "Supply" 3 "Demand & Supply" 4 "Control";
lab values group_code group_code_lab;

graph bar b10_02_1 b10_02_2 b10_02_3 [pweight=hhpweight], over(group_code) title("Evolution of Health status over past 12 months per treatment group", size(medsmall) span) subtitle("Women 15-49", size(medsmall) span) ytitle("Proportion of Women who indicated evolution of health status") legend(label(1 "Better") label(2 "Worse") label(3 "Same") rows(1));
graph export b01_healthstatus_1, as(pdf) replace;

graph bar b10_03_1 b10_03_2 b10_03_3 b10_03_4 [pweight=hhpweight], over(group_code) title("Current ability to do daily activities per treatment group", span) subtitle("Women 15-49", span) ytitle("Proportion of Women who indicated degree of difficulty") legend(label(1 "Easily") label(2 "With some difficulty") label(3 "With much difficulty") label(4 "Unable to do") rows(2));
graph export b01_healthstatus_2, as(pdf) replace;

graph bar b10_04_1 [pweight=hhpweight], over(group_code) title("Sickness in last 4 weeks per treatment group", span) subtitle("Women 15-49", span) ytitle("Proportion of women sick in past 4 weeks");
graph export b01_healthstatus_3, as(pdf) replace;

graph pie [pweight=hhpweight], over(b10_05a) sort title("Main disease in past 4 weeks", span) subtitle("Women 15-49", span);
graph export b01_healthstatus_4, as(pdf) replace;
graph pie [pweight=hhpweight], over(b10_05b) sort title("2nd disease in past 4 weeks", span) subtitle("Women 15-49", span);
graph export b01_healthstatus_5, as(pdf) replace;
graph pie [pweight=hhpweight], over(b10_05c) sort title("3rd disease in past 4 weeks", span) subtitle("Women 15-49", span);
graph export b01_healthstatus_6, as(pdf) replace;
graph bar b10_05b_100 [pweight=hhpweight], title("Women who had more than 1 disease in last 4 weeks", span) subtitle("Women 15-49", span) ytitle("Proportion of women who had >1 disease");
graph export b01_healthstatus_7, as(pdf) replace;

graph dot b10_07a_4 [pweight=hhpweight], title("Nr. days of illness if illness is over", span) subtitle("Women 15-49", span) ytitle("Nr. days illness");
graph export b01_healthstatus_8, as(pdf) replace;
graph dot b10_07a_4 [pweight=hhpweight], over(group_code) title("Nr. days of illness if illness is over per treatment group", span) subtitle("Women 15-49", span) ytitle("Nr. days illness");
graph export b01_healthstatus_9, as(pdf) replace;

graph bar b10_08_1 [pweight=hhpweight], over(group_code) title("Women who consulted health personnel for last illness, including traditional healer", size(medsmall) span) subtitle("per treatment group - Women 15-49", size(medsmall) span) ytitle("Proportion of women who consulted health personnel") yscale(titlegap(*2));
graph export b01_healthstatus_10, as(pdf) replace;

restore;


*****************************
*** Section 11: Mental Health
*****************************;

use $cleandatadir/rwhrbf_b02_withstudyarms_withvarformeantests.dta, clear;
preserve;
keep if a1_11a>=15 & a1_11a<=49 & a1_02==2;
lab define group_code_lab 1 "Demand" 2 "Supply" 3 "Demand & Supply" 4 "Control";
lab values group_code group_code_lab;

graph bar b11_01a_1 b11_01a_2 b11_01a_3 [pweight=hhpweight], over(group_code) title("Frequency of feeling slowed down in last 6 months", span) subtitle("per treatment group - Women 15-49", span) ytitle("Proportion of women who felt slowed down")  legend(label(1 "Often") label(2 "Sometimes") label(3 "Never") rows(1));
graph export b02_mentalhealth_1, as(pdf) replace;

graph bar b11_01b_1 b11_01b_2 b11_01b_3 [pweight=hhpweight], over(group_code) title("Frequency of feeling deep sadness in last 6 months", span) subtitle("per treatment group - Women 15-49", span) ytitle("Proportion of women who felt deep sadness")  legend(label(1 "Often") label(2 "Sometimes") label(3 "Never") rows(1));
graph export b02_mentalhealth_2, as(pdf) replace;

graph bar b11_01c_1 b11_01c_2 b11_01c_3 [pweight=hhpweight], over(group_code) title("Frequency of feeling no more joy in life in last 6 months", span) subtitle("per treatment group - Women 15-49", span) ytitle("Proportion of women who felt they didn't enjoy life as used to") yscale(titlegap(*2)) legend(label(1 "Often") label(2 "Sometimes") label(3 "Never") rows(1));
graph export b02_mentalhealth_3, as(pdf) replace;

graph bar b11_01d_1 b11_01d_2 b11_01d_3 [pweight=hhpweight], over(group_code) title("Frequency of feeling hopeless in last 6 months", span) subtitle("per treatment group - Women 15-49", span) ytitle("Proportion of women who felt life is hopeless")  legend(label(1 "Often") label(2 "Sometimes") label(3 "Never") rows(1));
graph export b02_mentalhealth_4, as(pdf) replace;

graph bar b11_02_1 [pweight=hhpweight], over(group_code) title("Counseling or treatment for depression/anxiety in last 4 weeks", span) subtitle("per treatment group - Women 15-49", span) ytitle("Proportion of women who received counseling or treatment");
graph export b02_mentalhealth_5, as(pdf) replace;

restore;


********************************************
*** Section 12: Reproductive health (Female)
********************************************;

use $cleandatadir/rwhrbf_b03_withstudyarms_withvarformeantests.dta, clear;
preserve;
keep if a1_11a>=15 & a1_11a<=49 & a1_02==2;
lab define group_code_lab 1 "Demand" 2 "Supply" 3 "Demand & Supply" 4 "Control";
lab values group_code group_code_lab;

graph bar b12_02_1 b12_02_2 b12_02_3 b12_02_4 b12_02_5 b12_02_96 [pweight=hhpweight], title("Waiting time until birth of next child", span) subtitle("Women 15-49", span) legend(label(1 "No more child") label(2 "Infertile") label(3 "Years") label(4 "Soon/Now") label(5 "After marriage") label(6 "Other") rows(2)) ytitle("Proportion of women who want child at given time");
graph export b03_child_desire_1, as(pdf) replace;

graph bar b12_02_1 b12_02_2 b12_02_3 b12_02_4 b12_02_5 b12_02_96 [pweight=hhpweight], over(group_code) title("Waiting time until birth of next child per treatment group", span) subtitle("Women 15-49", span) legend(label(1 "No more child") label(2 "Infertile") label(3 "Years") label(4 "Soon/Now") label(5 "After marriage") label(6 "Other") rows(2)) ytitle("Proportion of women who want child at given time");
graph export b03_child_desire_2, as(pdf) replace;

graph bar b12_03_1 b12_03_2 b12_03_3 b12_03_4 [pweight=hhpweight], title("Would a pregnancy now be a problem?", span) subtitle("Women 15-49", span) legend(label(1 "Big problem") label(2 "Small problem") label(3 "No problem") label(4 "Can't get pregnant") rows(2)) ytitle("Proportion of women") yscale(titlegap(*2));
graph export b03_child_desire_3, as(pdf) replace;

graph bar b12_03_1 b12_03_2 b12_03_3 b12_03_4 [pweight=hhpweight], over(group_code) title("Would a pregnancy now be a problem? by treatment group", span) subtitle("Women 15-49", span) legend(label(1 "Big problem") label(2 "Small problem") label(3 "No problem") label(4 "Can't get pregnant") rows(2)) ytitle("Proportion of women") yscale(titlegap(*2));
graph export b03_child_desire_4, as(pdf) replace;

graph bar b12_04_1 b12_05_1 b12_06_1 b12_09_1 b12_12_1 b12_13a_2 [pweight=hhpweight], title("Contraception approval, knowledge and use", span) subtitle("Women 15-49", span) legend(label(1 "Approves contraception") label(2 "Heard of contraception") label(3 "Ever used contraception") label(4 "Partner approves contraception if has partner") label(5 "Contraceptive prevalence") label(6 "Is using modern contraception if currently uses contraception") rows(6)) ytitle("Proportion of women");
graph export b03_contraception_1, as(pdf) replace;

graph bar b12_04_1 b12_05_1 b12_06_1 b12_09_1 b12_12_1 b12_13a_2 [pweight=hhpweight], over(group_code) title("Contraception approval, knowledge and use by treatment group", span) subtitle("Women 15-49", span) legend(label(1 "Approves contraception") label(2 "Heard of contraception") label(3 "Ever used contraception") label(4 "Partner approves contraception if has partner") label(5 "Contraceptive prevalence") label(6 "Is using modern contraception if currently uses contraception") rows(6)) ytitle("Proportion of women");
graph export b03_contraception_2, as(pdf) replace;

graph bar b12_14_1 b12_14_2 b12_14_3 b12_14_4 b12_14_5 b12_14_6 b12_14_7 b12_14_8 b12_14_9 b12_14_10 b12_14_96 [pweight=hhpweight], title("Place where contraception was first got", span) subtitle("Women 15-49", span) legend(label(1 "Medical doctor") label(2 "Nurse/Midwife") label(3 "CHW") label(4 "Lab technician") label(5 "Pharmacist") label(6 "Traditional healer") label(7 "Spiritual healer") label(8 "Traditional birth attendant") label(9 "Family member") label(10 "Friend/Neighbor") label(11 "Other") rows(4) size(small)) ytitle("Proportion of women") yscale(titlegap(*2));
graph export b03_contraception_3, as(pdf) replace;

graph bar b12_14_1 b12_14_2 b12_14_3 b12_14_4 b12_14_5 b12_14_6 b12_14_7 b12_14_8 b12_14_9 b12_14_10 b12_14_96 [pweight=hhpweight], over(group_code) title("Place where contraception was first got by treatment group", span) subtitle("Women 15-49", span) legend(label(1 "Medical doctor") label(2 "Nurse/Midwife") label(3 "CHW") label(4 "Lab technician") label(5 "Pharmacist") label(6 "Traditional healer") label(7 "Spiritual healer") label(8 "Traditional birth attendant") label(9 "Family member") label(10 "Friend/Neighbor") label(11 "Other") rows(4) size(small)) ytitle("Proportion of women") yscale(titlegap(*2));
graph export b03_contraception_4, as(pdf) replace;

graph bar b12_14a_1 [pweight=hhpweight], over(group_code) title("Received gift when started current contraception method", span) subtitle("by treatment group - Women 15-49", span) ytitle("Proportion of women") ylabel(0(.2)1);
graph export b03_contraception_5, as(pdf) replace;

graph dot b12_14b [pweight=hhpweight], over(group_code) title("Value of gift received in RWF by treatment group", span) subtitle("Women 15-49", span) ytitle("Value in RWF");
graph export b03_contraception_6, as(pdf) replace;

graph bar b12_18a_1 b12_18b_1 b12_18c_1 b12_18d_1 b12_18e_1 [pweight=hhpweight], over(group_code) title("Source of information on FP methods by treatment group", span) subtitle("Women 15-49", span) legend(label(1 "Health facility staff") label(2 "CHW") label(3 "Friends/Family") label(4 "Local/Central govt") label(5 "Other") rows(3)) ytitle("Proportion of women");
graph export b03_FP_1, as(pdf) replace;

graph bar b12_12_100 b12_12_101 b12_12_102 b12_12_103 [pweight=hhpweight], over(group_code) title("Unmet need for FP by treatment group and civil status", span) subtitle("Women 15-49", span) legend(label(1 "Unmet need for FP") label(2 "Unmet need & partner disapproves") label(3 "Unmet need for FP -married") label(4 "Unmet need for FP -unmarried") rows(4)) ytitle("Proportion of women");
graph export b03_FP_ind_1, as(pdf) replace;

graph bar b12_12_1 b12_12_104 b12_12_105 b12_12_109 b12_12_106 b12_12_107 b12_12_108 [pweight=hhpweight], over(group_code) title("Contraceptive prevalence by treatment group and civil status", span) subtitle("Women 15-49", span) legend(label(1 "Contraceptive prevalence") label(2 "Contracep prevalence -married") label(3 "Contracep prev -unmarried") label(4 "Contracep prev -ever sex active (i.e. 15+)") label(5 "Modern contracep prev") label(6 "Modern contracep prev- married") label(7 "Modern contracep prev -unmarried") rows(7)) ytitle("Proportion of women");
graph export b03_contraception_ind_1, as(pdf) replace;

restore;


***********************************
*** Section 13.1: Pregnancy history
***********************************;

use $cleandatadir/rwhrbf_b04_withstudyarms_withvarformeantests.dta, clear;
preserve;
keep if a1_11a>=15 & a1_11a<=49 & a1_02==2;
lab define group_code_lab 1 "Demand" 2 "Supply" 3 "Demand & Supply" 4 "Control";
lab values group_code group_code_lab;

graph bar b13_003_1 b13_003_2 b13_003_3 [pweight=hhpweight], over(group_code) title("Appropriate time for current pregnancy by treatment group", span) subtitle("Women 15-49", span) legend(label(1 "Wanted child then") label(2 "Wanted child later") label(3 "Wanted no more child") rows(2)) ytitle("Proportion of pregnant women");
graph export b04_pregnancy_1, as(pdf) replace;

graph dot b13_005a b13_005b b13_007a b13_007b b13_009a b13_009b [pweight=hhpweight], over(group_code) title("Number of children living with or without mother or deceased", span) subtitle("by treatment group - Women 15-49", span) legend(label(1 "Nr. sons living w/mother") label(2 "Nr. daughters living w/mother") label(3 "Nr. sons living w\mother") label(4 "Nr. daughters living w\mother") label(5 "Nr. sons deceased") label(6 "Nr. daughters deceased") rows(6)) ytitle("Average nr. of children");
graph export b04_pregnancy_2, as(pdf) replace;

graph bar b13_012_1 b13_013_1 b13_014_1 [pweight=hhpweight], over(group_code) title("Miscarriage/abortion/end in stillbirth", span) subtitle("by treatment group - Women 15-49", span) legend(label(1 "Had miscarriage/abortion/end in stillbirth (proportion of women)") label(2 "Miscarriage/stillbirth (proportion of all births)") label(3 "Nr. abortions (proportion of all births)") rows(3)) ytitle("Proportion of women or births");
graph export b04_pregnancy_3, as(pdf) replace;

restore;


*******************************
*** Section 13.2: Birth history
*******************************;

use $cleandatadir/rwhrbf_b05_withstudyarms_withvarformeantests.dta, clear;
preserve;
keep if a1_11a>=15 & a1_11a<=49 & a1_02==2;
lab define group_code_lab 1 "Demand" 2 "Supply" 3 "Demand & Supply" 4 "Control";
lab values group_code group_code_lab;

graph bar b13_022n_1 b13_028_2 b13_026_2 b13_030a_1 [pweight=hhpweight], over(group_code) title("Motherhood by treatment group", span) subtitle("Women 15-49", span) legend(label(1 "Nr. births per woman") label(2 "Proportion of children who live away") label(3 "Proportion of children who died") label(4 "Age of child at death in years") rows(2) size(small)) ytitle("") ylabel(.1 .2 .5(.5)3, labsize(*.8));
graph export b05_motherhood_1, as(pdf) replace;

* hist b13_030a_2, discrete percent normal xlabel(0 12 24 36 48) title("Age at death in months for children<5") xtitle("Age in months") ytitle("% of deaths");
* graph export b05_child_mortality_1, as(pdf) replace;

restore;


**********************************************
*** Section 13.3: Antenatal and Postnatal care
**********************************************;

use $cleandatadir/rwhrbf_b06_withstudyarms_withvarformeantests.dta, clear;
preserve;
keep if a1_11a>=15 & a1_11a<=49 & a1_02==2;
lab define group_code_lab 1 "Demand" 2 "Supply" 3 "Demand & Supply" 4 "Control";
lab values group_code group_code_lab;

*** ANC;

graph bar b13_036_100 b13_035_3 b13_037_101 b13_039_2 b13_041_101 [pweight=hhpweight], over(group_code) title("Antenatal care indicators by treatment group", span) subtitle("Women 15-49 pregnant or had pregnancy since Jan 08", span) legend(label(1 "Skilled ANC visit") label(2 "ANC coverage: 1+ visit (WHO-live births)") label(3 "ANC in formal HF (live births)") label(4 "Timely ANC (<=4m; live births)") label(5 "ANC coverage: 4+ visits (WHO - live births)") rows(6)) ytitle("Proportion of most recent births/pregnancies") yscale(titlegap(*2)) ylabel(.2(.2)1) exclude0;
graph export b06_ANC_ind_1, as(pdf) replace;

graph bar b13_036_1 b13_036_2 b13_036_3 b13_036_4 b13_036_5 b13_036_6 b13_036_7 b13_036_8 b13_036_9 b13_036_10 b13_036_96 [pweight=hhpweight], over(group_code) title("Healthcare provider for ANC visits by treatment group", span) subtitle("Women 15-49 pregnant or had pregnancy since Jan 08", span) legend(label(1 "medical doctor") label(2 "nurse/midwife") label(3 "CHW") label(4 "lab technician") label(5 "pharmacist") label(6 "traditional healer") label(7 "spiritual healer") label(8 "traditonal birth attendant") label(9 "family member") label(10 "friend/neighbor") label(11 "other") rows(6)) ytitle("Proportion of births/pregnancies");
graph export b06_ANC_provider_1, as(pdf) replace;

graph bar b13_037_1 b13_037_2 b13_037_3 b13_037_4 b13_037_5 b13_037_7 b13_037_9 b13_037_10 b13_037_11 b13_037_12 b13_037_96 [pweight=hhpweight], over(group_code) title("Healthcare facility for ANC visits by treatment group", span) subtitle("Women 15-49 pregnant or had pregnancy since Jan 08", span) legend(label(1 "Govt hospital") label(2 "Govt health center") label(3 "Govt health post") label(4 "private hospital") label(5 "priv health center") label(6 "pharmacy") label(7 "trad healer") label(8 "faith/church healer") label(9 "CHW") label(10 "home") label(11 "other") rows(6)) ytitle("Proportion of births/pregnancies");
graph export b06_ANC_provider_2, as(pdf) replace;

graph bar b13_040a_1 [pweight=hhpweight], over(group_code) title("Received gift at 1st ANC visit by treatment group", span) subtitle("Women 15-49 pregnant or had pregnancy since Jan 08", span) ytitle("Proportion of births/pregnancies");
graph export b06_ANC_gift_1, as(pdf) replace;

graph dot b13_040b [pweight=hhpweight], over(group_code) title("Value of gift received at 1st ANC visit by treatment group", span) subtitle("Women 15-49 pregnant or had pregnancy since Jan 08", span) ytitle("Value in RWF"); 
graph export b06_ANC_gift_2, as(pdf) replace;

graph bar b13_044_1 [pweight=hhpweight], over(group_code) title("Minimum tests performed at ANC during pregnancy by treatment group", span size(medsmall)) subtitle("Women 15-49 pregnant or had pregnancy since Jan 08", span size(medsmall)) ytitle("Proportion of births/pregnancies");
graph export b06_ANC_tests_1, as(pdf) replace;

graph pie [pweight=hhpweight], over(b13_047a) sort by(group_code, title("Reasons for not consulting formal facility for ANC", span) subtitle("Women 15-49 pregnant or had pregnancy since Jan 08", span)) legend(size(vsmall));
graph export b06_ANC_provider_3, as(pdf) replace;

graph bar b13_048_1 [pweight=hhpweight], over(group_code) title("Unavailability of healthcare staff at one of ANC visits by treatment group", span size(medsmall)) subtitle("Women 15-49 pregnant or had pregnancy since Jan 08", span size(medsmall)) ytitle("Proportion of births/pregnancies");
graph export b06_ANC_provider_4, as(pdf) replace;

graph bar b13_049_2 b13_051_2 b13_053_2 [pweight=hhpweight], over(group_code) title("Immunization/Supplements at ANC visits by treatment group", span) subtitle("Women 15-49 pregnant or had pregnancy since Jan 08", span) legend(label(1 "TT2 coverage in pregnancy (live births)") label(2 "90-day Iron supplementation in pregnancy (live births)") label(3 "SP preventive treatment against malaria") rows(3)) ytitle("Proportion of most recent births/pregnancies");
graph export b06_ANC_tests_ind_1, as(pdf) replace;

graph bar b13_057_1 b13_057_2 b13_057_3 b13_057_4 b13_057_5 b13_057_6 [pweight=hhpweight], over(group_code) title("Result of pregnancy by treatment group", span) subtitle("Women 15-49 pregnant or had pregnancy since Jan 08", span) legend(label(1 "born alive, single birth") label(2 "born alive, multiple birth") label(3 "stillborn") label(4 "still pregnant") label(5 "miscarriage") label(6 "abortion") rows(3)) ytitle("Proportion of births/pregnancies");
graph export b06_ANC_pregnancy_result_1, as(pdf) replace;

 *** Delivery;
 
graph bar b13_058_100 b13_059_100 b13_062_1 [pweight=hhpweight], over(group_code) title("Delivery indicators by treatment group", span) subtitle("Women 15-49 pregnant or had pregnancy since Jan 08", span) legend(label(1 "Skilled delivery") label(2 "Delivery in formal facility") label(3 "C-section rate") rows(3)) ytitle("Proportion of births");
graph export b06_delivery_ind_1, as(pdf) replace;

graph bar b13_058_1 b13_058_2 b13_058_3 b13_058_4 b13_058_5 b13_058_6 b13_058_7 b13_058_8 b13_058_9 b13_058_10 b13_058_11 b13_058_96 [pweight=hhpweight], over(group_code) title("Healthcare provider for delivery by treatment group", span) subtitle("Women 15-49 pregnant or had pregnancy since Jan 08", span) legend(label(1 "medical doctor") label(2 "nurse/midwife") label(3 "CHW") label(4 "lab technician") label(5 "pharmacist") label(6 "traditional healer") label(7 "spiritual healer") label(8 "traditonal birth attendant") label(9 "family member") label(10 "friend/neighbor") label(11 "no one") label(12 "other") rows(6)) ytitle("Proportion of births");
graph export b06_delivery_provider_1, as(pdf) replace;

graph pie [pweight=hhpweight], over(b13_061_1) sort by(group_code, title("Reasons for not delivering at formal facility", span) subtitle("Women 15-49 pregnant or had pregnancy since Jan 08", span)) legend(size(vsmall));
graph export b06_delivery_provider_2, as(pdf) replace;

graph bar b13_061a_1 [pweight=hhpweight], over(group_code) title("Received gift at delivery by treatment group", span) subtitle("Women 15-49 pregnant or had pregnancy since Jan 08", span) ytitle("Proportion of births");
graph export b06_delivery_gift_1, as(pdf) replace;

graph dot b13_061b [pweight=hhpweight], over(group_code) title("Value of gift received at delivery by treatment group", span) subtitle("Women 15-49 pregnant or had pregnancy since Jan 08", span) ytitle("Value in RWF"); 
graph export b06_delivery_gift_2, as(pdf) replace;

*** Low-birth-weight newborns;

graph bar b13_067a_1 [pweight=hhpweight], over(group_code) title("Low-birth-weight newborns indicator (WHO - live births)", span) subtitle("Women 15-49 pregnant or had pregnancy since Jan 08", span) ytitle("Proportion of births"); 
graph export b06_lowbirthweight_newborns_1, as(pdf) replace;

*** Breastfeeding;

graph bar b13_069a_100 b13_071a_100 b13_071a_101 [pweight=hhpweight], over(group_code) title("Breastfeeding indicators", span) subtitle("Women 15-49 pregnant or had pregnancy since Jan 08", span) legend(label(1 "Timely initiation of breastfeeding") label(2 "Exclusive breastfeeding 0-6m (WHO)") label(3 "Breastfed & complementary fed 6-9m") rows(3)) ytitle("Proportion of most recent births"); 
graph export b06_breastfeeding_1, as(pdf) replace;

*** PNC;

graph bar b13_080_100 b13_080_102 b13_083_100 b13_092_100 [pweight=hhpweight], over(group_code) title("Postnatal care indicators by treatment group", span) subtitle("Women 15-49 pregnant or had pregnancy since Jan 08", span) legend(label(1 "Timely PNC for mothers' health") label(2 "Timely PNC (babies born at home)") label(3 "Timely PNC in formal facility") label(4 "Postnatal supplementation w/vitamin A") rows(2) size(small)) ytitle("Proportion of most recent births/miscarriages") yscale(titlegap(*2)); 
graph export b06_PNC_ind_1, as(pdf) replace;

graph bar b13_082_1 b13_082_2 b13_082_3 b13_082_4 b13_082_5 b13_082_6 b13_082_7 b13_082_8 b13_082_9 b13_082_10 b13_082_96 [pweight=hhpweight], over(group_code) title("Healthcare provider for 1st PNC visit by treatment group", span) subtitle("Women 15-49 pregnant or had pregnancy since Jan 08", span) legend(label(1 "medical doctor") label(2 "nurse/midwife") label(3 "CHW") label(4 "lab technician") label(5 "pharmacist") label(6 "traditional healer") label(7 "spiritual healer") label(8 "traditonal birth attendant") label(9 "family member") label(10 "friend/neighbor") label(11 "other") rows(6)) ytitle("Proportion of births/miscarriages");
graph export b06_PNC_provider_1, as(pdf) replace;

graph bar b13_083_1 b13_083_2 b13_083_3 b13_083_4 b13_083_5 b13_083_7 b13_083_9 b13_083_10 b13_083_11 b13_083_12 b13_083_96 [pweight=hhpweight], over(group_code) title("Healthcare facility for 1st PNC visit by treatment group", span) subtitle("Women 15-49 pregnant or had pregnancy since Jan 08", span) legend(label(1 "Govt hospital") label(2 "Govt clinic") label(3 "Govt health post") label(4 "private hospital") label(5 "priv clinic") label(6 "pharmacy") label(7 "trad healer") label(8 "faith/church healer") label(9 "CHW") label(10 "home") label(11 "other") rows(6)) ytitle("Proportion of births/miscarriages");
graph export b06_PNC_provider_2, as(pdf) replace;

graph bar b13_083a_1 [pweight=hhpweight], over(group_code) title("Received gift at 1st PNC visit by treatment group", span) subtitle("Women 15-49 pregnant or had pregnancy since Jan 08", span) ytitle("Proportion of births/miscarriages");
graph export b06_PNC_gift_1, as(pdf) replace;

graph dot b13_083b [pweight=hhpweight], over(group_code) title("Value of gift received at 1st PNC visit by treatment group", span) subtitle("Women 15-49 pregnant or had pregnancy since Jan 08", span) ytitle("Value in RWF"); 
graph export b06_PNC_gift_2, as(pdf) replace;
 
graph pie [pweight=hhpweight], over(b13_087a) sort by(group_code, title("Reasons for not consulting formal facility for PNC", span) subtitle("Women 15-49 pregnant or had pregnancy since Jan 08", span)) legend(size(vsmall));
graph export b06_PNC_provider_3, as(pdf) replace;

restore;


****************************************************
*** Section 13.4: Patient satisfaction and knowledge
****************************************************;

use $cleandatadir/rwhrbf_b07_withstudyarms_withvarformeantests.dta, clear;
preserve;
keep if a1_11a>=15 & a1_11a<=49 & a1_02==2;
lab define group_code_lab 1 "Demand" 2 "Supply" 3 "Demand & Supply" 4 "Control";
lab values group_code group_code_lab;

graph bar b13_096a_1 b13_096b_1 b13_099_1 [pweight=hhpweight], over(group_code) title("Meeting with CHW in last 3 months by treatment group", span) subtitle("Women 15-49", span) legend(label(1 "Met CHW at home") label(2 "Met CHW in community") label(3 "Would recommend CHW (% of those who met CHW)") rows(3)) ytitle("Proportion of women") yscale(titlegap(*2));
graph export b07_CHW_meeting_1, as(pdf) replace;

graph bar b13_097a_1 b13_097b_1 b13_097c_1 b13_097d_1 b13_097e_1 b13_097f_1 b13_097g_1 b13_097h_1 [pweight=hhpweight], over(group_code) title("Type of service provided by CHW by treatment group", span) subtitle("Women 15-49", span) ytitle("Proportion of women") legend(label(1 "ANC referral") label(2 "Delivery referral") label(3 "PNC referral") label(4 "VCT/PMTCT referral") label(5 "FP") label(6 "Child vaccination") label(7 "Child nutrition") label(8 "IEC session") rows(3) size(small)) yscale(titlegap(*2)) ylabe(0(.2)1); 
graph export b07_CHW_services_1, as(pdf) replace;

graph bar b13_098a_1 b13_098a_2 b13_098a_3 [pweight=hhpweight], over(group_code) title("Satisfaction with CHW being knowledgeable and responsive", span) subtitle("by treatment group - Women 15-49", span) legend(label(1 "Satisfied") label(2 "Neutral") label(3 "Unsatisfied") rows(1)) ytitle("Proportion of women");
graph export b07_CHW_satisfaction_1, as(pdf) replace;

graph bar b13_098b_1 b13_098b_2 b13_098b_3 [pweight=hhpweight], over(group_code) title("Satisfaction with sufficient quantity of CHW", span) subtitle("by treatment group - Women 15-49", span) legend(label(1 "Satisfied") label(2 "Neutral") label(3 "Unsatisfied") rows(1)) ytitle("Proportion of women");
graph export b07_CHW_satisfaction_2, as(pdf) replace;

graph bar b13_098c_1 b13_098c_2 b13_098c_3 [pweight=hhpweight], over(group_code) title("Satisfaction with CHW's time and availability", span) subtitle("by treatment group - Women 15-49", span) legend(label(1 "Satisfied") label(2 "Neutral") label(3 "Unsatisfied") rows(1)) ytitle("Proportion of women");
graph export b07_CHW_satisfaction_3, as(pdf) replace;

graph bar b13_098d_1 b13_098d_2 b13_098d_3 [pweight=hhpweight], over(group_code) title("Satisfaction with CHW's respect for privacy and confidentiality", span) subtitle("by treatment group - Women 15-49", span) legend(label(1 "Satisfied") label(2 "Neutral") label(3 "Unsatisfied") rows(1)) ytitle("Proportion of women");
graph export b07_CHW_satisfaction_4, as(pdf) replace;

graph bar b13_098e_1 b13_098e_2 b13_098e_3 [pweight=hhpweight], over(group_code) title("Satisfaction with CHW showing respect", span) subtitle("by treatment group - Women 15-49", span) legend(label(1 "Satisfied") label(2 "Neutral") label(3 "Unsatisfied") rows(1)) ytitle("Proportion of women");
graph export b07_CHW_satisfaction_5, as(pdf) replace;

graph bar b13_098f_1 b13_098f_2 b13_098f_3 [pweight=hhpweight], over(group_code) title("Satisfaction with CHW being a role model", span) subtitle("by treatment group - Women 15-49", span) legend(label(1 "Satisfied") label(2 "Neutral") label(3 "Unsatisfied") rows(1)) ytitle("Proportion of women");
graph export b07_CHW_satisfaction_6, as(pdf) replace;

graph dot b13_098_1 [pweight=hhpweight], over(group_code) title("General satisfaction with CHW - 0-1 score by treatment group", span) subtitle("Women 15-49", span) ytitle("0 to 1 satisfaction score");
graph export b07_CHW_satisfaction_7, as(pdf) replace;

graph bar b13_100_1 b13_100_2 b13_100_3 b13_100_4 b13_100_96 [pweight=hhpweight], over(group_code) title("Reasons for not recommending CHW by treatment group", span) subtitle("Women 15-49", span) legend(label(1 "Poor quality of care") label(2 "Not helpful") label(3 "Treatment too expensive") label(4 "Difficult to access") label(5 "Other") rows(3)) ytitle("Proportion of women");
graph export b07_CHW_unsatisfaction_1, as(pdf) replace;

restore;


***********************************
*** Section 13.5: Height and Weight
***********************************;

use $cleandatadir/rwhrbf_b09_withstudyarms_withvarformeantests.dta, clear;
preserve;
keep if a1_02==2;
lab define group_code_lab 1 "Demand" 2 "Supply" 3 "Demand & Supply" 4 "Control";
lab values group_code group_code_lab;

graph dot b13_118_1 b13_121 b13_123 [pweight=hhpweight], over(group_code) title("Women's age, height and weight by treatment group", span) subtitle("Women who gave birth in last 4 months") legend(label(1 "Age in years") label(2 "Height in centimeters") label(3 "Weight in kilograms") rows(2)) ytitle("") ylabel(0(20)160);
graph export b09_age_height_weight_1, as(pdf) replace;

restore;


***********************************************
*** Section 14.1: Health status and utilization
***********************************************;

use $cleandatadir/rwhrbf_c01_withstudyarms_withvarformeantests.dta, clear;
preserve;
keep if a1_11a<5;
lab define group_code_lab 1 "Demand" 2 "Supply" 3 "Demand & Supply" 4 "Control";
lab values group_code group_code_lab;

graph bar c14_05_1 [pweight=hhpweight], over(group_code) title("Sickness in last 4 weeks by treatment group", span) subtitle("Children under 5 years old") ytitle("Proportion of children");
graph export c01_sickness_1, as(pdf) replace;

graph bar c14_06a_1 c14_06a_2 c14_06a_3 c14_06a_4 c14_06a_5 c14_06a_6 c14_06a_7 c14_06a_8 c14_06a_9 c14_06a_10 c14_06a_11 c14_06a_12 c14_06a_13 c14_06a_14 c14_06a_15 c14_06a_16 c14_06a_17 c14_06a_18 c14_06a_19 c14_06a_96 [pweight=hhpweight], over(group_code) title("Main disease in last 4 weeks by treatment group", span) subtitle("Children under 5 years old", span) legend(label(1 "Fever/Malaria") label(2 "Cough/Chest infection") label(3 "TB") label(4 "Asthma") label(5 "Bronchitis") label(6 "Pneumonia") label(7 "Diarrhea w/t blood") label(8 "Diarrhea with blood") label(9 "Diarrhea&vomiting") label(10 "Vomiting") label(11 "Abdominal pain") label(12 "Anemia") label(13 "Skin/Rash infection") label(14 "Eye/Ear infection") label(15 "Measles") label(16 "Jaundice") label(17 "Convulsions") label(18 "Sore throat") label(19 "Accident injuries") label(20 "Other") rows(7) size(small)) ytitle("Proportion of children");
graph export c01_sickness_2, as(pdf) replace;

graph dot c14_08a_2 [pweight=hhpweight], over(group_code) title("Duration of illness in days by treatment group", span) subtitle("Children under 5 years old", span) ytitle("Nr. days");
graph export c01_sickness_3, as(pdf) replace;

graph bar c14_10_4 c14_11_4 c14_12_1 if c14_09_1==1 [pweight=hhpweight], over(group_code) title("Treatments against diarrhea by treatment group", span) subtitle("Children under 5 years old", span) legend(label(1 "More water") label(2 "Continued feeding") label(3 "ORS") rows(1)) ytitle("Proportion of children");
graph export c01_diarrhea_1, as(pdf) replace;

graph bar c14_12a_1 c14_12a_2 c14_12a_3 c14_12a_4 c14_12a_5 c14_12a_6 c14_12a_7 c14_12a_8 c14_12a_9 c14_12a_10 c14_12a_11 c14_12a_12 c14_12a_96 [pweight=hhpweight], over(group_code) title("Place where ORS was obtained by treatment group", span) subtitle("Children under 5 years old", span) legend(label(1 "Govt hospital") label(2 "Govt health center") label(3 "Govt health post") label(4 "Private hospital") label(5 "Private health center") label(6 "Private health post") label(7 "Pharmacy") label(8 "Medical personnel") label(9 "Traditional healher") label(10 "Faith/Church healer") label(11 "CHW") label(12 "Friends/Neighbors") label(13 "Other") rows(5) size(small)) ytitle("Proportion of children");
graph export c01_diarrhea_2, as(pdf) replace;

graph dot c14_25_1 c14_25_2 [pweight=hhpweight], over(group_code) title("Consultation costs in last 4 weeks in RWF by treatment group", span) subtitle("Children under 5 years old", span) legend(label(1 "Costs including transportation") label(2 "Costs excluding transportation")) ytitle("Price in RWF");
graph export c01_consultation_costs_1, as(pdf) replace;

graph bar c14_25a c14_25b c14_25c c14_25d c14_25e [pweight=hhpweight], over(group_code) title("Treatment costs in last 4 weeks in RWF by treatment group", span) subtitle("Children under 5 years old", span) legend(label(1 "Mutuelle copayment") label(2 "Registration fees") label(3 "Consultation fees") label(4 "Lab fees") label(5 "Transportation") rows(3)) ytitle("Price in RWF");
graph export c01_consultation_costs_2, as(pdf) replace;

graph bar c14_31_1 [pweight=hhpweight], over(group_code) title("Proportion of children who took drugs to treat their main disease by treatment group", span size(medsmall)) subtitle("Children under 5 years old", span size(medsmall)) ytitle("Proportion of children");
graph export c01_drugs_1, as(pdf) replace;

graph bar c14_40_1 c14_40_2 c14_40_3 [pweight=hhpweight], over(group_code) title("Illness outcome by treatment group", span) subtitle("Children under 5 years old", span) legend(label(1 "Full recovery") label(2 "Partial recovery") label(3 "Not recovered yet")) ytitle("Proportion of children");
graph export c01_sickness_4, as(pdf) replace;

graph bar c14_31a_100 c14_12_100 [pweight=hhpweight], over(group_code) title("Child health status and utilization indicators by treatment group", span size(medsmall)) subtitle("Children under 5 years old", span size(medsmall)) legend(label(1 "Effective case management malaria (WHO)") label(2 "ORS/Fluids & Feeding if diarrhea") rows(2)) ytitle("Proportion of children") yscale(titlegap(*2));
graph export c01_sickness_ind_1, as(pdf) replace;

graph dot c14_39 [pweight=hhpweight], over(group_code) title("Nr. days of inactivity due to illness in last 4 weeks", span) subtitle("by treatment group - Children under 5 years old") ytitle("Duration in days");
graph export c01_sickness_5, as(pdf) replace;

restore;


***************************
*** Section 15: Vaccination
***************************;

use $cleandatadir/rwhrbf_c02_withstudyarms_withvarformeantests.dta, clear;
preserve;
keep if a1_11a<5;
lab define group_code_lab 1 "Demand" 2 "Supply" 3 "Demand & Supply" 4 "Control";
lab values group_code group_code_lab;

graph bar c15_05h_100 c15_05h_101 c15_05i_100 c15_05i_101 c15_05i_102 c15_05i_103 c15_05j_100 c15_05j_101 [pweight=hhpweight], over(group_code) title("Child vaccination and immunization indicators by treatment group", span size(medsmall)) subtitle("Children under 5 years old", span size(medsmall)) legend(label(1 "Pentavalent immunization coverage 12-23m (denominator:all children)") label(2 "Pentavalent immunization coverage 12-23m (denom:children w/vaccination card)")  label(3 "Measles immunization coverage 12-23m (denom:all children)") label(4 "Measles immunization coverage 12-23m (denom:children w/vaccination card)") label(5 "Measles immunization coverage 0-12m (denom:all children)") label(6 "Measles immunization coverage 0-12m (denom:children w/vaccination card)") label(7 "Vitamin A coverage last 6 months (denom:all children)") label(8 "Vitamin A coverage last 6 months (denom:children w/vaccination card)") rows(8) size(small)) ytitle("Proportion of children");
graph export c02_vaccination_1, as(pdf) replace;

restore;


****************************
*** Section 15: Immunization
****************************;

use $cleandatadir/rwhrbf_c03_withstudyarms_withvarformeantests.dta, clear;
preserve;
keep if a1_11a<5;
lab define group_code_lab 1 "Demand" 2 "Supply" 3 "Demand & Supply" 4 "Control";
lab values group_code group_code_lab;

graph bar c15_06_1 c15_07_1 c15_08_1 c15_08_1 [pweight=hhpweight], over(group_code) title("Had other vaccinations than those on card, by treatment group", span size(medsmall)) subtitle("Children under 5 years old", span size(medsmall)) legend(label(1 "Received vaccines not on card") label(2 "Ever had card if not presented at interview") label(3 "Ever vaccinated if no card") rows(3)) ytitle("Proportion of children");
graph export c03_immunization_1, as(pdf) replace;

graph bar c15_20_1 c15_20_2 c15_20_3 c15_20_4 c15_20_5 c15_20_6 c15_20_7 c15_20_8 c15_20_9 c15_20_10 c15_20_11 c15_20_96 [pweight=hhpweight], over(group_code) title("Place of vaccination if vaccinated in last 3 months by treatment group", span size(medsmall)) subtitle("Children under 5 years old", span size(medsmall)) legend(label(1 "Govt hospital") label(2 "Govt health center") label(3 "Govt health post") label(4 "Private hospital") label(5 "Private health center") label(6 "Private health post") label(7 "Pharmacy") label(8 "Medical staff") label(9 "Traditional healer") label(10 "Faith healer") label(11 "CHW") label(12 "Other") rows(6)) ytitle("Proportion of children");
graph export c03_immunization_2, as(pdf) replace;

restore;


**********************************
*** Section 16.1 Height and Weight
**********************************;

use $cleandatadir/rwhrbf_c04_withstudyarms_withvarformeantests.dta, clear;
preserve;
keep if a1_11a<5;
lab define group_code_lab 1 "Demand" 2 "Supply" 3 "Demand & Supply" 4 "Control";
lab values group_code group_code_lab;

graph bar c16_02_1 c16_06_1 c16_06_2 c16_06_3 [pweight=hhpweight], over(group_code) title("Measurement in last 6 months by treatment group", span) subtitle("Children under 5 years old", span) legend(label(1 "Was measured in last 6 months") label(2 "Result if measured: No malnutrition") label(3 "Result if measured: Risk of malnutrition") label(4 "Result if measured: Severe malnutrition") rows(4)) ytitle("Proportion of children");
graph export c04_measurement_1, as(pdf) replace;

graph bar c16_07_1 c16_07_2 c16_07_3 c16_07_11 c16_07_13 [pweight=hhpweight], over(group_code) title("Referral if malnourished at last measurement by treatment group", span size(medsmall)) subtitle("Children under 5 years old", span size(medsmall)) legend(label(1 "Referred to Govt hospital") label(2 "Referred to Govt health center") label(3 "Referred to Govt health post") label(4 "Referred to CHW") label(5 "Not referred") rows(3)) ytitle("Proportion of children");
graph export c04_malnutrition_referral_1, as(pdf) replace;

graph bar c16_08a_1 c16_08b_1 c16_08c_1 c16_08d_1 c16_08e_1 c16_08f_1 [pweight=hhpweight], over(group_code) title("Treatments if malnourished at last measurement by treatment group", span size(medsmall)) subtitle("Children under 5 years old", span size(medsmall)) legend(label(1 "Vitamin A") label(2 "Advise") label(3 "Rehabilitation") label(4 "Coartem") label(5 "Referred to higher level") label(6 "Other treatment") rows(3)) ytitle("Proportion of children");
graph export c04_malnutrition_treatments_1, as(pdf) replace;

graph bar c16_09_1 c16_09_2 c16_09_5 c16_09_6 c16_12_1 c16_12_2 [pweight=hhpweight], over(group_code) title("Measure at interview by treatment group", span) subtitle("Children under 5 years old", span) legend(label(1 "Child measured") label(2 "Not measured:not present") label(3 "Not measured:ill") label(4 "Not measured:refusal") label(5 "If measured:Measured standing") label(6 "If measured:Measured lying") rows(3)) ytitle("Proportion of children");
graph export c04_measurement_2, as(pdf) replace;

graph bar c16_14_1 c16_14_2 c16_14_3 [pweight=hhpweight], over(group_code) title("Upper-Arm Circunference measurement result by treatment group", span size(medsmall)) subtitle("Children under 5 years old", span size(medsmall)) legend(label(1 "No malnutrition (green)") label(2 "Risk of malnutrition (yellow)") label(3 "Severe malnutrition (red)") rows(3)) ytitle("Proportion of children");
graph export c04_measurement_uacm_1, as(pdf) replace;

graph bar _fwfl _flen _fwei _fbmi [pweight=hhpweight], over(group_code) title("Biologically implausible values of Z-scores by treatment group", span) subtitle("Children under 5 years old", span) legend(label(1 "Weight-for-Length Z-score implausible") label(2 "Length-for-age Z-score implausible") label(3 "Weight-for-age Z-score implausible") label(4 "BMI-for-age Z-score implausible") rows(4)) ytitle("Proportion of children");
graph export c04_zscores_1, as(pdf) replace;

graph dot _zwei_clean _zlen_clean _zwfl_clean _zbmi_clean [pweight=hhpweight], over(group_code) title("Z-scores by treatment group (plausible values only)", span) subtitle("Children under 5 years old", span) legend(label(1 "Weight-for-age Z-score") label(2 "Length-for-age Z-score") label(3 "Weight-for-height Z-score") label(4 "BMI-for-age Z-score") rows(4)) ytitle("Z-score value");
graph export c04_zscores_2, as(pdf) replace;

graph bar c16_13_100 c16_13_101 c16_13_102 c16_13_103 c16_13_104 c16_13_105 c16_11_100 c16_11_101 c16_11_102 c16_11_103 [pweight=hhpweight], title("Z-score indicators (plausible values only)", span) subtitle("Children under 5 years old", span) legend(label(1 "Moderate/Severe underwght 0-59m") label(2 "Severe underweight 0-59m") label(3 "Moderate/Severe wasting 0-23m") label(4 "Severe wasting 0-23m") label(5 "Moderate/Severe wasting 0-59m (WHO)") label(6 "Severe wasting 0-59m (WHO)") label(7 "Moderate/Severe stunting 24-59m") label(8 "Severe stunting 24-59m") label(9 "Moderate/Severe stunting 0-59m (WHO)") label(10 "Severe stunting 0-59m (WHO)") rows(5) size(small)) ytitle("Proportion of children");
graph export c04_zscores_ind_1, as(pdf) replace;

graph bar c16_13_100 c16_13_101 c16_13_102 c16_13_103 c16_13_104 c16_13_105 c16_11_100 c16_11_101 c16_11_102 c16_11_103 [pweight=hhpweight], over(group_code) title("Z-score indicators by treatment group (plausible values only)", span) subtitle("Children under 5 years old", span) legend(label(1 "Moderate/Severe underwght 0-59m") label(2 "Severe underweight 0-59m") label(3 "Moderate/Severe wasting 0-23m") label(4 "Severe wasting 0-23m") label(5 "Moderate/Severe wasting 0-59m (WHO)") label(6 "Severe wasting 0-59m (WHO)") label(7 "Moderate/Severe stunting 24-59m") label(8 "Severe stunting 24-59m") label(9 "Moderate/Severe stunting 0-59m (WHO)") label(10 "Severe stunting 0-59m (WHO)") rows(5) size(small)) ytitle("Proportion of children");
graph export c04_zscores_ind_2, as(pdf) replace;

graph bar c16_13_100 c16_13_101 c16_13_102 c16_13_103 c16_13_104 c16_13_105 c16_11_100 c16_11_101 c16_11_102 c16_11_103 [pweight=hhpweight], over(a1_02) title("Z-score indicators by gender (plausible values only)", span) subtitle("Children under 5 years old", span) legend(label(1 "Moderate/Severe underwght 0-59m") label(2 "Severe underweight 0-59m") label(3 "Moderate/Severe wasting 0-23m") label(4 "Severe wasting 0-23m") label(5 "Moderate/Severe wasting 0-59m (WHO)") label(6 "Severe wasting 0-59m (WHO)") label(7 "Moderate/Severe stunting 24-59m") label(8 "Severe stunting 24-59m") label(9 "Moderate/Severe stunting 0-59m (WHO)") label(10 "Severe stunting 0-59m (WHO)") rows(5) size(small)) ytitle("Proportion of children");
graph export c04_zscores_ind_3, as(pdf) replace;

restore;


******************************
*** Section 16.2: Anemia tests
******************************;


use $cleandatadir/rwhrbf_c05_withstudyarms_withvarformeantests.dta, clear;
preserve;
keep if a1_11a<5;
lab define group_code_lab 1 "Demand" 2 "Supply" 3 "Demand & Supply" 4 "Control";
lab values group_code group_code_lab;

graph bar c16_16_1 c16_19_1 c16_20_1 [pweight=hhpweight], over(group_code) title("Anemia tests by treatment group", span) subtitle("Children under 5 years old", span) legend(label(1 "Mother consented to anemia test") label(2 "Anemia detected") label(3 "Referral accepted if anemia detected") rows(2)) ytitle("Proportion of children");

graph export c05_anemia_1, as(pdf) replace;

restore;

log close;
