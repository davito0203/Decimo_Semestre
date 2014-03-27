function [CP]= diegoAprende ()

load valiData.txt
frec = valiData(:,1);
ImOC = valiData(:,3);
ReSC = valiData(:,4);
ImSC = valiData(:,5);

CP=[1, zeros(1,200)];

for k = 1:200
    CP(k)=eval(solve('ReOC(k) + i*ImOC(k)=(tanh(x*68e-3)-1)/(tanh(x*68e-3)+1)'));
end
    
%CP(k)=eval(CP1(k));    

%  CP(i)=solve('ReOC(k) + i*ImOC(k)=(tanh(x*68e-3)-1)/(tanh(x*68e-3)+1)')
% solve('1+2*i=(tanh(x*68e-3)-1)/(tanh(x*68e-3)+1)')
% % 

% 
% solve('ReOC(1) + i*ImOC(1)=(tanh(x*68e-3)-1)/(tanh(x*68e-3)+1)')
%  
% ans =
%  
% (-7.3529411764705882352941176470588)*log(- 1.0*ReOC(1) - 1.0*i*ImOC(1))
%  
% eval(solve('ReOC(1) + i*ImOC(1)=(tanh(x*68e-3)-1)/(tanh(x*68e-3)+1)'))