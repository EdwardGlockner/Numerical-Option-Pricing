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

compareWithExactChooser

function result = compareWithExactChooser
    nSamplesRange = 10:8:8000;
    
    randnErrors = ...
        arrayfun(@(x) totalErrorChooser(x, @randnNormSamples), nSamplesRange);
    
    sobolErrors = ...
        arrayfun(@(x) totalErrorChooser(x, @sobolNormSamples), nSamplesRange);

    haltonErrors = ...
        arrayfun(@(x) totalErrorChooser(x, @haltonNormSamples), nSamplesRange);
    
    figure(1);
    plot(nSamplesRange, randnErrors);
    title("Error analysis of Pseudo Monte-Carlo");
    xlabel("Number of simulations");
    ylabel("Absolute error");
    
    figure(2)
    plot(nSamplesRange, sobolErrors);
    title("Error analysis of Quasi Monte-Carlo using Sobol sequence")
    xlabel("Number of simulations")
    ylabel("Absolute error")
    
    figure(3)
    plot(nSamplesRange, haltonErrors);
    title("Error analysis of Quasi Monte-Carlo using Halton sequence")
    xlabel("Number of simulations")
    ylabel("Absolute error")
    
    figure(4)
    title("Error analysis of Quasi Monte-Carlo using Halton and Sobol sequence")
    xlabel("Number of simulations")
    ylabel("Absolute error")
    hold on 
    plot(nSamplesRange, haltonErrors);
    plot(nSamplesRange, sobolErrors);
    hold off
    legend("Halton", "Sobol")
    
    figure(5)
    title("Error analysis of Monte-Carlo methods")
    ylabel("Absolute error")
    xlabel("Number of simulations")
    hold on
    plot(nSamplesRange, haltonErrors);
    plot(nSamplesRange, sobolErrors);
    plot(nSamplesRange, randnErrors);
    hold off
    legend("Halton", "Sobol", "Pseudo");
    
    p_sobol = polyfit(log(nSamplesRange), log(sobolErrors), 1);
    p_pseudo = polyfit(log(nSamplesRange), log(randnErrors), 1);
    p_halton = polyfit(log(nSamplesRange), log(haltonErrors), 1);

    disp("Estimated rate of convergence for pseudo: " + num2str(-p_pseudo(1)))
    disp("Estimated rate of convergence for sobol: " + num2str(-p_sobol(1)))
    disp("Estimated rate of convergence for halton: " + num2str(-p_halton(1)));  
    
    disp("Mean error for pseudo: " + num2str(mean(randnErrors)));
    disp("Mean error for sobol: " + num2str(mean(sobolErrors)));
    disp("Mean error for halton: " + num2str(mean(haltonErrors)));

end

function result = plotDelta
    stockPrices= 1 : 40;
    [chooserPrices, callPrices, putPrices] = arrayfun(@combinedOptionPrices, stockPrices);

    hold on;
    plot(stockPrices(2:end), finDiff(chooserPrices))
    plot(stockPrices(2:end), finDiff(callPrices))
    plot(stockPrices(2:end), finDiff(putPrices))
    legend("chooser", "call", "put")
    hold off;
end

function result = finDiff(X)
   result = X(2:end) - X(1: end-1); 
end


% Difference between Monte-Carlo and exact solutions for Chooser options
function result = totalErrorChooser(nSamples, randGen)
    global initialPrice;

    optionPriceExact = exactChooser(initialPrice);
    optionPriceEst = mcChooser(initialPrice, randGen(nSamples));

    result = abs(optionPriceExact - optionPriceEst);
end



% Solve Chooser option with Monte-Carlo and 1400 Sobol samples.
% Solve call / put exactly
% Put everything in a single vector
function [chooser, call, put] = combinedOptionPrices(initialPrice)
    global K;
    global r;
    global T;
    global sigma;

    chooser = mcChooser(initialPrice, sobolNormSamples(1400));
    [call, put] = blsprice(initialPrice, K, r, T, sigma);
end

% Solve Chooser option using Monte-Carlo that uses the supplied
% normally-distributed vector
function result = mcChooser(initialPrice, normVector)
    global Tc;
    global r;

    % Sample prices at time Tc
    samplePrices = getExactSamples(initialPrice, Tc, normVector);

    % Sample option prices at time Tc
    samplePayoffs = chooserPayoff(samplePrices);

    % Take mean and apply discounting
    result = exp(-r * Tc) * mean(samplePayoffs);

end

function result = sobolNormSamples(nSamples)
    q = qrandstream('sobol', 1, 'Skip', 1e3, 'Leap', 1e2);
    result = norminv(qrand(q, nSamples));
end

function result = randnNormSamples(nSamples)
    result = randn(nSamples, 1);
end

function result = haltonNormSamples(nSamples)
    q = qrandstream("halton", 1, "Skip", 1e3, "Leap", 1e3);
    result = norminv(qrand(q, nSamples));
end



% Sample stock prices at time T (i.e. samples of GBM)
function result = getExactSamples(initialPrice, T, normVector)
    global sigma;
    global r;

    WT = sqrt(T) * normVector;

    % Geometric Brownian motion
    result = initialPrice * exp(sigma * WT + (r - 0.5 * sigma^2) * T);
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