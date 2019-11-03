function result = findBSquareFixedABRatio(x,y,aDivB,sin,cos)
% FINDBSQUAREFIXEDABRATIO find the Bsquare of a elipse with a/b ratio
% fixxed. (x,y) is some point on elipse, aDivB = a/b
result = (x * sin - y * cos)^2 / aDivB^2 + (x * sin + y * cos)^2;
end

