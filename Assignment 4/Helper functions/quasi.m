clear; close all; clc;

K = 12;
r = 0.025;
sigma = 0.4;
T = 0.5;
t_c = 0.3;
N = 1000; % time-steps
M = 10000; % runs
gamma = 1;


Z = randn(M,N);
Q_halton = qrandstream("Halton", N, 'Skip',1e3,'Leap',1e2);
Q_sobol = qrandstream("Sobol", N);

Z_halton = qrand(Q_halton, M);
Z_sobol = qrand(Q_sobol, M);

Z_halton = norminv(Z_halton, 0 ,1);
Z_sobol = norminv(Z_sobol, 0 ,1);

%[d1, d1_star] = d(S0, K, r, sigma, T, t_c);

%delta_an = normcdf(d1) + normcdf(d1_star) - 1;

S0 = linspace(3, 24, 40);
dS0 = 1e-6;
delta_num = zeros(1,length(S0));

err_sobol = zeros(length(linspace(3, 24, 40)), 1);
err_pseudo = zeros(length(linspace(3, 24, 40)), 1);
err_halton = zeros(length(linspace(3, 24, 40)), 1);

for i = 1:length(S0)
    [V1, err1] = mc_chooser(S0(i) + dS0, K, r, sigma, T, t_c, N, M, gamma, Z_sobol);
    [V2, err2] = mc_chooser(S0(i) + dS0, K, r, sigma, T, t_c, N, M, gamma, Z_halton);
    [V3, err3] = mc_chooser(S0(i) + dS0, K, r, sigma, T, t_c, N, M, gamma, Z);
    
    err_sobol(i) = err1;
    err_halton(i) = err2;
    err_pseudo(i) = err3;
end

figure(1)
title("Error")
ylabel("Error")
xlabel("S-Domain");
plot(S0, err_sobol);
hold on;
plot(S0, err_pseudo);
plot(S0, err_halton)
hold off
legend("Sobol points", "Pseudo", "Halton points");


mean_sobol = mean(err_sobol);
mean_halton = mean(err_halton);
mean_pseudo = mean(err_pseudo);

disp("Mean error sobol: " + mean_sobol);
disp("Mean error halton: " + mean_halton);
disp("Mean error pseudo: " + mean_pseudo);