
clear; clc; close all;
addAllPath();

% System parameter
tspan = [0 10];

% Robot configuration
Q0 = [0.05; 0.05; 0; 0]; % Initial configuration
u = zeros(2, 1); % N haptics
F = 0; % N human operator

% System dynamics
twoMassDynamics_Handler = @(t,Q) twoMassDynamics(t, Q, F, u);
[t_his,Q_his] = ode45(twoMassDynamics_Handler, tspan, Q0);
t_his = t_his';
Q_his = Q_his';



animateTwoMass(t_his, Q_his);
figure; plot(t_his, Q_his(1, :));hold on; plot(t_his, Q_his(2, :));



