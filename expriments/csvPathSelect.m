function log = csvPathSelect(filename)
%CSVPATHSELECT Summary of this function goes here
%   Detailed explanation goes here
csv = csvread(filename,1);
[row,~] = size(csv);
currDir = csv(2,:) - csv(1,:);
log = {};
log{1} = csv(1,:);
for i = 2: row
    dir = csv(i,:) - csv(i-1,:);
    boovec = currDir ~= dir;
    if (boovec(1) + boovec(2) ~= 0)
        log{length(log) + 1} = csv(i-1,:);
        currDir = dir;
    end
end
log{length(log) + 1} = csv(row,:);
i = 1;
while(i < length(log) - 1)
    dis = distance(log{i}, log{i+1});
    if (dis < 20)
        log(i) = [];
        i = i - 1;
    end
    i = i+1;
end
end

