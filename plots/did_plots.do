set more off
use did_data_1.dta, clear

// Graph 1: A simple line graph showing the two groups
preserve
collapse y, by(treated_id time)

graph twoway (line y time if treated_id==1) || (line y time if treated_id==0), legend(label(1 "Treatment") label(2 "Control"))
restore

// Graph 2: Plot for representing regression results graphically
// Can also be used for graphically representing regression tables
xtset id time

gen time_did = 50 if treated_id ==1
replace time_did = 200 if treated_id ==0

////gen time_did = 30 if treated_1 ==1
////replace time_did = 60 if treated_2==1
////replace time_did = 200 if time_did==.

gen diff_time = time - time_did
gen diff_time_0= diff_time == 0

foreach num of numlist 1(1)3{
gen diff_time_p`num'= diff_time == `num'
}

foreach num of numlist 1(1)4{
gen diff_time_m`num'= diff_time == -`num'
}

gen diff_time_m5= diff_time <= -5  & diff_time!=.
gen diff_time_p4= diff_time >= 4 & diff_time!=.

gen zero = 0

global prepost diff_time_m5 diff_time_m4 diff_time_m3 diff_time_m2  zero diff_time_0 diff_time_p1  diff_time_p2  diff_time_p3  diff_time_p4


est clear
reghdfe y $prepost, absorb(time id treated_id#c.time) cl(id)
eststo f1

graph drop _all
#delimit ;
coefplot f1, omitted
 keep(diff_time_m5 diff_time_m4 diff_time_m3 diff_time_m2 zero diff_time_0 diff_time_p1  diff_time_p2  diff_time_p3  diff_time_p4) vertical
 lcolor(gs6) mlcolor(gs6) mfcolor(gs6) msize(*1.6) msymbol(Oh) legend(off)
 xlabel( 1 "-5" 2 "-4" 3 "-3" 4 "-2" 5 "-1" 6 "0"7"+1" 8"+2" 9"+3" 10 "+4")
 xtitle("t away from the treatment") ytitle("Treatement effect")
 yline(0, lcolor(red) lwidth(*1.1)) xline(5.5, lcolor(orange) lwidth(*1.1)) ;
