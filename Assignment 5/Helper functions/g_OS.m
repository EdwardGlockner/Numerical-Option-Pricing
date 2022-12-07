function g = g_OS(S, K, type)
    % K   : 
    % S   :
    % type: type of option (call/put)
        
    if lower(type) == "put"
        g = max(K-S, 0);
    
    elseif lower(type) == "call"
        g = max(S-K, 0);
    
    else
        disp("Not a valid option type (call/put)");
        g = NaN;
    end
end