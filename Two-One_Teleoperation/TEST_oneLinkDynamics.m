clear; clc; close all;
addAllPath();

% System parameter
tspan = [0 10];

% Robot configuration
X0 = deg2rad([90; 0]); % Initial configuration
F = 0; % N
u = 0; % N*m

% System dynamics
oneLinkDynamics_Handler = @(t,Q) oneLinkDynamics(t, Q, F, u);
[t_his,Q_his] = ode45(oneLinkDynamics_Handler, tspan, X0);
t_his = t_his';
Q_his = Q_his';


% Data Saving
E_his_OneLink = dataSaving_OneLink(t_his,Q_his);


% Figures and animation
animateOneLink(t_his, Q_his);
figure; plot(t_his, E_his_OneLink);
