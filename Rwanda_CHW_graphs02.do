*Matt Mulligan Nov 11
*Creates graphs for CHW Survey
*To be used with Master do file
capture log close
set more off

gl clean "L:\Rwanda CHW Report\Stata Files\Updated Data"
gl output "L:\Rwanda CHW Report\Stata Files\Output\Graphs"


*****************************************************************************************************
*Section 2 Graphs
********************************************************



*Antenatal and Postnatal Care BTG
*************************

use "$clean\rwHRBF_D CHWs -02.dta", clear

preserve

gen wmean = .
gen wse = .
gen wn = .

foreach x of numlist 1/4 {
	regress d2_01c_2 if group_code == `x', vce(cluster hrbf_id1)  
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
	title("Percentage of CHW Trained in Antenatal and Postnatal Care", span) subtitle("By Treatment Group", span)  ///
	ylabel(0(25)1) xlabel(1 "Demand" 2 "Supply" 3 "Demand & Supply" 4 "Control") ///
	xtitle("") ytitle("Frequency Trained") ///
	note("Source: Authors", span)
	graph export "$output/CHW02_antenatal_postnatalcare_btg.emf", replace

clear

restore, preserve

graph bar d2_01b_2 d2_01c_2 d2_01d_2 d2_01f_2, over(group_code, relabel(1 "Demand" 2 "Supply" 3 "Demand & Supply" 4 "Control")) title("Training Received by Treatment Group", span) subtitle("Subjects With Significant Differences at P<.05", span) note("Source: Authors", span) ///
ylabel(0(.25)1) ytitle("Proportion of CHWs") legend(size(2.8) order(1 "Family Planning" 2 "Antenatal and Postnatal Care" 3 "Referral to Facility for Delivery or Danger Signs" 4 "Newborn Care" ))
graph export "$output/CHW02_train_sigdiff.emf", replace

//graph pie d2_02a_2 d2_02b_2 d2_02c_2 d2_02d_2 d2_02e_2, sort title("Source of Training", span) note("Source: Authors", span) plabel(_all percent, format(%2.0f) size(3.3)) legend(size(2.6) order(1 "NGO" 2 "Health Center" 3 "Health Committee" 4 "Ministry of Health" 5 "CHW Cooperative"))
//graph export "$output/CHW02_source_train.emf", replace
//plabel(_all percent, format(%5.1f) size(5.5))
*Should not be represented by a pie graph, because not categorical.

graph bar d2_02a_2 d2_02b_2 d2_02c_2 d2_02d_2 d2_02e_2, over(group_code, relabel(1 "Demand" 2 "Supply" 3 "Demand & Supply" 4 "Control")) title("Source of Training", span) subtitle("By Treatment Group", span) note("Source: Authors", span) ///
ylabel(0(.25)1) ytitle("Proportion of CHWs") legend(size(2.8) order(1 "NGO" 2 "Health Center" 3 "Health Committee" 4 "Ministry of Health" 5 "CHW Cooperative"))
graph export "$output/CHW02_source_train.emf", replace

graph bar d2_04c_2 d2_04j_2 d2_04k_2 d2_04l_2, over(group_code, relabel(1 "Demand" 2 "Supply" 3 "Demand & Supply" 4 "Control")) title("Training Recieved in Last 12 Months by Treatment Group", span) subtitle("Subjects With Significant Differences at P<.05") ///
ylabel(0(.25)1) ytitle("Proportion of CHWs") legend(size(2.5) order(1 "Antenatal and Postnatal Care" 2 "Nutriontion" 3 "Sanitation & Home Hygiene" 4 "Mental Health" ))
graph export "$output/CHW02_subject_train_12m.emf", replace

//graph pie d2_05a_2 d2_05b_2 d2_02c_2 d2_02d_2 d2_02e_2, sort title("Source of Training in Last 12 Months", span)  note("Source: Authors", span) legend(size(2.6) order(1 "NGO" 2 "Health Center" 3 "Health Committee" 4 "Ministry of Health" 5 "CHW Cooperative")) 
//graph export "$output/CHW02_source_train_12m.emf", replace

graph bar d2_05a_2 d2_05b_2 d2_02c_2 d2_02d_2 d2_02e_2, over(group_code, relabel(1 "Demand" 2 "Supply" 3 "Demand & Supply" 4 "Control")) title("Source of Training in Last 12 Months", span) subtitle("By Treatment Group", span) note("Source: Authors", span) ///
ylabel(0(.25)1) ytitle("Proportion of CHWs") legend(size(2.8) order(1 "NGO" 2 "Health Center" 3 "Health Committee" 4 "Ministry of Health" 5 "CHW Cooperative"))
graph export "$output/CHW02_source_train_12m.emf", replace


graph bar d2_06p_2 d2_06r_2 d2_06u_2 d2_06v_2, over(group_code, relabel(1 "Demand" 2 "Supply" 3 "Demand & Supply" 4 "Control")) title("Services Provided in Last 3 Months by Treatment Group", span) subtitle("Services with Significant Differences at P<.05", span) note("Source: Authors", span) ///
ylabel(0(.25)1) ytitle("Proportion of CHWs") legend(size(2.6) symxsize(2.4) order(1 "Mosquito Net Distribution" 2 "Referall and Advising on Disabilities" 3 "Vitamin A Distribution (Child. 6-59m & Nursing Mother)" 4 "SurEau Distribution" ))
graph export "$output/CHW02_services_provided.emf", replace



clear

**************************************************************************************
*Section 3 Graphs
******************************************************************************
restore
clear
use "$clean\rwHRBF_D CHWs -03.dta", clear

graph pie, over(d3_01) sort title("Recieve Monetary Payments For Work", span) plabel(2 percent, size(4.5) format(%2.0f)) note("Source: Authors", span) legend(size(2.6) order(1 "Yes" 2 "No"))
graph export "$output/CHW03_monetary_payment.emf", replace

graph pie, over(d3_04) sort title("Recieve In-Kind Payments For Work", span) plabel(2 percent, size(4.5) format(%2.0f)) note("Source: Authors", span) legend(size(2.6) order(1 "Yes" 2 "No"))
graph export "$output/CHW03_inkind_payment.emf", replace

preserve

gen wmean = .
gen wse = .
gen wn = .

foreach x of numlist 1/4 {
	regress d3_12_2 if group_code == `x', vce(cluster hrbf_id1)  
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
	title("Reported that Cooperative Invests" "In Income Generating Activities", span) subtitle("By Treatment Group", span)  ///
	ylabel(0(.25)1) xlabel(1 "Demand" 2 "Supply" 3 "Demand & Supply" 4 "Control") ///
	xtitle("") ytitle("Proportion of CHWs") ///
	note("Source: Authors", span)
	graph export "$output/CHW03_income_gen_btg.emf", replace

**************************************************************************************
*Section 4 Graphs
******************************************************************************
restore
clear

use "$clean\rwHRBF_D CHWs -04.dta", clear
preserve


graph bar d4_02a_2 d4_02b_2 d4_02c_2 d4_02d_2 d4_02e_2 d4_02fth_2 , over(group_code, relabel(1 "Demand" 2 "Supply" 3 "Demand & Supply" 4 "Control")) title("Supervisor's Organization", span) subtitle("By Treatment Group", span) note("Source: Authors", span) ylabel(0(.25)1) ytitle("Proportion of CHWs") legend(size(2.6) symxsize(3) row(2) order(1 "NGO" 2 "Health Center" 3 "Health Committee" 4 "Ministry of Health" 5 "CHW Cooperative" 6 "Other" ))
graph export "$output/CHW04_supervisor_location.emf", replace


graph bar d4_05a_2 d4_05b_2 d4_05c_2 d4_05d_2 d4_05e_2 d4_05f_2 d4_05g_2 d4_05h_2 d4_05i_2 d4_05j_2 , over(group_code, relabel(1 "Demand" 2 "Supply" 3 "Demand & Supply" 4 "Control")) title("Activities Performed By Supervisor", span) subtitle("By Treatment Group", span) note("Source: Authors", span) ylabel(0(.25)1) ytitle("Proportion of CHWs", margin(small)) legend(size(2.2) col(3) symxsize(3) order(1 "Participates in CHW Meetings" 2 "Supervision of CHW Activities" 3 "Replace CHW Kits" 4 "Support CHW Training" 5 "Provide CHW Training" 6 "Complile Monthly Activity Reports" 7 "Meet with Health Posts" 8 "Promote Specific Health Programs" 9 "Vaccination Campaign Assitance" 10 "General Assistance" ))
graph export "$output/CHW04_supervisor_activities.emf", replace

graph bar d4_05a_2 d4_05b_2 d4_05c_2 d4_05d_2 d4_05e_2 d4_05f_2 d4_05g_2 d4_05h_2 d4_05i_2 d4_05j_2 , title("Activities Performed By Supervisor", span) note("Source: Authors", span) ylabel(0(.25)1) ytitle("Proportion of CHWs", margin(small)) legend(size(2.2) col(3) symxsize(3) order(1 "Participates in CHW Meetings" 2 "Supervision of CHW Activities" 3 "Replace CHW Kits" 4 "Support CHW Training" 5 "Provide CHW Training" 6 "Complile Monthly Activity Reports" 7 "Meet with Health Posts" 8 "Promote Specific Health Programs" 9 "Vaccination Campaign Assitance" 10 "General Assistance" ))
graph export "$output/CHW04_supervisor_activitiesNEW.emf", replace
**************************************************************************************
*Section 5 Graphs
******************************************************************************
restore
clear

use "$clean\rwHRBF_D CHWs -05.dta", clear


graph bar d5_05a_2 d5_05b_2 d5_05c_2 d5_05d_2 d5_05e_2 d5_05fth_2 , over(group_code, relabel(1 "Demand" 2 "Supply" 3 "Demand & Supply" 4 "Control")) title("Type of Support Received From Steering Committee", span) subtitle("By Treatment Group", span) note("Source: Authors", span) yscale(r(0 1) noextend) ylabel(0(.25)1)  ytitle("Proportion of CHWs") legend(size(2.6) keygap(1) symxsize(1.6) col(3) order(1 "Payment for Health Services" 2 "Donation for Health Post" 3 "Mobilize Com. to Use Health Services" 4 "Appreciation/Recognition" 5 "In-kind Contributions" 6 "Other" ))
graph export "$output/CHW05_steering_support_type.emf", replace


*************************************************************************************
*Section 6 Graphs
*******************************************

use "$clean\rwHRBF_D CHWs -06.dta", clear

graph bar d6_01a_2 d6_01b_2 d6_01c_2 d6_01d_2 d6_01e_2 d6_01f_2 d6_01g_2, title("Support Type", span) ylabel(0(.25)1) subtitle("From a Health Center", span) ytitle("Proportion of CHWs", margin(small)) note("Source:Authors") legend(size(2.7) symxsize(2.5) keygap(1) col(3) order(1 "Monetary Compensation" 2 "Non-Monetary Support(Land,Supples)" 3 "Transport" 4 "Appreciation/Recognition" 5 "Improved Supervision" 6 "More Training" 7 "Access to Mobile Technology"))
graph export "$output/CHW06_suppt_healthcenter.emf", replace

graph bar d6_02a_2 d6_02b_2 d6_02c_2 d6_02d_2 d6_02e_2 d6_02f_2 d6_02g_2, title("Support Type", span) ylabel(0(.25)1) subtitle("From the Government", span) ytitle("Proportion of CHWs", margin(small)) note("Source:Authors") legend(size(2.7) symxsize(2.5) keygap(1) col(3) order(1 "Monetary Compensation" 2 "Non-Monetary Support(Land,Supples)" 3 "Transport" 4 "Appreciation/Recognition" 5 "Improved Supervision" 6 "More Training" 7 "Access to Mobile Technology"))
graph export "$output/CHW06_suppt_gov.emf", replace

graph bar d6_03a_2 d6_03b_2 d6_03c_2 d6_03d_2 d6_03e_2 d6_03f_2 d6_03g_2, title("Support Type", span) ylabel(0(.25)1) subtitle("From an NGO", span) ytitle("Proportion of CHWs", margin(small)) note("Source:Authors") legend(size(2.7) symxsize(2.5) keygap(1) col(3) order(1 "Monetary Compensation" 2 "Non-Monetary Support(Land,Supples)" 3 "Transport" 4 "Appreciation/Recognition" 5 "Improved Supervision" 6 "More Training" 7 "Access to Mobile Technology"))
graph export "$output/CHW06_suppt_NGO.emf", replace

graph bar d6_04a_2 d6_04b_2 d6_04c_2 d6_04d_2 d6_04e_2 , title("Support Type", span) note("Source:Authors") ylabel(0(.25)1) subtitle("From the Community", span) bar(3, color(sunflowerlime)) bar(5, color(purple))ytitle("Proportion of CHWs", margin(small)) legend(size(2.7) symxsize(2.5) keygap(1) order(1 "Monetary Compensation" 2 "Non-Monetary Support(Land,Supples)" 3 "Mobilizing Community to use Health Services" 4 "Appreciation/Recognition" 5 "In-Kind Contributions"))
graph export "$output/CHW06_suppt_community.emf", replace


graph bar d6_09a_23 d6_09b_23 d6_09d_23 d6_09e_23 d6_09f_23 d6_09h_23 d6_09i_23 d6_09j_23 d6_09k_23 d6_09l_23 d6_09m_23 d6_09n_23 d6_09o_23 d6_09p_23 d6_09q_23, title("Health Supplies in Complete or Incomplete Stock", span) note("Source: Authors", span) yscale(r(0 1) noextend) ylabel(0(.25)1) ytitle("Proportion of CHWs", margin(small)) legend(size(2.1) rows(3) keygap(.3) symxsize(2.2) order(1 "Contraceptive Pills" 2 "Condoms" 3 "Injectable Contraceptive" 4 "Primo Red(Coartem)" 5 "Primo Yellow(Coartem)" 6 "Amoxicillin" 7 "Mebendazole" 8 "Sur eau" 9 "Vitamin A" 10 "Bed Nets" 11 "TB Drugs" 12 "Measuring Tape" 13 "Referal Forms" 14 "Timer" 15 "Health Registries"))
graph export "$output/CHW06_incorinstock.emf", replace

graph bar d6_09a_22 d6_09b_22 d6_09d_22 d6_09e_22 d6_09f_22 d6_09h_22 d6_09i_22 d6_09j_22 d6_09k_22 d6_09l_22 d6_09m_22 d6_09n_22 d6_09o_22 d6_09p_22 d6_09q_22, title("Health Supplies Not in Stock", span) note("Source: Authors", span) yscale(r(0 1) noextend) ylabel(0(.25)1) ytitle("Proportion of CHWs", margin(small)) legend(size(2.1) rows(3) keygap(.3) symxsize(2.2) order(1 "Contraceptive Pills" 2 "Condoms" 3 "Injectable Contraceptive" 4 "Primo Red(Coartem)" 5 "Primo Yellow(Coartem)" 6 "Amoxicillin" 7 "Mebendazole" 8 "Sur eau" 9 "Vitamin A" 10 "Bed nets" 11 "TB Drugs" 12 "Measuring Tape" 13 "Referal Forms" 14 "Timer" 15 "Health Registries" ))
graph export "$output/CHW06_outofstock.emf", replace
//ver(group_code, relabel(1 "Demand" 2 "Supply" 3 "Demand & Supply" 4 "Control"))

clear

exit
