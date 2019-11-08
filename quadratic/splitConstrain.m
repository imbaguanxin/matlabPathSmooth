function [modified,b] = splitConstrain(constrain,center)
%SPLITCONSTRAIN Summary of this function goes here
%   Detailed explanation goes here
ctr = [center(1);center(2);1];
res = constrain * ctr < 0;
% disp(res);
temp = res - 1;
% disp(temp);
res = res + temp;
% disp(res);
res = [res, res, res];
modified = constrain .* res;
b = modified(:,3) * -1;
modified = modified(:,1:2);
end

