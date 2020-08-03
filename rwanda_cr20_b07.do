* Elisa Rothenbuhler - Sep 10

* This do-file:
* Creates clean female b07 dataset: $cleandatadir/rwhrbf_b07.dta.
* Merges $cleandatadir/rwhrbf_b07.dta with household roster.
* Generates appropriate variables for mean tests.


version 10.0
clear
set more off
set mem 500m
cap log close

#delimit ;

log using $logdir/rwanda_cr20_b07.log, replace;



*********************
*** Clean b07 section
*********************;

use $origdatadir/RWHRBF_B_FEMALE-07.dta, clear;
drop if b13_096a==. & b13_096b==. & b13_097a==. & b13_097b==. & b13_097c==. & b13_097d==. & b13_097e==. & b13_097f==. & b13_097g==. & b13_097h==. & b13_098a==. & b13_098b==. & b13_098c==. & b13_098d==. & b13_098e==. & b13_098f==. & b13_099==. & b13_100==. & b13_101==. & b13_102a==. & b13_102b==. & b13_103==. & b13_104==. & b13_105a==. & b13_105b==. & b13_106a==. & b13_106b==. & b13_107==. & b13_108==. & b13_109==. & b13_110a==. & b13_110b==.;

duplicates tag hrbf_id1 hrbf_id2 b13d_pid, gen(dupl);
list hrbf_id1 hrbf_id2 b13d_pid if dupl!=0;
list hrbf_id1 hrbf_id2 b13d_pid if (hrbf_id1==182 & hrbf_id2==2) |  (hrbf_id1==220 & hrbf_id2==3);
drop if b13d_pid==.;
duplicates report hrbf_id1 hrbf_id2 b13d_pid;

tab1 b13_096a b13_096b b13_097a b13_097b b13_097c b13_097d b13_097e b13_097f b13_097g b13_097h b13_098a b13_098b b13_098c b13_098d b13_098e b13_098f b13_099 b13_100 b13_101 b13_102a b13_102b b13_103 b13_104 b13_105a b13_105b b13_106a b13_106b b13_107 b13_108 b13_109 b13_110a b13_110b, nolab;

replace b13_096b=2 if b13_096b==0;
replace b13_097a=2 if b13_097a==0;
list b13_102a b13_102b b13_103 if b13_102a>15 & b13_102a!=.,nolab;
mvdecode b13_102b, mv(96=.a);
list b13_105a b13_105b if b13_105a>12 & b13_105a!=.;
replace b13_105a=. if b13_105a>12;
replace b13_105b=. if b13_105b>2000;
list b13_106a b13_106b b13_107 if (b13_106a>15 | b13_106b==60) & b13_106a!=., nolab;
mvdecode b13_110a, mv(99=.b);
replace b13_110b=2010 if b13_110b==210;
replace b13_110b=. if b13_110b<2001.;

* assert b13_097a==. & b13_097b==. & b13_097c==. & b13_097d==. & b13_097e==. & b13_097f==. & b13_097g==. & b13_097h==. & b13_098a==. & b13_098b==. & b13_098c==. & b13_098d==. & b13_098e==. & b13_098f==. & b13_099==. & b13_100==. & b13_101==. & b13_102a==. & b13_102b==. & b13_103==. if b13_096a==2 & b13_096b==2;
list b13_097a b13_097b b13_097c b13_097d b13_097e b13_097f b13_097g b13_097h b13_098a b13_098b b13_098c b13_098d b13_098e b13_098f b13_099 b13_100 b13_101 b13_102a b13_102b b13_103 if (b13_097a!=. | b13_097b!=. | b13_097c!=. | b13_097d!=. | b13_097e!=. | b13_097f!=. | b13_097g!=. | b13_097h!=. | b13_098a!=. | b13_098b!=. | b13_098c!=. | b13_098d!=. | b13_098e!=. | b13_098f!=. | b13_099!=. | b13_100!=. | b13_101!=. | b13_102a!=. | b13_102b!=. | b13_103!=.) & b13_096a==2 & b13_096b==2, compress nolab;
replace b13_096b=1 if b13_097a!=. & b13_097b!=. & b13_097c!=. & b13_097d!=. & b13_097e!=. & b13_097f!=. & b13_097g!=. & b13_097h!=. & b13_098a!=. & b13_098b!=. & b13_098c!=. & b13_098d!=. & b13_098e!=. & b13_098f!=. & b13_099!=.;
replace b13_101=. if b13_096b==2 & b13_096a==2;
replace b13_102a=. if b13_096b==2 & b13_096a==2;
replace b13_102b=. if b13_096b==2 & b13_096a==2;
replace b13_103=. if b13_096b==2 & b13_096a==2;
* assert b13_097a==. & b13_097b==. & b13_097c==. & b13_097d==. & b13_097e==. & b13_097f==. & b13_097g==. & b13_097h==. & b13_098a==. & b13_098b==. & b13_098c==. & b13_098d==. & b13_098e==. & b13_098f==. & b13_099==. & b13_100==. & b13_101==. & b13_102a==. & b13_102b==. & b13_103==. if b13_096a==2 & b13_096b==2;
list b13_097a b13_097b b13_097c b13_097d b13_097e b13_097f b13_097g b13_097h b13_098a b13_098b b13_098c b13_098d b13_098e b13_098f b13_099 b13_100 b13_101 b13_102a b13_102b b13_103 if (b13_097a!=. | b13_097b!=. | b13_097c!=. | b13_097d!=. | b13_097e!=. | b13_097f!=. | b13_097g!=. | b13_097h!=. | b13_098a!=. | b13_098b!=. | b13_098c!=. | b13_098d!=. | b13_098e!=. | b13_098f!=. | b13_099!=. | b13_100!=. | b13_101!=. | b13_102a!=. | b13_102b!=. | b13_103!=.) & b13_096a==2 & b13_096b==2, compress nolab;
replace b13_097a=. if b13_096a==2 & b13_096b==2 & b13_097b==. & b13_097c==. & b13_097d==. & b13_097e==. & b13_097f==. & b13_097g==. & b13_097h==. & b13_098a==. & b13_098b==. & b13_098c==. & b13_098d==. & b13_098e==. & b13_098f==. & b13_099==. & b13_100==. & b13_101==. & b13_102a==. & b13_102b==. & b13_103==.;
replace b13_096b=1 if b13_097a!=. | b13_097b!=. | b13_097c!=. | b13_097d!=. | b13_097e!=. | b13_097f!=. | b13_097g!=. | b13_097h!=. | b13_098a!=. | b13_098b!=. | b13_098c!=. | b13_098d!=. | b13_098e!=. | b13_098f!=. | b13_099!=.;
assert b13_097a==. & b13_097b==. & b13_097c==. & b13_097d==. & b13_097e==. & b13_097f==. & b13_097g==. & b13_097h==. & b13_098a==. & b13_098b==. & b13_098c==. & b13_098d==. & b13_098e==. & b13_098f==. & b13_099==. & b13_100==. & b13_101==. & b13_102a==. & b13_102b==. & b13_103==. if b13_096a==2 & b13_096b==2;
* assert b13_100==. if b13_099==1;
replace b13_099=2 if b13_100!=.;
* assert b13_102a==. & b13_102b==. & b13_103==. if b13_101==2;
list b13_101 b13_102a b13_102b b13_103 if (b13_102a!=. | b13_102b!=. | b13_103!=.) & b13_101==2;
replace b13_101=1 if b13_101==2 & (b13_102a!=. | b13_102b!=.) & b13_103!=.;
* assert b13_105a==. & b13_105b==. & b13_106a==. & b13_106b==. & b13_107==. & b13_108==. if b13_104==2;
list b13_104 b13_105a b13_105b b13_106a b13_106b b13_107 b13_108 if (b13_105a!=. | b13_105b!=. | b13_106a!=. | b13_106b!=. | b13_107!=. | b13_108!=.) & b13_104==2;
replace b13_104=1 if (b13_105a!=. | b13_105b!=. | b13_106a!=. | b13_106b!=. | b13_107!=. | b13_108!=.) & b13_104==2;
* assert b13_110a==. & b13_110b==. if b13_109==2 | b13_109==3;
list b13_109 b13_110a b13_110b if (b13_110a!=. | b13_110b!=.) & (b13_109==2 | b13_109==3);
replace b13_109=1 if (b13_110a!=. | b13_110b!=.) & (b13_109==2 | b13_109==3);

sort hrbf_id1 hrbf_id2 b13d_pid;
save $cleandatadir/rwhrbf_b07.dta, replace;


************************************
*** Create rwhrbf_b07_with_studyarms
************************************;

ren b13d_pid a1_pid;
save $tempdatadir/rwhrbf_b07.dta, replace;

use $cleandatadir/rwhrbf_household_roster.dta, clear;
merge hrbf_id1 hrbf_id2 a1_pid using $tempdatadir/rwhrbf_b07.dta, unique;
tab _merge;
list hrbf_id1 hrbf_id2 a1_pid a1_02 if _merge==2;
drop if _merge==2;
drop _merge;
save $cleandatadir/rwhrbf_b07_withstudyarms.dta, replace;



*********************************************
*** Create necessary variables for mean tests
*********************************************;

foreach var of varlist b13_096a b13_096b b13_097a b13_097b b13_097c b13_097d b13_097e b13_097f b13_097g b13_097h b13_099 b13_101 b13_104 b13_108 {;
	gen `var'_1=`var'==1;
	replace `var'_1=. if `var'==.;
};
lab var b13_096a_1 "Met CHW at home past 3m";
lab var b13_096b_1 "Met CHW in community past 3m";
lab var b13_097a_1 "CHW provided ANC referral";
lab var b13_097b_1 "CHW provided delivery referral";
lab var b13_097c_1 "CHW provided PNC referral";
lab var b13_097d_1 "CHW provided VCT/PMTCT referral";
lab var b13_097e_1 "CHW provided FP";
lab var b13_097f_1 "CHW provided child vaccination";
lab var b13_097g_1 "CHW provided child nutrition";
lab var b13_097h_1 "CHW provided IEC session";
lab var b13_099_1 "Would recommend CHW";
lab var b13_101_1 "Knows where to be tested HIV";
lab var b13_104_1 "Ever been tested for HIV";
lab var b13_108_1 "HF gave HIV test result";

gen b13_096_1=b13_096a==1 | b13_096b==1;
replace b13_096a_1=. if b13_096a==. & b13_096b==.;
lab var b13_096_1 "Met CHW in last 3m";

egen b13_097_1=rowtotal(b13_097a b13_097b b13_097c b13_097d b13_097e b13_097f b13_097g b13_097h);
replace b13_097_1=b13_097_1/8;
lab var b13_097_1 "Nr services from CHW:0-1 score";

foreach var of varlist b13_098a b13_098b b13_098c b13_098d b13_098e b13_098f {;
	gen `var'_1=`var'==1;
	replace `var'_1=. if `var'==.;
	gen `var'_2=`var'==2;
	replace `var'_2=. if `var'==.;
	gen `var'_3=`var'==3;
	replace `var'_3=. if `var'==.;
};
lab var b13_098a_1 "CHW knowledge/response:Satisfied";
lab var b13_098a_2 "CHW knowledge/response:Neutral";
lab var b13_098a_3 "CHW knowledge/respse:Unsatisfied";
lab var b13_098b_1 "Enough CHW:Satisfied";
lab var b13_098b_2 "Enough CHW:Neutral";
lab var b13_098b_3 "Enough CHW:Unsatisfied";
lab var b13_098c_1 "CHW time/availability:Satisfied";
lab var b13_098c_2 "CHW time/availability:Neutral";
lab var b13_098c_3 "CHW time/availab:Unsatisfied";
lab var b13_098d_1 "CHW privacy/confid:Satisfied";
lab var b13_098d_2 "CHW privacy/confid:Neutral";
lab var b13_098d_3 "CHW privacy/confid:Unsatisfied";
lab var b13_098e_1 "CHW show respect:Satisfied";
lab var b13_098e_2 "CHW show respect:Neutral";
lab var b13_098e_3 "CHW show respect:Unsatisfied";
lab var b13_098f_1 "CHW role models:Satisfied";
lab var b13_098f_2 "CHW role models:Neutrals";
lab var b13_098f_3 "CHW role models:Unsatisfied";

gen b13_098_1=0;
foreach var of varlist b13_098a b13_098b b13_098c b13_098d b13_098e b13_098f {;
	replace b13_098_1=b13_098_1+1 if `var'==1;
	replace b13_098_1=b13_098_1+0 if `var'==2;
	replace b13_098_1=b13_098_1-1 if `var'==3;
};
replace b13_098_1=. if b13_098a==. & b13_098b==. & b13_098c==. & b13_098d==. & b13_098e==. & b13_098f==.;
sum b13_098_1;
local r=r(min);
gen b13_098_rank=b13_098_1+(-`r'+1);
sum b13_098_rank;
local R=r(max);
gen b13_098_2=(b13_098_rank-1)/(`R'-1);
sum b13_098_2;
drop b13_098_1;
ren b13_098_2 b13_098_1;
lab var b13_098_1 "Satisfaction w CHW:0-1 score";

forvalues v=1(1)4 {;
	gen b13_100_`v'=b13_100==`v';
	replace b13_100_`v'=. if b13_100==.;
};
gen b13_100_96=b13_100==96;
replace b13_100_96=. if b13_100==.;
lab var b13_100_1 "Not recommend CHW:Poor quality";
lab var b13_100_2 "Not recommend CHW:Not helpful";
lab var b13_100_3 "Not recom CHW:Treat expensive";
lab var b13_100_4 "Not recommend CHW:Hard to access";
lab var b13_100_96 "Not recommend CHW:other reason";

gen b13_102_1=b13_102a;
replace b13_102_1=b13_102a+b13_102b/60 if b13_102a!=. & b13_102b<.;
replace b13_102_1=b13_102b/60 if b13_102a==. & b13_102b<.;
lab var b13_102_1 "Time to walk to HIVtest site hrs";

forvalues v=1(1)4 {;
	gen b13_103_`v'=b13_103==`v';
	replace b13_103_`v'=. if b13_103==.;
};
gen b13_103_96=b13_103==96;
replace b13_103_96=. if b13_103==.;
lab var b13_103_1 "Learned about HIVtest center:CHW";
lab var b13_103_2 "Learned about HIVtest center:HF";
lab var b13_103_3 "Learned HIVtest center:Friends";
lab var b13_103_4 "Learned HIVtest center:Partner";
lab var b13_103_96 "Learned HIVtest center:other";

gen b13_105_1=b13_105b>=2009 & b13_105b!=.;
replace b13_105_1=. if b13_105b==.;
lab var b13_105_1 "HIV test 2009 or after";

gen b13_106_1=b13_106a;
replace b13_106_1=b13_106a+b13_106b/60 if b13_106a!=. & b13_106b!=.;
replace b13_106_1=b13_106b/60 if b13_106a==. & b13_106b!=.;
lab var b13_106_1 "Time walk last HIVtest site hrs";

gen b13_107_1=b13_107==1;
replace b13_107_1=. if b13_107==.;
lab var b13_107_1 "Ever tested:attended VCT";

gen b13_107_2=b13_107==2;
replace b13_107_2=. if b13_107==.;
lab var b13_107_2 "Ever tested:attended PMTCT";

gen b13_109_1=b13_109==1;
replace b13_109_1=. if b13_109==. | b13_109==3;
lab var b13_109_1 "Partner tested for HIV";

gen b13_110_1=b13_110b>=2009 & b13_110b!=.;
replace b13_110_1=. if b13_110b==.;
lab var b13_110_1 "Partners HIV test 2009 or after";

svyset [pweight=hhpweight], psu(hrbf_id1);
save $cleandatadir/rwhrbf_b07_withstudyarms_withvarformeantests.dta, replace;

log close;








	






