clear; close all; clc;

%%%%%%%%%%%%%%% GLOBAL PARAMETERS %%%%%%%%%%%%%%%

global r;
global sigma;
global delta;

r = 0.3;        % Risk free interest rate
sigma = 0.2;    % Volatility
delta = 0.2;    % Dividend rate

% Constants
q = 2*r/sigma^2;
qs = 2*(r-delta)/sigma^2;

%%%%%%%%%%%%%%% OPTION PARAMETERS %%%%%%%%%%%%%%%

T = 5;          % Time to maturity
K = 10;         % Strike price
S0 = 15;        % Start price

%%%%%%%%%% FINITE DIFFERENCE PARAMTERS %%%%%%%%%%

theta = 0.5;                     % Cranc-Nicholson
omega_r = 1;                     % For PSOR

x_Min = -3;                      % Transformed min spot price
x_Max = 3;                       % Transformed max spot price
v_Max = 30;                      % Transformed max time value
m = 100;                         % Number of spot price points

delta_x = (x_Max-x_Min)/m;       % Spot price discretization step
delta_tau = 0.5*sigma^2*T/v_Max; % Time discretization step

x_Vals = x_Min : delta_x : x_Max;
tau_Vals = 0 : delta_tau : v_Max;

type = "call";                   % for our function g

w = zeros(length(tau_Vals), length(x_Vals)); % Solution matrix (Time x Space)


%%%%%%%%%%% FINITE DIFFERENCE METHOD %%%%%%%%%%%%

% Start by setting initial condition
for i = 1:length(x_Vals)
    w(1, i) = g(x_Vals(i), 0, type, q, qs);
end

% Finite difference need the last two time steps to compute the 
% next one, so we copy our first initial condition. One can also use
% euler forward. This will lower the overall accuracy of the method

for i = 1:length(x_Vals)
    w(2, i) = g(x_Vals(i), 0, type, q, qs);
end

lambda = delta_tau/delta_x^2;
alfa = lambda*theta;

% Now we create our matrix A
A = diag(ones(m, 1)*(1 + 2*lambda*theta), 0) + ...
    diag(ones(m-1, 1)*-lambda*theta,1) + ...
    diag(ones(m-1, 1)*-lambda*theta,-1);

% Now we are ready to calculate the numerical approximation

for v = 2:length(tau_Vals)-1 % Iterate over all time values

    % Calculate the matrix b
    b = zeros(1, length(x_Vals)-1);
    for i = 2:length(x_Vals)-2
        b(i) = w(v, i) + lambda * (1 - theta) * ...
            (w(v, i+1) - w(v, i) + w(v, i-1));
    end
    % Set boundary conditions
    b(1) = w(v, 1) + lambda*(1-theta) * ...
        (w(v, 2) - 2*w(v,1) + g(0, tau_Vals(v), type, q, qs)) + ...
        alfa * g(0, tau_Vals(v+1), type, q, qs);
    
    b(length(x_Vals)-1) = w(v, length(x_Vals)-1) + lambda*(1-theta)* ...
        (g(x_Vals(length(x_Vals)), tau_Vals(v), type, q, qs) - 2*w(v, m-1) + w(v, m-2)) + ...
        alfa * g(x_Vals(length(x_Vals)), tau_Vals(v+1), type, q, qs);
    
    %w(v+1,:) = PSORV2(length(x_Vals), w(v, :), w(v-1,:), omega_r, A, b);
    
    g_val = g(x_Vals(1:end-1), tau_Vals(v), type, q, qs);
    w(v+1,:) = PSORV3(length(x_Vals), w(v, :), w(v-1,:), omega_r, A, b, g_val);
    
end

% END OF CORE ALGORITHM

S_Vals = K*exp(x_Vals(1 : floor(2*length(x_Vals)/3)));

t_Vals = T-tau_Vals(:);

V = zeros(length(tau_Vals), length(S_Vals));

error = 10^(-5); % For testing early exercise
curve = zeros(length(tau_Vals), length(x_Vals));

for j = 1:length(tau_Vals)
    for i = 1:length(S_Vals)
        V(j,i) = K*w(1,i)*exp(-x_Vals(i) * 0.5 * ...
            (qs-1)) * exp(-0.5*T*sigma^2*(0.25*(qs-1)^2 + q));
        
        % Now we test for early exercise
        if lower(type) == "call"
            if K - S_Vals(i) + V(j, i) < error
                curve(j, i) = K + V(j,i);
            else
                curve(j, i) = 0;
            end
        elseif lower(type) == "put"
            if V(j, i) + S_Vals(i) - K < error
                curve(j, i) = K + V(j,i);
            else
                curve(j,i) = 0;
            end
        end
    end
end


figure(1)  
mesh(S_Vals, tau_Vals, V);
%mesh(S_Vals(1:floor(end/2)), tau_Vals, V(:, 1:floor(end/2)));
xlabel("Stock price (S)");
ylabel("Time to maturity (T-t)");
zlabel("Option price (V)");
titletext = "Finite difference solver for American " + type + " option" + newline + ...
    '\color{blue} K = ' + K + ", r = " + r + ", sigma = " + sigma + ", delta = " + delta;
title(titletext)


t_Vals2 = 0.5:0.001:1;
S_f_vals = 10.*(1 - sigma*sqrt((t_Vals2 - 1) .* log(1-t_Vals2)));

figure(2)

plot(S_f_vals, t_Vals2)
title("Asymptotic behaviour of early exercise curve for American put option")
xlabel("S_f")
ylabel("Time")


