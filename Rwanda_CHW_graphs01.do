*Matt Mulligan Nov 11
*Creates graphs for CHW Survey
*To be used with Master do file
capture log close
set more off

gl clean "L:\Rwanda CHW Report\Stata Files\Updated Data"
gl output "L:\Rwanda CHW Report\Stata Files\Output\Graphs"

***************************************************************************************************
*Section 1 Graphs
********************************************

//If F-test is significant at ***


****How Long Have CHW Lived in the Village**************************************

use "$clean\rwHRBF_D CHWs -01", clear

***Specialization of CHW


graph pie, over(d1_00) sort title("Specialization of CHW") plabel(5 percent, size(4) format(%2.0f)) plabel(4 percent, size(4) format(%2.0f)) plabel(3 percent, size(4) format(%2.0f)) plabel(2 percent, size(4) format(%2.0f)) pie(5 , explode) legend( symxsize(3)) note("Source: Authors")
graph export "$output/CHW01_special_CHW.emf", replace


preserve

gen wmean = .
gen wse = .
gen wn = .
foreach x of numlist 1/4 {
	regress d1_04 if group_code == `x', vce(cluster hrbf_id1)  
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
	title("Time CHW Lived in the Respective Village", span) subtitle("By Treatment Group", span)  ///
	ylabel(0(10)30) xlabel(1 "Demand" 2 "Supply" 3 "Demand & Supply" 4 "Control") ///
	xtitle("") ytitle("Years") ///
	note("Source: Authors", span)
	graph export "$output/CHW01_time_livedinvill_btg.emf", replace

clear

******Criteria for becoming a CHW elected BY TG ***************************

restore, preserve

gen wmean = .
gen wse = .
gen wn = .
replace d1_07a_2 = d1_07a_2*100
foreach x of numlist 1/4 {
	regress d1_07a_2 if group_code == `x', vce(cluster hrbf_id1)  
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
	title("CHW Must be Elected to Posistion", span) subtitle("By Treatment Group", span)  ///
	ylabel(0(25)100) xlabel(1 "Demand" 2 "Supply" 3 "Demand & Supply" 4 "Control") ///
	xtitle("") ytitle("%") ///
	note("Source: Authors", span)
	graph export "$output/CHW01_eligib_critera_btg.emf", replace

clear

restore, preserve
********************Eligibility Criteria************
graph pie, over(d1_06) sort title("Recruitment of CHW", span) note("Source: Authors", span) 
graph export "$output/CHW01_recruited.emf", replace

graph pie, over(d1_01) sort title("Percentage of CHW's Female", span) note("Source: Authors", span) plabel(_all percent, size(6))
graph export "$output/CHW01__female.emf", replace

graph bar d1_07a_2 d1_07b_2 d1_07c_2 d1_07d_2 d1_07e_2, over(group_code, relabel(1 "Demand" 2 "Supply" 3 "Demand & Supply" 4 "Control")) title("Eligibility Criteria To Become Member of CHW Cooperative", span) subtitle("By Treatment Group", span) note("Source: Authors", span) ///
ytitle("Proportion CHWs") legend(order(1 "Elected by Village" 2 "Letter Request" 3 "Over 16 Years Old" 4 "One Time Membership Fee" 5 "Other"))
graph export "$output/CHW01_eligibiliy_criteria_all.emf", replace
clear
********************Number of Households responsibile for********************

restore, preserve

gen wmean = .
gen wse = .
gen wn = .

foreach x of numlist 1/4 {
	regress d1_17 if group_code == `x', vce(cluster hrbf_id1)  
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
	title("Number of Households CHW is Responsible For", span) subtitle("By Treatment Group", span)  ///
	ylabel(0(20)140) xlabel(1 "Demand" 2 "Supply" 3 "Demand & Supply" 4 "Control") ///
	xtitle("") ytitle("Number of Households") ///
	note("Source: Authors", span)
	graph export "$output/CHW01_numberhouseholdres_btg.emf", replace
clear

**********************Length of Time Worked as  CHW ******************
restore, preserve

gen wmean = .
gen wse = .
gen wn = .

foreach x of numlist 1/4 {
	regress d1_13y if group_code == `x', vce(cluster hrbf_id1)  
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
	title("Length of Time Worked as a CHW", span) subtitle("By Treatment Group", span)  ///
	ylabel(0(1)5) xlabel(1 "Demand" 2 "Supply" 3 "Demand & Supply" 4 "Control") ///
	xtitle("") ytitle("Years") ///
	note("Source: Authors", span)
	graph export "$output/CHW01_timeworkedasCHW_btg.emf", replace
clear

exit