function [outputArg1,outputArg2] = genAfromConstraint(constraint,t,numOfPathSegregate, numOfTotalPath)
%GENAFROMCONSTRAINT Summary of this function goes here
%   Detailed explanation goes here
[row,~] = size(constraint);
allCons = []
for i = 1 : row
    tempCons = constraint(row,:);
    a = tempCons(1);
    b = tempCons(2);
    consLine = [a*cos(t) a*sin(t) a b*cos(t) b*cos(t) b*sin(t) b];
    allCons = [allCons ; consLine];
end


end

