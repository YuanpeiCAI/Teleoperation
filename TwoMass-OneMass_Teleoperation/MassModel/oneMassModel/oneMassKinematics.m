

function [x, J, X_config] = oneMassKinematics(Q)

% State variable
x = Q(1, 1);

% Forward kinematics
x; % Position
J = 1;

% Configuration position (only for drawing)
X_config(1, 1) = x; % x1

end