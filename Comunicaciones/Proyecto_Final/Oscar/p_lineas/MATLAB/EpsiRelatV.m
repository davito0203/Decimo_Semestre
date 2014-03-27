function [epre]= EpsiRelatV(beta1)
%ereff=(er+1)/2+(er-1)/(2*sqrt(1+12*h/w))

epre=zeros(200,1);
load valiData.txt;
frec = valiData(:,1);

for k = 1:200 ;
epre(k)=eval(solve('beta1(k) =((2*pi*frec(k))/(2.99793*10^8)) * ( (x+1)/2 + (x-1)/(2*sqrt(1+12*(1.2/4))) )^0.5  '));
end