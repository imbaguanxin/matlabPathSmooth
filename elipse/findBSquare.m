function result = findBSquare(x,y,a,cos,sin)
%FINDBSQUARE calculate bSquare of a ellipse(center at 0,0)
up = (x * sin + y * cos)^2;
downup = (x * cos - y * sin)^2;
result = abs(up / (1 - (downup / a^2)));
end

