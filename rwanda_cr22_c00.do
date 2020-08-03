* Elisa Rothenbuhler - Sep 10

* This do-file:
* Creates clean child c00 dataset: $cleandatadir/rwhrbf_c00.dta.
* Merges $cleandatadir/rwhrbf_c00.dta with household-level dataset a00.


version 10.0
clear
set more off
set mem 500m
cap log close

#delimit ;

log using $logdir/rwanda_cr22_c00.log, replace;



*********************
*** Clean c00 section
*********************;

use $origdatadir/RWHRBF_C_CHILD_An-00.dta, clear;
*duplicates report c0_sect c0_vill;
*duplicates report c0_sect hrbf_id2;
duplicates report hrbf_id1 hrbf_id2;
tab c0_under5;
tab c15_01;
list hrbf_id1 hrbf_id2 c0_under5 c15_01 if c0_under5!=c15_01;

sort hrbf_id1 hrbf_id2;
save $cleandatadir/rwhrbf_c00.dta, replace;


************************************
*** Create rwhrbf_c00_with_studyarms
************************************;

use $cleandatadir/rwhrbf_a00_withstudyarms.dta, clear;
merge hrbf_id1 hrbf_id2 using $cleandatadir/rwhrbf_c00.dta, unique;
tab _merge;
list hrbf_id1 hrbf_id2 if _merge==2;
drop if _merge==2;
drop _merge;

svyset [pweight=hhpweight], psu(hrbf_id1);
save $cleandatadir/rwhrbf_c00_withstudyarms.dta, replace;
