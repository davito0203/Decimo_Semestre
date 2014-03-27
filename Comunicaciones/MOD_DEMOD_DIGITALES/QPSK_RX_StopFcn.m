m=20;%TIEMPO DE SIMULACI�N EN SIMULINK
Ts=100;%TIEMPO DE MUESTREO (ES EL MISMO DE LOS SIN Y COS DE LOS TX)

% TIEMPO
tiempo=(0:1/Ts:m)';
% RECORTAR EL RUIDO INICIAL
imp=impares(100*1:end);
par=pares(100*1:end);

% ALINEAR LA TRAMA DESDE EL PRIMER 1
par=par(34:end);
imp=imp(34:end);

% AJUSTAR EL TIEMPO A LA LONGITUD DE LA TRAMA
tiempo=tiempo(1:length(imp));

% PLOTEO DE LAS SE�ALES
% BITS IMPARES
subplot(3,1,2)
plot(tiempo,imp);
ylim([-.5 1.5])
title('IMPARES')
grid on
% BITS PARES
subplot(3,1,1)
plot(tiempo,par);
ylim([-.5 1.5])
title('PARES')
grid on

% UNIR BITS PARES E IMPARES
% MATRIZ NULA PARA ALMACENAR DATOS
D=[];
% CANTIDAD DE BITS DE TAMA�O 100
lb=floor(length(imp)/100)-1;
% CICLO DE RECONSTRUCCI�N DE LA TRAMA
for n=0:lb
    D=[D;par(n*100+1:100*(n+1));imp(n*100+1:100*(n+1))];
end
% TIEMPO DE RECONSTRUCCI�N DE LA TRAMA PARA AJUSTARLO AL ANCHO DE BIR
% ORIGINAL
tiempo=(1:1/180:50)';
subplot(3,1,3)
plot(tiempo(1:length(D)),D);
ylim([-5 5])
xlim([1 21])
title('SENAL ORIGINAL')
grid on