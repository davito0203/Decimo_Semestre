function [I,f]=fftsingleside(vin,t,n)

dt=t(3)-t(2);
Fs=1/dt;

%FFT 

%Make sure is a column vector
if (size(vin,1)==1)
    vin=vin';
end 

% nfft=numel(vin); 
nfft=2^(nextpow2(numel(vin))+n);
df = Fs/nfft ;
f = [0:df:Fs/2]';% Create frequency vector
I=fft(vin,nfft)*dt;%Current fourier transform
% I=fft(vin,nfft);%Current fourier transform

I=I(1:nfft/2+1); %Obtain the FFT magnitude in for single side spectrum 
 