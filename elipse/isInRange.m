function result = isInRange(start,dest,check)
% ISINRANGE check whether the given point is in search range
% since the elipse's b is smaller than a, so the point that determins the
% smallest b should be in a circle range.
radius = distance(start,dest)/2;
center = (start + dest) / 2;
result = distance(check, center) <= radius;
end

