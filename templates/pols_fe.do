use  data.dta

*******variables*******
// id - individual specfic id
// year - time variable from year 2005 to year 2012
// x  - x
// ln_y - log of y
***********************

// Pool OLS
reg ln_y x

// Pool OLS with cluster on individual
reg ln_y x, cl(id)

// Individual Fixed effects (with cluster on individual)
// i.var creates n-1 dummy variables based on variable var
reg ln_y x i.id, cl(id)

// Within Individual Estimator (with cluster on individual)
// Same as individual fixed effects
areg ln_y x, a(id) cl(id)

// Time FE + Within Individual Estimator (with cluster on individual)
areg ln_y x i.year, a(id) cl(id)

// Individual Fixed Effects (with cluster on individual)
reghdfe  ln_y x , a(id) cl(id)

// Individual and Time Fixed Effects (with cluster on individual)
reghdfe  ln_y x , a(id year) cl(id)
