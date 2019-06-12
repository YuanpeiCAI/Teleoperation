
clear; clc; close all;
addAllPath();

% System parameter
tspan = [0 10];

% Robot configuration
X0 = deg2rad([90; 0; 0; 0]); % Initial configuration
u = zeros(2, 1); % N*m
F = 0; % N 

% System dynamics
twoLinkDynamics_Handler = @(t,Q) twoLinkDynamics(t, Q, F, u);
[t_his,Q_his] = ode45(twoLinkDynamics_Handler, tspan, X0);
t_his = t_his';
Q_his = Q_his';


% Data Saving
E_his_TwoLink = dataSaving_TwoLink(t_his,Q_his);


animateTwoLink(t_his, Q_his);
figure; plot(t_his, E_his_TwoLink);




