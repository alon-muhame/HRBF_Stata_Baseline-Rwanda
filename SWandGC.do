





log using "$log/spandgc", replace

use "$origdata/rwanda_CPBF_sample_weights_2011.3.14.dta", clear
gen hhpweight=1/((1/number_hh2)*(12/number_villages))
lab var hhpweight "Pweight for households in each village"

* Re-create geographic IDs that are not the combination of higher-level geographic IDs (e.g. avoid that for district 201, sector is 20101, cell is 2010101 and village is 201010103, but rather have the combination of district 201, sector 01, cell 01, village 03 that constitute the full ID of a village)

tostring d0_dist d0_sect d0_cell d0_vill, gen(a0_dist_2 d0_sect_str d0_cell_str d0_vill_str)
gen a0_sect_2=regexr(d0_sect_str,a0_dist_2,"")
gen a0_cell_2=regexr(d0_cell_str,d0_sect_str,"")
gen a0_vill_2=regexr(d0_vill_str,d0_cell_str,"")
drop d0_sect_str d0_cell_str d0_vill_str
save $cleandatadir/rwanda_weighted_villages.dta, replace