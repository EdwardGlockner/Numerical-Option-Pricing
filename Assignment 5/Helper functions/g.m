function g = g(x, tau, type, q, qs)
    % x   : transformed spot price
    % tau : transformed time value
    % type: type of option (call/put)
    
    %if lower(type) == "put"
    %    g = exp((tau/4) * (q+1)^2) * max(exp(x*0.5*(q-1)) - exp(x*0.5*(q+1)), 0);
        
    %elseif lower(type) == "call"
    %    g = exp((tau/4) * (q+1)^2) * max(exp(x*0.5*(q+1)) - exp(x*0.5*(q-1)), 0);
        
    %else
    %    disp("Not a valid option type (call/put)");
    %    g = NaN;
    %end
    
    if lower(type) == "put"
        g = exp((tau/4) * ((qs-1)^2 + 4*q))*max(exp(x*0.5*(qs-1)) - exp(x*0.5*(qs+1)), 0);
    
    elseif lower(type) == "call"
        g = exp((tau/4) * ((qs-1)^2 + 4*q))*max(exp(x*0.5*(qs+1)) - exp(x*0.5*(qs-1)), 0);
    
    else
        disp("Not a valid option type (call/put)");
        g = NaN;
    end
end
