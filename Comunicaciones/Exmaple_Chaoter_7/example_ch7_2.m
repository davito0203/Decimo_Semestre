% clc;
% clear all;
% close all;
% fs=100;
% no_of_bits=100;
% no_of_samples=fs*no_of_bits;
% threshold=0.5;
% Tb=1; % Bit duration
% fc=8; % Carrier frequency
% f1=fc+1/(2*Tb);
% f0=fc-1/(2*Tb);
% t = linspace(0, 1, no_of_samples);
% t1=linspace(0, 1, no_of_samples);
% t2=t1/fc;
% A=round(rand(1,no_of_bits)); % Generate a random sequence
% d=A(1:no_of_bits); % Binary sequence
% for j = 1:length(d)
%     if d(j)==1
%         freq1 = cos(2*pi*f1*t2);
%     else
%         freq0 = cos(2*pi*f0*t2);
%     end
% end
M = 1; freqsep = 8; nsamp = 100; Fs = 100;
x=round(rand(1,M)); % Random signal
y = fskmod(x,M,freqsep,nsamp,Fs); % Modulate.
ly = length(y);
% Create an FFT plot.
freq = [-Fs/2 : Fs/ly : Fs/2 - Fs/ly];
Syy = 10*log10(fftshift(abs(fft(y))));
plot(freq,Syy)