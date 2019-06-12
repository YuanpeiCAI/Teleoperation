

function [x, J, X_config] = twoMassKinematics(Q)

% State variable
x1 = Q(1, 1);
x2 = Q(2, 1);

% Forward kinematics
x = x1 + x2; % Position
J = [1 1]; % Jacobian

% Configuration position (only for drawing): X_config = [x1, x1+ x2 ]
X_config(1, 1) = x1; % x1 
X_config(1, 2) = x1 + x2; % x1+ x2 

end