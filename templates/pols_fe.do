use  data.dta

*****variables********
*district_id - district specfic id
*year - time variable from year 2005 to year 2012
*x  - x (Secondary)
*ln_y - log of y
**********************

*Pool OLS
reg ln_y x

*Pool OLS with cluster
reg ln_y x, cl(district_id)

* District Fixed effects (with cluster)
reg ln_y x i.district_id, cl(district_id)

* Within District Estimator (with cluster)
areg ln_y x , a(district_id) cl(district_id)

* Time FE + Within District Estimator (with cluster)
areg ln_y x i.year, a(district_id) cl(district_id)

* HDFE
reghdfe  ln_y x , a(district_id) cl(district_id)
reghdfe  ln_y x , a(district_id year) cl(district_id)

