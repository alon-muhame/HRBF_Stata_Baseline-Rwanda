* Elisa Rothenbuhler - Sep 10

* This do-file:
* Merges male and female sections for health knowledge a04 and b08 to create $cleandatadir/rwhrbf_a04_b08_withstudyarms.dta.
* Creates necessary variables for mean tests.

version 10.0
clear
set more off
set mem 500m
cap log close

#delimit ;

log using $logdir/rwanda_cr7_a04_b08.log, replace;


***************************************************************
*** Merge Male and female Health knowledge sections a04 and b08
***************************************************************;

use $cleandatadir/rwhrbf_b08_withstudyarms.dta, clear;

#delimit cr
ren b13e_seq a4_seq 
ren b13_111a a4_10a
ren b13_111b a4_10b  
ren b13_111c a4_10c  
ren b13_111d a4_10d
ren b13_112a a4_11a  
ren b13_112b a4_11b
ren b13_112c a4_11c    
ren b13_112d a4_11d 
ren b13_113a a4_12a  
ren b13_113b a4_12b 
ren b13_113c a4_12c   
ren b13_113d a4_12d
ren b13_113e a4_12e   
ren b13_114a a4_13a
ren b13_114b a4_13b   
ren b13_114c a4_13c     
ren b13_114d a4_13d 
ren b13_115a a4_14a   
ren b13_115b a4_14b  
ren b13_115c a4_14c
ren b13_115d a4_14d
ren b13_116a a4_15a      
ren b13_116b a4_15b 
ren b13_116c a4_15c   
ren b13_116d a4_15d 
ren b13_116e a4_15e
ren b13_117a a4_16a     
ren b13_117b a4_16b
ren b13_117c a4_16c
ren b13_117d a4_16d  
ren b13_117e a4_16e
drop hhpweight
#delimit ;

sort hrbf_id1 hrbf_id2 a1_pid;
save $tempdatadir/rwhrbf_b08_withstudyarms_renamed_var.dta, replace;

use $cleandatadir/rwhrbf_a04_withstudyarms.dta, clear;
merge hrbf_id1 hrbf_id2 a1_pid using $tempdatadir/rwhrbf_b08_withstudyarms_renamed_var.dta, unique update;
* assert a1_11a>=15 & a1_11a<=49 if hrbf_rectype!="";
list hrbf_id1 hrbf_id2 a1_pid a1_11a a1_11b if (a1_11a<15 | a1_11a>49) & hrbf_rectype!="";
tab _merge;
drop _merge;
save $cleandatadir/rwhrbf_a04_b08_withstudyarms.dta, replace;

*********************************************
*** Create necessary variables for mean tests
*********************************************;
//Must answer all parts of each question;
foreach x in a b c d {;
	replace a4_10`x' =. if a4_10a==. | a4_10b==. | a4_10c==. | a4_10d==.;
};
foreach x in a b c d {;
	replace a4_11`x' =. if a4_11a==. | a4_11b==. | a4_11c==. | a4_11d==.;
};
foreach x in a b c d e {;
	replace a4_12`x' =. if a4_12a==. | a4_12b==. | a4_12c==. | a4_12d==. | a4_12e ==.;
};
foreach x in a b c d {;
	replace a4_13`x' =. if a4_13a==. | a4_13b==. | a4_13c==. | a4_13d==.;
};
foreach x in a b c d {;
	replace a4_14`x' =. if a4_14a==. | a4_14b==. | a4_14c==. | a4_14d==.;
};
foreach x in a b c d e {;
	replace a4_15`x' =. if a4_15a==. | a4_15b==. | a4_15c==. | a4_15d==.| a4_15e==.;
};
foreach x in a b c d e {;
	replace a4_16`x' =. if a4_16a==. | a4_16b==. | a4_16c==. | a4_16d==. | a4_16e==.;
};

foreach var of varlist a4_10a a4_10c a4_10d a4_11c a4_12c a4_13a a4_13b a4_13c a4_14a a4_14b a4_14c a4_14d a4_15a a4_15b a4_15c a4_15d a4_16a a4_16b a4_16c {;
	gen `var'_1=`var'==1;
	replace `var'_1=. if `var'==.;
};

foreach var of varlist a4_10b a4_11a a4_11b a4_11d a4_12a a4_12b a4_12d a4_12e a4_13d a4_15e a4_16d a4_16e {;
	gen `var'_1=`var'==2;
	replace `var'_1=. if `var'==.;
};


lab var a4_10a_1 "Wash hands:remove dirt";
lab var a4_10b_1 "Wash hands:prevent HIV";
lab var a4_10c_1 "Wash hands:avoid diarrhea";
lab var a4_10d_1 "Wash hands:prevent skin inf";
lab var a4_11a_1 "Drink treated water near animals";
lab var a4_11b_1 "Drink treated stagnate water";
lab var a4_11c_1 "Drink treated spring/well water";
lab var a4_11d_1 "Drink treated stream/river water";
lab var a4_12a_1 "Diarrhea:Give 1l/day ORT";
lab var a4_12b_1 "Diarrhea:Give 3-4gl/day ORT";
lab var a4_12c_1 "1/4-1/2cup ORT each watery stool";
lab var a4_12d_1 "Diarrhea:Give 1l/day water only";
lab var a4_12e_1 "Diarrhea:Give other treatment";
lab var a4_13a_1 "Danger pregnancy:fever";
lab var a4_13b_1 "Danger pregnancy:vagina bleeds";
lab var a4_13c_1 "Danger pregnancy:swelling";
lab var a4_13d_1 "Danger pregnancy:loss appetite";
lab var a4_14a_1 "Danger baby:convulsion";
lab var a4_14b_1 "Danger baby:fever";
lab var a4_14c_1 "Danger baby:no breastfeeding";
lab var a4_14d_1 "Danger baby:breathing quickly";
lab var a4_15a_1 "Vaccine for: polio";
lab var a4_15b_1 "Vaccine for: measles";
lab var a4_15c_1 "Vaccine for: tetanus";
lab var a4_15d_1 "Vaccine for: TB";
lab var a4_15e_1 "Vaccine for: AIDS";
lab var a4_16a_1 "Contraception: oral";
lab var a4_16b_1 "Contraception: DMPA";
lab var a4_16c_1 "Contraception: IUD";
lab var a4_16d_1 "Contraception: Breastfeeding";
lab var a4_16e_1 "Contraception: Withdrawal";
/* Old Code
gen a4_healthscore=.;
replace a4_healthscore=1 if a4_10a==1;
replace a4_healthscore=a4_healthscore+1 if a4_10b==2;
replace a4_healthscore=a4_healthscore+1 if a4_10c==1;
replace a4_healthscore=a4_healthscore+1 if a4_10d==1;

replace a4_healthscore=a4_healthscore+1 if a4_11a==2;
replace a4_healthscore=a4_healthscore+1 if a4_11b==2;
replace a4_healthscore=a4_healthscore+1 if a4_11c==1;
replace a4_healthscore=a4_healthscore+1 if a4_11d==2;

replace a4_healthscore=a4_healthscore+1 if a4_12a==2;
replace a4_healthscore=a4_healthscore+1 if a4_12b==2;
replace a4_healthscore=a4_healthscore+1 if a4_12c==1;
replace a4_healthscore=a4_healthscore+1 if a4_12d==2;
replace a4_healthscore=a4_healthscore+1 if a4_12e==2;

replace a4_healthscore=a4_healthscore+1 if a4_13a==1;
replace a4_healthscore=a4_healthscore+1 if a4_13b==1;
replace a4_healthscore=a4_healthscore+1 if a4_13c==1;
replace a4_healthscore=a4_healthscore+1 if a4_13d==2;

replace a4_healthscore=a4_healthscore+1 if a4_14a==1;
replace a4_healthscore=a4_healthscore+1 if a4_14b==1;
replace a4_healthscore=a4_healthscore+1 if a4_14c==1;
replace a4_healthscore=a4_healthscore+1 if a4_14d==1;

replace a4_healthscore=a4_healthscore+1 if a4_15a==1;
replace a4_healthscore=a4_healthscore+1 if a4_15b==1;
replace a4_healthscore=a4_healthscore+1 if a4_15c==1;
replace a4_healthscore=a4_healthscore+1 if a4_15d==1;
replace a4_healthscore=a4_healthscore+1 if a4_15e==2;

replace a4_healthscore=a4_healthscore+1 if a4_16a==1;
replace a4_healthscore=a4_healthscore+1 if a4_16b==1;
replace a4_healthscore=a4_healthscore+1 if a4_16c==1;
replace a4_healthscore=a4_healthscore+1 if a4_16d==2;
replace a4_healthscore=a4_healthscore+1 if a4_16e==2;

replace a4_healthscore=a4_healthscore/31;
lab var a4_healthscore "0-1 Score on health knowledge";
*/
**********************NEW Health Score Calculations to Account for Missing Values***********************;



#delimit ;
//Must answer complete question.  Therefore, creating missing values if any part of question a-d is left blank.;  


#delimit ;
gen a4_healthscore = a4_10a==1;
replace a4_healthscore=a4_healthscore+1 if a4_10b==2;
replace a4_healthscore=a4_healthscore+1 if a4_10c==1;
replace a4_healthscore=a4_healthscore+1 if a4_10d==1;

replace a4_healthscore=a4_healthscore+1 if a4_11a==2;
replace a4_healthscore=a4_healthscore+1 if a4_11b==2;
replace a4_healthscore=a4_healthscore+1 if a4_11c==1;
replace a4_healthscore=a4_healthscore+1 if a4_11d==2;

replace a4_healthscore=a4_healthscore+1 if a4_12a==2;
replace a4_healthscore=a4_healthscore+1 if a4_12b==2;
replace a4_healthscore=a4_healthscore+1 if a4_12c==1;
replace a4_healthscore=a4_healthscore+1 if a4_12d==2;
replace a4_healthscore=a4_healthscore+1 if a4_12e==2;

replace a4_healthscore=a4_healthscore+1 if a4_13a==1;
replace a4_healthscore=a4_healthscore+1 if a4_13b==1;
replace a4_healthscore=a4_healthscore+1 if a4_13c==1;
replace a4_healthscore=a4_healthscore+1 if a4_13d==2;

replace a4_healthscore=a4_healthscore+1 if a4_14a==1;
replace a4_healthscore=a4_healthscore+1 if a4_14b==1;
replace a4_healthscore=a4_healthscore+1 if a4_14c==1;
replace a4_healthscore=a4_healthscore+1 if a4_14d==1;

replace a4_healthscore=a4_healthscore+1 if a4_15a==1;
replace a4_healthscore=a4_healthscore+1 if a4_15b==1;
replace a4_healthscore=a4_healthscore+1 if a4_15c==1;
replace a4_healthscore=a4_healthscore+1 if a4_15d==1;
replace a4_healthscore=a4_healthscore+1 if a4_15e==2;

replace a4_healthscore=a4_healthscore+1 if a4_16a==1;
replace a4_healthscore=a4_healthscore+1 if a4_16b==1;
replace a4_healthscore=a4_healthscore+1 if a4_16c==1;
replace a4_healthscore=a4_healthscore+1 if a4_16d==2;
replace a4_healthscore=a4_healthscore+1 if a4_16e==2;

gen nonmissing =0 ;
#delimit ;
foreach var of varlist a4_10a a4_10b a4_10c a4_10d a4_11a a4_11b a4_11c a4_11d a4_12a a4_12b a4_12c a4_12c a4_12d a4_12e a4_13a a4_13b a4_13c a4_13d a4_14a a4_14b a4_14c a4_14d a4_15a a4_15b a4_15c a4_15d a4_15e a4_16a a4_16b a4_16c a4_16d a4_16e{;
	replace nonmissing=nonmissing+1 if !missing(`var');
	
};

replace a4_healthscore=a4_healthscore/nonmissing;
lab var a4_healthscore "0-1 Score on health knowledge";

svyset [pweight=hhpweight], psu(hrbf_id1);
save $cleandatadir/rwhrbf_a04_b08_withstudyarms_withvarformeantests.dta, replace;