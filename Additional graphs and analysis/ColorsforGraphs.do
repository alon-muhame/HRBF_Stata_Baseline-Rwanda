*Set Color Sequence
* Note: this code expects 75 entries in local -colors-
* - "none" is a placeholder; my Stata has 72 colors, so I use 3 placeholders
* - you may rearrange the colors and placeholders to suit your preference
* To see the graph code, change the -run- to -do- in the last line
*
local colors "gs0 gs1 gs2 gs3 gs4 gs5 gs6 gs7 gs8 gs9 gs10"
local colors "`colors' gs11 gs12 gs13 gs14 gs15 gs16 dimgray gray black"
local colors "`colors' dknavy navy8 navy edkblue emidblue eltblue ebblue"
local colors "`colors' midblue blue lavender cyan ltblue edkbg ebg bluishgray8"
local colors "`colors' ltbluishgray8 bluishgray ltbluishgray none none"
local colors "`colors' olive_teal eltgreen teal emerald forest_green dkgreen"
local colors "`colors' green midgreen lime mint sunflowerlime sandb yellow"
local colors "`colors' gold dkorange orange orange_red red cranberry pink"
local colors "`colors' magenta purple maroon erose none brown olive chocolate"
local colors "`colors' sienna sand khaki stone ltkhaki eggshell white"
* generate the graph code
tempname fh
tempfile fn
file open `fh' using `fn'.do, write
local k 0
forvalues y = 1/15 {
local y0 = `y' - 1
forvalues x = 1/5 {
local x0 = `x' - 1
local k = `k' + 1
local c : word `k' of `colors'
if `k' == 1 file write `fh' "graph tw ///" _n
file write `fh' `"|| scatteri `y' `x0' `y' `x', "'
file write `fh' `"base(`y0') fc(`c') lc(black) recast(area) ///"' _n
file write `fh' `"|| scatteri `y' `x0' (5) "`c'", "'
file write `fh' `"msym(i) mlabc(black) ///"' _n
if `k' == 75 {
file write `fh' "legend(off) xsca(off) ysca(off) xsiz(7.9) ysiz(10.6)" _n
}
}
}
file close `fh'
run `fn'.do
