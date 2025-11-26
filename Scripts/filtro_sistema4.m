function y = filtro_sistema4(x)
    N = length(x);
    y = zeros(size(x));

    for n = 1:N
        x_n   = x(n);
        if n == 1
            x_n_1 = 0;      % x[-1]
            y_n_1 = 0;      % y[-1]
        else
            x_n_1 = x(n-1);
            y_n_1 = y(n-1);
        end

        y(n) = 0.25*x_n - 0.25*x_n_1 - 0.5*y_n_1;
    end
end

