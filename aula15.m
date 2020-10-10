%Henrique Bueno de Lima - Nº USP: 9302305
clear;
% Diferencial do Campo magnético com u_0 . I = 1
function dB = dB(p, z)
  dB = 1/(4*pi) * p/((p^2 + z^2)^(3/2));
endfunction

function integral_simpson = integral_simpson(dz, z, p, s)
  integral = 0;
  for i = 2:(s-1)
    if(mod(i,2) == 0) % indices pares
      integral = integral + 4*dB(p, z(i));
    else % indices ímpares
      integral = integral + 2*dB(p, z(i));
    endif
  endfor
  integral = integral + dB(p, z(1)) + dB(p, z(s));
  integral_simpson = integral * dz/3;

endfunction

L = 10;
dz = [0.1 0.05 0.01 0.005];
p = 0.01:0.01:0.1;
z = -L/2:dz(1):L/2;

size_dz = length(dz);
size_z = length(z);
size_p = length(p);

B = zeros(size_dz, size_p);
for i = 1:size_dz
  for j = 1:size_p
    B(i,j) = integral_simpson(dz(i), z, p(j), size_z);
  endfor
endfor
plot(p,B)
legend('dz = 0.1', 'dz = 0.05', 'dz = 0.01', 'dz = 0.001');
xlabel('p','Fontsize', 20);
ylabel('B','Fontsize', 20);

figure(2)
theta = linspace(0,2*pi, 40);
x = p' * cos(theta);
y = p' * sin(theta);
for i = 1:size_dz
  Bx = -B(i,:)' * sin(theta);
  By = B(i,:)' * cos(theta);
  quiver(x,y,Bx,By,4); hold on;
  endfor
xlabel('x','Fontsize', 20);
ylabel('y','Fontsize', 20);
set(gca, 'Fontsize', 20);