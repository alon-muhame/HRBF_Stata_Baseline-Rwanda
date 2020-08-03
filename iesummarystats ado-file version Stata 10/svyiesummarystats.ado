program define svyiesummarystats
	syntax varlist(min=1 numeric) [if] , TREATment(varname) OUTPUTfile(string) PWEIGHT(varname) PSUclusterunit(varname) [STRata(varname)] [BROWSE] [2aster] [replace]

	******compute summary statistics*************************************
	if `"`if'"' != `""'  {   
   		keep `if'
		}
	preserve

	** check whether the treatment variable is really binary
	gen T=1
	gen C=0
	gen errort=0
	replace error=1 if `treatment'~=T &`treatment'~=C
	collapse (max) errort
	disp "If the program breaks here, then the treatment variable is not binary."
	error errort==1
	restore
	preserve

	** compute the summary stats
	cap mkdir temp
	quietly save temp\dataset.dta, replace
	cap erase temp\summstats.dta
	quietly foreach X in `varlist' {
		use  temp\dataset.dta, clear 
		svyset `psuclusterunit' [pweight=`pweight'], strata(`strata')
		statsby "svy: regress `X' `treatment'"  tstat=(_b[`treatment']/_se[`treatment']) nobstotal=e(N)
		gen str20 variablename="`X'"
		cap append using temp\tempsummstats.dta
		save temp\tempsummstats.dta, replace
		
		use  temp\dataset.dta, clear
		svyset `psuclusterunit' [pweight=`pweight'], strata(`strata')
		statsby "svy: mean `X', over(`treatment')" meancontrol=_b[0] errorcontrol=_se[0] meantreatment=_b[1] errortreatment=_se[1], clear
		gen str20 variablename="`X'"
		append using temp\tempsummstats.dta
		save temp\tempsummstats.dta, replace
		
		use  temp\dataset.dta, clear
		svyset `psuclusterunit' [pweight=`pweight'], strata(`strata')
		statsby "svy: mean `X' if `treatment'==0"    nobscontrol=e(N)
		gen str20 variablename="`X'"
		append using temp\tempsummstats.dta
		save temp\tempsummstats.dta, replace

		use  temp\dataset.dta, clear
		svyset `psuclusterunit' [pweight=`pweight'], strata(`strata')
		statsby "svy:mean `X' if `treatment'==1"  nobstreatment=e(N)
		gen str20 variablename="`X'"
		append using temp\tempsummstats.dta
		save temp\tempsummstats.dta, replace
		} 
	
	use temp\tempsummstats.dta, clear
	quietly collapse (max) nobscontrol meancontrol  errorcontrol  nobstreatment meantreatment errortreatment tstat nobstotal, by(variablename)
	gen difference=meantreatment-meancontrol
	order variablename meantreatment errortreatment nobstreatment meancontrol errorcontrol nobscontrol difference tstat nobstotal
	sort variablename
	replace variablename=trim(variablename)
	gen significance=ttail(nobscontrol+nobstreat-1,abs(tstat))*2
	** note that ttail is a one-tailed test while the stars need to be based on a two-tailed test - hence the adjustment below in calculating the significance

	*** generate the significance stars (ten percent, five percent and one percent repectively)
	gen str3 stars="*" if significance<0.1
	replace stars="**" if significance<0.05
	replace stars="***" if significance<0.01
	gen str6 asters="`2aster'"
	replace stars=subinstr(stars,"*","",1) if asters=="2aster"
	drop asters
	*drop significance
	erase temp\tempsummstats.dta


	*** put all the summary statistics into a neat table
	gen line=.
	local count=1
	foreach variable in `varlist' {
		replace line=`count' if variablename=="`variable'"
		local count=`count'+1
	}	
		sort line
	order line
	`browse' 
	outsheet using `outputfile'.out, `replace'
	save `outputfile'.dta, `replace'
	display "THE SUMMARY STATS TABLE WAS EXPORTED TO THE `outputfile'.out AND TO THE `outputfile'.dta FILES."
	restore
end





***************************************************************************
*This ado file computes summary statistics by treatment and comparison group
*You can cluster the t-stats calculations
*version 2.0
*Last update: March 17, 2011
*Tested on Stata version 10
*Author: Christel Vermeersch
*Send comments to cvermeersch@worldbank.org
***************************************************************************
