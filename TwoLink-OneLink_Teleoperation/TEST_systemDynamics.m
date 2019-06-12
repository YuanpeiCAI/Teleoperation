
clear; clc; close all;
addAllPath();

% System parameter
tspan = [0 10];
x_wall = 0.02;
x_dsr = 0.05; % 0.2*deg2rad(30)*sin(1*pi*t); % 
global t_pre ei; t_pre = 0; ei = 0;

% Robot configuration
X0 = deg2rad([0; 0; 0; 0; 0; 0]); % Initial configuration
u = zeros(3, 1); % N*m

% System dynamics
systemDynamics_Handler = @(t,Q) systemDynamics(t,Q,x_dsr,x_wall);
[t_his,Q_his] = ode45(systemDynamics_Handler, tspan, X0);
t_his = t_his';
Q_his = Q_his';
Q_his_OneLink = [Q_his(3, :); Q_his(6, :)];
Q_his_TwoLink = [Q_his(1:2, :); Q_his(4:5, :)];

% Data Saving
SystemData = dataSaving_System(t_his, Q_his, x_dsr, x_wall);


animateSystem(t_his, Q_his, x_wall, SystemData);


