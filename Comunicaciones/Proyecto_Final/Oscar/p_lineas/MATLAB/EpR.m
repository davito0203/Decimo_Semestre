function [epre]= EpR( beta1)
%ereff=(er+1)/2+(er-1)/(2*sqrt(1+12*h/w))

load datos.txt;
frec = datos(:,1);

for k = 1:631;
epre(k)=eval(solve('beta1(k) =((2*pi*frec(k))/(2.99793e8)) * ( (x+1)/2 + (x-1)/(2*sqrt(1+12*(1.5/4))) )^0.5  '));
end