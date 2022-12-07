clear; close all; clc;
global K;
global T
global Tc;
global r;
global sigma;
global initialPrice;

K = 15; %Strike price
T = 1; %Time to maturity
Tc = 0.5; %Time of choice
r = 0.1; %Interest rate
sigma = 0.25; %Volatility
initialPrice = 14;

compareWithExactChooser;



% function result = plotPayoff
%     X = 1:100;
%     plot(X, chooserPayoff(X));
% end
% 
% function result  = plotExactSamples
%     nSamples = 200;
%     samples = getExactSamples(nSamples , 14, 2.5);
%     plot(1:nSamples, samples);
% end


function result = compareWithExactChooser
    nSamplesRange = 1000:1000:200000;
    nIntervals = 100;
    
    simpleSampling = arrayfun(@(x) totalErrorChooser(x, nIntervals), nSamplesRange);
    plot(nSamplesRange,  simpleSampling)
end


% Difference between Monte-Carlo and exact solutions for Chooser options
function result = totalErrorChooser(nSamples, nIntervals)
    global initialPrice;

    optionPriceExact = exactChooser(initialPrice);
    optionPriceEst = mcChooser(nSamples, nIntervals);
    result = abs(optionPriceExact - optionPriceEst);
end


function result = mcChooser(nSamples, nIntervals)
    global initialPrice;
    global Tc;
    global r;

    % Sample prices at time Tc
    samplePrices = getExactSamples(nSamples, initialPrice, Tc);

    % Sample option prices at time Tc
    samplePayoffs = chooserPayoff(samplePrices);

    % Take mean and apply discounting
    result = exp(-r * Tc) * mean(samplePayoffs);

end


% Sample stock prices at time T (i.e. samples of GBM)
function result = getExactSamples(nSamples, initialPrice, T)
    global sigma;
    global r;
    % HALTON
    %Q = qrandstream("halton", 1, "Skip", 2, "Leap", 1e2);
    %q = qrand(Q, nSamples);
    %Z = norminv(q, 0, 1);
    %result = initialPrice * exp(sigma * Z + (r - 0.5 * sigma^2) * T);
    %reset(Q);
    
    % SOBOL
    Q = qrandstream("sobol", 1, "Skip", 1e3, "Leap", 1e2);
    q = qrand(Q, nSamples);
    Z = norminv(q, 0, 1);
    result = initialPrice * exp(sigma * Z + (r - 0.5 * sigma^2) * T);
    
    % PSEUDO
    %WT = sqrt(T) * randn(nSamples, 1);
    %Geometric Brownian motion
    %result = initialPrice * exp(sigma * WT + (r - 0.5 * sigma^2) * T);
end


% Espen Haug p.128, payoff  at time Tc
function result = chooserPayoff(InitialPrice)
    global K;
    global r;
    global T;
    global Tc;
    global sigma;

    [call, put] = blsprice(InitialPrice, K, r, T - Tc, sigma);
    result = max(call, put);
end

% Espen Haug, p.128
function result = exactChooser(InitialPrice)
    global sigma;
    global r;
    global K;
    global T
    global Tc;

    d = (log(InitialPrice/K) + (r + 0.5 * sigma^2) * T) / (sigma * sqrt(T));
    y = (log(InitialPrice/K) + r * T + 0.5 * sigma^2 * Tc) / (sigma*sqrt(Tc));

    result = InitialPrice * normcdf(d) ...
        - K * exp(- r * T) * normcdf(d - sigma * sqrt(T)) ...
        - InitialPrice * normcdf(-y) ...
        + K * exp(- r * T) * normcdf(-y + sigma * sqrt(Tc));
end