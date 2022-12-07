clear; close all; clc;

K = 12;
r = 0.025;
sigma = 0.4;
T = 10;
t_c = 5;
N_vals = 100:100:1000; % Time steps
M = 50000;
gamma = 1;
S0 = 14;

err_sobol = zeros(length(N_vals), 1);
err_halton = zeros(length(N_vals), 1);
err_pseudo = zeros(length(N_vals), 1);



for i = 1:length(N_vals)

    Z_pseudo = randn(M, N_vals(i));
    
    p_sobol = sobolset(N_vals(i), 'Skip', 1e1, 'Leap', M*2);
    p_sobol = scramble(p_sobol, 'MatousekAffineOwen');
    X0_sobol = net(p_sobol, M);
    sobol_points = norminv(X0_sobol, 0, 1);

    p_halton = haltonset(N_vals(i), 'Skip', 1e1, 'Leap', M*2);
    p_halton = scramble(p_halton, 'RR2');
    X0_halton = net(p_halton, M);
    halton_points = norminv(X0_halton, 0, 1);
    
    
    [V1, err1] = mc_chooser(S0, K, r, sigma, T, t_c, N_vals(i), M, gamma, sobol_points);
    [V2, err2] = mc_chooser(S0, K, r, sigma, T, t_c, N_vals(i), M, gamma, halton_points);
    [V3, err3] = mc_chooser(S0, K, r, sigma, T, t_c, N_vals(i), M, gamma, Z_pseudo);

    err_sobol(i) = err1;
    err_halton(i) = err2;
    err_pseudo(i) = err3;
    
end


mean_sobol = mean(err_sobol);
mean_halton = mean(err_halton);
mean_pseudo = mean(err_pseudo);

disp("Mean error pseudo: " + mean_pseudo);
disp("Mean error sobol: " + mean_sobol);
disp("Mean error halton: " + mean_halton);
disp(" ");

p_pseudo = polyfit(log(N_vals), log(err_pseudo), 1);
p_sobol = polyfit(log(N_vals), log(err_sobol), 1);
p_halton = polyfit(log(N_vals), log(err_halton), 1);

disp("Estimated rate of convergence for pseudo: " + num2str(-p_pseudo(1)))
disp("Estimated rate of convergence for sobol: " + num2str(-p_sobol(1)))
disp("Estimated rate of convergence for halton: " + num2str(-p_halton(1)))


figure(1)

plot(N_vals, err_sobol);
hold on;

plot(N_vals, err_pseudo);
plot(N_vals, err_halton)
hold off

title("Error analysis of pseudo vs quasi Monte-Carlo method")
ylabel("Absolute Error")
xlabel("Number of time points");
legend("Sobol points", "Pseudo", "Halton points");