function result = isInRange(start,dest,check)
radius = distance(start,dest)/2;
center = (start + dest) / 2;
result = distance(check, center) <= radius;
end

