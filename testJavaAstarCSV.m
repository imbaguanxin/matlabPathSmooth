clc;
clear all;
close all;
%%
% fn = 'wareHouseMap.csv';
% 
% map = genWareHouseMap();
% 
% img = map.showMapMatrixImg();
% imshow(img);
% 
% Map2dToCsv(map, fn);
%%
filename = 'testGenCSVwarehouse.csv';

csv = csvread(filename,1);

[row, col] = size(csv);

map = map2d(row, col);

map.cellStatus = csv;

img = map.showMapMatrixImg();
figure;
imshow(img);