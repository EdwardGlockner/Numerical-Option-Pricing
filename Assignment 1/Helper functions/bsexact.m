function sol = bsexact(sigma, r, E, T, s)
    % sigma: volatilitet
    % r:     riskfri ränta
    % E:     Strike price
    % T:     Maturity
    % s:     Priset på den underliggande tillgången
    
    d1 = ( log(s/E) + (r + 0.5*sigma^2)*T )/(sigma*sqrt(T));
    d2 = d1 - sigma*sqrt(T);
    F = 0.5*s*(1+erf(d1/sqrt(2))) - exp(-r*T)*E*0.5*(1+erf(d2/sqrt(2)))';
    sol = F;
end