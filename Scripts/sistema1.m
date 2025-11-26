function sistema1(numal)
    % SISTEMA 1
    % y[n] = 0.5 x[n] + 0.5 x[n-1]

    ruta_sis1 = 'C:\Users\santi\Laboratorio-IPS\Figuras\Sistema1\';
    % --- 1) Graficar h1[n] ---
    n = -2:2;
    h1 = 0.5*(n==0) + 0.5*(n==1);

    figure;
    stem(n, h1, 'filled'); grid on;
    title('Respuesta impulsional h_1[n]');
    xlabel('n'); ylabel('h_1[n]');

    print ([ruta_sis1 'h1_sistema1.png'], '-dpng');


    % --- 2) Graficar H1(e^{j2pis}) ---
    ds = 0.001;
    s = -0.5:ds:0.5;
    H1 = 0.5 + 0.5 * exp(-1i * 2*pi*s);

    figure;
    plot(s, abs(H1)); grid on;
    title('Modulo |H_1(e^{j2\pi s})|');
    xlabel('s'); ylabel('|H_1|');
    print ([ruta_sis1 'H1_mod_sistema1.png'], '-dpng');

    figure;
    plot(s, angle(H1)); grid on;
    title('Fase arg H_1(e^{j2\pi s})');
    xlabel('s'); ylabel('fase');
    print ([ruta_sis1 'H1_fase_sistema1.png'], '-dpng');

    % ============================================================
    % Verificacion 1.3.a: respuesta impulsional numerica vs teorica
    % ============================================================

    % Defino un eje de n para el impulso
    n_imp = -5:5;

    % Defino el impulso discreto delta[n]: 1 en n=0, 0 en el resto
    x_imp = (n_imp == 0);             % vector [1 0 0 0 ...]

    % Aplico el filtro sistema 1 a la entrada impulso
    y_imp = filtro_sistema1(x_imp);   % esta es h1[n] numerica

    % Defino h1 teorica en el mismo eje n_imp
    h1_teo = 0.5 * (n_imp == 0) + 0.5 * (n_imp == 1);

    % Grafico comparacion
    figure;
    stem(n_imp, h1_teo, 'filled'); hold on;
    stem(n_imp, y_imp, 'r'); grid on;
    legend('h_1[n] teórica', 'h_1[n] numérica');
    title('Comparacion de respuestas impulsionales del Sistema 1');
    xlabel('n'); ylabel('h_1[n]');
    print ([ruta_sis1 'h1_sistema1_comparacion.png'], '-dpng');

    % ============================================================
    % Verificacion 1.3.b: TFTD de h1[n] vs H1(e^{j2\pi s}) analitica
    % ============================================================

    % Calculo TFTD aproximada de la respuesta impulsional numerica
    [s_h, H_num] = tftd_aprox(y_imp, n_imp);

    % Calculo H1 analitica en las mismas frecuencias s_h
    H_teo = 0.5 + 0.5 * exp(-1i * 2*pi * s_h);

    % Comparo modulo
    figure;
    plot(s_h, abs(H_teo), 'b', s_h, abs(H_num), 'r--');
    grid on;
    legend('|H_1| analitica', '|H_1| numerica');
    title('Modulo de H_1(e^{j2\pi s}) - Comparacion analitica vs numerica');
    xlabel('s'); ylabel('|H_1(e^{j2\pi s})|');
    print ([ruta_sis1 'H1_mod_analitica_vs_numerica.png'], '-dpng');

     % Señal de entrada del inciso 1
    [n_x, x] = senial(numal);     % x[n]: señal de entrada

    % Salida del sistema 1
    y1 = filtro_sistema1(x);      % y1[n] = 0.5 x[n] + 0.5 x[n-1]

    % Gráfico solo de la salida
    figure;
    stem(n_x, y1, 'filled'); grid on;
    title('Salida y_1[n] del Sistema 1 para la senal del Ejercicio 1');
    xlabel('n'); ylabel('y_1[n]');
    print ([ruta_sis1 'ej1_sistema1_salida_y1.png'], '-dpng');

    % (opcional pero muy util para el informe):
    % comparar entrada y salida en el mismo grafico
    figure;
    stem(n_x, x, 'b', 'filled'); hold on;
    stem(n_x, y1, 'r'); grid on;
    legend('Entrada x[n]', 'Salida y_1[n]');
    title('Comparacion x[n] vs y_1[n] - Sistema 1');
    xlabel('n'); ylabel('amplitud');
    print ([ruta_sis1 'ej1_sistema1_x_vs_y1.png'], '-dpng');

    % ================================================
    % 1.5: TFTD de la salida y_1[n] y análisis
    % ================================================

    % TFTD aproximada de la salida
    [s_y1, Y1] = tftd_aprox(y1, n_x);

    % TFTD aproximada de la entrada (para comparar)
    [s_x, X] = tftd_aprox(x, n_x);

    % --- TFTD SOLO de la salida y1[n] ---
    figure;
    plot(s_y1, abs(Y1));
    grid on;
    title('Modulo de la TFTD de la salida y_1[n] - Sistema 1');
    xlabel('s'); ylabel('|Y_1(e^{j2\pi s})|');
    print ([ruta_sis1 'ej1_sistema1_mod_Y1_solo.png'], '-dpng');


    % Módulo de la entrada y salida en el mismo gráfico
    figure;
    plot(s_x, abs(X), 'b', s_y1, abs(Y1), 'r--');
    grid on;
    legend('|X(e^{j2\pi s})| entrada', '|Y_1(e^{j2\pi s})| salida');
    title('Modulo de la TFTD: entrada vs salida - Sistema 1');
    xlabel('s'); ylabel('Modulo');
    print ([ruta_sis1 'ej1_sistema1_mod_X_vs_Y1.png'], '-dpng');

end
