function [CtProp]= KttProp()

load valiData.txt
frec = valiData(:,1);
ReOC = valiData(:,2);
ImOC = valiData(:,3);
ReSC = valiData(:,4);
ImSC = valiData(:,5);

%CP=[1, zeros(1,200)];

for k = 1:200;
    CtProp(k)=eval(solve('ReOC(k) + i*ImOC(k)=(tanh(x*68e-3)-1)/(tanh(x*68e-3)+1)'));
    %CP(k)=eval(q);
end
    