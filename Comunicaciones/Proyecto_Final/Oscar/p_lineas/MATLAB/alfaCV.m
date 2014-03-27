function [alfac]=alfaCV(er)

ereff=zeros(200,1);
rs=zeros(200,1);
z0=zeros(200,1);
alfac=zeros(200,1);

load valiData.txt
frec = valiData(:,1);

h=1.2e-3;
w=4e-3;
t=50e-6;
mu0=4*pi*10^-7 ;
sigma=5.813*10^7;

der=1/pi*log(2*h/t);



for k=1:200
ereff(k)=(er(k)+1)/2+(er(k)-1)/(2*sqrt(1+12*h/w));
end
for m=1:200
rs(m)= sqrt(frec(m)*(pi*mu0/sigma));
end
for n= 1:200
z0(n)=120*pi/(sqrt(ereff(n))*(w/h+1.393+0.667*log(w/h+1.44)));
end

for p=1:200
alfac(p)=((z0(p)*rs(p))/(14400*pi^2*h))*(1+(h/w)^2*(0.44+6*(1-h/w)^5))*(1+w/h+der);
end