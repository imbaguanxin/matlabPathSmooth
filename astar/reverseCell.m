function result = reverseCell(cList)
%REVERSECELL Summary of this function goes here
%   Detailed explanation goes here
result = cell(0);
for i = 1:length(cList)
    result{length(cList) - i + 1} = cList{i};
end
end

