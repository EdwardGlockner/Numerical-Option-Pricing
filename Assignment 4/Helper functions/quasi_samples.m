clear; close all; clc;

K = 12;
r = 0.025;
sigma = 0.4;
T = 10;
t_c = 7;
N = 1000; % Time steps
M_vals = 20000:10000:50000; % Number of simulation
gamma = 1;
S0 = 14;

err_sobol = zeros(length(M_vals), 1);
err_halton = zeros(length(M_vals), 1);
err_pseudo = zeros(length(M_vals), 1);



for i = 1:length(M_vals)
    
    Z_pseudo = randn(M_vals(i), N);
    p_sobol = sobolset(N, 'Skip', 1e1, 'Leap', M_vals(i)/2);
    p_sobol = scramble(p_sobol, 'MatousekAffineOwen');

    p_halton = haltonset(N, 'Skip', 1e1, 'Leap', M_vals(i)/2);
    p_halton = scramble(p_halton, 'RR2');
    
    X0_sobol = net(p_sobol, M_vals(i));
    sobol_points = norminv(X0_sobol, 0, 1);

    
    X0_halton = net(p_halton, M_vals(i));
    halton_points = norminv(X0_halton, 0, 1);
    

    [V1, err1] = mc_chooser(S0, K, r, sigma, T, t_c, N, M_vals(i), gamma, sobol_points);
    [V2, err2] = mc_chooser(S0, K, r, sigma, T, t_c, N, M_vals(i), gamma, halton_points);
    [V3, err3] = mc_chooser(S0, K, r, sigma, T, t_c, N, M_vals(i), gamma, Z_pseudo);

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

p_pseudo = polyfit(log(M_vals), log(err_pseudo), 1);
p_sobol = polyfit(log(M_vals), log(err_sobol), 1);
p_halton = polyfit(log(M_vals), log(err_halton), 1);

disp("Estimated rate of convergence for pseudo: " + num2str(-p_pseudo(1)))
disp("Estimated rate of convergence for sobol: " + num2str(-p_sobol(1)))
disp("Estimated rate of convergence for halton: " + num2str(-p_halton(1)))


figure(1)

plot(M_vals, err_sobol);
hold on;

plot(M_vals, err_pseudo);
plot(M_vals, err_halton)
hold off

title("Error analysis of pseudo vs quasi Monte-Carlo method")
ylabel("Absolute Error")
xlabel("Number of simulations");
legend("Sobol points", "Pseudo", "Halton points");