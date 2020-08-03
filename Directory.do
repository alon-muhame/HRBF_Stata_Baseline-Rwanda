*Matt Mulligan Nov 2011

*******************************************************************
*Directory for Rwanda CHW Survey
*******************************************************************

gl log "L:\Rwanda CHW Report\Stata Files\Log Files"
gl clean "L:\Rwanda CHW Report\Stata Files\Updated Data"
gl output "L:\Rwanda CHW Report\Stata Files\Output"
gl tempres "L:\Rwanda CHW Report\Stata Files\Temp"
gl dofile "L:\Rwanda CHW Report\Stata Files\do files"
gl origdata "L:\Rwanda\data\original"
gl tables "L:\Rwanda CHW Report\Stata Files\do files\Tables"

gl studyarmbase "L:\Rwanda\data\original\rwanda_rbf_baseline_study_arms_2010_8_10.dta" 
*The above Data File is made by Elisa using rwanda_cr1_a00.do


**************** Original Data ******************************
gl chw0 "L:\Rwanda\data\original\rwHRBF_D CHWs -00.dta" 
gl chw1 "L:\Rwanda\data\original\rwHRBF_D CHWs -01.dta"
gl chw2 "L:\Rwanda\data\original\rwHRBF_D CHWs -02.dta"
gl chw3 "L:\Rwanda\data\original\rwHRBF_D CHWs -03.dta"
gl chw4 "L:\Rwanda\data\original\rwHRBF_D CHWs -04.dta"
gl chw5 "L:\Rwanda\data\original\rwHRBF_D CHWs -05.dta"
gl chw6 "L:\Rwanda\data\original\rwHRBF_D CHWs -06.dta"
gl chw7 "L:\Rwanda\data\original\rwHRBF_D CHWs -07.dta"
gl chw8 "L:\Rwanda\data\original\rwHRBF_D CHWs -08.dta"
gl chw9 "L:\Rwanda\data\original\rwHRBF_D CHWs -09.dta"

exit
