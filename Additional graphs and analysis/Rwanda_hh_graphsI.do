*Matt Mulligan Nov 11- built on work by Elisa Nov 10


*Creates Updated Graphs with Error bars for Household Report

*Directory

capture log close

set more off

//Directory for Datasets and Graph Files
global cleandatadir "L:/Rwanda/data/clean"
global rwandaupdatedgraphs "L:/Rwanda Household Report/UpdatedGraphs\Graphs"
global loganddofiles "L:/Rwanda Household Report/UpdatedGraphs"
capture log close
log using "$loganddofiles/bargraphci.log", replace
set more off

//replace a1_12=7 if a1_12==96;   

*Average Size of Household
use "$cleandatadir/rwhrbf_a01_withstudyarms_withvarformeantests.dta"
//Part 1 Creates Mean, SD, and n with appropiate weighting and clustering.
gen wmean = .
gen wse = .
gen wn = .
svyset [pweight=hhpweight], psu(hrbf_id1)
foreach x of numlist 1/4 {
	svy: mean a1_hhsize  if group_code == `x'
	mat a= e(b)
	mat b= el(e(V),1,1)^(1/2)
	scalar m`x'= a[1,1]
	scalar y`x'= b[1,1]
	replace wmean = m`x' if group_code==`x'
	replace wse = y`x' if group_code==`x'
	replace wn = e(N) if group_code==`x'
}

collapse  mean=wmean sd=wse n=wn, by(group_code)

generate hi = mean + invttail(n-1,0.025)*(sd)
generate lo = mean - invttail(n-1,0.025)*(sd)

graph twoway (bar mean group_code if group_code==1) /// 
	(bar mean group_code if group_code==2) ///
	(bar mean group_code if group_code==3) ///
	(bar mean group_code if group_code==4) ///
	(rcap hi lo group_code, color(black)), ///
	legend(off) ///
	title("Average Size of Households", span) subtitle("By Treatment Group", span)  ///
	ylabel(0(1)6) xlabel(1 "Demand" 2 "Supply" 3 "Demand & Supply" 4 "Control") ///
	xtitle("") ytitle("Mean Family Size") ///
	note("Source: Authors", span)
	graph export "$rwandaupdatedgraphs/a01_hhsize.emf", replace

clear

*Insurance Coverage by Study Arm
use "$cleandatadir/rwhrbf_a01_withstudyarms_withvarformeantests.dta"
gen wmean = .
gen wse = .
gen wn = .
svyset [pweight=hhpweight], psu(hrbf_id1)
foreach x of numlist 1/4 {
	svy: mean a1_20_01  if group_code == `x'
	mat a= e(b)
	mat b= el(e(V),1,1)^(1/2)
	scalar m`x'= a[1,1]
	scalar y`x'= b[1,1]
	replace wmean = m`x' if group_code==`x'
	replace wse = y`x' if group_code==`x'
	replace wn = e(N) if group_code==`x'
}

collapse  mean=wmean sd=wse n=wn, by(group_code)


generate hi = mean + invttail(n-1,0.025)*(sd)
generate lo = mean - invttail(n-1,0.025)*(sd)

twoway(bar mean group_code if group_code==1) /// 
	(bar mean group_code if group_code==2) ///
	(bar mean group_code if group_code==3) ///
	(bar mean group_code if group_code==4) ///
	(rcap hi lo group_code, color(black)), ///
	legend(off) ///
	title("Insurance coverage of All Participants", span) subtitle("By Treatment Group", span) ///
	ylabel(0(.2)1) ///
	xlabel(1 "Demand" 2 "Supply" 3 "Demand & Supply" 4 "Control") ///
	xtitle("") ytitle("Proportion Currently Covered by Mutuelle") ///
	note("Source: Authors", span)
	graph export "$rwandaupdatedgraphs/a01_mutuellecoverage.emf", replace

clear

*Daily Pay in Primary Activity (Difficult to add Secondary Activity) 
use "$cleandatadir/rwhrbf_a03_withstudyarms_withvarformeantests.dta"
preserve
keep if a1_11a>11
gen wmean = .
gen wse = .
gen wn = .
svyset [pweight=hhpweight], psu(hrbf_id1)
foreach x of numlist 1/4 {
	svy: mean a3_04_1  if group_code == `x'
	mat a= e(b)
	mat b= el(e(V),1,1)^(1/2)
	scalar m`x'= a[1,1]
	scalar y`x'= b[1,1]
	replace wmean = m`x' if group_code==`x'
	replace wse = y`x' if group_code==`x'
	replace wn = e(N) if group_code==`x'
}

collapse  mean=wmean sd=wse n=wn, by(group_code)


generate hi = mean + invttail(n-1,0.025)*(sd)
generate lo = mean - invttail(n-1,0.025)*(sd)


twoway (bar mean group_code if group_code==1) ///
	(bar mean group_code if group_code==2) ///
	(bar mean group_code if group_code==3) ///
	(bar mean group_code if group_code==4) ///
	(rcap hi lo group_code, color(black)), ///
	legend(off) ///
	title("Daily Pay in Primary Activity in Last 12m (12y and Older)", span) subtitle("By Treatment Group", span) ///
	ylabel(0(200)1200) ///
	xlabel(1 "Demand" 2 "Supply" 3 "Demand & Supply" 4 "Control") ///
	xtitle("") ytitle("Daily Pay (RWF)") ///
	note("Source: Authors", span)
	graph export "$rwandaupdatedgraphs/a03_prim_dailypay.emf", replace

clear
restore
**Secondary Pay
keep if a1_11a>11
gen wmean = .
gen wse = .
gen wn = .
svyset [pweight=hhpweight], psu(hrbf_id1)
foreach x of numlist 1/4 {
	svy: mean a3_11_1  if group_code == `x'
	mat a= e(b)
	mat b= el(e(V),1,1)^(1/2)
	scalar m`x'= a[1,1]
	scalar y`x'= b[1,1]
	replace wmean = m`x' if group_code==`x'
	replace wse = y`x' if group_code==`x'
	replace wn = e(N) if group_code==`x'
}

collapse  mean=wmean sd=wse n=wn, by(group_code)


generate hi = mean + invttail(n-1,0.025)*(sd)
generate lo = mean - invttail(n-1,0.025)*(sd)


twoway (bar mean group_code if group_code==1) ///
	(bar mean group_code if group_code==2) ///
	(bar mean group_code if group_code==3) ///
	(bar mean group_code if group_code==4) ///
	(rcap hi lo group_code, color(black)), ///
	legend(off) ///
	title("Daily Pay in Secondary Activity in Last 12m (12y and Older)", span) subtitle("By Treatment Group", span) ///
	ylabel(0(400)2400) ///
	xlabel(1 "Demand" 2 "Supply" 3 "Demand & Supply" 4 "Control") ///
	xtitle("") ytitle("Daily Pay (RWF)") ///
	note("Source: Authors", span)
	graph export "$rwandaupdatedgraphs/a03_sec_dailypay.emf", replace
clear
*Not Including Secondary because of Smaller Sample Size
//graph dot a3_11_1 [pweight=hhpweight], over(group_code) title("Daily pay in secondary activity in last 12m in RWF by treatment group", size(medsmall) span) subtitle("12y and older", size(medsmall) span) ytitle("Daily pay in RWF");
//graph export a03_daily_pay_sec_1, as(pdf) replace;

*Current Value of Total Material Assets
use "$cleandatadir/rwhrbf_a05_with_1obs_for_1hh_withstudyarms_withvarformeantests.dta"

gen wmean = .
gen wse = .
gen wn = .
svyset [pweight=hhpweight], psu(hrbf_id1)
foreach x of numlist 1/4 {
	svy: mean a6_02_100  if group_code == `x'
	mat a= e(b)
	mat b= el(e(V),1,1)^(1/2)
	scalar m`x'= a[1,1]
	scalar y`x'= b[1,1]
	replace wmean = m`x' if group_code==`x'
	replace wse = y`x' if group_code==`x'
	replace wn = e(N) if group_code==`x'
}

collapse  mean=wmean sd=wse n=wn, by(group_code)


generate hi = mean + invttail(n-1,0.025)*(sd)
generate lo = mean - invttail(n-1,0.025)*(sd)


twoway (bar mean group_code if group_code==1) ///
	(bar mean group_code if group_code==2) ///
	(bar mean group_code if group_code==3) ///
	(bar mean group_code if group_code==4) ///
	(rcap hi lo group_code, color(black)), ///
	legend(off) ///
	title("Current Value of Material Assets", span) subtitle("By Treatment Group", span) ///
	ylabel(0(25000)102000) ///
	xlabel(1 "Demand" 2 "Supply" 3 "Demand & Supply" 4 "Control") ///
	xtitle("") ytitle("Value of Assets (RWF)") ///
	note("Source: Authors", span)
	graph export "$rwandaupdatedgraphs/a05_value_materassets.emf", replace

clear

*Income Outside of Employment by Treatment Group

use "$cleandatadir/rwhrbf_a07_with_1obs_for_1hh_withstudyarms_withvarformeantests.dta"

gen wmean = .
gen wse = .
gen wn = .
svyset [pweight=hhpweight], psu(hrbf_id1)
foreach x of numlist 1/4 {
	svy: mean a7_01_100  if group_code == `x'
	mat a= e(b)
	mat b= el(e(V),1,1)^(1/2)
	scalar m`x'= a[1,1]
	scalar y`x'= b[1,1]
	replace wmean = m`x' if group_code==`x'
	replace wse = y`x' if group_code==`x'
	replace wn = e(N) if group_code==`x'
}

collapse  mean=wmean sd=wse n=wn, by(group_code)


generate hi = mean + invttail(n-1,0.025)*(sd)
generate lo = mean - invttail(n-1,0.025)*(sd)


twoway (bar mean group_code if group_code==1) ///
	(bar mean group_code if group_code==2) ///
	(bar mean group_code if group_code==3) ///
	(bar mean group_code if group_code==4) ///
	(rcap hi lo group_code, color(black)), ///
	legend(off) ///
	title("Income Outside of Employment", span) subtitle("By Treatment Group", span) ///
	ylabel(0(25000)120000) ///
	xlabel(1 "Demand" 2 "Supply" 3 "Demand & Supply" 4 "Control") ///
	xtitle("") ytitle("Income Outside of Employment (RWF)") ///
	note("Source: Authors", span)
	graph export "$rwandaupdatedgraphs/a07_income_outsideemploy.emf", replace
	
clear

*Age of the Most Recently Deceased IndividualBy Study Arm
use "$cleandatadir/rwhrbf_a08_with_1obs_for_1hh_withstudyarms_withvarformeantests.dta"



gen wmean = .
gen wse = .
gen wn = .
svyset [pweight=hhpweight], psu(hrbf_id1)
foreach x of numlist 1/4 {
	svy: mean a9_06n_1_1  if group_code == `x'
	mat a= e(b)
	mat b= el(e(V),1,1)^(1/2)
	scalar m`x'= a[1,1]
	scalar y`x'= b[1,1]
	replace wmean = m`x' if group_code==`x'
	replace wse = y`x' if group_code==`x'
	replace wn = e(N) if group_code==`x'
}

collapse  mean=wmean sd=wse n=wn, by(group_code)


generate hi = mean + invttail(n-1,0.025)*(sd)
generate lo = mean - invttail(n-1,0.025)*(sd)

//Cannot have a negative value for age..
replace lo = 0 if lo<0 



twoway (bar mean group_code if group_code==1) ///
	(bar mean group_code if group_code==2) ///
	(bar mean group_code if group_code==3) ///
	(bar mean group_code if group_code==4) ///
	(rcap hi lo group_code, color(black)), ///
	legend(off) ///
	title("Average Age of Death", span) subtitle("By Treatment Group", span) ///
	ylabel(0(1)5)  ///
	xlabel(1 "Demand" 2 "Supply" 3 "Demand & Supply" 4 "Control") ///
	xtitle("") ytitle("Age of the Most Recently Deceased Individual (Years)") ///
	note("Source: Authors", span)
	graph export "$rwandaupdatedgraphs/a08_Age_mostrecdeath.emf", replace
	
clear
	
*Number of Days of Illness if Recovered

use "$cleandatadir/rwhrbf_b01_withstudyarms_withvarformeantests.dta" 
keep if a1_11a>=15 & a1_11a<=49 & a1_02==2
gen wmean = .
gen wse = .
gen wn = .
svyset [pweight=hhpweight], psu(hrbf_id1)
foreach x of numlist 1/4 {
	svy: mean b10_07a_4  if group_code == `x'
	mat a= e(b)
	mat b= el(e(V),1,1)^(1/2)
	scalar m`x'= a[1,1]
	scalar y`x'= b[1,1]
	replace wmean = m`x' if group_code==`x'
	replace wse = y`x' if group_code==`x'
	replace wn = e(N) if group_code==`x'
}

collapse  mean=wmean sd=wse n=wn, by(group_code)


generate hi = mean + invttail(n-1,0.025)*(sd)
generate lo = mean - invttail(n-1,0.025)*(sd)
*Cannot have Negative Illness days
replace lo = 0 if lo<0

twoway (bar mean group_code if group_code==1) ///
	(bar mean group_code if group_code==2) ///
	(bar mean group_code if group_code==3) ///
	(bar mean group_code if group_code==4) ///
	(rcap hi lo group_code, color(black)), ///
	legend(off) ///
	title("Length of Illness if Recoverd", span) subtitle("Women 15-49 by Treatment Group", span) ///
	ylabel(0(25)125)  ///
	xlabel(1 "Demand" 2 "Supply" 3 "Demand & Supply" 4 "Control") ///
	xtitle("") ytitle("Length of Illness (Days)") ///
	note("Source: Authors", span)
	graph export "$rwandaupdatedgraphs/b01_days_ofillnessrecovered.emf", replace
	
clear
	
*Value of Gift Received at First ANC Visit
use "$cleandatadir/rwhrbf_b06_withstudyarms_withvarformeantests.dta"
keep if a1_11a>=15 & a1_11a<=49 & a1_02==2
gen wmean = .
gen wse = .
gen wn = .
svyset [pweight=hhpweight], psu(hrbf_id1)
foreach x of numlist 1/4 {
	svy: mean b13_040b  if group_code == `x'
	mat a= e(b)
	mat b= el(e(V),1,1)^(1/2)
	scalar m`x'= a[1,1]
	scalar y`x'= b[1,1]
	replace wmean = m`x' if group_code==`x'
	replace wse = y`x' if group_code==`x'
	replace wn = e(N) if group_code==`x'
}

collapse  mean=wmean sd=wse n=wn, by(group_code)


generate hi = mean + invttail(n-1,0.025)*(sd)
generate lo = mean - invttail(n-1,0.025)*(sd)


twoway (bar mean group_code if group_code==1) ///
	(bar mean group_code if group_code==2) ///
	(bar mean group_code if group_code==3) ///
	(bar mean group_code if group_code==4) ///
	(rcap hi lo group_code, color(black)), ///
	legend(off) ///
	title("Value of Gift Received at First ANC Visit by Treatment Arm", span) subtitle(" Women 15-49 Pregnant or had Pregnancy Since Jan 08", span) ///
	ylabel(0(400)1600)  ///
	xlabel(1 "Demand" 2 "Supply" 3 "Demand & Supply" 4 "Control") ///
	xtitle("") ytitle("Value of Gift (RWF)") ///
	note("Source: Authors", span)
	graph export "$rwandaupdatedgraphs/b06_giftvalue_firstANCvisit.emf", replace
	
clear
	
*Value of Gift Received at First PNC Visit
//Almost no Sample Size so will not produce a graph
use "$cleandatadir/rwhrbf_b06_withstudyarms_withvarformeantests.dta"
keep if a1_11a>=15 & a1_11a<=49 & a1_02==2

gen wmean = .
gen wse = .
gen wn = .
svyset [pweight=hhpweight], psu(hrbf_id1)
foreach x of numlist 1/4 {
	svy: mean b13_083b   if group_code == `x'
	mat a= e(b)
	mat b= el(e(V),1,1)^(1/2)
	scalar m`x'= a[1,1]
	scalar y`x'= b[1,1]
	replace wmean = m`x' if group_code==`x'
	replace wse = y`x' if group_code==`x'
	replace wn = e(N) if group_code==`x'
}

collapse  mean=wmean sd=wse n=wn, by(group_code)


generate hi = mean + invttail(n-1,0.025)*(sd)
generate lo = mean - invttail(n-1,0.025)*(sd)
//Cannot Have negative Cash
replace lo = 0 if lo<0

twoway (bar mean group_code if group_code==1) ///
	(bar mean group_code if group_code==2) ///
	(bar mean group_code if group_code==3) ///
	(bar mean group_code if group_code==4) ///
	(rcap hi lo group_code, color(black)), ///
	legend(off) ///
	title("Value of Gift Received at First PNC Visit by Treatment Arm", span) subtitle(" Women 15-49 Pregnant or had Pregnancy Since Jan 08", span) ///
	xlabel(1 "Demand" 2 "Supply" 3 "Demand & Supply" 4 "Control") ///
	xtitle("") ytitle("Value of Gift (RWF)") ///
	note("Source: Authors", span)
	graph export "$rwandaupdatedgraphs/b06_giftvalue_firstPNCvisit.emf", replace
	
clear


*Value of Gift Received at Delivery by Treatment Group
use "$cleandatadir/rwhrbf_b06_withstudyarms_withvarformeantests.dta"
keep if a1_11a>=15 & a1_11a<=49 & a1_02==2

gen wmean = .
gen wse = .
gen wn = .
svyset [pweight=hhpweight], psu(hrbf_id1)
foreach x of numlist 1/4 {
	svy: mean b13_061b  if group_code == `x'
	mat a= e(b)
	mat b= el(e(V),1,1)^(1/2)
	scalar m`x'= a[1,1]
	scalar y`x'= b[1,1]
	replace wmean = m`x' if group_code==`x'
	replace wse = y`x' if group_code==`x'
	replace wn = e(N) if group_code==`x'
}

collapse  mean=wmean sd=wse n=wn, by(group_code)


generate hi = mean + invttail(n-1,0.025)*(sd)
generate lo = mean - invttail(n-1,0.025)*(sd)
*Cannot Have negative Gift
replace lo = 0 if lo<0

twoway (bar mean group_code if group_code==1) ///
	(bar mean group_code if group_code==2) ///
	(bar mean group_code if group_code==3) ///
	(bar mean group_code if group_code==4) ///
	(rcap hi lo group_code, color(black)), ///
	legend(off) ///
	title("Value of Gift Received at Delivery Visit by Treatment Arm", span) subtitle(" Women 15-49 Pregnant or had Pregnancy Since Jan 08", span) ///
	ylabel(0(1000)5000)  ///
	xlabel(1 "Demand" 2 "Supply" 3 "Demand & Supply" 4 "Control") ///
	xtitle("") ytitle("Value of Gift (RWF)") ///
	note("Source: Authors", span)
	graph export "$rwandaupdatedgraphs/b06_giftvalue_delivery.emf", replace

clear


*Size Of Land

use "$cleandatadir/rwhrbf_a00_withstudyarms_withvarformeantests.dta"

gen wmean = .
gen wse = .
gen wn = .
svyset [pweight=hhpweight], psu(hrbf_id1)
foreach x of numlist 1/4 {
	svy: mean a6_06n_2  if group_code == `x'
	mat a= e(b)
	mat b= el(e(V),1,1)^(1/2)
	scalar m`x'= a[1,1]
	scalar y`x'= b[1,1]
	replace wmean = m`x' if group_code==`x'
	replace wse = y`x' if group_code==`x'
	replace wn = e(N) if group_code==`x'
}

collapse  mean=wmean sd=wse n=wn, by(group_code)
list n


generate hi = mean + invttail(n-1,0.025)*(sd)
generate lo = mean - invttail(n-1,0.025)*(sd)


twoway (bar mean group_code if group_code==1) ///
	(bar mean group_code if group_code==2) ///
	(bar mean group_code if group_code==3) ///
	(bar mean group_code if group_code==4) ///
	(rcap hi lo group_code, color(black)), ///
	legend(off) ///
	title("Size of Land Owned", span) subtitle("By Treatment Group", span) ///
	ylabel(0(10)50) ///
	xlabel(1 "Demand" 2 "Supply" 3 "Demand & Supply" 4 "Control") ///
	xtitle("") ytitle("Size of Land Owned (ha)") ///
	note("Source: Authors", span)
	graph export "$rwandaupdatedgraphs/a05_size_land.emf", replace

clear




*Current Value of Land Owned


use "$cleandatadir/rwhrbf_a00_withstudyarms_withvarformeantests.dta"

gen wmean = .
gen wse = .
gen wn = .
replace a6_07 = a6_07 /100000

svyset [pweight=hhpweight], psu(hrbf_id1)

foreach x of numlist 1/4 {
	svy: mean a6_07  if group_code == `x'
	mat a= e(b)
	mat b= el(e(V),1,1)^(1/2)
	scalar m`x'= a[1,1]
	scalar y`x'= b[1,1]
	replace wmean = m`x' if group_code==`x'
	replace wse = y`x' if group_code==`x'
	replace wn = e(N) if group_code==`x'
}

collapse  mean=wmean sd=wse n=wn, by(group_code)
list n


generate hi = mean + invttail(n-1,0.025)*(sd)
generate lo = mean - invttail(n-1,0.025)*(sd)


twoway (bar mean group_code if group_code==1) ///
	(bar mean group_code if group_code==2) ///
	(bar mean group_code if group_code==3) ///
	(bar mean group_code if group_code==4) ///
	(rcap hi lo group_code, color(black)), ///
	legend(off) ///
	title("Current Value of Land Owned", span) subtitle("By Treatment Group", span) ///
	ylabel(0(5)25) ///
	xlabel(1 "Demand" 2 "Supply" 3 "Demand & Supply" 4 "Control") ///
	xtitle("") ytitle("Value of Land Owned (100,000 RWF)") ///
	note("Source: Authors", span)
	graph export "$rwandaupdatedgraphs/a05_value_land.emf", replace


******* Original vs Current Value  Land

use "$cleandatadir/rwhrbf_a06_with_1obs_for_1hh_withstudyarms_withvarformeantests.dta", clear
graph bar a6_12_100 a6_13_100, over(group_code, relabel(1 "Demand" 2 "Supply" 3 "Demand & Supply" 4 "Control")) title("Original vs. Current Value of Livestock", span)  subtitle("By Treatment Group", span) ytitle("Value (RWF)") legend(label(1 "Value at Purchase") label(2 "Current Estimated Value"))
graph export "$rwandaupdatedgraphs/a06_livestockvalue.emf", replace
clear
***** Health Score by TG and Gender*
use $cleandatadir/rwhrbf_a04_b08_withstudyarms_withvarformeantests.dta, clear
keep if a1_11a>=15 & a1_11a<=49
graph bar a4_healthscore, over(a1_02) over(group_code, relabel(1 "Demand" 2 "Supply" 3 "Demand & Supply" 4 "Control")) title("Health Knowledge Score by Gender and Treatment Group", span) subtitle("All Aged 15-49", span) ytitle("Health Knowledge Score (0-1)") ylabel(0(.2)1)
graph export "$rwandaupdatedgraphs/a04_b08_healthscore_2.emf", replace



*****************************
*** Section 11: Mental Health
*****************************

use "$cleandatadir/rwhrbf_b02_withstudyarms_withvarformeantests.dta", clear
preserve

keep if a1_11a>=15 & a1_11a<=49 & a1_02==2
lab define group_code_lab 1 "Demand" 2 "Supply" 3 "Demand & Supply" 4 "Control"
lab values group_code group_code_lab

graph bar b11_01a_1 b11_01a_2 b11_01a_3 [pweight=hhpweight], over(group_code, relabel(1 "Demand" 2 "Supply" 3 "Demand & Supply" 4 "Control")) ylabel(0(.2)1) title("Feeling Slowed Down in Last 6m", span) subtitle("Women 15-49 by Treatment Group", span) ytitle("Proportion of Women with Feeling for 2 Weeks")  legend(label(1 "Often") label(2 "Sometimes") label(3 "Never") rows(1))
graph export "$rwandaupdatedgraphs/mentalhealth1.emf", replace

graph bar b11_01b_1 b11_01b_2 b11_01b_3 [pweight=hhpweight], over(group_code, relabel(1 "Demand" 2 "Supply" 3 "Demand & Supply" 4 "Control")) ylabel(0(.2)1) title("Feeling Deep Sadness in Last 6m", span) subtitle("Women 15-49 by Treatment Group", span) ytitle("Proportion of Women with Feeling for 2 Weeks")  legend(label(1 "Often") label(2 "Sometimes") label(3 "Never") rows(1))
graph export "$rwandaupdatedgraphs/mentalhealth2.emf", replace

graph bar b11_01c_1 b11_01c_2 b11_01c_3 [pweight=hhpweight], over(group_code, relabel(1 "Demand" 2 "Supply" 3 "Demand & Supply" 4 "Control")) ylabel(0(.2)1) title("Feeling No More Joy in Life in Last 6m", span) subtitle("Women 15-49 by Treatment Group", span) ytitle("Proportion of Women with Feeling for 2 Weeks") yscale(titlegap(*2)) legend(label(1 "Often") label(2 "Sometimes") label(3 "Never") rows(1))
graph export "$rwandaupdatedgraphs/mentalhealth3.emf", replace

graph bar b11_01d_1 b11_01d_2 b11_01d_3 [pweight=hhpweight], over(group_code, relabel(1 "Demand" 2 "Supply" 3 "Demand & Supply" 4 "Control")) ylabel(0(.2)1) title("Feeling Hopeless in Last 6m", span) subtitle("Women 15-49 by Treatment Group", span) ytitle("Proportion of Women with Feeling for 2 Weeks")  legend(label(1 "Often") label(2 "Sometimes") label(3 "Never") rows(1))
graph export "$rwandaupdatedgraphs/mentalhealth4.emf", replace

restore
*************************
use "$cleandatadir/rwhrbf_b06_withstudyarms_withvarformeantests.dta", clear
preserve
keep if a1_11a>=15 & a1_11a<=49 & a1_02==2
lab define group_code_lab 1 "Demand" 2 "Supply" 3 "Demand & Supply" 4 "Control"
lab values group_code group_code_lab

graph bar b13_044_1 [pweight=hhpweight], over(group_code) ylabel(0(.2)1) title("Minimum Tests Performed at ANC During Pregnancy", span) subtitle("Women 15-49 Pregnant or Had Pregnancy Since Jan 08 by Treatment Group", span size(medsmall)) ytitle("Proportion of Births/Pregnancies" "That Had Minimum Tests Performed")
graph export "$rwandaupdatedgraphs/b06_minimumANCtest.emf", replace

capture, log close
end