function alfac=alfac(rs,h,w,t,z0)
if (w/h <= 1/(2*pi))
    der=1/pi*log(4*pi*w/t);
elseif (w/h >= 1/(2*pi))
    der=1/pi*log(2*h/t);
end
if (w/h <= 1)
    alfac=rs/(2*pi)*((8*h/w-w/(4*h))*(1+h/w*(der)))/(h*z0*exp(z0/60));
elseif (w/h >= 1)
    alfac=((z0*rs)/(14400*pi^2*h))*(1+(h/w)^2*(0.44+6*(1-h/w)^5))*(1+w/h+der);
end