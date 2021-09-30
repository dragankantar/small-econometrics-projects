//b)
gen over21=0
replace over21=1 if agecell>=21

//c)
scatter all agecell

//d)
reg all over21 agecell, robust

//e)
gen age = agecell-21

reg all over21 age, robust
predict linfit

//f)
preserve
collapse all, by(over21 agecell)
graph twoway (scatter all agecell) (line linfit agecell if over21==0) (line linfit agecell if over21==1), xline(21, lpattern(dash) lcolor(gs10)) legend(off)
restore

//g)
gen age_over21 = age*over21
gen age_sq = age*age
gen age_sq_over21 = age_sq*over21

reg all over21 age age_sq age_over21 age_sq_over21, robust
predict quadfit

//h)
preserve
collapse all, by(over21 agecell)
twoway (scatter all agecell) (line linfit quadfit agecell if age < 0,  lcolor(red black) lwidth(medthick medthick) lpattern(dash)) (line linfit quadfit agecell if age >= 0, lcolor(red black) lwidth(medthick medthick) lpattern(dash)), xline(21, lpattern(dash) lwidth(medthin) lcolor(gs10)) legend(off)
restore

//i)
reg all over21 age if agecell>=20 & agecell<=22, robust
reg all over21 age age_sq age_over21 age_sq_over21 if agecell>=20 & agecell<=22, robust
