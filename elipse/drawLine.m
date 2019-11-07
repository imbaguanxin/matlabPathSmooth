function result = drawLine(a,b,c)
%DRAWLINE Summary of this function goes here
%   Detailed explanation goes here
min_x = 0;
max_x = 800;    
min_y = 0;
max_y = 800;
if (a == 0)
    x = [min_x  max_x];
    y = -c/b * ones(size(x));  
    plot(x,y,'linewidth',1);
elseif ( b == 0)
    y = [min_y  max_y];
    x = -c/a * ones(size(y));
    plot(x,y,'linewidth',1);
else
    x = [min_x  max_x];
    y = -c/b + -a/b * x;
    plot(x,y,'linewidth',1);
end
result = 0;
end
