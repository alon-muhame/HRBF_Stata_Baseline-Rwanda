*Matt Mulligan Nov 2011
************************************************************************************************************************************
*Rwanda CHW Survey Master Do File
************************************************************************************************************************************

version 10.0
clear
set more off
set mem 500m
cap log close
set trace off

*************** Directory ********************************************************************************************
do "L:\Rwanda CHW Report\Stata Files\do files\Directory.do"

*************** Tab CHW1 *********************************************************************************************
*do "$dofile\Rwanda_CHW_tabvariables01.do"

*************** Clean ************************************************************************************************
do "$dofile\Rwanda_CHW_cr1.do"

*************** Analysis *********************************************************************************************
do "$dofile\Rwanda_CHW_an1.do"

************** Table Creation ****************************************************************************************
do "$dofile\Rwanda_CHW_desctables.do" //Creates file with that lists variable names and variable labels.
do "$dofile\Rwanda_CHW_baselinetables.do" //Merges data mean,ftest, and ttest data onto the above file

do "$dofile\Tables\table1.do" //Creates the final tables for report
do "$dofile\Rwanda_CHW_baselinebalancetable.do" //Summary Stats on number of variables with significannce

****************Graphs************************************************************************************************
*Were created to run separately of master do file
do "$dofile\Rwanda_CHW_graphs01.do"
do "$dofile\Rwanda_CHW_graphs02.do"

exit
