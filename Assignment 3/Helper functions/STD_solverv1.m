function V_vec = STD_solverv1(N_samples, n_timepoints, T, S0, sigma, gamma, K, r)
V_vec = zeros(1,N_samples);
dt = T / n_timepoints;

for i = 1:N_samples
    S_prev = S0; 
    for j = 1:n_timepoints
        Z = randn;
        S = S_prev + r * S_prev * dt + sigma * S_prev ^ gamma * Z * sqrt(dt); % Euler forward scheme 
        S_prev = S;
    end
    V_vec(i) = max([S - K, 0]); 
   
end
end