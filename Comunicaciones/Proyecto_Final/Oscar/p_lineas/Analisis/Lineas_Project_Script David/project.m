% Waveguides lines of transmission
% Medidas en Metros
clear all; format long;
w=4e-3;%% Ancho en metros de la microscrip
h=1.33e-3;%% Alto del dielectrico en metros
t=50e-9;%% Alto del conductor
%--------------------------------------------------------------------------
f=2.5e9;%linspace(2e9,3e9,100);
%--------------------------------------------------------------------------
%Constantes físicas
mu0=pi*4e-7;% Permeabilidad magnetica en el vacio
c=299792458;% Velocidad de la luz en el vacio
ep0=1/(mu0*c^2);% Permitividad electrica en el vacio
%--------------------------------------------------------------------------
sigma=5.813e7;% Conductividad del cobre
%--------------------------------------------------------------------------
er=4.3;%2:0.5:10;
rs=sqrt(2*pi*f*mu0/(2*sigma));
eref=ereff(w,h,er);
z0=z0(w,h,eref);
alfac=alfac(rs,h,w,t,z0);
[deltal,deltaw]=delta(eref,w,h,t);
%parametro S[1,1], coeficiente de reflexión
lcc=c/(f*sqrt(eref));
loc=lcc-deltal;