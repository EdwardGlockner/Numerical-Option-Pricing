function [Value, Error] = mc_chooser_quasi(S0,K,r,sigma,T, t_c,N,M,gamma)
%EUROPEANCALL call option pricing.
%   Compute European call option prices using Euler's method and Monte Carlo 
%   Simulation.
% Inputs:
% S0          - Current price of the underlying asset.
% K           - Strike (i.e., exercise) price of the option.
% r           - Annualized continuously compounded risk-free rate of return
%               over the life of the option, expressed as a positive decimal
%               number.
% T           - Time to expiration of the option, expressed in years.
% t_c         - Time of choise
% sigma       - Annualized asset price volatility (i.e., annualized standard
%               deviation of the continuously compounded asset return),
%               expressed as a positive decimal number.
% N           - Number of timesteps
% M           - Number of simulations
% Gamma       - controls the relationship between volatility and price
%               [0,1]
% Z           - Brownian motion
% Output:
% Value       - Price (i.e., value) of a European call option.
% Error       - Absolute error between the Black-Scholes analytical price and
%               the simulated approximation

dt = T/N;  
S = S0*ones(M,1);
t = 0;

t_vals = 0:dt:T;

[mini, index] = min(abs(t_vals-t_c));
Q = qrandstream("Sobol", 1, "Skip", 2, "Leap", 6);
for k=1:N % Loop for number of simulations
    t = t+dt;
    if k == index
        S_t = S; % Price at chooser time
    end
    
    q = qrand(Q, M);
    Z = norminv(q, 0, 1);
    dW  = Z*sqrt(dt);
    S = S + r*S*dt + sigma*S.^gamma.*dW; % Euler-Maruyama
    reset(Q);
end

[Call,Put] = blsprice(S0, K, r, T, sigma);
% blsprice Black-Scholes put and call option pricing.
Exact = max(Call, Put);

disc = exp(-r*(T-t_c));
Value = disc*( mean(max(S_t - K,0)) + mean(max(K*disc - S_t, 0)) );

Error = abs(Exact - Value);
end