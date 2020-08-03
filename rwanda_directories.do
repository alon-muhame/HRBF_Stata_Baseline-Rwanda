* Elisa Rothenbuhler - Feb 2011

version 10.0
clear 
set more off
set mem 500m

#delimit ;

sysdir set PERSONAL "/Library/Application Support/Stata/ado/personal";

global dodir "/Users/elisarothenbuhler/Desktop/WB*HRITF/Rwanda/dofiles";
global origdatadir "/Users/elisarothenbuhler/Desktop/WB*HRITF/Rwanda/data/original";
global cleandatadir "/Users/elisarothenbuhler/Desktop/WB*HRITF/Rwanda/data/clean";
global tempdatadir "/Users/elisarothenbuhler/Desktop/WB*HRITF/Rwanda/data/temp";
global logdir "/Users/elisarothenbuhler/Desktop/WB*HRITF/Rwanda/logfiles";
global resultdir "/Users/elisarothenbuhler/Desktop/WB*HRITF/Rwanda/results";
global tempresultdir "/Users/elisarothenbuhler/Desktop/WB*HRITF/Rwanda/results/temp";
global graphresultdir "/Users/elisarothenbuhler/Desktop/WB*HRITF/Rwanda/results/graphs";



* Tables of Gender tests directories;
global a04resultdir "/Users/elisarothenbuhler/Desktop/WB*HRITF/Rwanda/results/health_knowledge_results";
global a04men_resultdir "/Users/elisarothenbuhler/Desktop/WB*HRITF/Rwanda/results/health_knowledge_results/men";
global a04women_resultdir "/Users/elisarothenbuhler/Desktop/WB*HRITF/Rwanda/results/health_knowledge_results/women";
global a04men_vs_women_resultdir "/Users/elisarothenbuhler/Desktop/WB*HRITF/Rwanda/results/health_knowledge_results/men_vs_women";
global a04men_tempresultdir "/Users/elisarothenbuhler/Desktop/WB*HRITF/Rwanda/results/health_knowledge_results/men/temp";
global a04women_tempresultdir "/Users/elisarothenbuhler/Desktop/WB*HRITF/Rwanda/results/health_knowledge_results/women/temp";
global a04men_vs_women_tempresultdir "/Users/elisarothenbuhler/Desktop/WB*HRITF/Rwanda/results/health_knowledge_results/men_vs_women/temp";