

function [] = addAllPath()

LinkModelPath = genpath('./LinkModel');
plotFunctionPath = genpath('./plotFunction');
controlLawPath = genpath('./controlLaw');

addpath(LinkModelPath);
addpath(plotFunctionPath);
addpath(controlLawPath);
addpath('./dataSaving');
addpath('./testFunction');

end