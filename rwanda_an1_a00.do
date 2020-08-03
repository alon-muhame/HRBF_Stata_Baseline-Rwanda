* Elisa Rothenbuhler - Aug 10

* This do-file:
* Obtains summary statistics on the sample based on $cleandatadir/rwhrbf_a00_withstudyarms.dta.

version 10.0
clear
set more off
set mem 500m
cap log close

#delimit ;

log using $logdir/rwanda_an1_a00.log, replace;

use $cleandatadir/rwhrbf_a00_withstudyarms.dta;

unique hrbf_id1, by(group_code) gen(nr_sectors_per_arm);
bysort group_code: egen nr_hh_per_arm=count(hrbf_id1);

tabstat nr_sectors_per_arm nr_hh_per_arm, by(group_code) statistics(mean) nototal save;
mat def A=(1\2\3\4),(r(Stat1)\r(Stat2)\r(Stat3)\r(Stat4));
mat rownames A= Demand_side Supply_side Demand_and_Supply_side Control;
mat colnames A=Study_arm Nr_Sectors Nr_Households;
mat2txt, matrix(A) saving($resultdir/Summary_Sectors_HH_per_study_arm.txt) replace title(Description of the sample per study arm) note(Off the 200 initial randomized sectors, one sector from the control group had to be replaced, but couldn't because no replacement sector had been randomly preselected. The sector was dropped from the analysis. Another randomly selected sector from the control group, Gishyita, was missing in the household dataset. Therefore 48 and not 50 sectors constitute the control group.);

drop nr_sectors_per_arm nr_hh_per_arm;
clear;

log close;

