function [epre]= EpRet(epreff)
%ereff=(er+1)/2+(er-1)/(2*sqrt(1+12*h/w))

epre=zeros(631,1);

for k = 1:631 ;
epre(k)=eval(solve('epreff(k) =  (x+1)/2 + (x-1)/(2*sqrt(1+12*(1.5/4))) '));
end