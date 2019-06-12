

function u = oneMassController_JacobianInverse(Q_TwoMass, Q_OneMass)

[x_m, ~, ~] = twoMassKinematics(Q_TwoMass);
[x_s, J_s, ~] = oneMassKinematics(Q_OneMass);
e = x_m - x_s; 
k = 1e6; % tele-operation gain
u = k*norm(J_s)^2*J_s^-1*e; % Jacobian Inverse Controller

end