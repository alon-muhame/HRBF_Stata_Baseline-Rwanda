capture log close

//Directory for Datasets and Graph Files
global cleandatadir "L:/Rwanda/data/clean"
global rwandaupdatedgraphs "L:/UpdatedGraphs\Graphs"
global loganddofiles "L:/UpdatedGraphs"

set more off



use $cleandatadir/rwhrbf_a02_withstudyarms_withvarformeantests.dta

//Change "children care" to "child care"
label variable a2_10c "Child care (hrs)"

graph pie a2_10a a2_10b a2_10c a2_10d a2_10e a2_10f a2_10g [pweight=hhpweight], ///
	sort pie(7, color(maroon)) pie(6, color(lavender)) pie(5, color(cranberry)) pie(4, color(navy)) pie(3,color(orange)) pie(2, color(forest_green))  pie(1, color(emerald)) title("Hours Spent in Various Activities in Last 7 Days", size(medsmall) span) subtitle("Age 5 and Older", span) 
graph export $rwandaupdatedgraphs/a02_time_use_1.emf, replace

graph pie a2_10a a2_10b a2_10c a2_10d a2_10e a2_10f a2_10g if a1_02==2 [pweight=hhpweight], ///
	sort pie(6, color(maroon)) pie(7, color(lavender)) pie(4, color(cranberry)) pie(5, color(navy)) pie(3,color(orange)) pie(2, color(forest_green))  pie(1, color(emerald)) title("Hours Spent in Various Activities in Last 7 days", size(medsmall) span) subtitle(" Women Age 5 and Older", span) 
graph export $rwandaupdatedgraphs/a02_time_use_2.emf, replace

graph pie a2_10a a2_10b a2_10c a2_10d a2_10e a2_10f a2_10g if a1_15_mother==1 [pweight=hhpweight], ///
	 sort pie(6, color(maroon)) pie(7, color(lavender)) pie(5, color(cranberry)) pie(2, color(navy)) pie(3,color(orange)) pie(1, color(forest_green))  pie(4, color(emerald))  title("Hours Spent in Various Activities in last 7 Days", size(medsmall) span) subtitle("Mother of Youngest Child", span) 
graph export $rwandaupdatedgraphs/a02_time_use_3.emf, replace 

graph pie a2_10a a2_10b a2_10c a2_10d a2_10e a2_10f a2_10g if a1_11a<=12 [pweight=hhpweight], ///
	sort pie(5, color(maroon)) pie(3, color(lavender)) pie(1, color(cranberry)) pie(7, color(navy)) pie(6,color(orange)) pie(4, color(forest_green))  pie(2, color(emerald))  title("Hours Spent in Various Activities in Last 7 Days" , size(medsmall) span) subtitle("Children Age 5-12", span) 
graph export $rwandaupdatedgraphs/a02_time_use_4.emf, replace

end