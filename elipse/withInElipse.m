function result = withInElipse(pt,center,a,b,cos,sin)
%WITHINELIPSE Find whether a point is within a given elipse.
x = center(1) - pt(1);
y = center(2) - pt(2);
result = ((x * cos - y * sin)^2 / a^2 + (x * sin + y * cos)^2/ b^2) < 1;

end

