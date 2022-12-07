clear; close all; clc;


S0 = 14;      % Start value
K = 15;       % Strike price
r = 0.1;      % Risk free interest rate
sigma = 0.25; % Volatility
T = 0.5;      % Maturity

dt = 0.005;
dx = 1;
gamma = 1;
[V_finite_ex, spatial_points_ex, time_points_ex] = CEV_Solver_Explicit(S0,...
    K, T, dt, dx, sigma, r, gamma);

time_to_expire_ex = T-time_points_ex;



figure(2)
surf(time_to_expire_ex, spatial_points_ex, V_finite_ex);
colorbar
xlabel('Time to expire (T-t)'), ylabel('Stock price (S)'), zlabel('Option Price (V)')
title("Finite Difference Explicit solver");



function [V, spatial_points, time_points] = CEV_Solver_Explicit(S0, K, T, dt, dx, sigma, r, gamma) 
% S0    - Start price
% K     - Strike price
% T     - Maturity
% SMAX  - Maximal S value
% dt    - Time step
% dx    - Spatial step
% sigma - Volatility
% r     - Risk free interest rate
% gamma - Controls the relationship between volatility and price
    SMIN = 0;
    SMAX = 4*K;
    
    % Discretisize the spot price, and the time
    time_points = 0:dt:T;
    spatial_points = SMIN:dx:SMAX;
    
    V = zeros(length(spatial_points), length(time_points)); % Solution matrix
    
    % We start by settings some boundary conditions
    
    % Final time point
    for i = 1:length(spatial_points)
        % Pay off function
        V(i, length(time_points)) = max(spatial_points(i)-K,0);
    end
    % Start time point
    for k = 1:length(spatial_points)
        V(i, 1) = 0;
    end
    
    for n = length(time_points):-1:2 % Time levels
        % Set boundary conditions
        V(1, n-1) = 0;
        V(length(spatial_points), n-1) = SMAX -K*exp(-r*(T-time_points(n-1)));
        for j = 2:length(spatial_points)-1 % Spatial
            % Finite difference scheme
            V(j, n-1) = V(j, n) + (sigma^(2) * 0.5 * dt * ...
                spatial_points(j)^(2*gamma))/(dx^(2)) * ...
                (V(j+1, n) - 2*V(j, n) + V(j-1, n)) + ...
                (dt * r * spatial_points(j) * (V(j+1, n) - V(j-1, n)) * 0.5)/(dx) - ...
                r * dt * V(j,n);
        end
    end
end