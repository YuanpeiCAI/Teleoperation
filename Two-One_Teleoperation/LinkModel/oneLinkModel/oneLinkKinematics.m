

function [x, J, X_config] = oneLinkKinematics(Q)

% Model parameter
oneLink = oneLinkParameter();
L = oneLink.L;

q = Q(1, 1); % State variable

x = L*sin(q);
J = L*cos(q);

% Configuration position (only for drawing)
X_config(1, 1) = x; % x
X_config(2, 1) = -L*cos(q); % y

end