cap log close
log using "$log\rwanda_tab_chw1.log", replace

use "$chw1", clear

foreach x of varlist d1_02 d1_04 d1_08 d1_10 d1_13y d1_14hrs d1_14days d1_16hrs d1_16min d1_17 d1_18 d1_19km d1_21km d1_24 {
	display "`x'"
	tab `x' 
}
destring d1_10, replace
tab d1_10

tab d1_14hrs d1_14days

tab d1_09 d1_10

//replace d1_02=. if d1_02<15
//replace d1_04=. if d1_04>82
//mvdecode d1_08,mv(90000)
//mvdecode d1_10, mv(63)
//replace d1_13y=. if d1_13y>82
//gen flag=1 if (d1_14hrs==0 & d1_14days>0)
//gen hours_week=( d1_14days* d1_14hrs) if flag!=1
//mvdecode d1_16hrs,mv(300)
//mvdecode d1_16min,mv(98)
//gen d1_16hrs_2= d1_16hrs*60
//egen total_minutes_HC= rsum(d1_16min d1_16hrs_2)
//gen d1_17_2=d1_17
//centile d1_17 if d1_17!=0, centile(1 99)
//replace d1_17_2=. if (d1_17<r(c11) | d1_17>r(c_2))
//gen d1_18_2= d1_18
//centile d1_17, centile(1 99)
//replace d1_18_2=. if d1_18>r(c_2)
//label var d1_17_2 "Number of households responsible for in village, exclude top/bottom 1%"
//label var d1_18_2 "Number of households visited last month, exclude top 1%"
//mvdecode d1_19km, mv(0)
//replace d1_21km=. if d1_21km>50
//mvdecode d1_21km, mv(0)
//gen d1_24_2= d1_24
//centile d1_24, centile(1 99)
//replace d1_24_2=. if (d1_24<r(c_1)  | d1_24>r(c_2))
//label var d1_24_2 "Number of CHWs on team, exclude top/bottom 1%"

use "$chw3", clear
foreach y of varlist d3_02 d3_06a-d3_06f d3_08a-d3_08c d3_09a-d3_09c d3_15 {
	display "`y'"
	tab `y'
}
use "$chw4", clear

display "d4_03"
tab d4_03

use "$chw6", clear
display "d6_08"
tab d6_08


capture log close
clear
exit