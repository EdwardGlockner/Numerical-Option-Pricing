function [y,x] = PSOR(b, A, g, x, x_prev, omega_r, m)





    b_hat = b' - A.*g;
    r = zeros(1, m);
    x = zeros(1, m);
    y = zeros(1, m);
    
    for i = 1:m-1
        term1 = 0;
        for j = 1:i-1
            term1 = term1 + A(i,j) * x(i);
        end

        term2 = 0;
        for j = i+1:m-1
            term2 = term2 + A(i,j) * x_prev(i);
        end

        r = b_hat - term1 - A(i,i)*x_prev(i) - term2;
        x = max(0, x_prev + omega_r * (r/A(i,i)));
        y = -r + A(i, i)*(x - x_prev);
    end
end