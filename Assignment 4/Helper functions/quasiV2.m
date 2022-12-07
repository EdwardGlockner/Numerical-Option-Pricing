clear; close all; clc;

K = 12;
r = 0.025;
sigma = 0.4;
T = 0.5;
t_c = 0.3;
N = 700; % Time steps
M_vals = 20000:10000:100000; % Number of simulation
gamma = 1;
S0 = 14;

err_sobol = zeros(length(M_vals), 1);
err_halton = zeros(length(M_vals), 1);
err_pseudo = zeros(length(M_vals), 1);



for i = 1:length(M_vals)
    %Q_halton = qrandstream("Halton", N, 'Skip',1e2, 'Leap', 1e3);
    Q_sobol = qrandstream("Sobol", N, 'Skip', 1e2, 'Leap', 1e3);
    
    Z_pseudo = randn(M_vals(i), N);
    %Z_halton = norminv(qrand(Q_halton, M_vals(i)), 0, 1);
    Z_sobol = norminv(qrand(Q_sobol, M_vals(i)), 0, 1);
    
    X_sobol = randperm(numel(Z_sobol));
    ShuffledData_sobol = reshape(Z_sobol(X_sobol),size(Z_sobol));
    
    %X_halton = randperm(numel(Z_halton));
    %ShuffledData_halton = reshape(Z_halton(X_halton), size(Z_halton));
    p = haltonset(N,'Skip', 1e3, 'Leap', 1e2);
    p = scramble(p, 'RR2');
    X0 = net(p, M_vals(i));
    ShuffledData_halton = norminv(X0, 0, 1);
    

    [V1, err1] = mc_chooser(S0, K, r, sigma, T, t_c, N, M_vals(i), gamma, ShuffledData_sobol);
    [V2, err2] = mc_chooser(S0, K, r, sigma, T, t_c, N, M_vals(i), gamma, ShuffledData_halton);
    [V3, err3] = mc_chooser(S0, K, r, sigma, T, t_c, N, M_vals(i), gamma, Z_pseudo);

    err_sobol(i) = err1;
    err_halton(i) = err2;
    err_pseudo(i) = err3;
    
    %reset(Q_halton);
    reset(Q_sobol);
    
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