
function F = twoLinkController_HumanImpedance(Q, x_dsr)

[x_TwoLink, ~, ~] = twoLinkKinematics(Q);
e = x_dsr - x_TwoLink; 
k = 500; % need to tune
F = k*e; % Assume human is a spring

end