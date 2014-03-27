clear all;
t=-100:0.1:100;
m=t./(1+t.^2);
%figure
%plot(t,m)
%grid on;
f=10;
c=50.*cos(2*pi*f.*t);
%figure
%plot(t,c)
%grid on;
%-----------------------------
ka1=1;
s1=(1+ka1.*m).*cos(2*pi*f.*t);
%figure
%plot(t,s1)
%grid on;
%-----------------------------
ka2=2;
s2=(1+ka2.*m).*cos(2*pi*f.*t);
%figure
%plot(t,s2)
%grid on;
%-------------------------------
%-----------------------------
ka3=2.5;
s3=(1+ka3.*m).*cos(2*pi*f.*t);
%%figure
%plot(t,s3)
%grid on;
s1=s1';
[I,F]=fftsingleside(s1',t,f);
figure
plot(F,abs(I))
s2=s2';
[I2,F2]=fftsingleside(s2',t,f);
figure
plot(F2,abs(I2))
s3=s3';
[I3,F3]=fftsingleside(s3',t,f);
figure
plot(F3,abs(I3))