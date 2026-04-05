clear; clc; clf; funcprot(0);

// --- 1. SIGNAL DATA DEFINITION ---
x = [1, 2, -3, 2, 1];    
h = [1, 0, -1];          
Nx = length(x); Nh = length(h); L = Nx + Nh - 1;

printf("--- LINEAR CONVOLUTION VERIFICATION ---\n");

// --- 2. ALGORITHM 1: FOLDING & SHIFTING (Manual Loop) ---
y_fold = zeros(1, L);
for n = 1:L
    for k = 1:Nx
        // Scilab indexing starts at 1
        if (n - k + 1 >= 1) & (n - k + 1 <= Nh)
            y_fold(n) = y_fold(n) + x(k) * h(n - k + 1);
        end
    end
end
disp("Result using Folding & Shifting Method:", y_fold);

// --- 3. ALGORITHM 2: MATRIX METHOD (Toeplitz Construction) ---
X_toeplitz = zeros(L, Nh);
for col = 1:Nh
    X_toeplitz(col : col + Nx - 1, col) = x';
end
y_matrix = (X_toeplitz * h')'; 
disp("Result using Matrix Multiplication Method:", y_matrix);

// --- 4. ENERGY COMPUTATION ---
Ex = sum(x.^2); Eh = sum(h.^2); Ey = sum(y_matrix.^2);
printf("\nSIGNAL ENERGIES:\n");
printf("Energy of x[n]: %g\n", Ex);
printf("Energy of h[n]: %g\n", Eh);
printf("Energy of y[n]: %g\n", Ey);
printf("---------------------------------------\n");

// --- 5. VISUALIZATION (Lab 3 Professional Style) ---
nx = 0:Nx-1; nh = 0:Nh-1; ny = 0:L-1;
f = gcf(); clf; f.figure_size = [1000, 900];

// Common plot settings for consistency
min_v = min([x, h, y_matrix]) - 2;
max_v = max([x, h, y_matrix]) + 2;

// Subplot 1: Signal x[n] (Red)
subplot(3, 1, 1);
plot2d3(nx, x, style=2); 
e1 = gce(); e1.children.thickness = 3;
plot(nx, x, 'ro', 'markersize', 8);
for i = 1:Nx
    xstring(nx(i), x(i) + 0.4, string(x(i)));
    txt = gce(); txt.font_size = 3; txt.font_foreground = 2;
end
title(msprintf("Input Signal x[n] (Total Energy: %g)", Ex), "fontsize", 4);
xgrid(color('gray')); gca().data_bounds = [-1, min_v; Nx, max_v];

// Subplot 2: Signal h[n] (Blue)
subplot(3, 1, 2);
plot2d3(nh, h, style=5); 
e2 = gce(); e2.children.thickness = 3;
plot(nh, h, 'bo', 'markersize', 8);
for i = 1:Nh
    xstring(nh(i), h(i) + 0.4, string(h(i)));
    txt = gce(); txt.font_size = 3; txt.font_foreground = 5;
end
title(msprintf("FIR System Response h[n] (Total Energy: %g)", Eh), "fontsize", 4);
xgrid(color('gray')); gca().data_bounds = [-1, min_v; Nx, max_v];

// Subplot 3: Result y[n] (Green)
subplot(3, 1, 3);
plot2d3(ny, y_matrix, style=3); 
e3 = gce(); e3.children.thickness = 3;
plot(ny, y_matrix, 'go', 'markersize', 8);
for i = 1:L
    xstring(ny(i), y_matrix(i) + 0.4, string(y_matrix(i)));
    txt = gce(); txt.font_size = 3; txt.font_foreground = 3;
end
title(msprintf("Linear Convolution Result y[n] (Total Energy: %g)", Ey), "fontsize", 4);
xgrid(color('gray')); gca().data_bounds = [-1, min_v; L, max_v];
