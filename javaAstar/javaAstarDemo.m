clc;
clear all;
close all;
%% Generate map info for java
% Filename of the map csv
filename = 'wareHouseMap.csv';
% Generate map (you can generate map as you like
% as long as it is a map2d object.
map = genWareHouseMap();
% Showing the map
img = map.showMapMatrixImg();
imshow(img);

% out put the map
Map2dToCsv(map, filename);

% Then you need to swtich to java to generate the path
%% Read the path from java generated searche map.
filename = 'searchedMap.csv';
% read the csv file
csv = csvread(filename,1);

% generate the map.
[row, col] = size(csv);
map = map2d(row, col);
map.cellStatus = csv;

% Find the path
path = genPathFromJava("searchedPath.csv");

% show the map
img = map.showMapMatrixImg();
figure;
imshow(img);