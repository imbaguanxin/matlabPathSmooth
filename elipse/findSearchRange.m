function [xlow,xhigh,ylow,yhigh] = findSearchRange(p1,p2,xbound,ybound)
% FINDSEARCHRANGE during the elipse finding, find a box that fits in the
% elipse.
dis = distance(p1,p2)/2;
cx = (p1(1) + p2(1))/2;
cy = (p1(2) + p2(2))/2;
xlow = max(1,floor(cx - dis));
xhigh = min(xbound, ceil(cx + dis));
ylow = max(1,floor(cy - dis));
yhigh = min(ybound, ceil(cy + dis));
end

