function [It,time]=ifftsingleside(If,fI)
 %Make sure is a row vector
if (size(If,1)==1)
    If=If.';
end %Make sure is a row vector

dt = 1/(2*max(fI));
If=[If;conj(If(end-1:-1:2))];
It = (ifft(If)/dt);
It=real(It);
time = (0:numel(It)-1)*dt;