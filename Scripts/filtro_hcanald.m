function y = filtro_hcanald(x)
    N = length(x);
    y = zeros(size(x));

    d1 = 8820;    % primer retardo
    d2 = 17640;   % segundo retardo

    for n = 1:N
        x_n = x(n);    % x[n]

        % x[n-8820]
        if n > d1
            x_n_d1 = x(n - d1);
        else
            x_n_d1 = 0;   % para n <= 8820, x[n-8820] = 0
        end

        % x[n-17640]
        if n > d2
            x_n_d2 = x(n - d2);
        else
            x_n_d2 = 0;   % para n <= 17640, x[n-17640] = 0
        end

        y(n) = x_n + 0.4 * x_n_d1 + 0.16 * x_n_d2;
    end
end

