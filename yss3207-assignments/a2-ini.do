/******************/
// OLS
reg loggdp risk

// First Stage, no controls
reg risk logmort0

predict mort_iv_risk

// Reduced Form, no controls
reg loggdp logmort0

// IV, no controls
reg loggdp mort_iv_risk

/******************/
// First Stage, controlling for malaria
reg risk logmort malaria

predict mort_iv_risk_malaria

// IV, controlling for malaria
reg loggdp mort_iv_risk_malaria malaria

// OLS, controlling for malaria
reg loggdp risk malaria

/******************/
// First Stage, full controls
reg risk logmort0 malaria latitude rainmin meantemp

predict mort_iv_sachs

// IV, full controls
reg loggdp mort_iv_sachs malaria latitude rainmin meantemp
