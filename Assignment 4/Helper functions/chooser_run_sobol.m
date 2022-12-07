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

%[d1, d1_star] = d(S0, K, r, sigma, T, t_c);

%delta_an = normcdf(d1) + normcdf(d1_star) - 1;

S0 = linspace(3, 24, 40);
dS0 = 1e-6;
delta_num = zeros(1,length(S0));

for i = 1:length(S0)
    [V2, err1] = mc_chooser(S0(i) + dS0,K,r,sigma,T, t_c,N,M,gamma,Z);
    [V1, err2] = mc_chooser(S0(i) - dS0,K,r,sigma,T, t_c,N,M,gamma,Z);
    
    delta_num(i) = (V2 - V1)/(2*dS0);
end

figure(1)
hold on
grid on
plot(S0, delta_num, 'r*')