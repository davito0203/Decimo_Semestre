%Prueba oscilador NE555
%T1 tiempo de ancho de pulso en 1
%T2 tiempo de ancho de pulso en 0

r1=100;
r2=100;
c=220e-12;
x=linspace(1,100);
t1=0.693.*(r1+r2).*c;
t2=0.693.*(r2.*c);
freq=1.44./((r1+r2).*c)