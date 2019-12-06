img = imread('../data/garageMap.jpg');
img = rgb2gray(img);
[sizeRow, sizeCol] = size(img);
mapStatus = zeros(sizeRow,sizeCol);
for i = 1 : sizeRow
    for j = 1 : sizeCol
        temp = img(i,j);
        if (temp < 128)
            mapStatus(i,j) = 1;
        end
    end
end

% 
map = map2d(sizeRow,sizeCol);
map.cellStatus = mapStatus;
% map.cellStatus = [0,0,0,0,0,0,0,0,1,0,0,0,0,0;
%                   0,0,1,0,0,0,0,0,1,0,0,0,0,0;
%                   0,0,1,1,1,1,1,0,1,0,0,0,0,0;
%                   0,1,1,1,1,0,0,0,1,0,0,0,0,0;
%                   0,0,1,1,1,0,0,1,1,1,1,1,1,1;
%                   0,0,0,0,0,0,0,0,0,0,0,0,0,0;
%                   0,0,1,0,1,0,0,0,0,0,0,0,0,0;
%                   0,1,1,1,0,1,0,1,1,1,1,1,1,1;
%                   0,0,0,1,0,0,0,0,0,0,0,0,0,0;
%                   0,1,1,1,0,0,1,1,1,1,1,1,0,0;
%                   0,0,0,1,0,0,1,0,0,0,0,1,0,0;
%                   1,1,1,1,0,0,1,0,1,0,0,1,0,0;
%                   0,0,0,0,0,0,0,0,1,0,0,1,0,0];
% map status: 0 - blank, 1 - obstacle, 3 - searched, 4 - path


% manually alloacate the startpoint and endpoint
startPoint = [12,13];
endPoint = [675,593];

% initialize the waiting list
waitingList = cell(0);
waitingList{1} = [startPoint, distance(startPoint, endPoint)] ;
map.parent{startPoint(1),startPoint(2)} = [startPoint(1),startPoint(2)];
% write down the possible direction lists (up down right left)
directionList = {[0,1],[0,-1],[1,0],[-1,0],[1,1],[1,-1],[-1,1],[-1,-1]};

loopCount = 0;

% main loop of A*
if (~map.isBlank(endPoint(1), endPoint(2)) || ~map.isBlank(startPoint(1),startPoint(2)))
    fprintf("Not reachable, please stop the program\n");
else 
    while(~isempty(waitingList))
        loopCount = loopCount + 1;
        %Find lowest score in waitingList
        [candidate, clearIndex] = waitingListMin(waitingList);
        if (clearIndex > 0)
            waitingList(clearIndex) = [];
        end
        %populate the waitingList with 4 directions
        for i = 1 : length(directionList)
            %find next possible point
            candi = [candidate(1), candidate(2)];
            nextPoint = candi + directionList{i};
            % Check whether the nextpoint is blank in the map 
            % (not blocked,not searched)
            if (map.isBlank(nextPoint(1), nextPoint(2)))
                % if blank, add the nextPoint and its cost to waitinglist
                waitingList{length(waitingList)+1} = [nextPoint(1), nextPoint(2),findScore(candidate,nextPoint,endPoint)];
                % change parent, and status in map of the nextPoint
                map.cellStatus(nextPoint(1),nextPoint(2)) = 3;
                map.parent{nextPoint(1),nextPoint(2)} = [candidate(1),candidate(2)];
                % if the nextPoint is the destination, clear the waitinglist
                if (nextPoint(1) == endPoint(1) && nextPoint(2) == endPoint(2))
                   waitingList = cell(0);
                   break;
                end
            end
        end
        if (loopCount == 1000)
            imgResult = showMapImg(map);
            imshow(imgResult);
            loopCount=0;
        end
    end

    % initialize the path
    path = cell(0);

    % If we successfully find a path: find the path by iterativly finding the
    % parent of the endPoint.
    % end -> end.parent -> end.parent.parent -> ... -> start
    if (~isempty(map.findParent(endPoint(1),endPoint(2))))
        path{1} = endPoint;
        map.cellStatus(endPoint(1),endPoint(2)) = 4;
        parent = map.findParent(endPoint(1),endPoint(2));
        while(parent(1) ~= startPoint(1) || parent(2) ~= startPoint(2))
            map.cellStatus(parent(1),parent(2)) = 4;
            path{length(path) +1} = parent;
            parent = map.findParent(parent(1),parent(2));
        end
        map.cellStatus(startPoint(1),startPoint(2)) = 4;
    end

    % reverse the path
    path = reverseCell(path);
end

imgResult = showMapImg(map);
imshow(imgResult);

