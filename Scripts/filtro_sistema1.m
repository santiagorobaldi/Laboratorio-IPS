function y = filtro_sistema1(x)
    N = length(x);
    y = zeros(size(x));     % prealoco salida

    for n = 1:N
        x_n   = x(n);       % x[n]
        if n == 1
            % Para n = 1 (que representa n=0 si arrancamos en 0),
            % asumimos x[n-1] = x[-1] = 0 (sistema causal).
            x_n_1 = 0;
        else
            x_n_1 = x(n-1); % x[n-1]
        end

        y(n) = 0.5 * x_n + 0.5 * x_n_1;
    end
end

