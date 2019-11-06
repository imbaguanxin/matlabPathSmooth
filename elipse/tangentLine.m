function [a,b,c] = tangentLine(aSquare,bSquare,cos,sin,givenPoint,center)
%TANGENTLINE find tangent line of a elipse given a point on the elipse
% fprintf('aSquare: ');
% disp(aSquare);
turning = [cos,-sin;sin,cos];
% fprintf('turning: ');
% disp(turning);
pt = givenPoint - center;
% fprintf('pt before rotate: ');
% disp(pt);
pt = turning * transpose(pt);
% fprintf('pt after rotate: ');
% disp(pt);
atemp = pt(1) / aSquare;
btemp = pt(2) / bSquare;
% fprintf('atemp: ');
% disp(atemp);
% fprintf('btemp: ');
% disp(btemp);
if (atemp == 0)
    pt1 = [0,1/btemp];
    pt2 = [1,1/btemp];
elseif (btemp == 0)
    pt1 = [1/atemp, 0];
    pt2 = [1/atemp, 1];
else
    pt1 = [0, 1 / btemp];
    pt2 = [1 / atemp, 0];
end
% fprintf('before invert\npt1: \n');
% disp(pt1);
% fprintf('pt2: \n');
% disp(pt2);
turning = [cos, sin; -sin, cos];
% fprintf('turning: ');
% disp(turning);
pt1 = turning * transpose(pt1);
pt2 = turning * transpose(pt2);
% fprintf('after invert\npt1: \n');
% disp(pt1);
% fprintf('pt2: \n');
% disp(pt2);

% point1 and point2 determinates the slop of the line, givenPoint
% determines the distance of translation.
[a,b,c] = getLineFromPts(pt1, pt2, givenPoint);
end

