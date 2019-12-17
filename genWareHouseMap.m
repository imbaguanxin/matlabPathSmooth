function map = genWareHouseMap()
%GENWAREHOUSEMAP 此处显示有关此函数的摘要
%   此处显示详细说明
sizeRow = 1000;
sizeCol = 2000;
mapStatus = zeros(sizeRow, sizeCol);
mapStatus(1,:) = 1;
mapStatus(:,1) = 1;
% mapStatus(600,:) = 1;
% mapStatus(:,600) = 1;
mapStatus(1000,:) = 1;
mapStatus(:,2000) = 1;
% mapStatus(400:500, 100:200) = 1;
% mapStatus(450:550, 350:450) = 1;
% mapStatus(200:300, 200:300) = 1;
% mapStatus(50:150, 50:150) = 1;
% mapStatus(100:320, 500:600) = 1;
% mapStatus(100:200, 100:200) = 1;
% mapStatus(250:350, 250:350) = 1;
% mapStatus(400:500, 400:500) = 1;
% mapStatus(400:500, 100:200) = 1;
% mapStatus(250:350, 100:200) = 1;
% mapStatus(400:500, 250:350) = 1;
mapStatus(50:100, 50:350) = 1;
mapStatus(150:200, 50:350) = 1;
mapStatus(250:300, 50:350) = 1;
mapStatus(350:450, 50:350) = 1;
mapStatus(500:600, 50:350) = 1;
mapStatus(650:950, 50:100) = 1;
mapStatus(650:950, 150:250) = 1;
mapStatus(650:950, 300:350) = 1;
mapStatus(50:350, 450:550) = 1;
mapStatus(50:150, 550:750) = 1;
mapStatus(200:250, 600:750) = 1;
mapStatus(300:350, 600:750) = 1;
mapStatus(400:650, 450:600) = 1;
mapStatus(700:950, 450:600) = 1;
mapStatus(400:500, 650:750) = 1;
mapStatus(550:650, 650:750) = 1;
mapStatus(700:800, 650:750) = 1;
mapStatus(850:950, 650:750) = 1;
mapStatus(50:150, 850:1150) = 1;
mapStatus(150:350, 1050:1150) = 1;
for pixelRow = 200:250
    for pixelCol = 850:900
        if distance([pixelRow, pixelCol], [225,875]) <= 25
            mapStatus(pixelRow, pixelCol) = 1;
        end
    end
end
for pixelRow = 200:250
    for pixelCol = 900:950
        if distance([pixelRow, pixelCol], [225,925]) <= 25
            mapStatus(pixelRow, pixelCol) = 1;
        end
    end
end
for pixelRow = 200:250
    for pixelCol = 950:1000
        if distance([pixelRow, pixelCol], [225,975]) <= 25
            mapStatus(pixelRow, pixelCol) = 1;
        end
    end
end
for pixelRow = 300:350
    for pixelCol = 850:900
        if distance([pixelRow, pixelCol], [325,875]) <= 25
            mapStatus(pixelRow, pixelCol) = 1;
        end
    end
end
for pixelRow = 300:350
    for pixelCol = 900:950
        if distance([pixelRow, pixelCol], [325,925]) <= 25
            mapStatus(pixelRow, pixelCol) = 1;
        end
    end
end
for pixelRow = 300:350
    for pixelCol = 950:1000
        if distance([pixelRow, pixelCol], [325,975]) <= 25
            mapStatus(pixelRow, pixelCol) = 1;
        end
    end
end
mapStatus(400:950, 1050:1150) = 1;
mapStatus(750:950, 1000:1050) = 1;
for pixelRow = 400:550
    for pixelCol = 850:1000
        if distance([pixelRow, pixelCol], [475,925]) <= 75
            mapStatus(pixelRow, pixelCol) = 1;
        end
    end
end
for pixelRow = 600:750
    for pixelCol = 850:1000
        if distance([pixelRow, pixelCol], [675,925]) <= 75
            mapStatus(pixelRow, pixelCol) = 1;
        end
    end
end
mapStatus(800:950, 850:950) = 1;
mapStatus(50:100, 1250:1950) = 1;
mapStatus(150:200, 1250:1950) = 1;
mapStatus(250:300, 1250:1950) = 1;
mapStatus(350:500, 1250:1950) = 1;
mapStatus(550:700, 1250:1950) = 1;
mapStatus(750:950, 1250:1300) = 1;
mapStatus(800:900, 1300:1400) = 1;
mapStatus(750:950, 1400:1450) = 1;
mapStatus(750:950, 1500:1550) = 1;
mapStatus(800:900, 1550:1650) = 1;
mapStatus(750:950, 1650:1700) = 1;
mapStatus(750:950, 1750:1800) = 1;
mapStatus(800:900, 1800:1900) = 1;
mapStatus(750:950, 1900:1950) = 1;
map = map2d(sizeRow,sizeCol);
map.cellStatus = mapStatus;
end

