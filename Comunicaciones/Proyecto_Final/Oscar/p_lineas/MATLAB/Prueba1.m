function [ReOC, ImOC, ReSC, ImSC]= Prueba1(n)

ReOC=zeros(631,1);
ImOC=zeros(631,1);
ReSC=zeros(631,1);
ImSC=zeros(631,1);

load datos.txt;
frec = datos(:,1);
magOC = datos(:,2);
faseOC = datos(:,3);
magSC = datos(:,4);
faseSC = datos(:,5);

%n=1;
c= 2.99793e8;
lo= 70e-3;

for m = 1:631;
ReOC(m)= magOC(m)*cos( faseOC(m)-n*360 + 2*(2*180*frec(m)/c)*lo );
ImOC(m)= magOC(m)*sin( faseOC(m)-n*360 + 2*(2*180*frec(m)/c)*lo );
ReSC(m)= magSC(m)*cos( faseSC(m)-n*360 + 2*(2*180*frec(m)/c)*lo );
ImSC(m)= magSC(m)*sin( faseSC(m)-n*360 + 2*(2*180*frec(m)/c)*lo );
end
