clear; clc; clf; funcprot(0);

// --- 1. SIGNAL DATA DEFINITION ---
x = [1, 2, -3, 2, 1];    
h = [1, 0, -1, -1, 1];   
N = length(x);

printf("--- CIRCULAR CONVOLUTION VERIFICATION (N=%d) ---\n", N);

// --- 2. ALGORITHM 1: FOLDING & SHIFTING (Manual Loop) ---
y_fold = zeros(1, N);
for n = 1:N
    for k = 1:N
        // Scilab's pmodulo handles the periodic index wrap-around
        idx = pmodulo(n - k, N) + 1; 
        y_fold(n) = y_fold(n) + h(k) * x(idx);
    end
end
disp("Result using Circular Folding & Shifting:", y_fold);

// --- 3. ALGORITHM 2: MATRIX METHOD (Circulant Matrix Construction) ---
H_matrix = zeros(N, N);
for r = 1:N
    for c = 1:N
        idx_circ = pmodulo(r - c, N) + 1;
        H_matrix(r, c) = h(idx_circ);
    end
end
y_matrix = (H_matrix * x')'; 
disp("Result using Circulant Matrix Multiplication:", y_matrix);

// --- 4. ENERGY COMPUTATION ---
Ex = sum(x.^2); Eh = sum(h.^2); Ey = sum(y_matrix.^2);
printf("\nSIGNAL ENERGIES:\n");
printf("Energy of x[n]: %g\n", Ex);
printf("Energy of h[n]: %g\n", Eh);
printf("Energy of y[n]: %g\n", Ey);
printf("----------------------------------------------\n");

// --- 5. VISUALIZATION (Lab 3 Style) ---
n_axis = 0:N-1;
f = gcf(); clf; f.figure_size = [1000, 900];
min_v = min([x, h, y_matrix]) - 2;
max_v = max([x, h, y_matrix]) + 2;

// Subplot 1: Signal x[n] (Red)
subplot(3, 1, 1); plot2d3(n_axis, x, style=2); 
e1 = gce(); e1.children.thickness = 3;
plot(n_axis, x, 'ro', 'markersize', 8);
for i = 1:N
    xstring(n_axis(i), x(i) + 0.4, string(x(i)));
    txt = gce(); txt.font_size = 3; txt.font_foreground = 2;
end
title(msprintf("Input Signal x[n] (Energy: %g)", Ex), "fontsize", 4);
xgrid(color('gray')); gca().data_bounds = [-1, min_v; N, max_v];

// Subplot 2: Signal h[n] (Blue)
subplot(3, 1, 2); plot2d3(n_axis, h, style=5); 
e2 = gce(); e2.children.thickness = 3;
plot(n_axis, h, 'bo', 'markersize', 8);
for i = 1:N
    xstring(n_axis(i), h(i) + 0.4, string(h(i)));
    txt = gce(); txt.font_size = 3; txt.font_foreground = 5;
end
title(msprintf("Impulse Response h[n] (Energy: %g)", Eh), "fontsize", 4);
xgrid(color('gray')); gca().data_bounds = [-1, min_v; N, max_v];

// Subplot 3: Result y[n] (Green)
subplot(3, 1, 3); plot2d3(n_axis, y_matrix, style=3); 
e3 = gce(); e3.children.thickness = 3;
plot(n_axis, y_matrix, 'go', 'markersize', 8);
for i = 1:N
    xstring(n_axis(i), y_matrix(i) + 0.4, string(y_matrix(i)));
    txt = gce(); txt.font_size = 3; txt.font_foreground = 3;
end
title(msprintf("Circular Convolution y[n] (Total Energy: %g)", Ey), "fontsize", 4);
xgrid(color('gray')); gca().data_bounds = [-1, min_v; N, max_v];
