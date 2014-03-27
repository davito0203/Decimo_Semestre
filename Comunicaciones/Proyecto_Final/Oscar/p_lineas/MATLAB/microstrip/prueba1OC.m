function [Ereff]= prueba1OC(n)

frec=zeros(631,1);
Ereff=zeros(631,1);
c=2.99793e8;
l= 68e-3;
l1= 70e-3;
%n=3;

load datos.txt;
frec = datos(:,1);
faseOC = datos(:,3);

for k= 1:631 ;
Ereff(k)= (  (faseOC(k)-n*360)*(pi/180)/(-4*pi+l*frec(k)/c)+(l1/l)  )^2;
end