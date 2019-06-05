
clear; clc; close all;
addAllPath();

% System parameter
tspan = [0 10];

% Robot configuration
X0 = deg2rad([0; 0; 0; 0; 0; 0]); % Initial configuration
F = zeros(2, 1); % N
u = zeros(3, 1); % N*m

% System dynamics
systemDynamics_Handler = @(t,Q) systemDynamics(t,Q,F,u);
[t_his,Q_his] = ode45(systemDynamics_Handler, tspan, X0);
t_his = t_his';
Q_his = Q_his';
Q_his_OneLink = [Q_his(3, :); Q_his(6, :)];
Q_his_TwoLink = [Q_his(1:2, :); Q_his(4:5, :)];

% Data Saving
SystemData = dataSaving_System(t_his, Q_his, F, u);


animateSystem(t_his, Q_his, SystemData);
figure; plot(t_his, SystemData.e_his);




