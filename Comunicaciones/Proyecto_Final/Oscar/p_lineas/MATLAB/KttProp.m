function [CPOC, CPSC]= KttProp(n)

ReOC=zeros(631,1);
ImOC=zeros(631,1);
ReSC=zeros(631,1);
ImSC=zeros(631,1);
CPOC=zeros(631,1);
CPSC=zeros(631,1);

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
ReOC(m)= magOC(m)*cos( (faseOC(m)-n*360 + 2*(2*180*frec(m)/c)*lo)*(pi/180) );
ImOC(m)= magOC(m)*sin( (faseOC(m)-n*360 + 2*(2*180*frec(m)/c)*lo)*(pi/180) );
ReSC(m)= magSC(m)*cos( (faseSC(m)-n*360 + 2*(2*180*frec(m)/c)*lo)*(pi/180) );
ImSC(m)= magSC(m)*sin( (faseSC(m)-n*360 + 2*(2*180*frec(m)/c)*lo)*(pi/180) );
end


for k = 1:631;
    CPOC(k)=eval(solve('ReOC(k) + i*ImOC(k)=(41.1571*coth(x*68e-3)-50)/(41.1571*coth(x*68e-3)+50) '));
    CPSC(k)=eval(solve('ReSC(k) + i*ImSC(k)=(41.1571*tanh(x*68e-3)-50)/(41.1571*tanh(x*68e-3)+50) '));
end
    