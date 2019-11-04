function result = elipseFunc(cx,cy,a,b,cos,sin)
%ELIPSEFUNC 此处显示有关此函数的摘要
%   此处显示详细说明
result = sprintf('((x - %d) * %d - (y - %d) * %d)^2 / %d^2 + ((x - %d) * %d + (y - %d) * %d)^2 / %d^2 - 1', cx,cos,cy,sin,a,cx,sin,cy,cos,b);
end

