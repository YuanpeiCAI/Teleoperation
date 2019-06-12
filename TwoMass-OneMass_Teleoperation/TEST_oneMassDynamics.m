
clear; clc; close all;
addAllPath();

% System parameter
tspan = [0 10];

% Robot configuration
Q0 = [0.05; 0]; % Initial configuration
u = 0; % N Wall
F = 0; % N Controller

% System dynamics
oneMassDynamics_Handler = @(t,Q) oneMassDynamics(t, Q, F, u);
[t_his,Q_his] = ode45(oneMassDynamics_Handler, tspan, Q0);
t_his = t_his';
Q_his = Q_his';



animateOneMass(t_his, Q_his);
figure; plot(t_his, Q_his(1, :));



