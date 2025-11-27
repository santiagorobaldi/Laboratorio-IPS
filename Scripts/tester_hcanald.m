function tester_hcanald(numAl)
    % numAl : número de alumno


    ruta = 'C:\Users\santi\Laboratorio-IPS\Figuras\Hcanald\';


    % Respuesta impulsional del canal "verdadera"
    [n_imp, h_teo] = hcanald(numAl);

    % Impulso de prueba del mismo tamaño que h_teo
    x_imp = zeros(size(h_teo));
    x_imp(1) = 1;   % x[0] = 1

    % Respuesta impulsional numérica del filtro implementado
    y_imp = filtro_hcanald(x_imp);

    % Gráfico de comparación
    figure;
    stem(n_imp, h_teo, 'filled'); hold on;
    stem(n_imp, y_imp, 'r'); grid on;
    legend('h[n] teórica (hcanald)', 'h[n] numérica (filtro_hcanald)');
    title('Comparación de respuestas impulsionales del canal con dos ecos');
    xlabel('n'); ylabel('h[n]');

    print([ruta 'h_canal_comparacion.png'], '-dpng');

end

