use card.dta, clear

// OLS
reg lwage educ exper expersq black south smsa reg661 reg662 reg663 reg664 reg665 reg666 reg667 reg668 smsa66, r

///// IV using ivreghdfe /////
// IV with nearc4 as instrument for educ variable
ivreghdfe lwage (educ=nearc4) exper expersq black south smsa reg661 reg662 reg663 reg664 reg665 reg666 reg667 reg668 smsa66, r

// IV with motheduc and fatheduc variables as instruments for educ variable
ivreghdfe lwage (educ=motheduc fatheduc) exper expersq black south smsa reg661 reg662 reg663 reg664 reg665 reg666 reg667 reg668 smsa66, r


///// IV without ivreghdfe /////
// First Stage, controlling for malaria
reg x z control

predict fs

// IV, controlling for malaria
reg y fs control
