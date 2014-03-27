function ereff=ereff(w,h,er)

if(w/h >= 1)
    ereff=(er+1)/2+(er-1)/(2*sqrt(1+12*h/w));
elseif (w/h <= 1)
    ereff=(er+1)/2+(er-1)/2*(1/sqrt(1+12*h/w)+0.04*(1-w/h)^2);
end