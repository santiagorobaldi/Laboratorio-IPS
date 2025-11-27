function graficar_hcanald(numal)
    % GRAFICAR_hcanald  Ejer 2.1
    [n, h] = hcanald(numal);

    ruta = 'C:\Users\santi\Laboratorio-IPS\Figuras\Hcanald\';


    figure;
    stem(n, h, 'filled');
    title('Respuesta impulsional del canal discreto');
    xlabel('n'); ylabel('h[n]');
    grid on;
    print ([ruta 'ej2_hacald.png'], '-dpng');

    format long g
    idx = find(abs(h) > 1e-12);
    [n(idx).'  h(idx).']



end

