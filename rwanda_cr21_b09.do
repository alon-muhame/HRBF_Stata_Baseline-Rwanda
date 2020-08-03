* Elisa Rothenbuhler - Sep 10

* This do-file:
* Creates clean female b09 dataset: $cleandatadir/rwhrbf_b09.dta.
* Merges $cleandatadir/rwhrbf_b09.dta with household roster.
* Generates appropriate variables for mean tests.


version 10.0
clear
set more off
set mem 500m
cap log close

#delimit ;

log using $logdir/rwanda_cr21_b09.log, replace;



*********************
*** Clean b09 section
*********************;

use $origdatadir/RWHRBF_B_FEMALE-09.dta, clear;

drop if b13_118y==. & b13_118m==. & b13_119==. & b13_120d==. & b13_120m==. & b13_120y==. & b13_121==. & b13_122==. & b13_123==.;
duplicates report hrbf_id1 hrbf_id2 b13f_pid;

tab1 b13_118y b13_118m b13_119 b13_120d b13_120m b13_120y b13_121 b13_122 b13_123 b13_123, nolab;
replace b13_118y=. if b13_118y<=4;
replace b13_118y=. if b13_118y==95;
replace b13_118m=3 if b13_118m==34;
mvdecode b13_120d,mv(0);
mvdecode b13_120m,mv(13=.c\15=.d\16=.e\17=.f\18=.g\19=.h\20=.i\21=.j\22=.k\23=.l\24=.m\25=.n\26=.o\27=.p\28=.q\29=.r\30=.s\31=.t);
replace b13_120y=2010 if b13_120y==10 | b13_120y==0 | b13_120y==201;
replace b13_120y=2009 if b13_120y==2004 | b13_120y==2006;

tab b13_123 b13_121 if b13_123<30;
replace b13_121=.c if (b13_121==float(0) & b13_121==float(0)) | (b13_121==float(1.5) & b13_121==float(0)) | (b13_121==float(1.5) & b13_121==float(5.9)) | (b13_121==float(1.6) & b13_121==float(7.2)) | (b13_121==float(1.6) & b13_121==float(17.4)) | (b13_121==float(1.7) & b13_121==float(19.8)) | (b13_121==float(56) & b13_121==float(1.5));
replace b13_123=.c if b13_121==.c;
tab b13_123 b13_121 if b13_123>float(154);
replace b13_121=.c if b13_121==float(1.5) & b13_123==float(521);
replace b13_121=b13_121*10 if b13_121<=16;
replace b13_121=.c if b13_121<100;
replace b13_121=. if b13_121==float(0);
replace b13_121=float(143.7) if b13_121==float(43.7);
replace b13_121=float(152.7) if b13_121==float(52.7);
replace b13_121=float(156) if b13_121==float(56);
tab b13_121;
tab b13_123;
replace b13_123=.c if b13_123<=28;
replace b13_123=b13_123/10 if b13_123>=158 & b13_123<.;
replace b13_123=.c if b13_123==float(15.8);
tab b13_123;

sort hrbf_id1 hrbf_id2 b13f_pid;
save $cleandatadir/rwhrbf_b09.dta, replace;


************************************
*** Create rwhrbf_b09_with_studyarms
************************************;

ren b13f_pid a1_pid;
save $tempdatadir/rwhrbf_b09.dta, replace;

use $cleandatadir/rwhrbf_household_roster.dta, clear;
merge hrbf_id1 hrbf_id2 a1_pid using $tempdatadir/rwhrbf_b09.dta, unique;
tab _merge;
list hrbf_id1 hrbf_id2 a1_pid a1_02 if _merge==2;
drop if _merge==2;
drop _merge;
save $cleandatadir/rwhrbf_b09_withstudyarms.dta, replace;



*********************************************
*** Create necessary variables for mean tests
*********************************************;

gen b13_118_1=b13_118y;
replace b13_118_1=b13_118y+b13_118m/12 if b13_118y<. & b13_118m<.;
replace b13_118_1=b13_118m/12 if b13_118y>=. & b13_118m<.;
lab var b13_118_1 "Age years";

gen b13_119_1=b13_119==1;
replace b13_119_1=. if b13_119==.;
lab var b13_119_1 "Consented to be measured";

gen b13_122_1=b13_122==1;
replace b13_122_1=. if b13_122==.;
lab var b13_122_1 "Measured standing";

gen b13_122_2=b13_122==2;
replace b13_122_2=. if b13_122==.;
lab var b13_122_2 "Measured lying";

svyset [pweight=hhpweight], psu(hrbf_id1);
save $cleandatadir/rwhrbf_b09_withstudyarms_withvarformeantests.dta, replace;

log close;

