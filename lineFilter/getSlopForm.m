function [k,t] = getSlopForm(a,b,c)
%GETSLOPFORM find the slop form of a line from normal form
%   returns k: the slop(in radius), t: intercept on Y
if (b == 0)
    k = pi/2;
    t = Inf;
else
    k = atan(-a/b);
    t = -c/b;
end
end