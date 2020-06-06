//Simple multinomial regression. 
//Ruby Grounds emet8002

// getting the variables of interest. 
clear all               // clear memory
capture log close       // close any open log files
set more off            // don't pause when screen fills

use xwaveid pjbhrcpr pesdtl phgsex pjomdw pjomfd pjomflex pesbrd pwscei pedhigh1 using /Users/rubygrounds/Documents/case/ADA/Combined_p160c.dta


// time to clean!

* start by relabelling the variables
rename phgsex sex
rename pesbrd employmentbrd
rename pesdtl employment
rename pjbhrcpr preference
rename pjomflex flexibility
rename pjomfd freedom
rename pjomdw choice 
rename pedhigh1 education 


replace sex = 1 if sex == 1
replace sex = 0 if sex == 2

keep if employmentbrd == 1

replace employment = 0 if employment == 2 // dummy for full time employment 

replace preference = . if preference == -3 
replace preference = . if preference == -4 

replace choice = . if choice == -8
replace choice = . if choice == -1
replace choice = . if choice == -4
replace choice = . if choice == -5

replace flex = . if flex == -8
replace flex = . if flex == -1
replace flex = . if flex == -4
replace flex = . if flex == -5

replace freedom = . if freedom == -8
replace freedom = . if freedom == -1
replace freedom = . if freedom == -4
replace freedom = . if freedom == -5

//drop part time workers 



// trying out some multinomial regression


mlogit preference flexibility freedom choice , base(2)
eststo reg4

mlogit preference sex employment flexibility freedom choice, base(2)
eststo reg5

mlogit preference sex employment flexibility freedom choice i.education, base(2)
eststo reg6

esttab reg4 reg5 reg5 using reg2.tab, se keep(sex employment flexibility freedom choice) replace



log close 

