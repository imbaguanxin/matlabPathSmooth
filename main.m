% mac file location
img = imread('/Users/guanxin/Desktop/cloned/matlabPathSmooth/data/garageMap.jpg');
img = rgb2gray(img);
[sizeRow, sizeCol] = size(img);
mapStatus = zeros(sizeRow,sizeCol);
for i = 1 : sizeRow
    for j = 1 : sizeCol
        temp = img(i,j);
        if ( i == 1 || j == 1 || temp < 128)
            mapStatus(i,j) = 1;
        end
    end
end
map = map2d(sizeRow,sizeCol);
map.cellStatus = mapStatus;

mapCor = map2d2mapXYcor(map);

imgMat = map.showMapMatrixImg();
imgCor = mapCor.showMapImg();

% imshow(imgMat);
imshow(imgCor);