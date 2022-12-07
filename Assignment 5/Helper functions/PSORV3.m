function x = PSORV3(m, x_current, x_prev, omega_r, A, b, g)

    r = zeros(1, m);
    x = zeros(1, m);
    b = b-A.*g';
    
    for i = 1:m-1
        term1 = 0;
        for j = 1:i-1
            term1 = term1 + A(i,j)*x_current(j);
        end
        
        term2 = 0;
        for j = i+1:m-1
            term2 = term2 + A(i,j) * x_prev(i);
        end
        
        r(i) = b(i)-term1-term2 - A(i,i)*x_prev(i);
        x(i) = max(0, x_prev(i) + omega_r * (r(i)/A(i,i)));
        
    end

end