% 

function u = twoMassController_Haptics(Q_TwoMass, Q_OneMass)

[x_m, J_m, ~] = twoMassKinematics(Q_TwoMass);
[x_s, ~, ~] = oneMassKinematics(Q_OneMass);
k_Haptics = 1e4;
F_Haptics = k_Haptics*(x_s - x_m); 
u = J_m'*F_Haptics; % may have multiple choice, as it's redundant

end