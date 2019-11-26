function result = constraintsSelector(constraints)
%CONSTRAINTSSELECTOR Filter the constraints to delete the similar ones
result = cell(length(constraints), 1);
for i = 1 : length(constraints)
    tempCons = constraints{i};
    tempConsResult =  constraints{i}(1:4,:);
    for j = 4 : length(tempCons)
%         disp(j);
        if (j > 4)
            if (~similarCons(tempCons(j-2:j,:)))
%                 fprintf("here");
                [row,~] = size(tempConsResult);
                tempConsResult(row+1,:) = tempCons(j,:);
            end
        end
    end
    result{i} = tempConsResult;
end
end