function [modified,b] = splitConstrain(constraint,center)
%SPLITCONSTRAIN Summary of this function goes here
%   Detailed explanation goes here
ctr = [center(1);center(2);1];
res = constraint * ctr <= 0;
% [r,~] = size(constraint);
% modified = zeros(r,2);
% b = zeros(r,1);
% for i = 1 : r
%     if (res(i))
%         modified(i,1) = constraint(i,1);
%         modified(i,2) = constraint(i,2);
%         b(i) = -constraint(i,3);
%     else
%         modified(i,1) = -constraint(i,1);
%         modified(i,2) = -constraint(i,2);
%         b(i) = constraint(i,3);
%     end
% end

% disp(res);
temp = res - 1;
% disp(temp);
res = res + temp;
% disp(res);
res = [res, res, res];
modified = constraint .* res;
b = modified(:,3) * -1;
modified = modified(:,1:2);
end

