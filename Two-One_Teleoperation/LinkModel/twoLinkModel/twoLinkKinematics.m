

function [x, J, X_config] = twoLinkKinematics(Q)

% Model parameter
TwoLink = twoLinkParameter();
L1 = TwoLink.L1;
L2 = TwoLink.L2;

% State variable
q1 = Q(1, 1);
q2 = Q(2, 1);

x = L1*sin(q1) + L2*sin(q1+q2);
J = [L1*cos(q1)+L2*cos(q1+q2) L2*cos(q1+q2)];

% Configuration position (only for drawing): X_config = [x1 x2; y1 y2]
X_config(1, 1) = L1*sin(q1); % x1 
X_config(2, 1) = -L1*cos(q1); % y1 
X_config(1, 2) = x; % x2 
X_config(2, 2) = -L1*cos(q1) - L2*cos(q1+q2); % y2 

end