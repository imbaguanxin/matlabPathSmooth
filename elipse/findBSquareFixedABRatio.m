function result = findBSquareFixedABRatio(x,y,aDivB,cos,sin,cx,cy)
% FINDBSQUAREFIXEDABRATIO find the Bsquare of a ellipse with a/b ratio
% fixxed. (x,y) is some point on ellipse, aDivB = a/b
result = ((x-cx) * cos - (y-cy) * sin)^2 / aDivB^2 + ((x-cx) * sin + (y-cy) * cos)^2;
end

