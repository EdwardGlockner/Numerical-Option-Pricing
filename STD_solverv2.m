function V_vec = STD_solverv2(N_samples, n_timepoints, T, S0, sigma, gamma, K, r)
V_vec = zeros(1,N_samples);
dt = T / n_timepoints;
for i = 1:N_samples
    S_prev1 = S0;
    S_prev2 = S0;
    for j = 1:n_timepoints
        Z1 = randn;
        Z2 = -Z1; % Here the anthetic variate method is applied. This makes that Z2 is negatively correlated to Z1 (Z2 = 2 *  mu - Z1 = Z1)
           % See section 4.3 in "Extra_reference_for_Anthethic. 
        S1_h = S_prev1 + r * S_prev1 * dt + sigma * S_prev1 ^ gamma * sqrt(dt);
        S1 = S_prev1 + r * S_prev1 * dt + sigma * S_prev1 ^ gamma * Z1 * sqrt(dt) + ...
            (1 /(2 * sqrt(dt))) * (sigma * S1_h ^ gamma - ...
            sigma * S_prev1 ^ gamma) * ((sqrt(dt) * Z1)^ 2 - dt); % Runge kutta scheme (Implmented according to equation )
        S2_h = S_prev2 + r * S_prev2 * dt + sigma * S_prev2 ^ gamma * sqrt(dt);
        S2 = S_prev2 + r * S_prev2 * dt + sigma * S_prev2 ^ gamma * Z2 * sqrt(dt) + ...
            (1 / (2 * sqrt(dt))) * (sigma * S2_h ^ gamma  - ...
            sigma * S_prev2 ^ gamma) * ((sqrt(dt) * Z2)^ 2 - dt); 
        S_prev1 = S1;
        S_prev2 = S2;
    end
    V_vec(i) = (max([S1 - K, 0]) + max([S2 - K, 0])) / 2; % The result is the mean of the two trajectories. 
   
end
end
