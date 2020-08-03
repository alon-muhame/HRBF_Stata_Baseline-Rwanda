* Jennifer Sturdy September 2010, Updated by Matt Mulligan Nov 2011
* This do-file creates clean data sets for CHW individual data with study arm assignment merged into data
*To be used with Master Do Files

version 10.0
clear
cap log close


*************************************************************************************************************************************
log using "$log/Rwanda_CHW cr1.log", replace


***************************************************************************************************************************************
*Cleans Section 1 of CHW Survey
***********************************************************


use "$chw1",clear
duplicates report  hrbf_id1 hrbf_id2 hrbf_id3
assert r(N)== r(unique_value)

sort hrbf_id1 hrbf_id2 hrbf_id3
merge hrbf_id1 hrbf_id2 hrbf_id3 using "$clean\rwHRBF_Study Arm CHW BaseAnon.dta"
drop if _merge==1 & (hrbf_id1 ==87 | hrbf_id1 ==158 | hrbf_id1 ==166)

list if _merge==1
*Should only be missing data

keep if _merge==3
drop _merge

order hrbf_id1 hrbf_id2 hrbf_id3 hrbf_rectype group_code group_code_1 group_code_2 group_code_3 group_code_4

//Ensures response is within available options
foreach x of varlist  d1_01 d1_03 d1_07a-d1_07e d1_11 d1_12 d1_23 d1_25 d1_26 d1_27 d1_28 {
	replace `x' =. if (`x' !=1 & `x' !=2 & `x' !=.)
}
replace d1_00 =. if (d1_00 !=1 & d1_00 !=2 & d1_00 !=3 & d1_00 !=4 & d1_00 !=5 & d1_00 !=.)
foreach x of varlist  d1_05 d1_06 {
	replace `x' =. if (`x' !=1 & `x' !=2 & `x' !=3 & `x' !=4 &  `x' !=5 &  `x' !=6 &  `x' !=96 & `x' !=.)
}
replace d1_09 =. if (d1_09 !=1 & d1_09 !=2 & d1_09 !=3 & d1_09 !=4 &  d1_09 !=5 &  d1_09 !=6 & d1_09 !=7 & d1_09 !=96 & d1_09 !=.)
replace d1_30 =. if d1_30>168
//Other Irregular Reponses That were Modified (and new variables generated)

replace d1_02=. if d1_02<15
replace d1_04=. if d1_04>82
label define hcom 1 "NGO" 2 " Health Center" 3 "Health Committee" 4 "Ministry of Health" 5 " CHW Cooperative" 6 " Elected By Community" 96 "Other"
label values d1_06 hcom

mvdecode d1_08,mv(0 90000)

*Problems with Highest Grade Completed  IMPORTANT FOR REVIEW OF METHODOLOGY
//Answers differ greatly from previous question, highest level of education completed
destring d1_10, replace
mvdecode d1_10, mv(63)

//replace d1_10				//Primary
replace d1_10 = d1_10+6 if d1_09==4 & d1_10<3  //Pre-Secondary
replace d1_10 = d1_10+9 if d1_09==5 & d1_10<3   //Secondary
//University students only went to 6 years of school????

*Problems with How long have you worked as a CHW
label var d1_13y "How long have you worked as a CHW"
lab var d1_13m "How long have you worked as a CHW"
replace d1_13y=. if (d1_13y>82 | (d1_13y > (d1_02-15)))
gen d1_13m_2= d1_13m/12
egen time_chw = rsum(d1_13y d1_13m_2)
label var time_chw "Time worked as a Health Worker"

*Problems with How often do you work as a CHW (24hrs/day for 7 days?) IMPORTANT FOR REVIEW...
replace d1_14hrs =15 if d1_14hrs>15 //Limited to 15 hrs/day
gen flag=1 if (d1_14hrs==0 & d1_14days>0)
label var flag "Dummy=1 if reported worked days but 0 hours"
gen hours_week=( d1_14days* d1_14hrs) if flag!=1
label var hours_week "Hrs/wk spent as CHW"

mvdecode d1_16hrs,mv(300)
mvdecode d1_16min,mv(98)
gen d1_16hrs_2= d1_16hrs*60
egen total_minutes_HC= rsum(d1_16min d1_16hrs_2)
label var total_minutes_HC "Minutes to HC from Village(One Way, on Foot)"

gen d1_17_2=d1_17
centile d1_17 if d1_17!=0, centile(1 99)
replace d1_17_2=. if (d1_17<r(c_1) | d1_17>r(c_2))
gen d1_18_2= d1_18
centile d1_18, centile(1 99)
replace d1_18_2=. if d1_18>r(c_2)
label var d1_17_2 "Households Responsible For (Exl. top/bot. 1%)"
label var d1_18_2 "Households Visited Last Month(Exl. top 1%)"

mvdecode d1_19km, mv(0 1800)

mvdecode d1_20hrs, mv(300)
gen time_farhouse = (d1_20hrs/60 + d1_20min)
label var time_farhouse "Time to the Farthest House" 

replace d1_21km=. if d1_21km>d1_19km
mvdecode d1_21km, mv(0)

mvdecode d1_24, mv(0)
gen d1_24_2= d1_24
centile d1_24, centile(1 99)
replace d1_24_2=. if (d1_24<r(c_1)  | d1_24>r(c_2))
label var d1_24_2 "Number of CHWs on team, exclude top/bottom 1%"

//Jump
replace d1_10=. if (d1_09==1 | d1_09==2 | d1_09==96)
replace d1_24=. if d1_23==1
replace d1_26=. if d1_25==2 
foreach x of varlist d1_28 d1_29a-d1_29g d1_30{
	replace `x'=. if d1_27==2
}

//Dummy Variables and Labeling
gen d1_00_2= d1_00==1 if !missing(d1_00)
label var d1_00_2 "Maternal and Child Health Specialization"

gen d1_01_2 = d1_01==2 if !missing(d1_01) 
label define sex 1 "Female"
label value d1_01_2 sex
label var d1_01_2 "Female"

gen d1_05_2= d1_05==2 | d1_05==3 if !missing(d1_05)
lab var d1_05_2 "Married"

gen d1_06_2 = (d1_06==6) if !missing(d1_06)
label define comm 1 "Elected By Community" 0 "Other"
label values d1_06_2 comm
label var d1_06_2 "Elected by Community=1, Other=0"

foreach x in 3 5 6 7 {
	gen d1_09_`x'_2 = d1_09==`x' if !missing(d1_09)
}

label var d1_09_3_2 "Highest Level of Education: Primary" 
label var d1_09_5_2 "Highest Level of Education: Secondary"
label var d1_09_6_2 "Highest Level of Education: University"
label var d1_09_7_2 "Highest Level of Education: Cerai"

	

label define yes 1 "Yes"
foreach x in 03 07a 07b 07c 07d 07e 11 12 23 25 26 27 28{
	gen d1_`x'_2= (d1_`x'==1) if !missing(d1_`x')
	label value d1_`x'_2 yes
}
label var d1_02	"Age"
label var d1_03_2 "From The Village"
label var d1_06_2 "Elected by the Community"
label var d1_07a_2 "Eligibility: Elected=1, No=0"
label var d1_07b_2 "Eligibility: Letter=1, No=0"
label var d1_07c_2 "Eligibility: Over 16=1, No=0"
label var d1_07d_2 "Eligibility: Membership fee=1, No=0"
label var d1_07e_2 "Eligibility: Other=1, No=0"
label var d1_11_2 "Literacy course=1, No=0"
label var d1_10 "Highest Grade Completed"
label var d1_12_2 "Able to Read and write"
label var d1_13y "Years worked as CHW"
label var d1_23_2 "Works Independently"
label var d1_25_2 "TBA works in village=1, No=0"
label var d1_26_2 "Collaborate with TBA=1, No=0"
label var d1_27_2 "Has Access to Transport"
label var d1_28_2 "Use public transport=1, No=0"

gen number_hh= d1_17_2 if  d1_00==1
label var number_hh "Total number of households MCH covers in village"


sort hrbf_id1 hrbf_id2 hrbf_id3
save "$clean\rwHRBF_D CHWs -01.dta",replace
***************************************************************************************************************************************
*Section 2 CHW Survey "Training and Services"
***************************************************************
use "$chw2",clear
duplicates report  hrbf_id1 hrbf_id2 hrbf_id3
assert r(N)== r(unique_value)
sort hrbf_id1 hrbf_id2 hrbf_id3
merge hrbf_id1 hrbf_id2 hrbf_id3 using "$clean\rwHRBF_Study Arm CHW BaseAnon.dta"
drop if _merge==1 & (hrbf_id1 ==87 | hrbf_id1 ==158 | hrbf_id1 ==166)
list if _merge==1 //Should only be Missing Data

keep if _merge==3
drop _merge
order hrbf_id1 hrbf_id2 hrbf_id3 hrbf_rectype group_code group_code_1 group_code_2 group_code_3 group_code_4


//Ensures response is within available options
foreach y of numlist 1/6 {
	foreach x in a b c d e f g h i j k l m n o p q r s t u v w {
		capture noisily replace d2_0`y'`x' =. if (d2_0`y'`x' !=1 & d2_0`y'`x' !=2 & d2_0`y'`x' !=.)
	}
}

//JUMP
foreach y of numlist 4 5 {
	foreach x in a b c d e f g h i j k l m n o p q {
		capture noisily replace d2_0`y'`x' =. if d2_03==2
	}
}

//Dummy Variables

foreach x of var d2_01a- d2_06w {
 	gen `x'_2 = `x'==1 if !missing(`x')
 	label var `x'_2 "If `x' is Yes=1, No=0"
 	label values `x'_2 yes
 }


label var d2_01a_2 "C-IMCI or Childhood Diseases"
label var d2_01b_2 "Family Planning"
label var d2_01c_2 "Antenatal and Postnatal Care"
label var d2_01d_2 "Referral to Facility for Delivery or Danger Signs"
label var d2_01e_2 "Safe Home Delivery"
label var d2_01f_2 "Newborn Care"
label var d2_01g_2 "Tuberculosis"
label var d2_01h_2 "Vaccinations"
label var d2_01i_2 "Malaria"
label var d2_01j_2 "Nutrition"
label var d2_01k_2 "Sanitation and Home Hygiene"
label var d2_01l_2 "Mental Health"
label var d2_01m_2 "Disabilities"
label var d2_01n_2 "HIV/AIDS Service"
label var d2_01o_2 "Data Collection/Management"
label var d2_01p_2 "Mobile Technology"
label var d2_01qth_2 "Other"


label var d2_04a_2 "C-IMCI or Childhood Diseases"
label var d2_04b_2 "Family Planning"
label var d2_04c_2 "Antenatal and Postnatal Care"
label var d2_04d_2 "Referral to Facility for Delivery or Danger Signs"
label var d2_04e_2 "Safe Home Delivery"
label var d2_04f_2 "Newborn Care"
label var d2_04g_2 "Tuberculosis"
label var d2_04h_2 "Vaccinations"
label var d2_04i_2 "Malaria"
label var d2_04j_2 "Nutrition"
label var d2_04k_2 "Sanitation and Home Hygiene"
label var d2_04l_2 "Mental Health"
label var d2_04m_2 "Disabilities"
label var d2_04n_2 "HIV/AIDS Service"
label var d2_04o_2 "Data Collection/Management"
label var d2_04p_2 "Mobile Technology"
label var d2_04qth_2 "Other"



label var d2_06a_2 "Treat Sick Children"
label var d2_06b_2 "Refer Very Sick Children"
label var d2_06c_2 "Refer Children for Vacc."
label var d2_06d_2 "Support Outreach Vacc. Campaigns"
label var d2_06e_2 "Consultations for Adults"
label var d2_06f_2 "Provide Birth Spacing Methods(Exl. Condoms)"
label var d2_06g_2 "Give Iron Tablets and Nutrition Advice to Preg. Women"
label var d2_06h_2 "Refer Preg. Women for Tetanus Toxoid & Antenatal Care"
label var d2_06i_2 "Supervise Home Deliveries"
label var d2_06j_2 "Refer Preg. Women with Danger Signs"
label var d2_06k_2 "Postnatal Care"
label var d2_06l_2 "Newborn Care"
label var d2_06m_2 "Refer for Institutional Delivery"
label var d2_06n_2 "Supervise DOTS Treatment for TB"
label var d2_06o_2 "Malaria Treatment"
label var d2_06p_2 "Distribute Mosquito Nets"
label var d2_06q_2 "Advise and Refer on Mental Health"
label var d2_06r_2 "Advise and Refer on Disabilities"
label var d2_06s_2 "Health Education for Community"
label var d2_06t_2 "Distribute Condoms"
label var d2_06u_2 "Distribute Vitamin A for Children 6-59m & Nursing Mothers"
label var d2_06v_2 "Distribute SurEau"
label var d2_06w_2 "Other"


label var d2_03_2 "Recieved Training in Last 12 Months"
sort hrbf_id1 hrbf_id2 hrbf_id3
save "$clean\rwHRBF_D CHWs -02.dta",replace
***************************************************************************************************************************************
*Section 3 CHW Survey "CHW Payments
**************************************************************
use "$chw3",clear
duplicates report hrbf_id1 hrbf_id2 hrbf_id3
assert r(N)== r(unique_value)
sort hrbf_id1 hrbf_id2 hrbf_id3
merge hrbf_id1 hrbf_id2 hrbf_id3 using "$clean\rwHRBF_Study Arm CHW BaseAnon.dta"
drop if _merge==1 & (hrbf_id1 ==87 | hrbf_id1 ==158 | hrbf_id1 ==166)
list if _merge==1 //Should only be Missing Data

keep if _merge==3
drop _merge
order hrbf_id1 hrbf_id2 hrbf_id3 hrbf_rectype group_code group_code_1 group_code_2 group_code_3 group_code_4

//Ensures response is within available options
foreach x of varlist d3_01 d3_04 d3_05a-d3_05l d3_07 d3_10 d3_11a-d3_11c d3_12 d3_14 {
	replace `x' =. if (`x' !=1 & `x' !=2 & `x' !=.)
}
replace d3_13 =. if d3_13 > 100

gen d3_15_2=.
centile d3_15, centile(99)
replace d3_15_2 = d3_15 if d3_15 < r(c_1)
label var d3_15_2 " Payment from Cooperative in last quarter exlud top 1%"

//Jump			
foreach x of varlist d3_02 d3_03a-d3_03f {
	replace `x' =. if d3_01==2
}

foreach x of varlist d3_05a-d3_05l d3_06a-d3_06f {
	replace `x' =. if d3_04==2
}

foreach x of varlist d3_08a-d3_08c d3_09a-d3_09c {
	replace `x' =. if d3_07==2
}

foreach x of varlist d3_11a-d3_11c {
	replace `x' =. if d3_10==2
}

foreach x of varlist d3_13-d3_15 {
	replace `x' =. if d3_12==2
}

gen d3_13_2 = d3_13>0 if !missing(d3_13)
label var d3_13_2 "Recieved a Percentage of Income Generating Profit"

gen d3_13_3 = d3_13 if d3_13_2==1
label var d3_13_3 "Average Percentage of Income Generating Profit Recieved"

gen d3_14_2 = d3_14==1 if d3_13_2==1 & !missing(d3_14)
label var d3_14_2 "Whether the Percentage Varies on Performance"

//Dummy Variables
foreach x of var d3_01 d3_04 d3_05a- d3_05lth d3_07 d3_10 d3_11a-d3_11cth d3_12{
	gen `x'_2 = `x'==1 if !missing(`x')
	label var `x'_2 "If `x' is Yes=1, No=0"
	label values `x'_2 yes
}

label var d3_01_2 "Recieve Monetary Payment for CHW Work"
label var d3_02 "Monetary Pymt. in Last 3 Months"
label var d3_03a "Monetary Pymt. by NGO"
label var d3_03b "Monetary Pymt. by Health Center/District Hospital"
label var d3_03c "Monetary Pymt. by Health Committee"
label var d3_03d "Monetary Pymt. by Ministry of Health"
label var d3_03e "Monetary Pymt. by CHW Cooperative"
label var d3_03fth "Monetary Pymt. by Other"

label var d3_04_2 "Recieve In-Kind Payment for CHW Work"
label var d3_06a "Value of In-Kind Pymt. by NGO"
label var d3_06b "Value of In-Kind Pymt. by Health Center/District Hospital"
label var d3_06c "Value of In-Kind Pymt. by Health Committee"
label var d3_06d "Value of In-Kind Pymt. by Ministry of Health"
label var d3_06e "Value of In-Kind Pymt. by CHW Cooperative"
label var d3_06fth "Value of In-Kind Pymt. by Other"

label var d3_07_2 "Charge Patients a Fee"
label var d3_08a "Fee for Prev. Care Visit: Consultation"
label var d3_08b "Fee for Prev. Care Visit: Copayment"
label var d3_08c "Fee for Prev. Care Visit: Drugs"
label var d3_09a "Fee for Cur. Care Visit: Consultation"
label var d3_09b "Fee for Cur. Care Visit: Copayment"
label var d3_09c "Fee for Cur. Care Visit: Drugs"
label var d3_10_2 "Receive Pymt. Other than Money"

label var d3_12_2 "Coop. Invests in Income Generating Activities"
label var d3_13_2 "Recieved a % of Income Generating Profit"
label var d3_13_3 "Average % of Income Generating Profit Recieved"
label var d3_14_2 "% Varies on Performance"
label var d3_15_2 "Pymt. from Coop. in Last Quarter(Exl. Top 1%)"

sort hrbf_id1 hrbf_id2 hrbf_id3
save "$clean\rwHRBF_D CHWs -03.dta",replace
***************************************************************************************************************************************
*Section 4 CHW Survey "Supervision" 
*****************************************************************
use "$chw4",clear
duplicates report  hrbf_id1 hrbf_id2 hrbf_id3
assert r(N)== r(unique_value)
sort hrbf_id1 hrbf_id2 hrbf_id3
merge hrbf_id1 hrbf_id2 hrbf_id3 using "$clean\rwHRBF_Study Arm CHW BaseAnon.dta"
drop if _merge==1 & (hrbf_id1 ==87 | hrbf_id1 ==158 | hrbf_id1 ==166)
list if _merge==1 //Should only be Missing Data

keep if _merge==3
drop _merge

order hrbf_id1 hrbf_id2 hrbf_id3 hrbf_rectype group_code group_code_1 group_code_2 group_code_3 group_code_4

//Ensures response is within available options
foreach x of varlist d4_01 d4_02a-d4_02f d4_05a-d4_05l {
	replace `x' =. if (`x' !=1 & `x' !=2 & `x' !=.)
}
replace d4_04 =. if (d4_04 !=1 & d4_04 !=2 & d4_04 !=3 & d4_04 !=.)
mvdecode d4_03, mv(180)

//Jump			
foreach x of varlist d4_02a-d4_02f d4_03 d4_04 d4_05a-d4_05l {
	replace `x' =. if d4_01==2
}

//Dummy Variable
foreach x of var d4_01 d4_02a- d4_02fth d4_05a- d4_05lth{
	gen `x'_2 = `x'==1 if !missing(`x') 
 	label var `x'_2 "If `x' is Yes=1, No=0"
 	label values `x' yes
}

gen d4_04_2 = d4_04==1 | d4_04==2 if !missing(d4_04)
label var d4_04_2 "Supervisor Records Recommendations that CHW Keeps"

label var d4_01_2 "Has a Supervisor"
label var d4_03 "Times Supervisor Visited to Discuss/Supervise in Last 6m"
label var d4_04_2 "Supervisor Records Recommendations & Kept by CHW"

sort hrbf_id1 hrbf_id2 hrbf_id3
save "$clean\rwHRBF_D CHWs -04.dta",replace
***************************************************************************************************************************************
**Section 5 CHW Survey "Steering Committe" 
***********************************************************
use "$chw5",clear
duplicates report  hrbf_id1 hrbf_id2 hrbf_id3
assert r(N)== r(unique_value)
sort hrbf_id1 hrbf_id2 hrbf_id3
merge hrbf_id1 hrbf_id2 hrbf_id3 using "$clean\rwHRBF_Study Arm CHW BaseAnon.dta"
drop if _merge==1 & (hrbf_id1 ==87 | hrbf_id1 ==158 | hrbf_id1 ==166)
list if _merge==1 //Should only be Missing Data


keep if _merge==3
drop _merge
order hrbf_id1 hrbf_id2 hrbf_id3 hrbf_rectype group_code group_code_1 group_code_2 group_code_3 group_code_4

//Ensures response is within available options
foreach x of varlist d5_01 d5_02a-d5_02i d5_04 d5_05a-d5_05f {
	replace `x' =. if (`x' !=1 & `x' !=2 & `x' !=.)
}
replace d5_03 =. if (d5_03 !=1 & d5_03 !=2 & d5_03 !=3 & d5_03 !=4 & d5_03 !=5 & d5_03 !=.)

//Jump			
foreach x of varlist d5_02a-d5_02i d5_03 d5_04 d5_05a-d5_05f {
	replace `x' =. if d5_01==2
}			
foreach x of varlist d5_05a-d5_05f {
	replace `x' =. if d5_04==2
}

//Dummy Variables
foreach x of var d5_01 d5_02a- d5_02i d5_04 d5_05a- d5_05f{
	gen `x'_2 = `x'==1 if !missing(`x') 
 	label var `x'_2 "If `x' is Yes=1, No=0"
 	label values `x' yes
}

gen d5_03_2 = d5_03 <=3 if !missing(d5_03)
label var d5_03_2 "Met in Last Three Months"

label var d5_01_2 "Recieved Support or Guidance from Cell Steering Committee (CSC)"
label var d5_03_2 "CSC Met in Last 3m"
label var d5_04_2 "Recieved Support from CSC in Last 3m"
label var d5_05a_2 "Pymt. for Health Services"
label var d5_05b_2 "Donations for Improving Health Post"
label var d5_05c_2 "Mobilizing Community to Use Health Services"
label var d5_05d_2 "Appreciation/Recognition"
label var d5_05e_2 "In-Kind Contributions"
label var d5_05fth_2 "Other"


sort hrbf_id1 hrbf_id2 hrbf_id3
save "$clean\rwHRBF_D CHWs -05.dta",replace
*******************************************************************************************************************************
*Section 6 CHW Survey "CHW Resources"
************************************************************************
use "$chw6",clear
duplicates report  hrbf_id1 hrbf_id2 hrbf_id3
assert r(N)== r(unique_value)
sort hrbf_id1 hrbf_id2 hrbf_id3
merge hrbf_id1 hrbf_id2 hrbf_id3 using "$clean\rwHRBF_Study Arm CHW BaseAnon.dta"
drop if _merge==1 & (hrbf_id1 ==87 | hrbf_id1 ==158 | hrbf_id1 ==166)
list if _merge==1 //Should only be Missing Data

keep if _merge==3
drop _merge
order hrbf_id1 hrbf_id2 hrbf_id3 hrbf_rectype group_code group_code_1 group_code_2 group_code_3 group_code_4

//Ensures response is within available options
foreach x of varlist d6_01a-d6_01h d6_02a-d6_02h d6_03a-d6_03h d6_04a-d6_04f d6_05a-d6_05h d6_06 d6_07 d6_10a-d6_10q {
	replace `x' =. if (`x' !=1 & `x' !=2 & `x' !=.)
}
foreach x of varlist d6_09a-d6_09r {
	replace `x' =. if (`x' !=1 & `x' !=2 & `x' !=3 & `x' !=4 & `x' !=.)
}

//Jump			
foreach x of varlist d6_07-d6_08 {
	replace `x' =. if d6_06==2
}			
replace d6_08 =. if d6_07==2
replace d6_07 =. if d6_08==0
mvdecode d6_08, mv(0)
gen d6_08_2 = d6_08
centile d6_08, centile(99)
replace d6_08_2=. if d6_08 > r(c_1)
replace d6_08_2= d6_08_2+1 if !missing(d6_08_2)
label var d6_08_2 "Number of CHW Shared Kit exluding top 1%"


//Dummy Variables
foreach x of var d6_01a- d6_07  d6_10a- d6_10qth{
	gen `x'_2 = `x'==1 if !missing(`x') 
 	label var `x'_2 "If `x' is Yes=1, No=0"
 	label values `x' yes
}

gen stockcat =.
gen stockcat2=.
label var stockcat "1 Complete, 2 INC, 3 Not in Stock"
foreach x of var d6_09a- d6_09rth{
	gen `x'_2 = `x'==1 if !missing(`x') 
 	label var `x'_2 "If `x' is Complete Stock=1, No=0"

	gen `x'_21= (`x'==2) if !missing(`x')
	label var `x'_21 "If `x' is Incomplete Stock=1, No=0"
	
	gen `x'_22= (`x'==3 | `x'==4) if !missing(`x')
	label var `x'_22 "If `x' is NOT in Stock"
	
	gen `x'_23= (`x'==2 | `x'==1) if !missing(`x')
	label var `x'_23 "If `x' is Complete or Incomplete Stock=1, No=0"
	
	
	
}

label var d6_05a_2 "Home Visits"
label var d6_05b_2 "Share Drug Supplies"
label var d6_05c_2 "Refer Patients to Facility"
label var d6_05d_2 "Sharing Medical Knowledge"
label var d6_05e_2 "Mobilize Comunity for Vaccination Campaigns"
label var d6_05f_2 "Help with Filling Tally Sheet"
label var d6_05g_2 "No Support from CHW's"
label var d6_05hth_2 "Other"

label var d6_06_2 "Recieve a CHW Kit"
label var d6_07_2 "Share Kits with Other CHW's"
label var d6_08_2 "Number of CHW's That Share Kit"
sort hrbf_id1 hrbf_id2 hrbf_id3
save "$clean\rwHRBF_D CHWs -06.dta",replace
***************************************************************************************************************************************
*Section 7 CHW Survey "CHW Knowledge Questions"
*******************************************************************
use "$chw7",clear
duplicates report  hrbf_id1 hrbf_id2 hrbf_id3
assert r(N)== r(unique_value)
sort hrbf_id1 hrbf_id2 hrbf_id3
merge hrbf_id1 hrbf_id2 hrbf_id3 using "$clean\rwHRBF_Study Arm CHW BaseAnon.dta"
drop if _merge==1 & (hrbf_id1 ==87 | hrbf_id1 ==158 | hrbf_id1 ==166)
list if _merge==1 //Should only be Missing Data

keep if _merge==3
drop _merge
order hrbf_id1 hrbf_id2 hrbf_id3 hrbf_rectype group_code group_code_1 group_code_2 group_code_3 group_code_4

//Ensures response is within available options
foreach x in 01 02 03 04 05 06 07 09 10 11 {
	foreach y in a b c d e f {
		capture noisily replace d7_`x'`y' =. if (d7_`x'`y' !=1 & d7_`x'`y' !=2 & d7_`x'`y' !=.)
	}
}

//Dummy Variables
//foreach x of varlist d7_01a d7_01b d7_01c d7_01d d7_02a d7_02b d7_02c d7_02d d7_03a d7_03b d7_03c d7_03d d7_03e d7_04a d7_04b d7_04c d7_04d d7_05a ///
//	d7_05b d7_05c d7_05d d7_06a d7_06b d7_06c d7_06d d7_07a d7_07b d7_07c d7_07d d7_07e d7_08a d7_08b d7_08c d7_08d d7_08e 7_09a d7_09b d7_09c d7_09d{
//		gen `x'_1= `x'==1 if !missing(`x')
//}

//Must answer complete question.  Therefore, creating missing values if any part of question a-d is left blank.  
foreach x in a b c d {
	replace d7_01`x' =. if d7_01a==. | d7_01b==. | d7_01c==. | d7_01d==.
}
foreach x in a b c d {
	replace d7_02`x' =. if d7_02a==. | d7_02b==. | d7_02c==. | d7_02d==.
}
foreach x in a b c d e {
	replace d7_03`x' =. if d7_03a==. | d7_03b==. | d7_03c==. | d7_03d==. | d7_03e ==.
}
foreach x in a b c d {
	replace d7_04`x' =. if d7_04a==. | d7_04b==. | d7_04c==. | d7_04d==.
}
foreach x in a b c d {
	replace d7_05`x' =. if d7_05a==. | d7_05b==. | d7_05c==. | d7_05d==.
}
foreach x in a b c d {
	replace d7_06`x' =. if d7_06a==. | d7_06b==. | d7_06c==. | d7_06d==.
}
foreach x in a b c d e {
	replace d7_07`x' =. if d7_07a==. | d7_07b==. | d7_07c==. | d7_07d==.| d7_07e ==.
}
foreach x in a b c d e {
	replace d7_08`x' =. if d7_08a==. | d7_08b==. | d7_08c==. | d7_08d==. | d7_08e ==.
}
foreach x in a b c d {
	replace d7_09`x' =. if d7_09a==. | d7_09b==. | d7_09c==. | d7_09d==.
}


//lab var d7_01a_1 "Wash hands:remove dirt"
//lab var d7_01b_1 "Wash hands:prevent HIV"
//lab var d7_01c_1 "Wash hands:avoid diarrhea"
//lab var d7_01d_1 "Wash hands:prevent skin inf."
//lab var d7_02a_1 "Drink treated water near animals"
//lab var d7_02b_1 "Drink treated stagnate water"
//lab var d7_02c_1 "Drink treated spring/well water"
//lab var d7_02d_1 "Drink treated stream/river water"
//lab var d7_03a_1 "Diarrhea:Give 1l/day ORT"
//lab var d7_03b_1 "Diarrhea:Give 3-4gl/day ORT"
//lab var d7_03c_1 "1/4-1/2cup ORT each watery stool"
//lab var d7_03d_1 "Diarrhea:Give 1l/day water only"
//lab var d7_03e_1 "Diarrhea:Give other treatment"
//lab var d7_04a_1 "Danger pregnancy:fever"
//lab var d7_04b_1 "Danger pregnancy:vagina bleeds"
//lab var d7_04c_1 "Danger pregnancy:swelling"
//lab var d7_04d_1 "Danger pregnancy:loss appetite"
//lab var d7_05a_1 "Danger baby:convulsion"
//lab var d7_05b_1 "Danger baby:fever"
//lab var d7_05c_1 "Danger baby:no breastfeeding"
//lab var d7_05d_1 "Danger baby:breathing quickly"
//lab var d7_07a_1 "Vaccine for: polio"
//lab var d7_07b_1 "Vaccine for: measles"
//lab var d7_07c_1 "Vaccine for: tetanus"
//lab var d7_07d_1 "Vaccine for: TB"
//lab var d7_07e_1 "Vaccine for: AIDS"
//lab var d7_08a_1 "Contraception: oral"
//lab var d7_08b_1 "Contraception: DMPA"
//lab var d7_08c_1 "Contraception: IUD"
//lab var d7_08d_1 "Contraception: Breastfeeding"
//lab var d7_08e_1 "Contraception: Withdrawal"


gen d7_handwash= d7_01a==1 if !missing(d7_01a)
replace d7_handwash=d7_handwash+1 if d7_01b==2
replace d7_handwash=d7_handwash+1 if d7_01c==1
replace d7_handwash=d7_handwash+1 if d7_01d==1
replace d7_handwash=d7_handwash/4

gen d7_safewater= d7_02a==2 if !missing(d7_02a)
replace d7_safewater=d7_safewater+1 if d7_02b==2
replace d7_safewater=d7_safewater+1 if d7_02c==1
replace d7_safewater=d7_safewater+1 if d7_02d==2
replace d7_safewater=d7_safewater/4

gen d7_infantdiarrhea= d7_03a==2 if !missing(d7_03a)
replace d7_infantdiarrhea=d7_infantdiarrhea+1 if d7_03b==2
replace d7_infantdiarrhea=d7_infantdiarrhea+1 if d7_03c==1
replace d7_infantdiarrhea=d7_infantdiarrhea+1 if d7_03d==2
replace d7_infantdiarrhea=d7_infantdiarrhea+1 if d7_03e==2
replace d7_infantdiarrhea=d7_infantdiarrhea/5

gen d7_dangersignspreg= d7_04a==1 if !missing(d7_04a)
replace d7_dangersignspreg=d7_dangersignspreg+1 if d7_04b==1
replace d7_dangersignspreg=d7_dangersignspreg+1 if d7_04c==1
replace d7_dangersignspreg=d7_dangersignspreg+1 if d7_04d==2
replace d7_dangersignspreg=d7_dangersignspreg/4

gen d7_dangersignsinfant= d7_05a==1 if !missing(d7_05a)
replace d7_dangersignsinfant=d7_dangersignsinfant+1 if d7_05b==1
replace d7_dangersignsinfant=d7_dangersignsinfant+1 if d7_05c==1
replace d7_dangersignsinfant=d7_dangersignsinfant+1 if d7_05d==1
replace d7_dangersignsinfant=d7_dangersignsinfant/4

gen d7_solidfoods= d7_06a==2 if !missing(d7_06a)
replace d7_solidfoods=d7_solidfoods+1 if d7_06b==2
replace d7_solidfoods=d7_solidfoods+1 if d7_06c==2
replace d7_solidfoods=d7_solidfoods+1 if d7_06d==1
replace d7_solidfoods=d7_solidfoods/4

gen d7_vaccineprevent= d7_07a==1 if !missing(d7_07a)
replace d7_vaccineprevent=d7_vaccineprevent+1 if d7_07b==1
replace d7_vaccineprevent=d7_vaccineprevent+1 if d7_07c==1
replace d7_vaccineprevent=d7_vaccineprevent+1 if d7_07d==1
replace d7_vaccineprevent=d7_vaccineprevent+1 if d7_07e==2
replace d7_vaccineprevent=d7_vaccineprevent/5

gen d7_contraception= d7_08a==1 if !missing(d7_08a)
replace d7_contraception=d7_contraception+1 if d7_08b==1
replace d7_contraception=d7_contraception+1 if d7_08c==1
replace d7_contraception=d7_contraception+1 if d7_08d==2
replace d7_contraception=d7_contraception+1 if d7_08e==2
replace d7_contraception=d7_contraception/5

gen d7_tuberculosis= d7_09a==2 if !missing(d7_09a)
replace d7_tuberculosis=d7_tuberculosis+1 if d7_09b==1
replace d7_tuberculosis=d7_tuberculosis+1 if d7_09c==1
replace d7_tuberculosis=d7_tuberculosis+1 if d7_09d==1
replace d7_tuberculosis=d7_tuberculosis/4


*Overall Health Score
//See Comment Below about Missing Values in the generation of healthscore
gen d7_healthscore= d7_01a==1 
replace d7_healthscore=d7_healthscore+1 if d7_01b==2
replace d7_healthscore=d7_healthscore+1 if d7_01c==1
replace d7_healthscore=d7_healthscore+1 if d7_01d==1

replace d7_healthscore=d7_healthscore+1 if d7_02a==2
replace d7_healthscore=d7_healthscore+1 if d7_02b==2
replace d7_healthscore=d7_healthscore+1 if d7_02c==1
replace d7_healthscore=d7_healthscore+1 if d7_02d==2

replace d7_healthscore=d7_healthscore+1 if d7_03a==2
replace d7_healthscore=d7_healthscore+1 if d7_03b==2
replace d7_healthscore=d7_healthscore+1 if d7_03c==1
replace d7_healthscore=d7_healthscore+1 if d7_03d==2
replace d7_healthscore=d7_healthscore+1 if d7_03e==2

replace d7_healthscore=d7_healthscore+1 if d7_04a==1
replace d7_healthscore=d7_healthscore+1 if d7_04b==1
replace d7_healthscore=d7_healthscore+1 if d7_04c==1
replace d7_healthscore=d7_healthscore+1 if d7_04d==2

replace d7_healthscore=d7_healthscore+1 if d7_05a==1
replace d7_healthscore=d7_healthscore+1 if d7_05b==1
replace d7_healthscore=d7_healthscore+1 if d7_05c==1
replace d7_healthscore=d7_healthscore+1 if d7_05d==1

replace d7_healthscore=d7_healthscore+1 if d7_06a==2
replace d7_healthscore=d7_healthscore+1 if d7_06b==2
replace d7_healthscore=d7_healthscore+1 if d7_06c==2
replace d7_healthscore=d7_healthscore+1 if d7_06d==1

replace d7_healthscore=d7_healthscore+1 if d7_07a==1
replace d7_healthscore=d7_healthscore+1 if d7_07b==1
replace d7_healthscore=d7_healthscore+1 if d7_07c==1
replace d7_healthscore=d7_healthscore+1 if d7_07d==1
replace d7_healthscore=d7_healthscore+1 if d7_07e==2

replace d7_healthscore=d7_healthscore+1 if d7_08a==1
replace d7_healthscore=d7_healthscore+1 if d7_08b==1
replace d7_healthscore=d7_healthscore+1 if d7_08c==1
replace d7_healthscore=d7_healthscore+1 if d7_08d==2
replace d7_healthscore=d7_healthscore+1 if d7_08e==2

replace d7_healthscore=d7_healthscore+1 if d7_09a==2
replace d7_healthscore=d7_healthscore+1 if d7_09b==1
replace d7_healthscore=d7_healthscore+1 if d7_09c==1
replace d7_healthscore=d7_healthscore+1 if d7_09d==1



*Create Number of Number Missing Score for accurate health score calculation
gen nonmissing=0
foreach x of varlist d7_01a d7_01b d7_01c d7_01d d7_02a d7_02b d7_02c d7_02d d7_03a d7_03b d7_03c d7_03d d7_03e d7_04a d7_04b d7_04c d7_04d d7_05a ///
	d7_05b d7_05c d7_05d d7_06a d7_06b d7_06c d7_06d d7_07a d7_07b d7_07c d7_07d d7_07e d7_08a d7_08b d7_08c d7_08d d7_08e d7_09a d7_09b d7_09c d7_09d{
		replace nonmissing=nonmissing+1 if !missing(`x')
}
//Because denominator, the above equation, accounts for missing values, it is possible to assign the 0's to misisng values in the health score calculation.
//Problem arises because you cannot add to missing values


replace d7_healthscore=d7_healthscore/nonmissing
lab var d7_healthscore "0-1 Score on health knowledge"


lab var d7_healthscore "Health Score (0-1)"
sort hrbf_id1 hrbf_id2 hrbf_id3
save "$clean\rwHRBF_D CHWs -07.dta",replace

***************************************************************************************************************************************
*Section 8 CHW Survey "Community Health Worker Satisfaction" 
*********************************************************************
use "$chw8",clear
duplicates report  hrbf_id1 hrbf_id2 hrbf_id3
assert r(N)== r(unique_value)
sort hrbf_id1 hrbf_id2 hrbf_id3
merge hrbf_id1 hrbf_id2 hrbf_id3 using "$clean\rwHRBF_Study Arm CHW BaseAnon.dta"
drop if _merge==1 & (hrbf_id1 ==87 | hrbf_id1 ==158 | hrbf_id1 ==166)
list if _merge==1 //Should only be Missing Data

keep if _merge==3
drop _merge
order hrbf_id1 hrbf_id2 hrbf_id3 hrbf_rectype group_code group_code_1 group_code_2 group_code_3 group_code_4


//Ensures response is within available options
foreach x of varlist d8_01-d8_17 {
	replace `x' =. if (`x' !=1 & `x' !=2 & `x' !=3 & `x' !=4 & `x' !=.)
}

//Dummy Variables
//label define sat 1 "Satisfied" 0 "Unsatisfied"
//foreach x of var  d8_01- d8_17{
//	gen `x'_2= (`x'==3 | `x'==4) if !missing(`x')
//	label var `x'_2 "If `x' is Very, Satisfied=1, Unsatisfied=0"
//	label values `x'_2 sat
//}
label var d8_01 "Working Relationship with Facility Staff"
label var d8_02 "Working Relationship with District MoH Staff"
label var d8_03 "Adequate Community Support"
label var d8_04 "Relationship with Local Community Leaders"
label var d8_05 "Availability of Medicines"
label var d8_06 "Availability of Equiptment"
label var d8_07 "Own Level of Respect in the Community"
label var d8_08 "Additional Training Opportunities"
label var d8_09 "Ability to Meet the Needs of the Community"
label var d8_10 "Compensation"
label var d8_11 "Other Benefits"
label var d8_12 "Safety and Security of Practicing in the Community"
label var d8_13 "Living Accomodations for Own Family"
label var d8_14 "Education for Own Children"
label var d8_15 "Supervisor's Recognition"
label var d8_16 "Opportunities for Advancement"
label var d8_17 "Satisfied with Own Role"


sort hrbf_id1 hrbf_id2 hrbf_id3
save "$clean\rwHRBF_D CHWs -08.dta",replace
***************************************************************************************************************************************
*Section 9 CHW Survey "CHW Motivation"
********************************************************************
use "$chw9",clear
assert r(N)== r(unique_value)
duplicates report  hrbf_id1 hrbf_id2 hrbf_id3
sort hrbf_id1 hrbf_id2 hrbf_id3
merge hrbf_id1 hrbf_id2 hrbf_id3 using "$clean\rwHRBF_Study Arm CHW BaseAnon.dta"
drop if _merge==1 & (hrbf_id1 ==87 | hrbf_id1 ==158 | hrbf_id1 ==166)
list if _merge==1 //Should only be Missing Data

keep if _merge==3
drop _merge
order hrbf_id1 hrbf_id2 hrbf_id3 hrbf_rectype group_code group_code_1 group_code_2 group_code_3 group_code_4

//Ensures response is within available options
foreach x of varlist d9_01-d9_10 {
	replace `x' =. if (`x' !=1 & `x' !=2 & `x' !=3 & `x' !=4 & `x' !=.)
}

//Dummy variables
//foreach x of var d9_01- d9_10 {
//	gen `x'_2= (`x'==1|`x'==2) if !missing(`x')
//	label var `x'_2 "If `x' is Very, unsatisfied=1, Satisfied=0"
//	label values `x'_2 sat
//}
label var d9_01 "Feel Goood About Yourself"
label var d9_02 "Proud to be Working for this Community"
label var d9_03 "Glad To Be Working For Own Comm. Over Other Comm."
label var d9_04 "Inspired to do Your Best"
label var d9_05 "Always Complete Tasks Efficiently/Effectively"
label var d9_06 "Hard Worker"
label var d9_07 "Punctual"
label var d9_08 "Motviated to Work as Hard as Possible"
label var d9_09 "Satisfied with Job"
label var d9_10 "Satisfied with Opportunity to use Abilities"



sort hrbf_id1 hrbf_id2 hrbf_id3
save "$clean\rwHRBF_D CHWs -09.dta",replace
***************************************************************************************************************************************

log close

exit
