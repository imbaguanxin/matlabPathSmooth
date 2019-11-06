function [xl,xh,yl,yh] = findSearchRangeDynamic(start,dest,radius,xbound,ybound)
%FINDSEARCHRANGEDYNAMIC find search box given dynamic constrains
%   according to dynamic constrain : radis < v^2/(2*a^2), where v is the
%   max speed of a UAV and a is the max acceleration of a UAV. Within this
%   capsule like area, we need to detect barriers. Here to find a
%   rectangle area that includes the capsule for quick iteration.
xl = floor(max(1, min(start(1),dest(1)) - radius));
xh = ceil(min(xbound, (max(start(1),dest(1)) + radius)));
yl = floor(max(1, min(start(2),dest(2)) - radius));
yh = ceil(min(ybound, (max(start(2),dest(2)) + radius)));
end

