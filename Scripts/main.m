function main()
    % MAIN del PU1 - IPS 2025
    % Editá esta línea con tu número de alumno (sin barra):
    numal = 03769;

    addpath('C:\Users\santi\Laboratorio-IPS\Scripts');
    % ----- Ejercicio 1: señal y TFTD aproximada -----
    % graficar_senial(numal);

    % ----- Ejercicio 1:
    % ----- sacar el comentario y correr "main" para ver el sistema que quiera analizar
    % sistema1(numal);
    % sistema2(numal);
    % sistema3(numal);
    % sistema4(numal);


    % ----- Ejercicio 2
    % graficar_hcanald(numal);
    % tester_hcanald(numal);
    [x, fs] = audioread('audio.wav');
    y = filtro_hcanald(x);
    sound(x, fs);   % entrada
    pause(length(x)/fs + 0.5);

    sound(y, fs);   % salida (con ecos)

    % Eje temporal completo
    N = length(x);
    t = (0:N-1)/fs;

    % Figura
    figure;

    subplot(2,1,1);
    plot(t, x);
    title('Audio de entrada x[n]');
    xlabel('Tiempo [s]');
    ylabel('Amplitud');
    grid on;

    subplot(2,1,2);
    plot(t, y);
    title('Audio de salida y[n] (canal con dos ecos)');
    xlabel('Tiempo [s]');
    ylabel('Amplitud');
    grid on;

    % Guardar imagen
    ruta = 'C:\Users\santi\Laboratorio-IPS\Figuras\Hcanald\';
    print([ruta 'ej2_audio_xy_completo.png'], '-dpng');

end

