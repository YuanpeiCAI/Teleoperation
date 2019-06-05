

function u = oneLinkController_JacobianInverse(Q_TwoLink, Q_OneLink)

[x_TwoLink, ~, ~] = twoLinkKinematics(Q_TwoLink);
[x_OneLink, J_OneLink, ~] = oneLinkKinematics(Q_OneLink);
e = x_TwoLink - x_OneLink; 
k = 500; % need to tune
u = k*norm(J_OneLink)^2*J_OneLink^-1*e; % Jacobian Inverse Controller

end