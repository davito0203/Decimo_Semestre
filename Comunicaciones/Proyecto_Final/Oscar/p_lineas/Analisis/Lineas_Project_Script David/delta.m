function [deltal,deltaw]=delta(ereff,w,h,t)

deltal=0.412*(ereff+0.3)/(ereff-0.258)*(w/h+0.264)/(w/h+0.8)*h;

deltaw=1/pi*log(4*exp(1)/sqrt((t/h)^2+((1/pi)/(w/t+1.1))^2))*t;