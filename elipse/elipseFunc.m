function result = elipseFunc(cx,cy,a,b,cos,sin)
%ELIPSEFUNC return a string of a elipse function using given parameters
result = sprintf('((x - %d) * %d - (y - %d) * %d)^2 / %d^2 + ((x - %d) * %d + (y - %d) * %d)^2 / %d^2 - 1', cx,cos,cy,sin,a,cx,sin,cy,cos,b);
end

