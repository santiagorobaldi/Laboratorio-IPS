function sistema3(numal)
    % SISTEMA 3
    % y[n] = 0.25 x[n] + 0.25 x[n-1] + 0.5 y[n-1]

    ruta = 'C:\Users\santi\Laboratorio-IPS\Figuras\Sistema3\';

    % --- 1) Graficar h3[n] (teorica en un rango finito) ---
    n = 0:10;   % por ejemplo, primeros 11 valores

    h3 = zeros(size(n));
    for k = 1:length(n)
        if n(k) == 0
            h3(k) = 0.25;                 % h3[0]
        else
            if n(k) == 1
                h3(k) = 0.375;            % h3[1] = 0.25 + 0.5*0.25
            else
                h3(k) = 0.5 * h3(k-1);    % h3[n] = 0.5 h3[n-1] para n>=2
            end
        end
    end

    figure;
    stem(n, h3, 'filled'); grid on;
    title('Respuesta impulsional h_3[n]');
    xlabel('n'); ylabel('h_3[n]');

    print ([ruta 'h3_sistema3.png'], '-dpng');


    % --- 2) Graficar H3(e^{j2pis}) ---
    ds = 0.001;
    s = -0.5:ds:0.5;
    H3 = (0.25 + 0.25 * exp(-1i * 2*pi*s)) ./ (1 - 0.5 * exp(-1i * 2*pi*s));


    figure;
    plot(s, abs(H3)); grid on;
    title('Modulo |H_3(e^{j2\pi s})|');
    xlabel('s'); ylabel('|H_3|');
    print ([ruta 'H3_mod_sistema3.png'], '-dpng');

    figure;
    plot(s, angle(H3)); grid on;
    title('Fase arg H_3(e^{j2\pi s})');
    xlabel('s'); ylabel('fase');
    print ([ruta 'H3_fase_sistema3.png'], '-dpng');

    % ============================================================
    % Verificacion 1.3.a: respuesta impulsional numerica vs teorica
    % ============================================================

    n_imp = 0:10;
    x_imp = (n_imp == 0);
    y_imp = filtro_sistema3(x_imp);


    % Defino h3 teorica en el mismo eje n_imp
    h3_teo = zeros(size(n_imp));
    for k = 1:length(n_imp)
        if n_imp(k) == 0
            h3_teo(k) = 0.25;
        elseif n_imp(k) == 1
            h3_teo(k) = 0.375;
        else
            h3_teo(k) = 0.5 * h3_teo(k-1);
        end
    end


    % Grafico comparacion
    figure;
    stem(n_imp, h3_teo, 'filled'); hold on;
    stem(n_imp, y_imp, 'r'); grid on;
    legend('h_3[n] teórica', 'h_3[n] numérica');
    title('Comparacion de respuestas impulsionales del Sistema 3');
    xlabel('n'); ylabel('h_3[n]');
    print ([ruta 'h3_sistema3_comparacion.png'], '-dpng');

    % ============================================================
    % Verificacion 1.3.b: TFTD de h3[n] vs H3(e^{j2\pi s}) analitica
    % ============================================================

    % Calculo TFTD aproximada de la respuesta impulsional numerica
    [s_h, H_num] = tftd_aprox(y_imp, n_imp);

    % Calculo H3 analitica en las mismas frecuencias s_h
    H_teo = (0.25 + 0.25 * exp(-1i * 2*pi * s_h)) ./ (1 - 0.5 * exp(-1i * 2*pi * s_h));


    % Comparo modulo
    figure;
    plot(s_h, abs(H_teo), 'b', s_h, abs(H_num), 'r--');
    grid on;
    legend('|H_3| analitica', '|H_3| numerica');
    title('Modulo de H_3(e^{j2\pi s}) - Comparacion analitica vs numerica');
    xlabel('s'); ylabel('|H_3(e^{j2\pi s})|');
    print ([ruta 'H3_mod_analitica_vs_numerica.png'], '-dpng');

     % Señal de entrada del inciso 1
    [n_x, x] = senial(numal);     % x[n]: señal de entrada

    % Salida del sistema 3
    y3 = filtro_sistema3(x);

    % Gráfico solo de la salida
    figure;
    stem(n_x, y3, 'filled'); grid on;
    title('Salida y_3[n] del Sistema 3 para la senal del Ejercicio 1');
    xlabel('n'); ylabel('y_3[n]');
    print ([ruta 'ej1_sistema3_salida_y3.png'], '-dpng');

    % (opcional pero muy util para el informe):
    % comparar entrada y salida en el mismo grafico
    figure;
    stem(n_x, x, 'b', 'filled'); hold on;
    stem(n_x, y3, 'r'); grid on;
    legend('Entrada x[n]', 'Salida y_3[n]');
    title('Comparacion x[n] vs y_3[n] - Sistema 3');
    xlabel('n'); ylabel('amplitud');
    print ([ruta 'ej1_sistema3_x_vs_y3.png'], '-dpng');

    % ================================================
    % 1.5: TFTD de la salida y_3[n] y análisis
    % ================================================

    % TFTD aproximada de la salida
    [s_y3, Y3] = tftd_aprox(y3, n_x);

    % TFTD aproximada de la entrada (para comparar)
    [s_x, X] = tftd_aprox(x, n_x);

    % --- TFTD SOLO de la salida y3[n] ---
    figure;
    plot(s_y3, abs(Y3));
    grid on;
    title('Modulo de la TFTD de la salida y_3[n] - Sistema 3');
    xlabel('s'); ylabel('|Y_3(e^{j2\pi s})|');
    print ([ruta 'ej1_sistema3_mod_Y3_solo.png'], '-dpng');


    % Módulo de la entrada y salida en el mismo gráfico
    figure;
    plot(s_x, abs(X), 'b', s_y3, abs(Y3), 'r--');
    grid on;
    legend('|X(e^{j2\pi s})| entrada', '|Y_3(e^{j2\pi s})| salida');
    title('Modulo de la TFTD: entrada vs salida - Sistema 3');
    xlabel('s'); ylabel('Modulo');
    print ([ruta 'ej1_sistema3_mod_X_vs_Y3.png'], '-dpng');

end
