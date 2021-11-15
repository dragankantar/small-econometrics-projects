use https://stats.idre.ucla.edu/stat/stata/dae/binary.dta, clear

///// Linear Probability Model /////
reg admit gre gpa i.rank, r


///// Probit /////
probit admit gre gpa i.rank, r

// Predicted probability of admission at GRE=200, 300, ..., 800
// for each case using that case's value of rank and GPA
margins, at(gre=(200(100)800)) vsquish

// Predicted probability of admission at each level of rank,
// holding all other variables at their means
margins rank, atmeans

// Predicted probability of admission at GRE=200, 300, ..., 800
// holding all other variables at their means
margins, at(gre=(200(100)800)) atmeans vsquish

// Marginal effect of X on predicted probability
margins, dydx(gre gre gpa i.rank)


///// Logit /////
logit admit gre gpa i.rank, r

// Predicted probability of admission at GRE=200, 300, ..., 800
margins, at(gre=(200(100)800)) vsquish

// Predicted probability of admission at each level of rank,
// holding all other variables at their means
margins rank, atmeans

// Predicted probability of admission at GRE=200, 300, ..., 800
// holding all other variables at their means
margins, at(gre=(200(100)800)) atmeans vsquish

// Marginal effect of X on predicted probability
margins, dydx(gre gre gpa i.rank)
