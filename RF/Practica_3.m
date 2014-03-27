clear all;
format long;

f=4e6;
b=10e3;
rt=1e3;
r2=50;
x=4;
f0=f+x*100e3;
qt=f0/b;
c=1/(2*pi*b*rt);
l=1/((2*pi*f0)^2*c);
n=(rt/r2)^(1/2);
qp=(qt^2/n^2-1)^(1/2);
c2=qp^2/(2*pi*f0*r2);
c1=c2*c/(c2-c);