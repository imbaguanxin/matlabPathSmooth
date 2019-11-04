function result = findSearchConstrain(pt1,pt2,radius)
%FINDSEARCHCONSTRAIN 此处显示有关此函数的摘要
%   此处显示详细说明
dir = pt1 - pt2;
turning = [0, -1; 1, 0];
dir90 = transpose(turning * transpose(dir) / distance(pt1, pt2) * radius);
dirRadius = dir / distance(pt1,pt2) * radius;
pt190 = pt1 + dir90 + dirRadius;
% disp(pt190);
pt1m90 = pt1 - dir90 + dirRadius;
% disp(pt1m90);
pt290 = pt2 + dir90 - dirRadius;
% disp(pt290);
pt2m90 = pt2 - dir90 - dirRadius;
% disp(pt2m90);
[line1a, line1b, line1c] = getLineFromPts(pt190, pt1m90, pt190);
[line2a, line2b, line2c] = getLineFromPts(pt290, pt2m90, pt290);
[line3a, line3b, line3c] = getLineFromPts(pt190, pt290, pt190);
[line4a, line4b, line4c] = getLineFromPts(pt1m90, pt2m90, pt1m90);
result = [line1a, line1b, line1c;
          line2a, line2b, line2c;
          line3a, line3b, line3c;
          line4a, line4b, line4c];
end

