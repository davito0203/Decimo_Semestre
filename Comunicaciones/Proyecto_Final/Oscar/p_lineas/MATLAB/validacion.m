function [frec, alfaOC, betaOCu, alfaSC, betaSCu]=validacion(n)


alfaOC=zeros(200,1);
betaOC=zeros(200,1);
alfaSC=zeros(200,1);
betaSC=zeros(200,1);

load valiData.txt;

frec = valiData(:,1);
realOC = valiData(:,2);
imOC = valiData(:,3);
realSC = valiData(:,4);
imSC = valiData(:,5);

l=75e-3;
for k= 1:200 ;
alfaOC(k)= abs(realOC(k) + imOC(k)*i);
betaOC(k)=(angle(realOC(k) + imOC(k)*i)-pi*2*n)/(-2*l);

alfaSC(k)= abs(realSC(k) + imSC(k)*i);
betaSC(k)=(angle(realSC(k) + imSC(k)*i)-pi*2*n-pi)/(-2*l);
end

betaOCu=unwrap(betaOC);
betaSCu=unwrap(betaSC);