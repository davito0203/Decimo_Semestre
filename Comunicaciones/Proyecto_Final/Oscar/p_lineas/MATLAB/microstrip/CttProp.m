function [frec, alfaOC, betaOC, alfaSC, betaSC]=CttProp(n)

alfaOC=zeros(631,1);
betaOC=zeros(631,1);
alfaSC=zeros(631,1);
betaSC=zeros(631,1);

l=68e-3;
c=2.9979e8;

load datos.txt;

frec = datos(:,1);
magOC = datos(:,2);
faseOC = datos(:,3)-.360*3;
magSC = datos(:,4);
faseSC = datos(:,5)-.360*3;

for k= 1:631 ;
alfaOC(k)= magOC(k)/(-2*l*8.686);
betaOC(k)=((faseOC(k)-360*n)*(pi/180)+((2*2*pi*7e-2)/c)*frec(k) )/(-2*l);

alfaSC(k)= magSC(k)/(-2*l*8.686);
betaSC(k)=((faseSC(k)-360*n)*(pi/180)+((2*2*pi*7e-2)/c).*frec(k) -pi )/(-2*l);
end