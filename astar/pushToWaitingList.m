function wl = pushToWaitingList(waitingList,element)
%PUSHTOWAITINGLIST Summary of this function goes here
%   Detailed explanation goes here
wl = cell(1, length(waitingList) + 1);
wl{1} = element;
for i = 2 : length(wl)
    wl{i} = waitingList{i - 1};
end
end

