function [result, clearIndex] = waitingListMin(waitinglist)
%WAITINGLISTMIN find the min score of cells in waitinglist
%   waitinglist: cell
%   find the smallest score.
if(~isempty(waitinglist))
    result = waitinglist{1};
    min = result(3);
    clearIndex = 1;
    for i = 1:length(waitinglist)
        temp = waitinglist{i};
        if min > temp(3)
            result = temp;
            min = temp(3);
            clearIndex = i;
        end
    end
end

end

