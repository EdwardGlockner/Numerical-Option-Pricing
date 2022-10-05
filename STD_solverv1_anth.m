function V_vec = STD_solverv1_anth(N_samples, n_timepoints, T, S0, sigma, gamma, K, r)
V_vec = zeros(1,N_samples);
dt = T / n_timepoints;
for i = 1:N_samples
    S_prev1 = S0;
    S_prev2 = S0;
    for j = 1:n_timepoints
        Z1 = randn;
        Z2 = -Z1; % Here the anthetic variate is applied. 
        S1 = S_prev1 + r * S_prev1 * dt + sigma * S_prev1 ^ gamma * Z1 * sqrt(dt); % Euler forward scheme 
        S2 = S_prev2 + r * S_prev2 * dt + sigma * S_prev2 ^ gamma * Z2 * sqrt(dt); 
        S_prev1 = S1;
        S_prev2 = S2;
    end
    V_vec(i) = (max([S1 - K, 0]) + max([S2 - K, 0])) / 2; 
   
end
end