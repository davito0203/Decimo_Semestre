function z0=z0(w,h,ereff)
if(w/h >= 1)
    z0=120*pi/(sqrt(ereff)*(w/h+1.393+0.667*log(w/h+1.44)));
elseif(w/h <= 1)
    z0=60/sqrt(ereff)*log(8*h/w+w/(4*h));
end