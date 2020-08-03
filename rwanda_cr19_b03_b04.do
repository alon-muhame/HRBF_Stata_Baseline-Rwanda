* Elisa Rothenbuhler - Sep 10

* This do-file:
* Merges $cleandatadir/rwhrbf_b03_withstudyarms_withvarformeantests.dta with $cleandatadir/rwhrbf_b04_withstudyarms_withvarformeantests.dta.
* Generates a variable representing Unmet need for contraception as closely as possible to WHO definition.


version 10.0
clear
set more off
set mem 500m
cap log close

#delimit ;

log using $logdir/rwanda_cr19_b03_b04.log, replace;

use $cleandatadir/rwhrbf_b04_withstudyarms_withvarformeantests.dta, clear;
sort hrbf_id1 hrbf_id2 a1_pid;
save $cleandatadir/rwhrbf_b04_withstudyarms_withvarformeantests.dta, replace;

use $cleandatadir/rwhrbf_b03_withstudyarms_withvarformeantests.dta, clear;
sort hrbf_id1 hrbf_id2 a1_pid;
merge hrbf_id1 hrbf_id2 a1_pid using $cleandatadir/rwhrbf_b04_withstudyarms_withvarformeantests.dta, unique;
tab _merge;
list hrbf_id1 hrbf_id2 a1_pid if _merge==2;
drop if _merge==2;

********************************************************************************
*** Generate Unmet need for family planning variable - closest to WHO definition
********************************************************************************;

* Note from WHO Indicators Compendium 2010;
/*;
Unmet need for family planning = (Women who are married or in a consensual union who have an unmet need for family planning / Total number of women of reproductive age (15-49 years) who are married or in consensual union) x 100
Included in the numerator: • All pregnant women (married or in consensual union) whose pregnancies were unwanted or mistimed at the time of conception. • All postpartum amenorrheic women (married or in consensual union) who are not using family planning and whose last birth was unwanted or mistimed. • All fecund women (married or in consensual union) who are neither pregnant nor postpartum amenorrheic, and who either do not want any more children (limit), or who wish to postpone the birth of a child for at least two years or do not know when or if they want another child (spacing), but are not using any contraceptive method.
Excluded from the numerator of the unmet need definition are pregnant and amenorrheic women who became pregnant unintentionally due to contraceptive method failure (these women are assumed to be in need of a better contraceptive method). Also excluded from the unmet need definition are infecund women. Women are assumed to be infecund if:
1) they have been married for five or more years AND 2) there have been no births in the past five years AND 3) they are not currently pregnant AND 4) they have never used any kind of contraceptive method OR 5) they self-report that they are infecund, menopausal or have had a hysterectomy.
*/;

gen b12_12_200=.;
replace b12_12_200=1 if (b12_08==1 & b13_001==1 & (b13_003==2 | b13_003==3)) | (b13_001!=1 & b12_04==1 & b12_08==1 & b12_12==2 & (b12_02==1 | b12_02==3 |b12_02==5));
replace b12_12_200=0 if b12_12_200!=1 & b12_08==1;
lab var b12_12_200 "Unmet need for FP - WHO";
* Closest to WHO indicator;

gen b12_12_201=.;
replace b12_12_201=1 if ((a1_12==2 | a1_12==3) & b13_001==1 & (b13_003==2 | b13_003==3)) | (b13_001!=1 & b12_04==1 & (a1_12==2 | a1_12==3) & b12_12==2 & (b12_02==1 | b12_02==3 |b12_02==5));
replace b12_12_201=0 if b12_12_201!=1 & (a1_12==2 | a1_12==3);
lab var b12_12_201 "Unmet need for FP -married WHO";
* Closest to WHO indicator;

svyset [pweight=hhpweight], psu(hrbf_id1);
sort hrbf_id1 hrbf_id2 a1_pid;
save $cleandatadir/rwhrbf_b03_b04_withstudyarms_withvarformeantests.dta, replace;