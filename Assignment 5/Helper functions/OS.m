clear; close all; clc;

%%%%%%%%%%%%%%% GLOBAL PARAMETERS %%%%%%%%%%%%%%%

global r;
global sigma;
global delta;

r = 0.3;        % Risk free interest rate
sigma = 0.2;    % Volatility
delta = 0.2;    % Dividend rate


%%%%%%%%%%%%%%% OPTION PARAMETERS %%%%%%%%%%%%%%%

T = 5;          % Time to maturity
K = 20;         % Strike price
S0 = 15;        % Start price

%%%%%%%%%% FINITE DIFFERENCE PARAMTERS %%%%%%%%%%
type = "call";

M = 1000;       % Number of time points
N = 1000;       % Number of spatial points

delta_t = T/M;  % Time step
delta_s = (4*K - S0)/N;

t_vals = 0:delta_t:T;
s_vals = S0:delta_s:4*K;

V = zeros(length(t_vals), length(s_vals)); % Solution matrix (Time x Space)

% Set initial condition
for i = 1:length(s_vals)
        V(1, i) = g_OS(s_vals(i), K, type);
end
V(2,:) = V(1,:);


% Constants for finite difference
c1 = (1/delta_t) + r;
c2 = -sigma^2/2;
c3 = -r;

u = zeros(1, length(s_vals));

u(1) = 0;
u(2) = 0;

tic
for t = 1:length(t_vals)
    phi = zeros(1, length(s_vals)); % Auxiliary variable
    for i = 2:length(s_vals)-1
        f = phi(i) + V(t, i);

        u(i+1) = (f - c1*u(i) + c3*s_vals(i)*u(i-1)/2*delta_s - c3*s_vals(i)/2*delta_s)/...
            (c2*s_vals(i)^2/delta_s^2 + c3*s_vals(i)/2*delta_s);


        if -delta_t*phi(i) + u(i+1) >= g_OS(s_vals(i), K, type)
            phi(i+1) = 0;
            V(t, i+1) = u(i+1) - delta_t*phi(i);
        else
            phi(i+1) = (g_OS(s_vals(i), K, type)-u(i+1))/delta_t + phi(i);
            V(t, i+1) = g_OS(s_vals(i), K, type);
        end
    end
end
toc
figure(1)  
mesh(s_vals, t_vals, V);
colorbar;
xlabel("Stock price (S)");
ylabel("Time (t)");
zlabel("Option price (V)");
titletext = "Finite difference solver for American " + type + " option" + newline + ...
    '\color{blue} K = ' + K + ", r = " + r + ", sigma = " + sigma + ", delta = " + delta;
title(titletext)
