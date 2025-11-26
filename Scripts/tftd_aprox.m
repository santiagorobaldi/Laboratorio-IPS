function [s, X] = tftd_aprox(x, n)

    ds = 0.001;                    % resolución frecuencial
    s  = -0.5 : ds : 0.5;          % eje frecuencias en un periodo

    X = zeros(size(s));            % vector complejo

    for k = 1:length(s)
        X(k) = sum( x .* exp(-1i * 2*pi * s(k) .* n) );
    end
end

