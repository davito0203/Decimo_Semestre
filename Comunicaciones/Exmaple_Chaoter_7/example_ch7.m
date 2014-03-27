% %ASK
% %numbers of bits 100
% %sampling frequency fs = 100 (Hz)
% %data points sample = 100 * fs =10000
% %tamaño in fft,n = 4096
% %fc=4 or 8 (Hz)
% %bit duration tb=1 (s) or 1/2 (s)
% 
% %Function
% %s1(t)=sqrt(2*Eb/Tb)*cos(2*pi*f1*t)
% %s1(t)=sqrt(2*Eb/Tb)*cos(2*pi*f2*t)
clear all; format long;
fs=100;       %
Nbits=100*fs;%
fc=8;         %
Tb=1;

% For FSK, amplitude are  assumed to be unity.,..
%for fsk take
fc=fc*pi*2;%conv to angular
fc2=fc-1/(2*Tb);%assume double the freq for zeros
in=round(rand(1,Nbits));%Vector of bits
%in=ones(1,Nbits);
k=length(in);
for i=1:100*k%conv to rect waveform with 100 samples in each bit
    sigu(i)=in(ceil(i/100));
end
%sig has 100k samples,100 samples per pulse
%pulse width sec
pw=1;
g=k*pw/length(sigu);% 100 samples in every ‘pw’ width
t1=0:g:k*pw;
t=t1(1:length(sigu));%truncate t to have 100k samples,same as sigu
%now simple
car=cos(fc*t);
car2=cos(fc2*t);
fo=sigu.*car+(1-sigu).*car2;
%now plot:
%figure
%subplot(3,1,1)
%plot(t,sigu,'r');
%subplot(3,1,2)
%plot(t,car)
%subplot(3,1,3)
%plot(t,fo);
%Fourier transformation
N=4096;%numero muestras
Ft=fft(fo,N);
%[I,f]=fftsingleside(fo,t,fc);
%tk=linspace();
figure
plot(abs(Ft))
%gain in dB
%spe=abs(Ft).^2;
spedb=10*log10(abs(fftshift(Ft)));
figure
plot(spedb)