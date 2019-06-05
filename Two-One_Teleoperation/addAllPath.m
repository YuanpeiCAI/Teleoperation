

function [] = addAllPath()

LinkModelPath = genpath('./LinkModel');
plotFunctionPath = genpath('./plotFunction');

addpath(LinkModelPath);
addpath(plotFunctionPath);
addpath('./dataSaving');
addpath('./testFunction');

end