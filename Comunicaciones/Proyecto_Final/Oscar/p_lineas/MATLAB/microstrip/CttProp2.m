function [frec, CPOC]=CttProp2() % pilo unwrap

W= 4e-3;
l=68e-3;

c=2.9979e8;

load datos.txt

frec = datos(:,1);
magOC = datos(:,2);
faseOC = datos(:,3);
magSC = datos(:,4);
faseSC = datos(:,5);

for k = 1:631;
ReOC(k)= (10^(magOC(k)/20))* cos(faseOC(k)- 2*(2*pi*frec(k)*(7e-2)/c) );
ImOC(k)= (10^(magOC(k)/20))* sin(faseOC(k)- 2*(2*pi*frec(k)*(7e-2)/c) );
end

for k = 1:631;
    %CPSC(k)=eval(solve('ReSC(k) + i*ImSC(k)=((tanh(x*68e-3)-1)/(tanh(x*68e-3)+1))*exp(-2*x*75e-3) '));
    CPOC(k)=eval(solve('ReOC(k) + i*ImOC(k)=(coth(x*68e-3)-1)/(coth(x*68e-3)+1) '));
    %CP(k)=eval(q);
end
