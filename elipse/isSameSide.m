function result = isSameSide(matrix,check,origin)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
oriRes = matrix * transpose([origin(1), origin(2), 1]);
disp(oriRes)
checkRes = matrix * transpose([check(1), check(2), 1]);
disp(checkRes)
result = true;
for i = 1:length(oriRes)
    result = result && ~(xor(oriRes(i) > 0, checkRes(i) > 0));
end
end

