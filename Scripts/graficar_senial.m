function graficar_senial(numal)
    % GRAFICAR_SENIAL  Ejer 1.1: senal en el tiempo y TFTD aproximada

    % Obtengo la senal y los instantes a partir de la funcion provista
    [n, x] = senial(numal);

    ruta_senial = 'C:\Users\santi\Laboratorio-IPS\Figuras\Senial\';

    % --- Grafico de x[n] ---
    figure;
    stem(n, x, 'filled'); grid on;
    title('Senal del Ejercicio 1');
    xlabel('n'); ylabel('x[n]');
    print ([ruta_senial 'ej1_senal_xn.png'], '-dpng');

    % --- TFTD aproximada de x[n] ---
    [s, X] = tftd_aprox(x, n);   % usa defaults: s de -0.5 a 0.5, ds=0.001

    % Modulo
    figure;
    plot(s, abs(X)); grid on;
    title('Modulo de la TFTD aproximada de x[n]');
    xlabel('s'); ylabel('|X(e^{j2\pi s})|');
    print ([ruta_senial 'ej1_tftd_mod_xn.png'], '-dpng');

    % Fase (opcional pero util para el informe)
    figure;
    plot(s, angle(X)); grid on;
    title('Fase de la TFTD aproximada de x[n]');
    xlabel('s'); ylabel('arg X(e^{j2\pi s})');
    print ([ruta_senial 'ej1_tftd_fase_xn.png'], '-dpng');

end

