

function u = oneLinkController_JacobianTranspose(Q_TwoLink, Q_OneLink)

[x_TwoLink, ~, ~] = twoLinkKinematics(Q_TwoLink);
[x_OneLink, J_OneLink, ~] = oneLinkKinematics(Q_OneLink);
e = x_TwoLink - x_OneLink; 
k = 500; % need to tune
u = k*J_OneLink'*e; % Jacobian Transpose Controller

end