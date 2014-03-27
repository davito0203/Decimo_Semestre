function [tandelta] = tanDeltaV(alfa,er)

alfad=zeros(200,1);
ereff=zeros(200,1);
q=zeros(200,1);
tandelta=zeros(200,1);
%er=4.3;

load valiData.txt
frec = valiData(:,1);
c=2.9979e8;
h=1.2e-3;
w=4e-3;
t=50e-6;

alfad=alfa-alfaCV(er);

for k=1:200
ereff(k)=(er(k)+1)/2+(er(k)-1)/(2*sqrt(1+12*h/w));
end

for m=1:200
q(m)=(ereff(m)-1)/(er(m)-1);
end

for n=1:200
tandelta(n)= (alfad(n)*c)/(pi*q(n)*frec(n)*ereff(n));
end

