function [exact, spatial_points, time_points] = black_scholes(S0, K, r, sigma, dt, dx, T)

    SMAX=4*K;
    time_points = 0:dt:T; %time 
    spatial_points = 0:dx:SMAX; %price of the underlying
    
    exact = zeros(length(spatial_points), length(time_points));
    
    % Calculate the black scholes value on the entire grid
    for n = 1:length(time_points) % All the time points
        for i = 1:length(spatial_points) % All the spot prices
            exact(i, n) = bsexact(sigma, r, K, T-time_points(n), spatial_points(i));
        end
    end
end
