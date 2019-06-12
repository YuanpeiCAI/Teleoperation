
syms m1 m2 L1 L2 g;
syms theta1 theta2;
t1 = theta1;
t2 = theta2;

% Kinematics
x = L1*sin(t1)+L2*sin(t1+t2);
J(1, 1) = diff(x, t1);
J(1, 2) = diff(x, t2);

% Geometry
L3_square = L1^2 + L2^2 - 2*L1*L2*cos(t2);

% Dynamics
K = 1/2*m1*(L1*)