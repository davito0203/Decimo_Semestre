function [frec, rOC, angleOC, rSC, angleSC]= datos0()

rOC=zeros(631,1);
angleOC=zeros(631,1);
rSC=zeros(631,1);
angleSC=zeros(631,1);
c=2.9979e8;

load datos.txt;

frec = datos(:,1);
magOC = datos(:,2);
faseOC = datos(:,3);
magSC = datos(:,4);
faseSC = datos(:,5);

for k= 1:631 ;
rOC(k)= magOC(k);
angleOC(k)= (faseOC(k)-180)+((180*2*2*pi*7e-2)/(pi*c))*frec(k) ;

rSC(k)= magSC(k);
angleSC(k)= (faseSC(k))-((180*2*2*pi*7e-2)/(pi*c))*frec(k) ;
end