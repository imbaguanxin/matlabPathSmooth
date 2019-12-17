% build map
sizeRow = 600;
sizeCol = 600;
mapStatus = zeros(sizeRow, sizeCol);
mapStatus(1,:) = 1;
mapStatus(:,1) = 1;
mapStatus(600,:) = 1;
mapStatus(:,600) = 1;
% map 1 no balloon
% mapStatus(400:500, 100:200) = 1;
% mapStatus(450:550, 350:450) = 1;
% mapStatus(200:300, 200:300) = 1;
% mapStatus(50:150, 50:150) = 1;
% mapStatus(100:320, 500:600) = 1;
% map 2 balloon
mapStatus(380:520, 80:220) = 1;
mapStatus(430:570, 330:470) = 1;
mapStatus(180:320, 180:320) = 1;
mapStatus(30:170, 30:170) = 1;
mapStatus(80:340, 480:620) = 1;

map = map2d(sizeRow,sizeCol);
map.cellStatus = mapStatus;


% manually alloacate the startpoint and endpoint
startPoint = [20,20];
endPoint = [570,570];
% endPoint = [780,300];
% endPoint = [200,100];

% f+g : diagonal / cartesian
scoreFlag = 'diagnoal';

% initialize the waiting list
waitingList = cell(0);
[score, h] = findScore(startPoint, startPoint, endPoint, 0, scoreFlag);
waitingList{1} = [startPoint, distance(startPoint, endPoint), h] ;
map.parent{startPoint(1),startPoint(2)} = [startPoint(1),startPoint(2)];
% write down the possible direction lists (up down right left)
directionList = {[0,1],[0,-1],[1,0],[-1,0],[1,1],[-1,1],[-1,-1],[1,-1]};

loopCount = 0;

% main loop of A*
if (~map.isBlank(endPoint(1), endPoint(2)) || ~map.isBlank(startPoint(1),startPoint(2)))
    fprintf("Not reachable, please reset the destination\n");
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
            fatherH = candidate(4);
            nextPoint = candi + directionList{i};
            % Check whether the nextpoint is blank in the map 
            % (not blocked,not searched)
            if (map.isBlank(nextPoint(1), nextPoint(2)))
                % if blank, add the nextPoint and its cost to waitinglist
                [score, h] = findScore(candidate, nextPoint, endPoint, fatherH, scoreFlag);
                waitingList{length(waitingList)+1} = [nextPoint(1), nextPoint(2), score, h];
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
        % path
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
    
    path_mat = [];
    for i = 1 : length(path)
        wayPoint = path{i};
        path_mat(i, 1) = wayPoint(1);
        path_mat(i, 2) = wayPoint(2);
    end
end

imgResult = showMapImg(map);
imshow(imgResult);    

% format long g; % no scientific notation
fid = fopen('astar_result_map_b.csv', 'w');
legend = {'x', 'y'};
fprintf(fid, '%s,%s\n', legend{:});
[row,col] = size(path_mat);
for j = 1: row
    fprintf(fid, '%3.3f,%3.3f\n', path_mat(j, :));
end


