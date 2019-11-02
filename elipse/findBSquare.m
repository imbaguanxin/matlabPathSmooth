function result = findBSquare(x,y,a,sin,cos)
up = (x * sin + y * cos)^2;
downup = (x * cos - y * sin)^2;
result = abs(up / (1 - (downup / a^2)));
end

