function [V, spatial_points, time_points] = CEV_Solver_Implicit(S0, K, T, dt, dx, sigma, r, gamma) 
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
    
    V(length(spatial_points), length(time_points)) = nan; % Solution matrix
    
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
    
    % Final and start spot price
    for n = 1:length(time_points)
        V(1, n) = 0;
        V(length(spatial_points), n) = SMAX - K*exp(-r*(T-time_points(n)));
    end

    % Create matrices
    ax = 0.5 * (r * dt * spatial_points - sigma^(2) * dt * (spatial_points.^(2*gamma)));
    bx = 1 + sigma^(2) * dt * spatial_points.^(2*gamma) + r * dt;
    cx = -0.5 * (r * dt * spatial_points + sigma^(2) * dt * (spatial_points.^(2*gamma)));
    
    B = diag(ax(3:length(spatial_points)), -1) + diag(bx(2:length(spatial_points))) + ... 
    diag(cx(2:length(spatial_points)-1),1);
    
    [L, U] = lu(B); % lu factorization
    
    lost = zeros(size(B,2) ,1);
    
    for i = length(time_points)-1:-1:1 % Propagate backwards in time
        lost(1) = -ax(2) * V(1, i); 
        lost(end) = -cx(end) * V(end, i); 
        if length(lost) == 1
            lost = -ax(2) * V(1 , i) - cx(end) * V(end , i);
        end
        V(2:length(spatial_points),i) = U \ (L \ (V(2:length(spatial_points),i+1) + lost)); 
    end
end