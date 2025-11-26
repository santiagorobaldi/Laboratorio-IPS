function sistema4(numal)
    % SISTEMA 4
    % y[n] = 0.25 x[n] + 0.25 x[n-1] + 0.5 y[n-1]

    ruta = 'C:\Users\santi\Laboratorio-IPS\Figuras\Sistema4\';

    % --- 1) Graficar h4[n] (teorica en un rango finito) ---
    n = 0:10;   % por ejemplo, primeros 11 valores

    h4 = zeros(size(n));
    for k = 1:length(n)
        if n(k) == 0
            h4(k) = 0.25;                 % h4[0]
        elseif n(k) == 1
            h4(k) = -0.375;               % h4[1] = -0.25 - 0.5*0.25
        else
            h4(k) = -0.5 * h4(k-1);       % h4[n] = -0.5 h4[n-1] para n>=2
        end
    end


    figure;
    stem(n, h4, 'filled'); grid on;
    title('Respuesta impulsional h_4[n]');
    xlabel('n'); ylabel('h_4[n]');

    print ([ruta 'h4_sistema4.png'], '-dpng');


    % --- 2) Graficar H4(e^{j2pis}) ---
    ds = 0.001;
    s = -0.5:ds:0.5;
    H4 = (0.25 - 0.25 * exp(-1i * 2*pi*s)) ./ (1 + 0.5 * exp(-1i * 2*pi*s));



    figure;
    plot(s, abs(H4)); grid on;
    title('Modulo |H_4(e^{j2\pi s})|');
    xlabel('s'); ylabel('|H_4|');
    print ([ruta 'H4_mod_sistema4.png'], '-dpng');

    figure;
    plot(s, angle(H4)); grid on;
    title('Fase arg H_4(e^{j2\pi s})');
    xlabel('s'); ylabel('fase');
    print ([ruta 'H4_fase_sistema4.png'], '-dpng');

    % ============================================================
    % Verificacion 1.3.a: respuesta impulsional numerica vs teorica
    % ============================================================

    n_imp = 0:10;
    x_imp = (n_imp == 0);
    y_imp = filtro_sistema4(x_imp);   % esta es h4[n] numerica

    % Defino h4 teorica en el mismo eje n_imp
    h4_teo = zeros(size(n_imp));
    for k = 1:length(n_imp)
        if n_imp(k) == 0
            h4_teo(k) = 0.25;
        elseif n_imp(k) == 1
            h4_teo(k) = -0.375;
        else
            h4_teo(k) = -0.5 * h4_teo(k-1);
        end
    end


    % Grafico comparacion
    figure;
    stem(n_imp, h4_teo, 'filled'); hold on;
    stem(n_imp, y_imp, 'r'); grid on;
    legend('h_4[n] teórica', 'h_4[n] numérica');
    title('Comparacion de respuestas impulsionales del Sistema 4');
    xlabel('n'); ylabel('h_4[n]');
    print ([ruta 'h4_sistema4_comparacion.png'], '-dpng');

    % ============================================================
    % Verificacion 1.3.b: TFTD de h4[n] vs H4(e^{j2\pi s}) analitica
    % ============================================================

   % Calculo TFTD aproximada de la respuesta impulsional numerica
    [s_h, H_num] = tftd_aprox(y_imp, n_imp);

    % Calculo H4 analitica en las mismas frecuencias s_h
    H_teo = (0.25 - 0.25 * exp(-1i * 2*pi * s_h)) ./ (1 + 0.5 * exp(-1i * 2*pi * s_h));

    % Comparo modulo
    figure;
    plot(s_h, abs(H_teo), 'b', s_h, abs(H_num), 'r--');
    grid on;
    legend('|H_4| analitica', '|H_4| numerica');
    title('Modulo de H_4(e^{j2\pi s}) - Comparacion analitica vs numerica');
    xlabel('s'); ylabel('|H_4(e^{j2\pi s})|');
    print ([ruta 'H4_mod_analitica_vs_numerica.png'], '-dpng');

     % Señal de entrada del inciso 1
    [n_x, x] = senial(numal);     % x[n]: señal de entrada

    % Salida del sistema 4
    y4 = filtro_sistema4(x);

    % Gráfico solo de la salida
    figure;
    stem(n_x, y4, 'filled'); grid on;
    title('Salida y_4[n] del Sistema 4 para la senal del Ejercicio 1');
    xlabel('n'); ylabel('y_4[n]');
    print ([ruta 'ej1_sistema4_salida_y4.png'], '-dpng');

    % (opcional pero muy util para el informe):
    % comparar entrada y salida en el mismo grafico
    figure;
    stem(n_x, x, 'b', 'filled'); hold on;
    stem(n_x, y4, 'r'); grid on;
    legend('Entrada x[n]', 'Salida y_4[n]');
    title('Comparacion x[n] vs y_4[n] - Sistema 4');
    xlabel('n'); ylabel('amplitud');
    print ([ruta 'ej1_sistema4_x_vs_y4.png'], '-dpng');

    % ================================================
    % 1.5: TFTD de la salida y_4[n] y análisis
    % ================================================

    % TFTD aproximada de la salida
    [s_y4, Y4] = tftd_aprox(y4, n_x);

    % TFTD aproximada de la entrada (para comparar)
    [s_x, X] = tftd_aprox(x, n_x);

    % --- TFTD SOLO de la salida y4[n] ---
    figure;
    plot(s_y4, abs(Y4));
    grid on;
    title('Modulo de la TFTD de la salida y_4[n] - Sistema 4');
    xlabel('s'); ylabel('|Y_4(e^{j2\pi s})|');
    print ([ruta 'ej1_sistema4_mod_Y4_solo.png'], '-dpng');


    % Módulo de la entrada y salida en el mismo gráfico
    figure;
    plot(s_x, abs(X), 'b', s_y4, abs(Y4), 'r--');
    grid on;
    legend('|X(e^{j2\pi s})| entrada', '|Y_4(e^{j2\pi s})| salida');
    title('Modulo de la TFTD: entrada vs salida - Sistema 4');
    xlabel('s'); ylabel('Modulo');
    print ([ruta 'ej1_sistema4_mod_X_vs_Y4.png'], '-dpng');

end
