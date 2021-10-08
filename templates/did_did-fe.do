use did_data_1.dta,clear
set more off

// Difference-in-difference variable
gen did = treated_id*post_treatment

// Simple DID Regression
reg y treated_id post_treatment did, cl(id)

// DID with Individual and Time Fixed Effects (with cluster on individual)
reghdfe y treated_id post_treatment did, a(id time) cl(id)

// Trend variables
// Used for detrending when we have an issue with parallel trends assumption
gen treated_id_trend_1 = treated_id* time
gen treated_id_trend_2 = (1-treated_id)* time

// Detrended Simple DID (with cluster on individual)
reg y treated_id post_treatment did treated_id_trend_1 treated_id_trend_2, cl(id)

// Detrended DID Individual and Time Fixed Effects (with cluster on individual)
reghdfe y did, a(id time treated_id#c.time) cl(id)
