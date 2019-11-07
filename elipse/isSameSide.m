function result = isSameSide(matrix,check,origin)
% ISSAMESIDE find whether a point is on the same side compared to a given
% origin
% Apply a point to a line will give us a number that determins which side
% the point is. matrix gives several lines and we just need to find out
% whether the checked point and origin have the same sign after applyed to
% the matrix.
oriRes = matrix * transpose([origin(1), origin(2), 1]);
% disp(oriRes)
checkRes = matrix * transpose([check(1), check(2), 1]);
% disp(checkRes)
result = true;
for i = 1:length(oriRes)
    result = result && ~(xor(oriRes(i) >= 0, checkRes(i) >= 0));
end
end

