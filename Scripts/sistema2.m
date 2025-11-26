function sistema2(numal)
    % SISTEMA 2
    % y[n] = 0.5 x[n] - 0.5 x[n-1]

    ruta = 'C:\Users\santi\Laboratorio-IPS\Figuras\Sistema2\';
    % --- 1) Graficar h2[n] ---
    n = -2:2;
    h2 = 0.5*(n==0) - 0.5*(n==1);

    figure;
    stem(n, h2, 'filled'); grid on;
    title('Respuesta impulsional h_2[n]');
    xlabel('n'); ylabel('h_2[n]');

    print ([ruta 'h2_sistema2.png'], '-dpng');


    % --- 2) Graficar H2(e^{j2pis}) ---
    ds = 0.001;
    s = -0.5:ds:0.5;
    H2 = 0.5 - 0.5 * exp(-1i * 2*pi*s);

    figure;
    plot(s, abs(H2)); grid on;
    title('Modulo |H_2(e^{j2\pi s})|');
    xlabel('s'); ylabel('|H_2|');
    print ([ruta 'H2_mod_sistema2.png'], '-dpng');

    figure;
    plot(s, angle(H2)); grid on;
    title('Fase arg H_2(e^{j2\pi s})');
    xlabel('s'); ylabel('fase');
    print ([ruta 'H2_fase_sistema2.png'], '-dpng');

    % ============================================================
    % Verificacion 1.3.a: respuesta impulsional numerica vs teorica
    % ============================================================

    % Defino un eje de n para el impulso
    n_imp = -5:5;

    % Defino el impulso discreto delta[n]: 1 en n=0, 0 en el resto
    x_imp = (n_imp == 0);             % vector [1 0 0 0 ...]

    % Aplico el filtro sistema 2 a la entrada impulso
    y_imp = filtro_sistema2(x_imp);   % esta es h2[n] numerica

    % Defino h2 teorica en el mismo eje n_imp
    h2_teo = 0.5 * (n_imp == 0) - 0.5 * (n_imp == 1);

    % Grafico comparacion
    figure;
    stem(n_imp, h2_teo, 'filled'); hold on;
    stem(n_imp, y_imp, 'r'); grid on;
    legend('h_2[n] teórica', 'h_2[n] numérica');
    title('Comparacion de respuestas impulsionales del Sistema 2');
    xlabel('n'); ylabel('h_2[n]');
    print ([ruta 'h2_sistema2_comparacion.png'], '-dpng');

    % ============================================================
    % Verificacion 1.3.b: TFTD de h2[n] vs H2(e^{j2\pi s}) analitica
    % ============================================================

    % Calculo TFTD aproximada de la respuesta impulsional numerica
    [s_h, H_num] = tftd_aprox(y_imp, n_imp);

    % Calculo H2 analitica en las mismas frecuencias s_h
    H_teo = 0.5 - 0.5 * exp(-1i * 2*pi * s_h);

    % Comparo modulo
    figure;
    plot(s_h, abs(H_teo), 'b', s_h, abs(H_num), 'r--');
    grid on;
    legend('|H_2| analitica', '|H_2| numerica');
    title('Modulo de H_2(e^{j2\pi s}) - Comparacion analitica vs numerica');
    xlabel('s'); ylabel('|H_2(e^{j2\pi s})|');
    print ([ruta 'H2_mod_analitica_vs_numerica.png'], '-dpng');

     % Señal de entrada del inciso 1
    [n_x, x] = senial(numal);     % x[n]: señal de entrada

    % Salida del sistema 2
    y2 = filtro_sistema2(x);      % y2[n] = 0.5 x[n] - 0.5 x[n-1]

    % Gráfico solo de la salida
    figure;
    stem(n_x, y2, 'filled'); grid on;
    title('Salida y_2[n] del Sistema 2 para la senal del Ejercicio 1');
    xlabel('n'); ylabel('y_2[n]');
    print ([ruta 'ej1_sistema2_salida_y2.png'], '-dpng');

    % (opcional pero muy util para el informe):
    % comparar entrada y salida en el mismo grafico
    figure;
    stem(n_x, x, 'b', 'filled'); hold on;
    stem(n_x, y2, 'r'); grid on;
    legend('Entrada x[n]', 'Salida y_2[n]');
    title('Comparacion x[n] vs y_2[n] - Sistema 2');
    xlabel('n'); ylabel('amplitud');
    print ([ruta 'ej1_sistema2_x_vs_y2.png'], '-dpng');

    % ================================================
    % 1.5: TFTD de la salida y_2[n] y análisis
    % ================================================

    % TFTD aproximada de la salida
    [s_y2, Y2] = tftd_aprox(y2, n_x);

    % TFTD aproximada de la entrada (para comparar)
    [s_x, X] = tftd_aprox(x, n_x);

    % --- TFTD SOLO de la salida y2[n] ---
    figure;
    plot(s_y2, abs(Y2));
    grid on;
    title('Modulo de la TFTD de la salida y_2[n] - Sistema 2');
    xlabel('s'); ylabel('|Y_2(e^{j2\pi s})|');
    print ([ruta 'ej1_sistema2_mod_Y2_solo.png'], '-dpng');


    % Módulo de la entrada y salida en el mismo gráfico
    figure;
    plot(s_x, abs(X), 'b', s_y2, abs(Y2), 'r--');
    grid on;
    legend('|X(e^{j2\pi s})| entrada', '|Y_2(e^{j2\pi s})| salida');
    title('Modulo de la TFTD: entrada vs salida - Sistema 2');
    xlabel('s'); ylabel('Modulo');
    print ([ruta 'ej1_sistema2_mod_X_vs_Y2.png'], '-dpng');

end
