function result = genHess(inputT)
%GENHESS Summary of this function goes here
%   Detailed explanation goes here
result = [];

for i = 1:length(inputT)

    t = inputT(i);
    tempT = [1/4*sin(2*t) + 1/2*t  1/4*cos(2*t) - 1/4   0;
             1/4*cos(2*t) - 1/4    -1/4*sin(2*t)+1/2*t  0;
             0 0 0;];
    tempT = [tempT , zeros(3,3);
             zeros(3,3), tempT];
    
    rowT = [];
    for j = 1:length(inputT)
         if (i == j)
             rowT = [rowT, tempT];
         else
             rowT = [rowT, zeros(6,6)];
         end
    end
    result = [result; rowT];
end

end

