

function u = oneMassController_JacobianTranspose(Q_TwoMass, Q_OneMass)

[x_TwoMass, ~, ~] = twoLinkKinematics(Q_TwoMass);
[x_OneMass, J_OneMass, ~] = oneLinkKinematics(Q_OneMass);
e = x_TwoMass - x_OneMass; 
k = 500; % need to tune
u = k*J_OneMass'*e; % Jacobian Transpose Controller

end